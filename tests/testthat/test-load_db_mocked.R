# Offline: the play-by-play database builders with the release loaders mocked, so
# the build / purge / rebuild / missing-games paths run on an in-memory SQLite db.

local_db <- function(env = parent.frame()) {
  skip_if_not_installed("DBI")
  skip_if_not_installed("RSQLite")
  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  withr::defer(DBI::dbDisconnect(con), envir = env)
  con
}

# A games index (one game not yet in the db) and a pbp loader that writes the
# requested seasons' games to the table, as load_*_pbp(dbConnection =) does.
mock_pbp_loaders <- function(games_fn, pbp_fn, first, env = parent.frame()) {
  games <- data.frame(season = c(first, first, first + 1L), game_id = c(1L, 2L, 3L))
  pbp <- function(seasons, dbConnection, tablename, ...) {
    rows <- games[games$season %in% seasons & games$game_id != 3L, ]
    DBI::dbWriteTable(dbConnection, tablename, rows, append = TRUE)
    invisible(NULL)
  }
  args <- list(function(...) games, pbp)
  names(args) <- c(games_fn, pbp_fn)
  do.call(testthat::local_mocked_bindings, c(args, list(.package = "hoopR", .env = env)))
  games
}

test_that("update_mbb_db() builds, then rebuilds whole or by season, and finds missing games", {
  skip_on_cran()
  con <- local_db()
  mock_pbp_loaders("load_mbb_games", "load_mbb_pbp", 2024L)
  tbl <- "hoopR_mbb_pbp"
  expect_true(suppressMessages(update_mbb_db(db_connection = con, tblname = tbl)))
  expect_setequal(DBI::dbReadTable(con, tbl)$game_id, c(1L, 2L))
  suppressMessages(update_mbb_db(db_connection = con, tblname = tbl, force_rebuild = TRUE))
  expect_setequal(DBI::dbReadTable(con, tbl)$game_id, c(1L, 2L))
  suppressMessages(update_mbb_db(db_connection = con, tblname = tbl, force_rebuild = 2024))
  expect_setequal(DBI::dbReadTable(con, tbl)$game_id, c(1L, 2L))
  expect_error(update_mbb_db(db_connection = con, force_rebuild = "NEW"), "internal")
  expect_error(update_mbb_db(db_connection = con, force_rebuild = "x"), "either logical")
  expect_identical(suppressMessages(get_missing_mbb_games(1:3, con, tbl)), 3L)
  # an unknown season is reported, nothing is loaded
  expect_null(suppressMessages(build_mbb_db(tbl, con, rebuild = 1990)))
})

test_that("update_nba_db() builds, then rebuilds whole or by season, and finds missing games", {
  skip_on_cran()
  con <- local_db()
  mock_pbp_loaders("load_nba_games", "load_nba_pbp", 2024L)
  tbl <- "hoopR_nba_pbp"
  expect_true(suppressMessages(update_nba_db(db_connection = con, tblname = tbl)))
  expect_setequal(DBI::dbReadTable(con, tbl)$game_id, c(1L, 2L))
  suppressMessages(update_nba_db(db_connection = con, tblname = tbl, force_rebuild = TRUE))
  suppressMessages(update_nba_db(db_connection = con, tblname = tbl, force_rebuild = 2024))
  expect_setequal(DBI::dbReadTable(con, tbl)$game_id, c(1L, 2L))
  expect_error(update_nba_db(db_connection = con, force_rebuild = "NEW"), "internal")
  expect_error(update_nba_db(db_connection = con, force_rebuild = "x"), "either logical")
  expect_identical(suppressMessages(get_missing_nba_games(1:3, con, tbl)), 3L)
  expect_null(suppressMessages(build_nba_db(tbl, con, rebuild = 1990)))
})

test_that("update_nba_stats_db() writes each dataset and reports a failing one", {
  skip_on_cran()
  con <- local_db()
  local_mocked_bindings(
    load_nba_stats_coaches = function(seasons, dbConnection, tablename, ...) {
      DBI::dbWriteTable(dbConnection, tablename, data.frame(coach_id = 1:2), append = TRUE)
    },
    load_nba_stats_draft = function(...) stop("release asset missing")
  )
  expect_true(suppressMessages(update_nba_stats_db(datasets = c("coaches", "draft"), db_connection = con)))
  expect_true(DBI::dbExistsTable(con, "nba_stats_coaches"))
  expect_false(DBI::dbExistsTable(con, "nba_stats_draft"))
})
