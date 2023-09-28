within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.Data;
model data_CS "Control System Data for Primary Fuel Loop"
  extends TRANSFORM.Icons.Record;
  parameter Modelica.Units.SI.Temperature Feed_Temp_ref=673.15;
  parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref=950;
end data_CS;
