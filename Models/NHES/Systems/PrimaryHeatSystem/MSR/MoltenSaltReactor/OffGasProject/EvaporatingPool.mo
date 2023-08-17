within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.OffGasProject;
model EvaporatingPool

  import      Modelica.Units.SI;
  import SIadd = TRANSFORM.Units;
  package Medium = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_9999Li7_pT;

  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port tank1(
    redeclare package Medium = Medium,
    A=1,
    p_start=100000,
    level_start=1,
    use_T_start=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));

    // Only able to compare to Case 3: only have ABC info for those
  parameter String extraSubstances[:]={"Li","LiF","Li2F2","Li3F3","UF3","UF4","ThF4","CsI",
      "CsF","LiI","I2"};
  parameter Integer n=size(extraSubstances, 1) "Number of species";

  parameter SI.Area surfaceArea=Modelica.Constants.pi*(3.5+4.0)^2
    "Interfacial surface area between liquid and head space";
  SIadd.CoefficientOfMassTransfer k_i[n]
    "Mass transfer coefficient of species i";
  SIadd.CoefficientOfMassTransfer k_st "Mass transfer coefficient of steam";
  SI.MassConcentration Cs_i[n] "Saturation concentration of species i";

  parameter SI.MassConcentration Ca_i_start[n]=fill(0, n)
    "Initial concetration of species i in head space";
  SI.MassConcentration Ca_i[n] "Concetration of species i in head space";
  SI.Mass m_i[n] "Mass of species i in head space";
  SI.Pressure Ps_i[n] "Saturation pressure of species i";
  parameter SI.MolarMass MM_i[n]={TRANSFORM.PeriodicTable.CalculateMolarMass(extraSubstances[i]) for i in 1:n} "Molecular weight of species i";
  parameter SI.MolarMass MM_N2=TRANSFORM.PeriodicTable.CalculateMolarMass("N2") "Molecular mass of N2";
  parameter SI.Temperature T=300 "Temperature in head space";
  SI.DiffusionCoefficient Dst_a "Diffusivity of steam in the head space";
  SI.DiffusionCoefficient D_i_N2[n]
    "Binary diffusivity of evaporation compound i in N2";

  parameter Real A[n]={13.927,39.233,11.969,11.695,12.34,99.511,12.931,41.755,10.82,
      27.581,62.522};
  parameter Real B[n]={-8411.918,-17512.525,-12863.33,-12734.668,-16614.284,-28515.009,
      -15448.733,-12406.991,-8861.135,-10989.817,-5595.471};
  parameter Real C[n]={-1.157,-7.673,0,0,0,-24.05,0,-9.013,0,-4.747,-17.022};

  parameter Real P=1e5 "Pressure in head space";
  parameter SI.Volume volume=surfaceArea*(3+7+5+5)-(Modelica.Constants.pi*3.5^2*7) "Volume of head space";

  Real sigma_i_N2[n];
  Real omegaD_i_N2[n];
  Real sigma_i[n];
  Real sigma_N2;
  Real epsilon_i_N2[n];
  Real epsilon_i[n];
  Real epsilon_N2;
  Real Tstar[n];

  Real Sh;
  Real Nu=1;
  Real Sc=1;
  Real Pr=1;
  Real L_c=1;

protected
  SI.Temperature unitK=1;

initial equation
  Ca_i = Ca_i_start;

equation

  Dst_a = 4.7931e-5*T^1.9/P;
  //verified

  k_st = Sh*Dst_a/L_c;
  //verified

  Sh = Nu*Sc^(1/3)*Pr^(1/3);
  //verified

  sigma_N2 = 3.798;//e-10;
  //verified

  epsilon_N2/Modelica.Constants.k = 71.4;
  //verified

  for i in 1:n loop

    Ca_i[i] = m_i[i]/volume;

    // Mass Balance
    der(m_i[i]) = surfaceArea*k_i[i]*(Cs_i[i] - Ca_i[i]);
    //verified

    // Saturation calculation
    Cs_i[i] = Ps_i[i]*MM_i[i]/(Modelica.Constants.R*T);
    //verified

    log10(Ps_i[i]) = A[i] + B[i]*unitK/T + C[i]*log10(T/unitK);
    //verified

    k_i[i]/k_st = D_i_N2[i]/Dst_a;
    //verified

    D_i_N2[i] = 0.0018583*T^(1.5)*sqrt(1/MM_i[i] + 1/MM_N2)/(P*sigma_i_N2[i]^2*
      omegaD_i_N2[i]);
    //verified

    sigma_i_N2[i] = 0.5*(sigma_i[i] + sigma_N2);
    //verified //known

    sigma_i[i] = 3.617;//e-10;
    //verified

    omegaD_i_N2[i] = 1.06036/T^(0.15610) + 0.19300/exp(0.47635*Tstar[i]) + 1.03587
      /exp(1.52996*Tstar[i]) + 1.76474/exp(3.89411*Tstar[i]);
    //verified

    Tstar[i] = Modelica.Constants.k*T/epsilon_i_N2[i];
    //verified

    epsilon_i_N2[i] = sqrt(epsilon_i[i]*epsilon_N2);
    //verified

    epsilon_i[i]/Modelica.Constants.k = 97;
    //verified
  end for;

  connect(boundary.ports[1], tank1.port)
    annotation (Line(points={{-20,-20},{0,-20},{0,-8.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EvaporatingPool;
