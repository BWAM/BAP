## code to prepare `DATASET` dataset goes here

#load the data and change it
#updating the master table
#read in the new table
library(dplyr)
library(tidyverse)

file_dir <- file.path(
  "L:",
  "DOW",
  "BWAM Share",
  "SMAS",
  "data",
  "cleaned_files",
  "Final_Macro_ITS",
  "20210617_S_MSTR_MACRO_SPECIES.csv"
)
master_updated <- readr::read_csv(file_dir,
                                 col_types = cols(
                                   MSTR_MACRO_SPECIES_ID = col_number(),
                                   MMS_KINGDOM = col_character(),
                                   MMS_SUBKINGDOM = col_character(),
                                   MMS_INFRAKINGDOM = col_character(),
                                   MMS_SUPERPHYLUM = col_character(),
                                   MMS_PHYLUM = col_character(),
                                   MMS_SUBPHYLUM = col_character(),
                                   MMS_CLASS = col_character(),
                                   MMS_SUBCLASS = col_character(),
                                   MMS_INFRACLASS = col_character(),
                                   MMS_SUPERORDER = col_character(),
                                   MMS_ORDER = col_character(),
                                   MMS_SUBORDER = col_character(),
                                   MMS_INFRAORDER = col_character(),
                                   MMS_SUPERFAMILY = col_character(),
                                   MMS_FAMILY = col_character(),
                                   MMS_SUBFAMILY = col_character(),
                                   MMS_TRIBE = col_character(),
                                   MMS_GENUS = col_character(),
                                   MMS_SPECIES = col_character(),
                                   MMS_GENSPECIES = col_logical(),
                                   MMS_MACRO_GENSPECIES = col_character(),
                                   MMS_CLASSIFIER = col_logical(),
                                   MMS_COMMON_NAME = col_logical(),
                                   MMS_WATER_QLTY_EXCHANGE_NAME = col_logical(),
                                   MMS_WQX_UNIDENTFD_SPECIES_NAME = col_logical(),
                                   MMS_TOLERANCE = col_double(),
                                   MMS_TOLERANCE_NAME = col_character(),
                                   MMS_NBI_PHOSPHORUS_TOL = col_double(),
                                   MMS_NBI_NITRATE_TOL = col_double(),
                                   MMS_FEEDING_HABITS = col_character(),
                                   MMS_REFERENCE = col_character(),
                                   MMS_PREV_NAME = col_character(),
                                   MMS_INTEGR_TAXONOMIC_INFO_SYS = col_integer(),
                                   CREATE_DATE = col_character(),
                                   END_DATE = col_logical(),
                                   UPDATE_DATE = col_logical(),
                                   UPDATED_BY_GUID = col_logical()
                                 )) |>
  dplyr::filter(
    !is.na(MMS_PHYLUM),
    # Remove these rows becuase the ref info does not include a comma.
    # This error is fixed in the master_prev_update loaded below.!MMS_MACRO_GENSPECIES %in% c(
    "alboglossiphonia_heteroclita",
    "berosus_sp.",
    "enallagma_sp.",
    "ischnura_sp."
  )
)
#take out the unnecessary prefixes

master_updated<-master_updated %>%
  rename_all(~gsub("MMS_","", .x))


master_prev_update <- readr::read_csv(here::here("data-raw",
                                          "master_taxa",
                                          "S_MSTR_MACRO_SPECIES.csv"),
                                      col_types = cols(
                                        MMS_TOLERANCE = col_double(),
                                        MMS_TOLERANCE_NAME = col_character(),
                                        MMS_NBI_PHOSPHORUS_TOL = col_double(),
                                        MMS_NBI_NITRATE_TOL = col_double(),
                                        MMS_FEEDING_HABITS = col_character(),
                                        MMS_REFERENCE = col_character(),
                                        MMS_PREV_NAME = col_character(),
                                        MMS_INTEGR_TAXONOMIC_INFO_SYS = col_integer(),
                                        MMS_KINGDOM = col_character(),
                                        MMS_SUBKINGDOM = col_character(),
                                        MMS_INFRAKINGDOM = col_character(),
                                        MMS_SUPERPHYLUM = col_character(),
                                        MMS_PHYLUM = col_character(),
                                        MMS_SUBPHYLUM = col_character(),
                                        MMS_CLASS = col_character(),
                                        MMS_SUBCLASS = col_character(),
                                        MMS_INFRACLASS = col_character(),
                                        MMS_SUPERORDER = col_character(),
                                        MMS_ORDER = col_character(),
                                        MMS_SUBORDER = col_character(),
                                        MMS_INFRAORDER = col_character(),
                                        MMS_SUPERFAMILY = col_character(),
                                        MMS_FAMILY = col_character(),
                                        MMS_SUBFAMILY = col_character(),
                                        MMS_TRIBE = col_character(),
                                        MMS_GENUS = col_character(),
                                        MMS_SPECIES = col_character(),
                                        MMS_GENSPECIES = col_character(),
                                        MACRO_GENSPECIES = col_character(),
                                        MSTR_MACRO_SPECIES_ID = col_logical(),
                                        MMS_CLASSIFIER = col_logical(),
                                        MMS_COMMON_NAME = col_logical(),
                                        MMS_WATER_QLTY_EXCHANGE_NAME = col_logical(),
                                        MMS_WQX_UNIDENTIFD_SPECEIS_NAME = col_logical(),
                                        CREATE_DATE = col_logical(),
                                        END_DATE = col_logical(),
                                        UPDATE_DATE = col_logical(),
                                        UPDATED_BY_GUID = col_logical()
                                      )) %>%
  rename_all(~gsub("MMS_","", .x))

