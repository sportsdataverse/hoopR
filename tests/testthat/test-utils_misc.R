test_that("clean_team_names_NCAA_merge() maps KenPom names to NCAA names", {
  out <- clean_team_names_NCAA_merge(data.frame(Team = c("Cal St. Fullerton", "Albany", "Duke")))
  expect_s3_class(out, "data.table")
  expect_identical(out$TeamName, c("CS Fullerton", "SUNY Albany", "Duke"))
})

# The @eval helpers run at document() time from the package root, reading R/ and
# data-raw/return_columns.csv; data-raw is not in the built tarball.
test_that(".returns_rd() and .family_index() render roxygen lines from the source tree", {
  root <- test_path("..", "..")
  skip_if_not(file.exists(file.path(root, "data-raw", "return_columns.csv")), "data-raw is not in the tarball")
  withr::local_dir(root)
  rc <- utils::read.csv("data-raw/return_columns.csv", colClasses = "character", na.strings = "")
  single <- rc$fn[is.na(rc$component)][1]
  listed <- rc$fn[!is.na(rc$component) & !grepl("^`", rc$component)][1]
  variant <- rc$fn[grepl("^`\\w+ = .*`$", rc$component)][1]
  for (fn in stats::na.omit(c(single, listed, variant))) {
    inline <- .returns_rd(fn)
    expect_match(inline[1], "^@return ")
    expect_true(any(grepl("tabular", inline, fixed = TRUE) | grepl("|", inline, fixed = TRUE)))
    pointer <- .returns_rd(fn, inline = FALSE, unit = "row", class = "tibble")
    expect_match(pointer[1], "^@return A (named list of )?tibble")
    expect_true(any(grepl("return_columns", pointer, fixed = TRUE)))
  }
  expect_error(.returns_rd("not_a_function_anywhere"), "no return_columns rows")
  expect_error(.returns_rd(single, class = "matrix"), "unknown class")
  idx <- .family_index("ESPN NBA Functions")
  expect_identical(idx[1], "@description")
  expect_true("* [espn_nba_pbp()]" %in% idx)
  expect_error(.family_index("No Such Family"), "no function carries")
})
