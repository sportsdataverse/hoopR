test_that("ESPN - Get NBA Betting", {
  skip_on_cran()
  x <- espn_nba_betting(game_id = 401283399)

  cols_x1 <- c(
    "details",
    "over_under",
    "spread",
    "provider_id",
    "provider_name",
    "provider_priority",
    "away_team_odds_favorite",
    "away_team_odds_underdog",
    "away_team_odds_money_line",
    "away_team_odds_spread_odds",
    "away_team_odds_team_id",
    "away_team_odds_win_percentage",
    "away_team_odds_average_score",
    "away_team_odds_money_line_odds",
    "away_team_odds_spread_return",
    "away_team_odds_spread_record_wins",
    "away_team_odds_spread_record_losses",
    "away_team_odds_spread_record_pushes",
    "away_team_odds_spread_record_summary",
    "home_team_odds_favorite",
    "home_team_odds_underdog",
    "home_team_odds_money_line",
    "home_team_odds_spread_odds",
    "home_team_odds_team_id",
    "home_team_odds_win_percentage",
    "home_team_odds_average_score",
    "home_team_odds_money_line_odds",
    "home_team_odds_spread_return",
    "home_team_odds_spread_record_wins",
    "home_team_odds_spread_record_losses",
    "home_team_odds_spread_record_pushes",
    "home_team_odds_spread_record_summary"
  )

  cols_x2 <- c(
    "id",
    "uid",
    "display_name",
    "abbreviation",
    "logo",
    "logos",
    "records"
  )

  cols_x3 <- c(
    "home_team_id",
    "away_team_id",
    "away_team_game_projection",
    "away_team_chance_loss"
  )

  expect_equal(colnames(x[[1]]), cols_x1)
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(colnames(x[[2]]), cols_x2)
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(colnames(x[[3]]), cols_x3)
  expect_s3_class(x[[3]], "data.frame")

})
