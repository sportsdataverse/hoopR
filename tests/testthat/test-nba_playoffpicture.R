test_that("NBA Playoff Picture", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playoffpicture(league_id = '00', season_id = paste0(2, most_recent_nba_season() - 1))

  cols_x1 <- c(
    "CONFERENCE",
    "HIGH_SEED_RANK",
    "HIGH_SEED_TEAM",
    "HIGH_SEED_TEAM_ID",
    "LOW_SEED_RANK",
    "LOW_SEED_TEAM",
    "LOW_SEED_TEAM_ID",
    "HIGH_SEED_SERIES_W",
    "HIGH_SEED_SERIES_L",
    "HIGH_SEED_SERIES_REMAINING_G",
    "HIGH_SEED_SERIES_REMAINING_HOME_G",
    "HIGH_SEED_SERIES_REMAINING_AWAY_G"
  )

  cols_x2 <- c(
    "CONFERENCE",
    "HIGH_SEED_RANK",
    "HIGH_SEED_TEAM",
    "HIGH_SEED_TEAM_ID",
    "LOW_SEED_RANK",
    "LOW_SEED_TEAM",
    "LOW_SEED_TEAM_ID",
    "HIGH_SEED_SERIES_W",
    "HIGH_SEED_SERIES_L",
    "HIGH_SEED_SERIES_REMAINING_G",
    "HIGH_SEED_SERIES_REMAINING_HOME_G",
    "HIGH_SEED_SERIES_REMAINING_AWAY_G"
  )

  cols_x3 <- c(
    "CONFERENCE",
    "RANK",
    "TEAM",
    "TEAM_SLUG",
    "TEAM_ID",
    "WINS",
    "LOSSES",
    "PCT",
    "DIV",
    "CONF",
    "HOME",
    "AWAY",
    "GB",
    "GR_OVER_500",
    "GR_OVER_500_HOME",
    "GR_OVER_500_AWAY",
    "GR_UNDER_500",
    "GR_UNDER_500_HOME",
    "GR_UNDER_500_AWAY",
    "RANKING_CRITERIA",
    "CLINCHED_PLAYOFFS",
    "CLINCHED_CONFERENCE",
    "CLINCHED_DIVISION",
    "ELIMINATED_PLAYOFFS",
    "SOSA_REMAINING"
  )

  cols_x4 <- c(
    "CONFERENCE",
    "RANK",
    "TEAM",
    "TEAM_SLUG",
    "TEAM_ID",
    "WINS",
    "LOSSES",
    "PCT",
    "DIV",
    "CONF",
    "HOME",
    "AWAY",
    "GB",
    "GR_OVER_500",
    "GR_OVER_500_HOME",
    "GR_OVER_500_AWAY",
    "GR_UNDER_500",
    "GR_UNDER_500_HOME",
    "GR_UNDER_500_AWAY",
    "RANKING_CRITERIA",
    "CLINCHED_PLAYOFFS",
    "CLINCHED_CONFERENCE",
    "CLINCHED_DIVISION",
    "ELIMINATED_PLAYOFFS",
    "SOSA_REMAINING"
  )

  cols_x5 <- c(
    "TEAM",
    "TEAM_ID",
    "REMAINING_G",
    "REMAINING_HOME_G",
    "REMAINING_AWAY_G"
  )

  cols_x6 <- c(
    "TEAM",
    "TEAM_ID",
    "REMAINING_G",
    "REMAINING_HOME_G",
    "REMAINING_AWAY_G"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], 'data.frame')
  expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
  expect_s3_class(x[[5]], 'data.frame')
  expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
  expect_s3_class(x[[6]], 'data.frame')

})
