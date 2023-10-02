within NHES.Systems.PrimaryHeatSystem.MSR.Data;
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
  NHES.Systems.PrimaryHeatSystem.MSR.Data.Data_PG data_PG;

  NHES.Systems.PrimaryHeatSystem.MSR.Data.Data_ISO data_ISO;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Datasets;
