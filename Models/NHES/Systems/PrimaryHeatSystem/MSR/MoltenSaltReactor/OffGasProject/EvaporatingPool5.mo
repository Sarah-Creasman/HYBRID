within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.OffGasProject;
model EvaporatingPool5

  import      Modelica.Units.SI;
  import SIadd = TRANSFORM.Units;
  package Medium_salt =
      TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_9999Li7_pT (
        extraPropertiesNames=extraPropertiesNames);
  package Medium_head = Modelica.Media.IdealGases.SingleGases.N2 (
        extraPropertiesNames=extraPropertiesNames);

  parameter SI.Temperature T_start_headSpace=300 "Initial temperature";

  parameter SI.Temperature T_start_salt=500 "Initial temperature";

  parameter SI.AbsolutePressure p_start_headSpace=1e5 "Initial head space pressure";

  parameter SIadd.ExtraProperty C_start_headSpace[nC]=zeros(nC) "Mass-Specific value";
  parameter SIadd.ExtraProperty C_start_salt[nC]=fill(1,nC) "Mass-Specific value";

  parameter SI.Area surfaceArea=Modelica.Constants.pi*1^2
    "Interfacial surface area between liquid and head space";

  parameter SI.Length length=1 "Height of head space";

  constant String extraPropertiesNames[:]={"Li","LiF","Na","NaF","F2Na2","F3Na3","K","KF","K2F2","Cs"};

  constant Integer nC=size(extraPropertiesNames, 1) "Number of species";

  parameter SI.MolarMass MM_i[nC]={TRANSFORM.PeriodicTable.CalculateMolarMass(
      extraPropertiesNames[i]) for i in 1:nC} "Molecular weight of species";
  //swith MMs to avogadro's number to track for atoms in volumes.

  // transfer coefficients are highly dependent on the situtation being evaluated.
  SI.CoefficientOfHeatTransfer alpha=5 "Heat transfer coefficient between salt and head space";
  SIadd.CoefficientOfMassTransfer alphaM[nC] = fill(0.001,nC) "Mass transfer coefficient of species";

/*
1. Faghri, A., Zhang, Y.: Fundamentals of Multiphase Heat Transfer and Flow. Springer International Publishing, Cham (2020)
page 426

Nu = alpah*Lc/lambda;
Lc = surfaceArea/perimeter;
Nu = 0.664*Re^0.5*Pr^(1/3); 
Sh = 0.664*Re^0.5*Sc^(1/3);
Re = d_gas*v_gas/mu_gas;
Pr = Pr_gas
Sc = mu_gas/d_gas/D_i_inGas

mass transfer of species could be a function of main salt transfer?
should there be a henry/sieverts law interface?

H = A+B/T+C*log10(T)+D*T - henrys law = f(T)
*/

  //
  //
  //   SI.MassConcentration Csat_i[nC] "Saturation concentration of species";
  //
  //   SI.Pressure Ps_i[nC] "Saturation pressure of species i";
  //
