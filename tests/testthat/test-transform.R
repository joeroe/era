test_that("yr_transform() returns the destination era exactly", {
  expect_equal(yr_era(yr_transform(yr(1, "BP"), "BCE")), era("BCE"))
})

test_that("Valid transformations for all defined eras exist and are symmetrical", {
  xeras <- expect_error({
    tibble::tibble(
      era1 = eras()$label,
      era2 = era1
    ) %>%
      dplyr::filter(!is.na(era_year_days(era_unit(era(era1))))) %>%
      tidyr::expand(era1, era2) %>%
      dplyr::mutate(x = purrr::map(era1, ~yr(1000, .))) %>%
      dplyr::mutate(y = purrr::map2(x, era2, yr_transform)) %>%
      dplyr::mutate(z = purrr::map2(y, era1, yr_transform))
  }, NA)

  expect_equal(xeras$x, xeras$z)
})

test_that("yr_transform() throws an error for incompatible units", {
  expect_error(yr_transform(yr(9000, "bp"), era("BP")),
               class = "era_invalid_transform")
})

test_that("yr_transform() with precision set works", {
  expect_equal(yr_transform(yr(10000, "BP"), "BCE", precision = 100),
               yr(8000, "BCE"))
})

test_that("yr_transform() considers all significant parameters", {
  # Different epochs
  expect_equal(yr_transform(yr(1000, "BCE"), "BP"), yr(2950, "BP"))
  # Different scales
  expect_equal(yr_transform(yr(1, "mya"), "kya"), yr(1000, "kya"))
  # Different directions
  expect_equal(yr_transform(yr(1000, "BCE"), "CE"), yr(-1000, "CE"))
  # Different units
  # Use a dummy era here to avoid the float comparison quagmire
  dozen_years <- era("12YBCE", 0, unit = era_year("dozen", 365.2425 * 12))
  expect_equal(yr_transform(yr(144, "BCE"), dozen_years), yr(12, dozen_years))
})
