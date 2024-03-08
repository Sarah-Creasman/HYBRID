within NHES.Systems.BalanceOfPlant.RankineCycle.Examples;
model NSSS_Test_b_SEC_1LPT
  extends Modelica.Icons.Example;
//  parameter Real P_ext=3;
//  parameter Real P_demand=2.5;
//  parameter Modelica.Units.SI.Density d_ext=2.03641  "kg/m3";
//  parameter Modelica.Units.SI.MassFlowRate m_ext=40;

//  parameter Real P_ext=1.6;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext=1.004547784   "kg/m3";

  parameter Modelica.Units.SI.MassFlowRate m_ext=0;

  Real breaker;
  parameter Real Boo=1;

//  Real eta_th "Thermal Cycle Efficiency";
//  Real eta_CHP "Thermal Cycle Efficiency";
  Real Q_util "Thermal Cycle Efficiency";

  NHES.Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,16},{-18,36}})));
  NHES.Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,0},{-38,-20}})));
  NHES.Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{-48,34},{-8,64}})));
  NHES.Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-48,-16},{-8,-46}})));
  Models.SteamTurbine_L3_HPOFWHsimplified_sec_MovedMoistureSeparator_Optimization_1LPT BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_L3_HTGR_extraction_extractions_LWR
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data(
      Power_nom=data.Power_nom,
      HPT_p_in=data.HPT_p_in,
      p_dump=data.p_dump,
      p_i1=data.p_i1,
      p_i2=data.p_i2,
      cond_p=data.cond_p,
      Tin=data.Tin,
      Tfeed=data.Tfeed,
      d_HPT_in(displayUnit="kg/m3") = data.d_HPT_in,
      d_LPT1_in(displayUnit="g/cm3") = data.d_LPT1_in,
      d_LPT2_in(displayUnit="kg/m3") = data.d_LPT2_in,
      mdot_total=data.mdot_total,
      mdot_fh=data.mdot_fh,
      mdpt_HPFH=data.mdpt_HPFH,
      mdot_hpt=data.mdot_hpt,
      mdot_lpt1=data.mdot_lpt1,
      mdot_lpt2=data.mdot_lpt2,
      m_ext=data.m_ext,
      eta_t=data.eta_t,
      eta_mech=data.eta_mech,
      eta_p=data.eta_p),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15),
    LPT1_bypass_valve(dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=10*m_ext),
    moistureSeperator(p_start=990000, T_start=384.15),
    pump(use_input=false))
    annotation (Placement(transformation(extent={{16,-22},{76,38}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-42,-86},{-20,-66}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-18,76},{2,96}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{-5.5,-7.5},{5.5,7.5}},
        rotation=90,
        origin={182.5,-6.5})));
  NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data(
    HPT_p_in=6186000,
    Power_nom=3.6515e9,
    Tin=550.95,
    Tfeed=484.85,
    d_HPT_in(displayUnit="kg/m3") = 31.78211826,
    d_LPT1_in(displayUnit="kg/m3") = 11.24342362,
    d_LPT2_in(displayUnit="kg/m3") = 0.862546399,
    mdot_total=2017.871475,
    mdot_fh=574.9232334,
    mdpt_HPFH=20,
    mdot_hpt=1442.948241,
    mdot_lpt1=1442.948241,
    mdot_lpt2=1141.274089,
    m_ext=m_ext)
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  //  mdot_lpt2=995.6849312,
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=4,
    h=192e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-38})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={2,-62})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=P_demand*100000)
    annotation (Placement(transformation(extent={{-98,-78},{-78,-58}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={164,52})));
  NHES.Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{162,22},{178,6}})));
  PrimaryHeatSystem.FourLoopPWR.Components.NSSS_SEC_LoadFollow PHS
    annotation (Placement(transformation(extent={{-144,-10},{-100,34}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=7340000,
    T_start=562.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    use_HeatPort=true,
    Q_gen(displayUnit="MW"))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,40})));
  Fluid.Valves.FlowCV flowCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=0)
    annotation (Placement(transformation(extent={{14,50},{34,70}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{52,70},{72,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{128,68},{108,88}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=50e5)
    annotation (Placement(transformation(extent={{174,74},{194,94}})));
initial equation

equation
  breaker=1/Boo;
// assert(P_ext>bypassdump.medium.p_bar, "Extraction Pressure is below usage pressure",level = AssertionLevel.error);

//  eta_th=(-BOP.port_a_elec.W-BOP.pump.W-BOP.pump1.W-BOP.FWCP.W)/volume.heatPort.Q_flow;
//  eta_CHP=(-BOP.port_a_elec.W-BOP.pump.W-BOP.pump1.W-BOP.FWCP.W+Q_util)/volume.heatPort.Q_flow;
  Q_util = sensor_m_flow.m_flow * ( BOP.LPT1_bypass_valve.port_b.h_outflow-bypassdump1.h);

  connect(stateSensor1.statePort, stateDisplay2.statePort) annotation (Line(
        points={{-28.945,26.05},{-28,26.05},{-28,45.1}},color={0,0,0}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{2,86},{6,86},{6,38},{16,38}},
                                               color={0,127,255}));
  connect(stateSensor2.port_a, BOP.port_b_feed) annotation (Line(points={{-20,-10},
          {16,-10}},                 color={0,127,255}));
  connect(sensor_m_flow.port_a, BOP.port_b_bypass)
    annotation (Line(points={{2,-52},{2,8},{16,8}},     color={0,127,255}));
  connect(sensor_m_flow.port_b, bypassdump.ports[1])
    annotation (Line(points={{2,-72},{2,-76},{-20,-76}},
                                                 color={0,127,255}));
  connect(bypassdump1.ports[1], BOP.port_a_cond)
    annotation (Line(points={{86,-28},{86,0.8},{77.8,0.8}},
                                                 color={0,127,255}));
  connect(realExpression.y, bypassdump.p_in)
    annotation (Line(points={{-77,-68},{-44.2,-68}},
                                                   color={0,0,127}));
  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{76,8},{86,8},
          {86,2},{162,2},{162,14}},                 color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{182.5,-1},{182.5,
          4},{178,4},{178,14.16}},
                             color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{170,21.52},{170,42.4},
          {164,42.4}},                 color={0,0,127}));
  connect(stateDisplay1.statePort, stateSensor2.statePort) annotation (Line(
        points={{-28,-27.1},{-29.045,-27.1},{-29.045,-10.05}}, color={0,0,0}));
  connect(PHS.port_b, volume.port_a) annotation (Line(points={{-100,20.8},{-80,
          20.8},{-80,34}}, color={0,127,255}));
  connect(volume.port_b, stateSensor1.port_a) annotation (Line(points={{-80,46},
          {-80,54},{-54,54},{-54,26},{-40,26}}, color={0,127,255}));
  connect(stateSensor2.port_b, PHS.port_a) annotation (Line(points={{-38,-10},{
          -90,-10},{-90,3.2},{-100,3.2}}, color={0,127,255}));
  connect(stateSensor1.port_b, flowCV.port_a) annotation (Line(points={{-18,26},
          {2,26},{2,46},{12,46},{12,60},{14,60}}, color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a_steam)
    annotation (Line(points={{-18,26},{16,26}}, color={0,127,255}));
  connect(sensor_m_flow1.m_flow, bypassdump1.m_flow_in) annotation (Line(points
        ={{62,56.4},{108,56.4},{108,-56},{78,-56},{78,-48}}, color={0,0,127}));
  connect(sensor_m_flow1.port_b, boundary1.ports[1]) annotation (Line(points={{72,
          60},{102,60},{102,78},{108,78}}, color={0,127,255}));
  connect(flowCV.port_b, sensor_m_flow1.port_a)
    annotation (Line(points={{34,60},{52,60}}, color={0,127,255}));
  connect(realExpression1.y, boundary1.p_in) annotation (Line(points={{195,84},{
          200,84},{200,100},{130,100},{130,86}}, color={0,0,127}));
  annotation (experiment(
      StopTime=57600,
      Interval=100,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Three-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>The ThreeStaged Turbine BOP model contains four control elements: </p>
<p>1. maintaining steam (steam generator outlet) pressure by using TCV</p>
<p>2. controling amount of electricity generated by using LPTBV1</p>
<p>3. maintaining feedwater temperature by using LPTBV2</p>
<p>4. maintaining steam (steam generator outlet) temperature by controlling feedwater pump RPM</p>
</html>"),
    __Dymola_Commands(executeCall=Design.Experimentation.sweepParameter(
          Design.Internal.Records.ModelDependencySetup(
          Model=
            "NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples.Rankine_HTGR_Test_AR",
          dependencyParameters={Design.Internal.Records.DependencyParameter(
            name="hTGR_PebbleBed_Primary_Loop.CS.const11.k", values=linspace(
            1e-05,
            1e-06,
            6))},
          VariablesToPlot={Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.CS.CR.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.Q_total.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.fuelModel[2].T_Fuel")},
          integrator=Design.Internal.Records.Integrator(
            startTime=0,
            stopTime=1004200,
            numberOfIntervals=0,
            outputInterval=10,
            method="Esdirk45a",
            tolerance=0.0001,
            fixedStepSize=0)))),
    __Dymola_experimentSetupOutput(events=false));
end NSSS_Test_b_SEC_1LPT;
