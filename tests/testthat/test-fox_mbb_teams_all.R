test_that("fox_mbb_teams_all() enumerates the full league", {
  skip_on_cran()
  if (Sys.getenv("FOX_TESTS") != "1") skip("FOX_TESTS not set")
  df <- fox_mbb_teams_all()
  expect_s3_class(df, "hoopR_data")
  expect_gt(nrow(df), 300)
  expect_false(any(duplicated(df$fox_team_id)))
})
