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

test_that("eras(label) returns correct exact match", {
  expect_match(eras("cal BP")[["label"]], "cal BP", fixed = TRUE)
})

test_that("eras(label) returns correct partial match", {
  expect_match(eras("cal")[["label"]], "cal BP", fixed = TRUE)
})

test_that("era_parameters getter functions return correct value", {
  tera <- era("TE", epoch = 5000, name = "Test Era", unit = "calendar",
              scale = 1e6, direction = "forwards")
  expect_match(era_label(tera), "TE", fixed = TRUE)
  expect_equal(era_epoch(tera), 5000)
  expect_match(era_name(tera), "Test Era", fixed = TRUE)
  expect_match(era_unit(tera), "calendar", fixed = TRUE)
  expect_equal(era_scale(tera), 1e6)
  expect_match(era_direction(tera), "forwards", fixed = TRUE)
})
