# spotrac.com's cap table (recorded 2026-11-24 for the 2026-27 season) carries
# two advertisement rows inside its body and appends each allocation's share of
# the cap to the amount ("$108,246,871 (68.5%)"), which used to parse as one
# number (10824687168.5).

test_that("spotrac_team_cap() returns one row per team plus the league average", {
  skip_on_cran()
  local_http_fixtures()
  x <- suppressMessages(spotrac_team_cap(season = 2027))
  expect_s3_class(x, "hoopR_data")
  expect_equal(nrow(x), 31L)
  teams <- x[x$rank != "League Average", ]
  expect_equal(nrow(teams), 30L)
  expect_equal(teams$rank, as.character(1:30))
  expect_equal(x$team[[31]], "League")
  expect_false(anyNA(teams$team))
})

test_that("spotrac_team_cap() reads an amount without its percentage of the cap", {
  skip_on_cran()
  local_http_fixtures()
  x <- suppressMessages(spotrac_team_cap(season = 2027))
  mem <- x[x$team == "Grizzlies", ]
  expect_equal(mem$total_cap, 158112011)
  expect_equal(mem$active_cap, 108246871)
  expect_equal(mem$dead_cap, 3700000)
  expect_equal(mem$cap_holds, 46165140)
  expect_equal(mem$top_3, 63855630)
  expect_equal(mem$cap_space, 17887989)
  # a team's allocations add up to its total cap ("-" is no dead cap)
  teams <- x[x$rank != "League Average", ]
  dead <- ifelse(is.na(teams$dead_cap), 0, teams$dead_cap)
  expect_equal(teams$active_cap + dead + teams$cap_holds, teams$total_cap)
  expect_true(all(teams$top_3 <= teams$total_cap))
})
