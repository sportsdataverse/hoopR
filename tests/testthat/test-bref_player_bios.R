test_that("BREF - Player Bios", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_player_bios(letter = "a")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player bios returned at test time")

  cols <- c("player", "player_id", "year_min", "year_max", "pos", "height",
            "weight", "birth_date", "letter")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_equal(unique(x$letter), "a")
  expect_true(all(grepl("^[a-z]", x$player_id)))  # bref id slugs

  Sys.sleep(5)
})

test_that("BREF - Injuries", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_injuries()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No BREF injuries returned at test time")

  cols <- c("player", "team_name", "note")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})
