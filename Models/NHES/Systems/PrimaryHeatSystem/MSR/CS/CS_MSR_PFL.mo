within NHES.Systems.PrimaryHeatSystem.MSR.CS;
model CS_MSR_PFL

  extends MSR.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression inlet_temp(y=500)
    annotation (Placement(transformation(extent={{-78,0},{-28,18}})));
  Modelica.Blocks.Sources.RealExpression feedwater_temp(y=data_CS.Feed_Temp_ref)
    annotation (Placement(transformation(extent={{-68,42},{-18,60}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e7,
    yMax=5000,
    yMin=4000,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    Ti=5) annotation (Placement(transformation(extent={{28,62},{48,42}})));
  MoltenSaltReactor.Data.data_CS data_CS(Feed_Temp_ref=866.15)
    annotation (Placement(transformation(extent={{-94,-88},{-74,-68}})));
equation

  connect(feedwater_temp.y, PID.u_s) annotation (Line(points={{-15.5,51},{18,51},
          {18,52},{26,52}}, color={0,0,127}));
  connect(actuatorBus.pump_speed, PID.y) annotation (Line(
      points={{30,-100},{30,38},{49,38},{49,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Feed_Temp_input, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-76},{54,-76},{54,74},{38,74},{38,64}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_MSR_PFL;
