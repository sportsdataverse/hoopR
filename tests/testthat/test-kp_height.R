context("KP - Get heights")



test_that("KP - Get heights", {
  skip_on_cran()
  x <- kp_height(min_year = 2020, max_year = 2020)

  cols <- c(
  "team", "conf", "avg_hgt", "avg_hgt_rk", "eff_hgt",
  "eff_hgt_rk", "c_hgt", "c_hgt_rk", "pf_hgt", "pf_hgt_rk", "sf_hgt",
  "sf_hgt_rk", "sg_hgt", "sg_hgt_rk", "pg_hgt", "pg_hgt_rk", "experience", "experience_rk",
  "bench", "bench_rk", "continuity", "continuity_rk", "ncaa_seed", "year"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
