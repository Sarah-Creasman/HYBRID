within NHES.Systems.PrimaryHeatSystem.MSR.Examples;
package Old_NotInUseRightNow
  model MCA_Base_withBOP

    extends TRANSFORM.Icons.Example;

    import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
        Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu=kinetics.data.nC + Functions.FindIndexOfMatch(           20094239, kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
        30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
        30054137};
  public
    parameter Integer iSep[:]={kinetics.data.nC + Functions.FindIndexOfMatch(           i, kinetics.reactivity.data.SIZZZAAA)
        for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

  protected
    MSR.MoltenSaltReactor.Data.data_PHX data_PHX
      annotation (Placement(transformation(extent={{290,100},{310,120}})));
    MSR.MoltenSaltReactor.Data.data_RCTR data_RCTR
      annotation (Placement(transformation(extent={{260,100},{280,120}})));
    MSR.MoltenSaltReactor.Data.data_PUMP data_PUMP
      annotation (Placement(transformation(extent={{320,120},{340,140}})));
    MSR.MoltenSaltReactor.Data.data_SHX data_SHX
      annotation (Placement(transformation(extent={{320,102},{340,122}})));
    MSR.MoltenSaltReactor.Data.data_PIPING data_PIPING
      annotation (Placement(transformation(extent={{260,80},{280,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_RCTR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_PHX.T_outlet_tube,
      T_b_start=data_PHX.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_PHX.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_RCTR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_RCTR.crossArea_f,
          perimeter=data_RCTR.perimeter_f,
          length=data_RCTR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_RCTR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_RCTR.m_flow,
      p_a_start=data_PHX.p_inlet_tube + 50,
      T_a_start=data_PHX.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_RCTR.crossArea_reflA_ring,
          perimeter=data_RCTR.perimeter_reflA_ring,
          length=data_RCTR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_PHX.p_inlet_tube,
      T_start=data_PHX.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_RCTR.length_plenum,
          crossArea=data_RCTR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_RCTR.m_flow,
      p_a_start=data_PHX.p_inlet_tube + 150,
      T_a_start=data_PHX.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_RCTR.crossArea_reflA_ring,
          perimeter=data_RCTR.perimeter_reflA_ring,
          length=data_RCTR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_PHX.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_RCTR.length_plenum,
          crossArea=data_RCTR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_RCTR.nfG*data_RCTR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_RCTR.width_fG,
          length_y=data_RCTR.length_cells,
          length_z=data_RCTR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_PHX.T_inlet_tube + data_PHX.T_outlet_tube),
      T_b1_start=0.5*(data_PHX.T_inlet_tube + data_PHX.T_outlet_tube),
      T_b2_start=data_PHX.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_PHX.T_inlet_tube,
      T_b2_start=data_PHX.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_PHX.T_inlet_tube,
      T_b1_start=data_PHX.T_inlet_tube,
      nParallel=data_RCTR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_RCTR.rs_ring_edge_inner[6],
          r_outer=data_RCTR.rs_ring_edge_outer[6],
          length_z=data_RCTR.length_reflA,
          angle_theta=data_RCTR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_RCTR.n_reflA_ringG,
      T_a1_start=data_PHX.T_outlet_tube,
      T_b1_start=data_PHX.T_outlet_tube,
      T_a2_start=data_PHX.T_outlet_tube,
      T_b2_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_RCTR.rs_ring_edge_inner[6],
          r_outer=data_RCTR.rs_ring_edge_outer[6],
          length_z=data_RCTR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_RCTR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-28})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_PHX.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_PHX.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_RCTR.length_tee_inlet,
          crossArea=data_RCTR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_PHX.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_PHX.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_PHX.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_PIPING.length_PHXToRCTR,
          dimension=data_PIPING.D_PFL,
          dheight=toggleStaticHead*data_PIPING.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_PHX.p_inlet_shell,
      T_a_start_shell=data_PHX.T_inlet_shell,
      T_b_start_shell=data_PHX.T_outlet_shell,
      p_a_start_tube=data_PHX.p_inlet_tube,
      T_a_start_tube=data_PHX.T_inlet_tube,
      T_b_start_tube=data_PHX.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_PHX.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_PHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_PHX.D_tube_outer,
          S_T=data_PHX.pitch_tube,
          S_L=data_PHX.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_PHX.D_shell_inner,
          nTubes=data_PHX.nTubes,
          nR=3,
          length_shell=data_PHX.length_tube,
          th_wall=data_PHX.th_tube,
          dimension_tube=data_PHX.D_tube_inner,
          length_tube=data_PHX.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_PHX.p_inlet_tube + 350,
      T_a_start=data_PHX.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_PHX.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PFL,
          length=data_PIPING.length_pumpToPHX,
          dheight=toggleStaticHead*data_PIPING.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_PHX.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_PHX.p_inlet_tube,
      level_start=data_RCTR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_PHX.T_inlet_tube),
      A=3*data_RCTR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_PHX.T_inlet_tube,
      val_min=data_PHX.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_PHX.p_inlet_shell - 50,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_PHXsToPump,
          dheight=toggleStaticHead*data_PIPING.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={190,40})));
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_RCTR.level_pumpbowlnominal,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      A=3*data_RCTR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start, data_SHX.T_outlet_shell))
      annotation (Placement(transformation(extent={{210,36},{230,56}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_PHX.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{240,30},{260,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_pumpToSHX,
          dheight=toggleStaticHead*data_PIPING.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={280,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 50,
      T_a_start=data_PHX.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_SHXToPHX,
          dheight=toggleStaticHead*data_PIPING.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={230,-40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary4(
      m_flow=2*3*data_SHX.m_flow_tube,
      T=data_SHX.T_inlet_tube,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={330,-40})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=2*3,
      p_a_start_shell=data_SHX.p_inlet_shell,
      T_a_start_shell=data_SHX.T_inlet_shell,
      T_b_start_shell=data_SHX.T_outlet_shell,
      m_flow_a_start_shell=2*3*data_SHX.m_flow_shell,
      p_a_start_tube=data_SHX.p_inlet_tube,
      T_a_start_tube=data_SHX.T_inlet_tube,
      T_b_start_tube=data_SHX.T_outlet_tube,
      m_flow_a_start_tube=2*3*data_SHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_SHX.D_tube_outer,
          S_T=data_SHX.pitch_tube,
          S_L=data_SHX.pitch_tube,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_SHX.D_shell_inner,
          nTubes=data_SHX.nTubes,
          length_shell=data_SHX.length_tube,
          dimension_tube=data_SHX.D_tube_inner,
          length_tube=data_SHX.length_tube,
          th_wall=data_SHX.th_tube,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={300,0})));

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      p=data_SHX.p_outlet_tube,
      T=data_SHX.T_outlet_tube,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={330,42})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{290,120},{310,140}})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_PHX.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_PHX.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_RCTR.nRegions,
      m_flow_a_start=0.05*data_RCTR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_RCTR.crossArea_reflR,
          perimeter=data_RCTR.perimeter_reflR,
          length=data_RCTR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_PHX.T_outlet_tube + data_PHX.T_outlet_tube),
      T_a2_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_RCTR.nRegions*data_RCTR.n_reflR_blockG,
      T_b1_start=0.5*(data_PHX.T_outlet_tube + data_PHX.T_outlet_tube),
      T_b2_start=data_PHX.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_RCTR.width_reflR_blockG,
          length_y=data_RCTR.length_reflR,
          length_z=data_RCTR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_RCTR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_RCTR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_PHX.T_inlet_tube,
      T_tube_outlet_PHX=data_PHX.T_outlet_tube,
      p_inlet_tube_PHX=data_PHX.p_inlet_tube,
      m_flow_tube_PHX=data_PHX.m_flow_tube,
      T_shell_inlet_PHX=data_PHX.T_inlet_shell,
      T_shell_outlet_PHX=data_PHX.T_outlet_shell,
      p_inlet_shell_PHX=data_PHX.p_inlet_shell,
      m_flow_shell_PHX=data_PHX.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_PHX.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_RCTR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_RCTR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{260,122},{280,142}})));

    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_PHX.m_flow_tube)
      annotation (Placement(transformation(extent={{76,132},{56,152}})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_RCTR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_RCTR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

    //////////
    //    //Comment/Uncomment as a block - BIG DATA - 2b
    //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //
    //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
    //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
    //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
    //              19.43194,99.693068,185.13937};
    //
    //          constant Integer i_mCs_start_salt[:]={1009,1013};
    //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

    //Comment/Uncomment as a block - BIG DATA - 2b
    //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //     constant Integer i_mCs_start_salt[:]={1009,1013};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
    constant String actinide[:]={"u-235","u-238"};
    constant Integer nA=size(i_mCs_start_salt, 1);
    constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
    constant Real Ufrac = 0.01;
    constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
    constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
    constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

    constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
        nA};

      constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
      constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
          for i in 1:nA};

  //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
  //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
  //        for i in 1:nA};

    //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
    //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
    //       record Data_ISO =
    //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
    //
    //       constant Integer i_mCs_start_salt[:]={4};
    //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=Functions.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

  parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

  protected
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T1(y=drainTank_liquid.port_a.m_flow)
      annotation (Placement(transformation(extent={{-270,-44},{-250,-24}})));
    //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
    //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
    //
    //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
    //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

    //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
    //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

    // atoms per node

  public
    SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
    SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_upper.mCs;
    SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_lower.mCs;
    SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
       pipeFromPHX_PFL.mCs;
    SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
    SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        pipeToPHX_PFL.mCs;
    SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

    // atoms component total
    SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=
        drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
        :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
        :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
        reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

    // atoms total
    SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
        mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
        mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] + mCs_fuelCell_total[i] +
        mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
        mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
         + kinetics.reactivity.data.nC};

    // nParallel
    Real plenum_upper_nParallel=1;
    Real plenum_lower_nParallel=1;
    Real tee_inlet_nParallel=1;
    Real pumpBowl_PFL_nParallel=1;
    Real drainTank_gas_nParallel=1;
    Real drainTank_liquid_nParallel=1;
    Real fuelCell_nParallel=fuelCell.nParallel;
    Real reflA_upper_nParallel=reflA_upper.nParallel;
    Real reflA_lower_nParallel=reflA_lower.nParallel;
    Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
    Real PHX_tube_nParallel=PHX.tube.nParallel;
    Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
    Real reflR_nParallel=reflR.nParallel;

    // mass per node
    SI.Mass plenum_upper_m=plenum_upper.m;
    SI.Mass plenum_lower_m=plenum_lower.m;
    SI.Mass tee_inlet_m=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m=drainTank_liquid.m;
    SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
    SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
    SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
    SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
    SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
    SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
    SI.Mass reflR_m[reflR.nV]=reflR.ms;

    // mass component total
    SI.Mass plenum_upper_m_total=plenum_upper.m;
    SI.Mass plenum_lower_m_total=plenum_lower.m;
    SI.Mass tee_inlet_m_total=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
    SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
    SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
    SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
    SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
    SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
    SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
    SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

    // mass total
    SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
        pumpBowl_PFL_m_total + drainTank_liquid_m_total + fuelCell_m_total +
        reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
        pipeToPHX_PFL_m_total + reflR_m_total;

    // volume nodal
    SI.Volume plenum_upper_V=plenum_upper.V;
    SI.Volume plenum_lower_V=plenum_lower.V;
    SI.Volume tee_inlet_V=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
    SI.Volume drainTank_liquid_V=drainTank_liquid.V;
    SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
    SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
    SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
    SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
    SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
    SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
    SI.Volume reflR_V[reflR.nV]=reflR.Vs;

    // volume component total
    SI.Volume plenum_upper_V_total=plenum_upper.V;
    SI.Volume plenum_lower_V_total=plenum_lower.V;
    SI.Volume tee_inlet_V_total=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
    SI.Volume drainTank_gas_V_total=drainTank_gas.V;
    SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
    SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
    SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
    SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
    SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
    SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
    SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
    SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

    // volume total
    SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
        pumpBowl_PFL_V_total + drainTank_liquid_V_total + fuelCell_V_total +
        reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
        pipeToPHX_PFL_V_total + reflR_V_total;

    // nV
    Integer fuelCell_nV=fuelCell.nV;
    Integer reflA_upper_nV=reflA_upper.nV;
    Integer reflA_lower_nV=reflA_lower.nV;
    Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
    Integer PHX_tube_nV=PHX.tube.nV;
    Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
    Integer reflR_nV=reflR.nV;

    // lengths
    SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
    SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
    SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
    SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
    SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
    SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
    SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

    // dimensions
    SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
    SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
    SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
    SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
    SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
    SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
    SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_RCTR.Q_nominal,
      k_m=1/data_RCTR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_PHX.T_inlet_tube,
      k_m=1/data_PHX.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_PHX.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_OffGas_sink(
      redeclare package Medium = Medium_OffGas,
      nPorts=2,
      T=data_OFFGAS.T_carbon,
      p=data_OFFGAS.p_sep_ref,
      use_p_in=true,
      showName=systemTF.showName) annotation (Placement(transformation(extent={{-218,28},{-238,48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_OffGas_source(
      T=data_OFFGAS.T_sep_ref,
      redeclare package Medium = Medium_OffGas,
      m_flow=data_OFFGAS.m_flow_He_adsorber,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      use_C_in=false,
      showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-358,106},{-338,126}})));
    TRANSFORM.Fluid.TraceComponents.TraceDecayAdsorberBed_sparseMatrix adsorberBed(
      nV=10,
      redeclare package Medium = Medium_OffGas,
      d_adsorber=data_OFFGAS.d_carbon,
      cp_adsorber=data_OFFGAS.cp_carbon,
      tau_res=data_OFFGAS.delay_charcoalBed,
      R=data_OFFGAS.dp_carbon/data_OFFGAS.m_flow_He_adsorber,
      use_HeatPort=true,
      T_a_start=data_OFFGAS.T_carbon,
      showName=systemTF.showName,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-278,-22},{-258,-2}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_m_flow(y=data_OFFGAS.m_flow_He_adsorber)
      annotation (Placement(transformation(extent={{-398,124},{-378,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T(y=data_OFFGAS.T_sep_ref)
      annotation (Placement(transformation(extent={{-398,110},{-378,130}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary_thermal_adsorberBed(
      nPorts=adsorberBed.nV,
      T=fill(data_OFFGAS.T_carbon_wall, adsorberBed.nV),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-268,18})));
    Components.MixingVolume_forMSRs drainTank_gas(
      use_HeatPort=true,
      redeclare package Medium = Medium_OffGas,
      T_start=data_OFFGAS.T_drainTank,
      p_start=data_OFFGAS.p_drainTank,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      nPorts_a=1,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data_OFFGAS.volume_drainTank_inner - drainTank_liquid.V))
      annotation (Placement(transformation(extent={{-308,-2},{-288,-22}})));
    Components.ExpansionTank drainTank_liquid(
      redeclare package Medium = Medium_PFL,
      p_surface=drainTank_gas.medium.p,
      h_start=pumpBowl_PFL.h_start,
      p_start=drainTank_gas.p_start,
      C_start=Cs_start,
      use_HeatPort=true,
      A=data_OFFGAS.crossArea_drainTank_inner,
      level_start=0.20,
      showName=systemTF.showName,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-308,-56},{-288,-36}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fromDrainTank(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-268,-52})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_drainTank(redeclare
        package Medium =                                                                   Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-248,-62},{-228,-42}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_bypass(use_input=true, redeclare
        package Medium =
                 Medium_OffGas) annotation (Placement(transformation(extent={{-278,28},{-258,48}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_adsorberBed(use_input=true, redeclare
        package Medium = Medium_OffGas)
      annotation (Placement(transformation(extent={{-248,-22},{-228,-2}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_bypass(y=boundary_OffGas_m_flow.y -
          m_flow_OffGas_adsorberBed.y)
      annotation (Placement(transformation(extent={{-300,38},{-280,58}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_adsorberBed(y=data_OFFGAS.frac_gasSplit*
          boundary_OffGas_m_flow.y)
      annotation (Placement(transformation(extent={{-212,-2},{-232,18}})));
    TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(
      iSep=iSep,
      iCar=iSep,
      m_flow_sepFluid=m_flow_toDrainTank,
      redeclare package Medium = Medium_PFL,
      redeclare package Medium_carrier = Medium_OffGas,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-318,98})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_bypass(redeclare package
                Medium =                                                                Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-286,110},{-306,130}})));
    Modelica.Blocks.Sources.RealExpression m_flow_pump_bypass(y=x_bypass.y*abs(pump_PFL.port_a.m_flow))
      annotation (Placement(transformation(extent={{-326,124},{-306,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_fromPump_PFL_bypass_p(y=pumpBowl_PFL.p)
      annotation (Placement(transformation(extent={{-190,36},{-210,56}})));
    TRANSFORM.Examples.MoltenSaltReactor.Components.DRACS DRACS(
      redeclare package Medium_DRACS = Medium_DRACS,
      showName=systemTF.showName,
      surfaceAreas_thimble=DRACS.thimble_outer_drainTank.surfaceArea_outer*DRACS.nP_outer_drainTank[1].nParallel
          *{drainTank_liquid.level/data_OFFGAS.length_drainTank_inner,1 - drainTank_liquid.level/
          data_OFFGAS.length_drainTank_inner},
      alphas_drainTank={5000,1000})
      annotation (Placement(transformation(extent={{-402,-88},{-332,-8}})));
    Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{-4.44089e-16,
            105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{3.33067e-16,96}}, color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
    connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
      annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},{160,-140},
            {-4.44089e-16,-140},{-4.44089e-16,-136}}, color={0,127,255}));
    connect(PHX.port_b_shell, pipeFromPHX_PCL.port_a)
      annotation (Line(points={{164.6,10},{164,10},{164,40},{180,40}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b, pumpBowl_PCL.port_a)
      annotation (Line(points={{200,40},{213,40}}, color={0,127,255}));
    connect(pumpBowl_PCL.port_b, pump_PCL.port_a)
      annotation (Line(points={{227,40},{240,40}}, color={0,127,255}));
    connect(pump_PCL.port_b, pipeToSHX_PCL.port_a)
      annotation (Line(points={{260,40},{270,40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_a, SHX.port_b_shell)
      annotation (Line(points={{240,-40},{295.4,-40},{295.4,-10}}, color={0,127,255}));
    connect(pipeToSHX_PCL.port_b, SHX.port_a_shell)
      annotation (Line(points={{290,40},{295.4,40},{295.4,10}}, color={0,127,255}));
    connect(boundary1.ports[1], SHX.port_b_tube)
      annotation (Line(points={{320,42},{300,42},{300,10}}, color={0,127,255}));
    connect(SHX.port_a_tube, boundary4.ports[1])
      annotation (Line(points={{300,-10},{300,-40},{320,-40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_b, PHX.port_a_shell)
      annotation (Line(points={{220,-40},{164.6,-40},{164.6,-10}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(m_flow_pump_PFL.y, pump_PFL.in_m_flow)
      annotation (Line(points={{55,142},{50,142},{50,135.3}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(boundary_OffGas_T.y, boundary_OffGas_source.T_in)
      annotation (Line(points={{-377,120},{-360,120}}, color={0,0,127}));
    connect(boundary_OffGas_m_flow.y, boundary_OffGas_source.m_flow_in)
      annotation (Line(points={{-377,134},{-368,134},{-368,124},{-358,124}}, color={0,0,127}));
    connect(boundary_thermal_adsorberBed.port, adsorberBed.heatPorts)
      annotation (Line(points={{-268,8},{-268,-7}}, color={191,0,0}));
    connect(drainTank_liquid.port_b, resistance_fromDrainTank.port_a)
      annotation (Line(points={{-291,-52},{-275,-52}}, color={0,127,255}));
    connect(resistance_fromDrainTank.port_b, pump_drainTank.port_a)
      annotation (Line(points={{-261,-52},{-248,-52}}, color={0,127,255}));
    connect(adsorberBed.port_b, pump_OffGas_adsorberBed.port_a)
      annotation (Line(points={{-258,-12},{-248,-12}}, color={0,127,255}));
    connect(m_flow_OffGas_bypass.y, pump_OffGas_bypass.in_m_flow)
      annotation (Line(points={{-279,48},{-268,48},{-268,45.3}}, color={0,0,127}));
    connect(m_flow_OffGas_adsorberBed.y, pump_OffGas_adsorberBed.in_m_flow)
      annotation (Line(points={{-233,8},{-238,8},{-238,-4.7}}, color={0,0,127}));
    connect(boundary_OffGas_source.ports[1], traceSeparator.port_a_carrier)
      annotation (Line(points={{-338,116},{-324,116},{-324,108}}, color={0,127,255}));
    connect(m_flow_pump_bypass.y, pump_bypass.in_m_flow)
      annotation (Line(points={{-305,134},{-296,134},{-296,127.3}}, color={0,0,127}));
    connect(adsorberBed.port_a, drainTank_gas.port_b[1])
      annotation (Line(points={{-278,-12},{-286,-12},{-286,-11.75},{-292,
            -11.75}},                                                            color={0,127,255}));
    connect(pump_bypass.port_b, traceSeparator.port_a)
      annotation (Line(points={{-306,120},{-312,120},{-312,108}}, color={0,127,255}));
    connect(traceSeparator.port_sepFluid, drainTank_liquid.port_a)
      annotation (Line(points={{-318,88},{-318,-52},{-305,-52}}, color={0,127,255}));
    connect(traceSeparator.port_b_carrier, drainTank_gas.port_a[1])
      annotation (Line(points={{-324,88},{-324,-12},{-304,-12}}, color={0,127,255}));
    connect(pump_OffGas_bypass.port_a, drainTank_gas.port_b[2])
      annotation (Line(points={{-278,38},{-286,38},{-286,-12.25},{-292,-12.25}},
                                                                               color={0,127,255}));
    connect(pump_OffGas_bypass.port_b, boundary_OffGas_sink.ports[1])
      annotation (Line(points={{-258,38},{-248,38},{-248,37},{-238,37}}, color={0,127,255}));
    connect(pump_OffGas_adsorberBed.port_b, boundary_OffGas_sink.ports[2]) annotation (Line(points={{-228,
            -12},{-206,-12},{-206,24},{-246,24},{-246,39},{-238,39}}, color={0,127,255}));
    connect(boundary_fromPump_PFL_bypass_p.y, boundary_OffGas_sink.p_in)
      annotation (Line(points={{-211,46},{-216,46}}, color={0,0,127}));
    connect(traceSeparator.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-312,88},{-312,78},{-188,
            78},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_drainTank.port_b, pumpBowl_PFL.port_a)
      annotation (Line(points={{-228,-52},{-188,-52},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_bypass.port_a, pipeToPHX_PFL.port_a) annotation (Line(points={{-286,120},{-278,120},{-278,
            158},{160,158},{160,80}}, color={0,127,255}));
    connect(drainTank_liquid.heatPort, DRACS.port_thimbleWall[1])
      annotation (Line(points={{-298,-54.4},{-298,-73},{-332,-73}}, color={191,0,0}));
    connect(drainTank_gas.heatPort, DRACS.port_thimbleWall[2])
      annotation (Line(points={{-298,-6},{-298,0},{-308,0},{-308,-71},{-332,
            -71}},                                                                 color={191,0,0}));
    connect(boundary_OffGas_T1.y, pump_drainTank.in_m_flow)
      annotation (Line(points={{-249,-34},{-238,-34},{-238,-44.7}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=1825,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
  end MCA_Base_withBOP;

  model MCA_ReactivityInsertion_withBOP

    extends Old_NotInUseRightNow.MCA_Base_withBOP(
                                          kinetics(rho_input=0.003370 -
            0.00133511 + (if time < 3*30*24*60*60 then 0.0 else 0.0001)));

    //Modelica.Blocks.Sources.RealExpression realExpression(y=if time < 3*30*24*60*60 then 0.0 else 0.0001) annotation (Placement(transformation(extent={{-126,76},{-106,96}})));

    //Modelica.Blocks.Sources.RealExpression realExpression(y=if time < 3*30*24*60*60 then 0.0 else 0.0) annotation (Placement(transformation(extent={{-126,76},{-106,96}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end MCA_ReactivityInsertion_withBOP;

  model MCA_CompositionChange_withBOP

    extends Old_NotInUseRightNow.MCA_Base_withBOP(
                                          sepEfficiency(y=0.5));

  //   x_bypass(y=if time < 3*30*24*60*60 then 0.1 else 0.1 + 0.05*(time - 3*
  //           30*24*60*60)/(6*30*24*60*60 - 3*30*24*60*60)));

  //   extends MCA_Base_withBOP(simpleSeparator(eta={if i == iPu then realExpression.y else 0.0 for i in 1:(kinetics.data.nC +
  //           kinetics.reactivity.data.nC)}), x_bypass(y=if time < 3*30*24*60*60 then 0.1 else (time - 3*
  //           30*24*60*60)*0.15/(6*30*24*60*60 - 3*30*24*60*60)));

   // parameter Integer iPu= kinetics.data.nC + ORIGENDemo.Functions.FindIndexOfMatch(20092239,kinetics.reactivity.data.SIZZZAAA);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end MCA_CompositionChange_withBOP;

  model MCA_Base_withBOP_UTh

    extends TRANSFORM.Icons.Example;

    import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (
          extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total
        *Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

  protected
    package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                 extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu= kinetics.data.nC + Functions.FindIndexOfMatch(           20094239,kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:] = {10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,30036085,30036086,
                                    30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,30054137};
  public
    parameter Integer iSep[:]= {kinetics.data.nC + Functions.FindIndexOfMatch(           i,kinetics.reactivity.data.SIZZZAAA) for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    parameter Integer iRemove_ID[:] = {20092232,20092233,20092234,20092235,20092236,20092237,20092238,20092239};
    parameter Integer iRemove[:] = {kinetics.data.nC + Functions.FindIndexOfMatch(           i,kinetics.reactivity.data.SIZZZAAA) for i in iRemove_ID};

    Real mC_gen_add[Medium_PFL.nC];// = {if i in iRemove then -drainTank_liquid.mC[i]*removal.y else 0.0 for i in 1:Medium_PFL.nC};
    Real mC_removed_total[Medium_PFL.nC];

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

    // protected
  protected
    MSR.MoltenSaltReactor.Data.data_PHX data_PHX
      annotation (Placement(transformation(extent={{290,100},{310,120}})));
    MSR.MoltenSaltReactor.Data.data_RCTR data_RCTR
      annotation (Placement(transformation(extent={{260,100},{280,120}})));
    MSR.MoltenSaltReactor.Data.data_PUMP data_PUMP
      annotation (Placement(transformation(extent={{320,120},{340,140}})));
    MSR.MoltenSaltReactor.Data.data_SHX data_SHX
      annotation (Placement(transformation(extent={{320,100},{340,120}})));
    MSR.MoltenSaltReactor.Data.data_PIPING data_PIPING
      annotation (Placement(transformation(extent={{260,80},{280,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_RCTR.nFcells,
      C_a_start=Cs_start_fuelCell,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_PHX.T_outlet_tube,
      T_b_start=data_PHX.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_PHX.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_RCTR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_RCTR.crossArea_f,
          perimeter=data_RCTR.perimeter_f,
          length=data_RCTR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_RCTR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Components.GenericPipe_forMSRs reflA_upper(
      m_flow_a_start=data_RCTR.m_flow,
      p_a_start=data_PHX.p_inlet_tube + 50,
      T_a_start=data_PHX.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_RCTR.crossArea_reflA_ring,
          perimeter=data_RCTR.perimeter_reflA_ring,
          length=data_RCTR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_PHX.p_inlet_tube,
      T_start=data_PHX.T_inlet_tube,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_RCTR.length_plenum,
          crossArea=data_RCTR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    Components.GenericPipe_forMSRs reflA_lower(
      m_flow_a_start=data_RCTR.m_flow,
      p_a_start=data_PHX.p_inlet_tube + 150,
      T_a_start=data_PHX.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_RCTR.crossArea_reflA_ring,
          perimeter=data_RCTR.perimeter_reflA_ring,
          length=data_RCTR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    Components.MixingVolume_forMSRs plenum_lower(
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_PHX.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_RCTR.length_plenum,
          crossArea=data_RCTR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_RCTR.nfG*data_RCTR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_RCTR.width_fG,
          length_y=data_RCTR.length_cells,
          length_z=data_RCTR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_PHX.T_inlet_tube + data_PHX.T_outlet_tube),
      T_b1_start=0.5*(data_PHX.T_inlet_tube + data_PHX.T_outlet_tube),
      T_b2_start=data_PHX.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_PHX.T_inlet_tube,
      T_b2_start=data_PHX.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_PHX.T_inlet_tube,
      T_b1_start=data_PHX.T_inlet_tube,
      nParallel=data_RCTR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_RCTR.rs_ring_edge_inner[6],
          r_outer=data_RCTR.rs_ring_edge_outer[6],
          length_z=data_RCTR.length_reflA,
          angle_theta=data_RCTR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_RCTR.n_reflA_ringG,
      T_a1_start=data_PHX.T_outlet_tube,
      T_b1_start=data_PHX.T_outlet_tube,
      T_a2_start=data_PHX.T_outlet_tube,
      T_b2_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_RCTR.rs_ring_edge_inner[6],
          r_outer=data_RCTR.rs_ring_edge_outer[6],
          length_z=data_RCTR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_RCTR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    Components.MixingVolume_forMSRs tee_inlet(
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_PHX.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_PHX.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_RCTR.length_tee_inlet,
          crossArea=data_RCTR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_PHX.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_PHX.p_inlet_tube + 250,
      m_flow_a_start=2*3*data_PHX.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_PIPING.length_PHXToRCTR,
          dimension=data_PIPING.D_PFL,
          dheight=toggleStaticHead*data_PIPING.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_PHX.p_inlet_shell,
      T_a_start_shell=data_PHX.T_inlet_shell,
      T_b_start_shell=data_PHX.T_outlet_shell,
      p_a_start_tube=data_PHX.p_inlet_tube,
      T_a_start_tube=data_PHX.T_inlet_tube,
      T_b_start_tube=data_PHX.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_PHX.m_flow_shell,
      C_a_start_tube=Cs_start_loop,
      m_flow_a_start_tube=2*3*data_PHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_PHX.D_tube_outer,
          S_T=data_PHX.pitch_tube,
          S_L=data_PHX.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_PHX.D_shell_inner,
          nTubes=data_PHX.nTubes,
          nR=3,
          length_shell=data_PHX.length_tube,
          th_wall=data_PHX.th_tube,
          dimension_tube=data_PHX.D_tube_inner,
          length_tube=data_PHX.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_PHX.p_inlet_tube + 350,
      T_a_start=data_PHX.T_inlet_tube,
      m_flow_a_start=2*3*data_PHX.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PFL,
          length=data_PIPING.length_pumpToPHX,
          dheight=toggleStaticHead*data_PIPING.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_PHX.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_PHX.p_inlet_tube,
      level_start=data_RCTR.level_pumpbowlnominal,
      C_start=Cs_start_loop,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_PHX.T_inlet_tube),
      A=3*data_RCTR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_PHX.T_inlet_tube,
      val_min=data_PHX.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_PHX.p_inlet_shell - 50,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_PHXsToPump,
          dheight=toggleStaticHead*data_PIPING.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={190,40})));
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_RCTR.level_pumpbowlnominal,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      A=3*data_RCTR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start, data_SHX.T_outlet_shell))
      annotation (Placement(transformation(extent={{210,36},{230,56}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_PHX.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{240,30},{260,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_pumpToSHX,
          dheight=toggleStaticHead*data_PIPING.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={280,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 50,
      T_a_start=data_PHX.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_SHXToPHX,
          dheight=toggleStaticHead*data_PIPING.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={230,-40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary4(
      m_flow=2*3*data_SHX.m_flow_tube,
      T=data_SHX.T_inlet_tube,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={330,-40})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=2*3,
      p_a_start_shell=data_SHX.p_inlet_shell,
      T_a_start_shell=data_SHX.T_inlet_shell,
      T_b_start_shell=data_SHX.T_outlet_shell,
      m_flow_a_start_shell=2*3*data_SHX.m_flow_shell,
      p_a_start_tube=data_SHX.p_inlet_tube,
      T_a_start_tube=data_SHX.T_inlet_tube,
      T_b_start_tube=data_SHX.T_outlet_tube,
      m_flow_a_start_tube=2*3*data_SHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_SHX.D_tube_outer,
          S_T=data_SHX.pitch_tube,
          S_L=data_SHX.pitch_tube,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_SHX.D_shell_inner,
          nTubes=data_SHX.nTubes,
          length_shell=data_SHX.length_tube,
          dimension_tube=data_SHX.D_tube_inner,
          length_tube=data_SHX.length_tube,
          th_wall=data_SHX.th_tube,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={300,0})));

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      p=data_SHX.p_outlet_tube,
      T=data_SHX.T_outlet_tube,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={330,40})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{290,120},{310,140}})));
    Components.GenericPipe_forMSRs reflR(
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_PHX.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_PHX.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_RCTR.nRegions,
      m_flow_a_start=0.05*data_RCTR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_RCTR.crossArea_reflR,
          perimeter=data_RCTR.perimeter_reflR,
          length=data_RCTR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_PHX.T_outlet_tube + data_PHX.T_outlet_tube),
      T_a2_start=data_PHX.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_RCTR.nRegions*data_RCTR.n_reflR_blockG,
      T_b1_start=0.5*(data_PHX.T_outlet_tube + data_PHX.T_outlet_tube),
      T_b2_start=data_PHX.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_RCTR.width_reflR_blockG,
          length_y=data_RCTR.length_reflR,
          length_z=data_RCTR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_RCTR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_RCTR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_PHX.T_inlet_tube,
      T_tube_outlet_PHX=data_PHX.T_outlet_tube,
      p_inlet_tube_PHX=data_PHX.p_inlet_tube,
      m_flow_tube_PHX=data_PHX.m_flow_tube,
      T_shell_inlet_PHX=data_PHX.T_inlet_shell,
      T_shell_outlet_PHX=data_PHX.T_outlet_shell,
      p_inlet_shell_PHX=data_PHX.p_inlet_shell,
      m_flow_shell_PHX=data_PHX.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_PHX.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_RCTR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_RCTR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{260,120},{280,140}})));

    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_PHX.m_flow_tube)
      annotation (Placement(transformation(extent={{76,132},{56,152}})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_RCTR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_RCTR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (redeclare record Data = Data_ISO, mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO,
              fuelCell.nV)))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
                             annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

    //////////

    //Comment/Uncomment as a block - BIG DATA - 2b
  //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
  //     constant Integer i_mCs_start_salt[:]={1007,992};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
       record Data_ISO = Data.fissionProducts_1a;
       constant Integer i_mCs_start_salt[:]={87,79};

     // for cases 2a and 2b
   constant String actinide[:]={"u-233","th-232"};
   constant Integer nA=size(i_mCs_start_salt, 1);
   constant SI.MassFraction x_actinide[nA]={0.90,0.10};
   constant SI.Mass m_actinide=20;
   constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[
       i_mCs_start_salt[i]] for i in 1:nA};
   constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*
        x_actinide[i]/MW[i]*Modelica.Constants.N_A for i in 1:nA};

  //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
  //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
  //       record Data_ISO =
  //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
  //
  //       constant Integer i_mCs_start_salt[:]={4};
  //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=Functions.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

    parameter Integer nV_total=nV_fuelCell + nV_PHX + nV_SHX + nV_pipeToPHX_PFL + nV_pipeFromPHX_PFL +
        nV_pipeFromPHX_PCL + nV_pipeToPHX_PCL + nV_pipeToSHX_PCL;
    parameter Real mCs_start_perVolume[kinetics.data.nC + kinetics.reactivity.nC]=mCs_start/nV_total;

    // ere 1.0 is placeholder for the mass of each volume
    parameter Real Cs_start_fuelCell[kinetics.data.nC + kinetics.reactivity.data.nC]=
        mCs_start_perVolume/1.0;
    parameter Real Cs_start_loop[kinetics.data.nC + kinetics.reactivity.data.nC]=mCs_start_perVolume/1.0;

    //////////

    //SIadd.NonDim mCs[kinetics.reactivity.nC]=kinetics.reactivity.mCs[1,:];
  protected
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T1(y=drainTank_liquid.port_a.m_flow)
      annotation (Placement(transformation(extent={{-270,-44},{-250,-24}})));
  //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
  //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
  //
  //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
  //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
  //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
  //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
  //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
  //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
  //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
  //       end];
  //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
  //        + 1:end];
  //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
  //        + 1:end];
  //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
  //       kinetics.data.nC + 1:end];
  //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
  //       end];
  //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
  //       kinetics.data.nC + 1:end];
  //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

   //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
   //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

  public
    SIadd.NonDim mC_systemTotal[Medium_PFL.nC] = {mC_plenum_upper[i] + mC_plenum_lower[i] + mC_tee_inlet[i] + mC_pumpBowl_PFL[i] + mC_drainTank_gas[i]
    + mC_drainTank_liquid[i] + sum(mCs_fuelCell[:,i]) + sum(mCs_reflA_upper[:,1]) + sum(mCs_reflA_lower[:,1]) + sum(mCs_pipeFromPHX_PFL[:,1]) + sum(mCs_PHX_tube[:,1])
    + sum(mCs_pipeToPHX_PFL[:,1]) + sum(mCs_reflR[:,1]) for i in 1:Medium_PFL.nC};

   SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC] = plenum_upper.mC;
   SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC] = plenum_lower.mC;
   SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC] = tee_inlet.mC;
   SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC] = pumpBowl_PFL.mC;
   SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC] = drainTank_gas.mC;
   SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC] = drainTank_liquid.mC;
   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = fuelCell.mCs;
   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = reflA_upper.mCs;
   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = reflA_lower.mCs;
   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = pipeFromPHX_PFL.mCs;
   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = PHX.tube.mCs;
   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = pipeToPHX_PFL.mCs;
   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC] = reflR.mCs;
    Modelica.Blocks.Sources.Pulse removal(
      amplitude=0.5/(30*24*60*60/100),
      width=20,
      period=150*24*60*60,                                     startTime=150*24*60*60)
      annotation (Placement(transformation(extent={{-320,-140},{-300,-120}})));
  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_RCTR.Q_nominal,
      k_m=1/data_RCTR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_PHX.T_inlet_tube,
      k_m=1/data_PHX.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_PHX.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_OffGas_sink(
      redeclare package Medium = Medium_OffGas,
      nPorts=2,
      T=data_OFFGAS.T_carbon,
      p=data_OFFGAS.p_sep_ref,
      use_p_in=true,
      showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-218,28},{-238,48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_OffGas_source(
      T=data_OFFGAS.T_sep_ref,
      redeclare package Medium = Medium_OffGas,
      m_flow=data_OFFGAS.m_flow_He_adsorber,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      use_C_in=false,
      showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-358,106},{-338,126}})));
    TRANSFORM.Fluid.TraceComponents.TraceDecayAdsorberBed_sparseMatrix
                                                          adsorberBed(
      nV=10,
      redeclare package Medium = Medium_OffGas,
      d_adsorber=data_OFFGAS.d_carbon,
      cp_adsorber=data_OFFGAS.cp_carbon,
      tau_res=data_OFFGAS.delay_charcoalBed,
      R=data_OFFGAS.dp_carbon/data_OFFGAS.m_flow_He_adsorber,
      use_HeatPort=true,
      T_a_start=data_OFFGAS.T_carbon,
      showName=systemTF.showName,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-278,-22},{-258,-2}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_m_flow(y=data_OFFGAS.m_flow_He_adsorber)
      annotation (Placement(transformation(extent={{-398,124},{-378,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T(y=data_OFFGAS.T_sep_ref)
      annotation (Placement(transformation(extent={{-398,110},{-378,130}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary_thermal_adsorberBed(
      nPorts=adsorberBed.nV,
      T=fill(data_OFFGAS.T_carbon_wall, adsorberBed.nV),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-268,18})));
    Components.MixingVolume_forMSRs drainTank_gas(
      use_HeatPort=true,
      redeclare package Medium = Medium_OffGas,
      T_start=data_OFFGAS.T_drainTank,
      p_start=data_OFFGAS.p_drainTank,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      nPorts_a=1,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data_OFFGAS.volume_drainTank_inner - drainTank_liquid.V))
      annotation (Placement(transformation(extent={{-308,-2},{-288,-22}})));
    Components.ExpansionTank drainTank_liquid(
      redeclare package Medium = Medium_PFL,
      p_surface=drainTank_gas.medium.p,
      h_start=pumpBowl_PFL.h_start,
      p_start=drainTank_gas.p_start,
      use_HeatPort=true,
      A=data_OFFGAS.crossArea_drainTank_inner,
      level_start=0.20,
      showName=systemTF.showName,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      mC_gen_add=mC_gen_add)
      annotation (Placement(transformation(extent={{-308,-56},{-288,-36}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
      resistance_fromDrainTank(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-268,-52})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_drainTank(redeclare
        package Medium =                                                                   Medium_PFL,
        use_input=true)
      annotation (Placement(transformation(extent={{-248,-62},{-228,-42}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_bypass(use_input=true, redeclare
        package Medium =
                 Medium_OffGas)
      annotation (Placement(transformation(extent={{-278,28},{-258,48}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_adsorberBed(use_input=true, redeclare
        package Medium = Medium_OffGas)
      annotation (Placement(transformation(extent={{-248,-22},{-228,-2}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_bypass(y=boundary_OffGas_m_flow.y -
          m_flow_OffGas_adsorberBed.y)
      annotation (Placement(transformation(extent={{-300,38},{-280,58}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_adsorberBed(y=data_OFFGAS.frac_gasSplit*
          boundary_OffGas_m_flow.y)
      annotation (Placement(transformation(extent={{-212,-2},{-232,18}})));
    TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(
      iSep=iSep,
      iCar=iSep,
      m_flow_sepFluid=m_flow_toDrainTank,
      redeclare package Medium = Medium_PFL,
      redeclare package Medium_carrier = Medium_OffGas,
      showName=systemTF.showName)
                annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-318,98})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_bypass(redeclare package
                Medium =                                                                Medium_PFL,
        use_input=true)
      annotation (Placement(transformation(extent={{-286,110},{-306,130}})));
    Modelica.Blocks.Sources.RealExpression m_flow_pump_bypass(y=x_bypass.y*abs(pump_PFL.port_a.m_flow))
      annotation (Placement(transformation(extent={{-326,124},{-306,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_fromPump_PFL_bypass_p(y=pumpBowl_PFL.p)
      annotation (Placement(transformation(extent={{-190,36},{-210,56}})));
    TRANSFORM.Examples.MoltenSaltReactor.Components.DRACS DRACS(
      redeclare package Medium_DRACS = Medium_DRACS,
      showName=systemTF.showName,
      surfaceAreas_thimble=DRACS.thimble_outer_drainTank.surfaceArea_outer*DRACS.nP_outer_drainTank[1].nParallel
          *{drainTank_liquid.level/data_OFFGAS.length_drainTank_inner,1 - drainTank_liquid.level/
          data_OFFGAS.length_drainTank_inner},
      alphas_drainTank={5000,1000})
      annotation (Placement(transformation(extent={{-402,-88},{-332,-8}})));
    Modelica.Blocks.Sources.RealExpression
                                     x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
                      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    for i in 1:Medium_PFL.nC loop
      if TRANSFORM.Math.exists(i,iRemove) then
        mC_gen_add[i] = -drainTank_liquid.mC[i]*removal.y;
      else
        mC_gen_add[i] = 0.0;
      end if;
    end for;
    der(mC_removed_total) = -1*mC_gen_add;

    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{-4.44089e-16,
            105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{3.33067e-16,96}}, color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-40},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
    connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
      annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},{160,-140},
            {-4.44089e-16,-140},{-4.44089e-16,-136}}, color={0,127,255}));
    connect(PHX.port_b_shell, pipeFromPHX_PCL.port_a)
      annotation (Line(points={{164.6,10},{164,10},{164,40},{180,40}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b, pumpBowl_PCL.port_a)
      annotation (Line(points={{200,40},{213,40}}, color={0,127,255}));
    connect(pumpBowl_PCL.port_b, pump_PCL.port_a)
      annotation (Line(points={{227,40},{240,40}}, color={0,127,255}));
    connect(pump_PCL.port_b, pipeToSHX_PCL.port_a)
      annotation (Line(points={{260,40},{270,40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_a, SHX.port_b_shell)
      annotation (Line(points={{240,-40},{295.4,-40},{295.4,-10}}, color={0,127,255}));
    connect(pipeToSHX_PCL.port_b, SHX.port_a_shell)
      annotation (Line(points={{290,40},{295.4,40},{295.4,10}}, color={0,127,255}));
    connect(boundary1.ports[1], SHX.port_b_tube)
      annotation (Line(points={{320,40},{300,40},{300,10}}, color={0,127,255}));
    connect(SHX.port_a_tube, boundary4.ports[1])
      annotation (Line(points={{300,-10},{300,-40},{320,-40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_b, PHX.port_a_shell)
      annotation (Line(points={{220,-40},{164.6,-40},{164.6,-10}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(m_flow_pump_PFL.y, pump_PFL.in_m_flow)
      annotation (Line(points={{55,142},{50,142},{50,135.3}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(boundary_OffGas_T.y,boundary_OffGas_source. T_in)
      annotation (Line(points={{-377,120},{-360,120}}, color={0,0,127}));
    connect(boundary_OffGas_m_flow.y,boundary_OffGas_source. m_flow_in)
      annotation (Line(points={{-377,134},{-368,134},{-368,124},{-358,124}},
          color={0,0,127}));
    connect(boundary_thermal_adsorberBed.port,adsorberBed. heatPorts)
      annotation (Line(points={{-268,8},{-268,-7}},  color={191,0,0}));
    connect(drainTank_liquid.port_b,resistance_fromDrainTank. port_a)
      annotation (Line(points={{-291,-52},{-275,-52}}, color={0,127,255}));
    connect(resistance_fromDrainTank.port_b,pump_drainTank. port_a)
      annotation (Line(points={{-261,-52},{-248,-52}}, color={0,127,255}));
    connect(adsorberBed.port_b,pump_OffGas_adsorberBed. port_a)
      annotation (Line(points={{-258,-12},{-248,-12}}, color={0,127,255}));
    connect(m_flow_OffGas_bypass.y,pump_OffGas_bypass. in_m_flow) annotation (
        Line(points={{-279,48},{-268,48},{-268,45.3}}, color={0,0,127}));
    connect(m_flow_OffGas_adsorberBed.y,pump_OffGas_adsorberBed. in_m_flow)
      annotation (Line(points={{-233,8},{-238,8},{-238,-4.7}},  color={0,0,127}));
    connect(boundary_OffGas_source.ports[1],traceSeparator. port_a_carrier)
      annotation (Line(points={{-338,116},{-324,116},{-324,108}}, color={0,127,255}));
    connect(m_flow_pump_bypass.y,pump_bypass. in_m_flow) annotation (Line(points={{-305,134},{-296,134},
            {-296,127.3}},                       color={0,0,127}));
    connect(adsorberBed.port_a,drainTank_gas. port_b[1]) annotation (Line(points={{-278,
            -12},{-286,-12},{-286,-11.5},{-292,-11.5}},       color={0,127,255}));
    connect(pump_bypass.port_b,traceSeparator. port_a) annotation (Line(points={{-306,120},{-312,120},{
            -312,108}},                  color={0,127,255}));
    connect(traceSeparator.port_sepFluid,drainTank_liquid. port_a) annotation (
        Line(points={{-318,88},{-318,-52},{-305,-52}}, color={0,127,255}));
    connect(traceSeparator.port_b_carrier,drainTank_gas. port_a[1]) annotation (
        Line(points={{-324,88},{-324,-12},{-304,-12}}, color={0,127,255}));
    connect(pump_OffGas_bypass.port_a,drainTank_gas. port_b[2]) annotation (Line(
          points={{-278,38},{-286,38},{-286,-12.5},{-292,-12.5}}, color={0,127,255}));
    connect(pump_OffGas_bypass.port_b,boundary_OffGas_sink. ports[1]) annotation (
       Line(points={{-258,38},{-248,38},{-248,40},{-238,40}}, color={0,127,255}));
    connect(pump_OffGas_adsorberBed.port_b,boundary_OffGas_sink. ports[2])
      annotation (Line(points={{-228,-12},{-206,-12},{-206,24},{-246,24},{-246,36},
            {-238,36}}, color={0,127,255}));
    connect(boundary_fromPump_PFL_bypass_p.y,boundary_OffGas_sink. p_in)
      annotation (Line(points={{-211,46},{-216,46}}, color={0,0,127}));
    connect(traceSeparator.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-312,88},{-312,78},{-188,
            78},{-188,128},{13,128}},                          color={0,127,255}));
    connect(pump_drainTank.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-228,-52},{-188,-52},
            {-188,128},{13,128}},                      color={0,127,255}));
    connect(pump_bypass.port_a, pipeToPHX_PFL.port_a) annotation (Line(points={{-286,120},{-278,120},{-278,
            158},{160,158},{160,80}},                       color={0,127,255}));
    connect(drainTank_liquid.heatPort,DRACS. port_thimbleWall[1]) annotation (
        Line(points={{-298,-54.4},{-298,-74},{-332,-74}}, color={191,0,0}));
    connect(drainTank_gas.heatPort,DRACS. port_thimbleWall[2]) annotation (Line(
          points={{-298,-6},{-298,0},{-308,0},{-308,-70},{-332,-70}},    color={191,
            0,0}));
    connect(boundary_OffGas_T1.y,pump_drainTank. in_m_flow) annotation (Line(
          points={{-249,-34},{-238,-34},{-238,-44.7}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=4380,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
  end MCA_Base_withBOP_UTh;

  model TestSaltPopertyChange
    extends Old_NotInUseRightNow.MCA_Base_withBOP(
                             redeclare replaceable package Medium_PFL =
          MSR.CustomSalts.LinearFLiBe_12Th_05U_pT (
          d_mult=1,
          lambda_mult=1,
          cp_mult=1,
          eta_mult=1,
          extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC)));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TestSaltPopertyChange;

  model SimpleTestsPropertyChange
    extends TRANSFORM.Icons.Example;

    package Medium = MSR.CustomSalts.LinearFLiBe_12Th_05U_pT (
        d_mult=1.0,
        lambda_mult=1.0,
        cp_mult=1.0,
        eta_mult=1.0);

    parameter Integer nV=10;
    parameter SI.Length length=1.0;
    parameter SI.Length dimension=0.01;
    parameter SI.Temperature T_start=20 + 273.15;
    parameter SI.Pressure p_start=1e5;

    parameter SI.MassFlowRate m_flow = 1;

    // Optimize
    replaceable model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region;
    // End Optimize

    parameter Real CFs[nV] = fill(1.0,nV);

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface
                                           pipe(
      redeclare package Medium = Medium,
      p_a_start=p_start,
      T_a_start=T_start,
      m_flow_a_start=m_flow,
      redeclare replaceable model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=dimension,
          length=length,
          nV=nV),
      use_HeatTransfer=true,
      redeclare model HeatTransfer = HeatTransfer (CFs={{CFs[i] for j in 1:1}
              for i in 1:nV}))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T
                                        boundary(
      redeclare package Medium = Medium,
      use_C_in=false,
      m_flow=m_flow,
      T=T_start,
      nPorts=1)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT
                                   boundary1(
      redeclare package Medium = Medium,
      p=p_start,
      T=T_start,
      nPorts=1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary2(nPorts=nV, T=fill(350, nV)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,24})));
  equation
    connect(boundary.ports[1],pipe. port_a)
      annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
    connect(pipe.port_b,boundary1. ports[1])
      annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
    connect(boundary2.port,pipe. heatPorts[:, 1])
      annotation (Line(points={{0,14},{0,5}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SimpleTestsPropertyChange;

  model PropChangeReactivityInsertion

   extends Old_NotInUseRightNow.MCA_ReactivityInsertion_withBOP(
                                           redeclare replaceable package
        Medium_PFL =
       MSR.CustomSalts.LinearFLiBe_12Th_05U_pT (
          d_mult=0.95,
          lambda_mult=1,
          cp_mult=1,
          eta_mult=1,
          extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC)));

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                 Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=10000000,
        __Dymola_NumberOfIntervals=5000,
        __Dymola_Algorithm="Esdirk45a"));
  end PropChangeReactivityInsertion;

  model MCA_Base_withBOP_sec_NoDRACSNoOffgas
    import NHES;

    extends TRANSFORM.Icons.Example;

    import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

   // Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow) "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu=kinetics.data.nC + Functions.FindIndexOfMatch(           20094239, kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
        30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
        30054137};
  public
    parameter Integer iSep[:]={kinetics.data.nC + Functions.FindIndexOfMatch(           i, kinetics.reactivity.data.SIZZZAAA)
        for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

  //  MSR.MoltenSaltReactor.Data.data_PHX data_PHX annotation (Placement(transformation(extent={{290,100},{310,120}})));
  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR    annotation (Placement(transformation(extent={{260,100},{280,120}})));
  //  MSR.MoltenSaltReactor.Data.data_PUMP data_PUMP annotation (Placement(transformation(extent={{320,120},{340,140}})));
  //  MSR.MoltenSaltReactor.Data.data_SHX data_SHX
  //  MSR.MoltenSaltReactor.Data.data_PIPING data_PIPING    annotation (Placement(transformation(extent={{260,80},{280,100}})));
  protected
    MSR.MoltenSaltReactor.Data.data_MSR data_MSR
      annotation (Placement(transformation(extent={{304,74},{324,94}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-28})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_MSR.length_PHXToRCTR,
          dimension=data_MSR.D_PFL,
          dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_MSR.p_inlet_shell,
      T_a_start_shell=data_MSR.T_inlet_shell,
      T_b_start_shell=data_MSR.T_outlet_shell,
      p_a_start_tube=data_MSR.p_inlet_tube,
      T_a_start_tube=data_MSR.T_inlet_tube,
      T_b_start_tube=data_MSR.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer,
          S_T=data_MSR.pitch_tube,
          S_L=data_MSR.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_MSR.D_shell_inner,
          nTubes=data_MSR.nTubes,
          nR=3,
          length_shell=data_MSR.length_tube,
          th_wall=data_MSR.th_tube,
          dimension_tube=data_MSR.D_tube_inner,
          length_tube=data_MSR.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 350,
      T_a_start=data_MSR.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PFL,
          length=data_MSR.length_pumpToPHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube,
      level_start=data_MSR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_MSR.T_inlet_tube),
      A=3*data_MSR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_MSR.T_inlet_tube,
      val_min=data_MSR.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_MSR.p_inlet_shell - 50,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_PHXsToPump,
          dheight=toggleStaticHead*data_MSR.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={190,40})));
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_MSR.level_pumpbowlnominal,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      A=3*data_MSR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start, data_MSR.T_outlet_shell_SHX))
      annotation (Placement(transformation(extent={{210,36},{230,56}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_MSR.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{240,30},{260,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_pumpToSHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={280,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 50,
      T_a_start=data_MSR.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_SHXToPHX,
          dheight=toggleStaticHead*
          data_MSR.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={230,-40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary4(
      m_flow=2*3*data_MSR.m_flow_tube_SHX,
      T=data_MSR.T_inlet_tube_SHX,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={330,-40})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=2*3,
      p_a_start_shell=data_MSR.p_inlet_shell_SHX,
      T_a_start_shell=data_MSR.T_inlet_shell_SHX,
      T_b_start_shell=data_MSR.T_outlet_shell_SHX,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell_SHX,
      p_a_start_tube=data_MSR.p_inlet_tube_SHX,
      T_a_start_tube=data_MSR.T_inlet_tube_SHX,
      T_b_start_tube=data_MSR.T_outlet_tube_SHX,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube_SHX,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer_SHX,
          S_T=data_MSR.pitch_tube_SHX,
          S_L=data_MSR.pitch_tube_SHX,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_MSR.D_shell_inner_SHX,
          nTubes=data_MSR.nTubes_SHX,
          length_shell=data_MSR.length_tube_SHX,
          dimension_tube=data_MSR.D_tube_inner_SHX,
          length_tube=data_MSR.length_tube_SHX,
          th_wall=data_MSR.th_tube_SHX,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={300,0})));

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      p=data_MSR.p_outlet_tube_SHX,
      T=data_MSR.T_outlet_tube_SHX,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={330,40})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_MSR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_MSR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_MSR.T_inlet_tube,
      T_tube_outlet_PHX=data_MSR.T_outlet_tube,
      p_inlet_tube_PHX=data_MSR.p_inlet_tube,
      m_flow_tube_PHX=data_MSR.m_flow_tube,
      T_shell_inlet_PHX=data_MSR.T_inlet_shell,
      T_shell_outlet_PHX=data_MSR.T_outlet_shell,
      p_inlet_shell_PHX=data_MSR.p_inlet_shell,
      m_flow_shell_PHX=data_MSR.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_MSR.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_MSR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_MSR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_MSR.T_inlet_tube_SHX,
      T_tube_outlet_SHX=data_MSR.T_outlet_tube_SHX,
      p_inlet_tube_SHX=data_MSR.p_inlet_tube_SHX,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_MSR.m_flow_tube_SHX,
      T_shell_inlet_SHX=data_MSR.T_inlet_shell_SHX,
      T_shell_outlet_SHX=data_MSR.T_outlet_shell_SHX,
      p_inlet_shell_SHX=data_MSR.p_inlet_shell_SHX,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_MSR.m_flow_shell_SHX,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_MSR.pitch_tube_SHX,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{256,120},{276,140}})));

    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_MSR.m_flow_tube)
      annotation (Placement(transformation(extent={{76,132},{56,152}})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

    //////////
    //    //Comment/Uncomment as a block - BIG DATA - 2b
    //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //
    //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
    //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
    //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
    //              19.43194,99.693068,185.13937};
    //
    //          constant Integer i_mCs_start_salt[:]={1009,1013};
    //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

    //Comment/Uncomment as a block - BIG DATA - 2b
    //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //     constant Integer i_mCs_start_salt[:]={1009,1013};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
    constant String actinide[:]={"u-235","u-238"};
    constant Integer nA=size(i_mCs_start_salt, 1);
    constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
    constant Real Ufrac = 0.01;
    constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
    constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
    constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

    constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
        nA};

      constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
      constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
          for i in 1:nA};

  //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
  //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
  //        for i in 1:nA};

    //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
    //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
    //       record Data_ISO =
    //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
    //
    //       constant Integer i_mCs_start_salt[:]={4};
    //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=Functions.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

  parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

    //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
    //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
    //
    //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
    //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

    //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
    //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

    // atoms per node

  public
    SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
  //  SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
  //  SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
    SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_upper.mCs;
    SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_lower.mCs;
    SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
       pipeFromPHX_PFL.mCs;
    SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
    SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        pipeToPHX_PFL.mCs;
    SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

    // atoms component total
    SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
  //  SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
  //  SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
        :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
        :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
        reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

    // atoms total
    SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
        mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
        mCs_fuelCell_total[i] +
        mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
        mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
         + kinetics.reactivity.data.nC};
        //      mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] +

    // nParallel
    Real plenum_upper_nParallel=1;
    Real plenum_lower_nParallel=1;
    Real tee_inlet_nParallel=1;
    Real pumpBowl_PFL_nParallel=1;
  //  Real drainTank_gas_nParallel=1;
  //  Real drainTank_liquid_nParallel=1;
    Real fuelCell_nParallel=fuelCell.nParallel;
    Real reflA_upper_nParallel=reflA_upper.nParallel;
    Real reflA_lower_nParallel=reflA_lower.nParallel;
    Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
    Real PHX_tube_nParallel=PHX.tube.nParallel;
    Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
    Real reflR_nParallel=reflR.nParallel;

    // mass per node
    SI.Mass plenum_upper_m=plenum_upper.m;
    SI.Mass plenum_lower_m=plenum_lower.m;
    SI.Mass tee_inlet_m=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
  //  SI.Mass drainTank_liquid_m=drainTank_liquid.m;
    SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
    SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
    SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
    SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
    SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
    SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
    SI.Mass reflR_m[reflR.nV]=reflR.ms;

    // mass component total
    SI.Mass plenum_upper_m_total=plenum_upper.m;
    SI.Mass plenum_lower_m_total=plenum_lower.m;
    SI.Mass tee_inlet_m_total=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
  //  SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
    SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
    SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
    SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
    SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
    SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
    SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
    SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

    // mass total
    SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
        pumpBowl_PFL_m_total +
         fuelCell_m_total +
        reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
        pipeToPHX_PFL_m_total + reflR_m_total;
         //drainTank_liquid_m_total +

    // volume nodal
    SI.Volume plenum_upper_V=plenum_upper.V;
    SI.Volume plenum_lower_V=plenum_lower.V;
    SI.Volume tee_inlet_V=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
   // SI.Volume drainTank_liquid_V=drainTank_liquid.V;
    SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
    SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
    SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
    SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
    SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
    SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
    SI.Volume reflR_V[reflR.nV]=reflR.Vs;

    // volume component total
    SI.Volume plenum_upper_V_total=plenum_upper.V;
    SI.Volume plenum_lower_V_total=plenum_lower.V;
    SI.Volume tee_inlet_V_total=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
  //  SI.Volume drainTank_gas_V_total=drainTank_gas.V;
  //  SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
    SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
    SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
    SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
    SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
    SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
    SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
    SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

    // volume total
    SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
        pumpBowl_PFL_V_total +
         fuelCell_V_total +
        reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
        pipeToPHX_PFL_V_total + reflR_V_total;
         //drainTank_liquid_V_total +

    // nV
    Integer fuelCell_nV=fuelCell.nV;
    Integer reflA_upper_nV=reflA_upper.nV;
    Integer reflA_lower_nV=reflA_lower.nV;
    Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
    Integer PHX_tube_nV=PHX.tube.nV;
    Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
    Integer reflR_nV=reflR.nV;

    // lengths
    SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
    SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
    SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
    SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
    SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
    SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
    SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

    // dimensions
    SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
    SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
    SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
    SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
    SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
    SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
    SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.Q_nominal,
      k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.T_inlet_tube,
      k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.1)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{-4.44089e-16,
            105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{3.33067e-16,96}}, color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
    connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
      annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},{160,-140},
            {-4.44089e-16,-140},{-4.44089e-16,-136}}, color={0,127,255}));
    connect(PHX.port_b_shell, pipeFromPHX_PCL.port_a)
      annotation (Line(points={{164.6,10},{164,10},{164,40},{180,40}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b, pumpBowl_PCL.port_a)
      annotation (Line(points={{200,40},{213,40}}, color={0,127,255}));
    connect(pumpBowl_PCL.port_b, pump_PCL.port_a)
      annotation (Line(points={{227,40},{240,40}}, color={0,127,255}));
    connect(pump_PCL.port_b, pipeToSHX_PCL.port_a)
      annotation (Line(points={{260,40},{270,40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_a, SHX.port_b_shell)
      annotation (Line(points={{240,-40},{295.4,-40},{295.4,-10}}, color={0,127,255}));
    connect(pipeToSHX_PCL.port_b, SHX.port_a_shell)
      annotation (Line(points={{290,40},{295.4,40},{295.4,10}}, color={0,127,255}));
    connect(boundary1.ports[1], SHX.port_b_tube)
      annotation (Line(points={{320,40},{300,40},{300,10}}, color={0,127,255}));
    connect(SHX.port_a_tube, boundary4.ports[1])
      annotation (Line(points={{300,-10},{300,-40},{320,-40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_b, PHX.port_a_shell)
      annotation (Line(points={{220,-40},{164.6,-40},{164.6,-10}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(m_flow_pump_PFL.y, pump_PFL.in_m_flow)
      annotation (Line(points={{55,142},{50,142},{50,135.3}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
      annotation (Placement(transformation(extent={{320,100},{340,120}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=1825,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
  end MCA_Base_withBOP_sec_NoDRACSNoOffgas;

  model MCA_Base_withBOP_sec

    extends TRANSFORM.Icons.Example;

    import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
        Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu=kinetics.data.nC + Functions.FindIndexOfMatch(           20094239, kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
        30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
        30054137};
  public
    parameter Integer iSep[:]={kinetics.data.nC + Functions.FindIndexOfMatch(           i, kinetics.reactivity.data.SIZZZAAA)
        for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR    annotation (Placement(transformation(extent={{290,100},{310,120}})));
   // MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{260,100},{280,120}})));
  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{320,120},{340,140}})));
  protected
    MSR.MoltenSaltReactor.Data.data_SHX data_SHX
      annotation (Placement(transformation(extent={{320,100},{340,120}})));
  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{260,80},{280,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-28})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_MSR.length_PHXToRCTR,
          dimension=data_MSR.D_PFL,
          dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_MSR.p_inlet_shell,
      T_a_start_shell=data_MSR.T_inlet_shell,
      T_b_start_shell=data_MSR.T_outlet_shell,
      p_a_start_tube=data_MSR.p_inlet_tube,
      T_a_start_tube=data_MSR.T_inlet_tube,
      T_b_start_tube=data_MSR.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer,
          S_T=data_MSR.pitch_tube,
          S_L=data_MSR.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_MSR.D_shell_inner,
          nTubes=data_MSR.nTubes,
          nR=3,
          length_shell=data_MSR.length_tube,
          th_wall=data_MSR.th_tube,
          dimension_tube=data_MSR.D_tube_inner,
          length_tube=data_MSR.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 350,
      T_a_start=data_MSR.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PFL,
          length=data_MSR.length_pumpToPHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube,
      level_start=data_MSR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_MSR.T_inlet_tube),
      A=3*data_MSR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_MSR.T_inlet_tube,
      val_min=data_MSR.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_MSR.p_inlet_shell - 50,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_PHXsToPump,
          dheight=toggleStaticHead*data_MSR.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={190,40})));
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_MSR.level_pumpbowlnominal,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      A=3*data_MSR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start, data_SHX.T_outlet_shell))
      annotation (Placement(transformation(extent={{210,36},{230,56}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_MSR.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{240,30},{260,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_pumpToSHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={280,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 50,
      T_a_start=data_MSR.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_SHXToPHX,
          dheight=toggleStaticHead*data_MSR.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={230,-40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary4(
      m_flow=2*3*data_SHX.m_flow_tube,
      T=data_SHX.T_inlet_tube,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={330,-40})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=2*3,
      p_a_start_shell=data_SHX.p_inlet_shell,
      T_a_start_shell=data_SHX.T_inlet_shell,
      T_b_start_shell=data_SHX.T_outlet_shell,
      m_flow_a_start_shell=2*3*data_SHX.m_flow_shell,
      p_a_start_tube=data_SHX.p_inlet_tube,
      T_a_start_tube=data_SHX.T_inlet_tube,
      T_b_start_tube=data_SHX.T_outlet_tube,
      m_flow_a_start_tube=2*3*data_SHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_SHX.D_tube_outer,
          S_T=data_SHX.pitch_tube,
          S_L=data_SHX.pitch_tube,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_SHX.D_shell_inner,
          nTubes=data_SHX.nTubes,
          length_shell=data_SHX.length_tube,
          dimension_tube=data_SHX.D_tube_inner,
          length_tube=data_SHX.length_tube,
          th_wall=data_SHX.th_tube,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={300,0})));

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      p=data_SHX.p_outlet_tube,
      T=data_SHX.T_outlet_tube,
      nPorts=1,
      showName=systemTF.showName,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={330,40})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{290,120},{310,140}})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_MSR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_MSR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_MSR.T_inlet_tube,
      T_tube_outlet_PHX=data_MSR.T_outlet_tube,
      p_inlet_tube_PHX=data_MSR.p_inlet_tube,
      m_flow_tube_PHX=data_MSR.m_flow_tube,
      T_shell_inlet_PHX=data_MSR.T_inlet_shell,
      T_shell_outlet_PHX=data_MSR.T_outlet_shell,
      p_inlet_shell_PHX=data_MSR.p_inlet_shell,
      m_flow_shell_PHX=data_MSR.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_MSR.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_MSR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_MSR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{260,120},{280,140}})));

    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_MSR.m_flow_tube)
      annotation (Placement(transformation(extent={{76,132},{56,152}})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

    //////////
    //    //Comment/Uncomment as a block - BIG DATA - 2b
    //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //
    //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
    //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
    //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
    //              19.43194,99.693068,185.13937};
    //
    //          constant Integer i_mCs_start_salt[:]={1009,1013};
    //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

    //Comment/Uncomment as a block - BIG DATA - 2b
    //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //     constant Integer i_mCs_start_salt[:]={1009,1013};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
    constant String actinide[:]={"u-235","u-238"};
    constant Integer nA=size(i_mCs_start_salt, 1);
    constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
    constant Real Ufrac = 0.01;
    constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
    constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
    constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

    constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
        nA};

      constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
      constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
          for i in 1:nA};

  //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
  //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
  //        for i in 1:nA};

    //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
    //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
    //       record Data_ISO =
    //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
    //
    //       constant Integer i_mCs_start_salt[:]={4};
    //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=Functions.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

  parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

  protected
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T1(y=drainTank_liquid.port_a.m_flow)
      annotation (Placement(transformation(extent={{-270,-44},{-250,-24}})));
    //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
    //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
    //
    //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
    //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

    //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
    //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

    // atoms per node

  public
    SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
    SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_upper.mCs;
    SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_lower.mCs;
    SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
       pipeFromPHX_PFL.mCs;
    SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
    SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        pipeToPHX_PFL.mCs;
    SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

    // atoms component total
    SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=
        drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
        :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
        :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
        reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

    // atoms total
    SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
        mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
        mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] + mCs_fuelCell_total[i] +
        mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
        mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
         + kinetics.reactivity.data.nC};

    // nParallel
    Real plenum_upper_nParallel=1;
    Real plenum_lower_nParallel=1;
    Real tee_inlet_nParallel=1;
    Real pumpBowl_PFL_nParallel=1;
    Real drainTank_gas_nParallel=1;
    Real drainTank_liquid_nParallel=1;
    Real fuelCell_nParallel=fuelCell.nParallel;
    Real reflA_upper_nParallel=reflA_upper.nParallel;
    Real reflA_lower_nParallel=reflA_lower.nParallel;
    Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
    Real PHX_tube_nParallel=PHX.tube.nParallel;
    Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
    Real reflR_nParallel=reflR.nParallel;

    // mass per node
    SI.Mass plenum_upper_m=plenum_upper.m;
    SI.Mass plenum_lower_m=plenum_lower.m;
    SI.Mass tee_inlet_m=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m=drainTank_liquid.m;
    SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
    SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
    SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
    SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
    SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
    SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
    SI.Mass reflR_m[reflR.nV]=reflR.ms;

    // mass component total
    SI.Mass plenum_upper_m_total=plenum_upper.m;
    SI.Mass plenum_lower_m_total=plenum_lower.m;
    SI.Mass tee_inlet_m_total=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
    SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
    SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
    SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
    SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
    SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
    SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
    SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

    // mass total
    SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
        pumpBowl_PFL_m_total + drainTank_liquid_m_total + fuelCell_m_total +
        reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
        pipeToPHX_PFL_m_total + reflR_m_total;

    // volume nodal
    SI.Volume plenum_upper_V=plenum_upper.V;
    SI.Volume plenum_lower_V=plenum_lower.V;
    SI.Volume tee_inlet_V=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
    SI.Volume drainTank_liquid_V=drainTank_liquid.V;
    SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
    SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
    SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
    SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
    SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
    SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
    SI.Volume reflR_V[reflR.nV]=reflR.Vs;

    // volume component total
    SI.Volume plenum_upper_V_total=plenum_upper.V;
    SI.Volume plenum_lower_V_total=plenum_lower.V;
    SI.Volume tee_inlet_V_total=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
    SI.Volume drainTank_gas_V_total=drainTank_gas.V;
    SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
    SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
    SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
    SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
    SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
    SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
    SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
    SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

    // volume total
    SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
        pumpBowl_PFL_V_total + drainTank_liquid_V_total + fuelCell_V_total +
        reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
        pipeToPHX_PFL_V_total + reflR_V_total;

    // nV
    Integer fuelCell_nV=fuelCell.nV;
    Integer reflA_upper_nV=reflA_upper.nV;
    Integer reflA_lower_nV=reflA_lower.nV;
    Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
    Integer PHX_tube_nV=PHX.tube.nV;
    Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
    Integer reflR_nV=reflR.nV;

    // lengths
    SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
    SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
    SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
    SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
    SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
    SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
    SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

    // dimensions
    SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
    SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
    SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
    SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
    SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
    SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
    SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

    MoltenSaltReactor.Data.data_MSR data_MSR
      annotation (Placement(transformation(extent={{264,-128},{284,-108}})));
  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.Q_nominal,
      k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.T_inlet_tube,
      k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_OffGas_sink(
      redeclare package Medium = Medium_OffGas,
      nPorts=2,
      T=data_OFFGAS.T_carbon,
      p=data_OFFGAS.p_sep_ref,
      use_p_in=true,
      showName=systemTF.showName) annotation (Placement(transformation(extent={{-218,28},{-238,48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_OffGas_source(
      T=data_OFFGAS.T_sep_ref,
      redeclare package Medium = Medium_OffGas,
      m_flow=data_OFFGAS.m_flow_He_adsorber,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      use_C_in=false,
      showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-358,106},{-338,126}})));
    TRANSFORM.Fluid.TraceComponents.TraceDecayAdsorberBed_sparseMatrix adsorberBed(
      nV=10,
      redeclare package Medium = Medium_OffGas,
      d_adsorber=data_OFFGAS.d_carbon,
      cp_adsorber=data_OFFGAS.cp_carbon,
      tau_res=data_OFFGAS.delay_charcoalBed,
      R=data_OFFGAS.dp_carbon/data_OFFGAS.m_flow_He_adsorber,
      use_HeatPort=true,
      T_a_start=data_OFFGAS.T_carbon,
      showName=systemTF.showName,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-278,-22},{-258,-2}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_m_flow(y=data_OFFGAS.m_flow_He_adsorber)
      annotation (Placement(transformation(extent={{-398,124},{-378,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T(y=data_OFFGAS.T_sep_ref)
      annotation (Placement(transformation(extent={{-398,110},{-378,130}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary_thermal_adsorberBed(
      nPorts=adsorberBed.nV,
      T=fill(data_OFFGAS.T_carbon_wall, adsorberBed.nV),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-268,18})));
    Components.MixingVolume_forMSRs drainTank_gas(
      use_HeatPort=true,
      redeclare package Medium = Medium_OffGas,
      T_start=data_OFFGAS.T_drainTank,
      p_start=data_OFFGAS.p_drainTank,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      nPorts_a=1,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data_OFFGAS.volume_drainTank_inner - drainTank_liquid.V))
      annotation (Placement(transformation(extent={{-308,-2},{-288,-22}})));
    Components.ExpansionTank drainTank_liquid(
      redeclare package Medium = Medium_PFL,
      p_surface=drainTank_gas.medium.p,
      h_start=pumpBowl_PFL.h_start,
      p_start=drainTank_gas.p_start,
      C_start=Cs_start,
      use_HeatPort=true,
      A=data_OFFGAS.crossArea_drainTank_inner,
      level_start=0.20,
      showName=systemTF.showName,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-308,-56},{-288,-36}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fromDrainTank(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-268,-52})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_drainTank(redeclare
        package Medium =                                                                   Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-248,-62},{-228,-42}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_bypass(use_input=true, redeclare
        package Medium =
                 Medium_OffGas) annotation (Placement(transformation(extent={{-278,28},{-258,48}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_adsorberBed(use_input=true, redeclare
        package Medium = Medium_OffGas)
      annotation (Placement(transformation(extent={{-248,-22},{-228,-2}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_bypass(y=boundary_OffGas_m_flow.y -
          m_flow_OffGas_adsorberBed.y)
      annotation (Placement(transformation(extent={{-300,38},{-280,58}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_adsorberBed(y=data_OFFGAS.frac_gasSplit*
          boundary_OffGas_m_flow.y)
      annotation (Placement(transformation(extent={{-212,-2},{-232,18}})));
    TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(
      iSep=iSep,
      iCar=iSep,
      m_flow_sepFluid=m_flow_toDrainTank,
      redeclare package Medium = Medium_PFL,
      redeclare package Medium_carrier = Medium_OffGas,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-318,98})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_bypass(redeclare package
                Medium =                                                                Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-286,110},{-306,130}})));
    Modelica.Blocks.Sources.RealExpression m_flow_pump_bypass(y=x_bypass.y*abs(pump_PFL.port_a.m_flow))
      annotation (Placement(transformation(extent={{-326,124},{-306,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_fromPump_PFL_bypass_p(y=pumpBowl_PFL.p)
      annotation (Placement(transformation(extent={{-190,36},{-210,56}})));
    TRANSFORM.Examples.MoltenSaltReactor.Components.DRACS DRACS(
      redeclare package Medium_DRACS = Medium_DRACS,
      showName=systemTF.showName,
      surfaceAreas_thimble=DRACS.thimble_outer_drainTank.surfaceArea_outer*DRACS.nP_outer_drainTank[1].nParallel
          *{drainTank_liquid.level/data_OFFGAS.length_drainTank_inner,1 - drainTank_liquid.level/
          data_OFFGAS.length_drainTank_inner},
      alphas_drainTank={5000,1000})
      annotation (Placement(transformation(extent={{-402,-88},{-332,-8}})));
    Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{-4.44089e-16,
            105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{3.33067e-16,96}}, color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
    connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
      annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},{160,-140},
            {-4.44089e-16,-140},{-4.44089e-16,-136}}, color={0,127,255}));
    connect(PHX.port_b_shell, pipeFromPHX_PCL.port_a)
      annotation (Line(points={{164.6,10},{164,10},{164,40},{180,40}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b, pumpBowl_PCL.port_a)
      annotation (Line(points={{200,40},{213,40}}, color={0,127,255}));
    connect(pumpBowl_PCL.port_b, pump_PCL.port_a)
      annotation (Line(points={{227,40},{240,40}}, color={0,127,255}));
    connect(pump_PCL.port_b, pipeToSHX_PCL.port_a)
      annotation (Line(points={{260,40},{270,40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_a, SHX.port_b_shell)
      annotation (Line(points={{240,-40},{295.4,-40},{295.4,-10}}, color={0,127,255}));
    connect(pipeToSHX_PCL.port_b, SHX.port_a_shell)
      annotation (Line(points={{290,40},{295.4,40},{295.4,10}}, color={0,127,255}));
    connect(boundary1.ports[1], SHX.port_b_tube)
      annotation (Line(points={{320,40},{300,40},{300,10}}, color={0,127,255}));
    connect(SHX.port_a_tube, boundary4.ports[1])
      annotation (Line(points={{300,-10},{300,-40},{320,-40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_b, PHX.port_a_shell)
      annotation (Line(points={{220,-40},{164.6,-40},{164.6,-10}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(m_flow_pump_PFL.y, pump_PFL.in_m_flow)
      annotation (Line(points={{55,142},{50,142},{50,135.3}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(boundary_OffGas_T.y, boundary_OffGas_source.T_in)
      annotation (Line(points={{-377,120},{-360,120}}, color={0,0,127}));
    connect(boundary_OffGas_m_flow.y, boundary_OffGas_source.m_flow_in)
      annotation (Line(points={{-377,134},{-368,134},{-368,124},{-358,124}}, color={0,0,127}));
    connect(boundary_thermal_adsorberBed.port, adsorberBed.heatPorts)
      annotation (Line(points={{-268,8},{-268,-7}}, color={191,0,0}));
    connect(drainTank_liquid.port_b, resistance_fromDrainTank.port_a)
      annotation (Line(points={{-291,-52},{-275,-52}}, color={0,127,255}));
    connect(resistance_fromDrainTank.port_b, pump_drainTank.port_a)
      annotation (Line(points={{-261,-52},{-248,-52}}, color={0,127,255}));
    connect(adsorberBed.port_b, pump_OffGas_adsorberBed.port_a)
      annotation (Line(points={{-258,-12},{-248,-12}}, color={0,127,255}));
    connect(m_flow_OffGas_bypass.y, pump_OffGas_bypass.in_m_flow)
      annotation (Line(points={{-279,48},{-268,48},{-268,45.3}}, color={0,0,127}));
    connect(m_flow_OffGas_adsorberBed.y, pump_OffGas_adsorberBed.in_m_flow)
      annotation (Line(points={{-233,8},{-238,8},{-238,-4.7}}, color={0,0,127}));
    connect(boundary_OffGas_source.ports[1], traceSeparator.port_a_carrier)
      annotation (Line(points={{-338,116},{-324,116},{-324,108}}, color={0,127,255}));
    connect(m_flow_pump_bypass.y, pump_bypass.in_m_flow)
      annotation (Line(points={{-305,134},{-296,134},{-296,127.3}}, color={0,0,127}));
    connect(adsorberBed.port_a, drainTank_gas.port_b[1])
      annotation (Line(points={{-278,-12},{-286,-12},{-286,-11.75},{-292,
            -11.75}},                                                            color={0,127,255}));
    connect(pump_bypass.port_b, traceSeparator.port_a)
      annotation (Line(points={{-306,120},{-312,120},{-312,108}}, color={0,127,255}));
    connect(traceSeparator.port_sepFluid, drainTank_liquid.port_a)
      annotation (Line(points={{-318,88},{-318,-52},{-305,-52}}, color={0,127,255}));
    connect(traceSeparator.port_b_carrier, drainTank_gas.port_a[1])
      annotation (Line(points={{-324,88},{-324,-12},{-304,-12}}, color={0,127,255}));
    connect(pump_OffGas_bypass.port_a, drainTank_gas.port_b[2])
      annotation (Line(points={{-278,38},{-286,38},{-286,-12.25},{-292,-12.25}},
                                                                               color={0,127,255}));
    connect(pump_OffGas_bypass.port_b, boundary_OffGas_sink.ports[1])
      annotation (Line(points={{-258,38},{-248,38},{-248,37},{-238,37}}, color={0,127,255}));
    connect(pump_OffGas_adsorberBed.port_b, boundary_OffGas_sink.ports[2]) annotation (Line(points={{-228,
            -12},{-206,-12},{-206,24},{-246,24},{-246,39},{-238,39}}, color={0,127,255}));
    connect(boundary_fromPump_PFL_bypass_p.y, boundary_OffGas_sink.p_in)
      annotation (Line(points={{-211,46},{-216,46}}, color={0,0,127}));
    connect(traceSeparator.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-312,88},{-312,78},{-188,
            78},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_drainTank.port_b, pumpBowl_PFL.port_a)
      annotation (Line(points={{-228,-52},{-188,-52},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_bypass.port_a, pipeToPHX_PFL.port_a) annotation (Line(points={{-286,120},{-278,120},{-278,
            158},{160,158},{160,80}}, color={0,127,255}));
    connect(drainTank_liquid.heatPort, DRACS.port_thimbleWall[1])
      annotation (Line(points={{-298,-54.4},{-298,-73},{-332,-73}}, color={191,0,0}));
    connect(drainTank_gas.heatPort, DRACS.port_thimbleWall[2])
      annotation (Line(points={{-298,-6},{-298,0},{-308,0},{-308,-71},{-332,
            -71}},                                                                 color={191,0,0}));
    connect(boundary_OffGas_T1.y, pump_drainTank.in_m_flow)
      annotation (Line(points={{-249,-34},{-238,-34},{-238,-44.7}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=1825,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
  end MCA_Base_withBOP_sec;

  model PrimaryFuelLoop

      import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
        Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    //summary calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1
              [1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-36})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,24})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,54})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-96})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-6})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-126})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-66})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,76})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-62,-36})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(nPorts=
          fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-100,-46},{-80,-26}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-62,-6})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-62,-66})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-62,24})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
          reflA_upperG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-62,54})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
          reflA_upperG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-62,-6})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-62,-96})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
          reflA_lowerG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-62,-64})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
          reflA_lowerG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-62,-126})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-146})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-166})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_MSR.length_PHXToRCTR,
          dimension=data_MSR.D_PFL,
          dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={128,-106})));
    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_MSR.p_inlet_shell,
      T_a_start_shell=data_MSR.T_inlet_shell,
      T_b_start_shell=data_MSR.T_outlet_shell,
      p_a_start_tube=data_MSR.p_inlet_tube,
      T_a_start_tube=data_MSR.T_inlet_tube,
      T_b_start_tube=data_MSR.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer,
          S_T=data_MSR.pitch_tube,
          S_L=data_MSR.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_MSR.D_shell_inner,
          nTubes=data_MSR.nTubes,
          nR=3,
          length_shell=data_MSR.length_tube,
          th_wall=data_MSR.th_tube,
          dimension_tube=data_MSR.D_tube_inner,
          length_tube=data_MSR.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={128,-36})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 350,
      T_a_start=data_MSR.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PFL,
          length=data_MSR.length_pumpToPHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={128,34})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{8,82},{28,102}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube,
      level_start=data_MSR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_MSR.T_inlet_tube),
      A=3*data_MSR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-22,88},{-2,108}})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-12,-36})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={18,-36})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={18,-66})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(showName=
          systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{56,-46},{36,-26}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={18,-6})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-12,-66})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-12,-6})));
    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_MSR.m_flow_tube)
      annotation (Placement(transformation(extent={{44,96},{24,116}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i ==
          iPu then sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC +
          kinetics.reactivity.data.nC)}, redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{68,82},{88,102}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{68,54},{88,74}})));
  protected
    MoltenSaltReactor.Data.data_SHX     data_SHX
      annotation (Placement(transformation(extent={{240,62},{260,82}})));

     MoltenSaltReactor.Data.data_MSR     data_MSR
     annotation (Placement(transformation(extent={{200,56},{220,76}})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{210,82},{230,102}})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_MSR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_MSR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_MSR.T_inlet_tube,
      T_tube_outlet_PHX=data_MSR.T_outlet_tube,
      p_inlet_tube_PHX=data_MSR.p_inlet_tube,
      m_flow_tube_PHX=data_MSR.m_flow_tube,
      T_shell_inlet_PHX=data_MSR.T_inlet_shell,
      T_shell_outlet_PHX=data_MSR.T_outlet_shell,
      p_inlet_shell_PHX=data_MSR.p_inlet_shell,
      m_flow_shell_PHX=data_MSR.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_MSR.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_MSR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_MSR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{180,82},{200,102}})));

    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_MSR.T_inlet_tube,
      val_min=data_MSR.T_inlet_shell)
      annotation (Placement(transformation(extent={{162,46},{182,66}})));
    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-130,-32},{-110,-12}})));

  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.Q_nominal,
      k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-140,12},
              {-120,32}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-196,20},{-176,40}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-192,-4},{-172,16}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.T_inlet_tube,
      k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-138,
              -62},{-118,-42}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
      annotation (Placement(transformation(extent={{-194,-54},{-174,-34}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-190,-78},{-170,-58}})));

        //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
   // constant String actinide[:]={"u-235","u-238"};
   // constant Integer nA=size(i_mCs_start_salt, 1);
  //  constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
  //  constant Real Ufrac = 0.01;
  //  constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
  //  constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
  //  constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

  //  constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:nA};

   //   constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
   //   constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A for i in 1:nA};
  public
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b1
      annotation (Placement(transformation(extent={{-672,-48},{-652,-28}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(redeclare package
                Medium =
                 TRANSFORM.Media.Fluids.FLiBe.ConstantPropertyLiquidFLiBe, nPorts
        =1)
      annotation (Placement(transformation(extent={{194,-74},{174,-54}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.FLiBe.ConstantPropertyLiquidFLiBe,
        nPorts=1)
      annotation (Placement(transformation(extent={{192,-22},{172,-2}})));
  equation
    connect(reflA_upper.port_a,resistance_fuelCell_outlet. port_b)
      annotation (Line(points={{-32,14},{-32,1}},
                                               color={0,127,255}));
    connect(plenum_lower.port_b[1],reflA_lower. port_a) annotation (Line(points={{-32,
            -120},{-32,-106}},        color={0,127,255}));
    connect(reflA_lower.port_b,resistance_fuelCell_inlet. port_a)
      annotation (Line(points={{-32,-86},{-32,-73}},
                                                 color={0,127,255}));
    connect(reflA_upper.port_b,plenum_upper. port_a[1])
      annotation (Line(points={{-32,34},{-32,48}},
                                               color={0,127,255}));
    connect(resistance_toPump_PFL.port_a,plenum_upper. port_b[1]) annotation (Line(points={{-32,69},
            {-32,60}},                                                       color={0,127,255}));
    connect(fuelCellG.port_a1,fuelCell. heatPorts[:, 1])
      annotation (Line(points={{-52,-36},{-37,-36}},
                                                color={191,0,0}));
    connect(fuelCellG_centerline_bc.port,fuelCellG. port_b1)
      annotation (Line(points={{-80,-36},{-72,-36}},
                                                 color={191,0,0}));
    connect(fuelCellG_lower_bc.port,fuelCellG. port_a2)
      annotation (Line(points={{-62,-56},{-62,-46}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port,fuelCellG. port_b2)
      annotation (Line(points={{-62,-16},{-62,-26}},
                                                   color={191,0,0}));
    connect(reflA_upperG_lower_bc.port,reflA_upperG. port_a2)
      annotation (Line(points={{-62,4},{-62,14}},  color={191,0,0}));
    connect(reflA_upperG_upper_bc.port,reflA_upperG. port_b2)
      annotation (Line(points={{-62,44},{-62,34}}, color={191,0,0}));
    connect(reflA_upperG.port_a1,reflA_upper. heatPorts[:, 1])
      annotation (Line(points={{-52,24},{-37,24}},color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port,reflA_lowerG. port_a2)
      annotation (Line(points={{-62,-116},{-62,-106}},
                                                     color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port,reflA_lowerG. port_b2)
      annotation (Line(points={{-62,-74},{-62,-86}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1,reflA_lower. heatPorts[:, 1])
      annotation (Line(points={{-52,-96},{-37,-96}},color={191,0,0}));
    connect(reflA_upperG.port_b1,reflA_upper. heatPorts[:, 2]) annotation (Line(points={{-72,24},
            {-74,24},{-74,12},{-16,12},{-16,24},{-37,24}},
                                                 color={191,0,0}));
    connect(reflA_lowerG.port_b1,reflA_lower. heatPorts[:, 2]) annotation (Line(points={{-72,-96},
            {-74,-96},{-74,-108},{-16,-108},{-16,-96},{-37,-96}},
                                                          color={191,0,0}));
    connect(plenum_lower.port_a[1],resistance_teeTOplenum. port_b)
      annotation (Line(points={{-32,-132},{-32,-139}},
                                                  color={0,127,255}));
    connect(resistance_teeTOplenum.port_a,tee_inlet. port_b[1])
      annotation (Line(points={{-32,-153},{-32,-160}},
                                                   color={0,127,255}));
    connect(pipeToPHX_PFL.port_b,PHX. port_a_tube)
      annotation (Line(points={{128,24},{128,-26}},color={0,127,255}));
    connect(pump_PFL.port_a,pumpBowl_PFL. port_b)
      annotation (Line(points={{8,92},{-5,92}},                      color={0,127,255}));
    connect(pumpBowl_PFL.port_a,resistance_toPump_PFL. port_b)
      annotation (Line(points={{-19,92},{-32,92},{-32,83}},
                                                          color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a,PHX. port_b_tube)
      annotation (Line(points={{128,-96},{128,-46}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b,tee_inlet. port_a[1]) annotation (Line(points={{128,
            -116},{128,-182},{-32,-182},{-32,-172}},  color={0,127,255}));
    connect(resistance_reflR_outlet.port_b,reflA_upper. port_a)
      annotation (Line(points={{-12,1},{-12,14},{-32,14}},     color={0,127,255}));
    connect(reflR.port_a,resistance_reflR_inlet. port_b)
      annotation (Line(points={{-12,-46},{-12,-59}},
                                                   color={0,127,255}));
    connect(resistance_reflR_inlet.port_a,reflA_lower. port_b)
      annotation (Line(points={{-12,-73},{-12,-86},{-32,-86}},     color={0,127,255}));
    connect(resistance_reflR_outlet.port_a,reflR. port_b)
      annotation (Line(points={{-12,-13},{-12,-26}},
                                                 color={0,127,255}));
    connect(reflRG.port_a1,reflR. heatPorts[:, 1])
      annotation (Line(points={{8,-36},{-7,-36}},
                                               color={191,0,0}));
    connect(reflRG.port_a2,reflRG_lower_bc. port)
      annotation (Line(points={{18,-46},{18,-56}}, color={191,0,0}));
    connect(reflRG.port_b1,reflRG_centerline_bc. port)
      annotation (Line(points={{28,-36},{36,-36}},
                                               color={191,0,0}));
    connect(reflRG.port_b2,reflRG_upper_bc. port)
      annotation (Line(points={{18,-26},{18,-16}},
                                                 color={191,0,0}));
    connect(m_flow_pump_PFL.y,pump_PFL. in_m_flow)
      annotation (Line(points={{23,106},{18,106},{18,99.3}},  color={0,0,127}));
    connect(pump_PFL.port_b,simpleSeparator. port_a)
      annotation (Line(points={{28,92},{28,76},{62,76},{62,92},{68,92}},
                                                    color={0,127,255}));
    connect(simpleSeparator.port_b,pipeToPHX_PFL. port_a)
      annotation (Line(points={{88,92},{128,92},{128,44}},    color={0,127,255}));
    connect(realExpression.y,PID. u_s)
      annotation (Line(points={{-175,30},{-150,30},{-150,22},{-142,22}}, color={0,0,127}));
    connect(realExpression1.y,PID. u_m)
      annotation (Line(points={{-171,6},{-138,6},{-138,2},{-130,2},{-130,10}}, color={0,0,127}));
    connect(realExpression2.y,PID2. u_s)
      annotation (Line(points={{-173,-44},{-148,-44},{-148,-52},{-140,-52}}, color={0,0,127}));
    connect(realExpression3.y,PID2. u_m)
      annotation (Line(points={{-169,-68},{-136,-68},{-136,-72},{-128,-72},{-128,-64}},
                                                                                    color={0,0,127}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{-32,-59},{-32,-46}}, color={0,127,255}));
    connect(fuelCell.port_b, resistance_fuelCell_outlet.port_a)
      annotation (Line(points={{-32,-26},{-32,-13}}, color={0,127,255}));
    connect(PHX.port_b_shell, boundary1.ports[1]) annotation (Line(points={{132.6,
            -26},{132.6,-12},{172,-12}}, color={0,127,255}));
    connect(PHX.port_a_shell, boundary.ports[1]) annotation (Line(points={{132.6,-46},
            {132.6,-64},{174,-64}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PrimaryFuelLoop;

  model Reactor
  protected
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1
              [1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-60})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel
              /reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[
              end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,0})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,30})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel
              /reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[
              end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-120})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-30})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-150})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,52})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-46,-60})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(nPorts=
          fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-84,-70},{-64,-50}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-46,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-46,-90})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-46,0})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
          reflA_upperG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-46,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
          reflA_upperG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-46,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-46,-120})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
          reflA_lowerG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-46,-88})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
          reflA_lowerG.geometry.nR, showName=systemTF.showName)
                                                               annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-46,-150})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-170})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,-190})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{24,58},{
              44,78}})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={4,-60})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={34,-60})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={34,-90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(showName=
          systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{72,-70},{52,-50}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={34,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={4,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={4,-30})));
    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-106,-70},{-86,-50}})));

  equation
    connect(resistance_fuelCell_outlet.port_a,fuelCell. port_b)
      annotation (Line(points={{-16,-37},{-16,-50},{-16,-50}},  color={0,127,255}));
    connect(reflA_upper.port_a,resistance_fuelCell_outlet. port_b)
      annotation (Line(points={{-16,-10},{-16,-23}},
                                               color={0,127,255}));
    connect(plenum_lower.port_b[1],reflA_lower. port_a) annotation (Line(points={{-16,
            -144},{-16,-130},{-16,-130}},
                                      color={0,127,255}));
    connect(reflA_lower.port_b,resistance_fuelCell_inlet. port_a)
      annotation (Line(points={{-16,-110},{-16,-97}},
                                                 color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b,fuelCell. port_a)
      annotation (Line(points={{-16,-83},{-16,-70}},
                                                 color={0,127,255}));
    connect(reflA_upper.port_b,plenum_upper. port_a[1])
      annotation (Line(points={{-16,10},{-16,24}},
                                               color={0,127,255}));
    connect(resistance_toPump_PFL.port_a,plenum_upper. port_b[1]) annotation (Line(points={{-16,45},
            {-16,40.5},{-16,40.5},{-16,36}},                                 color={0,127,255}));
    connect(fuelCellG.port_a1,fuelCell. heatPorts[:, 1])
      annotation (Line(points={{-36,-60},{-21,-60}},
                                                color={191,0,0}));
    connect(fuelCellG_centerline_bc.port,fuelCellG. port_b1)
      annotation (Line(points={{-64,-60},{-56,-60}},
                                                 color={191,0,0}));
    connect(fuelCellG_lower_bc.port,fuelCellG. port_a2)
      annotation (Line(points={{-46,-80},{-46,-70}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port,fuelCellG. port_b2)
      annotation (Line(points={{-46,-40},{-46,-50}},
                                                   color={191,0,0}));
    connect(reflA_upperG_lower_bc.port,reflA_upperG. port_a2)
      annotation (Line(points={{-46,-20},{-46,-10}},
                                                   color={191,0,0}));
    connect(reflA_upperG_upper_bc.port,reflA_upperG. port_b2)
      annotation (Line(points={{-46,20},{-46,10}}, color={191,0,0}));
    connect(reflA_upperG.port_a1,reflA_upper. heatPorts[:, 1])
      annotation (Line(points={{-36,0},{-21,0}},  color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port,reflA_lowerG. port_a2)
      annotation (Line(points={{-46,-140},{-46,-130}},
                                                     color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port,reflA_lowerG. port_b2)
      annotation (Line(points={{-46,-98},{-46,-110}},color={191,0,0}));
    connect(reflA_lowerG.port_a1,reflA_lower. heatPorts[:, 1])
      annotation (Line(points={{-36,-120},{-21,-120}},
                                                    color={191,0,0}));
    connect(reflA_upperG.port_b1,reflA_upper. heatPorts[:, 2]) annotation (Line(points={{-56,0},
            {-60,0},{-60,4},{-28,4},{-28,0},{-21,0}},
                                                 color={191,0,0}));
    connect(reflA_lowerG.port_b1,reflA_lower. heatPorts[:, 2]) annotation (Line(points={{-56,
            -120},{-60,-120},{-60,-116},{-28,-116},{-28,-120},{-21,-120}},
                                                          color={191,0,0}));
    connect(plenum_lower.port_a[1],resistance_teeTOplenum. port_b)
      annotation (Line(points={{-16,-156},{-16,-163}},
                                                  color={0,127,255}));
    connect(resistance_teeTOplenum.port_a,tee_inlet. port_b[1])
      annotation (Line(points={{-16,-177},{-16,-184}},
                                                   color={0,127,255}));
    connect(pumpBowl_PFL.port_a,resistance_toPump_PFL. port_b)
      annotation (Line(points={{-3,68},{-16,68},{-16,59}},color={0,127,255}));
    connect(resistance_reflR_outlet.port_b,reflA_upper. port_a)
      annotation (Line(points={{4,-23},{4,-18},{-16,-18},{-16,-10}},
                                                               color={0,127,255}));
    connect(reflR.port_a,resistance_reflR_inlet. port_b)
      annotation (Line(points={{4,-70},{4,-83}},   color={0,127,255}));
    connect(resistance_reflR_inlet.port_a,reflA_lower. port_b)
      annotation (Line(points={{4,-97},{4,-106},{-16,-106},{-16,-110}},
                                                                   color={0,127,255}));
    connect(resistance_reflR_outlet.port_a,reflR. port_b)
      annotation (Line(points={{4,-37},{4,-50}}, color={0,127,255}));
    connect(reflRG.port_a1,reflR. heatPorts[:, 1])
      annotation (Line(points={{24,-60},{9,-60}},
                                               color={191,0,0}));
    connect(reflRG.port_a2,reflRG_lower_bc. port)
      annotation (Line(points={{34,-70},{34,-80}}, color={191,0,0}));
    connect(reflRG.port_b1,reflRG_centerline_bc. port)
      annotation (Line(points={{44,-60},{52,-60}},
                                               color={191,0,0}));
    connect(reflRG.port_b2,reflRG_upper_bc. port)
      annotation (Line(points={{34,-50},{34,-40}},
                                                 color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Reactor;

  model PrimaryFuelLoop1

    extends TRANSFORM.Icons.Example;

    import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
        Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu=kinetics.data.nC + Functions.FindIndexOfMatch(           20094239, kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
        30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
        30054137};
  public
    parameter Integer iSep[:]={kinetics.data.nC + Functions.FindIndexOfMatch(           i, kinetics.reactivity.data.SIZZZAAA)
        for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR    annotation (Placement(transformation(extent={{290,100},{310,120}})));
   // MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{260,100},{280,120}})));
  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{320,120},{340,140}})));
  protected
    MSR.MoltenSaltReactor.Data.data_SHX data_SHX
      annotation (Placement(transformation(extent={{320,100},{340,120}})));
  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{260,80},{280,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-28})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_MSR.length_PHXToRCTR,
          dimension=data_MSR.D_PFL,
          dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_MSR.p_inlet_shell,
      T_a_start_shell=data_MSR.T_inlet_shell,
      T_b_start_shell=data_MSR.T_outlet_shell,
      p_a_start_tube=data_MSR.p_inlet_tube,
      T_a_start_tube=data_MSR.T_inlet_tube,
      T_b_start_tube=data_MSR.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer,
          S_T=data_MSR.pitch_tube,
          S_L=data_MSR.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_MSR.D_shell_inner,
          nTubes=data_MSR.nTubes,
          nR=3,
          length_shell=data_MSR.length_tube,
          th_wall=data_MSR.th_tube,
          dimension_tube=data_MSR.D_tube_inner,
          length_tube=data_MSR.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 350,
      T_a_start=data_MSR.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PFL,
          length=data_MSR.length_pumpToPHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube,
      level_start=data_MSR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_MSR.T_inlet_tube),
      A=3*data_MSR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_MSR.T_inlet_tube,
      val_min=data_MSR.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{290,120},{310,140}})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_MSR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_MSR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_MSR.T_inlet_tube,
      T_tube_outlet_PHX=data_MSR.T_outlet_tube,
      p_inlet_tube_PHX=data_MSR.p_inlet_tube,
      m_flow_tube_PHX=data_MSR.m_flow_tube,
      T_shell_inlet_PHX=data_MSR.T_inlet_shell,
      T_shell_outlet_PHX=data_MSR.T_outlet_shell,
      p_inlet_shell_PHX=data_MSR.p_inlet_shell,
      m_flow_shell_PHX=data_MSR.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_MSR.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_MSR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_MSR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{260,120},{280,140}})));

    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_MSR.m_flow_tube)
      annotation (Placement(transformation(extent={{76,132},{56,152}})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

    //////////
    //    //Comment/Uncomment as a block - BIG DATA - 2b
    //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //
    //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
    //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
    //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
    //              19.43194,99.693068,185.13937};
    //
    //          constant Integer i_mCs_start_salt[:]={1009,1013};
    //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

    //Comment/Uncomment as a block - BIG DATA - 2b
    //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //     constant Integer i_mCs_start_salt[:]={1009,1013};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
    constant String actinide[:]={"u-235","u-238"};
    constant Integer nA=size(i_mCs_start_salt, 1);
    constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
    constant Real Ufrac = 0.01;
    constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
    constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
    constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

    constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
        nA};

      constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
      constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
          for i in 1:nA};

  //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
  //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
  //        for i in 1:nA};

    //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
    //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
    //       record Data_ISO =
    //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
    //
    //       constant Integer i_mCs_start_salt[:]={4};
    //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=Functions.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

  parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

    //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
    //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
    //
    //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
    //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

    //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
    //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

    // atoms per node

  public
    SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
    SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_upper.mCs;
    SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_lower.mCs;
    SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
       pipeFromPHX_PFL.mCs;
    SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
    SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        pipeToPHX_PFL.mCs;
    SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

    // atoms component total
    SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=
        drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
        :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
        :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
        reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

    // atoms total
    SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
        mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
        mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] + mCs_fuelCell_total[i] +
        mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
        mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
         + kinetics.reactivity.data.nC};

    // nParallel
    Real plenum_upper_nParallel=1;
    Real plenum_lower_nParallel=1;
    Real tee_inlet_nParallel=1;
    Real pumpBowl_PFL_nParallel=1;
    Real drainTank_gas_nParallel=1;
    Real drainTank_liquid_nParallel=1;
    Real fuelCell_nParallel=fuelCell.nParallel;
    Real reflA_upper_nParallel=reflA_upper.nParallel;
    Real reflA_lower_nParallel=reflA_lower.nParallel;
    Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
    Real PHX_tube_nParallel=PHX.tube.nParallel;
    Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
    Real reflR_nParallel=reflR.nParallel;

    // mass per node
    SI.Mass plenum_upper_m=plenum_upper.m;
    SI.Mass plenum_lower_m=plenum_lower.m;
    SI.Mass tee_inlet_m=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m=drainTank_liquid.m;
    SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
    SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
    SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
    SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
    SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
    SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
    SI.Mass reflR_m[reflR.nV]=reflR.ms;

    // mass component total
    SI.Mass plenum_upper_m_total=plenum_upper.m;
    SI.Mass plenum_lower_m_total=plenum_lower.m;
    SI.Mass tee_inlet_m_total=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
    SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
    SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
    SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
    SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
    SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
    SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
    SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

    // mass total
    SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
        pumpBowl_PFL_m_total + drainTank_liquid_m_total + fuelCell_m_total +
        reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
        pipeToPHX_PFL_m_total + reflR_m_total;

    // volume nodal
    SI.Volume plenum_upper_V=plenum_upper.V;
    SI.Volume plenum_lower_V=plenum_lower.V;
    SI.Volume tee_inlet_V=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
    SI.Volume drainTank_liquid_V=drainTank_liquid.V;
    SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
    SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
    SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
    SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
    SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
    SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
    SI.Volume reflR_V[reflR.nV]=reflR.Vs;

    // volume component total
    SI.Volume plenum_upper_V_total=plenum_upper.V;
    SI.Volume plenum_lower_V_total=plenum_lower.V;
    SI.Volume tee_inlet_V_total=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
    SI.Volume drainTank_gas_V_total=drainTank_gas.V;
    SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
    SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
    SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
    SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
    SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
    SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
    SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
    SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

    // volume total
    SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
        pumpBowl_PFL_V_total + drainTank_liquid_V_total + fuelCell_V_total +
        reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
        pipeToPHX_PFL_V_total + reflR_V_total;

    // nV
    Integer fuelCell_nV=fuelCell.nV;
    Integer reflA_upper_nV=reflA_upper.nV;
    Integer reflA_lower_nV=reflA_lower.nV;
    Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
    Integer PHX_tube_nV=PHX.tube.nV;
    Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
    Integer reflR_nV=reflR.nV;

    // lengths
    SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
    SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
    SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
    SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
    SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
    SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
    SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

    // dimensions
    SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
    SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
    SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
    SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
    SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
    SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
    SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

    MoltenSaltReactor.Data.data_MSR data_MSR
      annotation (Placement(transformation(extent={{264,-128},{284,-108}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a
      annotation (Placement(transformation(extent={{258,-52},{278,-32}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b
      annotation (Placement(transformation(extent={{248,6},{268,26}})));
  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.Q_nominal,
      k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.T_inlet_tube,
      k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{-4.44089e-16,
            105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{3.33067e-16,96}}, color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
    connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
      annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},{160,-140},
            {-4.44089e-16,-140},{-4.44089e-16,-136}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(m_flow_pump_PFL.y, pump_PFL.in_m_flow)
      annotation (Line(points={{55,142},{50,142},{50,135.3}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
    connect(PHX.port_a_shell, port_a) annotation (Line(points={{164.6,-10},{
            164.6,-24},{268,-24},{268,-42}}, color={0,127,255}));
    connect(PHX.port_b_shell, port_b) annotation (Line(points={{164.6,10},{
            164.6,16},{258,16}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=1825,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
  end PrimaryFuelLoop1;

  model ConnectToBOP
    MCA_Base_withBOP_sec_2 mCA_Base_withBOP_sec_2_1
      annotation (Placement(transformation(extent={{-70,-12},{-50,8}})));
    MoltenSaltReactor.Components.BOP3 bOP3_1
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-12,4},{8,24}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-10,-34},{10,-14}})));
  equation
    connect(mCA_Base_withBOP_sec_2_1.port_b, bOP3_1.port_b) annotation (Line(
          points={{-24.8,1.4},{-24.8,4},{20,4}}, color={0,127,255}));
    connect(mCA_Base_withBOP_sec_2_1.port_a, bOP3_1.port_a) annotation (Line(
          points={{-24.2,-5.2},{-24.2,-4},{20,-4}}, color={0,127,255}));
    connect(mCA_Base_withBOP_sec_2_1.port_b, sensor_T.port) annotation (Line(
          points={{-24.8,1.4},{-24.8,4},{-2,4}}, color={0,127,255}));
    connect(sensor_T1.port, bOP3_1.port_a)
      annotation (Line(points={{0,-34},{0,-4},{20,-4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
  end ConnectToBOP;

  model MCA_Base_withBOP_sec_2

  //  extends TRANSFORM.Icons.Example;

    import TRANSFORM;

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
        Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu=kinetics.data.nC + Functions.FindIndexOfMatch(           20094239, kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
        30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
        30054137};
  public
    parameter Integer iSep[:]={kinetics.data.nC + Functions.FindIndexOfMatch(           i, kinetics.reactivity.data.SIZZZAAA)
        for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR    annotation (Placement(transformation(extent={{290,100},{310,120}})));
   // MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{260,100},{280,120}})));
   //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{320,120},{340,140}})));
  //  MSR.MoltenSaltReactor.Data.data_MSR data_MSR annotation (Placement(transformation(extent={{260,80},{280,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Components.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel/
              reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    Components.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    Components.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel/
              reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    Components.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-28})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    Components.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    Components.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_MSR.length_PHXToRCTR,
          dimension=data_MSR.D_PFL,
          dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    Components.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_MSR.p_inlet_shell,
      T_a_start_shell=data_MSR.T_inlet_shell,
      T_b_start_shell=data_MSR.T_outlet_shell,
      p_a_start_tube=data_MSR.p_inlet_tube,
      T_a_start_tube=data_MSR.T_inlet_tube,
      T_b_start_tube=data_MSR.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer,
          S_T=data_MSR.pitch_tube,
          S_L=data_MSR.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_MSR.D_shell_inner,
          nTubes=data_MSR.nTubes,
          nR=3,
          length_shell=data_MSR.length_tube,
          th_wall=data_MSR.th_tube,
          dimension_tube=data_MSR.D_tube_inner,
          length_tube=data_MSR.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    Components.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 350,
      T_a_start=data_MSR.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PFL,
          length=data_MSR.length_pumpToPHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    Components.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube,
      level_start=data_MSR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_MSR.T_inlet_tube),
      A=3*data_MSR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_MSR.T_inlet_tube,
      val_min=data_MSR.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_MSR.p_inlet_shell - 50,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_PHXsToPump,
          dheight=toggleStaticHead*data_MSR.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={190,40})));
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_MSR.level_pumpbowlnominal,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      A=3*data_MSR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start, data_MSR.T_outlet_shell))
      annotation (Placement(transformation(extent={{210,36},{230,56}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_MSR.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{240,30},{260,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_pumpToSHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={280,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 50,
      T_a_start=data_MSR.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_SHXToPHX,
          dheight=toggleStaticHead*data_MSR.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={230,-40})));

    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{290,120},{310,140}})));
    Components.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      nG_fuelCell=fuelCellG.nParallel,
      dims_fuelG_1=fuelCellG.geometry.length_x,
      dims_fuelG_2=fuelCellG.geometry.length_z,
      dims_fuelG_3=fuelCellG.geometry.length_y,
      nG_reflA_blocks=reflA_upperG.nParallel,
      dims_reflAG_1=reflA_upperG.geometry.r_inner,
      dims_reflAG_2=reflA_upperG.geometry.r_outer,
      dims_reflAG_3=reflA_upperG.geometry.length_z,
      dims_reflAG_4=reflA_upperG.geometry.angle_theta,
      nG_reflR_blocks=reflRG.nParallel,
      dims_reflRG_1=reflRG.geometry.length_x,
      dims_reflRG_2=reflRG.geometry.length_z,
      dims_reflRG_3=reflRG.geometry.length_y,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
      m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
      m_reflRG=reflRG.nParallel*sum(reflRG.ms),
      m_reflR=reflR.nParallel*sum(reflR.ms),
      crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
      perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
      crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
      perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
      crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
      perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
      surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
      surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
      surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
      m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
      m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
      m_plenum=plenum_upper.m,
      dims_pumpBowl_2=data_MSR.length_pumpbowl,
      dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
      dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
      m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
      dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
      dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
      m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
      dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
      m_pumpBowl=pumpBowl_PFL.m/3,
      level_nom_pumpBowl=data_MSR.level_pumpbowlnominal,
      T_tube_inlet_PHX=data_MSR.T_inlet_tube,
      T_tube_outlet_PHX=data_MSR.T_outlet_tube,
      p_inlet_tube_PHX=data_MSR.p_inlet_tube,
      m_flow_tube_PHX=data_MSR.m_flow_tube,
      T_shell_inlet_PHX=data_MSR.T_inlet_shell,
      T_shell_outlet_PHX=data_MSR.T_outlet_shell,
      p_inlet_shell_PHX=data_MSR.p_inlet_shell,
      m_flow_shell_PHX=data_MSR.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_MSR.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      m_tee_inlet=tee_inlet.m,
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_MSR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_MSR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
      alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
      alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV)
          annotation (Placement(transformation(extent={{260,120},{280,140}})));
     // m_shell_SHX=sum(SHX.shell.ms),
     // alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
     //    alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
     // T_tube_inlet_SHX=data_MSR.T_inlet_tube,
     // T_tube_outlet_SHX=data_MSR.T_outlet_tube,
     // p_inlet_tube_SHX=data_MSR.p_inlet_tube,
     // dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
     // m_flow_tube_SHX=data_MSR.m_flow_tube,
     // T_shell_inlet_SHX=data_MSR.T_inlet_shell,
     // T_shell_outlet_SHX=data_MSR.T_outlet_shell,
     // p_inlet_shell_SHX=data_MSR.p_inlet_shell,
    //  dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
    //  m_flow_shell_SHX=data_MSR.m_flow_shell,
    //  nTubes_SHX=SHX.geometry.nTubes,
    //  diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
    //  th_tube_SHX=SHX.geometry.th_wall,
    //  length_tube_SHX=SHX.geometry.length_tube,
    //  tube_pitch_SHX=data_MSR.pitch_tube,
   //   surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
   //   m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
   //   crossArea_shell_SHX=SHX.geometry.crossArea_shell,
   //   perimeter_shell_SHX=SHX.geometry.perimeter_shell,
   //   surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],

    Modelica.Blocks.Sources.RealExpression m_flow_pump_PFL(y=2*3*data_MSR.m_flow_tube)
      annotation (Placement(transformation(extent={{76,132},{56,152}})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=0.003370 - 0.00133511,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

    //////////
    //    //Comment/Uncomment as a block - BIG DATA - 2b
    //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //
    //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
    //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
    //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
    //              19.43194,99.693068,185.13937};
    //
    //          constant Integer i_mCs_start_salt[:]={1009,1013};
    //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

    //Comment/Uncomment as a block - BIG DATA - 2b
    //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //     constant Integer i_mCs_start_salt[:]={1009,1013};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
    constant String actinide[:]={"u-235","u-238"};
    constant Integer nA=size(i_mCs_start_salt, 1);
    constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
    constant Real Ufrac = 0.01;
    constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
    constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
    constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

    constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
        nA};

      constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
      constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
          for i in 1:nA};

  //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
  //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
  //        for i in 1:nA};

    //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
    //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
    //       record Data_ISO =
    //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
    //
    //       constant Integer i_mCs_start_salt[:]={4};
    //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=Functions.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

  parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

  protected
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T1(y=drainTank_liquid.port_a.m_flow)
      annotation (Placement(transformation(extent={{-270,-44},{-250,-24}})));
    //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
    //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
    //
    //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
    //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

    //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
    //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

    // atoms per node

  public
    SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
    SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_upper.mCs;
    SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_lower.mCs;
    SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
       pipeFromPHX_PFL.mCs;
    SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
    SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        pipeToPHX_PFL.mCs;
    SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

    // atoms component total
    SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=
        drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
        :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
        :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
        reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

    // atoms total
    SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
        mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
        mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] + mCs_fuelCell_total[i] +
        mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
        mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
         + kinetics.reactivity.data.nC};

    // nParallel
    Real plenum_upper_nParallel=1;
    Real plenum_lower_nParallel=1;
    Real tee_inlet_nParallel=1;
    Real pumpBowl_PFL_nParallel=1;
    Real drainTank_gas_nParallel=1;
    Real drainTank_liquid_nParallel=1;
    Real fuelCell_nParallel=fuelCell.nParallel;
    Real reflA_upper_nParallel=reflA_upper.nParallel;
    Real reflA_lower_nParallel=reflA_lower.nParallel;
    Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
    Real PHX_tube_nParallel=PHX.tube.nParallel;
    Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
    Real reflR_nParallel=reflR.nParallel;

    // mass per node
    SI.Mass plenum_upper_m=plenum_upper.m;
    SI.Mass plenum_lower_m=plenum_lower.m;
    SI.Mass tee_inlet_m=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m=drainTank_liquid.m;
    SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
    SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
    SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
    SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
    SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
    SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
    SI.Mass reflR_m[reflR.nV]=reflR.ms;

    // mass component total
    SI.Mass plenum_upper_m_total=plenum_upper.m;
    SI.Mass plenum_lower_m_total=plenum_lower.m;
    SI.Mass tee_inlet_m_total=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
    SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
    SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
    SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
    SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
    SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
    SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
    SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

    // mass total
    SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
        pumpBowl_PFL_m_total + drainTank_liquid_m_total + fuelCell_m_total +
        reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
        pipeToPHX_PFL_m_total + reflR_m_total;

    // volume nodal
    SI.Volume plenum_upper_V=plenum_upper.V;
    SI.Volume plenum_lower_V=plenum_lower.V;
    SI.Volume tee_inlet_V=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
    SI.Volume drainTank_liquid_V=drainTank_liquid.V;
    SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
    SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
    SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
    SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
    SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
    SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
    SI.Volume reflR_V[reflR.nV]=reflR.Vs;

    // volume component total
    SI.Volume plenum_upper_V_total=plenum_upper.V;
    SI.Volume plenum_lower_V_total=plenum_lower.V;
    SI.Volume tee_inlet_V_total=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
    SI.Volume drainTank_gas_V_total=drainTank_gas.V;
    SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
    SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
    SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
    SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
    SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
    SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
    SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
    SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

    // volume total
    SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
        pumpBowl_PFL_V_total + drainTank_liquid_V_total + fuelCell_V_total +
        reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
        pipeToPHX_PFL_V_total + reflR_V_total;

    // nV
    Integer fuelCell_nV=fuelCell.nV;
    Integer reflA_upper_nV=reflA_upper.nV;
    Integer reflA_lower_nV=reflA_lower.nV;
    Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
    Integer PHX_tube_nV=PHX.tube.nV;
    Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
    Integer reflR_nV=reflR.nV;

    // lengths
    SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
    SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
    SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
    SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
    SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
    SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
    SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

    // dimensions
    SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
    SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
    SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
    SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
    SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
    SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
    SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

    MoltenSaltReactor.Data.data_MSR data_MSR(
      nHX_total=6,
      nParallel=3,
      nHX_total_SHX=6,
      nParallel_SHX=3)
      annotation (Placement(transformation(extent={{266,-128},{286,-108}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{348,-42},{368,-22}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{342,24},{362,44}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
      NTU=4,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium = Medium_BOP,
      redeclare package Shell_medium = Medium_PCL,
      V_Tube=0.1,
      V_Shell=0.1,
      dh_Tube=0.0,
      dh_Shell=0.0,
      p_start_tube=12000000,
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=788.15,
      p_start_shell=1820000,
      use_T_start_shell=true,
      T_start_shell_inlet=866.483,
      T_start_shell_outlet=755.372,
      dp_init_tube=0,
      dp_init_shell=1000,
      dp_general=100,
      Q_init=0,
      Cr_init=0.0,
      m_start_tube=200,
      m_start_shell=2797.15)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={312,0})));
  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.Q_nominal,
      k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.T_inlet_tube,
      k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_OffGas_sink(
      redeclare package Medium = Medium_OffGas,
      nPorts=2,
      T=data_OFFGAS.T_carbon,
      p=data_OFFGAS.p_sep_ref,
      use_p_in=true,
      showName=systemTF.showName) annotation (Placement(transformation(extent={{-218,28},{-238,48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_OffGas_source(
      T=data_OFFGAS.T_sep_ref,
      redeclare package Medium = Medium_OffGas,
      m_flow=data_OFFGAS.m_flow_He_adsorber,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      use_C_in=false,
      showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-358,106},{-338,126}})));
    TRANSFORM.Fluid.TraceComponents.TraceDecayAdsorberBed_sparseMatrix adsorberBed(
      nV=10,
      redeclare package Medium = Medium_OffGas,
      d_adsorber=data_OFFGAS.d_carbon,
      cp_adsorber=data_OFFGAS.cp_carbon,
      tau_res=data_OFFGAS.delay_charcoalBed,
      R=data_OFFGAS.dp_carbon/data_OFFGAS.m_flow_He_adsorber,
      use_HeatPort=true,
      T_a_start=data_OFFGAS.T_carbon,
      showName=systemTF.showName,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-278,-22},{-258,-2}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_m_flow(y=data_OFFGAS.m_flow_He_adsorber)
      annotation (Placement(transformation(extent={{-398,124},{-378,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T(y=data_OFFGAS.T_sep_ref)
      annotation (Placement(transformation(extent={{-398,110},{-378,130}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary_thermal_adsorberBed(
      nPorts=adsorberBed.nV,
      T=fill(data_OFFGAS.T_carbon_wall, adsorberBed.nV),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-268,18})));
    Components.MixingVolume_forMSRs drainTank_gas(
      use_HeatPort=true,
      redeclare package Medium = Medium_OffGas,
      T_start=data_OFFGAS.T_drainTank,
      p_start=data_OFFGAS.p_drainTank,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      nPorts_a=1,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data_OFFGAS.volume_drainTank_inner - drainTank_liquid.V))
      annotation (Placement(transformation(extent={{-308,-2},{-288,-22}})));
    Components.ExpansionTank drainTank_liquid(
      redeclare package Medium = Medium_PFL,
      p_surface=drainTank_gas.medium.p,
      h_start=pumpBowl_PFL.h_start,
      p_start=drainTank_gas.p_start,
      C_start=Cs_start,
      use_HeatPort=true,
      A=data_OFFGAS.crossArea_drainTank_inner,
      level_start=0.20,
      showName=systemTF.showName,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-308,-56},{-288,-36}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fromDrainTank(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-268,-52})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_drainTank(redeclare
        package Medium =                                                                   Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-248,-62},{-228,-42}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_bypass(use_input=true, redeclare
        package Medium =
                 Medium_OffGas) annotation (Placement(transformation(extent={{-278,28},{-258,48}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_adsorberBed(use_input=true, redeclare
        package Medium = Medium_OffGas)
      annotation (Placement(transformation(extent={{-248,-22},{-228,-2}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_bypass(y=boundary_OffGas_m_flow.y -
          m_flow_OffGas_adsorberBed.y)
      annotation (Placement(transformation(extent={{-300,38},{-280,58}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_adsorberBed(y=data_OFFGAS.frac_gasSplit*
          boundary_OffGas_m_flow.y)
      annotation (Placement(transformation(extent={{-212,-2},{-232,18}})));
    TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(
      iSep=iSep,
      iCar=iSep,
      m_flow_sepFluid=m_flow_toDrainTank,
      redeclare package Medium = Medium_PFL,
      redeclare package Medium_carrier = Medium_OffGas,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-318,98})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_bypass(redeclare package
                Medium =                                                                Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-286,110},{-306,130}})));
    Modelica.Blocks.Sources.RealExpression m_flow_pump_bypass(y=x_bypass.y*abs(pump_PFL.port_a.m_flow))
      annotation (Placement(transformation(extent={{-326,124},{-306,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_fromPump_PFL_bypass_p(y=pumpBowl_PFL.p)
      annotation (Placement(transformation(extent={{-190,36},{-210,56}})));
    Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{-4.44089e-16,
            105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{3.33067e-16,96}}, color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
    connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
      annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},{160,-140},
            {-4.44089e-16,-140},{-4.44089e-16,-136}}, color={0,127,255}));
    connect(PHX.port_b_shell, pipeFromPHX_PCL.port_a)
      annotation (Line(points={{164.6,10},{164,10},{164,40},{180,40}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b, pumpBowl_PCL.port_a)
      annotation (Line(points={{200,40},{213,40}}, color={0,127,255}));
    connect(pumpBowl_PCL.port_b, pump_PCL.port_a)
      annotation (Line(points={{227,40},{240,40}}, color={0,127,255}));
    connect(pump_PCL.port_b, pipeToSHX_PCL.port_a)
      annotation (Line(points={{260,40},{270,40}}, color={0,127,255}));
    connect(pipeToPHX_PCL.port_b, PHX.port_a_shell)
      annotation (Line(points={{220,-40},{164.6,-40},{164.6,-10}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(m_flow_pump_PFL.y, pump_PFL.in_m_flow)
      annotation (Line(points={{55,142},{50,142},{50,135.3}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(boundary_OffGas_T.y, boundary_OffGas_source.T_in)
      annotation (Line(points={{-377,120},{-360,120}}, color={0,0,127}));
    connect(boundary_OffGas_m_flow.y, boundary_OffGas_source.m_flow_in)
      annotation (Line(points={{-377,134},{-368,134},{-368,124},{-358,124}}, color={0,0,127}));
    connect(boundary_thermal_adsorberBed.port, adsorberBed.heatPorts)
      annotation (Line(points={{-268,8},{-268,-7}}, color={191,0,0}));
    connect(drainTank_liquid.port_b, resistance_fromDrainTank.port_a)
      annotation (Line(points={{-291,-52},{-275,-52}}, color={0,127,255}));
    connect(resistance_fromDrainTank.port_b, pump_drainTank.port_a)
      annotation (Line(points={{-261,-52},{-248,-52}}, color={0,127,255}));
    connect(adsorberBed.port_b, pump_OffGas_adsorberBed.port_a)
      annotation (Line(points={{-258,-12},{-248,-12}}, color={0,127,255}));
    connect(m_flow_OffGas_bypass.y, pump_OffGas_bypass.in_m_flow)
      annotation (Line(points={{-279,48},{-268,48},{-268,45.3}}, color={0,0,127}));
    connect(m_flow_OffGas_adsorberBed.y, pump_OffGas_adsorberBed.in_m_flow)
      annotation (Line(points={{-233,8},{-238,8},{-238,-4.7}}, color={0,0,127}));
    connect(boundary_OffGas_source.ports[1], traceSeparator.port_a_carrier)
      annotation (Line(points={{-338,116},{-324,116},{-324,108}}, color={0,127,255}));
    connect(m_flow_pump_bypass.y, pump_bypass.in_m_flow)
      annotation (Line(points={{-305,134},{-296,134},{-296,127.3}}, color={0,0,127}));
    connect(adsorberBed.port_a, drainTank_gas.port_b[1])
      annotation (Line(points={{-278,-12},{-286,-12},{-286,-11.75},{-292,
            -11.75}},                                                            color={0,127,255}));
    connect(pump_bypass.port_b, traceSeparator.port_a)
      annotation (Line(points={{-306,120},{-312,120},{-312,108}}, color={0,127,255}));
    connect(traceSeparator.port_sepFluid, drainTank_liquid.port_a)
      annotation (Line(points={{-318,88},{-318,-52},{-305,-52}}, color={0,127,255}));
    connect(traceSeparator.port_b_carrier, drainTank_gas.port_a[1])
      annotation (Line(points={{-324,88},{-324,-12},{-304,-12}}, color={0,127,255}));
    connect(pump_OffGas_bypass.port_a, drainTank_gas.port_b[2])
      annotation (Line(points={{-278,38},{-286,38},{-286,-12.25},{-292,-12.25}},
                                                                               color={0,127,255}));
    connect(pump_OffGas_bypass.port_b, boundary_OffGas_sink.ports[1])
      annotation (Line(points={{-258,38},{-248,38},{-248,37},{-238,37}}, color={0,127,255}));
    connect(pump_OffGas_adsorberBed.port_b, boundary_OffGas_sink.ports[2]) annotation (Line(points={{-228,
            -12},{-206,-12},{-206,24},{-246,24},{-246,39},{-238,39}}, color={0,127,255}));
    connect(boundary_fromPump_PFL_bypass_p.y, boundary_OffGas_sink.p_in)
      annotation (Line(points={{-211,46},{-216,46}}, color={0,0,127}));
    connect(traceSeparator.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-312,88},{-312,78},{-188,
            78},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_drainTank.port_b, pumpBowl_PFL.port_a)
      annotation (Line(points={{-228,-52},{-188,-52},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_bypass.port_a, pipeToPHX_PFL.port_a) annotation (Line(points={{-286,120},{-278,120},{-278,
            158},{160,158},{160,80}}, color={0,127,255}));
    connect(boundary_OffGas_T1.y, pump_drainTank.in_m_flow)
      annotation (Line(points={{-249,-34},{-238,-34},{-238,-44.7}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
    connect(port_a, nTU_HX_SinglePhase.Tube_out) annotation (Line(points={{
            358,-32},{316,-32},{316,-10}}, color={0,127,255}));
    connect(nTU_HX_SinglePhase.Tube_in, port_b) annotation (Line(points={{316,
            10},{316,34},{352,34}}, color={0,127,255}));
    connect(pipeToSHX_PCL.port_b, nTU_HX_SinglePhase.Shell_out) annotation (
        Line(points={{290,40},{310,40},{310,10}}, color={0,127,255}));
    connect(nTU_HX_SinglePhase.Shell_in, pipeToPHX_PCL.port_a) annotation (
        Line(points={{310,-10},{310,-40},{240,-40}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=1825,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
  end MCA_Base_withBOP_sec_2;

  model ConnectToBOP_MoreComplicatedBOP
    BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH steamTurbine_L3_HPOFWH
      annotation (Placement(transformation(extent={{22,-12},{42,8}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=14000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-54,-62},{-34,-42}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=2000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-36,-102},{-16,-82}})));
    TRANSFORM.Electrical.Sources.FrequencySource boundary
      annotation (Placement(transformation(extent={{106,-14},{86,6}})));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{82,30},{102,50}})));
    Electrical.PowerSensor      sensorW
      annotation (Placement(transformation(extent={{52,6},{72,-14}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=3400000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-38,30},{-18,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                   bypassdump3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=40,
      h=3366e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  equation
    connect(bypassdump2.ports[1], steamTurbine_L3_HPOFWH.port_b_bypass)
      annotation (Line(points={{-34,-52},{16,-52},{16,-8},{18,-8},{18,-2},{22,
            -2}}, color={0,127,255}));
    connect(bypassdump.ports[1], steamTurbine_L3_HPOFWH.port_b_feed)
      annotation (Line(points={{-16,-92},{20,-92},{20,-16},{18,-16},{18,-8},{
            22,-8}}, color={0,127,255}));
    connect(boundary.port,sensorW. port_b) annotation (Line(points={{86,-4},{
            79,-4},{79,-3.8},{72,-3.8}},
                               color={255,0,0}));
    connect(sensorW.W,integrator. u) annotation (Line(points={{62,5.4},{62,40},
            {80,40}},                    color={0,0,127}));
    connect(steamTurbine_L3_HPOFWH.port_a_elec, sensorW.port_a)
      annotation (Line(points={{42,-2},{42,-4},{52,-4}}, color={255,0,0}));
    connect(bypassdump3.ports[1], steamTurbine_L3_HPOFWH.port_a_steam)
      annotation (Line(points={{-48,0},{16,0},{16,4},{22,4}}, color={0,127,
            255}));
    connect(steamdump.ports[1], steamTurbine_L3_HPOFWH.prt_b_steamdump)
      annotation (Line(points={{-18,40},{16,40},{16,8},{22,8}}, color={0,127,
            255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
  end ConnectToBOP_MoreComplicatedBOP;

  model PCL_WithHeatSource_StandAlone
      replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

      record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

          parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    // import Modelica.Constants.N_A;

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_PFL,
      nPorts=1)
      annotation (Placement(transformation(extent={{-150,-34},{-130,-14}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Medium_PFL,
      nPorts=1)
      annotation (Placement(transformation(extent={{-166,32},{-146,52}})));
       TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary4(
      m_flow=2*3*data_SHX.m_flow_tube,
      T=data_SHX.T_inlet_tube,
      nPorts=1,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,-34})));
            TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      p=data_SHX.p_outlet_tube,
      T=data_SHX.T_outlet_tube,
      nPorts=1,
      redeclare package Medium = Medium_BOP) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,48})));
  protected
    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass
                                                      PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_PHX.p_inlet_shell,
      T_a_start_shell=data_PHX.T_inlet_shell,
      T_b_start_shell=data_PHX.T_outlet_shell,
      p_a_start_tube=data_PHX.p_inlet_tube,
      T_a_start_tube=data_PHX.T_inlet_tube,
      T_b_start_tube=data_PHX.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_PHX.m_flow_shell,
      m_flow_a_start_tube=2*3*data_PHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_PHX.D_tube_outer,
          S_T=data_PHX.pitch_tube,
          S_L=data_PHX.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_PHX.D_shell_inner,
          nTubes=data_PHX.nTubes,
          nR=3,
          length_shell=data_PHX.length_tube,
          th_wall=data_PHX.th_tube,
          dimension_tube=data_PHX.D_tube_inner,
          length_tube=data_PHX.length_tube,
          nV=nV_PHX))                       annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-60,6})));

    //  C_a_start_tube=Cs_start,

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_PHX.p_inlet_shell - 50,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_PHXsToPump,
          dheight=toggleStaticHead*data_PIPING.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-30,46})));
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_RCTR.level_pumpbowlnominal,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      A=3*data_RCTR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start,
          data_SHX.T_outlet_shell))
      annotation (Placement(transformation(extent={{-10,42},{10,62}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_PHX.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{20,36},{40,56}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_pumpToSHX,
          dheight=toggleStaticHead*data_PIPING.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={60,46})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      showName=systemTF.showName,
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 50,
      T_a_start=data_PHX.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_SHXToPHX,
          dheight=toggleStaticHead*data_PIPING.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={10,-34})));

    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=2*3,
      p_a_start_shell=data_SHX.p_inlet_shell,
      T_a_start_shell=data_SHX.T_inlet_shell,
      T_b_start_shell=data_SHX.T_outlet_shell,
      m_flow_a_start_shell=2*3*data_SHX.m_flow_shell,
      p_a_start_tube=data_SHX.p_inlet_tube,
      T_a_start_tube=data_SHX.T_inlet_tube,
      T_b_start_tube=data_SHX.T_outlet_tube,
      m_flow_a_start_tube=2*3*data_SHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_SHX.D_tube_outer,
          S_T=data_SHX.pitch_tube,
          S_L=data_SHX.pitch_tube,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_SHX.D_shell_inner,
          nTubes=data_SHX.nTubes,
          length_shell=data_SHX.length_tube,
          dimension_tube=data_SHX.D_tube_inner,
          length_tube=data_SHX.length_tube,
          th_wall=data_SHX.th_tube,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,6})));

    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      nG_reflA_blocks=1,
      dims_reflAG_1=1,
      dims_reflAG_2=1,
      dims_reflAG_3=1,
      dims_reflAG_4=0.017453292519943,
      crossArea_reflA=1,
      perimeter_reflA=1,
      alpha_reflA=111,
      surfaceArea_reflA=1,
      m_reflAG=1,
      m_reflA=1,
      nG_reflR_blocks=1,
      dims_reflRG_1=1,
      dims_reflRG_2=1,
      dims_reflRG_3=1,
      crossArea_reflR=1,
      perimeter_reflR=1,
      alpha_reflR=1,
      surfaceArea_reflR=1,
      m_reflRG=1,
      m_reflR=1,
      volume_reflRG=1,
      nG_fuelCell=1,
      dims_fuelG_1=1,
      dims_fuelG_2=1,
      dims_fuelG_3=1,
      crossArea_fuel=1,
      perimeter_fuel=1,
      alpha_fuel=1,
      surfaceArea_fuel=1,
      m_fuelG=1,
      m_fuel=1,
      m_plenum=1,
      m_tee_inlet=1,
      dims_pumpBowl_1=1,
      dims_pumpBowl_2=1,
      level_nom_pumpBowl=1,
      m_pumpBowl=1,
      dims_pipeToPHX_1=1,
      dims_pipeToPHX_2=1,
      m_pipeToPHX_PFL=1,
      dims_pipeFromPHX_1=1,
      dims_pipeFromPHX_2=1,
      m_pipeFromPHX_PFL=1,
      T_tube_inlet_PHX=data_PHX.T_inlet_tube,
      T_tube_outlet_PHX=data_PHX.T_outlet_tube,
      p_inlet_tube_PHX=data_PHX.p_inlet_tube,
      m_flow_tube_PHX=data_PHX.m_flow_tube,
      T_shell_inlet_PHX=data_PHX.T_inlet_shell,
      T_shell_outlet_PHX=data_PHX.T_outlet_shell,
      p_inlet_shell_PHX=data_PHX.p_inlet_shell,
      m_flow_shell_PHX=data_PHX.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_PHX.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_RCTR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_RCTR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{-96,78},{-76,98}})));
    //  nG_fuelCell=fuelCellG.nParallel,
    //  dims_fuelG_1=fuelCellG.geometry.length_x,
    //  dims_fuelG_2=fuelCellG.geometry.length_z,
     // dims_fuelG_3=fuelCellG.geometry.length_y,
   //   nG_reflA_blocks=reflA_upperG.nParallel,
   //   dims_reflAG_1=reflA_upperG.geometry.r_inner,
   //   dims_reflAG_2=reflA_upperG.geometry.r_outer,
    //  dims_reflAG_3=reflA_upperG.geometry.length_z,
    //  dims_reflAG_4=reflA_upperG.geometry.angle_theta,
    //  nG_reflR_blocks=reflRG.nParallel,
    //  dims_reflRG_1=reflRG.geometry.length_x,
    //  dims_reflRG_2=reflRG.geometry.length_z,
    //  dims_reflRG_3=reflRG.geometry.length_y,
    //  m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
    //  m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
    //  m_reflRG=reflRG.nParallel*sum(reflRG.ms),
    //  m_reflR=reflR.nParallel*sum(reflR.ms),
    //  crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
   //   perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
   //   crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
    //  perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
    //  crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
    //  perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
    //  surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
    //  surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
    //  surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
   //   m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
   //   m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
   //   m_plenum=plenum_upper.m,
    //  dims_pumpBowl_2=data_RCTR.length_pumpbowl,
   //   dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
   //   dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
   //   m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
   //   dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
   //   dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
   //   m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
   //   dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
  //    m_pumpBowl=pumpBowl_PFL.m/3,
   //   level_nom_pumpBowl=data_RCTR.level_pumpbowlnominal,
    //  m_tee_inlet=tee_inlet.m,
   //   alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
   //   alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
    //  alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,

  protected
    MoltenSaltReactor.Data.data_PHX     data_PHX
      annotation (Placement(transformation(extent={{-70,78},{-50,98}})));
    MoltenSaltReactor.Data.data_SHX     data_SHX
      annotation (Placement(transformation(extent={{-44,78},{-24,98}})));
    MoltenSaltReactor.Data.data_PIPING     data_PIPING
      annotation (Placement(transformation(extent={{-18,78},{2,98}})));
        MSR.MoltenSaltReactor.Data.data_RCTR data_RCTR
      annotation (Placement(transformation(extent={{260,100},{280,120}})));
    MSR.MoltenSaltReactor.Data.data_PUMP data_PUMP
      annotation (Placement(transformation(extent={{320,120},{340,140}})));
  equation
    connect(PHX.port_b_shell,pipeFromPHX_PCL. port_a)
      annotation (Line(points={{-55.4,16},{-56,16},{-56,46},{-40,46}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b,pumpBowl_PCL. port_a)
      annotation (Line(points={{-20,46},{-7,46}},  color={0,127,255}));
    connect(pumpBowl_PCL.port_b,pump_PCL. port_a)
      annotation (Line(points={{7,46},{20,46}},    color={0,127,255}));
    connect(pump_PCL.port_b,pipeToSHX_PCL. port_a)
      annotation (Line(points={{40,46},{50,46}},   color={0,127,255}));
    connect(pipeToPHX_PCL.port_a,SHX. port_b_shell)
      annotation (Line(points={{20,-34},{75.4,-34},{75.4,-4}},     color={0,127,255}));
    connect(pipeToSHX_PCL.port_b,SHX. port_a_shell)
      annotation (Line(points={{70,46},{75.4,46},{75.4,16}},    color={0,127,255}));
    connect(boundary1.ports[1],SHX. port_b_tube)
      annotation (Line(points={{100,48},{80,48},{80,16}},   color={0,127,255}));
    connect(SHX.port_a_tube,boundary4. ports[1])
      annotation (Line(points={{80,-4},{80,-34},{100,-34}},    color={0,127,255}));
    connect(pipeToPHX_PCL.port_b,PHX. port_a_shell)
      annotation (Line(points={{0,-34},{-55.4,-34},{-55.4,-4}},    color={0,127,255}));
  public
    record Data_ISO = Data.fissionProducts_1a;
  equation
    connect(boundary2.ports[1], PHX.port_a_tube) annotation (Line(points={{
            -146,42},{-60,42},{-60,16}}, color={0,127,255}));
    connect(boundary.ports[1], PHX.port_b_tube) annotation (Line(points={{
            -130,-24},{-60,-24},{-60,-4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000000, __Dymola_Algorithm="Dassl"));
  end PCL_WithHeatSource_StandAlone;

  model PCL_WithHeatSource

      replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

      record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

          parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    // import Modelica.Constants.N_A;

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_PFL,
      nPorts=1)
      annotation (Placement(transformation(extent={{-150,-34},{-130,-14}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Medium_PFL,
      m_flow=831.5860117*10,
      T=950.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-166,32},{-146,52}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{112,-38},{132,-18}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{120,22},{140,42}})));
  protected
    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass
                                                      PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_PHX.p_inlet_shell,
      T_a_start_shell=data_PHX.T_inlet_shell,
      T_b_start_shell=data_PHX.T_outlet_shell,
      p_a_start_tube=data_PHX.p_inlet_tube,
      T_a_start_tube=data_PHX.T_inlet_tube,
      T_b_start_tube=data_PHX.T_outlet_tube,
      nParallel=2*3,
      m_flow_a_start_shell=2*3*data_PHX.m_flow_shell,
      m_flow_a_start_tube=2*3*data_PHX.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_PHX.D_tube_outer,
          S_T=data_PHX.pitch_tube,
          S_L=data_PHX.pitch_tube,
          CFs=fill(
              0.44,
              PHX.shell.heatTransfer.nHT,
              PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_PHX.D_shell_inner,
          nTubes=data_PHX.nTubes,
          nR=3,
          length_shell=data_PHX.length_tube,
          th_wall=data_PHX.th_tube,
          dimension_tube=data_PHX.D_tube_inner,
          length_tube=data_PHX.length_tube,
          nV=nV_PHX))                       annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-60,6})));

    //  C_a_start_tube=Cs_start,

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_PHX.p_inlet_shell - 50,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_PHXsToPump,
          dheight=toggleStaticHead*data_PIPING.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-30,46})));
     // showName=systemTF.showName,
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_RCTR.level_pumpbowlnominal,
      redeclare package Medium = Medium_PCL,
      A=3*data_RCTR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start,
          data_SHX.T_outlet_shell))
      annotation (Placement(transformation(extent={{-10,42},{10,62}})));
    //  showName=systemTF.showName,
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=10*data_PHX.m_flow_shell,
      use_input=false) annotation (Placement(transformation(extent={{20,36},{40,56}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_PHX.T_outlet_shell,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_pumpToSHX,
          dheight=toggleStaticHead*data_PIPING.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={60,46})));
   //   showName=systemTF.showName,
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_PHX.m_flow_shell,
      p_a_start=data_PHX.p_inlet_shell + 50,
      T_a_start=data_PHX.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_PIPING.D_PCL,
          length=data_PIPING.length_SHXToPHX,
          dheight=toggleStaticHead*data_PIPING.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={10,-34})));
   //   showName=systemTF.showName,

    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=2*5,
      p_a_start_shell=data_SHX.p_inlet_shell,
      T_a_start_shell=data_SHX.T_inlet_shell,
      T_b_start_shell=data_SHX.T_outlet_shell,
      m_flow_a_start_shell=2*3*data_SHX.m_flow_shell,
      p_a_start_tube=data_SHX.p_inlet_tube,
      T_a_start_tube=data_SHX.T_inlet_tube,
      T_b_start_tube=data_SHX.T_outlet_tube,
      m_flow_a_start_tube=288.5733428,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_SHX.D_tube_outer,
          S_T=data_SHX.pitch_tube,
          S_L=data_SHX.pitch_tube,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_SHX.D_shell_inner,
          nTubes=data_SHX.nTubes,
          length_shell=data_SHX.length_tube,
          dimension_tube=data_SHX.D_tube_inner,
          length_tube=data_SHX.length_tube,
          th_wall=data_SHX.th_tube,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,6})));

    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      nG_reflA_blocks=1,
      dims_reflAG_1=1,
      dims_reflAG_2=1,
      dims_reflAG_3=1,
      dims_reflAG_4=0.017453292519943,
      crossArea_reflA=1,
      perimeter_reflA=1,
      alpha_reflA=111,
      surfaceArea_reflA=1,
      m_reflAG=1,
      m_reflA=1,
      nG_reflR_blocks=1,
      dims_reflRG_1=1,
      dims_reflRG_2=1,
      dims_reflRG_3=1,
      crossArea_reflR=1,
      perimeter_reflR=1,
      alpha_reflR=1,
      surfaceArea_reflR=1,
      m_reflRG=1,
      m_reflR=1,
      volume_reflRG=1,
      nG_fuelCell=1,
      dims_fuelG_1=1,
      dims_fuelG_2=1,
      dims_fuelG_3=1,
      crossArea_fuel=1,
      perimeter_fuel=1,
      alpha_fuel=1,
      surfaceArea_fuel=1,
      m_fuelG=1,
      m_fuel=1,
      m_plenum=1,
      m_tee_inlet=1,
      dims_pumpBowl_1=1,
      dims_pumpBowl_2=1,
      level_nom_pumpBowl=1,
      m_pumpBowl=1,
      dims_pipeToPHX_1=1,
      dims_pipeToPHX_2=1,
      m_pipeToPHX_PFL=1,
      dims_pipeFromPHX_1=1,
      dims_pipeFromPHX_2=1,
      m_pipeFromPHX_PFL=1,
      T_tube_inlet_PHX=data_PHX.T_inlet_tube,
      T_tube_outlet_PHX=data_PHX.T_outlet_tube,
      p_inlet_tube_PHX=data_PHX.p_inlet_tube,
      m_flow_tube_PHX=data_PHX.m_flow_tube,
      T_shell_inlet_PHX=data_PHX.T_inlet_shell,
      T_shell_outlet_PHX=data_PHX.T_outlet_shell,
      p_inlet_shell_PHX=data_PHX.p_inlet_shell,
      m_flow_shell_PHX=data_PHX.m_flow_shell,
      nTubes_PHX=PHX.geometry.nTubes,
      diameter_outer_tube_PHX=PHX.geometry.D_o_tube,
      th_tube_PHX=PHX.geometry.th_wall,
      length_tube_PHX=PHX.geometry.length_tube,
      tube_pitch_PHX=data_PHX.pitch_tube,
      m_tube_PHX=PHX.geometry.nTubes*sum(PHX.tube.ms),
      crossArea_shell_PHX=PHX.geometry.crossArea_shell,
      perimeter_shell_PHX=PHX.geometry.perimeter_shell,
      m_shell_PHX=sum(PHX.shell.ms),
      surfaceArea_shell_PHX=PHX.geometry.surfaceArea_shell[1],
      dp_tube_PHX=abs(PHX.port_a_tube.p - PHX.port_b_tube.p),
      dp_shell_PHX=abs(PHX.port_a_shell.p - PHX.port_b_shell.p),
      surfaceArea_tube_PHX=PHX.geometry.nTubes*PHX.geometry.surfaceArea_tube[1],
      redeclare package Medium_PCL = Medium_PCL,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_RCTR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_RCTR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_SHX.T_inlet_tube,
      T_tube_outlet_SHX=data_SHX.T_outlet_tube,
      p_inlet_tube_SHX=data_SHX.p_inlet_tube,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_SHX.m_flow_tube,
      T_shell_inlet_SHX=data_SHX.T_inlet_shell,
      T_shell_outlet_SHX=data_SHX.T_outlet_shell,
      p_inlet_shell_SHX=data_SHX.p_inlet_shell,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_SHX.m_flow_shell,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_SHX.pitch_tube,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      m_tube_SHX=SHX.geometry.nTubes*sum(SHX.tube.ms),
      crossArea_shell_SHX=SHX.geometry.crossArea_shell,
      perimeter_shell_SHX=SHX.geometry.perimeter_shell,
      surfaceArea_shell_SHX=SHX.geometry.surfaceArea_shell[1],
      m_shell_SHX=sum(SHX.shell.ms),
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_tube_PHX=sum(PHX.tube.heatTransfer.alphas)/PHX.tube.nV,
      alpha_shell_PHX=sum(PHX.shell.heatTransfer.alphas)/PHX.shell.nV,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV)
      annotation (Placement(transformation(extent={{-96,78},{-76,98}})));
    //  nG_fuelCell=fuelCellG.nParallel,
    //  dims_fuelG_1=fuelCellG.geometry.length_x,
    //  dims_fuelG_2=fuelCellG.geometry.length_z,
     // dims_fuelG_3=fuelCellG.geometry.length_y,
   //   nG_reflA_blocks=reflA_upperG.nParallel,
   //   dims_reflAG_1=reflA_upperG.geometry.r_inner,
   //   dims_reflAG_2=reflA_upperG.geometry.r_outer,
    //  dims_reflAG_3=reflA_upperG.geometry.length_z,
    //  dims_reflAG_4=reflA_upperG.geometry.angle_theta,
    //  nG_reflR_blocks=reflRG.nParallel,
    //  dims_reflRG_1=reflRG.geometry.length_x,
    //  dims_reflRG_2=reflRG.geometry.length_z,
    //  dims_reflRG_3=reflRG.geometry.length_y,
    //  m_reflAG=reflA_upperG.nParallel*sum(reflA_upperG.ms),
    //  m_reflA=reflA_upper.nParallel*sum(reflA_upper.ms),
    //  m_reflRG=reflRG.nParallel*sum(reflRG.ms),
    //  m_reflR=reflR.nParallel*sum(reflR.ms),
    //  crossArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.crossArea,
   //   perimeter_reflA=reflA_upper.nParallel*reflA_upper.geometry.perimeter,
   //   crossArea_reflR=reflR.nParallel*reflR.geometry.crossArea,
    //  perimeter_reflR=reflR.nParallel*reflR.geometry.perimeter,
    //  crossArea_fuel=fuelCell.nParallel*fuelCell.geometry.crossArea,
    //  perimeter_fuel=fuelCell.nParallel*fuelCell.geometry.perimeter,
    //  surfaceArea_reflA=reflA_upper.nParallel*reflA_upper.geometry.surfaceArea_total,
    //  surfaceArea_reflR=reflR.nParallel*reflR.geometry.surfaceArea_total,
    //  surfaceArea_fuel=fuelCell.nParallel*fuelCell.geometry.surfaceArea_total,
   //   m_fuelG=fuelCellG.nParallel*sum(fuelCellG.ms),
   //   m_fuel=fuelCell.nParallel*sum(fuelCell.ms),
   //   m_plenum=plenum_upper.m,
    //  dims_pumpBowl_2=data_RCTR.length_pumpbowl,
   //   dims_pipeToPHX_1=pipeToPHX_PFL.geometry.dimension,
   //   dims_pipeToPHX_2=pipeToPHX_PFL.geometry.length,
   //   m_pipeToPHX_PFL=sum(pipeToPHX_PFL.ms),
   //   dims_pipeFromPHX_1=pipeFromPHX_PFL.geometry.dimension,
   //   dims_pipeFromPHX_2=pipeFromPHX_PFL.geometry.length,
   //   m_pipeFromPHX_PFL=sum(pipeFromPHX_PFL.ms),
   //   dims_pumpBowl_1=sqrt(4*pumpBowl_PFL.A/Modelica.Constants.pi/3),
  //    m_pumpBowl=pumpBowl_PFL.m/3,
   //   level_nom_pumpBowl=data_RCTR.level_pumpbowlnominal,
    //  m_tee_inlet=tee_inlet.m,
   //   alpha_reflA=sum(reflA_upper.heatTransfer.alphas)/reflA_upper.nV,
   //   alpha_reflR=sum(reflR.heatTransfer.alphas)/reflR.nV,
    //  alpha_fuel=sum(fuelCell.heatTransfer.alphas)/fuelCell.nV,

  protected
    MoltenSaltReactor.Data.data_PHX     data_PHX(m_flow_tube=831.5860117*10)
      annotation (Placement(transformation(extent={{-70,78},{-50,98}})));
    MoltenSaltReactor.Data.data_SHX     data_SHX
      annotation (Placement(transformation(extent={{-44,78},{-24,98}})));
    MoltenSaltReactor.Data.data_PIPING     data_PIPING
      annotation (Placement(transformation(extent={{-18,78},{2,98}})));
        MSR.MoltenSaltReactor.Data.data_RCTR data_RCTR
      annotation (Placement(transformation(extent={{260,100},{280,120}})));
    MSR.MoltenSaltReactor.Data.data_PUMP data_PUMP
      annotation (Placement(transformation(extent={{320,120},{340,140}})));
  equation
    connect(PHX.port_b_shell,pipeFromPHX_PCL. port_a)
      annotation (Line(points={{-55.4,16},{-56,16},{-56,46},{-40,46}}, color={0,127,255}));
    connect(pipeFromPHX_PCL.port_b,pumpBowl_PCL. port_a)
      annotation (Line(points={{-20,46},{-7,46}},  color={0,127,255}));
    connect(pumpBowl_PCL.port_b,pump_PCL. port_a)
      annotation (Line(points={{7,46},{20,46}},    color={0,127,255}));
    connect(pump_PCL.port_b,pipeToSHX_PCL. port_a)
      annotation (Line(points={{40,46},{50,46}},   color={0,127,255}));
    connect(pipeToPHX_PCL.port_a,SHX. port_b_shell)
      annotation (Line(points={{20,-34},{75.4,-34},{75.4,-4}},     color={0,127,255}));
    connect(pipeToSHX_PCL.port_b,SHX. port_a_shell)
      annotation (Line(points={{70,46},{75.4,46},{75.4,16}},    color={0,127,255}));
    connect(pipeToPHX_PCL.port_b,PHX. port_a_shell)
      annotation (Line(points={{0,-34},{-55.4,-34},{-55.4,-4}},    color={0,127,255}));
  public
    record Data_ISO = Data.fissionProducts_1a;
  equation
    connect(boundary2.ports[1], PHX.port_a_tube) annotation (Line(points={{
            -146,42},{-60,42},{-60,16}}, color={0,127,255}));
    connect(boundary.ports[1], PHX.port_b_tube) annotation (Line(points={{
            -130,-24},{-60,-24},{-60,-4}}, color={0,127,255}));
    connect(port_a, SHX.port_a_tube) annotation (Line(points={{122,-28},{122,
            -10},{80,-10},{80,-4}},
                               color={0,127,255}));
    connect(SHX.port_b_tube, port_b)
      annotation (Line(points={{80,16},{80,32},{130,32}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000000, __Dymola_Algorithm="Esdirk45a"));
  end PCL_WithHeatSource;

end Old_NotInUseRightNow;
