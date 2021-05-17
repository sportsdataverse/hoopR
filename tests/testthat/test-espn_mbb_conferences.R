context("ESPN - Get MBB conferences")



test_that("ESPN - Get MBB conferences", {
  skip_on_cran()
  x <- espn_mbb_conferences()

  cols <- c(
    'group_id', 'short_name', 'uid',
    'name', 'logo', 'parent_group_id'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
