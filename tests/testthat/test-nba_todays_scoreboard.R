test_that("NBA Todays Scoreboard", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  # Fetch the feed itself first, so a refused request fails here instead of
  # passing as a day without games. The CDN serves this JSON as text/plain,
  # so check that the body parses rather than its content type.
  resp <- .retry_request(
    "https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json",
    headers = .nba_cdn_headers()
  )
  expect_equal(httr2::resp_status(resp), 200L)
  body <- .resp_text(resp)
  expect_true(jsonlite::validate(body))
  feed <- jsonlite::fromJSON(body)
  expect_true("games" %in% names(feed$scoreboard))
  # Off-days and the off-season list no games.
  if (NROW(feed$scoreboard$games) == 0) {
    skip("No games on the schedule today")
  }

  Sys.sleep(3)

  x <- nba_todays_scoreboard()
  expect_s3_class(x, "data.frame")
  expect_gt(nrow(x), 0)

  # The *_leaders_* and pb_odds_* columns are absent when no player leaders
  # or betting odds are posted, so assert only the identity columns.
  cols_x1 <- c(
    "game_id",
    "game_code",
    "game_status",
    "home_team_id",
    "away_team_id"
  )

  expect_in(sort(cols_x1), sort(colnames(x)))

  Sys.sleep(3)

})
