# URL builders are pure -- safe to run everywhere.

test_that("NBA media URL builders", {
  skip_on_cran()
  expect_equal(
    nba_player_headshot_url(201939),
    "https://cdn.nba.com/headshots/nba/latest/1040x760/201939.png")
  expect_equal(
    nba_player_headshot_url(201939, size = "260x190"),
    "https://cdn.nba.com/headshots/nba/latest/260x190/201939.png")
  expect_equal(
    nba_team_logo_url(1610612744),
    "https://cdn.nba.com/logos/nba/1610612744/primary/L/logo.svg")
  # vectorized
  expect_length(nba_player_headshot_url(c(2544, 201939)), 2)
})

test_that("NBA Player Dictionary", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_player_dict()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player dictionary returned at test time")

  cols <- c("player_id", "player_name", "team_id", "team_abbreviation",
            "headshot_url", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_true(all(grepl("cdn.nba.com/headshots", x$headshot_url)))

  Sys.sleep(3)
})

test_that("NBA Team Dictionary", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_team_dict()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team dictionary returned at test time")

  cols <- c("team_id", "team_abbreviation", "team_full", "conference",
            "division", "logo_url")
  expect_in(sort(cols), sort(colnames(x)))
  expect_setequal(unique(x$conference), c("Eastern", "Western"))

  Sys.sleep(3)
})
