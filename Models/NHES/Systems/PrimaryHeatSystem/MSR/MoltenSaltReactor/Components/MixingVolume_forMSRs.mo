within NHES.Systems.PrimaryHeatSystem.MSR.MoltenSaltReactor.Components;
model MixingVolume_forMSRs
  extends TRANSFORM.Fluid.Volumes.MixingVolume(
    replaceable package Medium =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (
          extraPropertiesNames=kinetics_data.extraPropertiesNames, C_nominal=
            kinetics_data.C_nominal),
    mC_gen={-kinetics_data.lambdas[j]*mC[j] + mC_gen_PtoD[j] for j in 1:
        kinetics_data.nC},
    Q_gen=sum({((if includeDecayHeatNear then kinetics_data.w_near_decay[j]
         else 0) + (if includeDecayHeatFar then kinetics_data.w_far_decay[j]
 else
     0))*kinetics_data.lambdas[j]*mC[j] for j in 1:kinetics_data.nC}),
  C_start=cat(
      1,
      fill(0, kinetics_data.data_PG.nC),
      fill(0, kinetics_data.data_FP.nC),
      C_start_TR));

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

  TRANSFORM.Units.ExtraPropertyFlowRate[kinetics_data.nC] mC_gen_PtoD={sum({
      kinetics_data.lambdas[k] .* mC[k] .* kinetics_data.parents[j, k] for k in
          1:kinetics_data.nC}) for j in 1:kinetics_data.nC};

  TRANSFORM.Nuclear.ReactorKinetics.Data.summary_traceSubstances kinetics_data(
    redeclare record Data_PG = Data,
    redeclare record Data_FP = Data_FP,
    redeclare record Data_TR = Data_TR,
    redeclare record Data_CP = Data_CP)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

end MixingVolume_forMSRs;
