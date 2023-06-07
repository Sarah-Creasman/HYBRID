#include <moutil.c>
PreNonAliasDef(6)
PreNonAliasDef(7)
PreNonAliasDef(8)
PreNonAliasDef(9)
PreNonAliasDef(10)
StartNonAlias(5)
DeclareAlias2("HTSE.AirHXOutTemp.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.AirPort_Out.m_flow", -1, 5, 5506, 132)
DeclareAlias2("HTSE.AirHXOutTemp.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "AirExhaust.p", 1, 7, 798, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "AirExhaust.ports[1].h_outflow", 1, 5, 5603, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "AirExhaust.X[1]", 1, 7, 800, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "AirExhaust.X[2]", 1, 7, 801, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.AirPort_Out.m_flow", 1, 5, 5506, 132)
DeclareAlias2("HTSE.AirHXOutTemp.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "AirExhaust.p", 1, 7, 798, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.AirPort_Out.h_outflow", 1, 5, 5507, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.AirHX.volume_1[20].medium.X[1]", 1, 1, 226, 4)
DeclareAlias2("HTSE.AirHXOutTemp.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.AirHX.volume_1[20].medium.X[2]", 1, 1, 227, 4)
DeclareParameter("HTSE.AirHXOutTemp.m_flow_small", "Regularization for zero flow:|m_flow| < m_flow_small [kg/s]",\
 677, 0.0001, 0.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.AirHXOutTemp.p_start", "Pressure [Pa|bar]", 678, 101325, \
0.0,1E+100,100000.0,0,560)
DeclareVariable("HTSE.AirHXOutTemp.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.AirHXOutTemp.T_start", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("HTSE.AirHXOutTemp.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.AirHXOutTemp.X_start[1]", "Mass fraction [1]", 679, 0.5, \
0.0,1.0,0.0,0,560)
DeclareParameter("HTSE.AirHXOutTemp.X_start[2]", "Mass fraction [1]", 680, 0.5, \
0.0,1.0,0.0,0,560)
DeclareParameter("HTSE.AirHXOutTemp.precision", "Number of decimals displayed [:#(type=Integer)]",\
 681, 0, 0.0,1E+100,0.0,0,564)
DeclareVariable("HTSE.AirHXOutTemp.var", "Variable to be converted [K]", 0.0, \
0.0,1E+100,0.0,0,512)
DeclareVariable("HTSE.AirHXOutTemp.y", "Icon display", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.AirHXOutTemp.T", "Temperature of the passing fluid [K|degC]",\
 "HTSE.AirHXOutTemp.var", 1, 5, 5122, 0)
DeclareVariable("HTSE.AirHXOutTemp.T_a_inflow", "Temperature of inflowing fluid at port_a [K|degC]",\
 500, 200.0,6000.0,500.0,0,2560)
DeclareVariable("HTSE.AirHXOutTemp.T_b_inflow", "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow [K|degC]",\
 500, 200.0,6000.0,500.0,0,2561)
DeclareAlias2("HTSE.condenser.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.FuelHX.port_b1.m_flow", -1, 5, 917, 132)
DeclareAlias2("HTSE.condenser.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareAlias2("HTSE.condenser.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.FuelHXOutTemp.port_a.h_outflow", 1, 5, 5109, 4)
DeclareAlias2("HTSE.condenser.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[1]", 1, 1, 304, 4)
DeclareAlias2("HTSE.condenser.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[2]", 1, 1, 305, 4)
DeclareAlias2("HTSE.condenser.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", -1, 5, 665, 132)
DeclareAlias2("HTSE.condenser.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareAlias2("HTSE.condenser.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.FuelHXOutTemp.port_a.h_outflow", 1, 5, 5109, 4)
DeclareAlias2("HTSE.condenser.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[1]", 1, 1, 304, 4)
DeclareAlias2("HTSE.condenser.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[2]", 1, 1, 305, 4)
DeclareVariable("HTSE.condenser.V", "Volume [m3]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareVariable("HTSE.condenser.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.condenser.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.condenser.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.condenser.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareParameter("HTSE.condenser.p_start", "Pressure [Pa|kPa]", 682, 103800, 0.0,\
1E+100,100000.0,0,560)
DeclareVariable("HTSE.condenser.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.condenser.T_start", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("HTSE.condenser.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.condenser.X_start[1]", "Mass fraction [1]", 683, \
0.0122804, 0.0,1.0,0.0,0,560)
DeclareParameter("HTSE.condenser.X_start[2]", "Mass fraction [1]", 684, \
0.9877196, 0.0,1.0,0.0,0,560)
DeclareVariable("HTSE.condenser.medium.p", "Absolute pressure of medium [Pa|bar]",\
 0.0, 0.0,100000000.0,100000.0,0,513)
DeclareAlias2("HTSE.condenser.medium.Xi[1]", "Structurally independent mass fractions [1]",\
 "HTSE.condenser.medium.X[1]", 1, 1, 304, 0)
DeclareAlias2("HTSE.condenser.medium.Xi[2]", "Structurally independent mass fractions [1]",\
 "HTSE.condenser.medium.X[2]", 1, 1, 305, 0)
DeclareAlias2("HTSE.condenser.medium.der(Xi[1])", "der(Structurally independent mass fractions) [s-1]",\
 "HTSE.condenser.medium.der(X[1])", 1, 6, 304, 0)
DeclareAlias2("HTSE.condenser.medium.der(Xi[2])", "der(Structurally independent mass fractions) [s-1]",\
 "HTSE.condenser.medium.der(X[2])", 1, 6, 305, 0)
DeclareAlias2("HTSE.condenser.medium.h", "Specific enthalpy of medium [J/kg]", \
"HTSE.FuelHXOutTemp.port_a.h_outflow", 1, 5, 5109, 0)
DeclareVariable("HTSE.condenser.medium.d", "Density of medium [kg/m3|g/cm3]", \
0.0, 0.0,100000.0,10.0,0,512)
DeclareVariable("HTSE.condenser.medium.der(d)", "der(Density of medium) [Pa.m-2.s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.medium.T", "Temperature of medium [K|degC]", \
293.15, 200.0,6000.0,500.0,0,513)
DeclareState("HTSE.condenser.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 304, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("HTSE.condenser.medium.der(X[1])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,576)
DeclareState("HTSE.condenser.medium.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 305, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("HTSE.condenser.medium.der(X[2])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,576)
DeclareVariable("HTSE.condenser.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("HTSE.condenser.medium.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("HTSE.condenser.medium.der(R_s)", "der(Gas constant (of mixture if applicable)) [W/(kg.K)]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("HTSE.condenser.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.condenser.medium.p", 1, 5, 5134, 0)
DeclareAlias2("HTSE.condenser.medium.state.T", "Temperature of medium [K|degC]",\
 "HTSE.boundary3.T", 1, 7, 687, 0)
DeclareAlias2("HTSE.condenser.medium.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "HTSE.condenser.medium.X[1]", 1, 1, 304, 0)
DeclareAlias2("HTSE.condenser.medium.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "HTSE.condenser.medium.X[2]", 1, 1, 305, 0)
DeclareVariable("HTSE.condenser.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.condenser.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.condenser.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.m", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("HTSE.condenser.der(m)", "der(Mass) [kg/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.U", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.der(U)", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.mXi[1]", "Species mass [kg]", 0.0, 0.0,1E+100,\
0.0,0,512)
DeclareVariable("HTSE.condenser.mXi[2]", "Species mass [kg]", 0.0, 0.0,1E+100,\
0.0,0,512)
DeclareVariable("HTSE.condenser.der(mXi[1])", "der(Species mass) [kg/s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.condenser.der(mXi[2])", "der(Species mass) [kg/s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.condenser.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "HTSE.condenser.der(m)", 1, 5, 5148, 0)
DeclareAlias2("HTSE.condenser.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "HTSE.condenser.der(U)", 1, 5, 5150, 0)
DeclareAlias2("HTSE.condenser.mXib[1]", "Species mass flow rates source/sinks within volumes [kg/s]",\
 "HTSE.condenser.der(mXi[1])", 1, 5, 5153, 0)
DeclareAlias2("HTSE.condenser.mXib[2]", "Species mass flow rates source/sinks within volumes [kg/s]",\
 "HTSE.condenser.der(mXi[2])", 1, 5, 5154, 0)
DeclareParameter("HTSE.condenser.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 685, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("HTSE.condenser.geometry.V", "Volume [m3]", 0.1, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.geometry.angle", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("HTSE.condenser.geometry.dheight", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.g_n", "Gravitational acceleration [m/s2]", \
9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.condenser.Q_gen", "Internal heat generation [W]", 0, \
0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.condenser.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("HTSE.condenser.heatPort.T", "Port temperature [K|degC]", \
"HTSE.boundary3.T", 1, 7, 687, 4)
DeclareAlias2("HTSE.condenser.heatPort.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "HTSE.condenser.Q_flow_internal", 1, 5, 5164, 132)
DeclareParameter("HTSE.condenser.showName", "[:#(type=Boolean)]", 686, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("HTSE.condenser.Q_flow_internal", "[W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("HTSE.boundary3.use_port", "=true then use input port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.boundary3.T", "Fixed temperature at port [K|degC]", 687, \
313.15, 200.0,6000.0,300.0,0,560)
DeclareParameter("HTSE.boundary3.showName", "[:#(type=Boolean)]", 688, true, \
0.0,0.0,0.0,0,562)
DeclareAlias2("HTSE.boundary3.T_int", "[K]", "HTSE.boundary3.T", 1, 7, 687, 1024)
DeclareAlias2("HTSE.boundary3.port.T", "Port temperature [K|degC]", \
"HTSE.boundary3.T", 1, 7, 687, 4)
DeclareAlias2("HTSE.boundary3.port.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "HTSE.condenser.Q_flow_internal", -1, 5, 5164, 132)
DeclareVariable("HTSE.SinkTemp.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("HTSE.SinkTemp.showName", "= false to hide component name [:#(type=Boolean)]",\
 689, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("HTSE.SinkTemp.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", 1, 5, 665, 132)
DeclareAlias2("HTSE.SinkTemp.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareAlias2("HTSE.SinkTemp.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.cathodeSink1.ports[1].h_outflow", 1, 5, 666, 4)
DeclareAlias2("HTSE.SinkTemp.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.cathodeSink1.X[1]", 1, 7, 137, 4)
DeclareAlias2("HTSE.SinkTemp.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.cathodeSink1.X[2]", 1, 7, 138, 4)
DeclareAlias2("HTSE.SinkTemp.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", -1, 5, 665, 132)
DeclareAlias2("HTSE.SinkTemp.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareAlias2("HTSE.SinkTemp.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.FuelHXOutTemp.port_a.h_outflow", 1, 5, 5109, 4)
DeclareAlias2("HTSE.SinkTemp.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[1]", 1, 1, 304, 4)
DeclareAlias2("HTSE.SinkTemp.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[2]", 1, 1, 305, 4)
DeclareParameter("HTSE.SinkTemp.m_flow_small", "Regularization for zero flow:|m_flow| < m_flow_small [kg/s]",\
 690, 0.0001, 0.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.SinkTemp.p_start", "Pressure [Pa|bar]", 691, 101325, 0.0,\
1E+100,100000.0,0,560)
DeclareVariable("HTSE.SinkTemp.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.SinkTemp.T_start", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("HTSE.SinkTemp.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.SinkTemp.X_start[1]", "Mass fraction [1]", 692, 0.5, 0.0,\
1.0,0.0,0,560)
DeclareParameter("HTSE.SinkTemp.X_start[2]", "Mass fraction [1]", 693, 0.5, 0.0,\
1.0,0.0,0,560)
DeclareParameter("HTSE.SinkTemp.precision", "Number of decimals displayed [:#(type=Integer)]",\
 694, 0, 0.0,1E+100,0.0,0,564)
DeclareVariable("HTSE.SinkTemp.var", "Variable to be converted [K]", 0.0, 0.0,\
1E+100,0.0,0,512)
DeclareVariable("HTSE.SinkTemp.y", "Icon display", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.SinkTemp.T", "Temperature of the passing fluid [K|degC]", \
"HTSE.SinkTemp.var", 1, 5, 5170, 0)
DeclareVariable("HTSE.SinkTemp.T_a_inflow", "Temperature of inflowing fluid at port_a [K|degC]",\
 500, 200.0,6000.0,500.0,0,2560)
DeclareVariable("HTSE.SinkTemp.T_b_inflow", "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow [K|degC]",\
 500, 200.0,6000.0,500.0,0,2561)
DeclareVariable("HTSE.X_H2.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("HTSE.X_H2.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareVariable("HTSE.X_H2.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -40367.92552974306, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.X_H2.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.X_H2.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.X_H2.Xi", "Mass fraction in port medium [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.X_H2.ind", "Index of species in vector of independent mass fractions [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,2565)
DeclareVariable("HTSE.X_H2.XiVec[1]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.X_H2.XiVec[2]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.X_H2O.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("HTSE.X_H2O.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareVariable("HTSE.X_H2O.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -40367.92552974306, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.X_H2O.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.X_H2O.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.X_H2O.Xi", "Mass fraction in port medium [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.X_H2O.ind", "Index of species in vector of independent mass fractions [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,2565)
DeclareVariable("HTSE.X_H2O.XiVec[1]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.X_H2O.XiVec[2]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareAlias2("HTSE.mH2_sep_out.u1", "Connector of Real input signal 1 [kg/s]", \
"HTSE.cathodeSink1.ports[1].m_flow", 1, 5, 665, 0)
DeclareAlias2("HTSE.mH2_sep_out.u2", "Connector of Real input signal 2 [1]", \
"HTSE.X_H2.Xi", 1, 5, 5178, 0)
DeclareAlias2("HTSE.mH2_sep_out.y", "Connector of Real output signal [kg/s]", \
"HTSE.H2_flowOut.ports[1].m_flow", -1, 5, 5226, 0)
DeclareVariable("HTSE.massFlowRate.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("HTSE.massFlowRate.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", 1, 5, 665, 132)
DeclareAlias2("HTSE.massFlowRate.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareAlias2("HTSE.massFlowRate.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.cathodeSink1.ports[1].h_outflow", 1, 5, 666, 4)
DeclareAlias2("HTSE.massFlowRate.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.cathodeSink1.X[1]", 1, 7, 137, 4)
DeclareAlias2("HTSE.massFlowRate.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.cathodeSink1.X[2]", 1, 7, 138, 4)
DeclareAlias2("HTSE.massFlowRate.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", -1, 5, 665, 132)
DeclareAlias2("HTSE.massFlowRate.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareAlias2("HTSE.massFlowRate.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.FuelHXOutTemp.port_a.h_outflow", 1, 5, 5109, 4)
DeclareAlias2("HTSE.massFlowRate.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[1]", 1, 1, 304, 4)
DeclareAlias2("HTSE.massFlowRate.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.condenser.medium.X[2]", 1, 1, 305, 4)
DeclareParameter("HTSE.massFlowRate.port_a_exposesState", "= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]",\
 695, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.massFlowRate.port_b_exposesState", "= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]",\
 696, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.massFlowRate.showDesignFlowDirection", "= false to hide the arrow in the model icon [:#(type=Boolean)]",\
 697, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("HTSE.massFlowRate.m_flow_nominal", "Nominal value of m_flow = port_a.m_flow [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("HTSE.massFlowRate.m_flow_small", "Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareAlias2("HTSE.massFlowRate.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", 1, 5, 665, 0)
DeclareAlias2("HTSE.mH2O_sep_out.u1", "Connector of Real input signal 1 [kg/s]",\
 "HTSE.cathodeSink1.ports[1].m_flow", 1, 5, 665, 0)
DeclareAlias2("HTSE.mH2O_sep_out.u2", "Connector of Real input signal 2 [1]", \
"HTSE.X_H2O.Xi", 1, 5, 5186, 0)
DeclareAlias2("HTSE.mH2O_sep_out.y", "Connector of Real output signal [kg/s]", \
"HTSE.H2O_flowOut.ports[1].m_flow", -1, 5, 5297, 0)
DeclareVariable("HTSE.H2_flowOut.nPorts", "Number of ports [:#(type=Integer)]", 1,\
 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.H2_flowOut.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.H2Product.p", 1, 7, 704, 0)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.MM",\
 "Molar mass [kg/mol]", 0.00201588, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 4200697.462150524, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[1]",\
 "Low temperature coefficients a", 40783.2321, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[2]",\
 "Low temperature coefficients a", -800.918604, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[3]",\
 "Low temperature coefficients a", 8.21470201, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[4]",\
 "Low temperature coefficients a", -0.01269714457, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[5]",\
 "Low temperature coefficients a", 1.753605076E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[6]",\
 "Low temperature coefficients a", -1.20286027E-08, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.alow[7]",\
 "Low temperature coefficients a", 3.36809349E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.blow[1]",\
 "Low temperature constants b", 2682.484665, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.blow[2]",\
 "Low temperature constants b", -30.43788844, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[1]",\
 "High temperature coefficients a", 560812.801, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[2]",\
 "High temperature coefficients a", -837.150474, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[3]",\
 "High temperature coefficients a", 2.975364532, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[4]",\
 "High temperature coefficients a", 0.001252249124, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[5]",\
 "High temperature coefficients a", -3.74071619E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[6]",\
 "High temperature coefficients a", 5.9366252E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.ahigh[7]",\
 "High temperature coefficients a", -3.6069941E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.bhigh[1]",\
 "High temperature constants b", 5339.82441, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.bhigh[2]",\
 "High temperature constants b", -2.202774769, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.SingleGases.H2.data.R_s",\
 "Gas constant [J/(kg.K)]", 4124.487568704486, 0.0,0.0,0.0,0,2561)
DeclareAlias2("HTSE.H2_flowOut.medium.h", "Specific enthalpy of medium [J/kg]", \
"HTSE.H2_flowOut.ports[1].h_outflow", 1, 5, 5228, 0)
DeclareVariable("HTSE.H2_flowOut.medium.d", "Density of medium [kg/m3|g/cm3]", 10,\
 0.0,100000.0,10.0,0,512)
DeclareAlias2("HTSE.H2_flowOut.medium.T", "Temperature of medium [K|degC]", \
"HTSE.H2_flowOut.T_in_internal", 1, 5, 5234, 0)
DeclareVariable("HTSE.H2_flowOut.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("HTSE.H2_flowOut.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("HTSE.H2_flowOut.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 4124.487568704486, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("HTSE.H2_flowOut.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.00201588, 0.001,0.25,0.032,0,513)
DeclareAlias2("HTSE.H2_flowOut.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.H2Product.p", 1, 7, 704, 0)
DeclareAlias2("HTSE.H2_flowOut.medium.state.T", "Temperature of medium [K|degC]",\
 "HTSE.H2_flowOut.T_in_internal", 1, 5, 5234, 0)
DeclareVariable("HTSE.H2_flowOut.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2_flowOut.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2_flowOut.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.H2_flowOut.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.H2_flowOut.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -1E+60,1E+60,0.0,0,776)
DeclareVariable("HTSE.H2_flowOut.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 1000000.0, 0.0,100000000.0,1000000.0,0,521)
DeclareVariable("HTSE.H2_flowOut.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 4200697.462150524, -10000000000.0,10000000000.0,100000.0,0,520)
DeclareVariable("HTSE.H2_flowOut.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.H2_flowOut.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_flowOut.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_flowOut.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_flowOut.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.H2_flowOut.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 698, 1.35415, -100000.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.H2_flowOut.T", "Fixed value of temperature [K|degC]", 699,\
 618.329, 200.0,6000.0,500.0,0,560)
DeclareParameter("HTSE.H2_flowOut.X[1]", "Fixed value of composition [kg/kg]", 700,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.H2_flowOut.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"HTSE.H2_flowOut.ports[1].m_flow", -1, 5, 5226, 0)
DeclareAlias2("HTSE.H2_flowOut.T_in", "Prescribed fluid temperature [K]", \
"HTSE.H2_flowOut.T_in_internal", 1, 5, 5234, 0)
DeclareAlias2("HTSE.H2_flowOut.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "HTSE.H2_flowOut.ports[1].m_flow", -1, 5, 5226, 1024)
DeclareVariable("HTSE.H2_flowOut.T_in_internal", "Needed to connect to conditional connector [K]",\
 500, 200.0,6000.0,500.0,0,2560)
DeclareVariable("HTSE.H2_flowOut.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.H2O_flowOut.nPorts", "Number of ports [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.H2O_flowOut.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "CondensateSink.p", 1, 7, 790, 0)
DeclareAlias2("HTSE.H2O_flowOut.medium.h", "Specific enthalpy of medium [J/kg]",\
 "HTSE.H2O_flowOut.ports[1].h_outflow", 1, 5, 5299, 0)
DeclareVariable("HTSE.H2O_flowOut.medium.d", "Density of medium [kg/m3|g/cm3]", 150,\
 0.0,100000.0,500.0,0,512)
DeclareVariable("HTSE.H2O_flowOut.medium.T", "Temperature of medium [K|degC]", 500,\
 273.15,2273.15,500.0,0,512)
DeclareVariable("HTSE.H2O_flowOut.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("HTSE.H2O_flowOut.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("HTSE.H2O_flowOut.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("HTSE.H2O_flowOut.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("HTSE.H2O_flowOut.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,644)
DeclareAlias2("HTSE.H2O_flowOut.medium.state.h", "Specific enthalpy [J/kg]", \
"HTSE.H2O_flowOut.ports[1].h_outflow", 1, 5, 5299, 0)
DeclareAlias2("HTSE.H2O_flowOut.medium.state.d", "Density [kg/m3|g/cm3]", \
"HTSE.H2O_flowOut.medium.d", 1, 5, 5237, 0)
DeclareAlias2("HTSE.H2O_flowOut.medium.state.T", "Temperature [K|degC]", \
"HTSE.H2O_flowOut.medium.T", 1, 5, 5238, 0)
DeclareAlias2("HTSE.H2O_flowOut.medium.state.p", "Pressure [Pa|bar]", \
"CondensateSink.p", 1, 7, 790, 0)
DeclareVariable("HTSE.H2O_flowOut.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2O_flowOut.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2O_flowOut.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.H2O_flowOut.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.H2O_flowOut.medium.sat.psat", "Saturation pressure [Pa|bar]",\
 "CondensateSink.p", 1, 7, 790, 0)
DeclareVariable("HTSE.H2O_flowOut.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,513)
DeclareAlias2("HTSE.H2O_flowOut.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "HTSE.H2O_flowOut.medium.state.phase", 1, 5, 5243, 66)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].molarMass",\
 "Molar mass [kg/mol]", 0.018015268, 0.001,0.25,0.032,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].criticalTemperature",\
 "Critical temperature [K|degC]", 647.096, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].criticalPressure",\
 "Critical pressure [Pa|bar]", 22064000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].criticalMolarVolume",\
 "Critical molar Volume [m3/mol]", 5.5948037267080745E-05, 1E-06,1000000.0,1.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].acentricFactor",\
 "Pitzer acentric factor", 0.344, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].triplePointTemperature",\
 "Triple point temperature [K|degC]", 273.16, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].triplePointPressure",\
 "Triple point pressure [Pa|bar]", 611.657, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].meltingPoint",\
 "Melting point at 101325 Pa [K|degC]", 273.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].normalBoilingPoint",\
 "Normal boiling point (at 101325 Pa) [K|degC]", 373.124, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].dipoleMoment",\
 "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m) [debye]", 1.8,\
 0.0,2.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasIdealGasHeatCapacity",\
 "True if ideal gas heat capacity is available [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasCriticalData",\
 "True if critical data are known [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasDipoleMoment",\
 "True if a dipole moment known [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasFundamentalEquation",\
 "True if a fundamental equation [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasLiquidHeatCapacity",\
 "True if liquid heat capacity is available [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasSolidHeatCapacity",\
 "True if solid heat capacity is available [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasAccurateViscosityData",\
 "True if accurate data for a viscosity function is available [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasAccurateConductivityData",\
 "True if accurate data for thermal conductivity is available [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasVapourPressureCurve",\
 "True if vapour pressure data, e.g., Antoine coefficients are known [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].hasAcentricFactor",\
 "True if Pitzer acentric factor is known [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].HCRIT0", \
"Critical specific enthalpy of the fundamental equation [J/kg]", 0.0, \
-10000000000.0,10000000000.0,1000000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].SCRIT0", \
"Critical specific entropy of the fundamental equation [J/(kg.K)]", 0.0, \
-10000000.0,10000000.0,1000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].deltah", \
"Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f) [J/kg]",\
 0.0, -10000000000.0,10000000000.0,1000000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.waterConstants[1].deltas", \
"Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f) [J/(kg.K)]",\
 0.0, -10000000.0,10000000.0,1000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].molarMass",\
 "Molar mass [kg/mol]", 0.018015268, 0.001,0.25,0.032,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].criticalTemperature",\
 "Critical temperature [K|degC]", 647.096, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].criticalPressure",\
 "Critical pressure [Pa|bar]", 22064000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].criticalMolarVolume",\
 "Critical molar Volume [m3/mol]", 5.5948037267080745E-05, 1E-06,1000000.0,1.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].acentricFactor",\
 "Pitzer acentric factor", 0.344, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].triplePointTemperature",\
 "Triple point temperature [K|degC]", 273.16, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].triplePointPressure",\
 "Triple point pressure [Pa|bar]", 611.657, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].meltingPoint",\
 "Melting point at 101325 Pa [K|degC]", 273.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].normalBoilingPoint",\
 "Normal boiling point (at 101325 Pa) [K|degC]", 373.124, 1.0,10000.0,300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].dipoleMoment",\
 "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m) [debye]", 1.8,\
 0.0,2.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasIdealGasHeatCapacity",\
 "True if ideal gas heat capacity is available [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasCriticalData",\
 "True if critical data are known [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasDipoleMoment",\
 "True if a dipole moment known [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasFundamentalEquation",\
 "True if a fundamental equation [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasLiquidHeatCapacity",\
 "True if liquid heat capacity is available [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasSolidHeatCapacity",\
 "True if solid heat capacity is available [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasAccurateViscosityData",\
 "True if accurate data for a viscosity function is available [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasAccurateConductivityData",\
 "True if accurate data for thermal conductivity is available [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasVapourPressureCurve",\
 "True if vapour pressure data, e.g., Antoine coefficients are known [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].hasAcentricFactor",\
 "True if Pitzer acentric factor is known [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].HCRIT0",\
 "Critical specific enthalpy of the fundamental equation [J/kg]", 0.0, \
-10000000000.0,10000000000.0,1000000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].SCRIT0",\
 "Critical specific entropy of the fundamental equation [J/(kg.K)]", 0.0, \
-10000000.0,10000000.0,1000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].deltah",\
 "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f) [J/kg]",\
 0.0, -10000000000.0,10000000000.0,1000000.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.Water.WaterIF97_base.fluidConstants[1].deltas",\
 "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f) [J/(kg.K)]",\
 0.0, -10000000.0,10000000.0,1000.0,0,2561)
DeclareVariable("HTSE.H2O_flowOut.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("HTSE.H2O_flowOut.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 5000000.0, 611.657,100000000.0,1000000.0,0,521)
DeclareVariable("HTSE.H2O_flowOut.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,520)
DeclareVariable("HTSE.H2O_flowOut.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.H2O_flowOut.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2O_flowOut.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2O_flowOut.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2O_flowOut.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.H2O_flowOut.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 701, 1.35415, -100000.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.H2O_flowOut.T", "Fixed value of temperature [K|degC]", 702,\
 618.329, 273.15,2273.15,500.0,0,560)
DeclareParameter("HTSE.H2O_flowOut.X[1]", "Fixed value of composition [kg/kg]", 703,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.H2O_flowOut.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"HTSE.H2O_flowOut.ports[1].m_flow", -1, 5, 5297, 0)
DeclareAlias2("HTSE.H2O_flowOut.T_in", "Prescribed fluid temperature [K]", \
"HTSE.H2_flowOut.T_in_internal", 1, 5, 5234, 0)
DeclareAlias2("HTSE.H2O_flowOut.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "HTSE.H2O_flowOut.ports[1].m_flow", -1, 5, 5297, 1024)
DeclareAlias2("HTSE.H2O_flowOut.T_in_internal", "Needed to connect to conditional connector [K]",\
 "HTSE.H2_flowOut.T_in_internal", 1, 5, 5234, 1024)
DeclareVariable("HTSE.H2O_flowOut.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.H2Product.nPorts", "Number of ports [:#(type=Integer)]", 1,\
 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.H2Product.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.H2Product.p", 1, 7, 704, 0)
DeclareAlias2("HTSE.H2Product.medium.h", "Specific enthalpy of medium [J/kg]", \
"HTSE.H2Product.ports[1].h_outflow", 1, 5, 5316, 0)
DeclareVariable("HTSE.H2Product.medium.d", "Density of medium [kg/m3|g/cm3]", 10,\
 0.0,100000.0,10.0,0,513)
DeclareAlias2("HTSE.H2Product.medium.T", "Temperature of medium [K|degC]", \
"HTSE.H2Product.T", 1, 7, 705, 0)
DeclareVariable("HTSE.H2Product.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("HTSE.H2Product.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("HTSE.H2Product.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 4124.487568704486, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("HTSE.H2Product.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.00201588, 0.001,0.25,0.032,0,513)
DeclareAlias2("HTSE.H2Product.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.H2Product.p", 1, 7, 704, 0)
DeclareAlias2("HTSE.H2Product.medium.state.T", "Temperature of medium [K|degC]",\
 "HTSE.H2Product.T", 1, 7, 705, 0)
DeclareVariable("HTSE.H2Product.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2Product.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2Product.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.H2Product.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.H2Product.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2_flowOut.ports[1].m_flow", -1, 5, 5226, 132)
DeclareAlias2("HTSE.H2Product.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.H2Product.p", 1, 7, 704, 4)
DeclareVariable("HTSE.H2Product.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 4200697.462150524, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.H2Product.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.H2Product.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2Product.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2Product.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2Product.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.H2Product.p", "Fixed value of pressure [Pa|Pa]", 704, \
103299.8, 0.0,100000000.0,1000000.0,0,560)
DeclareParameter("HTSE.H2Product.T", "Fixed value of temperature [K|degC]", 705,\
 313.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("HTSE.H2Product.X[1]", "Fixed value of composition [kg/kg]", 706,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.H2Product.p_in_internal", "Needed to connect to conditional connector [Pa]",\
 "HTSE.H2Product.p", 1, 7, 704, 1024)
DeclareAlias2("HTSE.H2Product.T_in_internal", "Needed to connect to conditional connector [K]",\
 "HTSE.H2Product.T", 1, 7, 705, 1024)
DeclareVariable("HTSE.H2Product.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.temperature.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("HTSE.temperature.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.cathodeSink1.p", 1, 7, 135, 4)
DeclareVariable("HTSE.temperature.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -40367.92552974306, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.temperature.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.temperature.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareAlias2("HTSE.temperature.T", "Temperature in port medium [K|degC]", \
"HTSE.H2_flowOut.T_in_internal", 1, 5, 5234, 0)
DeclareVariable("HTSE.X_H1.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("HTSE.X_H1.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", 1, 5, 5408, 4)
DeclareVariable("HTSE.X_H1.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -40367.92552974306, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.X_H1.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.X_H1.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,521)
DeclareVariable("HTSE.X_H1.Xi", "Mass fraction in port medium", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareVariable("HTSE.X_H1.ind", "Index of species in vector of independent mass fractions [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,2565)
DeclareVariable("HTSE.X_H1.XiVec[1]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.X_H1.XiVec[2]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.H2_recycleFeed.nPorts", "Number of ports [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.H2_recycleFeed.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 0)
DeclareAlias2("HTSE.H2_recycleFeed.medium.h", "Specific enthalpy of medium [J/kg]",\
 "HTSE.H2_recycleFeed.ports[1].h_outflow", 1, 5, 5347, 0)
DeclareVariable("HTSE.H2_recycleFeed.medium.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,513)
DeclareAlias2("HTSE.H2_recycleFeed.medium.T", "Temperature of medium [K|degC]", \
"HTSE.H2_recycleFeed.T", 1, 7, 708, 0)
DeclareVariable("HTSE.H2_recycleFeed.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("HTSE.H2_recycleFeed.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("HTSE.H2_recycleFeed.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 4124.487568704486, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("HTSE.H2_recycleFeed.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.00201588, 0.001,0.25,0.032,0,513)
DeclareAlias2("HTSE.H2_recycleFeed.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 0)
DeclareAlias2("HTSE.H2_recycleFeed.medium.state.T", "Temperature of medium [K|degC]",\
 "HTSE.H2_recycleFeed.T", 1, 7, 708, 0)
DeclareVariable("HTSE.H2_recycleFeed.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2_recycleFeed.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2_recycleFeed.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.H2_recycleFeed.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.H2_recycleFeed.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("HTSE.H2_recycleFeed.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 1000000.0, 0.0,100000000.0,1000000.0,0,521)
DeclareVariable("HTSE.H2_recycleFeed.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.H2_recycleFeed.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.H2_recycleFeed.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_recycleFeed.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_recycleFeed.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_recycleFeed.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.H2_recycleFeed.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 707, 1.35415, -100000.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.H2_recycleFeed.T", "Fixed value of temperature [K|degC]",\
 708, 414.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("HTSE.H2_recycleFeed.X[1]", "Fixed value of composition [kg/kg]",\
 709, 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.H2_recycleFeed.m_flow_in", "Prescribed mass flow rate [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareAlias2("HTSE.H2_recycleFeed.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 1024)
DeclareAlias2("HTSE.H2_recycleFeed.T_in_internal", "Needed to connect to conditional connector [K]",\
 "HTSE.H2_recycleFeed.T", 1, 7, 708, 1024)
DeclareVariable("HTSE.H2_recycleFeed.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporInlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporInlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporInlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidInlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidInlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidInlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 4)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporFlowRate.allowFlowReversal", \
"= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.port_a.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.port_a.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.combiner_FinalV2_1.vaporInlet.h_outflow", 1, 5, 5354, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.port_b.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"HTSE.H2_recycleFeed.ports[1].m_flow", 1, 5, 5345, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.port_b.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.H2_recycleFeed.ports[1].h_outflow", 1, 5, 5347, 4)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporFlowRate.port_a_exposesState", \
"= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]", 710, \
false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporFlowRate.port_b_exposesState", \
"= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]", 711,\
 false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporFlowRate.showDesignFlowDirection",\
 "= false to hide the arrow in the model icon [:#(type=Boolean)]", 712, true, \
0.0,0.0,0.0,0,2610)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporFlowRate.m_flow_nominal", \
"Nominal value of m_flow = port_a.m_flow [kg/s]", 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporFlowRate.m_flow_small", \
"Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporFlowRate.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidFlowRate.allowFlowReversal", \
"= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_a.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"SteamFlowIn.k", 1, 7, 786, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_a.p", \
"Thermodynamic pressure in the connection point [Pa|bar]", "HTSE.combiner_FinalV2_1.liquidSink.p", 1,\
 7, 719, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_a.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_b.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"SteamFlowIn.k", -1, 7, 786, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_b.p", \
"Thermodynamic pressure in the connection point [Pa|bar]", "HTSE.combiner_FinalV2_1.liquidSink.p", 1,\
 7, 719, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_b.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SteamSource.ports[1].h_outflow", 1, 5, 5525, 4)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_a_exposesState", \
"= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]", 713, \
false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidFlowRate.port_b_exposesState", \
"= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]", 714,\
 false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidFlowRate.showDesignFlowDirection",\
 "= false to hide the arrow in the model icon [:#(type=Boolean)]", 715, true, \
0.0,0.0,0.0,0,2610)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidFlowRate.m_flow_nominal", \
"Nominal value of m_flow = port_a.m_flow [kg/s]", 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidFlowRate.m_flow_small", \
"Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidFlowRate.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.nPorts", "Number of ports [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.medium.h", "Specific enthalpy of medium [J/kg]",\
 "HTSE.combiner_FinalV2_1.vaporInlet.h_outflow", 1, 5, 5354, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.medium.T", "Temperature of medium [K|degC]",\
 "HTSE.combiner_FinalV2_1.vaporSink.T", 1, 7, 717, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 4124.487568704486, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.00201588, 0.001,0.25,0.032,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.medium.state.p", \
"Absolute pressure of medium [Pa|bar]", "HTSE.combiner_FinalV2_1.vaporSink.p", 1,\
 7, 716, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.medium.state.T", \
"Temperature of medium [K|degC]", "HTSE.combiner_FinalV2_1.vaporSink.T", 1, 7, 717,\
 0)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.medium.p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.ports[1].m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.ports[1].h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.combiner_FinalV2_1.vaporInlet.h_outflow", 1, 5, 5354, 4)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.flowDirection", \
"Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]", 3, \
1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.combiner_FinalV2_1.vaporSink.p", "Fixed value of pressure [Pa|bar]",\
 716, 1764315, 0.0,100000000.0,1000000.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.vaporSink.T", "Fixed value of temperature [K|degC]",\
 717, 618.329, 200.0,6000.0,500.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.vaporSink.X[1]", "Fixed value of composition [kg/kg]",\
 718, 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.p_in_internal", \
"Needed to connect to conditional connector [Pa]", "HTSE.combiner_FinalV2_1.vaporSink.p", 1,\
 7, 716, 1024)
DeclareAlias2("HTSE.combiner_FinalV2_1.vaporSink.T_in_internal", \
"Needed to connect to conditional connector [K]", "HTSE.combiner_FinalV2_1.vaporSink.T", 1,\
 7, 717, 1024)
DeclareVariable("HTSE.combiner_FinalV2_1.vaporSink.X_in_internal[1]", \
"Needed to connect to conditional connector [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.nPorts", "Number of ports [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.h", "Specific enthalpy of medium [J/kg]",\
 "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.d", "Density of medium [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.T", "Temperature of medium [K|degC]",\
 500, 273.15,2273.15,500.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.state.h", \
"Specific enthalpy [J/kg]", "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.state.d", \
"Density [kg/m3|g/cm3]", "HTSE.combiner_FinalV2_1.liquidSink.medium.d", 1, 5, 5378,\
 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.state.T", \
"Temperature [K|degC]", "HTSE.combiner_FinalV2_1.liquidSink.medium.T", 1, 5, 5379,\
 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.state.p", \
"Pressure [Pa|bar]", "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.sat.psat", \
"Saturation pressure [Pa|bar]", "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719,\
 0)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.medium.sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.medium.phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"HTSE.combiner_FinalV2_1.liquidSink.medium.state.phase", 1, 5, 5384, 66)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.ports[1].m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"SteamFlowIn.k", 1, 7, 786, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.ports[1].h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 4)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.flowDirection", \
"Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]", 3, \
1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.combiner_FinalV2_1.liquidSink.p", "Fixed value of pressure [Pa|bar]",\
 719, 1764315, 611.657,100000000.0,1000000.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.liquidSink.T", "Fixed value of temperature [K|degC]",\
 720, 618.329, 273.15,2273.15,500.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.liquidSink.X[1]", "Fixed value of composition [kg/kg]",\
 721, 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.p_in_internal", \
"Needed to connect to conditional connector [Pa]", "HTSE.combiner_FinalV2_1.liquidSink.p", 1,\
 7, 719, 1024)
DeclareAlias2("HTSE.combiner_FinalV2_1.liquidSink.T_in_internal", \
"Needed to connect to conditional connector [K]", "HTSE.combiner_FinalV2_1.liquidSink.T", 1,\
 7, 720, 1024)
DeclareVariable("HTSE.combiner_FinalV2_1.liquidSink.X_in_internal[1]", \
"Needed to connect to conditional connector [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("HTSE.combiner_FinalV2_1.Outlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", 1, 5, 5407, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.Outlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", 1, 5, 5408, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.Outlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].h_outflow", 1, 5, 5409, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.Outlet.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1, 5, 5418, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.Outlet.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", 1, 5, 5419, 4)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.nPorts", \
"Number of ports [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.p", \
"Absolute pressure of medium [Pa|bar]", "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", 1,\
 5, 5408, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.Xi[1]", \
"Structurally independent mass fractions [1]", "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1,\
 5, 5418, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.Xi[2]", \
"Structurally independent mass fractions [1]", "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", 1,\
 5, 5419, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.h", \
"Specific enthalpy of medium [J/kg]", "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].h_outflow", 1,\
 5, 5409, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.d", \
"Density of medium [kg/m3|g/cm3]", 10, 0.0,100000.0,10.0,0,512)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.T", \
"Temperature of medium [K|degC]", "HTSE.combiner_FinalV2_1.OutletFlowControl.T_in_internal", 1,\
 5, 5417, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 0.5, 0.0,1.0,\
0.1,0,512)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.X[2]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 0.5, 0.0,1.0,\
0.1,0,512)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 1000.0, 0.0,10000000.0,\
1000.0,0,512)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.state.p", \
"Absolute pressure of medium [Pa|bar]", "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", 1,\
 5, 5408, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.state.T", \
"Temperature of medium [K|degC]", "HTSE.combiner_FinalV2_1.OutletFlowControl.T_in_internal", 1,\
 5, 5417, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.state.X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", \
"HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1, 5, 5418, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.state.X[2]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", \
"HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", 1, 5, 5419, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.medium.p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", 0.0, \
-100000.0,100000.0,0.0,0,776)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", \
"Thermodynamic pressure in the connection point [Pa|bar]", 0.0, 0.0,100000000.0,\
1000000.0,0,520)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,520)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].Xi_outflow[1]",\
 "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,520)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].Xi_outflow[2]",\
 "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,520)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.flowDirection", \
"Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]", 3, \
1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.use_m_flow_in", \
"Get the mass flow rate from the input connector [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.use_T_in", \
"Get the temperature from the input connector [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.use_X_in", \
"Get the composition from the input connector [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.use_C_in", \
"Get the trace substances from the input connector [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.combiner_FinalV2_1.OutletFlowControl.m_flow", \
"Fixed mass flow rate going out of the fluid port [kg/s]", 722, 1.35415, \
-100000.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.OutletFlowControl.T", "Fixed value of temperature [K|degC]",\
 723, 618.329, 200.0,6000.0,500.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.OutletFlowControl.X[1]", \
"Fixed value of composition [kg/kg]", 724, 0.5, 0.0,1.0,0.1,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.OutletFlowControl.X[2]", \
"Fixed value of composition [kg/kg]", 725, 0.5, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.m_flow_in", \
"Prescribed mass flow rate [kg/s]", "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", -1,\
 5, 5407, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.T_in", "Prescribed fluid temperature [K]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.T_in_internal", 1, 5, 5417, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.X_in[1]", \
"Prescribed fluid composition [1]", "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1,\
 5, 5418, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.X_in[2]", \
"Prescribed fluid composition [1]", "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", 1,\
 5, 5419, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.OutletFlowControl.m_flow_in_internal", \
"Needed to connect to conditional connector [kg/s]", "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", -1,\
 5, 5407, 1024)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.T_in_internal", \
"Needed to connect to conditional connector [K]", 500, 200.0,6000.0,500.0,0,2560)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", \
"Needed to connect to conditional connector [1]", 0.5, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", \
"Needed to connect to conditional connector [1]", 0.5, 0.0,1.0,0.1,0,2560)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.allowFlowReversal", \
"= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidTemp.showName", "= false to hide component name [:#(type=Boolean)]",\
 726, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.port_a.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"SteamFlowIn.k", 1, 7, 786, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.port_a.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.port_b.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"SteamFlowIn.k", -1, 7, 786, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.port_b.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SteamSource.ports[1].h_outflow", 1, 5, 5525, 4)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidTemp.m_flow_small", \
"Regularization for zero flow:|m_flow| < m_flow_small [kg/s]", 727, 0.0001, 0.0,\
100000.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidTemp.p_start", "Pressure [Pa|bar]",\
 728, 101325, 0.0,1E+100,100000.0,0,560)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.use_T_start", \
"Use T_start if true, otherwise h_start [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.T_start", "Temperature [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.h_start", "Specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidTemp.X_start[1]", \
"Mass fraction [1]", 729, 1.0, 0.0,1.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.LiquidTemp.precision", \
"Number of decimals displayed [:#(type=Integer)]", 730, 0, 0.0,1E+100,0.0,0,564)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.var", "Variable to be converted [K]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.y", "Icon display", 0.0, \
0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.combiner_FinalV2_1.LiquidTemp.T", "Temperature of the passing fluid [K|degC]",\
 "HTSE.combiner_FinalV2_1.LiquidTemp.var", 1, 5, 5424, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.T_a_inflow", \
"Temperature of inflowing fluid at port_a [K|degC]", 500, 273.15,2273.15,500.0,0,2561)
DeclareVariable("HTSE.combiner_FinalV2_1.LiquidTemp.T_b_inflow", \
"Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow [K|degC]",\
 500, 273.15,2273.15,500.0,0,2561)
DeclareAlias2("HTSE.combiner_FinalV2_1.add.u1", "Connector of Real input signal 1 [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.add.u2", "Connector of Real input signal 2 [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.add.y", "Connector of Real output signal [kg/s]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", -1, 5, 5407, 0)
DeclareParameter("HTSE.combiner_FinalV2_1.add.k1", "Gain of input signal 1 [1]",\
 731, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.add.k2", "Gain of input signal 2 [1]",\
 732, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("HTSE.combiner_FinalV2_1.average.u1", "Connector of Real input signal 1 [K]",\
 0.0, 0.0,1E+100,0.0,0,512)
DeclareAlias2("HTSE.combiner_FinalV2_1.average.u2", "Connector of Real input signal 2 [K]",\
 "HTSE.combiner_FinalV2_1.LiquidTemp.var", 1, 5, 5424, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.average.y", "Connector of Real output signal [K]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.T_in_internal", 1, 5, 5417, 0)
DeclareParameter("HTSE.combiner_FinalV2_1.average.k1", "Gain of input signal 1",\
 733, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.average.k2", "Gain of input signal 2",\
 734, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.allowFlowReversal", \
"= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporTemp.showName", "= false to hide component name [:#(type=Boolean)]",\
 735, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.port_a.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.port_a.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.combiner_FinalV2_1.vaporInlet.h_outflow", 1, 5, 5354, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.port_b.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"HTSE.H2_recycleFeed.ports[1].m_flow", 1, 5, 5345, 132)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.port_b.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.H2_recycleFeed.ports[1].h_outflow", 1, 5, 5347, 4)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporTemp.m_flow_small", \
"Regularization for zero flow:|m_flow| < m_flow_small [kg/s]", 736, 0.0001, 0.0,\
100000.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporTemp.p_start", "Pressure [Pa|bar]",\
 737, 101325, 0.0,1E+100,100000.0,0,560)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.use_T_start", \
"Use T_start if true, otherwise h_start [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.T_start", "Temperature [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.h_start", "Specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporTemp.X_start[1]", \
"Mass fraction [1]", 738, 1.0, 0.0,1.0,0.0,0,560)
DeclareParameter("HTSE.combiner_FinalV2_1.VaporTemp.precision", "Number of decimals displayed [:#(type=Integer)]",\
 739, 0, 0.0,1E+100,0.0,0,564)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.var", "Variable to be converted [K]",\
 "HTSE.combiner_FinalV2_1.average.u1", 1, 5, 5428, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.y", "Icon display", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.combiner_FinalV2_1.VaporTemp.T", "Temperature of the passing fluid [K|degC]",\
 "HTSE.combiner_FinalV2_1.average.u1", 1, 5, 5428, 0)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.T_a_inflow", "Temperature of inflowing fluid at port_a [K|degC]",\
 500, 200.0,6000.0,500.0,0,2561)
DeclareVariable("HTSE.combiner_FinalV2_1.VaporTemp.T_b_inflow", "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow [K|degC]",\
 500, 200.0,6000.0,500.0,0,2561)
DeclareAlias2("HTSE.combiner_FinalV2_1.realExpression_Vector.y[1]", \
"Value of Real output [1]", "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1,\
 5, 5418, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.realExpression_Vector.y[2]", \
"Value of Real output [1]", "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", 1,\
 5, 5419, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.division.u1", "Connector of Real input signal 1 [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.division.u2", "Connector of Real input signal 2 [kg/s]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", -1, 5, 5407, 0)
DeclareAlias2("HTSE.combiner_FinalV2_1.division.y", "Connector of Real output signal [1]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1, 5, 5418, 0)
DeclareVariable("HTSE.PID_Fuel1.u_s", "Connector of setpoint input signal", \
0.0123, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Fuel1.u_m", "Connector of measurement input signal", \
"HTSE.X_H1.Xi", 1, 5, 5331, 0)
DeclareAlias2("HTSE.PID_Fuel1.y", "Connector of actuator output signal [kg/s]", \
"HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareVariable("HTSE.PID_Fuel1.controlError", "Control error (set point - measurement)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Fuel1.controllerType", "Type of controller [:#(type=Modelica.Blocks.Types.SimpleController)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel1.with_FF", "enable feed-forward input signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.PID_Fuel1.derMeas", "=true avoid derivative kick [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("HTSE.PID_Fuel1.k", "Controller gain: +/- for direct/reverse acting [1]",\
 740, 1000.0, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.Ti", "Time constant of Integrator block [s]", 741,\
 5, 1E-60,1E+100,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.Td", "Time constant of Derivative block [s]", 742,\
 0.1, 0.0,1E+100,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.yb", "Output bias. May improve simulation", 743,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.k_s", "Setpoint input scaling: k_s*u_s. May improve simulation [1]",\
 744, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.k_m", "Measurement input scaling: k_m*u_m. May improve simulation [1]",\
 745, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.k_ff", "Measurement input scaling: k_ff*u_ff. May improve simulation",\
 746, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.yMax", "Upper limit of output [kg/s]", 747, 1000,\
 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.yMin", "Lower limit of output [kg/s]", 748, 0, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.wp", "Set-point weight for Proportional block (0..1)",\
 749, 1, 0.0,1E+100,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.wd", "Set-point weight for Derivative block (0..1)",\
 750, 0, 0.0,1E+100,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.Ni", "Ni*Ti is time constant of anti-windup compensation",\
 751, 0.9, 1E-13,1E+100,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.Nd", "The higher Nd, the more ideal the derivative block",\
 752, 10, 1E-13,1E+100,0.0,0,560)
DeclareVariable("HTSE.PID_Fuel1.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel1.xi_start", "Initial or guess value value for integrator output (= integrator state)",\
 0, 0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.PID_Fuel1.xd_start", "Initial or guess value for state of derivative block",\
 753, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.y_start", "Initial value of output [kg/s]", 754,\
 0, 0.0,0.0,0.0,0,560)
DeclareVariable("HTSE.PID_Fuel1.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.PID_Fuel1.reset", "Type of controller output reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel1.y_reset", "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.addP.u1", "Connector of Real input signal 1", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.addP.u2", "Connector of Real input signal 2", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Fuel1.addP.y", "Connector of Real output signal", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Fuel1.addP.k1", "Gain of input signal 1", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.PID_Fuel1.addP.k2", "Gain of input signal 2", 755, -1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.P.k", "Gain value multiplied with input signal [1]",\
 756, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel1.P.u", "Input signal connector", "HTSE.PID_Fuel1.addP.y", 1,\
 5, 5448, 0)
DeclareVariable("HTSE.PID_Fuel1.P.y", "Output signal connector", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareVariable("HTSE.PID_Fuel1.gainPID.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.gainPID.u", "Input signal connector", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Fuel1.gainPID.y", "Output signal connector", 0.0, \
0.0,0.0,0.0,0,512)
DeclareParameter("HTSE.PID_Fuel1.addPID.k1", "Gain of input signal 1", 757, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addPID.k2", "Gain of input signal 2", 758, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addPID.k3", "Gain of input signal 3", 759, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel1.addPID.u1", "Connector of Real input signal 1", \
"HTSE.PID_Fuel1.P.y", 1, 5, 5450, 0)
DeclareAlias2("HTSE.PID_Fuel1.addPID.u2", "Connector of Real input signal 2", \
"HTSE.PID_Fuel1.Dzero.k", 1, 7, 819, 0)
DeclareAlias2("HTSE.PID_Fuel1.addPID.u3", "Connector of Real input signal 3", \
"HTSE.PID_Fuel1.I.y", 1, 1, 308, 0)
DeclareAlias2("HTSE.PID_Fuel1.addPID.y", "Connector of Real output signal", \
"HTSE.PID_Fuel1.gainPID.u", 1, 5, 5452, 0)
DeclareVariable("HTSE.PID_Fuel1.limiter.uMax", "Upper limits of input signals [kg/s]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.limiter.uMin", "Lower limits of input signals [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.limiter.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.PID_Fuel1.limiter.homotopyType", "Simplified model for homotopy-based initialization [:#(type=Modelica.Blocks.Types.LimiterHomotopy)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel1.limiter.u", "Connector of Real input signal [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.PID_Fuel1.limiter.y", "Connector of Real output signal [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareAlias2("HTSE.PID_Fuel1.limiter.simplifiedExpr", "Simplified expression for homotopy-based initialization [kg/s]",\
 "HTSE.PID_Fuel1.limiter.u", 1, 5, 5458, 1024)
DeclareParameter("HTSE.PID_Fuel1.Fzero.k", "Constant output value", 760, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel1.Fzero.y", "Connector of Real output signal", \
"HTSE.PID_Fuel1.Fzero.k", 1, 7, 760, 0)
DeclareParameter("HTSE.PID_Fuel1.addFF.k1", "Gain of input signal 1", 761, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addFF.k2", "Gain of input signal 2", 762, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addFF.k3", "Gain of input signal 3", 763, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel1.addFF.u1", "Connector of Real input signal 1", \
"HTSE.PID_Fuel1.Fzero.k", 1, 7, 760, 0)
DeclareAlias2("HTSE.PID_Fuel1.addFF.u2", "Connector of Real input signal 2", \
"HTSE.PID_Fuel1.gainPID.y", 1, 5, 5453, 0)
DeclareAlias2("HTSE.PID_Fuel1.addFF.u3", "Connector of Real input signal 3", \
"HTSE.PID_Fuel1.null_bias.k", 1, 5, 5462, 0)
DeclareAlias2("HTSE.PID_Fuel1.addFF.y", "Connector of Real output signal [kg/s]",\
 "HTSE.PID_Fuel1.limiter.u", 1, 5, 5458, 0)
DeclareVariable("HTSE.PID_Fuel1.gain_u_s.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.gain_u_s.u", "Input signal connector", 0.0123, \
0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Fuel1.gain_u_s.y", "Output signal connector", \
"HTSE.PID_Fuel1.addP.u1", 1, 5, 5446, 0)
DeclareVariable("HTSE.PID_Fuel1.gain_u_m.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Fuel1.gain_u_m.u", "Input signal connector", \
"HTSE.X_H1.Xi", 1, 5, 5331, 0)
DeclareAlias2("HTSE.PID_Fuel1.gain_u_m.y", "Output signal connector", \
"HTSE.PID_Fuel1.addP.u2", 1, 5, 5447, 0)
DeclareVariable("HTSE.PID_Fuel1.null_bias.k", "Constant output value", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Fuel1.null_bias.y", "Connector of Real output signal", \
"HTSE.PID_Fuel1.null_bias.k", 1, 5, 5462, 0)
DeclareVariable("HTSE.PID_Fuel1.unitTime", "[s]", 1, 0.0,0.0,0.0,0,1537)
DeclareVariable("HTSE.PID_Fuel1.with_I", "[:#(type=Boolean)]", true, 0.0,0.0,0.0,\
0,1539)
DeclareVariable("HTSE.PID_Fuel1.with_D", "[:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,1539)
DeclareVariable("HTSE.PID_Fuel1.y_reset_internal", "Internal connector for controller output reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.realExpression2.y", "Value of Real output", 0.0123, \
0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.SinkTemp1.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("HTSE.SinkTemp1.showName", "= false to hide component name [:#(type=Boolean)]",\
 764, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("HTSE.SinkTemp1.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", -1, 5, 5407, 132)
DeclareAlias2("HTSE.SinkTemp1.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", 1, 5, 5408, 4)
DeclareAlias2("HTSE.SinkTemp1.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.cathodeFlowIn2.port_a.h_outflow", 1, 5, 675, 4)
DeclareAlias2("HTSE.SinkTemp1.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.FuelHX.volume_2[1].medium.X[1]", 1, 1, 78, 4)
DeclareAlias2("HTSE.SinkTemp1.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.FuelHX.volume_2[1].medium.X[2]", 1, 1, 79, 4)
DeclareAlias2("HTSE.SinkTemp1.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].m_flow", 1, 5, 5407, 132)
DeclareAlias2("HTSE.SinkTemp1.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].p", 1, 5, 5408, 4)
DeclareAlias2("HTSE.SinkTemp1.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.ports[1].h_outflow", 1, 5, 5409, 4)
DeclareAlias2("HTSE.SinkTemp1.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[1]", 1, 5, 5418, 4)
DeclareAlias2("HTSE.SinkTemp1.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.combiner_FinalV2_1.OutletFlowControl.X_in_internal[2]", 1, 5, 5419, 4)
DeclareParameter("HTSE.SinkTemp1.m_flow_small", "Regularization for zero flow:|m_flow| < m_flow_small [kg/s]",\
 765, 0.0001, 0.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.SinkTemp1.p_start", "Pressure [Pa|bar]", 766, 101325, 0.0,\
1E+100,100000.0,0,560)
DeclareVariable("HTSE.SinkTemp1.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.SinkTemp1.T_start", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("HTSE.SinkTemp1.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("HTSE.SinkTemp1.X_start[1]", "Mass fraction [1]", 767, 0.5, 0.0,\
1.0,0.0,0,560)
DeclareParameter("HTSE.SinkTemp1.X_start[2]", "Mass fraction [1]", 768, 0.5, 0.0,\
1.0,0.0,0,560)
DeclareParameter("HTSE.SinkTemp1.precision", "Number of decimals displayed [:#(type=Integer)]",\
 769, 0, 0.0,1E+100,0.0,0,564)
DeclareVariable("HTSE.SinkTemp1.var", "Variable to be converted [K]", 0.0, 0.0,\
1E+100,0.0,0,512)
DeclareVariable("HTSE.SinkTemp1.y", "Icon display", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.SinkTemp1.T", "Temperature of the passing fluid [K|degC]", \
"HTSE.SinkTemp1.var", 1, 5, 5472, 0)
DeclareVariable("HTSE.SinkTemp1.T_a_inflow", "Temperature of inflowing fluid at port_a [K|degC]",\
 500, 200.0,6000.0,500.0,0,2560)
DeclareVariable("HTSE.SinkTemp1.T_b_inflow", "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow [K|degC]",\
 500, 200.0,6000.0,500.0,0,2560)
DeclareVariable("HTSE.SteamFlowMeasure.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("HTSE.SteamFlowMeasure.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 132)
DeclareAlias2("HTSE.SteamFlowMeasure.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareAlias2("HTSE.SteamFlowMeasure.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.SteamIn_Port.h_outflow", 1, 5, 5501, 4)
DeclareAlias2("HTSE.SteamFlowMeasure.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SteamFlowIn.k", -1, 7, 786, 132)
DeclareAlias2("HTSE.SteamFlowMeasure.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareAlias2("HTSE.SteamFlowMeasure.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SteamSource.ports[1].h_outflow", 1, 5, 5525, 4)
DeclareParameter("HTSE.SteamFlowMeasure.port_a_exposesState", "= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]",\
 770, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.SteamFlowMeasure.port_b_exposesState", "= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]",\
 771, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.SteamFlowMeasure.showDesignFlowDirection", \
"= false to hide the arrow in the model icon [:#(type=Boolean)]", 772, true, \
0.0,0.0,0.0,0,2610)
DeclareVariable("HTSE.SteamFlowMeasure.m_flow_nominal", "Nominal value of m_flow = port_a.m_flow [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("HTSE.SteamFlowMeasure.m_flow_small", "Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareAlias2("HTSE.SteamFlowMeasure.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 0)
DeclareVariable("HTSE.H2_recycleMassFlowRate.allowFlowReversal", \
"= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 132)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.combiner_FinalV2_1.vaporInlet.h_outflow", 1, 5, 5354, 4)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", 1, 5, 5345, 132)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.vaporSink.p", 1, 7, 716, 4)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.H2_recycleFeed.ports[1].h_outflow", 1, 5, 5347, 4)
DeclareParameter("HTSE.H2_recycleMassFlowRate.port_a_exposesState", \
"= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]", 773, \
false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.H2_recycleMassFlowRate.port_b_exposesState", \
"= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]", 774,\
 false, 0.0,0.0,0.0,0,2610)
DeclareParameter("HTSE.H2_recycleMassFlowRate.showDesignFlowDirection", \
"= false to hide the arrow in the model icon [:#(type=Boolean)]", 775, true, \
0.0,0.0,0.0,0,2610)
DeclareVariable("HTSE.H2_recycleMassFlowRate.m_flow_nominal", "Nominal value of m_flow = port_a.m_flow [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("HTSE.H2_recycleMassFlowRate.m_flow_small", "Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareAlias2("HTSE.H2_recycleMassFlowRate.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareAlias2("HTSE.H2Port_Out.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2_feed2.ports[1].m_flow", 1, 5, 5492, 132)
DeclareAlias2("HTSE.H2Port_Out.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "H2ProductOut.p", 1, 7, 787, 4)
DeclareAlias2("HTSE.H2Port_Out.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.H2_feed2.ports[1].h_outflow", 1, 5, 5494, 4)
DeclareAlias2("HTSE.realExpression3.y", "Value of Real output [kg/s]", \
"HTSE.H2_feed2.ports[1].m_flow", -1, 5, 5492, 0)
DeclareVariable("HTSE.H2_feed2.nPorts", "Number of ports [:#(type=Integer)]", 1,\
 0.0,0.0,0.0,0,517)
DeclareAlias2("HTSE.H2_feed2.medium.p", "Absolute pressure of medium [Pa|bar]", \
"H2ProductOut.p", 1, 7, 787, 0)
DeclareAlias2("HTSE.H2_feed2.medium.h", "Specific enthalpy of medium [J/kg]", \
"HTSE.H2_feed2.ports[1].h_outflow", 1, 5, 5494, 0)
DeclareVariable("HTSE.H2_feed2.medium.d", "Density of medium [kg/m3|g/cm3]", 10,\
 0.0,100000.0,10.0,0,513)
DeclareAlias2("HTSE.H2_feed2.medium.T", "Temperature of medium [K|degC]", \
"HTSE.H2_feed2.T", 1, 7, 777, 0)
DeclareVariable("HTSE.H2_feed2.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("HTSE.H2_feed2.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("HTSE.H2_feed2.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 4124.487568704486, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("HTSE.H2_feed2.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.00201588, 0.001,0.25,0.032,0,513)
DeclareAlias2("HTSE.H2_feed2.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "H2ProductOut.p", 1, 7, 787, 0)
DeclareAlias2("HTSE.H2_feed2.medium.state.T", "Temperature of medium [K|degC]", \
"HTSE.H2_feed2.T", 1, 7, 777, 0)
DeclareVariable("HTSE.H2_feed2.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2_feed2.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("HTSE.H2_feed2.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.H2_feed2.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.H2_feed2.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("HTSE.H2_feed2.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 1000000.0, 0.0,100000000.0,1000000.0,0,521)
DeclareVariable("HTSE.H2_feed2.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 4200697.462150524, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("HTSE.H2_feed2.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("HTSE.H2_feed2.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_feed2.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_feed2.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("HTSE.H2_feed2.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("HTSE.H2_feed2.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 776, 1.35415, -100000.0,100000.0,0.0,0,560)
DeclareParameter("HTSE.H2_feed2.T", "Fixed value of temperature [K|degC]", 777, \
414.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("HTSE.H2_feed2.X[1]", "Fixed value of composition [kg/kg]", 778,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("HTSE.H2_feed2.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"HTSE.H2_feed2.ports[1].m_flow", -1, 5, 5492, 0)
DeclareAlias2("HTSE.H2_feed2.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "HTSE.H2_feed2.ports[1].m_flow", -1, 5, 5492, 1024)
DeclareAlias2("HTSE.H2_feed2.T_in_internal", "Needed to connect to conditional connector [K]",\
 "HTSE.H2_feed2.T", 1, 7, 777, 1024)
DeclareVariable("HTSE.H2_feed2.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("HTSE.SteamIn_Port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 132)
DeclareAlias2("HTSE.SteamIn_Port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 4)
DeclareVariable("HTSE.SteamIn_Port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareAlias2("HTSE.AirIn_Port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "AirFlowIn.k", 1, 7, 797, 132)
DeclareAlias2("HTSE.AirIn_Port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "AirSource.ports[1].p", 1, 5, 5581, 4)
DeclareVariable("HTSE.AirIn_Port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,520)
DeclareVariable("HTSE.AirIn_Port.der(h_outflow)", "der(Specific thermodynamic enthalpy close to the connection point if m_flow < 0) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareAlias2("HTSE.AirIn_Port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.AirHX.volume_2[1].medium.X[1]", 1, 1, 230, 4)
DeclareAlias2("HTSE.AirIn_Port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.AirHX.volume_2[1].medium.X[2]", 1, 1, 231, 4)
DeclareVariable("HTSE.electricalLoad.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,776)
DeclareVariable("HTSE.electricalLoad.f", "Frequency [Hz]", 60, 0.0,0.0,0.0,0,521)
DeclareVariable("HTSE.AirPort_Out.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareAlias2("HTSE.AirPort_Out.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "AirExhaust.p", 1, 7, 798, 4)
DeclareVariable("HTSE.AirPort_Out.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,520)
DeclareVariable("HTSE.AirPort_Out.der(h_outflow)", "der(Specific thermodynamic enthalpy close to the connection point if m_flow < 0) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareAlias2("HTSE.AirPort_Out.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.AirHX.volume_1[20].medium.X[1]", 1, 1, 226, 4)
DeclareAlias2("HTSE.AirPort_Out.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "HTSE.AirHX.volume_1[20].medium.X[2]", 1, 1, 227, 4)
DeclareAlias2("HTSE.WaterPort_Out.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2O_flowOut.ports[1].m_flow", 1, 5, 5297, 132)
DeclareAlias2("HTSE.WaterPort_Out.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "CondensateSink.p", 1, 7, 790, 4)
DeclareAlias2("HTSE.WaterPort_Out.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "HTSE.H2O_flowOut.ports[1].h_outflow", 1, 5, 5299, 4)
DeclareParameter("DCPowerControl.height", "Height of ramps [W]", 779, 10000, \
0.0,0.0,0.0,0,560)
DeclareParameter("DCPowerControl.duration", "Duration of ramp (= 0.0 gives a Step) [s]",\
 780, 100, 0.0,1E+100,0.0,0,560)
DeclareAlias2("DCPowerControl.y", "Connector of Real output signal [W]", \
"HTSE.electricalLoad.W", 1, 5, 5504, 0)
DeclareParameter("DCPowerControl.offset", "Offset of output signal y [W]", 781, 30000,\
 0.0,0.0,0.0,0,560)
DeclareParameter("DCPowerControl.startTime", "Output y = offset for time < startTime [s]",\
 782, 500, 0.0,0.0,0.0,0,560)
DeclareAlias2("prescribedPowerFlow.port_b.W", "Active power [W]", \
"HTSE.electricalLoad.W", -1, 5, 5504, 132)
DeclareVariable("prescribedPowerFlow.port_b.f", "Frequency [Hz]", 60.0, 0.0,0.0,\
0.0,0,521)
DeclareAlias2("prescribedPowerFlow.P_flow", "[W|MW]", "HTSE.electricalLoad.W", 1,\
 5, 5504, 0)
DeclareVariable("SteamSource.nPorts", "Number of ports [:#(type=Integer)]", 1, \
0.0,0.0,0.0,0,517)
DeclareAlias2("SteamSource.medium.p", "Absolute pressure of medium [Pa|bar]", \
"HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 0)
DeclareAlias2("SteamSource.medium.h", "Specific enthalpy of medium [J/kg]", \
"SteamSource.ports[1].h_outflow", 1, 5, 5525, 0)
DeclareVariable("SteamSource.medium.d", "Density of medium [kg/m3|g/cm3]", 150, \
0.0,100000.0,500.0,0,513)
DeclareVariable("SteamSource.medium.T", "Temperature of medium [K|degC]", 500, \
273.15,2273.15,500.0,0,513)
DeclareVariable("SteamSource.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("SteamSource.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("SteamSource.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("SteamSource.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("SteamSource.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareAlias2("SteamSource.medium.state.h", "Specific enthalpy [J/kg]", \
"SteamSource.ports[1].h_outflow", 1, 5, 5525, 0)
DeclareAlias2("SteamSource.medium.state.d", "Density [kg/m3|g/cm3]", \
"SteamSource.medium.d", 1, 5, 5511, 0)
DeclareAlias2("SteamSource.medium.state.T", "Temperature [K|degC]", \
"SteamSource.medium.T", 1, 5, 5512, 0)
DeclareAlias2("SteamSource.medium.state.p", "Pressure [Pa|bar]", \
"HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 0)
DeclareVariable("SteamSource.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SteamSource.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SteamSource.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SteamSource.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SteamSource.medium.sat.psat", "Saturation pressure [Pa|bar]", \
"HTSE.combiner_FinalV2_1.liquidSink.p", 1, 7, 719, 0)
DeclareVariable("SteamSource.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,513)
DeclareAlias2("SteamSource.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "SteamSource.medium.state.phase", 1, 5, 5517, 66)
DeclareVariable("SteamSource.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -1E+60,1E+60,0.0,0,777)
DeclareVariable("SteamSource.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 5000000.0, 611.657,100000000.0,1000000.0,0,521)
DeclareVariable("SteamSource.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareVariable("SteamSource.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("SteamSource.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("SteamSource.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SteamSource.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SteamSource.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("SteamSource.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 783, 4.540425, -100000.0,100000.0,0.0,0,560)
DeclareParameter("SteamSource.T", "Fixed value of temperature [K|degC]", 784, \
414.15, 273.15,2273.15,500.0,0,560)
DeclareParameter("SteamSource.X[1]", "Fixed value of composition [kg/kg]", 785, \
1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("SteamSource.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"SteamFlowIn.k", 1, 7, 786, 0)
DeclareAlias2("SteamSource.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "SteamFlowIn.k", 1, 7, 786, 1024)
DeclareAlias2("SteamSource.T_in_internal", "Needed to connect to conditional connector [K]",\
 "SteamSource.T", 1, 7, 784, 1024)
DeclareVariable("SteamSource.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareParameter("SteamFlowIn.k", "Constant output value [kg/s]", 786, 0.0036929,\
 -100000.0,100000.0,0.0,0,560)
DeclareAlias2("SteamFlowIn.y", "Connector of Real output signal [kg/s]", \
"SteamFlowIn.k", 1, 7, 786, 0)
DeclareVariable("H2ProductOut.nPorts", "Number of ports [:#(type=Integer)]", 1, \
0.0,0.0,0.0,0,517)
DeclareAlias2("H2ProductOut.medium.p", "Absolute pressure of medium [Pa|bar]", \
"H2ProductOut.p", 1, 7, 787, 0)
DeclareAlias2("H2ProductOut.medium.h", "Specific enthalpy of medium [J/kg]", \
"H2ProductOut.ports[1].h_outflow", 1, 5, 5542, 0)
DeclareVariable("H2ProductOut.medium.d", "Density of medium [kg/m3|g/cm3]", 10, \
0.0,100000.0,10.0,0,513)
DeclareAlias2("H2ProductOut.medium.T", "Temperature of medium [K|degC]", \
"H2ProductOut.T", 1, 7, 788, 0)
DeclareVariable("H2ProductOut.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("H2ProductOut.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("H2ProductOut.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 4124.487568704486, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("H2ProductOut.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.00201588, 0.001,0.25,0.032,0,513)
DeclareAlias2("H2ProductOut.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "H2ProductOut.p", 1, 7, 787, 0)
DeclareAlias2("H2ProductOut.medium.state.T", "Temperature of medium [K|degC]", \
"H2ProductOut.T", 1, 7, 788, 0)
DeclareVariable("H2ProductOut.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("H2ProductOut.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("H2ProductOut.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("H2ProductOut.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("H2ProductOut.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2_feed2.ports[1].m_flow", -1, 5, 5492, 132)
DeclareAlias2("H2ProductOut.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "H2ProductOut.p", 1, 7, 787, 4)
DeclareVariable("H2ProductOut.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 4200697.462150524, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("H2ProductOut.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("H2ProductOut.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("H2ProductOut.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("H2ProductOut.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("H2ProductOut.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("H2ProductOut.p", "Fixed value of pressure [Pa|Pa]", 787, 101300,\
 0.0,100000000.0,1000000.0,0,560)
DeclareParameter("H2ProductOut.T", "Fixed value of temperature [K|degC]", 788, \
313.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("H2ProductOut.X[1]", "Fixed value of composition [kg/kg]", 789,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("H2ProductOut.p_in_internal", "Needed to connect to conditional connector [Pa]",\
 "H2ProductOut.p", 1, 7, 787, 1024)
DeclareAlias2("H2ProductOut.T_in_internal", "Needed to connect to conditional connector [K]",\
 "H2ProductOut.T", 1, 7, 788, 1024)
DeclareVariable("H2ProductOut.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("CondensateSink.nPorts", "Number of ports [:#(type=Integer)]", 1,\
 0.0,0.0,0.0,0,517)
DeclareAlias2("CondensateSink.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "CondensateSink.p", 1, 7, 790, 0)
DeclareAlias2("CondensateSink.medium.h", "Specific enthalpy of medium [J/kg]", \
"CondensateSink.ports[1].h_outflow", 1, 5, 5562, 0)
DeclareVariable("CondensateSink.medium.d", "Density of medium [kg/m3|g/cm3]", 150,\
 0.0,100000.0,500.0,0,513)
DeclareVariable("CondensateSink.medium.T", "Temperature of medium [K|degC]", 500,\
 273.15,2273.15,500.0,0,513)
DeclareVariable("CondensateSink.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("CondensateSink.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("CondensateSink.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("CondensateSink.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("CondensateSink.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareAlias2("CondensateSink.medium.state.h", "Specific enthalpy [J/kg]", \
"CondensateSink.ports[1].h_outflow", 1, 5, 5562, 0)
DeclareAlias2("CondensateSink.medium.state.d", "Density [kg/m3|g/cm3]", \
"CondensateSink.medium.d", 1, 5, 5550, 0)
DeclareAlias2("CondensateSink.medium.state.T", "Temperature [K|degC]", \
"CondensateSink.medium.T", 1, 5, 5551, 0)
DeclareAlias2("CondensateSink.medium.state.p", "Pressure [Pa|bar]", \
"CondensateSink.p", 1, 7, 790, 0)
DeclareVariable("CondensateSink.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("CondensateSink.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("CondensateSink.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("CondensateSink.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("CondensateSink.medium.sat.psat", "Saturation pressure [Pa|bar]", \
"CondensateSink.p", 1, 7, 790, 0)
DeclareVariable("CondensateSink.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,513)
DeclareAlias2("CondensateSink.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "CondensateSink.medium.state.phase", 1, 5, 5556, 66)
DeclareAlias2("CondensateSink.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.H2O_flowOut.ports[1].m_flow", -1, 5, 5297, 132)
DeclareAlias2("CondensateSink.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "CondensateSink.p", 1, 7, 790, 4)
DeclareVariable("CondensateSink.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareVariable("CondensateSink.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("CondensateSink.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("CondensateSink.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("CondensateSink.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("CondensateSink.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("CondensateSink.p", "Fixed value of pressure [Pa|Pa]", 790, \
103299.8, 611.657,100000000.0,1000000.0,0,560)
DeclareParameter("CondensateSink.T", "Fixed value of temperature [K|degC]", 791,\
 313.15, 273.15,2273.15,500.0,0,560)
DeclareParameter("CondensateSink.X[1]", "Fixed value of composition [kg/kg]", 792,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareAlias2("CondensateSink.p_in_internal", "Needed to connect to conditional connector [Pa]",\
 "CondensateSink.p", 1, 7, 790, 1024)
DeclareAlias2("CondensateSink.T_in_internal", "Needed to connect to conditional connector [K]",\
 "CondensateSink.T", 1, 7, 791, 1024)
DeclareVariable("CondensateSink.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("AirSource.nPorts", "Number of ports [:#(type=Integer)]", 1, \
0.0,0.0,0.0,0,517)
DeclareAlias2("AirSource.medium.p", "Absolute pressure of medium [Pa|bar]", \
"AirSource.ports[1].p", 1, 5, 5581, 0)
DeclareAlias2("AirSource.medium.Xi[1]", "Structurally independent mass fractions [1]",\
 "AirSource.X[1]", 1, 7, 795, 0)
DeclareAlias2("AirSource.medium.Xi[2]", "Structurally independent mass fractions [1]",\
 "AirSource.X[2]", 1, 7, 796, 0)
DeclareAlias2("AirSource.medium.h", "Specific enthalpy of medium [J/kg]", \
"AirSource.ports[1].h_outflow", 1, 5, 5582, 0)
DeclareVariable("AirSource.medium.d", "Density of medium [kg/m3|g/cm3]", 10, 0.0,\
100000.0,10.0,0,512)
DeclareAlias2("AirSource.medium.T", "Temperature of medium [K|degC]", \
"AirSource.T", 1, 7, 794, 0)
DeclareVariable("AirSource.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,513)
DeclareVariable("AirSource.medium.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,513)
DeclareVariable("AirSource.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("AirSource.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("AirSource.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("AirSource.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "AirSource.ports[1].p", 1, 5, 5581, 0)
DeclareAlias2("AirSource.medium.state.T", "Temperature of medium [K|degC]", \
"AirSource.T", 1, 7, 794, 0)
DeclareAlias2("AirSource.medium.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "AirSource.X[1]", 1, 7, 795, 0)
DeclareAlias2("AirSource.medium.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "AirSource.X[2]", 1, 7, 796, 0)
DeclareVariable("AirSource.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("AirSource.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("AirSource.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("AirSource.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("AirSource.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -1E+60,1E+60,0.0,0,777)
DeclareVariable("AirSource.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 0.0, 0.0,100000000.0,1000000.0,0,520)
DeclareVariable("AirSource.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("AirSource.ports[1].Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,521)
DeclareVariable("AirSource.ports[1].Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,521)
DeclareVariable("AirSource.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("AirSource.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("AirSource.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("AirSource.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("AirSource.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("AirSource.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 793, 4.540425, -100000.0,100000.0,0.0,0,560)
DeclareParameter("AirSource.T", "Fixed value of temperature [K|degC]", 794, \
293.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("AirSource.X[1]", "Fixed value of composition [kg/kg]", 795, \
0.7670824885424203, 0.0,1.0,0.1,0,560)
DeclareParameter("AirSource.X[2]", "Fixed value of composition [kg/kg]", 796, \
0.23291751145757963, 0.0,1.0,0.1,0,560)
DeclareAlias2("AirSource.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"AirFlowIn.k", 1, 7, 797, 0)
DeclareAlias2("AirSource.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "AirFlowIn.k", 1, 7, 797, 1024)
DeclareAlias2("AirSource.T_in_internal", "Needed to connect to conditional connector [K]",\
 "AirSource.T", 1, 7, 794, 1024)
DeclareVariable("AirSource.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("AirSource.X_in_internal[2]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareParameter("AirFlowIn.k", "Constant output value [kg/s]", 797, 0.005555, \
-100000.0,100000.0,0.0,0,560)
DeclareAlias2("AirFlowIn.y", "Connector of Real output signal [kg/s]", \
"AirFlowIn.k", 1, 7, 797, 0)
DeclareVariable("AirExhaust.nPorts", "Number of ports [:#(type=Integer)]", 1, \
0.0,0.0,0.0,0,517)
DeclareAlias2("AirExhaust.medium.p", "Absolute pressure of medium [Pa|bar]", \
"AirExhaust.p", 1, 7, 798, 0)
DeclareAlias2("AirExhaust.medium.Xi[1]", "Structurally independent mass fractions [1]",\
 "AirExhaust.X[1]", 1, 7, 800, 0)
DeclareAlias2("AirExhaust.medium.Xi[2]", "Structurally independent mass fractions [1]",\
 "AirExhaust.X[2]", 1, 7, 801, 0)
DeclareAlias2("AirExhaust.medium.h", "Specific enthalpy of medium [J/kg]", \
"AirExhaust.ports[1].h_outflow", 1, 5, 5603, 0)
DeclareVariable("AirExhaust.medium.d", "Density of medium [kg/m3|g/cm3]", 10, \
0.0,100000.0,10.0,0,513)
DeclareAlias2("AirExhaust.medium.T", "Temperature of medium [K|degC]", \
"AirExhaust.T", 1, 7, 799, 0)
DeclareVariable("AirExhaust.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,513)
DeclareVariable("AirExhaust.medium.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.5, 0.0,1.0,0.1,0,513)
DeclareVariable("AirExhaust.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("AirExhaust.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("AirExhaust.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,513)
DeclareAlias2("AirExhaust.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "AirExhaust.p", 1, 7, 798, 0)
DeclareAlias2("AirExhaust.medium.state.T", "Temperature of medium [K|degC]", \
"AirExhaust.T", 1, 7, 799, 0)
DeclareAlias2("AirExhaust.medium.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "AirExhaust.X[1]", 1, 7, 800, 0)
DeclareAlias2("AirExhaust.medium.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "AirExhaust.X[2]", 1, 7, 801, 0)
DeclareVariable("AirExhaust.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("AirExhaust.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("AirExhaust.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("AirExhaust.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("AirExhaust.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "HTSE.AirPort_Out.m_flow", -1, 5, 5506, 132)
DeclareAlias2("AirExhaust.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "AirExhaust.p", 1, 7, 798, 4)
DeclareVariable("AirExhaust.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareAlias2("AirExhaust.ports[1].Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "AirExhaust.X[1]", 1, 7, 800, 4)
DeclareAlias2("AirExhaust.ports[1].Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "AirExhaust.X[2]", 1, 7, 801, 4)
DeclareVariable("AirExhaust.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("AirExhaust.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("AirExhaust.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("AirExhaust.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("AirExhaust.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("AirExhaust.p", "Fixed value of pressure [Pa|kPa]", 798, 101300,\
 0.0,100000000.0,1000000.0,0,560)
DeclareParameter("AirExhaust.T", "Fixed value of temperature [K|degC]", 799, \
504.55, 200.0,6000.0,500.0,0,560)
DeclareParameter("AirExhaust.X[1]", "Fixed value of composition [kg/kg]", 800, \
0.5, 0.0,1.0,0.1,0,560)
DeclareParameter("AirExhaust.X[2]", "Fixed value of composition [kg/kg]", 801, \
0.5, 0.0,1.0,0.1,0,560)
DeclareAlias2("AirExhaust.p_in_internal", "Needed to connect to conditional connector [Pa]",\
 "AirExhaust.p", 1, 7, 798, 1024)
DeclareAlias2("AirExhaust.T_in_internal", "Needed to connect to conditional connector [K]",\
 "AirExhaust.T", 1, 7, 799, 1024)
DeclareVariable("AirExhaust.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("AirExhaust.X_in_internal[2]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.PID_Air.I.u", "Connector of Real input signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("HTSE.PID_Air.I.y", "Connector of Real output signal", 306, 0.0, \
0.0,0.0,0.0,0,560)
DeclareDerivative("HTSE.PID_Air.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Air.I.k", "Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Air.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.PID_Air.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Air.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("HTSE.PID_Air.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Air.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.PID_Air.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("HTSE.PID_Air.addI.k1", "Gain of input signal 1", 802, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Air.addI.k2", "Gain of input signal 2", 803, -1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Air.addI.k3", "Gain of input signal 3", 804, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Air.addI.u1", "Connector of Real input signal 1 [K]", \
"HTSE.PID_Air.addP.u1", 1, 5, 525, 0)
DeclareAlias2("HTSE.PID_Air.addI.u2", "Connector of Real input signal 2 [K]", \
"HTSE.PID_Air.addP.u2", 1, 5, 526, 0)
DeclareVariable("HTSE.PID_Air.addI.u3", "Connector of Real input signal 3", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.PID_Air.addI.y", "Connector of Real output signal", \
"HTSE.PID_Air.I.u", 1, 5, 5611, 0)
DeclareAlias2("HTSE.PID_Air.addSat.u1", "Connector of Real input signal 1 [W]", \
"HTSE.AirTH.Q_flow_internal", 1, 5, 505, 0)
DeclareAlias2("HTSE.PID_Air.addSat.u2", "Connector of Real input signal 2 [W]", \
"HTSE.PID_Air.limiter.u", 1, 5, 537, 0)
DeclareVariable("HTSE.PID_Air.addSat.y", "Connector of Real output signal", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareParameter("HTSE.PID_Air.addSat.k1", "Gain of input signal 1", 805, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Air.addSat.k2", "Gain of input signal 2", 806, -1, \
0.0,0.0,0.0,0,560)
DeclareVariable("HTSE.PID_Air.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Air.gainTrack.u", "Input signal connector", \
"HTSE.PID_Air.addSat.y", 1, 5, 5620, 0)
DeclareAlias2("HTSE.PID_Air.gainTrack.y", "Output signal connector", \
"HTSE.PID_Air.addI.u3", 1, 5, 5619, 0)
DeclareParameter("HTSE.PID_Air.Dzero.k", "Constant output value", 807, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Air.Dzero.y", "Connector of Real output signal", \
"HTSE.PID_Air.Dzero.k", 1, 7, 807, 0)
DeclareVariable("HTSE.PID_Fuel.I.u", "Connector of Real input signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("HTSE.PID_Fuel.I.y", "Connector of Real output signal", 307, 0.0, \
0.0,0.0,0.0,0,560)
DeclareDerivative("HTSE.PID_Fuel.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Fuel.I.k", "Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.PID_Fuel.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("HTSE.PID_Fuel.addI.k1", "Gain of input signal 1", 808, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel.addI.k2", "Gain of input signal 2", 809, -1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel.addI.k3", "Gain of input signal 3", 810, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel.addI.u1", "Connector of Real input signal 1 [K]", \
"HTSE.PID_Fuel.addP.u1", 1, 5, 607, 0)
DeclareAlias2("HTSE.PID_Fuel.addI.u2", "Connector of Real input signal 2 [K]", \
"HTSE.PID_Fuel.addP.u2", 1, 5, 608, 0)
DeclareVariable("HTSE.PID_Fuel.addI.u3", "Connector of Real input signal 3", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.PID_Fuel.addI.y", "Connector of Real output signal", \
"HTSE.PID_Fuel.I.u", 1, 5, 5622, 0)
DeclareAlias2("HTSE.PID_Fuel.addSat.u1", "Connector of Real input signal 1 [W]",\
 "HTSE.FuelTH.Q_flow_internal", 1, 5, 594, 0)
DeclareAlias2("HTSE.PID_Fuel.addSat.u2", "Connector of Real input signal 2 [W]",\
 "HTSE.PID_Fuel.limiter.u", 1, 5, 619, 0)
DeclareVariable("HTSE.PID_Fuel.addSat.y", "Connector of Real output signal", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareParameter("HTSE.PID_Fuel.addSat.k1", "Gain of input signal 1", 811, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel.addSat.k2", "Gain of input signal 2", 812, -1, \
0.0,0.0,0.0,0,560)
DeclareVariable("HTSE.PID_Fuel.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Fuel.gainTrack.u", "Input signal connector", \
"HTSE.PID_Fuel.addSat.y", 1, 5, 5631, 0)
DeclareAlias2("HTSE.PID_Fuel.gainTrack.y", "Output signal connector", \
"HTSE.PID_Fuel.addI.u3", 1, 5, 5630, 0)
DeclareParameter("HTSE.PID_Fuel.Dzero.k", "Constant output value", 813, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel.Dzero.y", "Connector of Real output signal", \
"HTSE.PID_Fuel.Dzero.k", 1, 7, 813, 0)
DeclareVariable("HTSE.PID_Fuel1.I.u", "Connector of Real input signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("HTSE.PID_Fuel1.I.y", "Connector of Real output signal", 308, 0.0, \
0.0,0.0,0.0,0,560)
DeclareDerivative("HTSE.PID_Fuel1.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("HTSE.PID_Fuel1.I.k", "Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel1.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("HTSE.PID_Fuel1.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("HTSE.PID_Fuel1.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("HTSE.PID_Fuel1.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("HTSE.PID_Fuel1.addI.k1", "Gain of input signal 1", 814, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addI.k2", "Gain of input signal 2", 815, -1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addI.k3", "Gain of input signal 3", 816, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel1.addI.u1", "Connector of Real input signal 1", \
"HTSE.PID_Fuel1.addP.u1", 1, 5, 5446, 0)
DeclareAlias2("HTSE.PID_Fuel1.addI.u2", "Connector of Real input signal 2", \
"HTSE.PID_Fuel1.addP.u2", 1, 5, 5447, 0)
DeclareVariable("HTSE.PID_Fuel1.addI.u3", "Connector of Real input signal 3", \
0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("HTSE.PID_Fuel1.addI.y", "Connector of Real output signal", \
"HTSE.PID_Fuel1.I.u", 1, 5, 5633, 0)
DeclareAlias2("HTSE.PID_Fuel1.addSat.u1", "Connector of Real input signal 1 [kg/s]",\
 "HTSE.H2_recycleFeed.ports[1].m_flow", -1, 5, 5345, 0)
DeclareAlias2("HTSE.PID_Fuel1.addSat.u2", "Connector of Real input signal 2 [kg/s]",\
 "HTSE.PID_Fuel1.limiter.u", 1, 5, 5458, 0)
DeclareVariable("HTSE.PID_Fuel1.addSat.y", "Connector of Real output signal", \
0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("HTSE.PID_Fuel1.addSat.k1", "Gain of input signal 1", 817, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("HTSE.PID_Fuel1.addSat.k2", "Gain of input signal 2", 818, -1, \
0.0,0.0,0.0,0,560)
DeclareVariable("HTSE.PID_Fuel1.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("HTSE.PID_Fuel1.gainTrack.u", "Input signal connector", \
"HTSE.PID_Fuel1.addSat.y", 1, 5, 5642, 0)
DeclareAlias2("HTSE.PID_Fuel1.gainTrack.y", "Output signal connector", \
"HTSE.PID_Fuel1.addI.u3", 1, 5, 5641, 0)
DeclareParameter("HTSE.PID_Fuel1.Dzero.k", "Constant output value", 819, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("HTSE.PID_Fuel1.Dzero.y", "Connector of Real output signal", \
"HTSE.PID_Fuel1.Dzero.k", 1, 7, 819, 0)
DeclareState("stateSelect.set1.x[1]", "", 309, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[1])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[2]", "", 310, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[2])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[3]", "", 311, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[3])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[4]", "", 312, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[4])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[5]", "", 313, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[5])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[6]", "", 314, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[6])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[7]", "", 315, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[7])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[8]", "", 316, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[8])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[9]", "", 317, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[9])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[10]", "", 318, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[10])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set1.x[11]", "", 319, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set1.der(x[11])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[1]", "", 320, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[1])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[2]", "", 321, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[2])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[3]", "", 322, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[3])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[4]", "", 323, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[4])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[5]", "", 324, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[5])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[6]", "", 325, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[6])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[7]", "", 326, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[7])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[8]", "", 327, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[8])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[9]", "", 328, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[9])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[10]", "", 329, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[10])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("stateSelect.set2.x[11]", "", 330, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("stateSelect.set2.der(x[11])", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[1, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[2, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[3, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[4, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[5, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[6, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[7, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[8, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[9, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[10, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set1.P[11, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[1, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[2, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[3, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[4, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[5, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[6, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[7, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[8, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[9, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[10, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 4]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 5]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 6]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 7]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 8]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 9]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 10]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 11]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 12]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 13]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 14]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 15]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 16]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 17]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 18]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 19]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 20]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 21]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 22]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 23]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 24]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 25]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("stateSelect.set2.P[11, 26]", "", 0.0, 0.0,0.0,0.0,0,512)
EndNonAlias(5)
PreNonAliasNew(6)
