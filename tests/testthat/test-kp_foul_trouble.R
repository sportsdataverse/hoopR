context("KP - Get foul trouble")



test_that("KP - Get foul trouble", {
  skip_on_cran()
  skip_on_ci()
  x <- kp_foul_trouble(min_year = 2020, max_year = 2020)

  cols <- c(
    "team", "conf", "two_foul_particpation_pct",
    "two_foul_particpation_pct_rk", "adj2fp", "adj2fp_rk", "two_foul_total_time",
    "two_foul_total_time_rk", "two_foul_time_on",
    "two_foul_time_on_rk", "bench_pct", "bench_pct_rk", "ncaa_seed", "year"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
