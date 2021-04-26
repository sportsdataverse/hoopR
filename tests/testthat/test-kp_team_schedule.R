context("KP - Get team schedule")



test_that("KP - Get team schedule", {
  skip_on_cran()
  x <- kp_team_schedule(team = 'Florida St.', year= 2020)

  cols <- c(
    'Team.Rk', 'Team', 'Opponent.Rk',
    'Opponent', 'Result', 'Poss', 'OT',
    'PreWP', 'Location', 'W', 'L',
    'W.Conference', 'L.Conference',
    'ConferenceGame', 'Postseason',
    'Year', 'Day.Date', 'GameDate',
    'W.Proj', 'L.Proj', 'W.ConferenceProj',
    'L.ConferenceProj',
    'Date', 'GameId', 'TiersOfJoy')

  expect_equal(colnames(x), cols)
  expect_s3_class(x,'data.frame')
})
