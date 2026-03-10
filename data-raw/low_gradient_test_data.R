directory <- here::here("data-raw", "low_gradient")

lg_taxa_counts <- readr::read_csv(
  file.path(directory, "input", "2015-2019_LGtaxa_unique_long_subsamp_2021-11-30.csv")
)

lg_bap_scores <- lg_taxa_counts <- readr::read_csv(
  file.path(directory, "output", "metrics.scores.df_2022-12-21.csv")
)
