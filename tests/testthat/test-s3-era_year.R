test_that("era_year() returns a zero length era_year", {
  expect_s3_class(era_year(), "era_year")
  expect_length(era_year(), 0)
})

test_that("era_year() accepts valid and rejects invalid parameters", {
  expect_error(era_year(character(), numeric()), NA)
  expect_error(era_year(numeric(), numeric(), "vctrs_error"))
  expect_error(era_year(character(), character(), "vctrs_error"))
})

test_that("is_era_year() can recognise era_years", {
  expect_true(is_era_year(era_year()))
  expect_false(is_era_year(1))
})

test_that("format.era has expected format", {
  expect_snapshot_output(era_year("BP"))
})

test_that("pillar_shaft.era has expected format", {
  expect_snapshot_output(tibble::tibble(era = era(c("cal BP", "BC", "AH")),
                                        unit = era_unit(era)))
})

test_that("we can access the parameters of an era_year", {
  unit <- era_year("lots of", days = 10000)
  expect_equal(era_year_label(unit), "lots of")
  expect_equal(era_year_days(unit), 10000)
})
