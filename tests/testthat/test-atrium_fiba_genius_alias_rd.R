# Every minted competition alias (atrium, fiba, genius) is named in its competition Rd's
# \value with a link to the base wrapper, whose columns are in return_columns.

alias_rd_routes <- function() {
  ns <- asNamespace("hoopR")
  reg <- ns$.intl_basketball_competitions
  routes <- list()
  add <- function(prefix, suffix, base) {
    routes[[length(routes) + 1L]] <<- list(topic = paste0(prefix, "_competition"),
                                           alias = paste0(prefix, "_", suffix), base = base)
  }
  for (e in reg$atrium) for (s in names(ns$.atrium_alias_specs)) add(e$prefix, s, ns$.atrium_alias_specs[[s]]$base)
  for (e in reg$fiba) for (s in ns$.FIBA_ALIASES) add(e$prefix, s$suffix, s$base)
  for (e in reg$genius) {
    add(e$prefix, "competitions", "genius_competitions")
    add(e$prefix, "schedule", "genius_schedule")
    for (s in names(ns$.GENIUS_ALIAS_GAMES)) add(e$prefix, s, ns$.GENIUS_ALIAS_GAMES[[s]])
  }
  routes
}

# The parsed Rd of `topic`: the source man/ under devtools::test(), the installed Rd db otherwise.
alias_rd_parse <- local({
  root <- testthat::test_path("..", "..")
  db <- NULL
  function(topic) {
    file <- file.path(root, "man", paste0(topic, ".Rd"))
    if (file.exists(file)) return(tools::parse_Rd(file))
    if (is.null(db)) db <<- tools::Rd_db("hoopR")
    db[[paste0(topic, ".Rd")]]
  }
})

rd_tag <- function(x) attr(x, "Rd_tag") %||% ""
rd_text <- function(x) paste(unlist(x), collapse = "")

rd_find <- function(x, tag) {
  if (rd_tag(x) == tag) return(list(x))
  if (is.list(x)) return(unlist(lapply(x, rd_find, tag = tag), recursive = FALSE))
  list()
}

rd_value <- function(rd) Filter(function(x) rd_tag(x) == "\\value", rd)[[1]]

test_that("every competition alias Rd links its base wrapper's returns table", {
  routes <- alias_rd_routes()
  expect_length(routes, 148L)
  for (r in routes) {
    # The base wrapper's columns live in return_columns; its \value links there.
    expect_gt(sum(hoopR::return_columns$fn == r$base), 0L)
    base_links <- vapply(rd_find(rd_value(alias_rd_parse(r$base)), "\\link"), rd_text, "")
    expect_true("return_columns" %in% base_links, label = paste0(r$base, "() links return_columns"))
    value <- rd_value(alias_rd_parse(r$topic))
    links <- vapply(rd_find(value, "\\link"), function(x) attr(x, "Rd_option") %||% "", "")
    expect_true(paste0("=", r$base) %in% links, label = paste0(r$alias, "() links ", r$base, "()"))
    expect_match(rd_text(value), paste0(r$alias, "()"), fixed = TRUE)
  }
})

test_that("competition alias Rds show their calls as a details code block, not a run example", {
  for (topic in unique(vapply(alias_rd_routes(), `[[`, "", "topic"))) {
    rd <- alias_rd_parse(topic)
    expect_length(Filter(function(x) rd_tag(x) == "\\examples", rd), 0L)
    details <- Filter(function(x) rd_tag(x) == "\\details", rd)
    expect_length(details, 1L)
    expect_length(rd_find(details[[1]], "\\preformatted"), 1L)
  }
})
