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
