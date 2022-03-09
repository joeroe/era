test_that("landmarks for Islamic calendars", {
  ce <- yr(c(621, 623, 2022), "CE")

  ah <- yr(c(-1, 1, 1443), "AH")
  sh <- yr(c(-1, 1, 1400), "SH")

  bh <- yr(c(1, -1, -1443), "BH")
  bsh <- yr(c(1, -1, -1400), "BSH")

  expect_equal(floor(yr_transform(ce, "AH")), ah)
  expect_equal(floor(yr_transform(ce, "SH")), sh)

  expect_equal(floor(yr_transform(ce, "BH")), bh)
  expect_equal(floor(yr_transform(ce, "BSH")), bsh)
})

test_that("landmarks for Jewish calendars", {
  # "Adar 2" table <https://commons.wikimedia.org/wiki/File:Jewish_calendar,_showing_Adar_II_between_1927_and_1948.jpeg>
  ce <- yr(c(1927, 1929, 1932, 1935, 1938, 1940, 1943, 1946, 1948), "CE")
  am <- yr(c(5687, 5689, 5692, 5695, 5698, 5700, 5703, 5706, 5708), "AM")
  expect_equal(floor(yr_transform(ce, "AM")), am)
})
