skip_on_cran()

# Shot coordinates in helper_espn_nba_pbp() / helper_espn_mbb_pbp() on both
# payload shapes the data repos feed them:
# - a raw ESPN summary (fixtures/score_repair): ESPN's coordinates, which the
#   helper transforms and keeps as coordinate_{x,y}_raw;
# - sportsdataverse-py's processed json/final payload for the same game
#   (fixtures/espn_pbp_coordinates, provenance in its README). Since
#   sportsdataverse-py #844 its plays already carry the transformed pair next to
#   coordinate.x.raw / coordinate.y.raw, and the helper failed on it with dplyr's
#   "Names must be unique".

.raw <- function(name) testthat::test_path("fixtures", "score_repair", paste0(name, ".json.gz"))
.final <- function(name) {
  testthat::test_path("fixtures", "espn_pbp_coordinates", paste0(name, "_final.json.gz"))
}
.coords <- function(df) {
  df <- as.data.frame(df)[, c("sequence_number", "coordinate_x", "coordinate_y", "coordinate_x_raw", "coordinate_y_raw")]
  df$sequence_number <- as.numeric(df$sequence_number)
  df <- df[order(df$sequence_number), ]
  rownames(df) <- NULL
  df
}
cases <- list(
  list(fn = helper_espn_nba_pbp, game = "nba_401766458"),
  list(fn = helper_espn_mbb_pbp, game = "mbb_401830342")
)

test_that("a sportsdataverse-py processed payload keeps its coordinates", {
  for (case in cases) {
    got <- case$fn(.final(case$game))
    plays <- jsonlite::fromJSON(.final(case$game))[["plays"]]
    expect_identical(nrow(got), nrow(plays), info = case$game)
    expect_identical(got$coordinate_x, as.double(plays[["coordinate.x"]]), info = case$game)
    expect_identical(got$coordinate_y, as.double(plays[["coordinate.y"]]), info = case$game)
    expect_identical(got$coordinate_x_raw, as.double(plays[["coordinate.x.raw"]]), info = case$game)
    expect_identical(got$coordinate_y_raw, as.double(plays[["coordinate.y.raw"]]), info = case$game)
  }
})

test_that("the raw and the processed payload of one game give the same coordinates", {
  for (case in cases) {
    expect_identical(
      .coords(case$fn(.final(case$game))),
      .coords(case$fn(.raw(case$game))),
      info = case$game
    )
  }
})

test_that("free throws sit on the line in the transformed pair, in both leagues", {
  # NBA "Free Throw ..." types: both pairs pinned to (25, 13.75), as before
  nba <- helper_espn_nba_pbp(.raw("nba_401766458"))
  ft <- grepl("Free Throw", nba$type_text, fixed = TRUE)
  expect_identical(sum(ft), 61L)
  expect_true(all(nba$coordinate_x_raw[ft] == 25 & nba$coordinate_y_raw[ft] == 13.75))
  expect_true(all(abs(nba$coordinate_x[ft]) == 28 & nba$coordinate_y[ft] == 0))

  # MBB "MadeFreeThrow" (made or missed): the case-sensitive raw pin misses it,
  # so the raw pair keeps ESPN's (25, 0), but the transformed pair is on the line
  mbb <- helper_espn_mbb_pbp(.raw("mbb_401830342"))
  ft <- mbb$type_text == "MadeFreeThrow"
  expect_identical(sum(ft), 39L)
  expect_true(all(mbb$coordinate_x_raw[ft] == 25 & mbb$coordinate_y_raw[ft] == 0))
  expect_true(all(abs(mbb$coordinate_x[ft]) == 28 & mbb$coordinate_y[ft] == 0))
})
