# A wrapper's tryCatch() error handler must name the cause of a failure, not
# only "no data available": a 429, a 403 and a parse bug otherwise read like an
# empty result. Every request is made to fail offline (httr2::req_perform(),
# and the chromote page fetch behind realgm_*()), and every wrapper -- every
# function that runs its body through .hoopR_with_warnings() -- must pass that
# cause on without the error escaping.

# Functions this setup cannot exercise, with why.
.handler_cause_skip <- c(
  .espn_basketball_athlete_career_stats = "a failed request falls back to an empty result inside the body",
  .espn_basketball_event_propbets = "a failed request falls back to an empty result inside the body",
  .espn_basketball_season_groups = "a failed request falls back to an empty result inside the body",
  .espn_basketball_season_leaders = "a failed request falls back to an empty result inside the body",
  .espn_basketball_season_weeks = "a failed request falls back to an empty result inside the body",
  .espn_basketball_team_record = "a failed request falls back to an empty result inside the body",
  hoopshype_salaries = "a failed request falls back to an empty result inside the body",
  nba_playerheadshot = "builds a URL; makes no request",
  ncaa_mbb_NET_rankings = "reads the page with xml2::read_html(url), outside the httr2 layer"
)

# Values for formals that have no default; any other such formal gets "1".
.handler_cause_args <- list(
  league = "nba", season = most_recent_nba_season(), seasons = 2024L, game_id = 401585183L,
  min_year = 2023L, max_year = 2024L,
  season_dates = "20240115", group = "50", path = "/x", description = "x", args = list()
)

.handler_cause_fns <- function(ns) {
  # Selected by shape, not by whether the handler already reports the cause,
  # so a handler that loses conditionMessage() fails instead of dropping out.
  # Defunct wrappers stop in lifecycle::deprecate_stop() before any request.
  is_wrapper <- function(nm) {
    f <- get(nm, envir = ns)
    if (!is.function(f) || is.primitive(f)) return(FALSE)
    b <- paste(deparse(body(f)), collapse = "\n")
    grepl(".hoopR_with_warnings(", b, fixed = TRUE) && !grepl("deprecate_stop", b, fixed = TRUE)
  }
  Filter(is_wrapper, ls(ns, all.names = TRUE))
}

.handler_cause_call_args <- function(f) {
  fm <- formals(f)
  req <- names(fm)[vapply(fm, function(x) identical(x, quote(expr = )), logical(1))]
  req <- setdiff(req, "...")
  args <- lapply(req, function(a) if (a %in% names(.handler_cause_args)) .handler_cause_args[[a]] else "1")
  stats::setNames(args, req)
}

# TRUE when `x` (a function body) contains tryCatch(..., warning = ...).
.has_trycatch_warning <- function(x) {
  if (!is.call(x)) return(FALSE)
  f <- x[[1]]
  if (is.call(f) && as.character(f[[1]]) %in% c("::", ":::")) f <- f[[3]]
  if (identical(f, as.name("tryCatch")) && "warning" %in% names(x)) return(TRUE)
  for (el in as.list(x)[-1]) {
    if (!missing(el) && .has_trycatch_warning(el)) return(TRUE)
  }
  FALSE
}

test_that("no hoopR function gives tryCatch() a warning = handler", {
  # tryCatch(warning =) unwinds at the first warning and returns the empty or
  # half-built default; run the body through .hoopR_with_warnings() instead.
  ns <- asNamespace("hoopR")
  bad <- Filter(function(nm) {
    f <- get(nm, envir = ns)
    is.function(f) && !is.primitive(f) && .has_trycatch_warning(body(f))
  }, ls(ns, all.names = TRUE))
  expect_identical(bad, character())
  expect_true(.has_trycatch_warning(quote({ x <- tryCatch(1, warning = function(w) NULL) })))
})


test_that("error handlers report the cause of a failed request", {
  ns <- asNamespace("hoopR")
  fns <- .handler_cause_fns(ns)
  expect_true(all(names(.handler_cause_skip) %in% fns))
  fns <- setdiff(fns, names(.handler_cause_skip))
  expect_gt(length(fns), 350L)

  withr::local_envvar(CBBD_API_KEY = "test-key", KP_USER = "user@example.com", KP_PW = "pw")
  outage <- function(...) stop("mock outage")
  local_mocked_bindings(req_perform = outage, .package = "httr2")
  local_mocked_bindings(.realgm_html = outage)

  silent <- character()
  escaped <- character()
  for (nm in fns) {
    f <- get(nm, envir = ns)
    msgs <- character()
    withCallingHandlers(
      tryCatch(do.call(f, .handler_cause_call_args(f)), error = function(e) {
        escaped <<- c(escaped, paste0(nm, ": ", conditionMessage(e)))
      }),
      message = function(m) {
        msgs <<- c(msgs, conditionMessage(m))
        invokeRestart("muffleMessage")
      },
      warning = function(w) invokeRestart("muffleWarning")
    )
    if (!any(grepl("mock outage", msgs, fixed = TRUE))) silent <- c(silent, nm)
  }
  expect(length(escaped) == 0L, paste(c("errors escaped:", escaped), collapse = "\n"))
  silent <- setdiff(silent, sub(":.*", "", escaped))
  expect(length(silent) == 0L, paste(c("cause not reported:", silent), collapse = "\n"))
})
