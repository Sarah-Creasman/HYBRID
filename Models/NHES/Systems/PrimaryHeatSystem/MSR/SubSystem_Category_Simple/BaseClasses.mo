within NHES.Systems.PrimaryHeatSystem.MSR.SubSystem_Category_Simple;
package BaseClasses

extends Modelica.Icons.BasesPackage;

  partial model Partial_SubSystem

    extends NHES.Systems.BaseClasses.Partial_SubSystem;

    annotation (
      defaultComponentName="changeMe",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-94,-76},{94,-84}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="changeMe")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,140}})));
  end Partial_SubSystem;

  model SubSystem_PlaceHolder

    extends Partial_SubSystem;
    extends NHES.Icons.PlaceHolder;

    annotation (defaultComponentName="SES",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SubSystem_PlaceHolder;
end BaseClasses;
