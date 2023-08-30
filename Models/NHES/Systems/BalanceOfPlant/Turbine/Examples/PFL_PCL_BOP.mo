within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model PFL_PCL_BOP
  extends Modelica.Icons.Example;
  parameter Real P_ext=138;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext= 42.55456924 "kg/m3";
  parameter Modelica.Units.SI.MassFlowRate m_ext=0;

  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_3 CS(data(
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
        eta_p=data.eta_p)),
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
    moistureSeperator(T_start=373.15),
    pump1(p_nominal=10500000))
    annotation (Placement(transformation(extent={{56,-20},{116,40}})));
     // booleanStep2(startTime=100000),
      //Steam_Extraction(y=data.m_ext),
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{194,22},{174,42}})));

  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{170,66},{190,86}})));
  NHES.Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{140,42},{160,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=14000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-44,-72},{-18,-46}})));
  Data.Data_L3 data(
    HPT_p_in=12000000,
    p_dump=20000000,
    p_i1=2000000,
    p_i2=150000,
    cond_p=10000,
    Tin=813.15,
    Tfeed=473.15,
    d_HPT_in(displayUnit="kg/m3") = 34.69607167,
    d_LPT1_in(displayUnit="kg/m3") = 8.189928251,
    d_LPT2_in(displayUnit="kg/m3") = 0.862546399,
    mdot_total=288.5733428,
    mdot_fh=56.4311671,
    mdot_hpt=232.1421757,
    mdot_lpt1=232.1421757,
    mdot_lpt2=217.0235411,
    m_ext=1,
    eta_t=0.93,
    eta_mech=1,
    eta_p=0.9)
    annotation (Placement(transformation(extent={{-88,62},{-68,82}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-4,56},{16,76}})));
  PrimaryHeatSystem.MSR.Examples.MCA_Base_withBOP_PFL_Only
    mCA_Base_withBOP_PFL_Only(PHX(nParallel=24))
    annotation (Placement(transformation(extent={{-122,24},{-102,44}})));
  PrimaryHeatSystem.MSR.Examples.PCL_PortsBothSides_NoPHXPressureFIx
    pCL_PortsBothSides_NoPHX(CS(realExpression(y=120e5)))
    annotation (Placement(transformation(extent={{-44,20},{-24,40}})));
initial equation

equation

  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{116,10},{
          134,10},{134,32},{140,32}},               color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{174,32},{167,
          32},{167,32.2},{160,32.2}},
                             color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{150,41.4},{150,76},
          {168,76}},                   color={0,0,127}));
  connect(bypassdump2.ports[1], BOP.port_b_bypass) annotation (Line(points={{-18,-59},
          {-18,-60},{-6,-60},{-6,10},{56,10}},
                                        color={0,127,255}));
  connect(BOP.prt_b_steamdump, steamdump.ports[1]) annotation (Line(points={{56,
          40},{22,40},{22,66},{16,66}}, color={0,127,255}));
  connect(pCL_PortsBothSides_NoPHX.port_b, BOP.port_a_steam) annotation (Line(
        points={{-24.2,34.8},{46,34.8},{46,28},{56,28}}, color={0,127,255}));
  connect(pCL_PortsBothSides_NoPHX.port_a, BOP.port_b_feed) annotation (Line(
        points={{-24.2,27.6},{-10,27.6},{-10,-10},{48,-10},{48,-8},{56,-8}},
        color={0,127,255}));
  connect(pCL_PortsBothSides_NoPHX.port_b1, mCA_Base_withBOP_PFL_Only.port_a)
    annotation (Line(points={{-43.8,27.4},{-102,27.4},{-102,31}},   color={0,
          127,255}));
  connect(pCL_PortsBothSides_NoPHX.port_a1, mCA_Base_withBOP_PFL_Only.port_b)
    annotation (Line(points={{-43.8,34.6},{-102,34.6},{-102,38.4}},   color={0,
          127,255}));
  annotation (experiment(
      StopTime=100000,
      Interval=5,
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
end PFL_PCL_BOP;
