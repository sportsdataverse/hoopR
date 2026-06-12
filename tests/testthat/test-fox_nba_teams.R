test_that(".fox_bb_teams parses a standings payload into a team directory", {
  raw <- jsonlite::fromJSON(
    testthat::test_path("fixtures", "fox_nba_standings.json"),
    simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)
  df <- hoopR:::.fox_bb_teams(raw)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("fox_team_id", "fox_team_name", "fox_section") %in% names(df)))
  expect_gt(nrow(df), 0)
  expect_false(any(duplicated(df$fox_team_id)))
  expect_false(any(grepl("^[0-9]+$", df$fox_team_name)))
  expect_true(any(grepl(" ", df$fox_team_name)))
})

test_that("fox_nba_teams() returns a live directory", {
  skip_on_cran()
  if (Sys.getenv("FOX_TESTS") != "1") skip("FOX_TESTS not set")
  df <- fox_nba_teams()
  expect_s3_class(df, "hoopR_data")
  expect_gte(nrow(df), 30)
})
