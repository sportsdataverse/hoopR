test_that("ESPN - Get NBA teams", {
  skip_on_cran()
  x <- espn_nba_teams()

  cols <- c(
    'team_id',
    'abbreviation',
    'display_name',
    'short_name',
    'mascot',
    'team',
    'color',
    'alternate_color',
    'logo',
    'logo_dark',
    'logos_href_3',
    'logos_href_4'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
