#include <moutil.c>
PreNonAliasDef(21)
PreNonAliasDef(22)
PreNonAliasDef(23)
PreNonAliasDef(24)
PreNonAliasDef(25)
StartNonAlias(20)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.use_set",\
 "= true, if set port enabled and used as reinitialization value when reset [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.initType",\
 "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.y_start",\
 "Initial or guess value of output (= state)", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.u", \
"Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.y", \
"Connector of Real output signal", 921, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.local_reset",\
 "[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.I.local_set",\
 "", 0, 0.0,0.0,0.0,0,1537)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.k1",\
 "Gain of input signal 1", 1433, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.k2",\
 "Gain of input signal 2", 1434, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.k3",\
 "Gain of input signal 3", 1435, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.u1", \
"Connector of Real input signal 1 [1]", "control_System_Therminol_4_element_all_modes_sec.Error1", 1,\
 5, 7203, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.u2", \
"Connector of Real input signal 2 [1]", "control_System_Therminol_4_element_all_modes_sec.const.k", 1,\
 7, 530, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.u3",\
 "Connector of Real input signal 3", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.y", \
"Connector of Real output signal", "control_System_Therminol_4_element_all_modes_sec.PIDV1.I.u", 1,\
 5, 19421, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.addSat.u1",\
 "Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.PIDV1.y", 1,\
 5, 7065, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.addSat.u2",\
 "Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.PIDV1.limiter.u", 1,\
 5, 7083, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.addSat.y",\
 "Connector of Real output signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV1.addSat.k1",\
 "Gain of input signal 1", 1436, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV1.addSat.k2",\
 "Gain of input signal 2", 1437, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV1.gainTrack.k",\
 "Gain value multiplied with input signal [1]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.gainTrack.u",\
 "Input signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV1.addSat.y", 1,\
 5, 19425, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV1.gainTrack.y",\
 "Output signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV1.addI.u3", 1,\
 5, 19424, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.k", \
"Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.use_reset",\
 "= true, if reset port enabled [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.use_set",\
 "= true, if set port enabled and used as reinitialization value when reset [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.initType",\
 "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.y_start",\
 "Initial or guess value of output (= state)", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.u", \
"Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.y", \
"Connector of Real output signal", 922, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.local_reset",\
 "[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.I.local_set",\
 "", 0, 0.0,0.0,0.0,0,1537)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.k1",\
 "Gain of input signal 1", 1438, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.k2",\
 "Gain of input signal 2", 1439, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.k3",\
 "Gain of input signal 3", 1440, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.u1", \
"Connector of Real input signal 1 [1]", "control_System_Therminol_4_element_all_modes_sec.Error2", 1,\
 5, 7204, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.u2", \
"Connector of Real input signal 2 [1]", "control_System_Therminol_4_element_all_modes_sec.const1.k", 1,\
 7, 555, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.u3",\
 "Connector of Real input signal 3", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.y", \
"Connector of Real output signal", "control_System_Therminol_4_element_all_modes_sec.PIDV2.I.u", 1,\
 5, 19432, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.addSat.u1",\
 "Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.PIDV2.y", 1,\
 5, 7088, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.addSat.u2",\
 "Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.PIDV2.limiter.u", 1,\
 5, 7106, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.addSat.y",\
 "Connector of Real output signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV2.addSat.k1",\
 "Gain of input signal 1", 1441, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV2.addSat.k2",\
 "Gain of input signal 2", 1442, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV2.gainTrack.k",\
 "Gain value multiplied with input signal [1]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.gainTrack.u",\
 "Input signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV2.addSat.y", 1,\
 5, 19436, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV2.gainTrack.y",\
 "Output signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV2.addI.u3", 1,\
 5, 19435, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.k", \
"Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.use_reset",\
 "= true, if reset port enabled [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.use_set",\
 "= true, if set port enabled and used as reinitialization value when reset [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.initType",\
 "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.y_start",\
 "Initial or guess value of output (= state)", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.u", \
"Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.y", \
"Connector of Real output signal", 923, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.local_reset",\
 "[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.I.local_set",\
 "", 0, 0.0,0.0,0.0,0,1537)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.k1",\
 "Gain of input signal 1", 1443, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.k2",\
 "Gain of input signal 2", 1444, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.k3",\
 "Gain of input signal 3", 1445, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.u1", \
"Connector of Real input signal 1 [1]", "control_System_Therminol_4_element_all_modes_sec.Error3", 1,\
 5, 7205, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.u2", \
"Connector of Real input signal 2 [1]", "control_System_Therminol_4_element_all_modes_sec.const2.k", 1,\
 7, 580, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.u3",\
 "Connector of Real input signal 3", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.y", \
"Connector of Real output signal", "control_System_Therminol_4_element_all_modes_sec.PIDV3.I.u", 1,\
 5, 19443, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.addSat.u1",\
 "Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.PIDV3.y", 1,\
 5, 7111, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.addSat.u2",\
 "Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.PIDV3.limiter.u", 1,\
 5, 7129, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.addSat.y",\
 "Connector of Real output signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV3.addSat.k1",\
 "Gain of input signal 1", 1446, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV3.addSat.k2",\
 "Gain of input signal 2", 1447, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV3.gainTrack.k",\
 "Gain value multiplied with input signal [1]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.gainTrack.u",\
 "Input signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV3.addSat.y", 1,\
 5, 19447, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV3.gainTrack.y",\
 "Output signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV3.addI.u3", 1,\
 5, 19446, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.k", \
"Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.use_reset",\
 "= true, if reset port enabled [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.use_set",\
 "= true, if set port enabled and used as reinitialization value when reset [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.initType",\
 "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.y_start",\
 "Initial or guess value of output (= state)", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.u", \
"Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.y", \
"Connector of Real output signal", 924, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.local_reset",\
 "[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.I.local_set",\
 "", 0, 0.0,0.0,0.0,0,1537)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.k1",\
 "Gain of input signal 1", 1448, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.k2",\
 "Gain of input signal 2", 1449, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.k3",\
 "Gain of input signal 3", 1450, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.u1", \
"Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.Error6", 1,\
 5, 7208, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.u2", \
"Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.const5.k", 1,\
 7, 657, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.u3",\
 "Connector of Real input signal 3", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.y", \
"Connector of Real output signal", "control_System_Therminol_4_element_all_modes_sec.PIDV6.I.u", 1,\
 5, 19454, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.addSat.u1",\
 "Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.PIDV6.y", 1,\
 5, 7180, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.addSat.u2",\
 "Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.PIDV6.limiter.u", 1,\
 5, 7198, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.addSat.y",\
 "Connector of Real output signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV6.addSat.k1",\
 "Gain of input signal 1", 1451, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.PIDV6.addSat.k2",\
 "Gain of input signal 2", 1452, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.PIDV6.gainTrack.k",\
 "Gain value multiplied with input signal [1]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.gainTrack.u",\
 "Input signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV6.addSat.y", 1,\
 5, 19458, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.PIDV6.gainTrack.y",\
 "Output signal connector", "control_System_Therminol_4_element_all_modes_sec.PIDV6.addI.u3", 1,\
 5, 19457, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.y",\
 "Connector of Real output signal", 925, 0.0, 0.0,0.0,0.0,0,560)
DeclareDerivative("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.k",\
 "Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.initType",\
 "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.y_start",\
 "Initial or guess value of output (= state)", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.reset",\
 "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]", 1, 1.0,3.0,0.0,0,517)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.y_reset",\
 "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.y_reset_internal",\
 "Internal connector for integrator reset", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.trigger_internal",\
 "Needed to use conditional connector trigger [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.k1",\
 "Gain of input signal 1", 1453, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.k2",\
 "Gain of input signal 2", 1454, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.k3",\
 "Gain of input signal 3", 1455, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.u1",\
 "Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addP.u1", 1,\
 5, 7241, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.u2",\
 "Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addP.u2", 1,\
 5, 7242, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.u3",\
 "Connector of Real input signal 3", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.y",\
 "Connector of Real output signal", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.I.u", 1,\
 5, 19460, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addSat.u1",\
 "Connector of Real input signal 1", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.y", 1,\
 5, 7231, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addSat.u2",\
 "Connector of Real input signal 2", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.limiter.u", 1,\
 5, 7253, 0)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addSat.y",\
 "Connector of Real output signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addSat.k1",\
 "Gain of input signal 1", 1456, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addSat.k2",\
 "Gain of input signal 2", 1457, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.gainTrack.k",\
 "Gain value multiplied with input signal [1]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.gainTrack.u",\
 "Input signal connector", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addSat.y", 1,\
 5, 19469, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.gainTrack.y",\
 "Output signal connector", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.addI.u3", 1,\
 5, 19468, 0)
DeclareParameter("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.Dzero.k",\
 "Constant output value", 1458, 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.Dzero.y",\
 "Connector of Real output signal", "control_System_Therminol_4_element_all_modes_sec.Chromolox_Heater_Control1.Dzero.k", 1,\
 7, 1458, 0)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Valve_1_Opening",\
 "Connector of Real output signal [1]", "control_System_Therminol_4_element_all_modes_sec.firstOrder.y", 1,\
 1, 402, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Valve_2_Opening",\
 "Connector of Real output signal [1]", "control_System_Therminol_4_element_all_modes_sec.firstOrder1.y", 1,\
 1, 403, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Valve_4_Opening",\
 "Connector of Real output signal [1]", "control_System_Therminol_4_element_all_modes_sec.firstOrder3.y", 1,\
 1, 405, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Valve_5_Opening",\
 "Connector of Real output signal [1]", "control_System_Therminol_4_element_all_modes_sec.firstOrder4.y", 1,\
 1, 406, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Valve_6_Opening",\
 "Connector of Real output signal [1]", "control_System_Therminol_4_element_all_modes_sec.firstOrder5.y", 1,\
 1, 407, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Valve_3_Opening",\
 "Connector of Real output signal [1]", "control_System_Therminol_4_element_all_modes_sec.firstOrder2.y", 1,\
 1, 404, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.Discharge_FlowRate",\
 "Value of Real output [kg/s]", "control_System_Therminol_4_element_all_modes_sec.Discharge_mass_flow_sensor.y", 1,\
 5, 7261, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.Charging_flowrate",\
 "Value of Real output [kg/s]", "control_System_Therminol_4_element_all_modes_sec.Charge_mass_flow_sensor.y", 1,\
 5, 7262, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.Heater_Input",\
 "Connector of Real input signal 2", "actuatorSubBus.Heater_Input", 1, 3, 6, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.sensorSubBus.Pump_Flow",\
 "Connector of Real output signal", "sensorSubBus.Pump_Flow", 1, 3, 16, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.Total_Mass_Flow_System",\
 "Input signal connector [kg/s]", "actuatorSubBus.Total_Mass_Flow_System", 1, 3,\
 13, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.Heater_flowrate",\
 "Value of Real output [kg/s]", "actuatorSubBus.Heater_flowrate", 1, 3, 14, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.heater_BOP_massflow",\
 "Value of Real output [kg/s]", "control_System_Therminol_4_element_all_modes_sec.Heater_BOP_mass_flow.y", 1,\
 5, 7308, 4)
DeclareOutput("sensorSubBus.Valve_1_Opening", "=1: completely open, =0: completely closed [1]",\
 0, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("sensorSubBus.Valve_2_Opening", "=1: completely open, =0: completely closed [1]",\
 1, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("sensorSubBus.Valve_3_Opening", "=1: completely open, =0: completely closed [1]",\
 2, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("sensorSubBus.Valve_4_Opening", "=1: completely open, =0: completely closed [1]",\
 3, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("sensorSubBus.Valve_5_Opening", "=1: completely open, =0: completely closed [1]",\
 4, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("sensorSubBus.Valve_6_Opening", "=1: completely open, =0: completely closed [1]",\
 5, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("actuatorSubBus.Heater_Input", "Connector of Real output signal", 6,\
 0.0, 0.0,0.0,0.0,0,520)
DeclareOutput("actuatorSubBus.T_discharge_outlet", "Temperature of the passing fluid [K|degC]",\
 7, 0.0, 0.0,1E+100,0.0,0,520)
DeclareOutput("actuatorSubBus.T_discharge_inlet", "Temperature of the passing fluid [K|degC]",\
 8, 0.0, 0.0,1E+100,0.0,0,520)
DeclareOutput("actuatorSubBus.T_charge_outlet", "Temperature of the passing fluid [K|degC]",\
 9, 0.0, 0.0,1E+100,0.0,0,520)
DeclareOutput("actuatorSubBus.T_charge_inlet", "Temperature of the passing fluid [K|degC]",\
 10, 0.0, 0.0,1E+100,0.0,0,520)
DeclareOutput("actuatorSubBus.Charging_flowrate", "Mass flow rate from port_a to port_b [kg/s]",\
 11, 0.0, 0.0,0.0,0.0,0,520)
DeclareOutput("actuatorSubBus.Discharge_FlowRate", "Mass flow rate from port_a to port_b [kg/s]",\
 12, 0.0, 0.0,0.0,0.0,0,520)
DeclareOutput("actuatorSubBus.Total_Mass_Flow_System", "Mass flow rate from port_a to port_b [kg/s]",\
 13, 0.84, -100000.0,100000.0,0.0,0,520)
DeclareOutput("actuatorSubBus.Heater_flowrate", "Mass flow rate from port_a to port_b [kg/s]",\
 14, 0.84, -100000.0,100000.0,0.0,0,520)
DeclareOutput("actuatorSubBus.heater_BOP_massflow", "Mass flow rate from port_a to port_b [kg/s]",\
 15, 0.0, 0.0,0.0,0.0,0,520)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.T_charge_inlet",\
 "Temperature of the passing fluid [K|degC]", "actuatorSubBus.T_charge_inlet", 1,\
 3, 10, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.T_charge_outlet",\
 "Temperature of the passing fluid [K|degC]", "actuatorSubBus.T_charge_outlet", 1,\
 3, 9, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.T_discharge_inlet",\
 "Temperature of the passing fluid [K|degC]", "actuatorSubBus.T_discharge_inlet", 1,\
 3, 8, 4)
DeclareAlias2("control_System_Therminol_4_element_all_modes_sec.actuatorSubBus.T_discharge_outlet",\
 "Temperature of the passing fluid [K|degC]", "actuatorSubBus.T_discharge_outlet", 1,\
 3, 7, 4)
DeclareOutput("sensorSubBus.Pump_Flow", "Connector of Real output signal", 16, \
0.0, 0.0,0.0,0.0,0,520)
EndNonAlias(20)
PreNonAliasNew(21)
