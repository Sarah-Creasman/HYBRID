within NHES.Desalination.MEE.Components;
model SEE_Tube_Side_Ue
 import Modelica.Fluid.Types.Dynamics;
 replaceable package Medium = Modelica.Media.Water.StandardWater;
 Medium.ThermodynamicState state_tube;
 input Modelica.Units.SI.Area Ax;
 Modelica.Units.SI.Temperature T_shell;
 Modelica.Units.SI.Temperature T_tube;
 Modelica.Units.SI.SpecificEnthalpy h_f;
 Modelica.Units.SI.SpecificEnthalpy h_in;
 Modelica.Units.SI.SpecificEnthalpy h_out;
 Modelica.Units.SI.AbsolutePressure p;
 Modelica.Units.SI.CoefficientOfHeatTransfer U;
 Modelica.Units.SI.Power Q;
 Modelica.Units.SI.MassFlowRate mdot;







  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow heat_port
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
equation

  h_f=Medium.bubbleEnthalpy(Medium.setSat_p(p));
  state_tube=Medium.setState_ph(p,((h_in+h_out)/2));
  T_tube=state_tube.T;
  U=(1939.4+1.40562*(T_shell-273.15)-0.020725
                                            *((T_shell-273.15)^2)+0.0023186
                                                                 *((T_shell-273.15)^3));
  Q=Ax*U*(T_tube-T_shell);
  h_out=h_in-(Q/mdot);

  //Connectors
  port_b.p = p;
  port_b.h_outflow=h_out;
 - mdot=port_b.m_flow;

  port_a.p = p;
  mdot=port_a.m_flow;
  port_a.h_outflow = Medium.dewEnthalpy(Medium.setSat_p(p));
  h_in =inStream(port_a.h_outflow);
  T_shell=heat_port.T;
  Q =-heat_port.Q_flow;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,127,255}, if showColors then dynColor
               else {0,127,255})),
        Polygon(
          points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{-26,
              0},{-16,4},{0,20},{68,40}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,42},{90,34}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,-32},{90,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-100,-40},{100,-60}},
          textColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SEE_Tube_Side_Ue;