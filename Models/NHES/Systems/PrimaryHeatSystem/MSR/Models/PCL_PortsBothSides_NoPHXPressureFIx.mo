within NHES.Systems.PrimaryHeatSystem.MSR.Models;
model PCL_PortsBothSides_NoPHXPressureFIx
  import MSR;
  extends MSR.BaseClasses.Partial_SubSystem_A(
    redeclare replaceable MSR.Data.data_new data,
    redeclare replaceable MSR.ControlSystems.CS_1 CS,
    redeclare replaceable MSR.ControlSystems.ED_Dummy ED);

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

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_BOP)
    annotation (Placement(transformation(extent={{88,-34},{108,-14}}),
        iconTransformation(extent={{88,-34},{108,-14}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_BOP)
    annotation (Placement(transformation(extent={{88,38},{108,58}}),
        iconTransformation(extent={{88,38},{108,58}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Medium_BOP)
    annotation (Placement(transformation(extent={{88,48},{108,68}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a1(redeclare package Medium =
        Medium_PCL)
    annotation (Placement(transformation(extent={{-108,36},{-88,56}}),
        iconTransformation(extent={{-108,36},{-88,56}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b1(redeclare package Medium =
        Medium_PCL)
    annotation (Placement(transformation(extent={{-108,-36},{-88,-16}}),
        iconTransformation(extent={{-108,-36},{-88,-16}})));

  //  C_a_start_tube=Cs_start,

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Medium_PCL,
    p=1000000,
    nPorts=1) annotation (Placement(transformation(extent={{-18,-6},{2,14}})));
public
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
    m_flow_nominal=2*3*data_PHX.m_flow_shell,
    use_input=true)  annotation (Placement(transformation(extent={{20,36},{40,56}})));
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
        nV=nV_pipeToSHX_PCL),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
                              annotation (Placement(transformation(
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
    nParallel=24,
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
    dp_tube_PHX=100000,
    m_flow_tube_PHX=data_PHX.m_flow_tube,
    T_shell_inlet_PHX=data_PHX.T_inlet_shell,
    T_shell_outlet_PHX=data_PHX.T_outlet_shell,
    p_inlet_shell_PHX=data_PHX.p_inlet_shell,
    dp_shell_PHX=100000,
    m_flow_shell_PHX=data_PHX.m_flow_shell,
    nTubes_PHX=1,
    diameter_outer_tube_PHX=1,
    th_tube_PHX=1,
    length_tube_PHX=1,
    tube_pitch_PHX=data_PHX.pitch_tube,
    redeclare package Medium_PCL = Medium_PCL,
    alpha_tube_PHX=1,
    surfaceArea_tube_PHX=1,
    m_tube_PHX=1,
    crossArea_shell_PHX=1,
    perimeter_shell_PHX=1,
    alpha_shell_PHX=1,
    surfaceArea_shell_PHX=1,
    m_shell_PHX=1,
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
    redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
    alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
    m_tube_SHX=1,
    crossArea_shell_SHX=1,
    perimeter_shell_SHX=1,
    alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV,
    surfaceArea_shell_SHX=1,
    m_shell_SHX=1)
    annotation (Placement(transformation(extent={{-96,78},{-76,98}})));

  MSR.Data.data_PHX data_PHX
    annotation (Placement(transformation(extent={{-70,78},{-50,98}})));
  MSR.Data.data_SHX data_SHX
    annotation (Placement(transformation(extent={{-44,78},{-24,98}})));
  MSR.Data.data_PIPING data_PIPING
    annotation (Placement(transformation(extent={{-18,78},{2,98}})));
  MSR.Data.data_RCTR data_RCTR
    annotation (Placement(transformation(extent={{-90,-94},{-70,-74}})));
  MSR.Data.data_PUMP data_PUMP
    annotation (Placement(transformation(extent={{-58,-94},{-38,-74}})));
equation
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
public
  record Data_ISO = MSR.Data.fissionProducts_1a;
equation
  connect(port_a, SHX.port_a_tube) annotation (Line(points={{98,-24},{98,-10},{
          80,-10},{80,-4}},  color={0,127,255}));
  connect(actuatorBus.pump_speed, pump_PCL.in_m_flow) annotation (Line(
      points={{30,100},{30,53.3}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SHX.port_b_tube, sensor_p.port) annotation (Line(points={{80,16},
          {80,42},{98,42},{98,48}}, color={0,127,255}));
  connect(sensor_p.port, port_b) annotation (Line(points={{98,48},{98,48}},
                                      color={0,127,255}));
  connect(sensorBus.SG_pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{114,100},{114,58},{104,58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_a1, pipeFromPHX_PCL.port_a) annotation (Line(points={{-98,46},{
          -70,46},{-70,46},{-40,46}},
                         color={0,127,255}));
  connect(port_b1, pipeToPHX_PCL.port_b) annotation (Line(points={{-98,-26},{-6,
          -26},{-6,-34},{1.77636e-15,-34}},
                                   color={0,127,255}));
  connect(port_b1, port_b1)
    annotation (Line(points={{-98,-26},{-98,-26}}, color={0,127,255}));
  connect(boundary.ports[1], pipeToPHX_PCL.port_a) annotation (Line(points={{2,
          4},{26,4},{26,-34},{20,-34}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-78,70},{74,-50}},
          textColor={28,108,200},
          textString="MSR-PCL")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000000, __Dymola_Algorithm="Esdirk45a"));
end PCL_PortsBothSides_NoPHXPressureFIx;
