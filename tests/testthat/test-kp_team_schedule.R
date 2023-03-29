
test_that("KP - Get team schedule", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_team_schedule(team = "Florida St.", year= 2020)

  cols <- c(
    "team_rk", "team", "opponent_rk", "opponent", "result",
    "poss", "ot", "pre_wp", "location", "w", "l", "w_conference",
    "l_conference", "conference_game", "postseason", "year",
    "day_date", "game_date", "w_proj", "l_proj",
    "w_conference_proj", "l_conference_proj", "date",
    "game_id", "tiers_of_joy"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x,"data.frame")
})