//   parameter Real A[nC]={13.927,39.233,11.969,11.695,12.34,99.511,12.931,41.755,10.82,
//       27.581,62.522};
//   parameter Real B[nC]={-8411.918,-17512.525,-12863.33,-12734.668,-16614.284,-28515.009,
//       -15448.733,-12406.991,-8861.135,-10989.817,-5595.471};
//   parameter Real C[nC]={-1.157,-7.673,0,0,0,-24.05,0,-9.013,0,-4.747,-17.022};

  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port salt(
    redeclare package Medium = Medium_salt,
    A=surfaceArea,
    p_surface=headSpace.medium.p,
    p_start=headSpace.p_start,
    level_start=1,
    use_T_start=true,
    T_start=T_start_salt,
    C_start=C_start_salt,
    use_HeatPort=true,
    use_TraceMassPort=true,
    MMs=MM_i)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_salt(
    redeclare package Medium = Medium_salt,
    T=T_start_salt,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port headSpace(
    redeclare package Medium = Medium_head,
    p_start=p_start_headSpace,
    T_start=T_start_headSpace,
    C_start=C_start_headSpace,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
        (length=length, crossArea=surfaceArea),
    use_HeatPort=true,
    use_TraceMassPort=true,
    MMs=MM_i)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_headSpace(
    redeclare package Medium = Medium_head,
    T=T_start_headSpace,
    nPorts=1) annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(
      surfaceArea=surfaceArea, alpha=alpha) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,20})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Mass.Convection convection1(
    nC=nC,
    surfaceArea=surfaceArea,
    alphaM=alphaM) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={46,20})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Mass.Concentration boundary(
      nC=nC, use_port=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={46,-10})));
  Modelica.Blocks.Sources.RealExpression concentration[nC](y=headSpace.medium.p
        *partialPressures.y*1e5/(Modelica.Constants.R*saltTemperature.y))
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Tables.CombiTable1Ds partialPressures(table=[273.15,5.95367e-35,
        6.48155e-45,2.4296e-17,9.01455e-47,9.26747e-50,2.299e-62,9.33676e-13,1.29552e-38,
        1.86513e-43,1.22434e-10; 323.15,8.28513e-29,9.49562e-37,6.29233e-14,2.64977e-38,
        1.11544e-40,4.59795e-51,4.01979e-10,1.855e-31,2.46795e-35,2.24704e-08; 373.15,
        2.56788e-24,8.8579e-31,1.93258e-11,4.05048e-32,4.66249e-34,8.12305e-43,3.30518e-08,
        3.09505e-26,2.06552e-29,9.8819e-07; 423.15,6.7011e-21,3.15271e-26,1.47356e-09,
        2.07985e-27,5.05703e-29,1.5341e-36,9.19524e-07,2.92566e-22,6.60291e-25,1.72812e-05;
        473.15,3.27394e-18,1.20498e-22,4.40648e-08,1.05305e-23,4.54e-25,1.30602e-31,
        1.24138e-05,3.90202e-19,2.27605e-21,0.00016122; 523.15,4.86311e-16,9.3759e-20,
        6.7922e-07,1.02227e-20,6.90226e-22,1.21883e-27,0.000100654,1.28952e-16,1.60517e-18,
        0.000963063; 573.15,2.98825e-14,2.2522e-17,6.39857e-06,2.93315e-18,2.83086e-19,
        2.22327e-24,0.000560923,1.5289e-14,3.54006e-16,0.004164963; 623.15,9.44403e-13,
        2.21715e-15,4.169e-05,3.33682e-16,4.29551e-17,1.17377e-21,0.002353791,8.2915e-13,
        3.20259e-14,0.014118761; 673.15,1.77737e-11,1.0912e-13,0.000203659,1.85009e-14,
        3.01028e-15,2.36314e-19,0.007928797,2.45428e-11,1.45568e-12,0.039633095;
        723.15,2.67394e-10,3.10059e-12,0.000954647,5.80435e-13,1.14387e-13,2.21526e-17,
        0.022452231,3.73178e-10,2.64095e-11,0.095853065; 737.84979,6.15662e-10,7.59401e-12,
        0.001606542,1.45893e-12,3.02103e-13,7.44485e-17,0.029653732,6.93931e-10,
        4.61805e-11,0.12133854; 753.72239,1.22385e-09,1.75773e-11,0.002526727,3.79755e-12,
        8.29529e-13,2.6304e-16,0.039540491,1.44052e-09,9.82364e-11,0.15482623; 773.15,
        2.76623e-09,4.77475e-11,0.003763689,1.02517e-11,2.10576e-12,7.92238e-16,
        0.055301113,3.39955e-09,2.39985e-10,0.20566931; 823.15,1.89148e-08,4.98549e-10,
        0.009610771,1.0526e-10,1.8532e-11,1.03559e-14,0.12156451,2.53946e-08,1.92507e-09,
        0.4002788; 845.14906,4.10184e-08,1.27659e-09,0.01400665,2.67474e-10,4.40843e-11,
        2.87971e-14,0.1667056,5.6745e-08,4.40761e-09,0.52257547; 873.15,1.02799e-07,
        3.9366e-09,0.02167818,8.13161e-10,1.2303e-10,9.63678e-14,0.24325827,1.49963e-07,
        1.20881e-08,0.6879411; 877.76432,1.18931e-07,4.70518e-09,0.023231446,9.69653e-10,
        1.44679e-10,1.16606e-13,0.2582623,1.74892e-07,1.41759e-08,0.71850594; 923.15,
        4.01086e-07,2.49973e-08,0.035024904,4.59445e-09,5.5557e-10,5.39171e-13,0.45001128,
        8.49594e-07,8.43448e-08,0.51496245; 930.90632,4.88129e-07,3.26941e-08,0.03718941,
        5.85999e-09,6.80093e-10,6.75308e-13,0.49200358,1.09445e-06,1.12122e-07,0.47080528;
        973.15,9.89191e-07,1.28438e-07,0.041534232,2.25503e-08,2.31958e-09,2.84314e-12,
        0.50832518,3.52641e-06,3.70416e-07,0.45013555; 1023.15,2.11869e-06,5.56281e-07,
        0.046700545,9.527e-08,8.5327e-09,1.30302e-11,0.52586765,1.23123e-05,1.31836e-06,
        0.4274154; 1073.15,4.23133e-06,2.08604e-06,0.051848521,3.48387e-07,2.72926e-08,
        5.05274e-11,0.54165568,3.78981e-05,4.09805e-06,0.40644711; 1123.15,7.95326e-06,
        6.90712e-06,0.056939112,1.12473e-06,7.74051e-08,1.69719e-10,0.55584675,0.000104635,
        1.13377e-05,0.3870821; 1173.15,1.41779e-05,2.05246e-05,0.061938987,3.2585e-06,
        1.97821e-07,5.03492e-10,0.56856246,0.000262858,2.83556e-05,0.36916918; 1223.15,
        2.4124e-05,5.54813e-05,0.06681746,8.58812e-06,4.61737e-07,1.3407e-09,0.57987038,
        0.000608023,6.49441e-05,0.35255054; 1273.15,3.93875e-05,0.000138,0.071542093,
        2.08293e-05,9.95497e-07,3.24819e-09,0.589758,0.001307989,0.000137694,0.33705501])
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Blocks.Sources.RealExpression saltTemperature(y=
        salt.Medium.temperature(salt.state_liquid))
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Mass.MassFlow boundary1(nC=
        nC, use_port=true)
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  Modelica.Blocks.Sources.RealExpression molarFlowRate[nC](y=boundary.port.n_flow)
    annotation (Placement(transformation(extent={{100,-30},{80,-10}})));
