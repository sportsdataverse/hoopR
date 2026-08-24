# Regression test: every load_* db-writing loader ran `dots <- rlang::dots_list(...)`
# but never forwarded `...` into DBI::dbWriteTable(), despite roxygen promising
# forwarded dots for the underlying write (`append = TRUE` was hardcoded with no
# way to pass e.g. row.names, overwrite, or a custom DBI field.types map).

test_that("load_nba_pbp forwards ... to DBI::dbWriteTable", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()
  skip_if_not_installed("RSQLite")

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  on.exit(DBI::dbDisconnect(con), add = TRUE)

  out <- load_nba_pbp(seasons = most_recent_nba_season(),
                       dbConnection = con, tablename = "nba_pbp",
                       row.names = TRUE)

  expect_null(out)
  # row.names = TRUE only reaches DBI::dbWriteTable() if `...` is forwarded;
  # a dropped `...` would write the table without a row_names column.
  expect_true("row_names" %in% DBI::dbListFields(con, "nba_pbp"))
})

test_that("load_mbb_pbp forwards ... to DBI::dbWriteTable", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()
  skip_if_not_installed("RSQLite")

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  on.exit(DBI::dbDisconnect(con), add = TRUE)

  out <- load_mbb_pbp(seasons = most_recent_mbb_season(),
                       dbConnection = con, tablename = "mbb_pbp",
                       row.names = TRUE)

  expect_null(out)
  expect_true("row_names" %in% DBI::dbListFields(con, "mbb_pbp"))
})
