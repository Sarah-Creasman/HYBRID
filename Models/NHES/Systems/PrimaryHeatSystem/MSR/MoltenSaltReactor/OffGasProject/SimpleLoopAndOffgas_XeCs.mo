within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.OffGasProject;
model SimpleLoopAndOffgas_XeCs

  extends TRANSFORM.Icons.Example;
//   import SI = Modelica.SIunits;
//   import SIadd = TRANSFORM.Units;

  package Medium = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_9999Li7_pT(extraPropertiesNames=
          {"Xe133m","Xe133","Cs133"}, C_nominal=fill(1.0, nC));
  package Medium_offgas = Modelica.Media.IdealGases.SingleGases.He(extraPropertiesNames=
          {"Xe133m","Xe133","Cs133"}, C_nominal=fill(1.0, nC));

  constant Integer nC=3;
  parameter Integer nV=10;
  parameter SI.Length length=1.0;
  parameter SI.Length dimension=0.01;
  parameter SI.Temperature T_start=20 + 273.15;
  parameter SI.Pressure p_start=4e5;

  parameter SI.Velocity v=0.02;

  parameter SI.Time t_half[nC]={TRANSFORM.Units.Conversions.Functions.Time_s.from_day(2.198),TRANSFORM.Units.Conversions.Functions.Time_s.from_day(5.2475),Modelica.Constants.inf};
  final parameter TRANSFORM.Units.InverseTime lambda_i[nC]={log(2)/t_half[i] for i in 1:nC};

  parameter SIadd.ExtraPropertyConcentration C_i_start[nV,nC]=0.0*ones(nV, nC);
  parameter SIadd.ExtraPropertyConcentration C_i_inlet[nC]=zeros(nC);

  final parameter SI.MassFlowRate m_flow=Medium.density_pT(p_start, T_start)*
      Modelica.Constants.pi*dimension^2/4*v;

  parameter SI.VolumeFlowRate V_flow = 5/1000/60;
  parameter SI.MassFlowRate m_flow_offgas = V_flow*Medium_offgas.density_pT(p_start,T_start);

  parameter SI.Time t_holdup_decaytank = TRANSFORM.Units.Conversions.Functions.Time_s.from_hr(47);
  parameter SI.Time t_holdup_hydroxideScrubber = 10;
  parameter SI.Time t_holdup_halideTrap = 10;
  parameter SI.Time t_holdup_drier = 10;
  parameter SI.Time t_holdup_charcoalBed = TRANSFORM.Units.Conversions.Functions.Time_s.from_day(100);

  parameter SI.Volume V_decaytank = V_flow*t_holdup_decaytank;
  parameter SI.Volume V_hydroxideScrubber = V_flow*t_holdup_hydroxideScrubber;
  parameter SI.Volume V_halideTrap = V_flow*t_holdup_halideTrap;
  parameter SI.Volume V_drier = V_flow*t_holdup_drier;
  parameter SI.Volume V_charcoalBed = V_flow*t_holdup_charcoalBed;

  SI.Time t_residence = if pipe.m_flows[1] < Modelica.Constants.eps then Modelica.Constants.inf else pipe.ms[1]/pipe.m_flows[1];

  // Convert from volume based to mass based
  final parameter SIadd.ExtraProperty Cs_start[nV,nC]= {{C_i_start[i, j]/
      Medium.density_pT(p_start, T_start) for j in 1:nC} for i in 1:nV};
  final parameter SIadd.ExtraProperty Cs_inlet[nC]={C_i_inlet[j]/
      Medium.density_pT(p_start, T_start) for j in 1:nC};

  SIadd.ExtraPropertyConcentration C_i[nV,nC];

  parameter Boolean use_generation = true;
  parameter Boolean use_PtoD = true;
  parameter Boolean use_capture = false;
  parameter Real parents[nC,nC]=if nC == 3 then
 {{0.0,0.0,0.0},
  {1.0,0.0,0.0},
  {0.0,1.0,0.0}} else fill(0,nC,nC)
    "Matrix of parent sources (sum(column) = 0 or 1) for each fission product 'daughter'. Row is daughter, Column is parent.";

  parameter Real fissionToFP[nC] = {0.0266,0.0085,0.0};

  SIadd.ExtraPropertyFlowRate[nV,nC] mC_gens={{mC_decay[i, j]
  + (if use_generation then mC_generation[i, j] else 0)
  + (if use_PtoD then mC_gens_PtoD[i, j] else 0)
  + (if use_capture then mC_gens_capture[i, j] else 0)
  for j in 1:nC} for i in 1:nV};

  SIadd.ExtraPropertyFlowRate[nV,nC] mC_decay = {{-lambda_i[j]*pipe.mCs[i, j]*pipe.nParallel for j in 1:nC} for i in 1:nV};
  Real[nV] mC_generationShape = {sin(Modelica.Constants.pi*pipe.summary.xpos_norm[i]) for i in 1:nV};
  //Real[nV] mC_captureShape = {sum({sin(k*Modelica.Constants.pi*pipe.summary.xpos_norm[i])/k for k in 1:100}) for i in 1:nV};
  Real[nV] mC_captureShape = {sum({-sin(k*Modelica.Constants.pi*(pipe.summary.xpos_norm[i]+1))/k for k in 1:100}) for i in 1:nV};
  SIadd.ExtraPropertyFlowRate[nV,nC] mC_generation = {{10000*mC_generationShape[i]*fissionToFP[j] for j in 1:nC} for i in 1:nV};
  SIadd.ExtraPropertyFlowRate[nV,nC] mC_gens_PtoD={{sum({lambda_i[k]*pipe.mCs[i, k]*pipe.nParallel*parents[j, k] for k in 1:nC}) for j in 1:nC} for i in 1:nV};
  SIadd.ExtraPropertyFlowRate[nV,nC] mC_gens_capture={{-0.1*mC_captureShape[i]* pipe.mCs[i, j]*pipe.nParallel for j in 1:nC} for i in 1:nV};

  // Offgas System
  SIadd.ExtraPropertyFlowRate[nC] mC_gens_decayTank={mC_decay_decayTank[j]
  + (if use_PtoD then mC_gens_PtoD_decayTank[j] else 0)
  for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_decay_decayTank = {-lambda_i[j]*decayTank.mC[j] for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_gens_PtoD_decayTank={sum({lambda_i[k]*decayTank.mC[k]*parents[j, k] for k in 1:nC}) for j in 1:nC};

  SIadd.ExtraPropertyFlowRate[nC] mC_gens_hydroxideScrubber={mC_decay_hydroxideScrubber[j]
  + (if use_PtoD then mC_gens_PtoD_hydroxideScrubber[j] else 0)
  for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_decay_hydroxideScrubber = {-lambda_i[j]*hydroxideScrubber.mC[j] for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_gens_PtoD_hydroxideScrubber={sum({lambda_i[k]*hydroxideScrubber.mC[k]*parents[j, k] for k in 1:nC}) for j in 1:nC};

    SIadd.ExtraPropertyFlowRate[nC] mC_gens_halideTrap={mC_decay_halideTrap[j]
  + (if use_PtoD then mC_gens_PtoD_halideTrap[j] else 0)
  for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_decay_halideTrap = {-lambda_i[j]*halideTrap.mC[j] for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_gens_PtoD_halideTrap={sum({lambda_i[k]*halideTrap.mC[k]*parents[j, k] for k in 1:nC}) for j in 1:nC};

    SIadd.ExtraPropertyFlowRate[nC] mC_gens_drier={mC_decay_drier[j]
  + (if use_PtoD then mC_gens_PtoD_drier[j] else 0)
  for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_decay_drier = {-lambda_i[j]*drier.mC[j] for j in 1:nC};
  SIadd.ExtraPropertyFlowRate[nC] mC_gens_PtoD_drier={sum({lambda_i[k]*drier.mC[k]*parents[j, k] for k in 1:nC}) for j in 1:nC};

  // End Offgas System

  SIadd.ExtraPropertyConcentration C_i_loop[nV,nC];

  SIadd.ExtraPropertyFlowRate[nV,nC] mC_gens_loop={{mC_decay_loop[i, j] + (if use_PtoD then mC_gens_PtoD_loop[i, j] else 0) for j in 1:nC} for i in 1:nV};

  SIadd.ExtraPropertyFlowRate[nV,nC] mC_decay_loop = {{-lambda_i[j]*pipe_loop.mCs[i, j]*pipe_loop.nParallel for j in 1:nC} for i in 1:nV};
  SIadd.ExtraPropertyFlowRate[nV,nC] mC_gens_PtoD_loop={{sum({lambda_i[k]* pipe_loop.mCs[i, k]* pipe_loop.nParallel* parents[j, k] for k in 1:nC}) for j in 1:nC} for i in 1:nV};

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_loop(
    redeclare package Medium = Medium,
    p_a_start=p_start,
    T_a_start=T_start,
    m_flow_a_start=m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=dimension,
        length=length,
        nV=nV),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens=mC_gens_loop))
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe(
    redeclare package Medium = Medium,
    Cs_start=Cs_start,
    p_a_start=p_start,
    T_a_start=T_start,
    m_flow_a_start=m_flow,
    redeclare replaceable model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=dimension,
        length=length,
        nV=nV),
    redeclare replaceable model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens=mC_gens))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));

  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C0(redeclare
      package Medium = Medium, allowFlowReversal=false,
    showName=false)
    annotation (Placement(transformation(extent={{30,-30},{10,-50}})));

  TRANSFORM.Fluid.Volumes.ExpansionTank tank(
    redeclare package Medium = Medium,
    A=1,
    p_start=p_start,
    level_start=0.1,
    h_start=Medium.specificEnthalpy_pT(p_start, T_start))
    annotation (Placement(transformation(extent={{-30,16},{-10,36}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
      Medium =
        Medium, m_flow_nominal=m_flow)
    annotation (Placement(transformation(extent={{-10,-50},{-30,-30}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume decayTank(
    redeclare package Medium = Medium_offgas,
    p_start=p_start,
    T_start=T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=V_decaytank),
    mC_gen=mC_gens_decayTank)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));

  TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(redeclare
      package Medium = Medium,
    redeclare package Medium_carrier = Medium_offgas,
    iSep={1,2,3},
    eta=fill(0.9, traceSeparator.nSep))
    annotation (Placement(transformation(extent={{0,36},{20,16}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    showName=false,
    redeclare package Medium = Medium_offgas,
    m_flow=m_flow_offgas,
    T=T_start,
    nPorts=1) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    showName=false,
    redeclare package Medium = Medium_offgas,
    p=p_start,
    T=T_start,
    nPorts=1) annotation (Placement(transformation(extent={{180,-60},{160,-40}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium_offgas,
    showName=false,                             R=0.00001)
    annotation (Placement(transformation(extent={{134,30},{154,50}})));
  TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(
    redeclare package Medium = Medium_offgas,
    showName=false,
    eta={0,0,0.8})
    annotation (Placement(transformation(extent={{82,30},{102,50}})));
  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C2(
    redeclare package Medium = Medium_offgas,
    showName=false,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{108,30},{128,50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
    redeclare package Medium = Medium_offgas,
    showName=false,
    R=0.00001)
    annotation (Placement(transformation(extent={{134,10},{154,30}})));
  TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator1(
    redeclare package Medium = Medium_offgas,
    showName=false,
    eta={0,0,0.9})
    annotation (Placement(transformation(extent={{82,10},{102,30}})));
  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C3(
    redeclare package Medium = Medium_offgas,
    showName=false,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{108,10},{128,30}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume hydroxideScrubber(
    redeclare package Medium = Medium_offgas,
    p_start=p_start,
    T_start=T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=V_hydroxideScrubber),
    mC_gen=mC_gens_hydroxideScrubber)
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(
    redeclare package Medium = Medium_offgas,
    showName=false,
    R=0.00001)
    annotation (Placement(transformation(extent={{134,-10},{154,10}})));
  TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator2(
    redeclare package Medium = Medium_offgas,
    showName=false,
    eta={0,0,0.8})
    annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C4(
    redeclare package Medium = Medium_offgas,
    showName=false,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{108,-10},{128,10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume halideTrap(
    redeclare package Medium = Medium_offgas,
    p_start=p_start,
    T_start=T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=V_halideTrap),
    mC_gen=mC_gens_halideTrap)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(
    redeclare package Medium = Medium_offgas,
    showName=false,
    R=0.00001)
    annotation (Placement(transformation(extent={{134,-30},{154,-10}})));
  TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator3(
    redeclare package Medium = Medium_offgas,
    showName=false,
    eta={0,0,0.99})
    annotation (Placement(transformation(extent={{82,-30},{102,-10}})));
  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C5(
    redeclare package Medium = Medium_offgas,
    showName=false,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{108,-30},{128,-10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume drier(
    redeclare package Medium = Medium_offgas,
    p_start=p_start,
    T_start=T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=V_drier),
    mC_gen=mC_gens_drier)
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator4(
    redeclare package Medium = Medium_offgas,
    showName=false,
    eta={0,0,1})
    annotation (Placement(transformation(extent={{82,-60},{102,-40}})));
  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C6(
    redeclare package Medium = Medium_offgas,
    showName=false,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{108,-60},{128,-40}})));
  TRANSFORM.Fluid.Sensors.TraceSubstancesTwoPort_multi sensor_C1(
    redeclare package Medium = Medium_offgas,
    showName=false,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));

  TRANSFORM.Fluid.TraceComponents.DecayBed_Simple charcoalBed(
    redeclare package Medium = Medium_offgas,
    nV=10,
    V=V_charcoalBed,
    R=fill(0.0001, charcoalBed.nV),
    lambdas=lambda_i,
    parents=parents,
    p_a_start=p_start,
    T_a_start=T_start)
    annotation (Placement(transformation(extent={{54,-60},{74,-40}})));
equation

  // Create variable for volume based concentration
  for j in 1:nV loop
    for i in 1:nC loop
      C_i[j, i] = pipe.Cs[j, i]*pipe.mediums[j].d;
    end for;
  end for;
  // Create variable for volume based concentration
  for j in 1:nV loop
    for i in 1:nC loop
      C_i_loop[j, i] = pipe_loop.Cs[j, i]*pipe_loop.mediums[j].d;
    end for;
  end for;
  connect(tank.port_a, pipe.port_b)
    annotation (Line(points={{-27,20},{-40,20},{-40,10}},color={0,127,255}));
  connect(pump.port_b, pipe.port_a) annotation (Line(points={{-30,-40},{-40,-40},
          {-40,-10}}, color={0,127,255}));
  connect(traceSeparator.port_b, pipe_loop.port_a)
    annotation (Line(points={{20,20},{40,20},{40,10}}, color={0,127,255}));
  connect(tank.port_b, traceSeparator.port_a)
    annotation (Line(points={{-13,20},{0,20}}, color={0,127,255}));
  connect(traceSeparator.port_sepFluid, pipe_loop.port_a)
    annotation (Line(points={{20,26},{40,26},{40,10}}, color={0,127,255}));
  connect(boundary.ports[1], traceSeparator.port_a_carrier) annotation (Line(
        points={{-20,50},{-10,50},{-10,32},{0,32}}, color={0,127,255}));
  connect(decayTank.port_b, simpleSeparator.port_a)
    annotation (Line(points={{76,40},{82,40}}, color={0,127,255}));
  connect(pipe_loop.port_b, sensor_C0.port_a)
    annotation (Line(points={{40,-10},{40,-40},{30,-40}}, color={0,127,255}));
  connect(sensor_C0.port_b, pump.port_a)
    annotation (Line(points={{10,-40},{-10,-40}}, color={0,127,255}));
  connect(simpleSeparator.port_b, sensor_C2.port_a)
    annotation (Line(points={{102,40},{108,40}}, color={0,127,255}));
  connect(sensor_C2.port_b, resistance.port_a)
    annotation (Line(points={{128,40},{137,40}}, color={0,127,255}));
  connect(simpleSeparator1.port_b, sensor_C3.port_a)
    annotation (Line(points={{102,20},{108,20}}, color={0,127,255}));
  connect(sensor_C3.port_b, resistance1.port_a)
    annotation (Line(points={{128,20},{137,20}}, color={0,127,255}));
  connect(hydroxideScrubber.port_b, simpleSeparator1.port_a)
    annotation (Line(points={{76,20},{82,20}}, color={0,127,255}));
  connect(simpleSeparator2.port_b, sensor_C4.port_a)
    annotation (Line(points={{102,0},{108,0}}, color={0,127,255}));
  connect(sensor_C4.port_b, resistance2.port_a)
    annotation (Line(points={{128,0},{137,0}}, color={0,127,255}));
  connect(halideTrap.port_b, simpleSeparator2.port_a)
    annotation (Line(points={{76,0},{82,0}}, color={0,127,255}));
  connect(resistance1.port_b, halideTrap.port_a) annotation (Line(points={{151,20},
          {160,20},{160,12},{52,12},{52,0},{64,0}}, color={0,127,255}));
  connect(simpleSeparator3.port_b, sensor_C5.port_a)
    annotation (Line(points={{102,-20},{108,-20}}, color={0,127,255}));
  connect(sensor_C5.port_b, resistance3.port_a)
    annotation (Line(points={{128,-20},{137,-20}}, color={0,127,255}));
  connect(drier.port_b, simpleSeparator3.port_a)
    annotation (Line(points={{76,-20},{82,-20}}, color={0,127,255}));
  connect(resistance2.port_b, drier.port_a) annotation (Line(points={{151,0},{160,
          0},{160,-8},{52,-8},{52,-20},{64,-20}}, color={0,127,255}));
  connect(simpleSeparator4.port_b, sensor_C6.port_a)
    annotation (Line(points={{102,-50},{108,-50}}, color={0,127,255}));
  connect(resistance.port_b, hydroxideScrubber.port_a) annotation (Line(points={
          {151,40},{160,40},{160,32},{52,32},{52,20},{64,20}}, color={0,127,255}));
  connect(traceSeparator.port_b_carrier, sensor_C1.port_a) annotation (Line(
        points={{20,32},{28,32},{28,40},{40,40}}, color={0,127,255}));
  connect(sensor_C1.port_b, decayTank.port_a)
    annotation (Line(points={{60,40},{64,40}}, color={0,127,255}));
  connect(sensor_C6.port_b, boundary1.ports[1])
    annotation (Line(points={{128,-50},{160,-50}}, color={0,127,255}));
  connect(charcoalBed.port_b, simpleSeparator4.port_a)
    annotation (Line(points={{74,-50},{82,-50}}, color={0,127,255}));
  connect(resistance3.port_b, charcoalBed.port_a) annotation (Line(points={{151,
          -20},{160,-20},{160,-32},{48,-32},{48,-50},{54,-50}}, color={0,127,
          255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{180,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{180,
            100}})),
    experiment(
      StopTime=17280000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"));
end SimpleLoopAndOffgas_XeCs;
