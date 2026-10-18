# Every minted competition alias (atrium, fiba, genius) documents, in its competition Rd's
# \value, a `\subsection{<alias>()}` whose returns table has the base wrapper's col_names.

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

# col_names (first cells, header row dropped) of an Rd \tabular node.
rd_tabular_cols <- function(tab) {
  out <- character()
  cur <- ""
  first <- TRUE
  for (cell in tab[[2]]) {
    tag <- rd_tag(cell)
    if (tag == "\\tab") {
      first <- FALSE
    } else if (tag == "\\cr") {
      out <- c(out, trimws(cur))
      cur <- ""
      first <- TRUE
    } else if (first) {
      cur <- paste0(cur, rd_text(cell))
    }
  }
  out[-1]
}

rd_find <- function(x, tag) {
  if (rd_tag(x) == tag) return(list(x))
  if (is.list(x)) return(unlist(lapply(x, rd_find, tag = tag), recursive = FALSE))
  list()
}

rd_value <- function(rd) Filter(function(x) rd_tag(x) == "\\value", rd)[[1]]

test_that("every competition alias Rd carries its base wrapper's returns table", {
  routes <- alias_rd_routes()
  expect_length(routes, 148L)
  for (r in routes) {
    base_tabs <- rd_find(rd_value(alias_rd_parse(r$base)), "\\tabular")
    expect_length(base_tabs, 1L)
    base_cols <- rd_tabular_cols(base_tabs[[1]])
    subs <- Filter(function(x) rd_tag(x) == "\\subsection", rd_value(alias_rd_parse(r$topic)))
    hit <- Filter(function(x) identical(rd_text(x[[1]]), paste0(r$alias, "()")), subs)
    expect_length(hit, 1L)
    if (length(hit) != 1L) next
    tabs <- rd_find(hit[[1]][[2]], "\\tabular")
    expect_length(tabs, 1L)
    expect_gt(length(base_cols), 0L)
    expect_identical(rd_tabular_cols(tabs[[1]]), base_cols, label = paste0(r$alias, "() col_names"))
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
