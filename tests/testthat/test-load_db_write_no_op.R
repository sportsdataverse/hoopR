# Regression tests for #80-style loaders (mirrors wehoop #80): load_nba_team_box()
# and load_mbb_rosters() (among 16 total) documented a dbConnection/tablename
# write via DBI::dbWriteTable() but never issued the call -- passing a db
# connection silently did nothing and still returned the in-memory data. These
# confirm the write now happens against an in-memory RSQLite database.

test_that("load_nba_team_box writes into the db when dbConnection/tablename are supplied", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()
  skip_if_not_installed("RSQLite")

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  on.exit(DBI::dbDisconnect(con), add = TRUE)

  out <- load_nba_team_box(seasons = most_recent_nba_season(),
                            dbConnection = con, tablename = "nba_team_box")

  expect_null(out)
  expect_true(DBI::dbExistsTable(con, "nba_team_box"))
  tbl <- DBI::dbReadTable(con, "nba_team_box")
  expect_gt(nrow(tbl), 0)
  expect_true(all(c("game_id", "team_id", "season") %in% colnames(tbl)))
})

test_that("load_mbb_rosters writes into the db when dbConnection/tablename are supplied", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()
  skip_if_not_installed("RSQLite")

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  on.exit(DBI::dbDisconnect(con), add = TRUE)

  out <- load_mbb_rosters(seasons = most_recent_mbb_season(),
                           dbConnection = con, tablename = "mbb_rosters")

  expect_null(out)
  expect_true(DBI::dbExistsTable(con, "mbb_rosters"))
  tbl <- DBI::dbReadTable(con, "mbb_rosters")
  expect_gt(nrow(tbl), 0)
})
