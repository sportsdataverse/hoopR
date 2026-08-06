test_that("espn_basketball_player_core() reproduces the sdv-py oracle", {
  # Golden-master parity. The Python implementation
  # (sportsdataverse.nba.helper_nba_player_core, sdv-py 0.0.75) currently
  # produces the released player_core dataset; this R function is a port and
  # must reproduce it exactly. Fixtures + provenance:
  #   tests/testthat/fixtures/player_core/README.md
  #
  # The payloads are copied unmodified from hoopR-nba-raw, never hand-written
  # -- a hand-made payload is the failure mode this guards.
  fx <- testthat::test_path("fixtures", "player_core")

  # Column types are DECLARED, never inferred, and read with base R so the
  # test adds no dependency to the package (readr is not in Imports/Suggests;
  # using it fails R CMD check on a clean machine).
  #
  # Inference guesses wrong here in both directions: `date_of_birth`
  # ("1979-11-27T08:00Z") parses as a datetime and `jersey` ("98", "", "35") as
  # a number. The second is the dangerous one -- a numeric jersey silently
  # turns "007" into 7, so the oracle would drift from the released string
  # column while the test still passed.
  #
  # na.strings = "" ONLY. The default includes "NA", which would turn the
  # literal string "NA" into a missing value -- and ESPN uses "NA" as a real
  # value: the abbreviation of its "Not Available" position is the two
  # characters N,A. Empty cells, which is what genuine nulls serialise to,
  # still read as NA.
  int_cols <- c(
    "athlete_id", "age", "position_id", "college_id", "current_team_id",
    "experience_years", "status_id", "draft_year", "draft_round",
    "draft_selection"
  )
  all_cols <- c(
    "athlete_id", "guid", "uid", "slug", "type", "first_name", "last_name",
    "full_name", "display_name", "short_name", "height", "display_height",
    "weight", "display_weight", "age", "date_of_birth", "birth_city",
    "birth_state", "birth_country", "jersey", "position_id", "position_name",
    "position_abbreviation", "position_display_name", "college_id",
    "current_team_id", "headshot_href", "experience_years", "status_id",
    "status_name", "status_type", "draft_year", "draft_round",
    "draft_selection", "active"
  )
  col_classes <- vapply(all_cols, function(col) {
    if (col %in% int_cols) "integer"
    else if (col %in% c("height", "weight")) "numeric"
    else if (col == "active") "logical"
    else "character"
  }, character(1))

  expected <- utils::read.csv(
    file.path(fx, "expected_player_core.csv"),
    colClasses = col_classes,
    na.strings = "",
    check.names = FALSE
  )

  ids <- c(1000L, 1011L, 10L)
  actual <- purrr::map_dfr(ids, function(aid) {
    payload <- jsonlite::fromJSON(
      file.path(fx, paste0(aid, ".json")),
      simplifyVector = FALSE
    )
    espn_basketball_player_core(payload, athlete_id = aid)
  })

  expect_equal(nrow(actual), 3L)
  expect_equal(ncol(actual), 35L)
  # Column ORDER is part of the contract: both sides feed a released parquet
  # whose consumers select positionally in places.
  expect_equal(names(actual), names(expected))

  # Ids and categoricals must match exactly -- no tolerance. A tolerance on an
  # id is how "123" and "123.0" pass as equal.
  exact_cols <- setdiff(names(expected), c("height", "weight"))
  for (col in exact_cols) {
    expect_equal(
      actual[[col]], expected[[col]],
      info = paste0("column mismatch: ", col)
    )
  }

  # height/weight are the only floats. Tolerance is 1e-9 rather than 0 because
  # the values round-trip through CSV text; they are ESPN integers-as-doubles
  # in practice, so any real divergence is far larger than this.
  for (col in c("height", "weight")) {
    expect_equal(
      actual[[col]], expected[[col]],
      tolerance = 1e-9,
      info = paste0("float column mismatch: ", col)
    )
  }
})

