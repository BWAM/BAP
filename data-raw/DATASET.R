## code to prepare `DATASET` dataset goes here

#load the data and change it
#updating the master table
#read in the new table
library(dplyr)
library(tidyverse)
master_updated<-read.csv("C:/Users/kareynol/New York State Office of Information Technology Services/SMAS - Streams Data Modernization/Cleaned Files/Final_Macro_ITS/20210617_S_MSTR_MACRO_SPECIES.csv")
#take out the uneccessary prefixes

master_updated<-master_updated %>%
  rename_all(~gsub("MMS_","", .x))

#load the old file
load(file = "data/master.Rda")

#filter the new master to the cols we need
master_updated_short<-master_updated %>%
  select(MACRO_GENSPECIES,
         PHYLUM,
         CLASS,
         ORDER,
         FAMILY,
         SUBFAMILY,
         GENUS,
         SPECIES,
         GENSPECIES,
         FEEDING_HABITS,
         TOLERANCE,
         NBI_PHOSPHORUS_TOL,
         NBI_NITRATE_TOL,
         TOLERANCE_NAME,
         CLASSIFIER,
         PREV_NAME,
         COMMON_NAME,
         REFERENCE)

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

master<-master_updated_short


usethis::use_data(master, overwrite = TRUE)

