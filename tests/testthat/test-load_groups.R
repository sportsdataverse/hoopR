test_that("group loaders read the mbb_groups / nba_groups release assets (offline)", {
  urls <- character()
  local_mocked_bindings(parquet_from_url = function(url) {
    urls <<- c(urls, url)
    data.table::data.table(league = "mbb", group_id = "mbb:sec")
  })

  x <- load_mbb_team_group_seasons(c(2024, 2025))
  expect_s3_class(x, "hoopR_data")
  expect_equal(nrow(x), 2L)
  expect_s3_class(load_nba_team_group_seasons(2005), "hoopR_data")
  for (f in c(load_mbb_groups, load_mbb_group_seasons, load_mbb_group_aliases,
              load_nba_groups, load_nba_group_seasons, load_nba_group_aliases)) {
    expect_s3_class(f(), "hoopR_data")
  }

  base <- "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/"
  expect_equal(urls, paste0(base, c(
    "mbb_groups/mbb_team_group_seasons_2024.parquet",
    "mbb_groups/mbb_team_group_seasons_2025.parquet",
    "nba_groups/nba_team_group_seasons_2005.parquet",
    "mbb_groups/mbb_groups.parquet",
    "mbb_groups/mbb_group_seasons.parquet",
    "mbb_groups/mbb_group_aliases.parquet",
    "nba_groups/nba_groups.parquet",
    "nba_groups/nba_group_seasons.parquet",
    "nba_groups/nba_group_aliases.parquet"
  )))

  urls <- character()
  load_nba_team_group_seasons(TRUE)
  expect_equal(basename(urls), "nba_team_group_seasons.parquet")
})

test_that("team_group_seasons loaders validate the seasons argument", {
  expect_error(load_mbb_team_group_seasons(2001))
  expect_error(load_nba_team_group_seasons(1970))
  expect_error(load_nba_team_group_seasons("2005"))
  expect_error(load_nba_team_group_seasons(2005.5))
})

test_that("group loaders return the published mbb_groups / nba_groups tables", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  x <- load_nba_team_group_seasons(c(2004, 2005))
  expect_gt(nrow(x), 0)

  expect_s3_class(x, "hoopR_data")
  expect_in(c("season", "team_id", "team_name", "conference_id", "division_id"), colnames(x))
  expect_type(x$team_id, "character")
  # The 2004-05 realignment moved Houston from the Midwest to the new Southwest.
  expect_equal(x$division_id[x$team_id == "10"][order(x$season[x$team_id == "10"])],
               c("nba:midwest", "nba:southwest"))

  m <- load_mbb_team_group_seasons(2025)
  if (nrow(m) == 0) skip("No rows returned at test time -- release may not exist yet")
  # Texas and Oklahoma joined the SEC for 2024-25.
  expect_setequal(m$conference_id[m$team_id %in% c("251", "201")], "mbb:sec")
  expect_in(unique(m$conference_id), load_mbb_groups()$group_id)
})