master_updates <- dplyr::bind_rows(
  master_updated,
  master_prev_update
)


#load the old file
load(file = "data/master.Rda")
master_old <- master

#filter the new master to the cols we need
master_updated_short<-master_updates %>%
  select(MACRO_GENSPECIES,
         PHYLUM,
         CLASS,
         ORDER,
         FAMILY,
         SUBFAMILY,
         GENUS,
         SPECIES,
         FEEDING_HABITS,
         TOLERANCE,
         NBI_PHOSPHORUS_TOL,
         NBI_NITRATE_TOL,
         TOLERANCE_NAME,
         CLASSIFIER,
         PREV_NAME,
         COMMON_NAME,
         REFERENCE) |>
  distinct()

master_updated_short<-master_updated_short %>%
  rename(FINAL_ID=MACRO_GENSPECIES,
         FEEDINGHAB=FEEDING_HABITS,
         NBI_P_TOLERANCE=NBI_PHOSPHORUS_TOL,
         NBI_N_TOLERANCE=NBI_NITRATE_TOL,
         TOLNAME=TOLERANCE_NAME,
         PREVNAMES=PREV_NAME,
         COMMONNAME=COMMON_NAME) %>%
  mutate(TOLNAME=toupper(TOLNAME))


cols.for.factor<-master_updated_short %>%
  select(!c(TOLERANCE,NBI_P_TOLERANCE,NBI_N_TOLERANCE))

cols.for.factor.l<-names(cols.for.factor)

master_updated_short[cols.for.factor.l]<-lapply(master_updated_short[
  cols.for.factor.l],
  as.factor) #maybe do this last?


# Remove any UNDETERMINED
master_updated_short$GENUS <- gsub("UNDETERMINED ","", master_updated_short$GENUS)
# Remove any text contained within parentheses
master_updated_short$GENUS <- gsub("\\([^\\)]+\\)","", master_updated_short$GENUS)
# Remove NR.
master_updated_short$GENUS <- gsub("\ NR\\.","", master_updated_short$GENUS)
# Remove GR.
master_updated_short$GENUS <- gsub("\ GR\\.","", master_updated_short$GENUS)
# Remove ?
master_updated_short$GENUS <- gsub("\\?","", master_updated_short$GENUS)
master_updated_short$GENUS <- ifelse(grepl(" ",  master_updated_short$GENUS),
                       gsub( " .*$", "", master_updated_short$GENUS_SPECIES),
                       master_updated_short$GENUS)

# Remove all genera, groups, undetermineds, complexes, and uncertainties
master_updated_short$SPECIES <- sapply(master_updated_short$SPECIES, function(x){
  remove <- c("SP\\.", "SPP\\.", "CF\\.", "UNDET\\.", NA, "/")
  ifelse(grepl(paste(remove, collapse="|"), x), "", paste(x))
})
# Remove any text contained within parentheses
master_updated_short$SPECIES <- gsub("\\([^\\)]+\\)","", master_updated_short$SPECIES)
# Remove NR.
master_updated_short$SPECIES <- gsub("\ NR\\.","", master_updated_short$SPECIES)
# Remove GR.
master_updated_short$SPECIES <- gsub("\ GR\\.","", master_updated_short$SPECIES)
# Remove ?
master_updated_short$SPECIES <- gsub("\\?","", master_updated_short$SPECIES)
# Replace the space between genus and species with "_"
master_updated_short$SPECIES <- gsub(" ","_", master_updated_short$SPECIES)

master <- master_updated_short |>
  dplyr::mutate(dplyr::across(tidyselect::where(is.factor), function(x) as.factor(toupper(x)))) |>
  mutate(
    CLASS = coalesce(CLASS, PHYLUM),
    ORDER = coalesce(ORDER, CLASS),
    FAMILY = coalesce(FAMILY, ORDER),
    SUBFAMILY = coalesce(SUBFAMILY, FAMILY),
    GENUS = coalesce(GENUS, SUBFAMILY),
    SPECIES = coalesce(SPECIES, GENUS)
  )

usethis::use_data(master, overwrite = TRUE)

