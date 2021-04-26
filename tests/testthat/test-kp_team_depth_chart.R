context("KP - Get team depth chart")



test_that("KP - Get team depth chart", {
  skip_on_cran()
  x <- kp_team_depth_chart(team = 'Florida St.', year= 2020)
  cols <- c(
    'PG.Number', 'PG.PlayerFirstName',
    'PG.PlayerLastName', 'PG.Hgt', 'PG.Wgt',
    'PG.Yr', 'PG.Min.Pct', 'SG.Number',
    'SG.PlayerFirstName', 'SG.PlayerLastName',
    'SG.Hgt', 'SG.Wgt', 'SG.Yr', 'SG.Min.Pct',
    'SF.Number', 'SF.PlayerFirstName',
    'SF.PlayerLastName', 'SF.Hgt', 'SF.Wgt',
    'SF.Yr', 'SF.Min.Pct', 'PF.Number',
    'PF.PlayerFirstName', 'PF.PlayerLastName',
    'PF.Hgt', 'PF.Wgt', 'PF.Yr',
    'PF.Min.Pct', 'C.Number', 'C.PlayerFirstName', 'C.PlayerLastName', 'C.Hgt',
    'C.Wgt', 'C.Yr', 'C.Min.Pct', 'Team', 'Year'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
