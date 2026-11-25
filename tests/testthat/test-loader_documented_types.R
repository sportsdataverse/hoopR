# A release file stores a column no row fills as all-NA logical, or as arrow's
# vctrs_unspecified, so the column's class changed from season to season (the
# draft combine's retired measures are integer in 2019, logical from 2023 on).
# The loaders give every all-NA column the type return_columns documents.

unspecified <- function(n) structure(rep(NA, n), class = "vctrs_unspecified")

test_that("the NCAA MBB shots and lineups loaders return empty columns as their documented type", {
  local_mocked_bindings(rds_from_url = function(url) {
    if (grepl("ncaa_mbb_shots", url, fixed = TRUE)) {
      data.table::data.table(contest_id = c("1", "2"), shot_x = c(10.5, 20), shot_zone = NA,
                             period = unspecified(2), sec_left = unspecified(2),
                             point_value = NA, espn_game_id = NA)
    } else {
      data.table::data.table(lineup_key = c("a", "b"), poss = c(3L, 4L), plus_minus = NA,
                             player_count_error = unspecified(2))
    }
  })
  shots <- load_ncaa_mbb_shots(seasons = 2025)
  expect_identical(vapply(shots, function(v) class(v)[1], ""),
                   c(contest_id = "character", shot_x = "numeric", shot_zone = "character",
                     period = "integer", sec_left = "numeric", point_value = "integer",
                     espn_game_id = "integer"))
  lineups <- load_ncaa_mbb_lineups(seasons = 2025)
  expect_identical(vapply(lineups, function(v) class(v)[1], ""),
                   c(lineup_key = "character", poss = "integer", plus_minus = "integer",
                     player_count_error = "logical"))
  # two seasons whose empty columns differ in class still bind
  both <- load_ncaa_mbb_shots(seasons = c(2024, 2025))
  expect_equal(nrow(both), 4L)
  expect_type(both$period, "integer")
})

test_that("the draft-combine loaders give a retired measure the same type every season", {
  local_mocked_bindings(
    .release_asset_exists = function(url) TRUE,
    parquet_from_url = function(url) {
      retired <- !grepl("_2020[.]parquet$", url) # the 2019 combine still measured them
      v <- function(x) if (retired) rep(NA, 2) else x
      if (grepl("draftcombinedrillresults", url, fixed = TRUE)) {
        data.table::data.table(player_id = c(1L, 2L), bench_press = v(c(10L, 12L)),
                               lane_agility_time = c(10.9, 11.2))
      } else {
        data.table::data.table(player_id = c(1L, 2L),
                               fifteen_corner_left_made = v(c(3L, 4L)),
                               fifteen_corner_left_attempt = v(c(5L, 5L)),
                               fifteen_corner_left_pct = v(c(0.6, 0.8)))
      }
    }
  )
  for (s in c(2019, 2023, 2025)) {
    drills <- load_nba_stats_draft_combine_drills(seasons = s)
    expect_type(drills$bench_press, "integer")
    spot <- load_nba_stats_draft_combine_spot_shooting(seasons = s)
    expect_type(spot$fifteen_corner_left_made, "integer")
    expect_type(spot$fifteen_corner_left_attempt, "integer")
    expect_type(spot$fifteen_corner_left_pct, "double")
  }
  expect_identical(load_nba_stats_draft_combine_drills(seasons = 2019)$bench_press, c(10L, 12L))
})

test_that(".na_cols_as_documented() covers dates and leaves filled columns alone", {
  rc <- hoopR::return_columns
  date_col <- rc[rc$fn == "load_nba_stats_injury_report" & rc$type == "Date" & is.na(rc$component), ]
  skip_if(nrow(date_col) == 0, "no documented Date column to test with")
  k <- date_col$col_name[[1]]
  df <- data.table::data.table(a = c(NA, NA))
  names(df) <- k
  out <- .na_cols_as_documented(df, "load_nba_stats_injury_report")
  expect_s3_class(out[[k]], "Date")
  filled <- data.table::data.table(x = c("2025-01-01", NA))
  names(filled) <- k
  expect_identical(.na_cols_as_documented(filled, "load_nba_stats_injury_report")[[k]], c("2025-01-01", NA))
  expect_identical(.na_cols_as_documented(df, "no_such_function"), df)
})
