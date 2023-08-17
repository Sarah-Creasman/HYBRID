within NHES.Systems.PrimaryHeatSystem.MSR.Components;
model Datasets

  constant String[:] extraPropertiesNames=cat(
      1,
      data_PG.extraPropertiesNames,
      data_ISO.extraPropertiesNames) "Names of groups";
  constant Real C_nominal[data_PG.nC + data_ISO.nC]=cat(
      1,
      data_PG.C_nominal,
      data_ISO.C_nominal)
    "Default for the nominal values for the extra properties";
  replaceable record Data_PG =
      TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_TRACEdefault
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.PartialPrecursorGroup
    "Neutron Precursor Data" annotation (choicesAllMatching=true);
  Data_PG data_PG;

  replaceable record Data_ISO =
      TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_null
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.PartialIsotopes
    "Data" annotation (choicesAllMatching=true);
  Data_ISO data_ISO;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Datasets;
