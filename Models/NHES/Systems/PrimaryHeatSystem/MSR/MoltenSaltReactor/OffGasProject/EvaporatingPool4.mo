within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.OffGasProject;
model EvaporatingPool4

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

  constant String extraPropertiesNames[:]={"Li","LiF","Li2F2","Li3F3","UF3","UF4","ThF4","CsI",
      "CsF","LiI","I2"};

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
  TRANSFORM.HeatAndMassTransfer.Resistances.Mass.SolubilityInterface interface(
      nC=nC) annotation (Placement(transformation(extent={{22,-16},{42,4}})));
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
  connect(salt.traceMassPort, interface.port_a)
    annotation (Line(points={{6,-5.8},{25,-6}}, color={0,140,72}));
  connect(interface.port_b, convection1.port_a)
    annotation (Line(points={{39,-6},{46,-6},{46,13}}, color={0,140,72}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Dassl"));
end EvaporatingPool4;
