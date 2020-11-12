test_that("yr_transform() throws an error for different units", {
  expect_error(yr_transform(yr(9000, "bp"), era("BP")),
               "No method for transforming radiocarbon to calendar years")
})
