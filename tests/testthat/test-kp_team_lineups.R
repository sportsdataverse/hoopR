test_that("KP - Get team lineups", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_team_lineups(team = "Florida St.", year= 2020)

  cols <- c(
    "year", "team", "min_pct", "pg_number", "pg_player_first_name",
    "pg_player_last_name", "pg_hgt", "pg_wgt", "pg_yr", "sg_number", "sg_player_first_name",
    "sg_player_last_name", "sg_hgt", "sg_wgt", "sg_yr", "sf_number", "sf_player_first_name",
    "sf_player_last_name", "sf_hgt", "sf_wgt", "sf_yr", "pf_number", "pf_player_first_name",
    "pf_player_last_name", "pf_hgt", "pf_wgt", "pf_yr", "c_number",
    "c_player_first_name", "c_player_last_name", "c_hgt", "c_wgt", "c_yr"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
