test_that("NBA G-League Schedule", {
  skip_on_cran()
  skip_on_ci()

  x <- nbagl_schedule(season = most_recent_nba_season() - 1)

  cols_x1 <- c(
    "mon",
    "gid",
    "gcode",
    "seri",
    "is",
    "gdte",
    "htm",
    "vtm",
    "etm",
    "an",
    "ac",
    "as",
    "st",
    "stt",
    "gdtutc",
    "utctm",
    "ppdst",
    "seq",
    "bd_b",
    "v_tid",
    "v_re",
    "v_ta",
    "v_tn",
    "v_tc",
    "v_s",
    "h_tid",
    "h_re",
    "h_ta",
    "h_tn",
    "h_tc",
    "h_s",
    "ptsls_pl"
  )


  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, 'data.frame')

})
