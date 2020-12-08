test_that("era(NA) throws an error", {
  expect_error(era(NA), class = "era_invalid_era")
})

test_that("direction argument of era() is backwards compatible with v. <= 0.2.0", {
  frwd_new <- era("test frwd", epoch = 0, direction = 1)
  frwd_old <- era("test frwd", epoch = 0, direction = "forwards")
  bcwd_new <- era("test bcwd", epoch = 0, direction = -1)
  bcwd_old <- era("test bcwd", epoch = 0, direction = "backwards")
  expect_equal(frwd_new, frwd_old)
  expect_equal(bcwd_new, bcwd_old)
})

test_that("eras() returns era_table", {
  expect_equal(as.data.frame(eras()), era_table)
})

test_that("labels in era_table are unique", {
  expect_equal(era_table[["label"]], unique(era_table[["label"]]))
})

test_that("all eras defined in eras() are valid", {
  expect_s3_class(
    do.call(era, as.list(eras())),
    "era"
  )
})

test_that("Basic validation of era objects works", {
  good_era <- era("BP")
  bad_era <- new_era()
  expect_true(is_era(good_era))
  expect_false(is_era(1))
  expect_true(is_valid_era(good_era))
  expect_false(is_valid_era(bad_era))
  expect_false(is_valid_era(NA))
  expect_silent(validate_era(good_era))
  expect_error(validate_era(bad_era), class = "era_invalid_era")
  expect_error(validate_era(NA), class = "era_invalid_era")
})

test_that("validate_era() finds specific problems", {
  bad_era_na <- new_era()
  bad_era_label <- new_era(label = 14)
  bad_era_epoch <- new_era(epoch = "bad epoch")
  bad_era_name <- new_era(name = 47)
  bad_era_unit <- new_era(unit = "bad unit")
  bad_era_scale <- new_era(scale = "bad scale")
  bad_era_negative_scale <- new_era(scale = -1)
  bad_era_direction <- new_era(direction = 2)

  expect_error(validate_era(bad_era_na), class = "era_invalid_era",
               regexp = "not be NA")
  expect_error(validate_era(bad_era_label), class = "era_invalid_era",
               regexp = "label")
  expect_error(validate_era(bad_era_epoch), class = "era_invalid_era",
               regexp = "epoch")
  expect_error(validate_era(bad_era_name), class = "era_invalid_era",
               regexp = "name")
  expect_error(validate_era(bad_era_unit), class = "era_invalid_era",
               regexp = "unit")
  expect_error(validate_era(bad_era_scale), class = "era_invalid_era",
               regexp = "scale")
  expect_error(validate_era(bad_era_negative_scale), class = "era_invalid_era",
               regexp = "positive")
  expect_error(validate_era(bad_era_direction), class = "era_invalid_era",
               regexp = "direction")
})

test_that("format.era returns correct output", {
  expect_snapshot_output(era("BP"))
})

test_that("eras(label) returns correct exact match", {
  expect_match(eras("cal BP")[["label"]], "cal BP", fixed = TRUE)
})

test_that("eras(label) returns correct partial match", {
  expect_match(eras("cal")[["label"]], "cal BP", fixed = TRUE)
})

test_that("vec_proxy_equal.era works correctly", {
  # Different label, same name
  expect_true(era("BP") == era("cal BP"))
  # Different label, different name
  expect_true(era("BC") == era("BCE"))
  # Incomparable
  expect_false(era("BP") == era("BC"))
})

test_that("era_parameters getter functions return correct value", {
  tera <- era("TE", epoch = 5000, name = "Test Era", unit = "calendar",
              scale = 1e6, direction = 1)
  expect_match(era_label(tera), "TE", fixed = TRUE)
  expect_equal(era_epoch(tera), 5000)
  expect_match(era_name(tera), "Test Era", fixed = TRUE)
  expect_match(era_unit(tera), "calendar", fixed = TRUE)
  expect_equal(era_scale(tera), 1e6)
  expect_equal(era_direction(tera), 1)
})
