test_that("ESPN - Get MBB Betting", {
  skip_on_cran()
  x <- espn_mbb_betting(game_id = 401256760)

  cols_x1 <- c(
    "details",
    "over_under",
    "spread",
    "over_odds",
    "under_odds",
    "provider_id",
    "provider_name",
    "provider_priority",
    "away_team_odds_win_percentage",
    "away_team_odds_favorite",
    "away_team_odds_underdog",
    "away_team_odds_money_line",
    "away_team_odds_spread_odds",
    "away_team_odds_team_id",
    "away_team_odds_average_score",
    "away_team_odds_money_line_odds",
    "away_team_odds_spread_return",
    "away_team_odds_current_point_spread_alternate_display_value",
    "away_team_odds_current_spread_alternate_display_value",
    "away_team_odds_current_money_line_alternate_display_value",
    "away_team_odds_spread_record_wins",
    "away_team_odds_spread_record_losses",
    "away_team_odds_spread_record_pushes",
    "away_team_odds_spread_record_summary",
    "home_team_odds_win_percentage",
    "home_team_odds_favorite",
    "home_team_odds_underdog",
    "home_team_odds_money_line",
    "home_team_odds_spread_odds",
    "home_team_odds_team_id",
    "home_team_odds_average_score",
    "home_team_odds_money_line_odds",
    "home_team_odds_spread_return",
    "home_team_odds_current_point_spread_alternate_display_value",
    "home_team_odds_current_spread_alternate_display_value",
    "home_team_odds_current_money_line_alternate_display_value",
    "home_team_odds_spread_record_wins",
    "home_team_odds_spread_record_losses",
    "home_team_odds_spread_record_pushes",
    "home_team_odds_spread_record_summary",
    "current_over_alternate_display_value",
    "current_under_alternate_display_value",
    "current_total_alternate_display_value",
    "game_id"
  )

  cols_x2 <- c(
    "id",
    "uid",
    "display_name",
    "abbreviation",
    "logo",
    "logos",
    "records",
    "game_id",
    "team_id"
  )

  cols_x3 <- c(
    "game_id",
    "home_team_id",
    "away_team_id",
    "away_team_game_projection",
    "away_team_chance_loss"
  )

  expect_in(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_in(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")

})
