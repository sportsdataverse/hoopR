skip_on_cran()

# Running-score rebuild in helper_espn_nba_pbp() / helper_espn_mbb_pbp(), the R
# mirror of sportsdataverse-py's _repair_running_score. Every payload is a real
# ESPN summary (provenance: fixtures/score_repair/README.md), and
# expected/<name>.csv is sportsdataverse-py's output on the same bytes. Two tests
# mutate a real payload in-test (a dropped header score, nulled per-play scores)
# to reach branches no committed game exercises; they say so where they do it.

fx <- testthat::test_path("fixtures", "score_repair")
.fixture <- function(name) file.path(fx, paste0(name, ".json.gz"))

# ESPN's own per-play scores, in the payload's array order.
.espn_scores <- function(path) {
  plays <- jsonlite::fromJSON(path, simplifyVector = FALSE)[["plays"]]
  pick <- function(key) {
    vapply(plays, function(p) if (is.null(p[[key]])) NA_integer_ else as.integer(p[[key]]), integer(1))
  }
  list(home = pick("homeScore"), away = pick("awayScore"))
}
.at <- function(got, seq) {
  i <- which(got$sequence_number == as.character(seq))
  c(got$home_score[[i]], got$away_score[[i]])
}
.last <- function(got) c(got$home_score[[nrow(got)]], got$away_score[[nrow(got)]])
.changed <- function(got, espn) sum(got$home_score != espn$home | got$away_score != espn$away, na.rm = TRUE)
.never_falls <- function(got) all(diff(got$home_score) >= 0) && all(diff(got$away_score) >= 0)
.mutated <- function(name, edit) {
  tf <- tempfile(fileext = ".json")
  payload <- edit(jsonlite::fromJSON(.fixture(name), simplifyVector = FALSE))
  jsonlite::write_json(payload, tf, auto_unbox = TRUE, null = "null", digits = NA)
  tf
}

test_that("home_score / away_score / score_source equal sportsdataverse-py row for row", {
  cases <- list(
    list(helper_espn_nba_pbp, c("nba_401766458", "nba_400829116", "nba_401704638", "summary_nba")),
    list(helper_espn_mbb_pbp, c("mbb_401829457", "summary_mbb", "mbb_401830342"))
  )
  for (case in cases) {
    for (name in case[[2]]) {
      got <- case[[1]](.fixture(name))
      want <- utils::read.csv(file.path(fx, "expected", paste0(name, ".csv")), stringsAsFactors = FALSE)
      expect_identical(names(got)[[ncol(got)]], "score_source", info = name)
      expect_identical(nrow(got), nrow(want), info = name)
      expect_identical(as.integer(got$sequence_number), want$sequence_number, info = name)
      expect_identical(got$home_score, want$home_score, info = name)
      expect_identical(got$away_score, want$away_score, info = name)
      expect_identical(got$score_source, want$score_source, info = name)
    }
  }
})

test_that("a late-keyed play re-bases every later row (NBA 401766458)", {
  got <- helper_espn_nba_pbp(.fixture("nba_401766458"))
  expect_identical(nrow(got), 496L)
  expect_identical(unique(got$score_source), "rebuilt")
  # array order: the late-keyed seq 738 sits before seq 658 and is never moved
  expect_identical(which(got$sequence_number == "738"), 439L)
  expect_identical(which(got$sequence_number == "658"), 440L)
  expect_identical(.at(got, 738), c(109L, 87L))
  expect_identical(.at(got, 658), c(109L, 87L)) # ESPN: 108-87
  expect_identical(.at(got, 659), c(109L, 87L))
  expect_identical(.at(got, 660), c(111L, 87L)) # ESPN: 110-87
  expect_identical(.last(got), c(120L, 95L)) # ESPN: 119-95; header final 120-95
  expect_identical(.changed(got, .espn_scores(.fixture("nba_401766458"))), 57L)
  expect_true(.never_falls(got))
})

test_that("made free throws shipped with scoreValue 0 count one (NBA 400829116, 2015-16)", {
  got <- helper_espn_nba_pbp(.fixture("nba_400829116"))
  ft <- got$scoring_play %in% TRUE & grepl("Free Throw", got$type_text)
  expect_gt(sum(ft), 0)
  expect_true(all(got$score_value[ft] == 0)) # the 2013-2019 feed shape
  espn <- .espn_scores(.fixture("nba_400829116"))
  expect_identical(unique(got$score_source), "rebuilt")
  expect_identical(.last(got), c(114L, 105L))
  expect_identical(c(espn$home[[length(espn$home)]], espn$away[[length(espn$away)]]), c(112L, 105L))
  expect_true(.never_falls(got))
})

