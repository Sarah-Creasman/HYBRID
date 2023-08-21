within NHES.Systems.PrimaryHeatSystem.MSR.CS;
model CS_1

  extends MSR.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    yMax=20000,
    yMin=-990)
    annotation (Placement(transformation(extent={{-44,-16},{-8,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=120e5)
    annotation (Placement(transformation(extent={{-172,-2},{-152,18}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{38,8},{58,28}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=4400)
    annotation (Placement(transformation(extent={{-94,32},{-74,52}})));
equation

  connect(realExpression.y, PID.u_s) annotation (Line(points={{-151,8},{-58,
          8},{-58,2},{-47.6,2}}, color={0,0,127}));
  connect(sensorBus.SG_pressure, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-28},{-26,-28},{-26,-19.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PID.y, add.u2) annotation (Line(points={{-6.2,2},{28,2},{28,12},{
          36,12}}, color={0,0,127}));
  connect(actuatorBus.pump_speed, add.y) annotation (Line(
      points={{30,-100},{30,4},{59,4},{59,18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, realExpression1.y) annotation (Line(points={{36,24},{-66,24},
          {-66,42},{-73,42}},     color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_1;
