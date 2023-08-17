within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.OffGasProject;
model MSDR_v1

  import TRANSFORM;

  package Medium_PFL =
      TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (
        extraPropertiesNames=kinetics.summary_data.extraPropertiesNames,
        C_nominal=kinetics.summary_data.C_nominal) "Primary fuel loop medium";
  package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT
    "Primary coolant loop medium";
  package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (
        extraPropertiesNames=kinetics.summary_data.extraPropertiesNames,
        C_nominal=kinetics.summary_data.C_nominal);
  package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;
  package Medium_BOP = Modelica.Media.Water.StandardWater;

  parameter Integer iOG[:]={2,3} + fill(kinetics.summary_data.data_PG.nC, 2)
    "Index array of substances sent to off-gas system";
  parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

  record Data_PG =
      TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;
  record Data_FP =
      TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_cut6_U235_Pu239;
  record Data_TR = TRANSFORM.Nuclear.ReactorKinetics.Data.Tritium.FLiBe;

  // Constant volume spacing for radial geometry
  //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
  //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

  // Initialization
  import Modelica.Constants.N_A;
  parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
      Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
  parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
  parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    "Mole fraction of LiF";
  parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
  parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
  parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
  parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
      /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    "Mole fraction of lithium in flibe that is Li-7";
  parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    "Mole fraction of lithium in flibe that is Li-6";

  parameter TRANSFORM.Units.ExtraProperty[fuelCell.nV,kinetics.summary_data.nC]
    Cs_start_fuelCell={cat(
      1,
      fill(0, kinetics.summary_data.data_PG.nC),
      fill(0, kinetics.summary_data.data_FP.nC),
      C_start) for i in 1:fuelCell.nV};

  parameter Integer nV_fuelCell=10;
  parameter Integer nV_PHX=10;
  parameter Integer nV_SHX=10;
  parameter Integer nV_pipeToPHX_PFL=2;
  parameter Integer nV_pipeFromPHX_PFL=2;
  parameter Integer nV_pipeFromPHX_PCL=2;
  parameter Integer nV_pipeToPHX_PCL=2;
  parameter Integer nV_pipeToSHX_PCL=2;
  //   SI.Temperature Tref_fuelCell[fuelCell.geometry.nV] = {TRANSFORM.Math.Sigmoid(fuelCell.summary.xpos_norm[i], 0.5, fuelCell.geometry.nV)*(data_RCTR.T_outlet_core-data_RCTR.T_inlet_core) + data_RCTR.T_inlet_core for i in 1:fuelCell.geometry.nV};
  //   SI.Temperature Tref_fuelCellG[fuelCell.geometry.nV] = {TRANSFORM.Math.Sigmoid(fuelCell.summary.xpos_norm[i], 0.5, fuelCell.geometry.nV)*(data_RCTR.T_outlet_core-data_RCTR.T_inlet_core) + data_RCTR.T_inlet_core+1 for i in 1:fuelCell.geometry.nV};
  //   SI.Temperature Tref_core[fuelCell.geometry.nV,kinetics.nFeedback] = {{if j == 1 then Tref_fuelCell[i] else Tref_fuelCellG[i] for j in 1:kinetics.nFeedback} for i in 1:fuelCell.geometry.nV};

  // Summary Calculations
  Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
    "Total thermal power output (from primary fission)";

  Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

  Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

  Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

  Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV +
    reflA_upper.nV + 1 + pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV +
    1]=cat(
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

  // Core fuel channel
  Modelica.Units.SI.Power[fuelCell.nV] Qs_gen_fuelCell=kinetics.Qs;

  TRANSFORM.Units.ExtraPropertyFlowRate[fuelCell.nV,kinetics.summary_data.nC]
    mC_gens_fuelCell=cat(
      2,
      kinetics.mC_gens,
      kinetics.fissionProducts.mC_gens,
      kinetics.fissionProducts.mC_gens_TR);

  // Decay Heat Calculations: PFL - solid
  Modelica.Units.SI.Power[reflA_lowerG.nVs[1],reflA_lowerG.nVs[2]]
    Qs_gen_reflA_lowerG={{QsG_reflA_lowerG[j]/reflA_lowerG.nVs[1] for j in 1:
      reflA_lowerG.nVs[2]} for i in 1:reflA_lowerG.nVs[1]};

  Modelica.Units.SI.Power[reflA_lower.nV] QsG_reflA_lowerG={sum({kinetics.summary_data.w_far_decay[
      j]*kinetics.summary_data.lambdas[j]*reflA_lower.mCs[i, j]*reflA_lower.nParallel
      for j in 1:kinetics.summary_data.nC}) for i in 1:reflA_lower.nV};

  //SI.Power[fuelCell.nV] QsG_fuelCellG = {sum({kinetics.summary_data.wG_decay[j]*kinetics.summary_data.lambdas[j]*fuelCell.mCs[i, j] for j in 1:kinetics.summary_data.nC}) for i in 1:fuelCell.nV};

  Modelica.Units.SI.Power[reflRG.nVs[1],reflRG.nVs[2]] Qs_gen_reflRG={{
      QsG_reflRG[j]/reflRG.nVs[1] + Qs_gen_fuellCellG[i, j] for j in 1:reflRG.nVs[
      2]} for i in 1:reflRG.nVs[1]};

  Modelica.Units.SI.Power[reflR.nV] QsG_reflRG={sum({kinetics.summary_data.w_far_decay[
      j]*kinetics.summary_data.lambdas[j]*reflR.mCs[i, j]*reflR.nParallel for j in
          1:kinetics.summary_data.nC}) for i in 1:reflR.nV};

  // Direct fission heat deposited in graphite
  Modelica.Units.SI.Power[fuelCellG.nVs[1],fuelCellG.nVs[2]] Qs_gen_fuellCellG=
      {{kinetics.fissionProducts.Qs_far[j]/fuelCellG.nVs[1] for j in 1:
      fuelCellG.nVs[2]} for i in 1:fuelCellG.nVs[1]};

  Modelica.Units.SI.Power[reflA_upperG.nVs[1],reflA_upperG.nVs[2]]
    Qs_gen_reflA_upperG={{QsG_reflA_upperG[j]/reflA_upperG.nVs[1] for j in 1:
      reflA_upperG.nVs[2]} for i in 1:reflA_upperG.nVs[1]};

  Modelica.Units.SI.Power[reflA_upper.nV] QsG_reflA_upperG={sum({kinetics.summary_data.w_far_decay[
      j]*kinetics.summary_data.lambdas[j]*reflA_upper.mCs[i, j]*reflA_upper.nParallel
      for j in 1:kinetics.summary_data.nC}) for i in 1:reflA_upper.nV};

  Data.data_PHX data_PHX
    annotation (Placement(transformation(extent={{290,100},{310,120}})));
  Data.data_RCTR data_RCTR
    annotation (Placement(transformation(extent={{260,100},{280,120}})));
  Data.data_PUMP data_PUMP
    annotation (Placement(transformation(extent={{320,120},{340,140}})));
  Data.data_SHX data_SHX
    annotation (Placement(transformation(extent={{320,100},{340,120}})));
  Data.data_PIPING data_PIPING
    annotation (Placement(transformation(extent={{260,80},{280,100}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
    nParallel=data_RCTR.nFcells,
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
        (mC_gens=mC_gens_fuelCell),
    Cs_start=Cs_start_fuelCell,
    redeclare model InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gens=Qs_gen_fuelCell),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        crossArea=data_RCTR.crossArea_f,
        perimeter=data_RCTR.perimeter_f,
        length=data_RCTR.length_cells,
        angle=toggleStaticHead*90,
        surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1
            [1, :])},
        nV=nV_fuelCell))
    "frac*data_RCTR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  Components.GenericPipe_forMSRs reflA_upper(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
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
    includeDecayHeatFar=false,
    C_start_TR=C_start)        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,60})));

  Components.MixingVolume_forMSRs plenum_upper(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    p_start=data_PHX.p_inlet_tube,
    T_start=data_PHX.T_inlet_tube,
    C_start_TR=C_start,
    nPorts_b=1,
    nPorts_a=1,
    redeclare package Medium = Medium_PFL,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
        (
        length=data_RCTR.length_plenum,
        crossArea=data_RCTR.crossArea_plenum,
        angle=toggleStaticHead*90),
    showName=systemTF.showName)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90})));
  Components.GenericPipe_forMSRs reflA_lower(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
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
    includeDecayHeatFar=false,
    C_start_TR=C_start)        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-60})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    resistance_fuelCell_outlet(
    redeclare package Medium = Medium_PFL,
    R=1,
    showName=systemTF.showName) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Components.MixingVolume_forMSRs plenum_lower(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    C_start_TR=C_start,
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
    showName=systemTF.showName)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    resistance_fuelCell_inlet(
    redeclare package Medium = Medium_PFL,
    R=1,
    showName=systemTF.showName) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    resistance_toPump_PFL(
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
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
        (Q_gens=Qs_gen_fuellCellG),
    T_a1_start=0.5*(data_PHX.T_inlet_tube + data_PHX.T_outlet_tube),
    T_b1_start=0.5*(data_PHX.T_inlet_tube + data_PHX.T_outlet_tube),
    T_b2_start=data_PHX.T_inlet_tube)
                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,0})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    fuelCellG_centerline_bc(nPorts=fuelCell.nV, showName=systemTF.showName)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    fuelCellG_upper_bc(nPorts=fuelCellG.geometry.nX, showName=systemTF.showName)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,30})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    fuelCellG_lower_bc(nPorts=fuelCellG.geometry.nX, showName=systemTF.showName)
    annotation (Placement(transformation(
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
        angle_theta=data_RCTR.angle_reflA_ring_blockG),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
        (Q_gens=Qs_gen_reflA_upperG))
                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,60})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflA_upperG_upper_bc(nPorts=reflA_upperG.geometry.nR, showName=systemTF.showName)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,90})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflA_upperG_lower_bc(nPorts=reflA_upperG.geometry.nR, showName=systemTF.showName)
    annotation (Placement(transformation(
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
        angle_theta=data_RCTR.angle_reflA_ring_blockG),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
        (Q_gens=Qs_gen_reflA_lowerG))
                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,-60})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflA_lowerG_upper_bc(nPorts=reflA_lowerG.geometry.nR, showName=systemTF.showName)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-30})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflA_lowerG_lower_bc(nPorts=reflA_lowerG.geometry.nR, showName=systemTF.showName)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-30,-90})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    resistance_teeTOplenum(
    redeclare package Medium = Medium_PFL,
    R=1,
    showName=systemTF.showName) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-110})));
  Components.MixingVolume_forMSRs tee_inlet(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    C_start_TR=C_start,
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
    showName=systemTF.showName)
                               annotation (Placement(transformation(
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
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        length=data_PIPING.length_PHXToRCTR,
        dimension=data_PIPING.D_PFL,
        dheight=toggleStaticHead*data_PIPING.height_PHXToRCTR,
        nV=nV_pipeFromPHX_PFL),
    C_start_TR=C_start)         annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={160,-70})));

  Components.GenericDistributed_HX_withMass_forMSRs       PHX(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    C_start_TR=C_start,
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
        nV=nV_PHX))                      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={160,0})));

  Components.GenericPipe_forMSRs pipeToPHX_PFL(
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
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
    C_start_TR=C_start)       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={160,70})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
    redeclare package Medium = Medium_PFL,
    m_flow_nominal=2*3*data_PHX.m_flow_tube,
    use_input=true)
    annotation (Placement(transformation(extent={{40,118},{60,138}})));
  Components.ExpansionTank              pumpBowl_PFL(
    redeclare package Medium = Medium_PFL,
    level_start=data_RCTR.level_pumpbowlnominal,
    showName=systemTF.showName,
    h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
        data_PHX.T_inlet_tube),
    A=3*data_RCTR.crossArea_pumpbowl,
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    C_start_TR=C_start)
    annotation (Placement(transformation(extent={{10,124},{30,144}})));
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showName=false,
    showColors=true,
    val_max=data_PHX.T_inlet_tube,
    val_min=data_PHX.T_inlet_shell)
    annotation (Placement(transformation(extent={{200,120},{220,140}})));
  TRANSFORM.Nuclear.ReactorKinetics.PointKinetics_L1_atomBased_external
    kinetics(
    nV=fuelCell.nV,
    Q_nominal=data_RCTR.Q_nominal,
    mCs=fuelCell.mCs[:, kinetics.summary_data.iPG[1]:kinetics.summary_data.iPG[2]]
        *fuelCell.nParallel,
    mCs_FP=fuelCell.mCs[:, kinetics.summary_data.iFP[1]:kinetics.summary_data.iFP[
        2]]*fuelCell.nParallel,
    mCs_TR=fuelCell.mCs[:, kinetics.summary_data.iTR[1]:kinetics.summary_data.iTR[
        2]]*fuelCell.nParallel,
    Vs=fuelCell.Vs*fuelCell.nParallel,
    SigmaF_start=26,
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    nFeedback=2,
    vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
    Q_fission_input=data_RCTR.Q_nominal*(1 - 0.12),
    vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
    alphas_feedback={-3.22e-5,2.35e-5},
    rho_input=0.00337 + 0.002)
    annotation (Placement(transformation(extent={{-80,-8},{-60,12}})));

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
    h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start,
        data_SHX.T_outlet_shell))
    annotation (Placement(transformation(extent={{210,36},{230,56}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
    redeclare package Medium = Medium_PCL,
    m_flow_nominal=2*3*data_PHX.m_flow_shell,
    use_input=false)
    annotation (Placement(transformation(extent={{240,30},{260,50}})));
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
        nV=nV_SHX))                                 annotation (Placement(
        transformation(
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
    redeclare record Data = Data_PG,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
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
    includeDecayHeatFar=false,
    C_start_TR=C_start)        annotation (Placement(transformation(
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
        length_z=data_RCTR.length_reflR_blockG),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
        (Q_gens=Qs_gen_reflRG))
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,0})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflRG_lower_bc(showName=systemTF.showName, nPorts=reflRG.geometry.nX)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,-30})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflRG_centerline_bc(showName=systemTF.showName, nPorts=reflR.nV)
    annotation (Placement(transformation(extent={{88,-10},{68,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    reflRG_upper_bc(showName=systemTF.showName, nPorts=reflRG.geometry.nX)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,30})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    resistance_reflR_inlet(
    redeclare package Medium = Medium_PFL,
    R=1,
    showName=systemTF.showName) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-30})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    resistance_reflR_outlet(
    redeclare package Medium = Medium_PFL,
    R=1,
    showName=systemTF.showName) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
  TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
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
    redeclare package Medium_OffGas = Medium_OffGas,
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
equation
  connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b) annotation (Line(
        points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
  connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
    annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
  connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{
          4.44089e-16,-84},{4.44089e-16,-70},{-6.66134e-16,-70}}, color={0,127,255}));
  connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
    annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
  connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
    annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
  connect(reflA_upper.port_b, plenum_upper.port_a[1])
    annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
  connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (
      Line(points={{-4.44089e-16,105},{-4.44089e-16,100.5},{3.33067e-16,100.5},{
          3.33067e-16,96}}, color={0,127,255}));
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
  connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(
        points={{-40,60},{-44,60},{-44,64},{-12,64},{-12,60},{-5,60}}, color={191,
          0,0}));
  connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(
        points={{-40,-60},{-44,-60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}},
        color={191,0,0}));
  connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
    annotation (Line(points={{0,-96},{0,-103}}, color={0,127,255}));
  connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
    annotation (Line(points={{0,-117},{0,-124}}, color={0,127,255}));
  connect(pipeToPHX_PFL.port_b, PHX.port_a_tube)
    annotation (Line(points={{160,60},{160,10}}, color={0,127,255}));
  connect(pump_PFL.port_b, pipeToPHX_PFL.port_a)
    annotation (Line(points={{60,128},{160,128},{160,80}}, color={0,127,255}));
  connect(pump_PFL.port_a, pumpBowl_PFL.port_b) annotation (Line(points={{40,128},
          {34,128},{34,128},{27,128}}, color={0,127,255}));
  connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
    annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
  connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
    annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
  connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={
          {160,-80},{160,-140},{-4.44089e-16,-140},{-4.44089e-16,-136}}, color={
          0,127,255}));
  connect(PHX.port_b_shell, pipeFromPHX_PCL.port_a) annotation (Line(points={{164.6,
          10},{164,10},{164,40},{180,40}}, color={0,127,255}));
  connect(pipeFromPHX_PCL.port_b, pumpBowl_PCL.port_a)
    annotation (Line(points={{200,40},{213,40}}, color={0,127,255}));
  connect(pumpBowl_PCL.port_b, pump_PCL.port_a)
    annotation (Line(points={{227,40},{240,40}}, color={0,127,255}));
  connect(pump_PCL.port_b, pipeToSHX_PCL.port_a)
    annotation (Line(points={{260,40},{270,40}}, color={0,127,255}));
  connect(pipeToPHX_PCL.port_a, SHX.port_b_shell) annotation (Line(points={{240,
          -40},{295.4,-40},{295.4,-10}}, color={0,127,255}));
  connect(pipeToSHX_PCL.port_b, SHX.port_a_shell) annotation (Line(points={{290,
          40},{295.4,40},{295.4,10}}, color={0,127,255}));
  connect(boundary1.ports[1], SHX.port_b_tube)
    annotation (Line(points={{320,40},{300,40},{300,10}}, color={0,127,255}));
  connect(SHX.port_a_tube, boundary4.ports[1]) annotation (Line(points={{300,-10},
          {300,-40},{320,-40}}, color={0,127,255}));
  connect(pipeToPHX_PCL.port_b, PHX.port_a_shell) annotation (Line(points={{220,
          -40},{164.6,-40},{164.6,-10}}, color={0,127,255}));
  connect(resistance_reflR_outlet.port_b, reflA_upper.port_a) annotation (Line(
        points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
  connect(reflR.port_a, resistance_reflR_inlet.port_b)
    annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
  connect(resistance_reflR_inlet.port_a, reflA_lower.port_b) annotation (Line(
        points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
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
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-360,-220},{340,180}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-360,-220},{340,
            180}})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
end MSDR_v1;
