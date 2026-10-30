# Offline: helper_espn_{mbb,nba}_pbp() on the committed ESPN payloads.

.raw <- function(name) testthat::test_path("fixtures", "score_repair", paste0(name, ".json.gz"))
.final <- function(name) {
  testthat::test_path("fixtures", "espn_pbp_coordinates", paste0(name, "_final.json.gz"))
}

test_that("play id is an exact character string on raw and processed payloads", {
  # The sportsdataverse-py processed payload carries `id` as a JSON number;
  # MBB ids are 18 digits, past what a double holds exactly.
  for (case in list(
    list(fn = helper_espn_mbb_pbp, game = "mbb_401830342"),
    list(fn = helper_espn_nba_pbp, game = "nba_401766458")
  )) {
    fin <- case$fn(.final(case$game))
    raw <- case$fn(.raw(case$game))
    expect_type(fin$id, "character")
    expect_type(raw$id, "character")
    expect_false(anyDuplicated(fin$id) > 0, info = case$game)
    expect_identical(sort(fin$id), sort(raw$id), info = case$game)
  }
})

# The same real summary with its two competitors listed away-first.
.away_first <- function(path) {
  j <- jsonlite::read_json(path, simplifyVector = FALSE)
  j$header$competitions[[1]]$competitors <- rev(j$header$competitions[[1]]$competitors)
  jsonlite::toJSON(j, auto_unbox = TRUE, null = "null", digits = NA)
}

test_that("home logo is the light logo whichever order the competitors come in", {
  for (case in list(
    list(fn = helper_espn_mbb_pbp, game = "summary_mbb"),
    list(fn = helper_espn_nba_pbp, game = "summary_nba")
  )) {
    home_first <- case$fn(.raw(case$game))
    away_first <- case$fn(.away_first(.raw(case$game)))
    cols <- c("home_team_logo", "home_team_logo_dark", "away_team_logo", "away_team_logo_dark")
    expect_identical(
      unique(as.data.frame(away_first)[, cols]),
      unique(as.data.frame(home_first)[, cols]),
      info = case$game
    )
    expect_false(grepl("-dark", away_first$home_team_logo[1]), info = case$game)
    expect_match(away_first$home_team_logo_dark[1], "-dark", info = case$game)
  }
})
