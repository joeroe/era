test_that("yr_difference() computes difference for forward eras", {
  expect_equal(yr_difference(yr(200, "CE"), yr(100, "CE")), 100)
  expect_equal(yr_difference(yr(100, "CE"), yr(200, "CE")), -100)
  expect_equal(yr_difference(yr(100, "CE"), yr(100, "CE")), 0)
})

test_that("yr_difference() computes difference for backward eras", {
  # BCE: larger numeric value = earlier chronologically
  expect_equal(yr_difference(yr(1900, "BCE"), yr(2000, "BCE")), 100)
  expect_equal(yr_difference(yr(2000, "BCE"), yr(1900, "BCE")), -100)

  # BP: larger numeric value = earlier chronologically
  expect_equal(yr_difference(yr(100, "BP"), yr(200, "BP")), 100)
  expect_equal(yr_difference(yr(200, "BP"), yr(100, "BP")), -100)
})

test_that("yr_difference() handles cross-era comparisons", {
  # BCE and CE: accounts for year zero
  expect_equal(yr_difference(yr(10, "CE"), yr(10, "BCE")), 19)
  expect_equal(yr_difference(yr(10, "BCE"), yr(10, "CE")), -19)

  # BP and CE: 1950 BP = 1 CE, 1940 BP = 10 CE
  expect_equal(yr_difference(yr(1940, "BP"), yr(10, "CE")), 0)
  expect_equal(yr_difference(yr(1950, "BP"), yr(10, "CE")), -10)
})

test_that("yr_difference() works with scaled eras", {
  # ka is backward-counting: 2 ka is earlier than 1 ka
  expect_equal(yr_difference(yr(2, "ka"), yr(1, "ka")), -1)
  expect_equal(yr_difference(yr(1, "ka"), yr(2, "ka")), 1)
})

test_that("yr_difference() is vectorized", {
  expect_equal(
    yr_difference(yr(c(100, 200, 300), "CE"), yr(c(50, 150, 250), "CE")),
    c(50, 50, 50)
  )
})

test_that("yr_difference() recycles inputs to common length", {
  expect_equal(
    yr_difference(yr(c(100, 200, 300), "CE"), yr(150, "CE")),
    c(-50, 50, 150)
  )
  expect_equal(
    yr_difference(yr(150, "CE"), yr(c(100, 200, 300), "CE")),
    c(50, -50, -150)
  )
})

test_that("yr_difference() propagates NA values", {
  expect_equal(yr_difference(yr(NA, "CE"), yr(100, "CE")), NA_real_)
  expect_equal(yr_difference(yr(100, "CE"), yr(NA, "CE")), NA_real_)
  expect_equal(
    yr_difference(yr(c(100, NA, 300), "CE"), yr(c(50, 100, 250), "CE")),
    c(50, NA, 50)
  )
})

test_that("yr_difference() accepts numeric y", {
  expect_equal(yr_difference(yr(200, "CE"), 100), 100)
  expect_equal(yr_difference(yr(100, "CE"), 200), -100)
  expect_equal(yr_difference(yr(1900, "BCE"), 2000), 100)
  expect_equal(yr_difference(yr(100, "BP"), 200L), 100)
})

test_that("yr_difference() errors with era_invalid_yr for non-yr x", {
  expect_error(
    yr_difference(100, yr(50, "CE")),
    class = "era_invalid_yr"
  )
})

test_that("yr_difference() errors with era_invalid_transform", {
  expect_error(
    yr_difference(yr(100, "BP"), yr(100, "uncal BP")),
    class = "era_invalid_transform"
  )
})

test_that("yr_difference() returns a numeric vector", {
  result <- yr_difference(yr(200, "CE"), yr(100, "CE"))
  expect_type(result, "double")
  expect_false(inherits(result, "era_yr"))
})
