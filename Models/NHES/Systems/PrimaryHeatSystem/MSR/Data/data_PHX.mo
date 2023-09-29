within NHES.Systems.PrimaryHeatSystem.MSR.Data;
model data_PHX
  "Primary heat exchanger: Tube - Primary Fuel Salt, Shell - Primary Coolant Salt"
  extends TRANSFORM.Icons.Record;
import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
import TRANSFORM.Units.Conversions.Functions.MassFlowRate_kg_s.from_lbm_hr;
import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
import from_inch =
       TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
parameter Real nHX_total = 6 "Total # of HXs";
parameter Real nParallel = 3 "# of parallel HX loops";
parameter Real nHX_loop = nHX_total/nParallel "# of HXs per loop";
  parameter Modelica.Units.SI.Power Qt_capacity=125e6 "Nominal capacity per HX";
parameter String Material = "Alloy-N" "HX material";
  parameter Modelica.Units.SI.Temperature T_inlet_tube=from_degF(1250)
    "Inlet temperature";
  parameter Modelica.Units.SI.Temperature T_outlet_tube=from_degF(1050)
    "Outlet temperature";
  parameter Modelica.Units.SI.Temperature T_inlet_shell=from_degF(900)
    "Inlet temperature";
  parameter Modelica.Units.SI.Temperature T_outlet_shell=from_degF(1100)
    "Outlet temperature";
  parameter Modelica.Units.SI.PressureDifference dp_tube=from_psi(127)
    "Pressure drop";
  parameter Modelica.Units.SI.Pressure p_inlet_tube=from_psi(180)
    "Inlet pressure";
                                                                     //taken from MSBR
  parameter Modelica.Units.SI.Pressure p_outlet_tube=p_inlet_tube - dp_tube
    "Outlet pressure";
  parameter Modelica.Units.SI.PressureDifference dp_shell=from_psi(115)
    "Pressure drop";
  parameter Modelica.Units.SI.Pressure p_inlet_shell=from_psi(149)
    "Inlet pressure";                                                 //taken from MSBR
  parameter Modelica.Units.SI.Pressure p_outlet_shell=p_inlet_shell - dp_shell
    "Outlet pressure";
  parameter Modelica.Units.SI.MassFlowRate m_flow_tube=from_lbm_hr(6.6e6)
    "Mass flow rate per HX";
  parameter Modelica.Units.SI.MassFlowRate m_flow_shell=from_lbm_hr(3.7e6)
    "Mass flow rate per HX";
  parameter Modelica.Units.SI.Length th_tube=from_inch(0.035) "Tube thickness";
  parameter Modelica.Units.SI.Length D_tube_outer=from_inch(0.375)
    "Tube outer diameter";
  parameter Modelica.Units.SI.Length D_tube_inner=D_tube_outer - 2*th_tube
    "Tube inner diameter";
  parameter Modelica.Units.SI.Length th_shell=from_inch(0.5) "Shell thickness";
  parameter Modelica.Units.SI.Length D_shell_inner=from_inch(26.32)
    "Shell inner diameter";
parameter Real nTubes = 1368 "# of tubes";
parameter String pitchType = "Triangular" "Tube pitch type";
  parameter Modelica.Units.SI.Length pitch_tube=from_inch(0.672) "Tube pitch";
  parameter Modelica.Units.SI.Length length_tube=from_inch(30*12)
    "Tubesheet to tubesheet distance";
  parameter Modelica.Units.SI.Area surfaceArea_tubeouter=D_tube_outer*Modelica.Constants.pi
      *length_tube*nTubes "Surface area outer tube basis";                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(4024);
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=
      TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(
      700);
parameter Real nBaffles = 47 "# of baffles";
parameter String baffleType="Disk and Dougnut" "Baffle type";
  parameter Modelica.Units.SI.Length spacing_baffle=from_inch(7.7)
    "Distance between baffles";
  parameter Modelica.Units.SI.Length D_diskBaffle=from_inch(19)
    "Outer diameter of disk type baffle";
  parameter Modelica.Units.SI.Length D_doughnutBaffle=from_inch(18.6)
    "Inner diameter of doughnut type baffle";
end data_PHX;
