#' BAP Low Gradient
#'
#' @param Long Taxonomic count data in a long data format.
#'
#' @returns Calculate and score the metrics in the BAP created for the Low Gradient IBI.
#' @export

bap_low_gradient <- function(Long) {
  final_id.df <- wide(Long, "PHYLUM")
  # Create a new data frame to store metrics
  metrics <- data.frame(unique(final_id.df[, 1:5]))

  # COE Richness ------------------------------------------------------------
  metrics$COE_RICH <- coe_rich(Long, "FINAL_ID")
  metrics$COE_RICH_SCORE <- score_low_gradient(metric = "rich_coe", values = metrics$COE_RICH)

  # Insect Richness ---------------------------------------------------------
  metrics$INSECT_RICH <- insect_rich(Long, "FINAL_ID")
  metrics$INSECT_RICH_SCORE <- score_low_gradient(metric = "rich_insect", values = metrics$INSECT_RICH)

  # Genus Level Richness ----------------------------------------------------
  metrics$GENUS_RICH <- richness(Long, Level = "GENUS")
  metrics$GENUS_RICH_SCORE <- score_low_gradient(metric = "rich_genus", values = metrics$GENUS_RICH)

  # Percent Gatherers -------------------------------------------------------
  metrics$PCT_GATHERER <- percent_composition(
    Long,
    Level = "FEEDINGHAB",
    target_taxa = "GATHERER"
    )

  metrics$PCT_GATHERER <- score_low_gradient(metric = "pct_gatherer", values = metrics$PCT_GATHERER)

  # Shannon Diversity of Shredders ------------------------------------------
  metrics$SHANNON_DIV_SHREDDERS <- shannon_diversity(
    Long,
    Level = "FINAL_ID",
    target_taxa_col = "FEEDINGHAB",
    target_taxa = "SHREDDER"
  )

  metrics$SHANNON_DIV_SHREDDERS_SCORE <- score_low_gradient(metric = "shannon_diversity_shredders", values = metrics$SHANNON_DIV_SHREDDERS)

# Calculate BAP Score -----------------------------------------------------
  # Find the mean score of all the metrics for each sample
  metrics$FINAL_SCORE <- apply(metrics[, which(grepl("SCORE", names(metrics)))], 1, FUN = mean)
  # Round to the hundredths place
  metrics$FINAL_SCORE <- round(metrics$FINAL_SCORE, digits = 2)
  return(metrics)
}