test_that("espn_basketball_player_core() covers the branches the fixtures encode", {
  fx <- testthat::test_path("fixtures", "player_core")
  read_one <- function(aid) {
    espn_basketball_player_core(
      jsonlite::fromJSON(file.path(fx, paste0(aid, ".json")), simplifyVector = FALSE),
      athlete_id = aid
    )
  }

  # 1011 has no college node: college_id must be NA, not 0 and not an error.
  expect_true(is.na(read_one(1011L)$college_id))
  # 10 has a college but no draft: all three draft columns NA together.
  no_draft <- read_one(10L)
  expect_true(all(is.na(c(no_draft$draft_year, no_draft$draft_round, no_draft$draft_selection))))
  expect_false(is.na(no_draft$college_id))
  # 1000 is the fully-populated path.
  full <- read_one(1000L)
  expect_false(is.na(full$college_id))
  expect_false(is.na(full$draft_year))
})

test_that("espn_basketball_player_core() applies both documented fallbacks", {
  # Neither fallback is reachable from the fixtures: all three real athletes
  # carry displayName, and all three nest birthPlace$country. Mutation-testing
  # the port proved it -- deleting the displayName->fullName fallback left the
  # golden-master test at 54/54 green. These assertions are what make the
  # fallbacks load-bearing rather than decorative.

  # displayName absent -> fall back to fullName.
  out <- espn_basketball_player_core(
    list(fullName = "Jane Doe"), athlete_id = 1L
  )
  expect_equal(out$display_name, "Jane Doe")
  # ...and when present it wins.
  out2 <- espn_basketball_player_core(
    list(fullName = "Jane Doe", displayName = "J. Doe"), athlete_id = 1L
  )
  expect_equal(out2$display_name, "J. Doe")

  # birth_country: college payloads carry a TOP-LEVEL birthCountry, pro
  # payloads nest it under birthPlace.
  nested <- espn_basketball_player_core(
    list(birthPlace = list(country = "USA")), athlete_id = 1L
  )
  expect_equal(nested$birth_country, "USA")
  top <- espn_basketball_player_core(
    list(birthCountry = "Canada"), athlete_id = 1L
  )
  expect_equal(top$birth_country, "Canada")
  # nested wins when both are present
  both <- espn_basketball_player_core(
    list(birthPlace = list(country = "USA"), birthCountry = "Canada"),
    athlete_id = 1L
  )
  expect_equal(both$birth_country, "USA")
})

test_that("espn_basketball_player_core() returns a stable empty schema", {
  # No payload in the 2,577-file tree is sparse enough to fixture, so the
  # empty/non-dict path is asserted directly. A caller chaining onto this must
  # see the documented column set rather than a zero-column tibble.
  for (empty in list(list(), NULL, "not a payload")) {
    out <- espn_basketball_player_core(empty, athlete_id = 1L)
    expect_s3_class(out, "tbl_df")
    expect_equal(nrow(out), 0L)
  }
})

test_that("espn_basketball_player_core() parses $ref ids without fetching", {
  # The ids live in the core-v2 $ref URL. Parsing is required; fetching would
  # make a compile stage hit the network and would break the one-way
  # raw -> data boundary.
  payload <- list(
    id = "7",
    college = list(`$ref` = "http://sports.core.api.espn.com/v2/colleges/153?lang=en"),
    team = list(`$ref` = "http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/2025/teams/22?lang=en")
  )
  out <- espn_basketball_player_core(payload, athlete_id = 7L)
  expect_equal(out$college_id, 153L)
  expect_equal(out$current_team_id, 22L)

  # A $ref with no /colleges/ or /teams/ segment yields NA, not a wrong id.
  bare <- espn_basketball_player_core(
    list(college = list(`$ref` = "http://example.com/v2/something/9")),
    athlete_id = 7L
  )
  expect_true(is.na(bare$college_id))
})

test_that("espn_basketball_player_core() keeps athlete_id an integer join key", {
  # athlete_id joins to player_box / player_season_stats. A float-origin id
  # stringifies as "123.0" and joins to nothing -- the recurring port bug.
  out <- espn_basketball_player_core(list(guid = "g"), athlete_id = "1966")
  expect_equal(out$athlete_id, 1966L)
  expect_false(is.character(out$athlete_id))
})
