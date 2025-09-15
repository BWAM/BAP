Long <- BAP::low_gradient_example

final_id.df <- wide(Long, "FINAL_ID")

test_that("metrics are calcualted correctly", {
  expect_equal(coe_rich(Long, "FINAL_ID"), 3)
  expect_equal(insect_rich(Long, "FINAL_ID"), 14)
  expect_equal(richness(Long, "GENUS"), 21)
  expect_equal(percent_composition(Long, Level = "FEEDINGHAB", target_taxa = "GATHERER"), 80.0885, tolerance = 1e-4)
  expect_equal(percent_composition(Long, Level = "FEEDINGHAB", target_taxa = "test"), 0)
  expect_equal(shannon_diversity(Long, Level = "FINAL_ID", target_taxa_col = "FEEDINGHAB", target_taxa = "SHREDDER"), 0)
  expect_equal(shannon_diversity(Long, Level = "FINAL_ID", target_taxa_col = "FEEDINGHAB", target_taxa = "test"), 0)
})
