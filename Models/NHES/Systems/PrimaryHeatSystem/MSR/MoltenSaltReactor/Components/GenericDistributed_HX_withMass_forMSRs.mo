within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.Components;
model GenericDistributed_HX_withMass_forMSRs
  extends TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass(
      replaceable package Medium_tube =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (
          extraPropertiesNames=kinetics_data.extraPropertiesNames, C_nominal=
            kinetics_data.C_nominal),
    redeclare replaceable model InternalTraceGen_tube =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens={{-
      kinetics_data.lambdas[j]*tube.mCs[i, j]*tube.nParallel + mC_gens_PtoD[i, j] for j in
          1:kinetics_data.nC} for i in 1:tube.nV}),
    redeclare replaceable model InternalHeatGen_tube =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gens={sum({((if includeDecayHeatNear then
      kinetics_data.w_near_decay[j] else 0) + (if includeDecayHeatFar then
      kinetics_data.w_far_decay[j] else 0))*kinetics_data.lambdas[j]*tube.mCs[i, j]*tube.nParallel
      for j in 1:kinetics_data.nC}) for i in 1:tube.nV}),
    Cs_start_tube= {cat(
      1,
      fill(0, kinetics_data.data_PG.nC),
      fill(0, kinetics_data.data_FP.nC),
      C_start_TR) for i in 1:tube.nV});

  replaceable record Data =
      TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_TRACEdefault
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.PartialPrecursorGroup
    "Neutron Precursor Data" annotation (choicesAllMatching=true,Dialog(tab="MSR Specific"));

  replaceable record Data_FP =
      TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_0
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.PartialFissionProduct
    "Fission Product Data" annotation (choicesAllMatching=true,Dialog(tab="MSR Specific"));

  replaceable record Data_TR =
      TRANSFORM.Nuclear.ReactorKinetics.Data.Tritium.tritium_0 constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.Tritium.PartialTritium
    "Tritium Contributors Data" annotation (choicesAllMatching=true,Dialog(tab="MSR Specific"));

  replaceable record Data_CP =
      TRANSFORM.Nuclear.ReactorKinetics.Data.CorrosionProducts.corrosionProduct_0
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.CorrosionProducts.PartialCorrosionProduct
    "Corrosion Product information" annotation (choicesAllMatching=true,Dialog(tab="MSR Specific"));

  parameter Boolean includeDecayHeatNear(fixed=true) = true annotation(Dialog(tab="MSR Specific"));
  parameter Boolean includeDecayHeatFar(fixed=true) = true annotation(Dialog(tab="MSR Specific"));

parameter TRANSFORM.Units.ExtraProperty[kinetics_data.data_TR.nC]
    C_start_TR= fill(0,kinetics_data.data_TR.nC) "Tritium related initial values" annotation(Dialog(tab="MSR Specific"));

  TRANSFORM.Units.ExtraPropertyFlowRate[tube.nV,kinetics_data.nC] mC_gens_PtoD={{sum(
       {kinetics_data.lambdas[k] .* tube.mCs[i, k] .* tube.nParallel .* kinetics_data.parents[
      j, k] for k in 1:kinetics_data.nC}) for j in 1:kinetics_data.nC} for i in
          1:tube.nV};

  TRANSFORM.Nuclear.ReactorKinetics.Data.summary_traceSubstances kinetics_data(
    redeclare record Data_PG = Data,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    redeclare record Data_CP = Data_CP)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
end GenericDistributed_HX_withMass_forMSRs;
