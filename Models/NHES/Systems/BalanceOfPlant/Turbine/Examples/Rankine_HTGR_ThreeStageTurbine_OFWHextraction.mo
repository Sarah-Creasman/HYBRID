within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model Rankine_HTGR_ThreeStageTurbine_OFWHextraction
  extends Modelica.Icons.Example;
  parameter Real P_ext=110;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext= 32.34901428
 "kg/m3";
  parameter Modelica.Units.SI.MassFlowRate m_ext=232;
  Real breaker;
  parameter Real Boo=1;

  Real eta_th "Thermal Cycle Efficiency";

  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_6 CS(data(
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
        mdot_hpt=data.mdot_hpt,
        mdot_lpt1=data.mdot_lpt1,
        mdot_lpt2=data.mdot_lpt2,
        m_ext=data.m_ext,
        eta_t=data.eta_t,
        eta_mech=data.eta_mech,
        eta_p=data.eta_p), LPT2_BV_PID(k=1e-7, delayTime=1e5),
      LPT1_BV_PID(k=1e-8, Ti=3000),
      Steam_Extraction(y=m_ext)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
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
    pump1(p_nominal=11000000))
    annotation (Placement(transformation(extent={{60,-20},{120,40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-24,-72},{-4,-52}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{180,28},{160,48}})));
  NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
    HPT_p_in=12000000,
    p_dump=20000000,
    p_i1=P_ext*100000,
    Tin=813.15,
    Tfeed=473.15,
    d_HPT_in(displayUnit="kg/m3"),
    d_LPT1_in(displayUnit="g/cm3") = d_ext,
    d_LPT2_in(displayUnit="kg/m3"),
    mdot_total=288.5733428,
    mdot_fh=56.43116714,
    mdot_hpt=232.1421757,
    mdot_lpt1=232.1421757,
    mdot_lpt2=217.023541,
    m_ext=m_ext,
    eta_t=0.9,
    eta_mech=0.99,
    eta_p=0.8)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=4,
    h=192e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{180,-12},{160,8}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={40,-50})));

  Modelica.Blocks.Sources.Ramp           ramp(
    height=P_demand*1e5 - 1e5,
    duration=1e3,
    offset=1e5,
    startTime=1e3)
    annotation (Placement(transformation(extent={{-80,-64},{-60,-44}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{124,74},{144,94}})));
  NHES.Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{132,50},{152,30}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=813.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen=750e6)
    annotation (Placement(transformation(extent={{-38,10},{-18,30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=100)
    annotation (Placement(transformation(extent={{-2,10},{18,30}})));
initial equation

equation
  breaker=1/Boo;
// assert(P_ext>bypassdump.medium.p_bar, "Extraction Pressure is below usage pressure",level = AssertionLevel.error);

  //hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.TCV.port_a.p;

  eta_th=(-BOP.port_a_elec.W-BOP.pump.W-BOP.pump1.W-BOP.FWCP.W)/7.5e8;
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{20,84},{52,84},{52,40},{60,40}},
                                               color={0,127,255}));
  connect(sensor_m_flow.port_a, BOP.port_b_bypass)
    annotation (Line(points={{40,-40},{40,10},{60,10}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, bypassdump.ports[1])
    annotation (Line(points={{40,-60},{40,-62},{-4,-62}},
                                                 color={0,127,255}));
  connect(bypassdump1.ports[1], BOP.port_a_cond)
    annotation (Line(points={{160,-2},{120,-2}}, color={0,127,255}));
  connect(sensor_m_flow.m_flow, bypassdump1.m_flow_in) annotation (Line(points=
          {{43.6,-50},{184,-50},{184,6},{180,6}}, color={0,0,127}));
  connect(ramp.y, bypassdump.p_in)
    annotation (Line(points={{-59,-54},{-26,-54}}, color={0,0,127}));
  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{120,10},{130,
          10},{130,26},{128,26},{128,40},{132,40}}, color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{160,38},{160,
          40.2},{152,40.2}}, color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{142,49.4},{142,70},
          {112,70},{112,84},{122,84}}, color={0,0,127}));
  connect(BOP.port_b_feed, volume.port_a) annotation (Line(points={{60,-8},{-44,
          -8},{-44,20},{-34,20}}, color={0,127,255}));
  connect(volume.port_b, resistance.port_a)
    annotation (Line(points={{-22,20},{1,20}}, color={0,127,255}));
  connect(resistance.port_b, BOP.port_a_steam) annotation (Line(points={{15,20},
          {50,20},{50,28},{60,28}}, color={0,127,255}));
  annotation (experiment(
      StopTime=10000000,
      Interval=500,
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
end Rankine_HTGR_ThreeStageTurbine_OFWHextraction;
