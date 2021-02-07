test_that("this_year() returns this year", {
  expect_equal(
    this_year(),
    yr(lubridate::year(lubridate::now()), "CE")
  )
})
