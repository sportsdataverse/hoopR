context("ESPN - Get MBB rankings")



test_that("ESPN - Get MBB rankings", {
  skip_on_cran()
  x <- espn_mbb_rankings()

  cols <- c(
    'id', 'name', 'shortName', 'type',
    'headline', 'shortHeadline', 'current',
    'previous', 'points', 'firstPlaceVotes',
    'trend', 'recordSummary', 'team.id',
    'team.uid', 'team.location', 'team.name',
    'team.nickname', 'team.abbreviation',
    'team.color', 'team.logo',
    'occurrence.number', 'occurrence.type',
    'occurrence.last', 'occurrence.value',
    'occurrence.displayValue', 'season.year',
    'season.startDate', 'season.endDate',
    'season.displayName', 'season.type.type',
    'season.type.name', 'season.type.abbreviation',
    'firstOccurrence.type', 'firstOccurrence.value'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
