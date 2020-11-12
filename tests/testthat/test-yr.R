test_that("yr() constructs an era_yr with valid input", {
  expect_s3_class(yr(1:10, "BP"), "era_yr")
  expect_s3_class(yr(1:10/2, "ka"), "era_yr")
  expect_s3_class(yr(1:10, era("BP")), "era_yr")
})

test_that("yr() throws an error with multiple eras", {
  expect_error(yr(1, era(c("BC", "BP"))),
               "yr vectors can only have one era attribute")
})

test_that("yr get and set functions work", {
  x <- yr(1, "BP")
  expect_equal(yr_era(x), era("BP"))
  x <- yr_set_era(x, era("ka"))
  expect_equal(yr_era(x), era("ka"))
  yr_era(x) <- era("BCE")
  expect_equal(yr_era(x), era("BCE"))
  y <- yr_set_era(1, era("mya"))
  expect_equal(yr_era(y), era("mya"))
})
