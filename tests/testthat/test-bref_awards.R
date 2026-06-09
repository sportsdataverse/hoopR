test_that("BREF - Awards Voting", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_awards(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No award voting returned at test time")

  cols <- c("award", "rank", "player", "team", "votes_first", "points_won",
            "award_share", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})

test_that("BREF - Team Roster", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_team_roster(team = "BOS", season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No roster returned at test time")

  cols <- c("number", "player", "pos", "height", "weight", "team", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})

test_that("BREF - Player Game Log", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_player_game_log(player_id = "jokicni01", season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No game log returned at test time")

  cols <- c("date", "team", "opp", "result", "pts", "trb", "ast",
            "player_id", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})
