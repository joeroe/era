test_that("yr_sort() correctly handles era direction", {
  forward_yr <- yr(c(200, 100, 300), "CE")
  backward_yr <- yr(c(200, 100, 300), "BCE")
  forward_sort <- yr_sort(forward_yr)
  backward_sort <- yr_sort(backward_yr)
  forward_rev_sort <- yr_sort(forward_yr, reverse = TRUE)
  backward_rev_sort <- yr_sort(backward_yr, reverse = TRUE)

  expect_lt(forward_sort[1], forward_sort[3])
  expect_gt(backward_sort[1], backward_sort[3])

  expect_gt(forward_rev_sort[1], forward_rev_sort[3])
  expect_lt(backward_rev_sort[1], backward_rev_sort[3])
})
