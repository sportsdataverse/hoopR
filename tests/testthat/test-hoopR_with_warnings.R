test_that(".hoopR_with_warnings() names the wrapper and keeps the result", {
  f <- function() {
    df <- data.frame()
    tryCatch(
      expr = .hoopR_with_warnings("my_wrapper", {
        x <- as.integer("not a number") # warns: NAs introduced by coercion
        df <- data.frame(x = x, y = 1L)
      }),
      error = function(e) NULL
    )
    df
  }
  expect_warning(out <- f(), class = "hoopR_warning", regexp = "my_wrapper\\(\\): .*coercion")
  expect_equal(nrow(out), 1L)
  expect_identical(out$y, 1L)
})

test_that("nested .hoopR_with_warnings() raises one warning, named by the inner wrapper", {
  w <- testthat::capture_warnings(
    .hoopR_with_warnings("outer", .hoopR_with_warnings("inner", warning("boom")))
  )
  expect_length(w, 1L)
  expect_match(w, "inner\\(\\): boom")
})

test_that(".hoopR_with_warnings() keeps return(), error handling, finally and the original class", {
  early <- function() {
    tryCatch(expr = .hoopR_with_warnings("early", {
      return("returned")
      "not reached"
    }), error = function(e) "error")
    "late"
  }
  expect_identical(early(), "returned")

  ran <- FALSE
  expect_warning(caught <- tryCatch(
    expr = .hoopR_with_warnings("caught", {
      warning("first")
      stop("then failed")
    }),
    error = function(e) conditionMessage(e),
    finally = ran <- TRUE
  ), class = "hoopR_warning")
  expect_identical(caught, "then failed")
  expect_true(ran)

  custom <- function() warning(warningCondition("deprecated thing", class = "my_deprecation"))
  expect_no_warning(suppressWarnings(.hoopR_with_warnings("cls", custom()), classes = "my_deprecation"))
})

test_that("a CBBD wrapper returns its rows when parsing warns", {
  # Before this fix cbbd_games() had a tryCatch(warning =) handler, which stopped
  # the parse at the first warning and returned an empty frame. clean_names()
  # warns here, ahead of the assignment, so the old pattern returns 0 rows.
  local_mocked_bindings(
    .cbbd_get = function(...) data.frame(id = 1L, homeTeam = "Duke", stringsAsFactors = FALSE)
  )
  local_mocked_bindings(
    clean_names = function(dat, ...) {
      warning("synthetic parse warning")
      names(dat) <- c("id", "home_team")
      dat
    },
    .package = "janitor"
  )
  expect_warning(out <- cbbd_games(season = 2024), class = "hoopR_warning",
                 regexp = "cbbd_games\\(\\): synthetic parse warning")
  expect_equal(nrow(out), 1L)
  expect_identical(out$home_team, "Duke")
})

test_that("a warning in an internal helper names the exported function the user called", {
  local_mocked_bindings(
    .espn_basketball_coach = function(...) .hoopR_with_warnings(".espn_basketball_coach", warning("boom"))
  )
  expect_warning(espn_nba_coach(coach_id = 1), class = "hoopR_warning", regexp = "espn_nba_coach(): boom", fixed = TRUE)
  expect_identical(.hoopR_user_fn(".no_exported_caller"), ".no_exported_caller")
})

test_that("a message with braces is not interpolated, and warn = 2 errors are caught", {
  expect_warning(.hoopR_with_warnings("f", warning("bad {json} {{ x")), regexp = "f(): bad {json} {{ x", fixed = TRUE)
  withr::local_options(warn = 2)
  expect_identical(
    tryCatch(.hoopR_with_warnings("f", {
      warning("w")
      "not reached"
    }), error = function(e) "caught"),
    "caught"
  )
})
