test_that("format.era has expected format", {
  expect_snapshot_output(era_year("BP"))
})

test_that("pillar_shaft.era has expected format", {
  expect_snapshot_output(tibble::tibble(era = era(c("cal BP", "BC", "AH")),
                                        unit = era_unit(era)))
})
