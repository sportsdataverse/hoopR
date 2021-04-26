context("KP - Get team lineups")



test_that("KP - Get team lineups", {
  skip_on_cran()
  x <- kp_team_lineups(team = 'Florida St.', year= 2020)

  cols <- c(
    'Year', 'Team', 'Min.Pct', 'PG.Number',
    'PG.PlayerFirstName', 'PG.PlayerLastName',
    'PG.Hgt', 'PG.Wgt', 'PG.Yr', 'SG.Number',
    'SG.PlayerFirstName', 'SG.PlayerLastName',
    'SG.Hgt', 'SG.Wgt', 'SG.Yr', 'SF.Number',
    'SF.PlayerFirstName', 'SF.PlayerLastName',
    'SF.Hgt', 'SF.Wgt', 'SF.Yr', 'PF.Number',
    'PF.PlayerFirstName', 'PF.PlayerLastName',
    'PF.Hgt', 'PF.Wgt', 'PF.Yr', 'C.Number',
    'C.PlayerFirstName',
    'C.PlayerLastName', 'C.Hgt', 'C.Wgt', 'C.Yr'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
