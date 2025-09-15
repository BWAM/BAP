


#' Calculate the percent composition
#'
#' @param Long Taxonomic count data in a long data format.
#' @param Level The taxonomic level/group our target_taxa can be found in. This should be the name of a column.
#' @param target_taxa The taxa we are interested in summarizing.
#'
#' @returns
#' @export

percent_composition <- function(Long, Level, target_taxa) {
  wide_df <- wide(Long, Level = Level)
  target_taxa_sub <- names(wide_df)[names(wide_df) %in% target_taxa]
  numerator <- ifelse(length(target_taxa_sub) == 0, 0, rowSums(wide_df[target_taxa_sub]))
  denominator <- rowSums(wide_df[, -c(1:5)])
  pct_vec <- numerator / denominator * 100
  unname(pct_vec)
}

