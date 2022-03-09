test_that("yr() returns a zero-length yr", {
  expect_s3_class(yr(), "era_yr")
  expect_length(yr(), 0)
})

test_that("yr() constructs an era_yr with valid input", {
  expect_s3_class(yr(1:10, "BP"), "era_yr")
  expect_s3_class(yr(1:10/2, "ka"), "era_yr")
  expect_s3_class(yr(1:10, era("BP")), "era_yr")
})

test_that("yr validation functions work", {
  good_yr <- yr(1, "BP")
  bad_yr <- new_yr("a", NA)
  not_yr <- 1
  expect_true(is_yr(good_yr))
  expect_true(is_valid_yr(good_yr))
  expect_silent(validate_yr(good_yr))
  expect_true(is_yr(bad_yr))
  expect_false(is_valid_yr(bad_yr))
  expect_error(validate_yr(bad_yr))
  expect_false(is_yr(not_yr))
  expect_false(is_valid_yr(not_yr))
  expect_error(validate_yr(not_yr))
})

test_that("validate_yr() finds specific problems", {
  not_yr <- 1
  bad_yr_data <- new_yr(c("A", "B", "C"), era("BP"))
  bad_yr_null_era <- new_yr(1, NULL)
  bad_yr_na_era <- new_yr(1, NA)
  bad_yr_multiple_era <- new_yr(1, era(c("BP", "BC")))
  bad_yr_invalid_era <- new_yr(1, new_era("x", "x", "x", "x", "x", "x"))

  expect_error(validate_yr(not_yr), class = "era_invalid_yr",
               regexp = "class era_yr")
  expect_error(validate_yr(bad_yr_data), class = "era_invalid_yr",
               regexp = "data")
  expect_error(validate_yr(bad_yr_null_era), class = "era_invalid_yr",
               regexp = "set")
  expect_error(validate_yr(bad_yr_na_era), class = "era_invalid_yr",
               regexp = "not NA")
  expect_error(validate_yr(bad_yr_multiple_era), class = "era_invalid_yr",
               regexp = "one era")
  expect_error(validate_yr(bad_yr_invalid_era), class = "era_invalid_yr",
               regexp = "valid era")
})

test_that("era_yr coercion is correct and symmetrical", {
  # era_yr <-> era_yr
  expect_s3_class(vec_c(yr(1, "BP"), yr(2, "BP")), "era_yr")
  expect_error(vec_c(yr(1, "BP"), yr(2, "BC")),
               class = "vctrs_error_incompatible_type")

  # integer <-> era_yr
  expect_s3_class(vec_c(1L, yr(2L, "BP")), "era_yr")
  expect_s3_class(vec_c(yr(1L, "BP"), 2L), "era_yr")

  # double <-> era_yr
  expect_s3_class(vec_c(1.0, yr(2.0, "BP")), "era_yr")
  expect_s3_class(vec_c(yr(1.0, "BP"), 2.0), "era_yr")
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

  # character <-> era_yr
  expect_type(vec_cast(new_yr(), character()), "character")
  expect_error(vec_cast(character(), new_yr()),
               class = "vctrs_error_incompatible_type")
})

test_that("casting era_yr to character returns expected output", {
  expect_equal(vec_cast(yr(1:3, "BP"), character()), c("1 BP", "2 BP", "3 BP"))
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

test_that("yr arithmetic preserves era where appropriate", {
  # switch statements in vec_arith.* "fall through" to lowest operator, so only
  # need to test that
  expect_s3_class(yr(1, "BP") - yr(1, "BP"), "era_yr")
  expect_s3_class(yr(1, "BP") - 1, "era_yr")
  expect_s3_class(1 - yr(1, "BP"), "era_yr")
})

test_that("yr arithmetic strips era where appropriate", {
  # switch statements in vec_arith.* "fall through" to lowest operator, so only
  # need to test that
  expect_s3_class(yr(10, "BP") %/% yr(2, "BP"), NA)
  expect_s3_class(yr(10, "BP") %/% 2, NA)
  expect_s3_class(2 %/% yr(10, "BP"), NA)
})

test_that("unary arithmetic operators work with yrs", {
  expect_equal(-yr(1, "BP"), yr(-1, "BP"))
  expect_equal(+yr(1, "BP"), yr(1, "BP"))
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
