within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.Data;
model data_BOP
  extends TRANSFORM.Icons.Record;
  import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
  parameter Modelica.Units.SI.Pressure p_condenser=1e5;
  parameter Modelica.Units.SI.Pressure p_outlet_HP=from_psi(1146)
    "Outlet pressure from HP turbine";
  parameter Modelica.Units.SI.Pressure p_outlet_LP=from_psi(500)
    "Outlet pressure from HP turbine";
end data_BOP;
