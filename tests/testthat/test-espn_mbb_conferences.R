context("ESPN - Get conferences")



test_that("ESPN - Get conferences", {
  skip_on_cran()
  x <- espn_mbb_conferences()

  cols <- c(
    'groupId', 'shortName', 'uid',
    'name', 'logo', 'parentGroupId'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
