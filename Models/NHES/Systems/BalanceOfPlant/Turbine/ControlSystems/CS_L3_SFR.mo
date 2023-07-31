within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L3_SFR

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=data.HPT_p_in)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  replaceable Modelica.Blocks.Sources.RealExpression Power_set(y=data.Power_nom)
    annotation (choices(choice( redeclare Modelica.Blocks.Sources.Ramp Power_set),
                        choice( redeclare Modelica.Blocks.Sources.Step Power_set),
                        choice( redeclare Modelica.Blocks.Sources.Sine Power_set),
                        choice( redeclare Modelica.Blocks.Sources.Trapezoid Power_set)),
                          Placement(transformation(extent={{-100,-40},{-80,
            -20}})));
  TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-1,
    Ti=30,
    yMax=2*data.mdot_hpt,
    yMin=data.mdot_hpt*0.1)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  TRANSFORM.Controls.LimPID TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-7e-9,
    Ti=360,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));
  TRANSFORM.Controls.LimPID LPT1_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-8,
    Ti=300,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  TRANSFORM.Controls.LimPID LPT2_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=15,
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
    offset=0,
    startTime=8000)
    annotation (Placement(transformation(extent={{-66,-210},{-46,-190}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{96,-172},{116,-152}})));
  Modelica.Blocks.Sources.RealExpression T_in_set1(y=data.mdot_hpt)
    annotation (Placement(transformation(extent={{4,64},{24,84}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{38,72},{58,92}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=2)
    annotation (Placement(transformation(extent={{-10,114},{10,134}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime=40000)
    annotation (Placement(transformation(extent={{150,72},{170,92}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{198,30},{218,50}})));
  Modelica.Blocks.Sources.RealExpression T_in_set2(y=1)
    annotation (Placement(transformation(extent={{164,22},{184,42}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{106,18},{126,38}})));
equation

  connect(T_feed_set.y, LPT2_BV_PID.u_s)
    annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
  connect(Power_set.y, LPT1_BV_PID.u_s)
    annotation (Line(points={{-79,-30},{-12,-30}}, color={0,0,127}));
  connect(sensorBus.W_total, LPT1_BV_PID.u_m) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-50},{0,-50},{0,-42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.LPT1_BV, LPT1_BV_PID.y) annotation (Line(
      points={{30,-100},{30,-30},{11,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
  connect(ramp.y, add.u2) annotation (Line(points={{-45,-200},{86,-200},{86,
          -168},{94,-168}}, color={0,0,127}));
  connect(actuatorBus.TBV, add.y) annotation (Line(
      points={{30,-100},{30,-136},{117,-136},{117,-162}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, add.u1) annotation (Line(points={{41,-150},{84,-150},{
          84,-156},{94,-156}}, color={0,0,127}));
  connect(FeedPump_PID.y, switch2.u1)
    annotation (Line(points={{11,90},{36,90}}, color={0,0,127}));
  connect(switch2.u3, T_in_set1.y)
    annotation (Line(points={{36,74},{25,74}}, color={0,0,127}));
  connect(booleanStep.y, switch2.u2) annotation (Line(points={{11,124},{36,
          124},{36,82}}, color={255,0,255}));
  connect(actuatorBus.Feed_Pump_Speed, switch2.y) annotation (Line(
      points={{30,-100},{30,-24},{66,-24},{66,54},{74,54},{74,82},{59,82}},
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
    annotation (Line(points={{171,82},{196,82},{196,40}}, color={255,0,255}));
  connect(booleanStep1.y,switch4. u2) annotation (Line(points={{171,82},{176,82},
          {176,48},{94,48},{94,28},{104,28}},   color={255,0,255}));
  connect(LPT2_BV_PID.y,switch5. u1) annotation (Line(points={{11,50},{30,50},{
          30,42},{96,42},{96,58},{196,58},{196,48}},
                              color={0,0,127}));
  connect(T_in_set2.y,switch5. u3)
    annotation (Line(points={{185,32},{196,32}}, color={0,0,127}));
  connect(actuatorBus.LPT2_BV,switch5. y) annotation (Line(
      points={{30,-100},{30,12},{226,12},{226,40},{219,40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Feedwater_Temp,switch4. u1) annotation (Line(
      points={{-30,-100},{-30,30},{94,30},{94,36},{104,36}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_feed_set.y,switch4. u3) annotation (Line(points={{-79,50},{-20,50},
          {-20,26},{94,26},{94,20},{104,20}},
                              color={0,0,127}));
  connect(switch4.y, LPT2_BV_PID.u_m) annotation (Line(points={{127,28},{132,28},
          {132,44},{16,44},{16,28},{0,28},{0,38}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L3_SFR;