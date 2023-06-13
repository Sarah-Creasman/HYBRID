within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L3_SMR_extraction

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=data.HPT_p_in)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-4,
    Ti=10,
    yMax=2*data.mdot_total,
    yMin=data.mdot_total*0.5)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  TRANSFORM.Controls.LimPID TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-10,
    Ti=1000,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));
  TRANSFORM.Controls.LimPID LPT2_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-8,
    Ti=200,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=data.HPT_p_in, uHigh=
        data.p_dump)
    annotation (Placement(transformation(extent={{-20,-140},{0,-160}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open0(y=0)
    annotation (Placement(transformation(extent={{-20,-184},{0,-164}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open1(y=1)
    annotation (Placement(transformation(extent={{-20,-146},{0,-126}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=4000,
    offset=1,
    startTime=8000)
    annotation (Placement(transformation(extent={{-66,-210},{-46,-190}})));
  Modelica.Blocks.Math.Product
                           product1
    annotation (Placement(transformation(extent={{96,-172},{116,-152}})));
  Modelica.Blocks.Sources.RealExpression T_in_set1(y=data.mdot_total)
    annotation (Placement(transformation(extent={{2,64},{22,84}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{38,72},{58,92}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=4000)
    annotation (Placement(transformation(extent={{-10,114},{10,134}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{42,20},{62,40}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime=1200000)
    annotation (Placement(transformation(extent={{86,74},{106,94}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{134,32},{154,52}})));
  Modelica.Blocks.Sources.RealExpression T_in_set2(y=0.03)
    annotation (Placement(transformation(extent={{100,24},{120,44}})));
  replaceable Modelica.Blocks.Sources.Ramp           Steam_Extraction(duration=
        1e7, startTime=1e7) constrainedby
    Modelica.Blocks.Sources.RealExpression
    annotation (choices(
      choice(redeclare Modelica.Blocks.Sources.Ramp Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Step Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Sine Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Trapezoid Steam_Extraction)), Placement(
        transformation(extent={{-222,-36},{-202,-16}})));
  TRANSFORM.Controls.LimPID LPT1_BV_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=300,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-104,-36},{-84,-16}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set2(y=0)
    annotation (Placement(transformation(extent={{-144,-64},{-124,-44}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2(startTime=1e7)
    annotation (Placement(transformation(extent={{-194,-66},{-174,-46}})));
equation

  connect(T_feed_set.y, LPT2_BV_PID.u_s)
    annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
  connect(P_in_set.y, TCV_PID.u_s)
    annotation (Line(points={{-79,10},{-14,10}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, TCV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-10},{-2,-10},{-2,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_TCV, TCV_PID.y) annotation (Line(
      points={{30.1,-99.9},{30,-99.9},{30,10},{9,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_in_set.y, FeedPump_PID.u_s)
    annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{1,-150},{18,-150}}, color={255,0,255}));
  connect(sensorBus.Steam_Pressure, hysteresis.u) annotation (Line(
      points={{-30,-100},{-30,-150},{-22,-150}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(P_dump_open0.y, switch1.u3) annotation (Line(points={{1,-174},{10,
          -174},{10,-158},{18,-158}}, color={0,0,127}));
  connect(switch1.u1, P_dump_open1.y) annotation (Line(points={{18,-142},{6,
          -142},{6,-136},{1,-136}}, color={0,0,127}));
  connect(ramp.y, product1.u2) annotation (Line(points={{-45,-200},{86,-200},{
          86,-168},{94,-168}}, color={0,0,127}));
  connect(actuatorBus.TBV, product1.y) annotation (Line(
      points={{30,-100},{30,-136},{117,-136},{117,-162}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, product1.u1) annotation (Line(points={{41,-150},{84,-150},
          {84,-156},{94,-156}}, color={0,0,127}));
  connect(FeedPump_PID.y, switch2.u1)
    annotation (Line(points={{11,90},{36,90}}, color={0,0,127}));
  connect(switch2.u3, T_in_set1.y)
    annotation (Line(points={{36,74},{23,74}}, color={0,0,127}));
  connect(booleanStep.y, switch2.u2) annotation (Line(points={{11,124},{36,
          124},{36,82}}, color={255,0,255}));
  connect(actuatorBus.Feed_Pump_Speed, switch2.y) annotation (Line(
      points={{30,-100},{30,44},{74,44},{74,82},{59,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanStep.y, switch3.u2) annotation (Line(points={{11,124},{16,
          124},{16,106},{-28,106},{-28,82},{-62,82},{-62,70},{-56,70}},
        color={255,0,255}));
  connect(switch3.y, FeedPump_PID.u_m) annotation (Line(points={{-33,70},{
          -18,70},{-18,78},{0,78}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, switch3.u1) annotation (Line(
      points={{-30,-100},{-30,44},{-72,44},{-72,80},{-56,80},{-56,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_in_set.y, switch3.u3) annotation (Line(points={{-79,90},{-64,90},
          {-64,62},{-56,62}}, color={0,0,127}));
  connect(booleanStep1.y,switch5. u2)
    annotation (Line(points={{107,84},{132,84},{132,42}}, color={255,0,255}));
  connect(booleanStep1.y,switch4. u2) annotation (Line(points={{107,84},{112,84},
          {112,50},{76,50},{76,14},{32,14},{32,30},{40,30}},
                                                color={255,0,255}));
  connect(T_feed_set.y,switch4. u3) annotation (Line(points={{-79,50},{-20,50},
          {-20,26},{32,26},{32,22},{40,22}},
                              color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,switch4. u1) annotation (Line(
      points={{-30,-100},{-30,56},{40,56},{40,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch4.y, LPT2_BV_PID.u_m) annotation (Line(points={{63,30},{63,46},
          {16,46},{16,30},{0,30},{0,38}},   color={0,0,127}));
  connect(LPT2_BV_PID.y,switch5. u1) annotation (Line(points={{11,50},{124,50},
          {124,58},{132,58},{132,50}},
                              color={0,0,127}));
  connect(T_in_set2.y,switch5. u3)
    annotation (Line(points={{121,34},{132,34}}, color={0,0,127}));
  connect(sensorBus.Extract_flow, LPT1_BV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-48},{-94,-48},{-94,-38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(LPT1_BV_PID.y, switch6.u1) annotation (Line(points={{-83,-26},{-28,
          -26},{-28,-24},{-22,-24},{-22,-32}}, color={0,0,127}));
  connect(T_feed_set2.y, switch6.u3) annotation (Line(points={{-123,-54},{-73.5,
          -54},{-73.5,-48},{-22,-48}}, color={0,0,127}));
  connect(booleanStep2.y, switch6.u2) annotation (Line(points={{-173,-56},{-150,
          -56},{-150,-38},{-110,-38},{-110,-46},{-32,-46},{-32,-40},{-22,-40}},
        color={255,0,255}));
  connect(actuatorBus.LPT2_BV, switch5.y) annotation (Line(
      points={{30,-100},{30,12},{162,12},{162,42},{155,42}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.LPT1_BV, switch6.y) annotation (Line(
      points={{30,-100},{30,-40},{1,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Steam_Extraction.y, LPT1_BV_PID.u_s)
    annotation (Line(points={{-201,-26},{-106,-26}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L3_SMR_extraction;