# Offline: capture the query params each wrapper hands to request_with_proxy().
capture_nba_params <- function(fn, ..., env = parent.frame()) {
  captured <- new.env()
  testthat::local_mocked_bindings(
    request_with_proxy = function(url, params = list(), ...) {
      captured$params <- params
      list(resultSets = list(
        name = "X", headers = list("A"), rowSet = list(matrix("1", 1, 1))
      ))
    },
    .package = "hoopR", .env = env
  )
  fn(...)
  captured$params
}

test_that("ptshot wrappers send ShotDistRange", {
  for (fn in list(nba_leaguedashplayerptshot, nba_leaguedashteamptshot)) {
    p <- capture_nba_params(fn, shot_dist_range = ">=10.0")
    expect_identical(p$ShotDistRange, ">=10.0")
    # Default is the empty "no filter" value nba_api and stats.nba.com use.
    expect_identical(capture_nba_params(fn)$ShotDistRange, "")
  }
})

test_that("hustle wrappers deprecate last_n_games and never send LastNGames", {
  withr::local_options(lifecycle_verbosity = "warning")
  fns <- list(
    nba_leaguehustlestatsplayer, nba_leaguehustlestatsplayerleaders,
    nba_leaguehustlestatsteam, nba_leaguehustlestatsteamleaders
  )
  for (fn in fns) {
    expect_no_warning(p <- capture_nba_params(fn))
    expect_false("LastNGames" %in% names(p))
    expect_warning(
      p <- capture_nba_params(fn, last_n_games = 5),
      class = "lifecycle_warning_deprecated"
    )
    expect_false("LastNGames" %in% names(p))
  }
})
