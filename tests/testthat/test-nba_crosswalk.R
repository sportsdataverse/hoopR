test_that(".bb_assemble_team_crosswalk_nba joins ESPN/Stats/Fox on espn_team_id", {
  espn <- data.frame(
    team_id = c(13L, 17L), abbreviation = c("LAL", "BOS"),
    display_name = c("Los Angeles Lakers", "Boston Celtics"),
    short_name = c("LA Lakers", "Boston"),
    team = c("Los Angeles", "Boston"), mascot = c("Lakers", "Celtics"),
    stringsAsFactors = FALSE)
  stats <- data.frame(
    espn_team_id = c(13L, 17L),
    nba_team_id = c("1610612747", "1610612738"),
    nba_team_abbreviation = c("LAL", "BOS"),
    nba_team_name = c("Lakers", "Celtics"),
    nba_team_city = c("Los Angeles", "Boston"),
    nba_team_slug = c("lakers", "celtics"),
    nba_conference = c("West", "East"),
    nba_division = c("Pacific", "Atlantic"),
    stringsAsFactors = FALSE)
  fox <- data.frame(
    fox_team_id = c("13", "18"),
    fox_team_name = c("Los Angeles Lakers", "Boston Celtics"),
    fox_section = c("Western Conference", "Eastern Conference"),
    stringsAsFactors = FALSE)
  out <- .bb_assemble_team_crosswalk_nba(espn, stats, fox, season = 2025)
  expect_equal(nrow(out), 2)
  expect_equal(out$nba_team_id[out$espn_team_id == 13L], "1610612747")
  expect_equal(out$fox_team_id[out$espn_team_id == 17L], "18")
  expect_true(all(is.na(out$yahoo_team_id)))
})

test_that(".bb_assemble_schedule_crosswalk_nba full-outer joins on ET date + teams", {
  team_xwalk <- data.frame(
    espn_team_id = c(13L, 17L), nba_team_id = c("1610612747", "1610612738"),
    stringsAsFactors = FALSE)
  espn_games <- data.frame(
    espn_game_id = "401", game_date = as.Date("2024-12-25"),
    espn_home_team_id = 13L, espn_away_team_id = 17L, stringsAsFactors = FALSE)
  stats_games <- data.frame(
    nba_game_id = "0022400400", nba_game_code = "20241225/BOSLAL",
    game_date = as.Date("2024-12-25"),
    nba_home_team_id = "1610612747", nba_away_team_id = "1610612738",
    season_type = "Regular Season", stringsAsFactors = FALSE)
  out <- .bb_assemble_schedule_crosswalk_nba(espn_games, stats_games, team_xwalk, season = 2025)
  expect_equal(nrow(out), 1)
  expect_equal(out$espn_game_id, "401")
  expect_equal(out$nba_game_id, "0022400400")
  expect_equal(out$match_method, "both")
  expect_false(any(c("espn_home_team_id", "espn_away_team_id") %in% names(out)))
})

test_that(".bb_assemble_player_crosswalk_nba matches ESPN/Stats within team blocks", {
  espn <- data.frame(
    espn_team_id = c(13L, 13L), team_abbreviation = c("LAL", "LAL"),
    espn_athlete_id = c("a1", "a2"),
    espn_full_name = c("LeBron James", "Anthony Davis"),
    espn_jersey = c("23", "3"), espn_position = c("SF", "PF"),
    espn_birth_date = c("1984-12-30", "1993-03-11"), stringsAsFactors = FALSE)
  stats <- data.frame(
    espn_team_id = c(13L, 13L), nba_player_id = c("p1", "p2"),
    nba_player_name = c("LeBron James", "Anthony Davis"),
    nba_jersey_num = c("23", "3"), nba_position = c("F", "F-C"),
    nba_birth_date = c("1984-12-30", "1993-03-11"), stringsAsFactors = FALSE)
  fox <- data.frame(
    espn_team_id = integer(), fox_athlete_id = character(),
    fox_player = character(), fox_jersey = character(),
    fox_position_group = character(), stringsAsFactors = FALSE)
  out <- .bb_assemble_player_crosswalk_nba(
    espn, stats, fox, season = 2025, min_confidence = 0.92
  )
  expect_equal(nrow(out), 2)
  expect_equal(out$nba_player_id[out$espn_athlete_id == "a1"], "p1")
  expect_in(sort(c("fox_athlete_id", "yahoo_player_id")), sort(colnames(out)))
})

# ---------------------------------------------------------------------------
# Live tests — require ESPN_TESTS=1; always skipped on CRAN and CI.
# ---------------------------------------------------------------------------

test_that("nba_team_crosswalk() returns a live hoopR_data tibble", {
  skip_on_cran()
  skip_on_ci()
  if (Sys.getenv("ESPN_TESTS") != "1") skip("ESPN_TESTS not set")
  out <- nba_team_crosswalk()
  skip_if(nrow(out) == 0, "nba_team_crosswalk() returned 0 rows at test time")
  expect_s3_class(out, "hoopR_data")
  expect_true("espn_team_id" %in% names(out))
  expect_gte(nrow(out), 28L)
})

test_that("nba_schedule_crosswalk() returns a live hoopR_data tibble", {
  skip_on_cran()
  skip_on_ci()
  if (Sys.getenv("ESPN_TESTS") != "1") skip("ESPN_TESTS not set")
  out <- nba_schedule_crosswalk()
  skip_if(nrow(out) == 0, "nba_schedule_crosswalk() returned 0 rows at test time")
  expect_s3_class(out, "hoopR_data")
  expect_true("espn_game_id" %in% names(out))
})

test_that("nba_player_crosswalk() returns a live hoopR_data tibble", {
  skip_on_cran()
  skip_on_ci()
  if (Sys.getenv("ESPN_TESTS") != "1") skip("ESPN_TESTS not set")
  out <- nba_player_crosswalk()
  skip_if(
    nrow(out) == 0,
    "nba_player_crosswalk() returned 0 rows at test time"
  )
  expect_s3_class(out, "hoopR_data")
  expect_true("espn_athlete_id" %in% names(out))
})
