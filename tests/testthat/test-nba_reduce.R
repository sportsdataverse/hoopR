# Pure result-set reducers -- deterministic, no network, safe everywhere.

make_sets <- function() {
  list(
    PlayerStats = data.frame(GAME_ID = "1", PERSON_ID = c(1, 2), PTS = c(10, 20),
                             stringsAsFactors = FALSE),
    TeamStats   = data.frame(GAME_ID = "1", TEAM_ID = 99, PTS = 30,
                             stringsAsFactors = FALSE)
  )
}

test_that("nba_bind_sets row-binds and tags origin (tactic B)", {
  skip_on_cran()
  out <- nba_bind_sets(make_sets(), tag_column = "set")
  expect_s3_class(out, "tbl_df")
  expect_equal(nrow(out), 3)
  expect_equal(names(out)[1], "set")
  expect_setequal(unique(out$set), c("PlayerStats", "TeamStats"))
  expect_true(all(c("PERSON_ID", "TEAM_ID") %in% names(out)))
  expect_true(any(is.na(out$TEAM_ID)))                 # missing cols -> NA

  expect_error(nba_bind_sets(list()))
})

test_that("nba_join_sets widens on a shared key (tactic C)", {
  skip_on_cran()
  sets <- list(
    PlayerStats = data.frame(GAME_ID = "1", PERSON_ID = c(1, 2),
                             stringsAsFactors = FALSE),
    GameMeta    = data.frame(GAME_ID = "1", ARENA = "X", stringsAsFactors = FALSE)
  )
  out <- nba_join_sets(sets, join_key = "GAME_ID")
  expect_s3_class(out, "tbl_df")
  expect_equal(nrow(out), 2)                            # both players kept
  expect_true(all(c("PERSON_ID", "ARENA") %in% names(out)))
  expect_equal(unique(out$ARENA), "X")

  expect_error(nba_join_sets(sets, join_key = c("A", "B")))   # not length 1
  expect_error(nba_join_sets(sets, join_key = "NOPE"))        # missing key
})

test_that("nba_nest_sets nests non-key columns, preserving origin (tactic D)", {
  skip_on_cran()
  out <- nba_nest_sets(make_sets(), keep_cols = "GAME_ID", nest_col = ".sets")
  expect_s3_class(out, "tbl_df")
  expect_true(all(c("set_name", "GAME_ID", ".sets") %in% names(out)))
  expect_type(out$.sets, "list")
  expect_s3_class(out$.sets[[1]], "tbl_df")
  # one row per (set_name, GAME_ID)
  expect_equal(nrow(out), 2)
  expect_setequal(out$set_name, c("PlayerStats", "TeamStats"))

  expect_error(nba_nest_sets(make_sets(), keep_cols = "NOPE"))  # bad keep_cols
})
