fx <- testthat::test_path("fixtures", "official_nba")
.read_gold <- function(name) {
  utils::read.csv(file.path(fx, name), colClasses = "character", na.strings = "", check.names = FALSE)
}
# Parity convention (Task 7-R spec): compare as character with NA == "".
.blank_as_na <- function(v) {
  v <- as.character(v)
  v[!is.na(v) & v == ""] <- NA_character_
  v
}

test_that("S3 XML 403 is no-data, Akamai HTML 403 is a fetch error", {
  xml <- paste(readLines(file.path(fx, "l2m_json_0022500002_no_report_s3_403.xml"), warn = FALSE), collapse = "\n")
  html <- paste(readLines(file.path(fx, "akamai_403_blocked_ua.html"), warn = FALSE), collapse = "\n")
  expect_identical(hoopR:::.classify_official_403(xml), "no_data")
  expect_identical(hoopR:::.classify_official_403(html), "fetch_error")
})

test_that("L2M parser matches sdv-py golden output (calls)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  got <- hoopR:::.parse_nba_l2m(x)$calls
  gold <- .read_gold("l2m_0042500405_calls.csv")

  expect_identical(names(got), names(gold))
  expect_equal(nrow(got), nrow(gold))
  expect_identical(as.character(got$game_id), gold$game_id)
  expect_identical(got$decision, gold$decision)
  expect_identical(as.character(got$call), gold$call)
  expect_identical(as.character(got$committing), gold$committing)
  expect_identical(as.character(got$disadvantaged), gold$disadvantaged)
  expect_equal(as.numeric(got$period), as.numeric(gold$period))
  expect_equal(as.numeric(got$seconds_remaining), as.numeric(gold$seconds_remaining))
  expect_identical(got$game_id[1], "0042500405")
})

test_that("L2M parser matches sdv-py golden output (game, stats)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  out <- hoopR:::.parse_nba_l2m(x)
  gold_game <- .read_gold("l2m_0042500405_game.csv")
  gold_stats <- .read_gold("l2m_0042500405_stats.csv")

  expect_identical(names(out$game), names(gold_game))
  expect_identical(as.character(out$game$game_id), gold_game$game_id)
  expect_identical(as.character(out$game$season_type), gold_game$season_type)
  expect_identical(format(out$game$game_date, "%Y-%m-%d"), gold_game$game_date)
  expect_equal(as.numeric(out$game$home_score), as.numeric(gold_game$home_score))

  expect_identical(names(out$stats), names(gold_stats))
  expect_identical(as.character(out$stats$stat_name), gold_stats$stat_name)
  expect_equal(as.numeric(out$stats$home), as.numeric(gold_stats$home))
  expect_equal(as.numeric(out$stats$away), as.numeric(gold_stats$away))
})

test_that("decision normalization: NCC/NCI/star/blank/Undetectable", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$CallRatingName[1:5] <- c("NCC", "NCI", "Undetectable", "", "CC*")
  got <- hoopR:::.parse_nba_l2m(x)$calls$decision[1:5]
  expect_identical(got, c("CNC", "INC", NA_character_, NA_character_, "CC"))
})

test_that("names are kept verbatim (no ASCII folding)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$DP[1] <- "Nikola Jokić"
  expect_identical(hoopR:::.parse_nba_l2m(x)$calls$disadvantaged[1], "Nikola Jokić")
})

test_that("game_id is a 10-char zero-padded string from an int game id", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$game$GameId <- 42500405
  got <- hoopR:::.parse_nba_l2m(x)$calls$game_id[1]
  expect_identical(got, "0042500405")
  expect_equal(nchar(got), 10)
})

test_that("referee assignments parser matches sdv-py golden output (nba)", {
  x <- jsonlite::fromJSON(file.path(fx, "referee_assignments_2026-06-13.json"), simplifyVector = FALSE)
  out <- hoopR:::.parse_nba_referee_assignments(x, "nba")
  gold_off <- .read_gold("referee_assignments_2026-06-13_nba_officials.csv")
  gold_replay <- .read_gold("referee_assignments_2026-06-13_nba_replay_center.csv")

  expect_identical(names(out$officials), names(gold_off))
  expect_equal(nrow(out$officials), nrow(gold_off))
  expect_identical(as.character(out$officials$official_name), gold_off$official_name)
  expect_equal(as.numeric(out$officials$official_id), as.numeric(gold_off$official_id))
  expect_equal(as.numeric(out$officials$season), as.numeric(gold_off$season))
  expect_identical(as.character(out$officials$season_type), gold_off$season_type)
  expect_identical(as.character(out$officials$game_id), gold_off$game_id)
  chief <- out$officials[out$officials$crew_position == 1, ]
  expect_equal(chief$official_id, 1162)
  expect_identical(chief$official_name, "Scott Foster")
  expect_identical(chief$jersey_num, "48")

  expect_identical(names(out$replay_center), names(gold_replay))
  expect_equal(nrow(out$replay_center), nrow(gold_replay))
  expect_identical(as.character(out$replay_center$official_name), gold_replay$official_name)
})

test_that("referee assignments: unknown league keeps schema, empty rows", {
  x <- jsonlite::fromJSON(file.path(fx, "referee_assignments_2026-06-13.json"), simplifyVector = FALSE)
  x[["gl"]] <- list(Table = list(rows = list()), Table1 = list(rows = list()))
  out <- hoopR:::.parse_nba_referee_assignments(x, "gl")
  expect_equal(nrow(out$officials), 0)
  expect_true("official_id" %in% names(out$officials))
})

test_that("referee assignments: bad league errors", {
  expect_error(hoopR:::.parse_nba_referee_assignments(list(), "mlb"))
})

test_that("L2M games listing matches sdv-py golden output (415 rows)", {
  html <- paste(readLines(file.path(fx, "l2m_listing_2025-26.html"), warn = FALSE), collapse = "\n")
  got <- hoopR:::.parse_nba_l2m_games(html, 2026)
  gold <- .read_gold("l2m_listing_2025-26_games.csv")

  expect_equal(nrow(got), 415)
  expect_equal(length(unique(got$game_id)), 415)
  expect_identical(names(got), names(gold))
  expect_identical(as.character(got$game_id), gold$game_id)
  expect_identical(as.character(got$season_type), gold$season_type)
  expect_identical(.blank_as_na(got$label), .blank_as_na(gold$label))
  expect_identical(got$game_id[1], "0042500405")
  expect_identical(got$season_type[1], "playoffs")
  expect_identical(got$label[1], "Knicks 94, Spurs 90")
})
