test_that("era_parameters getters return correct value", {
  tera <- era("TE", epoch = 5000, name = "Test Era", unit = "calendar",
              scale = 1e6, direction = "forwards")
  expect_match(era_label(tera), "TE", fixed = TRUE)
  expect_equal(era_epoch(tera), 5000)
  expect_match(era_name(tera), "Test Era", fixed = TRUE)
  expect_match(era_unit(tera), "calendar", fixed = TRUE)
  expect_equal(era_scale(tera), 1e6)
  expect_match(era_direction(tera), "forwards", fixed = TRUE)
})
