test_that("ESPN - Get NBA Betting", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_nba_betting(game_id = 401283399)

  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }

  # Betting data may not be available for older games
  if (length(x) >= 1 && ncol(x[[1]]) > 0) {
    cols_x1 <- c(
      "details",
      "over_under",
      "spread",
      "provider_id",
      "provider_name",
      "game_id"
    )
    expect_in(sort(cols_x1), sort(colnames(x[[1]])))
    expect_s3_class(x[[1]], "data.frame")
  }

  if (length(x) >= 2 && ncol(x[[2]]) > 0) {
    cols_x2 <- c(
      "id",
      "display_name",
      "abbreviation",
      "game_id",
      "team_id"
    )
    expect_in(sort(cols_x2), sort(colnames(x[[2]])))
    expect_s3_class(x[[2]], "data.frame")
  }

  if (length(x) >= 3 && ncol(x[[3]]) > 0) {
    cols_x3 <- c(
      "game_id",
      "home_team_id",
      "away_team_id"
    )
    expect_in(sort(cols_x3), sort(colnames(x[[3]])))
    expect_s3_class(x[[3]], "data.frame")
  }

  # At minimum, expect a list is returned
  expect_type(x, "list")

})

test_that("ESPN - Get NBA Betting falls back to Core v2 odds when pickcenter is empty (#136, #153, #173)", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_nba_betting(game_id = 401809781)

  expect_gt(nrow(x$pickcenter), 0)
  expect_in(
    c("provider_id", "provider_name", "over_under", "spread", "game_id"),
    colnames(x$pickcenter)
  )
})
