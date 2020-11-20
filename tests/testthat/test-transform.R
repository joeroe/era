test_that("yr_transform() throws an error for different units", {
  expect_error(yr_transform(yr(9000, "bp"), era("BP")),
               class = "era_invalid_transform")
})
