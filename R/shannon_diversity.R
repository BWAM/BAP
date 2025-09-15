shannon_diversity <- function(Long, Level, target_taxa_col, target_taxa) {
  taxa_vec <- master[master[[target_taxa_col]] %in% target_taxa, Level][[1]]
  wide_df <- wide(Long, Level = Level)
  wide_sub <- wide_df[c(names(wide_df)[1:5], names(wide_df)[names(wide_df) %in% taxa_vec])]

  if (ncol(wide_sub) == 5) {
    return(rep(0, nrow(wide_df)))
  }

  vegan::diversity(
    x = wide_sub[-c(1:5)],
    index = "shannon"
  )

}
