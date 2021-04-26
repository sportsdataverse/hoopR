context("KP - Get home court advantage")



test_that("KP - Get home court advantage", {
  skip_on_cran()
  x <- kp_hca()

  cols <- c(
    'Team', 'Conf', 'HCA', 'HCA.Rk',
    'PF', 'PF.Rk', 'Pts', 'Pts.Rk',
    'NST', 'NST.Rk',
    'Blk', 'Blk.Rk', 'Elev', 'Elev.Rk'
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