test_that("the clean NBA fixture rebuilds its one dip (summary_nba = 401585607)", {
  got <- helper_espn_nba_pbp(.fixture("summary_nba"))
  espn <- .espn_scores(.fixture("summary_nba"))
  expect_identical(nrow(got), 450L)
  expect_identical(unique(got$score_source), "rebuilt")
  expect_identical(.changed(got, espn), 17L)
  expect_identical(c(espn$home[[91]], espn$away[[91]]), c(26L, 22L))
  expect_identical(.at(got, 128), c(26L, 24L))
  expect_identical(.last(got), c(111L, 96L))
  expect_true(.never_falls(got))
})

test_that("a rebuild that misses the final keeps every ESPN value (NBA 401704638)", {
  got <- helper_espn_nba_pbp(.fixture("nba_401704638"))
  espn <- .espn_scores(.fixture("nba_401704638"))
  expect_identical(nrow(got), 531L)
  expect_identical(unique(got$score_source), "espn")
  expect_identical(got$home_score, espn$home)
  expect_identical(got$away_score, espn$away)
  expect_identical(.last(got), c(104L, 140L)) # the scoring plays only sum to 104-139
})

test_that("no official final keeps ESPN's scores", {
  # In-test mutation of the real payload: a pre-tip live header carries no score.
  tf <- .mutated("nba_401766458", function(j) {
    j$header$competitions[[1]]$competitors[[1]]$score <- NULL
    j
  })
  got <- helper_espn_nba_pbp(tf)
  espn <- .espn_scores(tf)
  unlink(tf)
  expect_identical(unique(got$score_source), "espn")
  expect_identical(.changed(got, espn), 0L)
  expect_identical(.last(got), c(119L, 95L))
})

test_that("null ESPN scores are filled when the game is rebuilt", {
  # In-test mutation of the real payload: ten rows with no per-play home score.
  tf <- .mutated("nba_401766458", function(j) {
    for (i in 101:110) j$plays[[i]]["homeScore"] <- list(NULL)
    j
  })
  got <- helper_espn_nba_pbp(tf)
  espn <- .espn_scores(tf)
  unlink(tf)
  expect_identical(sum(is.na(espn$home)), 10L)
  expect_identical(unique(got$score_source), "rebuilt")
  expect_identical(sum(is.na(got$home_score)), 0L)
  expect_identical(.last(got), c(120L, 95L))
  expect_type(got$home_score, "integer")
  expect_type(got$score_source, "character")
})

test_that("MBB neutral site: scores follow the header sides (401829457)", {
  got <- helper_espn_mbb_pbp(.fixture("mbb_401829457"))
  espn <- .espn_scores(.fixture("mbb_401829457"))
  expect_identical(unique(got$home_team_id), 155L) # UND, header home, 58 points
  expect_identical(c(espn$home[[length(espn$home)]], espn$away[[length(espn$away)]]), c(75L, 58L))
  expect_identical(unique(got$score_source), "rebuilt")
  expect_identical(.last(got), c(58L, 75L))
  first <- got[got$scoring_play %in% TRUE, ][1, ]
  expect_identical(first$team_id, 155L)
  expect_identical(c(first$home_score, first$away_score), c(3L, 0L))
  expect_identical(.changed(got, espn), 533L)
  expect_true(.never_falls(got))
})

test_that("clean MBB feeds rebuild to ESPN's values exactly (halves, 2OT)", {
  for (case in list(list("summary_mbb", 294L, 2L, c(75L, 60L)), list("mbb_401830342", 426L, 4L, c(75L, 81L)))) {
    got <- helper_espn_mbb_pbp(.fixture(case[[1]]))
    expect_identical(nrow(got), case[[2]], info = case[[1]])
    expect_identical(max(got$period_number), case[[3]], info = case[[1]])
    expect_identical(unique(got$score_source), "rebuilt", info = case[[1]])
    expect_identical(.changed(got, .espn_scores(.fixture(case[[1]]))), 0L, info = case[[1]])
    expect_identical(.last(got), case[[4]], info = case[[1]])
  }
})
