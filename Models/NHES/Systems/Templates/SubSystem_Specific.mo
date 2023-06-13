within NHES.Systems.Templates;
package SubSystem_Specific

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Test
      extends Modelica.Icons.Example;

      SubSystem_Dummy changeMe
        annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})),
        experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput);
    end Test;
  end Examples;

  model SubSystem_Dummy

    extends BaseClasses.Partial_SubSystem(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);

  equation

    annotation (
      defaultComponentName="changeMe",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end SubSystem_Dummy;

  model CS_Dummy

    extends BaseClasses.Partial_ControlSystem;

  equation

  annotation(defaultComponentName="PHS_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Dummy;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="PHS_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;

  package Components

  end Components;

  package Data

    record Data_Dummy

      extends BaseClasses.Record_Data;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Dummy;
  end Data;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;

    partial model Partial_SubSystem

      extends
        NHES.Systems.Templates.SubSystem_Category.BaseClasses.Partial_SubSystem(
          redeclare replaceable BaseClasses.Partial_ControlSystem CS constrainedby
          BaseClasses.Partial_ControlSystem, redeclare replaceable
          BaseClasses.Partial_EventDriver ED constrainedby
          BaseClasses.Partial_EventDriver);

      replaceable Record_Data data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      extends Record_SubSystem;

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;

    partial model Partial_SubSystem_A

      extends Partial_SubSystem;

      extends Record_SubSystem_A;

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));
    end Partial_SubSystem_A;

    partial record Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    partial record Record_SubSystem

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    partial record Record_SubSystem_A

      extends Record_SubSystem;

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem_A;

    partial model Partial_ControlSystem

      extends
        NHES.Systems.Templates.SubSystem_Category.BaseClasses.Partial_ControlSystem;

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_EventDriver

      extends
        NHES.Systems.Templates.SubSystem_Category.BaseClasses.Partial_EventDriver;

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;
  end BaseClasses;
end SubSystem_Specific;
