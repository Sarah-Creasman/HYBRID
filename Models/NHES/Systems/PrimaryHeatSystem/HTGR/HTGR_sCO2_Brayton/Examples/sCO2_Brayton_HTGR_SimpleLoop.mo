within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_sCO2_Brayton.Examples;
model sCO2_Brayton_HTGR_SimpleLoop
  extends Modelica.Icons.Example;
  Components.sCO2_TestLoop pebble_Bed_sCO2_Brayton_Standalone annotation (Placement(transformation(extent={{-62,-48},{50,44}})));
equation

  annotation (experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Simple_Rankine. The simulation should be moving towards steady state operation using the control system to meet exit core temperature of 850C. </p>
<p><br>The simple Rankine integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </p>
<p>This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </p>
</html>"));
end sCO2_Brayton_HTGR_SimpleLoop;