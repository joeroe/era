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
  expect_error(validate_yr(NA), class = "era_invalid_yr")
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

test_that("era_yr coercion is correct and symmetrical", {
  # era_yr <-> era_yr
  expect_s3_class(vec_c(yr(1, "BP"), yr(2, "BP")), "era_yr")
  expect_error(vec_c(yr(1, "BP"), yr(2, "BC")),
               class = "vctrs_error_incompatible_type")

  # integer <-> era_yr
  expect_type(vec_c(1L, yr(2L, "BP")), "integer")
  expect_type(vec_c(yr(1L, "BP"), 2L), "integer")

  # double <-> era_yr
  expect_type(vec_c(1.0, yr(2.0, "BP")), "double")
  expect_type(vec_c(yr(1.0, "BP"), 2.0), "double")
})

test_that("era_yr cast methods return correct class", {
  # era_yr <-> era_yr
  expect_s3_class(vec_cast(yr(1, "BP"), yr(2, "BP")), "era_yr")
  expect_error(vec_cast(yr(1, "BP"), yr(2, "BC")),
               class = "vctrs_error_incompatible_type")

  # integer <-> era_yr
  expect_type(vec_cast(new_yr(), integer()), "integer")
  expect_s3_class(vec_cast(integer(), new_yr()), "era_yr")

  # double <-> era_yr
  expect_type(vec_cast(new_yr(), double()), "double")
  expect_s3_class(vec_cast(double(), new_yr()), "era_yr")
})

test_that("format.era_yr returns expected output", {
  expect_snapshot_output(yr(1, "BP"))
})

test_that("tibble formatter pillar_shaft.era_yr returns expected output", {
  expect_snapshot_output(tibble::tibble(x = yr(1:10, "BP")))
})

test_that("yr arithmetic respects era equality", {
  expect_condition(yr(1, "BP") + yr(1, "BP"), NA)
  expect_warning(yr(1, "BP") + yr(1, "cal BP"), class = "era_lossy_coercion")
  expect_warning(yr(1, "BC") + yr(1, "BCE"), class = "era_lossy_coercion")
  expect_error(yr(1, "BP") + yr(1, "BC"), class = "vctrs_error_incompatible_op")
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
