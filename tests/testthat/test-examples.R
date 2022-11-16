test_that("this_year() returns this year", {
  year_now <- yr(lubridate::year(lubridate::now()), "CE")
  expect_equal(this_year(), year_now)

})

test_that("this_year() rounds negative years correctly", {
  year_now <- yr(lubridate::year(lubridate::now()), "CE")
  year_now <- yr_transform(year_now, "BP", precision = 1)
  expect_equal(this_year("BP"), year_now)
})

test_that("this_year() is vectorised", {
  year_now <- yr(lubridate::year(lubridate::now()), "CE")
  year_now_bp <- yr_transform(year_now, "BP", precision = 1)
  year_now_b2k <- yr_transform(year_now, "b2k", precision = 1)
  expect_equal(
    this_year(c("CE", "BP", "b2k")),
    list(year_now, year_now_bp, year_now_b2k)
  )
})
