test_that("multiplication works", {
  library(readr)
  usgs_df <- readr::read_csv(here::here("inst",
                                        "usgs_4_26_23.csv"),
                             col_types = cols(
                               ...1 = col_double(),
                               MSSIH_BIOSAMPLE_COLLECT_METHOD = col_character(),
                               MSSIH_EVENT_SMAS_HISTORY_ID = col_character(),
                               MSSIH_REPLICATE = col_double(),
                               MSSIH_EVENT_SMAS_SAMPLE_DATE = col_character(),
                               MSDH_GENSPECIES = col_character(),
                               MSDH_INDIVIDUAL_SPECIES_CNT = col_double(),
                               MSSIH_TOTAL_INDIV_CNT_IND = col_double(),
                               BASIN = col_character(),
                               LOCATION = col_character(),
                               RIVMILE = col_character(),
                               COLL_DATE = col_character(),
                               Replicate = col_double(),
                               MACRO_GENSPECIES = col_character(),
                               INDIV = col_double(),
                               site_id = col_character(),
                               ORIGINAL_BIOSAMPLE_COLLECT_METHOD_ID = col_double(),
                               BIOSAMPLE_COLLECT_METHOD_ID = col_double(),
                               BIOSAMPLE_COLLECT_METH_DESC = col_character(),
                               COLLECT = col_double()
                             )) |>
    dplyr::select(-"...1")

  prepped_df <- BAP::data_prep(usgs_df)

  ponar_df <- BAP::bap_ponar(long = prepped_df)
})
