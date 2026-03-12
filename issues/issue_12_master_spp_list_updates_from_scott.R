library(dplyr)
devtools::load_all()


master_raw <- BAP::master |>
  mutate(
    across(where(is.character), ~na_if(.x, "NA")),
    across(c(FINAL_ID, PHYLUM, CLASS, ORDER, FAMILY, SUBFAMILY, GENUS, SPECIES), ~toupper(.x))
  )


potamothrix_bavaricus <- data.frame(
  FINAL_ID = "POTAMOTHRIX_BAVARICUS",
  PHYLUM = "ANNELIDA",
  CLASS = "CLITELLATA",
  ORDER = "TUBIFICIDA",
  FAMILY = "NAIDIDAE",
  SUBFAMILY = "TUBIFICINAE",
  GENUS = "POTAMOTHRIX",
  SPECIES = "POTAMOTHRIX_BAVARICUS",
  FEEDINGHAB = NA_character_,
  TOLERANCE = NA_real_,
  NBI_P_TOLERANCE = NA_real_,
  NBI_N_TOLERANCE = NA_real_,
  TOLNAME = NA_character_,
  CLASSIFIER = NA_character_,
  PREVNAMES = NA_character_,
  COMMONNAME = NA_character_,
  REFERENCE = NA_character_
)

benthalia <- data.frame(
  FINAL_ID = "BENTHALIA",
  PHYLUM = "ARTHROPODA",
  CLASS = "INSECTA",
  ORDER = "DIPTERA",
  FAMILY = "CHIRONOMIDAE",
  SUBFAMILY = "CHIRONOMINAE",
  GENUS = "BENTHALIA",
  SPECIES = NA_character_,
  FEEDINGHAB = NA_character_,
  TOLERANCE = NA_real_,
  NBI_P_TOLERANCE = NA_real_,
  NBI_N_TOLERANCE = NA_real_,
  TOLNAME = NA_character_,
  CLASSIFIER = NA_character_,
  PREVNAMES = NA_character_,
  COMMONNAME = NA_character_,
  REFERENCE = NA_character_
)

allocladius <- data.frame(
  FINAL_ID = "ALLOCLADIUS",
  PHYLUM = "ARTHROPODA",
  CLASS = "INSECTA",
  ORDER = "DIPTERA",
  FAMILY = "CHIRONOMIDAE",
  SUBFAMILY = "ORTHOCLADIINAE",
  GENUS = "ALLOCLADIUS",
  SPECIES = NA_character_,
  FEEDINGHAB = NA_character_,
  TOLERANCE = NA_real_,
  NBI_P_TOLERANCE = NA_real_,
  NBI_N_TOLERANCE = NA_real_,
  TOLNAME = NA_character_,
  CLASSIFIER = NA_character_,
  PREVNAMES = NA_character_,
  COMMONNAME = NA_character_,
  REFERENCE = NA_character_
)

limnodrilus_rubripenis <- data.frame(
  FINAL_ID = "LIMNODRILUS_RUBRIPENIS",
  PHYLUM = "ANNELIDA",
  CLASS = "CLITELLATA",
  ORDER = "TUBIFICIDA",
  FAMILY = "NAIDIDAE",
  SUBFAMILY = "TUBIFICINAE",
  GENUS = "LIMNODRILUS",
  SPECIES = "LIMNODRILUS_RUBRIPENIS",
  FEEDINGHAB = NA_character_,
  TOLERANCE = NA_real_,
  NBI_P_TOLERANCE = NA_real_,
  NBI_N_TOLERANCE = NA_real_,
  TOLNAME = NA_character_,
  CLASSIFIER = NA_character_,
  PREVNAMES = NA_character_,
  COMMONNAME = NA_character_,
  REFERENCE = NA_character_
)

limoniidae <- data.frame(
  FINAL_ID = "LIMONIIDAE",
  PHYLUM = "ARTHROPODA",
  CLASS = "INSECTA",
  ORDER = "DIPTERA",
  FAMILY = "LIMONIIDAE",
  SUBFAMILY = NA_character_,
  GENUS = NA_character_,
  SPECIES = NA_character_,
  FEEDINGHAB = NA_character_,
  TOLERANCE = NA_real_,
  NBI_P_TOLERANCE = NA_real_,
  NBI_N_TOLERANCE = NA_real_,
  TOLNAME = NA_character_,
  CLASSIFIER = NA_character_,
  PREVNAMES = NA_character_,
  COMMONNAME = NA_character_,
  REFERENCE = NA_character_
)

master <- dplyr::bind_rows(
  master_raw,
  potamothrix_bavaricus,
  benthalia,
  allocladius,
  limnodrilus_rubripenis,
  limoniidae
)

usethis::use_data(master, overwrite = TRUE)
