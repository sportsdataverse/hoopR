fx <- testthat::test_path("fixtures", "official_nba")
.read_gold <- function(name) {
  utils::read.csv(file.path(fx, name), colClasses = "character", na.strings = "", check.names = FALSE)
}
# Parity convention (Task 7-R spec): compare as character with NA == "".
.blank_as_na <- function(v) {
  v <- as.character(v)
  v[!is.na(v) & v == ""] <- NA_character_
  v
}
# Compare every column two golden-backed frames share, as character with "" == NA
# (finding 9c: goldens must be compared column-complete, not a hand-picked subset).
# Numeric-typed `got` columns compare numerically (the gold CSV round-trips a
# Python float column as "114.0"; R's integer/double columns print "114" --
# a formatting difference, not a data difference).
.expect_matches_gold <- function(got, gold) {
  testthat::expect_identical(names(got), names(gold))
  testthat::expect_equal(nrow(got), nrow(gold))
  for (col in names(gold)) {
    if (is.numeric(got[[col]])) {
      testthat::expect_equal(as.numeric(got[[col]]), suppressWarnings(as.numeric(gold[[col]])), info = col)
    } else {
      testthat::expect_identical(.blank_as_na(got[[col]]), .blank_as_na(gold[[col]]), info = col)
    }
  }
}
