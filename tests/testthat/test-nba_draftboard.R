test_that("NBA Draft Board", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_draftboard(season = most_recent_nba_season() - 1)

  cols_x1 <- c(
    "pick_number",
    "pick_details",
    "team_id",
    "team_type",
    "team_season",
    "team_team_id",
    "team_permalink",
    "team_app_url",
    "team_trade_details",
    "team_team_name",
    "team_team_abbr",
    "team_picked_first_round",
    "team_picked_second_round",
    "team_team_record_season",
    "team_team_record_wins_and_losses",
    "team_team_record_season_finish",
    "team_team_record_playoffs_finish",
    "prospect_id",
    "prospect_type",
    "prospect_season",
    "prospect_display_name",
    "prospect_first_name",
    "prospect_last_name",
    "prospect_permalink",
    "prospect_app_url",
    "prospect_position",
    "prospect_weight_lbs",
    "prospect_school",
    "prospect_status",
    "prospect_birthday",
    "prospect_country",
    "prospect_trade_details",
    "prospect_height_feet_and_inches",
    "prospect_height_inches_only"
  )

  cols_x2 <- c(
    "id",
    "type",
    "season",
    "team_id",
    "team_record",
    "permalink",
    "app_url",
    "trade_details",
    "team_name",
    "team_abbr",
    "picked_second_round",
    "picked_first_round"
  )

  cols_x3 <- c(
    "is_draft_live",
    "live_draft_current_pick_number"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")

  Sys.sleep(3)

})
