skip_on_cran()

# Clock / period / timeout columns of helper_espn_mbb_pbp() / helper_espn_nba_pbp(), the
# R mirror of sportsdataverse-py's helper_<lg>_pbp_features. The payloads are the real ESPN
# summaries in fixtures/score_repair/; fixtures/pbp_features/<name>.csv is sportsdataverse-py's
# release frame (espn_<lg>_pbp) on the same bytes (provenance: fixtures/pbp_features/README.md).

fx <- testthat::test_path("fixtures")

.check_features <- function(helper, name) {
  got <- helper(file.path(fx, "score_repair", paste0(name, ".json.gz")))
  want <- utils::read.csv(file.path(fx, "pbp_features", paste0(name, ".csv")),
                          stringsAsFactors = FALSE, na.strings = "")
  expect_identical(nrow(got), nrow(want), info = name)
  expect_identical(as.integer(got$sequence_number), want$sequence_number, info = name)
  for (col in setdiff(names(want), c("row", "sequence_number"))) {
    expect_true(col %in% names(got), info = paste(name, col))
    g <- got[[col]]
    w <- want[[col]]
    if (is.logical(g)) w <- as.logical(w)
    if (is.character(g)) w <- as.character(w)
    expect_equal(unname(g), w, info = paste(name, col))
  }
  got
}

test_that("MBB play features equal sportsdataverse-py row for row", {
  for (name in c("mbb_401829457", "summary_mbb", "mbb_401830342")) {
    got <- .check_features(helper_espn_mbb_pbp, name)
    expect_type(got$start_game_seconds_remaining, "integer")
    expect_identical(names(got)[[ncol(got)]], "score_source")
  }
})

test_that("NBA play features equal sportsdataverse-py row for row", {
  for (name in c("nba_401766458", "nba_400829116", "nba_401704638", "summary_nba")) {
    got <- .check_features(helper_espn_nba_pbp, name)
    expect_type(got$start_game_seconds_remaining, "double")
  }
})

test_that("a period's last row ends at 0:00 on its own clock (MBB 401830342, 2OT)", {
  got <- helper_espn_mbb_pbp(file.path(fx, "score_repair", "mbb_401830342.json.gz"))
  last <- which(got$period_number != dplyr::lead(got$period_number))
  expect_length(last, 3L)
  expect_identical(got$end_period_seconds_remaining[last], c(0L, 0L, 0L))
  expect_true(is.na(got$end_game_seconds_remaining[[nrow(got)]]))
  # timeouts: every flagged play is a timeout type credited to exactly one team
  flagged <- got$home_timeout_called | got$away_timeout_called
  expect_gt(sum(flagged), 0L)
  expect_false(any(got$home_timeout_called & got$away_timeout_called))
  expect_true(all(got$type_text[flagged] %in% .team_timeout_types))
})

test_that(".timeout_called() falls back to a whole-word name match per row", {
  # hand-built frame: no committed game has a timeout without a team_id
  plays <- data.frame(
    type_text = c("ShortTimeOut", "ShortTimeOut", "Jumpshot", "ShortTimeOut"),
    text = c("Duke timeout", "UNC timeout", "Duke jumper", "San Jos\u00e9 St timeout")
  )
  expect_identical(.timeout_called(plays, 150L, "Duke"), c(TRUE, FALSE, FALSE, FALSE))
  # \W is Unicode-aware, as in sportsdataverse-py: "Jos" is not a word inside "Jos\u00e9"
  expect_identical(.timeout_called(plays, 23L, "Jos"), c(FALSE, FALSE, FALSE, FALSE))
  expect_identical(.timeout_called(plays, 23L, "san jos\u00e9 st"), c(FALSE, FALSE, FALSE, TRUE))
  # a play's own team_id wins over the text
  plays$team_id <- c(2L, NA, NA, NA)
  expect_identical(.timeout_called(plays, 150L, "Duke"), c(FALSE, FALSE, FALSE, FALSE))
})

test_that("a NA period never ends a period (sportsdataverse-py reads a null condition as false)", {
  plays <- data.frame(period_number = c(NA, 1L, 1L), start_period_seconds_remaining = c(5L, 3L, 1L))
  plays$start_game_seconds_remaining <- plays$start_period_seconds_remaining
  got <- .end_seconds(plays, "period", "game")
  expect_identical(got$end_period_seconds_remaining, c(3L, 1L, NA))
})
