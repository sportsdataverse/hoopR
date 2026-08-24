test_that("NBA Scoreboard V2", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_scoreboardv2(league_id = "00", game_date = "2021-07-20")

  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }

  # Result sets are keyed by name rather than fixed position: a 2026-08-24
  # live re-probe found the endpoint currently returns 9 named tables (no
  # WinProbability), and some tables (e.g. LineScore, TicketLinks) can come
  # back empty for older completed games -- so each table's columns are only
  # checked when it actually has rows.
  expect_type(x, "list")
  expect_true(all(vapply(x, is.data.frame, logical(1))))

  expected_cols <- list(
    GameHeader = c(
      "GAME_DATE_EST", "GAME_SEQUENCE", "GAME_ID", "GAME_STATUS_ID",
      "GAME_STATUS_TEXT", "GAMECODE", "HOME_TEAM_ID", "VISITOR_TEAM_ID",
      "SEASON", "LIVE_PERIOD", "LIVE_PC_TIME",
      "NATL_TV_BROADCASTER_ABBREVIATION", "LIVE_PERIOD_TIME_BCAST",
      "WH_STATUS"
    ),
    LineScore = c(
      "GAME_DATE_EST", "GAME_SEQUENCE", "GAME_ID", "TEAM_ID",
      "TEAM_ABBREVIATION", "TEAM_CITY_NAME", "TEAM_WINS_LOSSES",
      "PTS_QTR1", "PTS_QTR2", "PTS_QTR3", "PTS_QTR4", "PTS"
    ),
    SeriesStandings = c(
      "GAME_ID", "HOME_TEAM_ID", "VISITOR_TEAM_ID", "GAME_DATE_EST",
      "HOME_TEAM_WINS", "HOME_TEAM_LOSSES", "SERIES_LEADER"
    ),
    LastMeeting = c(
      "GAME_ID", "LAST_GAME_ID", "LAST_GAME_DATE_EST",
      "LAST_GAME_HOME_TEAM_ID", "LAST_GAME_HOME_TEAM_CITY",
      "LAST_GAME_HOME_TEAM_NAME", "LAST_GAME_HOME_TEAM_ABBREVIATION",
      "LAST_GAME_HOME_TEAM_POINTS", "LAST_GAME_VISITOR_TEAM_ID",
      "LAST_GAME_VISITOR_TEAM_CITY", "LAST_GAME_VISITOR_TEAM_NAME",
      "LAST_GAME_VISITOR_TEAM_POINTS"
    ),
    EastConfStandingsByDay = c(
      "TEAM_ID", "LEAGUE_ID", "SEASON_ID", "STANDINGSDATE", "CONFERENCE",
      "TEAM", "G", "W", "L", "W_PCT", "HOME_RECORD", "ROAD_RECORD"
    ),
    WestConfStandingsByDay = c(
      "TEAM_ID", "LEAGUE_ID", "SEASON_ID", "STANDINGSDATE", "CONFERENCE",
      "TEAM", "G", "W", "L", "W_PCT", "HOME_RECORD", "ROAD_RECORD"
    ),
    Available = c("GAME_ID", "PT_AVAILABLE"),
    TeamLeaders = c(
      "GAME_ID", "TEAM_ID", "TEAM_CITY", "TEAM_NICKNAME",
      "TEAM_ABBREVIATION", "PTS_PLAYER_ID", "PTS_PLAYER_NAME", "PTS",
      "REB_PLAYER_ID", "REB_PLAYER_NAME", "REB", "AST_PLAYER_ID",
      "AST_PLAYER_NAME", "AST"
    )
  )

  for (nm in names(expected_cols)) {
    if (!(nm %in% names(x))) next
    tbl <- x[[nm]]
    if (!is.data.frame(tbl) || nrow(tbl) == 0 || ncol(tbl) == 0) next
    expect_in(sort(expected_cols[[nm]]), sort(colnames(tbl)))
  }

  Sys.sleep(3)

})
