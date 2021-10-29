context("KP - Get home court advantage")



test_that("KP - Get home court advantage", {
  skip_on_cran()
  
  x <- kp_hca()

  cols <- c(
    "team", "conf", "hca", "hca_rk", "pf", "pf_rk",
    "pts", "pts_rk", "nst", "nst_rk",
    "blk", "blk_rk", "elev", "elev_rk"
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
