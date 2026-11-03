test_that("alias loaders read the mbb_groups / nba_groups release assets (offline)", {
  urls <- character()
  local_mocked_bindings(parquet_from_url = function(url) {
    urls <<- c(urls, url)
    data.table::data.table(league = "mbb", team_id = "150")
  })

  for (f in c(load_mbb_team_aliases, load_mbb_player_aliases,
              load_nba_team_aliases, load_nba_player_aliases)) {
    x <- f()
    expect_s3_class(x, "hoopR_data")
    # a data.table class on a tibble breaks tail() (#88)
    expect_false(inherits(x, "data.table"))
  }

  base <- "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/"
  expect_equal(urls, paste0(base, c(
    "mbb_groups/mbb_team_aliases.parquet",
    "mbb_groups/mbb_player_aliases.parquet",
    "nba_groups/nba_team_aliases.parquet",
    "nba_groups/nba_player_aliases.parquet"
  )))
})

test_that("alias loaders return the published mbb_groups / nba_groups tables", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  t <- load_nba_team_aliases()
  expect_s3_class(t, "hoopR_data")
  expect_gt(nrow(t), 0)
  expect_in(c("team_id", "source", "source_id", "id_kind", "name_kind", "value",
              "valid_from", "valid_to", "match_method"), colnames(t))
  expect_type(t$team_id, "character")
  expect_type(t$source_id, "character")
  # NBA Stats team id 1610612737 is the Atlanta Hawks, ESPN team 1.
  expect_equal(unique(t$team_id[t$source == "nba_stats" & t$source_id == "1610612737"]), "1")

  p <- load_mbb_player_aliases()
  expect_s3_class(p, "hoopR_data")
  expect_gt(nrow(p), 0)
  expect_in(c("athlete_id", "source", "source_player_id", "team_id",
              "valid_from", "valid_to", "match_method", "match_confidence"), colnames(p))
  expect_type(p$athlete_id, "character")
  expect_in("ncaa", p$source)
})
