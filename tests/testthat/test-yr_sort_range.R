forward_yr <- yr(c(200, 100, 300), "CE")
backward_yr <- yr(c(200, 100, 300), "BCE")

test_that("yr_sort() respects era direction", {
  forward_sort <- yr_sort(forward_yr)
  backward_sort <- yr_sort(backward_yr)

  expect_lt(forward_sort[1], forward_sort[3])
  expect_gt(backward_sort[1], backward_sort[3])
})

test_that("yr_sort(reverse = TRUE) respects era direction", {
  forward_rev_sort <- yr_sort(forward_yr, reverse = TRUE)
  backward_rev_sort <- yr_sort(backward_yr, reverse = TRUE)

  expect_gt(forward_rev_sort[1], forward_rev_sort[3])
  expect_lt(backward_rev_sort[1], backward_rev_sort[3])
})

test_that("yr_earliest() respects era direction", {
  expect_equal(yr_earliest(forward_yr), min(forward_yr))
  expect_equal(yr_earliest(backward_yr), max(backward_yr))
})

test_that("yr_latest() respects era direction", {
  expect_equal(yr_latest(forward_yr), max(forward_yr))
  expect_equal(yr_latest(backward_yr), min(backward_yr))
})

test_that("yr_range() respects era direction", {
  expect_equal(yr_range(forward_yr), range(forward_yr))
  expect_equal(yr_range(backward_yr), rev(range(backward_yr)))
})

test_that("yr_earlier_than() respects era direction", {
  expect_equal(
    yr_earlier_than(yr(c(100, 200, 300), "CE"), yr(200, "CE")),
    c(TRUE, FALSE, FALSE)
  )
  expect_equal(
    yr_earlier_than(yr(c(100, 200, 300), "BCE"), yr(200, "BCE")),
    c(FALSE, FALSE, TRUE)
  )
})

test_that("yr_later_than() respects era direction", {
  expect_equal(
    yr_later_than(yr(c(100, 200, 300), "CE"), yr(200, "CE")),
    c(FALSE, FALSE, TRUE)
  )
  expect_equal(
    yr_later_than(yr(c(100, 200, 300), "BCE"), yr(200, "BCE")),
    c(TRUE, FALSE, FALSE)
  )
})

test_that("yr_earlier_than() and yr_later_than() propagate NAs", {
  expect_equal(
    yr_earlier_than(yr(c(100, NA, 300), "CE"), yr(200, "CE")),
    c(TRUE, NA, FALSE)
  )
  expect_equal(
    yr_later_than(yr(c(100, NA, 300), "CE"), yr(c(200, 200, NA), "CE")),
    c(FALSE, NA, NA)
  )
})

test_that("yr_earlier_than() and yr_later_than() recycle inputs", {
  expect_equal(
    yr_earlier_than(yr(100, "CE"), yr(c(50, 100, 200), "CE")),
    c(FALSE, FALSE, TRUE)
  )
  expect_equal(
    yr_later_than(yr(c(50, 100, 200), "BCE"), yr(100, "BCE")),
    c(TRUE, FALSE, FALSE)
  )
})

test_that("yr_earlier_than() and yr_later_than() transform between eras", {
  expect_equal(
    yr_earlier_than(yr(100, "CE"), yr(100, "BCE")),
    FALSE
  )
  expect_equal(
    yr_later_than(yr(100, "CE"), yr(100, "BCE")),
    TRUE
  )
})

test_that("yr_earlier_than() errors with class era_invalid_yr for non-yr", {
  expect_error(
    yr_earlier_than(1, yr(1, "CE")),
    class = "era_invalid_yr"
  )
  expect_error(
    yr_earlier_than(yr(1, "CE"), 1),
    class = "era_invalid_yr"
  )
})

test_that("yr_later_than() errors with class era_invalid_yr for non-yr", {
  expect_error(
    yr_later_than(1, yr(1, "CE")),
    class = "era_invalid_yr"
  )
  expect_error(
    yr_later_than(yr(1, "CE"), 1),
    class = "era_invalid_yr"
  )
})
