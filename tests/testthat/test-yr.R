test_that("yr() constructs an era_yr with valid input", {
  expect_s3_class(yr(1:10, "BP"), "era_yr")
  expect_s3_class(yr(1:10/2, "ka"), "era_yr")
  expect_s3_class(yr(1:10, era("BP")), "era_yr")
})

test_that("Basic validation of yr objects works", {
  good_yr <- yr(1, "BP")
  bad_yr <- new_yr(1, new_era(NA))
  expect_true(is_yr(good_yr))
  expect_false(is_yr(1))
  expect_true(is_valid_yr(good_yr))
  expect_false(is_valid_yr(bad_yr))
  expect_false(is_valid_yr(NA))
  expect_silent(validate_yr(good_yr))
  expect_error(validate_yr(bad_yr), class = "era_invalid_yr")
})

test_that("validate_yr() finds specific problems", {
  bad_yr_data <- new_yr(c("A", "B", "C"), era("BP"))
  bad_yr_era_null <- new_yr(1, NULL)
  bad_yr_era_na <- new_yr(1, NA)
  bad_yr_era_multiple <- new_yr(1, era(c("BP", "BC")))
  bad_yr_era_invalid <- new_yr(1, new_era("bad era", epoch = "bad epoch"))

  expect_error(validate_yr(bad_yr_data), class = "era_invalid_yr",
               regexp = "data")
  expect_error(validate_yr(bad_yr_era_null), class = "era_invalid_yr",
               regexp = "set")
  expect_error(validate_yr(bad_yr_era_na), class = "era_invalid_yr",
               regexp = "not NA")
  expect_error(validate_yr(bad_yr_era_multiple), class = "era_invalid_yr",
               regexp = "one era")
  expect_error(validate_yr(bad_yr_era_invalid), class = "era_invalid_yr",
               regexp = "valid era")
})

test_that("format.yr returns correct output", {
  expect_snapshot_output(yr(1, "BP"))
})

test_that("yr get and set functions work", {
  x <- yr(1, "BP")
  expect_equal(yr_era(x), era("BP"))
  x <- yr_set_era(x, era("ka"))
  expect_equal(yr_era(x), era("ka"))
  yr_era(x) <- era("BCE")
  expect_equal(yr_era(x), era("BCE"))
  y <- yr_set_era(1, era("mya"))
  expect_equal(yr_era(y), era("mya"))
})
