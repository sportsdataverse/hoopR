test_that("NBA IST Standings", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_iststandings(league_id = "00", season = "2025-26")

  cols_standings <- c(
    "league_id",
    "season_year",
    "team_id",
    "team_city",
    "team_name",
    "team_abbreviation",
    "team_slug",
    "conference",
    "ist_group",
    "clinch_indicator",
    "clinched_ist_knockout",
    "clinched_ist_group",
    "clinched_ist_wildcard",
    "ist_wildcard_rank",
    "ist_group_rank",
    "ist_knockout_rank",
    "wins",
    "losses",
    "pct",
    "ist_group_gb",
    "ist_wildcard_gb",
    "diff",
    "pts",
    "opp_pts"
  )

  # Validate core columns are present (game columns are dynamic)
  expect_true(all(cols_standings %in% colnames(x$Standings)))
  expect_s3_class(x$Standings, "data.frame")
  expect_gt(nrow(x$Standings), 0)

  Sys.sleep(3)
})
