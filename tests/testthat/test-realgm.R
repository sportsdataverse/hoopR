test_that("RealGM - NBA Player Index", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()  # Requires REALGM_TESTS=1 + chromote + Google Chrome

  x <- realgm_players()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM player data returned at test time")

  cols <- c("player", "pos", "ht", "wt", "current_team", "pre_draft_team")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_gt(nrow(x), 100)  # full active player index, not a single team

  Sys.sleep(2)
})
