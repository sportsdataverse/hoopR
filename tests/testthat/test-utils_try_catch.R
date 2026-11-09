test_that(".try_catch() keeps the result when a warning is raised mid-expression", {
  seen <- NULL
  out <- NULL
  .try_catch(
    expr = {
      warning("row names were found from a short variable")
      out <- "parsed"
    },
    error = function(e) stop("unexpected"),
    warning = function(w) seen <<- conditionMessage(w)
  )
  expect_identical(out, "parsed")
  expect_match(seen, "row names")
  # A handler-less (or empty) warning arm drops the warning silently.
  expect_no_warning(.try_catch(warning("x"), warning = function(w) {}))
})

test_that(".try_catch() still catches errors, runs finally, and lets return() exit the caller", {
  ran <- FALSE
  expect_identical(.try_catch(stop("boom"), error = function(e) "caught", finally = ran <- TRUE), "caught")
  expect_true(ran)
  f <- function() {
    .try_catch(expr = return("early"), error = function(e) NULL)
    "late"
  }
  expect_identical(f(), "early")
})
