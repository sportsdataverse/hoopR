test_that("KP - Get team depth chart", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_team_depth_chart(team = "Florida St.", year = 2020)
  cols <- c(
    "pg_number",
    "pg_player_first_name",
    "pg_player_last_name",
    "pg_hgt",
    "pg_wgt",
    "pg_yr",
    "pg_min_pct",
    "sg_number",
    "sg_player_first_name",
    "sg_player_last_name",
    "sg_hgt",
    "sg_wgt",
    "sg_yr",
    "sg_min_pct",
    "sf_number",
    "sf_player_first_name",
    "sf_player_last_name",
    "sf_hgt",
    "sf_wgt",
    "sf_yr",
    "sf_min_pct",
    "pf_number",
    "pf_player_first_name",
    "pf_player_last_name",
    "pf_hgt",
    "pf_wgt",
    "pf_yr",
    "pf_min_pct",
    "c_number",
    "c_player_first_name",
    "c_player_last_name",
    "c_hgt",
    "c_wgt",
    "c_yr",
    "c_min_pct",
    "team",
    "year"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
