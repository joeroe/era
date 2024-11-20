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
