within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model BOP_test
  extends Modelica.Icons.Example;
  parameter Real P_ext=138;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext= 42.55456924 "kg/m3";
  parameter Modelica.Units.SI.MassFlowRate m_ext=0;

  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_HTGR_extraction
      CS(
      data(
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
      LPT1_BV_PID(k=5e-11, Ti=300)),
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
    LPT1_bypass_valve(dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=10*m_ext))
    annotation (Placement(transformation(extent={{58,-20},{118,40}})));
     // booleanStep2(startTime=100000),
      //Steam_Extraction(y=data.m_ext),
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=2000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-24,-72},{-4,-52}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{194,22},{174,42}})));
  NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
    HPT_p_in=14000000,
    p_dump=16000000,
    p_i1=P_ext*100000,
    Tin=788.15,
    Tfeed=481.15,
    d_HPT_in(displayUnit="kg/m3") = 43.049187,
    d_LPT1_in(displayUnit="g/cm3") = d_ext,
    d_LPT2_in(displayUnit="kg/m3"),
    mdot_total=40.44025635,
    mdot_fh=8.5063954,
    mdot_hpt=31.93386095,
    mdot_lpt1=31.93386095,
    mdot_lpt2=28.04335968,
    m_ext=m_ext,
    eta_t=0.9,
    eta_mech=0.99,
    eta_p=0.8)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=40,
    h=3366e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-44,14},{-24,34}})));

  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{170,66},{190,86}})));
  NHES.Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{140,42},{160,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=14000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-42,-18},{-22,2}})));
initial equation

equation

  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{20,84},{52,84},{52,40},{58,40}},
                                               color={0,127,255}));
  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{118,10},{134,
          10},{134,32},{140,32}},                   color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{174,32},{167,
          32},{167,32.2},{160,32.2}},
                             color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{150,41.4},{150,76},
          {168,76}},                   color={0,0,127}));
  connect(bypassdump1.ports[1], BOP.port_a_steam) annotation (Line(points={{-24,
          24},{48,24},{48,28},{58,28}}, color={0,127,255}));
  connect(bypassdump.ports[1], BOP.port_b_feed) annotation (Line(points={{-4,-62},
          {48,-62},{48,-8},{58,-8}}, color={0,127,255}));
  connect(bypassdump2.ports[1], BOP.port_b_bypass) annotation (Line(points={{-22,
          -8},{44,-8},{44,10},{58,10}}, color={0,127,255}));
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
end BOP_test;
