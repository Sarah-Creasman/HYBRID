within NHES.Systems.BalanceOfPlant.RankineCycle.Data;
model Data_L3 "Density inputs have large effects on nominal turbine pressures"
  extends BaseClasses.Record_Data;
  import NHES.Systems.BalanceOfPlant.RankineCycle.Data.BOP_Type;
  parameter BOP_Type FH_type= BOP_Type.OFWH "Type of Feed Heating";
  parameter Modelica.Units.SI.Pressure HPT_p_in=36e5 "High Pressure Turbine Inlet Pressure" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure p_dump=45e5 "Overpressure Set Pressure  " annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Power Power_nom=5e6 "Electrical Power Nominal";

  parameter Modelica.Units.SI.Pressure p_i1=3e5 "Set Pressure Between High Pressure Turbine and Low Pressure Turbine 1" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure p_i2=1.5e5 "Set Pressure Between Low Pressure Turbine 1 and Low Pressure Turbine 2" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure cond_p=0.1e5 "Condenser Pressure"
                                                   annotation(Dialog(group="Pressure Sets"));

  parameter Modelica.Units.SI.Temperature Tin=573.15 "Inlet Steam Temperature" annotation(Dialog(group="Temperature Sets"));
  parameter Modelica.Units.SI.Temperature Tfeed=331.65 "Target Feed Water Temperature" annotation(Dialog(group="Temperature Sets"));

  parameter Modelica.Units.SI.Density d_HPT_in = 15.07744  "HPT inlet density"  annotation(Dialog(group="Density Sets"));
  parameter Modelica.Units.SI.Density d_LPT1_in = 1.81354   "LPT1 inlet density"  annotation(Dialog(group="Density Sets"));
  parameter Modelica.Units.SI.Density d_LPT2_in = 0.86254   "LPT2 inlet density"  annotation(Dialog(group="Density Sets"));

  parameter Modelica.Units.SI.Pressure HPT_p_out=p_i1 annotation(Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure LPT1_p_in=p_i1 annotation(Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure LPT1_p_out=p_i2 annotation(Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure LPT2_p_in=p_i2 annotation(Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure LPT2_p_out=cond_p annotation(Dialog(tab="Initialization"));

  parameter Modelica.Units.SI.MassFlowRate mdot_total=5.5 "Nominal Total Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_fh= 0.1 "Nominal Controlled Feed Heating Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdpt_HPFH= 0.002 "Set High pressure feedwater heating flow (used in models with both LP and HP feed heating" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_hpt= 5.5 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_lpt1= 5.5 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_lpt2= 4.794 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate m_ext= 1 annotation(Dialog(group="Flow Rate Sets"));

  parameter Real eta_t=0.93 "Isentropic Efficiency of the Turbines" annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_mech=1 "Mechincal Effieiency of the Turbines"  annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_p=0.9 "Isentropic Efficiency of the Pumps" annotation(Dialog(group="Efficiency Sets"));

    //Heat Exchangers
    //Bypass Feedwater Heater
  parameter Real BypassFeedHeater_NTU = 20 "NTU of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Real BypassFeedHeater_K_tube(unit = "1/m4") = 17000 "K value of tube in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Real BypassFeedHeater_K_shell(unit = "1/m4") = 500 "K value of shell in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Volume  BypassFeedHeater_V_tube = 5 "Tube side volume in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Volume  BypassFeedHeater_V_shell = 5 "Shell side volume in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  //Cond Init
  parameter Modelica.Units.SI.Volume  V_condensor_liquid_start = 1.2 "Condensor volume"  annotation (Dialog(tab="Initialization", group = "Condensor"));
  //Bypass Feedwater Heater
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_tube_p_start = 55e5 "Initial Tube pressure of bypass feedwater heater"   annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_shell_p_start = 10e5 "Initial Shell pressure of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_tube_inlet = 1e6 "Initial Tube inlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_tube_outlet = 1.05e6 "Initial Tube outlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_shell_inlet = 3e6 "Initial Shell inlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_shell_outlet = 2.9e6 "Initial Shell outlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Temperature BypassFeedHeater_tube_T_start_inlet = 45+273 "Initial Tube inlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Temperature BypassFeedHeater_tube_T_start_outlet = 200+273 "Initial Tube outlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Temperature BypassFeedHeater_shell_T_start_inlet = 370+273 "Initial Tube inlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Temperature BypassFeedHeater_shell_T_start_outlet = 250+273 "Initial Tube outlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_dp_init_tube = 0 "Initial Tube pressure drop of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_dp_init_shell = 100000 "Initial Shell pressure drop of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.MassFlowRate BypassFeedHeater_m_start_tube = 72 "Initial tube mass flow rate in bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.MassFlowRate BypassFeedHeater_m_start_shell = 10 "Initial shell mass flow rate in main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));
  parameter Modelica.Units.SI.Power  BypassFeedHeater_Q_init = 1e6 "Initial Heat Flow in main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type==NHES.Systems.BalanceOfPlant.Turbine.Data.BOP_Type.CFWH));

   annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"),
    uses(NHES(version="2"), Modelica(version="4.0.0")));
end Data_L3;
