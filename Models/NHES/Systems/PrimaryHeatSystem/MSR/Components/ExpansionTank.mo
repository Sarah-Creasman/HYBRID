within NHES.Systems.PrimaryHeatSystem.MSR.Components;
model ExpansionTank
  extends TRANSFORM.Fluid.Volumes.ExpansionTank(
      replaceable package Medium =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (
          extraPropertiesNames=extraPropertiesNames, C_nominal=
            C_nominal),
    mC_gen=cat(
        1,
        mC_gen_PG,
        mC_gen_ISO)+mC_gen_add);

      extends Datasets;

  TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_PG[data_PG.nC];
  TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_ISO[data_ISO.nC];

  input SIadd.ExtraPropertyFlowRate mC_gen_add[Medium.nC]=fill(0,Medium.nC) "Additional internal trace mass generation"
    annotation (Dialog(tab="Advanced",group="Trace Mass Transfer"));

equation

  for j in 1:data_PG.nC loop
    mC_gen_PG[j] = -data_PG.lambdas[j]*mC[j];
  end for;
  for j in 1:data_ISO.nC loop
    mC_gen_ISO[j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mC[
      data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC] for k in
          1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mC[j + data_PG.nC];
  end for;

end ExpansionTank;