equation
  connect(boundary_salt.ports[1], salt.port)
    annotation (Line(points={{-40,-20},{0,-20},{0,-8.4}}, color={0,127,255}));
  connect(boundary_headSpace.ports[1], headSpace.port)
    annotation (Line(points={{-40,40},{14,40}}, color={0,127,255}));
  connect(headSpace.heatPort, convection.port_b)
    annotation (Line(points={{20,34},{20,27}}, color={191,0,0}));
  connect(convection.port_a, salt.heatPort)
    annotation (Line(points={{20,13},{20,0},{8.4,0}}, color={191,0,0}));
  connect(headSpace.traceMassPort, convection1.port_b)
    annotation (Line(points={{24,36},{46,36},{46,27}}, color={0,140,72}));
  connect(boundary.port, convection1.port_a)
    annotation (Line(points={{46,0},{46,13}}, color={0,140,72}));
  connect(concentration.y, boundary.C_ext)
    annotation (Line(points={{41,-50},{46,-50},{46,-14}}, color={0,0,127}));
  connect(saltTemperature.y, partialPressures.u)
    annotation (Line(points={{-19,-50},{-12,-50}},
                                                color={0,0,127}));
  connect(boundary1.port, salt.traceMassPort)
    annotation (Line(points={{60,-20},{6,-20},{6,-5.8}}, color={0,140,72}));
  connect(boundary1.n_flow_ext, molarFlowRate.y)
    annotation (Line(points={{74,-20},{79,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Dassl"));
end EvaporatingPool5;
