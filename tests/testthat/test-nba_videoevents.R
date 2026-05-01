test_that("NBA Video Events", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_videoevents(game_id = "0021700807", game_event_id = "10")

  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }

  cols_x1 <- c(
    "uuid",
    "dur",
    "stt",
    "stp",
    "sth",
    "stw",
    "mtt",
    "mtp",
    "mth",
    "mtw",
    "ltt",
    "ltp",
    "lth",
    "ltw"
  )

  cols_x2 <- c(
    "gi",
    "ei",
    "y",
    "m",
    "d",
    "gc",
    "p",
    "dsc",
    "ha",
    "va",
    "hpb",
    "hpa",
    "vpb",
    "vpa",
    "pta"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")

  Sys.sleep(3)

})
