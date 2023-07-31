within NHES.Desalination.MEE.Examples;
model MEE_ss_test "Test of a single effect with constant UA"

  Multiple_Effect.MEE_FC_ss mEE_FC_ss_delay(
                                      redeclare replaceable Data.MEE_Data
      data(nE=12, T_b_in=333.15), Cs_in=0.01)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=5,
    T=396.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,22},{-100,42}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,-38},{-100,-18}})));
equation
  connect(boundary1.ports[1], mEE_FC_ss_delay.port_b) annotation (Line(
        points={{-100,-28},{-50,-28},{-50,-24},{-40,-24}}, color={0,127,255}));
  connect(mEE_FC_ss_delay.port_a, boundary.ports[1]) annotation (Line(
        points={{-40,24},{-94,24},{-94,32},{-100,32}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),                               graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=500,
      Interval=0.5,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_ss_test;