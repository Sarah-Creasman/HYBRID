within NHES.Fluid.Machines.Examples.Verification;
model SteamTurbine_Example7_6 "Example 7.6 from Intro to Chemical Engineering"
  extends Modelica.Icons.Example;

  NHES.Utilities.ErrorAnalysis.Errors_AbsRelRMS summary_Error(
    n=1,
    x_1={error_abs},
    x_2={error_exp})
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  package Medium = Modelica.Media.Water.StandardWater "Working fluid";
  parameter SI.MassFlowRate m_flow = 59.02 "Flow rate in cycle";
  parameter SI.Pressure p_steam = 8.6e6 "Steam pressure";
  parameter SI.Temperature T_steam = Modelica.Units.Conversions.from_degC(
                                                              500) "Steam temperature";

  parameter SI.Pressure p_condenser = 1e4 "Condenser pressure";
  parameter SI.Efficiency eta = 0.75 "Overall turbine efficiency";
  parameter SI.Temperature T_condenser = Modelica.Units.Conversions.from_degC(
                                                                  45.8) "Condenser saturated liquid temperature";
  parameter SI.Power Q_capacity = 56.4e6 "Rated steam turbine capacity";

  parameter Real error_exp = 33085.4501 "Expected error between example and model";

  Real error_abs = steamTurbine.Q_mech - Q_capacity;

  Modelica.Fluid.Sources.Boundary_pT
                source(
    nPorts=1,
    use_p_in=false,
    p(displayUnit="kPa") = p_steam,
    T=T_steam,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
       3000/60*3.14159)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Fluid.Sources.Boundary_pT
              sink(
    nPorts=1,
    use_p_in=false,
    p(displayUnit="kPa") = p_condenser,
    T=T_condenser,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{30,-30},{10,-50}})));
  inner NHES.Fluid.System_TP system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  SteamTurbineStodola steamTurbine(
    p_a_start(displayUnit="kPa") = p_steam,
    p_b_start(displayUnit="kPa") = p_condenser,
    T_a_start=T_steam,
    T_b_start=T_condenser,
    redeclare model Eta_wetSteam =
        BaseClasses.WetSteamEfficiency.eta_Constant (
         eta_nominal=eta),
    m_flow_start=m_flow,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation

  connect(steamTurbine.shaft_b, constantSpeed.flange)
    annotation (Line(points={{10,0},{20,0}},           color={0,0,0}));
  connect(source.ports[1],steamTurbine.portHP)  annotation (Line(points={{-30,20},
          {-20,20},{-20,6},{-10,6}},          color={0,127,255}));
  connect(steamTurbine.portLP, sink.ports[1]) annotation (Line(points={{7,-10},
          {7,-40},{10,-40}},       color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(__Dymola_NumberOfIntervals=10),
    Documentation(info="<html>
<p>The is a comparison of the steam turbine results using the conditions and comparing the results specified in Example 7.6 in the source.</p>
<p><br>References:</p>
<p>Smith, J.M., Vand Ness, H.C., Abbott, M.M.m &apos;Introduction to Chemical Engineering Thermodynamics 7E,&apos;</p>
<p>pg. 269-270, Example 7.6, 2005.</p>
</html>"));
end SteamTurbine_Example7_6;
