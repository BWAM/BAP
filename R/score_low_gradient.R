#' Score Low Gradient Metrics
#'
#' @param metric The name of the metric to be scored.
#' @param values The raw metric values that correspond with the specified metric arguement.
#'
#' @returns
#' @export

score_low_gradient <- function(metric, values) {
  stopifnot(is.numeric(values))

  switch(
    metric,
    "rich_coe" = ((values - 4.88) / 4.26) + 5,
    "rich_insect" = ((values - 22) / 11.12) + 5,
    "rich_genus" = ((values - 28.88) / 8.15) + 5,
    "pct_gatherer" = (((values - 56.13) / 22.24) * -1) + 5,
    "shannon_diversity_shredders" = ((values - 1.16) / 0.89) + 5,
    stop(paste0("Supplied metric,", metric,", is unrecognized."))
  )

}
