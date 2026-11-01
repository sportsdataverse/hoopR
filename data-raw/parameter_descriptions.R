# Build `parameter_descriptions`: one row per R argument that hoopR's NBA Stats
# API (stats.nba.com) wrappers send as a query parameter.
#
# Run from the package root:
#   Rscript data-raw/parameter_descriptions.R
# Needs pkgload, usethis and wehoop (>= 3.0.0, for its WNBA
# `parameter_descriptions` table). Makes no network calls.
#
# Inputs
#   * hoopR itself: the exported nba_*() wrappers (their bodies and formals)
#     and the @param text in man/*.Rd.
#   * data-raw/nba_stats_parameter_values.csv: per-endpoint stats.nba.com
#     parameter values (required, default, enum, example and the validation
#     pattern the API enforces), frozen from the stats.nba.com parameter values
#     (cross-checked against nba_api).
#   * wehoop::parameter_descriptions, for wording shared with the WNBA Stats API.
# Outputs
#   * data/parameter_descriptions.rda and data-raw/parameter_descriptions.csv
#   * data-raw/nba_stats_parameter_inventory.csv: function -> endpoint ->
#     api_name -> parameter, one row per query parameter a wrapper sends.

pkgload::load_all(".", quiet = TRUE)
ns <- asNamespace("hoopR")

# ---- AST helpers -------------------------------------------------------------
is_empty_sym <- function(x) is.symbol(x) && !nzchar(as.character(x))
walk <- function(e, f) {
  f(e)
  if (is.call(e)) for (i in seq_along(e)[-1]) {
    if (is.null(e[[i]]) || is_empty_sym(e[[i]])) next
    walk(e[[i]], f)
  }
}
string_literals <- function(e) {
  out <- character()
  walk(e, function(x) if (is.character(x)) out <<- c(out, x))
  out
}

# ---- 1. Wrappers and the query parameters they send ----------------------------
# A wrapper is an exported nba_*() function that builds `params <- list(...)`
# and sends it with request_with_proxy() to an nba_endpoint() URL. That leaves
# out the ESPN, data.nba.com, cdn.nba.com and official.nba.com helpers and
# the functions that only post-process another wrapper's output.
src_has <- function(f, pat) any(grepl(pat, deparse(get(f, ns)), fixed = TRUE))
wrappers <- sort(grep("^nba_", getNamespaceExports("hoopR"), value = TRUE))
wrappers <- wrappers[vapply(wrappers, function(f) {
  src_has(f, "params <- list(") && src_has(f, "request_with_proxy(") && src_has(f, "nba_endpoint(")
}, logical(1))]

wrapper_rows <- function(f) {
  fun <- get(f, ns)
  fm <- formals(fun)
  args <- setdiff(names(fm), "...")
  lists <- list()
  alias <- character()
  strings <- list() # `version <- "leaguedashplayerstats"`
  endpoint_args <- list()
  walk(body(fun), function(e) {
    if (is.call(e) && identical(e[[1]], as.name("nba_endpoint"))) endpoint_args[[length(endpoint_args) + 1]] <<- e[[2]]
    if (!is.call(e) || !identical(e[[1]], as.name("<-")) || !is.name(e[[2]])) return()
    lhs <- as.character(e[[2]])
    rhs <- e[[3]]
    if (lhs == "params" && is.call(rhs) && identical(rhs[[1]], as.name("list"))) {
      lists[[length(lists) + 1]] <<- rhs
    } else if (is.name(rhs) && as.character(rhs) %in% args) {
      alias[lhs] <<- as.character(rhs) # e.g. `group_id2 <- group_id`
    } else if (is.character(rhs)) {
      strings[[lhs]] <<- c(strings[[lhs]], rhs)
    }
  })
  # The endpoint is the literal passed to nba_endpoint(), directly or through a variable.
  endpoint <- unlist(lapply(endpoint_args, function(a) {
    if (is.character(a)) a else if (is.name(a)) strings[[as.character(a)]]
  }))
  endpoint <- paste(unique(endpoint), collapse = ", ")
  rows <- list()
  for (pl in lists) {
    keys <- names(pl)
    for (i in seq_along(pl)[-1]) {
      syms <- all.names(pl[[i]])
      syms <- ifelse(syms %in% names(alias), alias[syms], syms)
      syms <- unique(intersect(syms, args))
      if (length(syms) != 1) next # constants such as `StartPeriod = 0`
      rows[[length(rows) + 1]] <- data.frame(
        function_name = f, endpoint = endpoint, api_name = keys[i], parameter = syms,
        r_default = paste(deparse(fm[[syms]]), collapse = " "),
        stringsAsFactors = FALSE
      )
    }
  }
  do.call(rbind, rows)
}
inventory <- unique(do.call(rbind, lapply(wrappers, wrapper_rows)))
inventory <- inventory[order(inventory$function_name, inventory$api_name), ]
stopifnot(all(nzchar(inventory$endpoint)))

# ---- 2. @param text from man/ ------------------------------------------------
rd_text <- function(x) trimws(gsub("[[:space:]]+", " ", paste(as.character(x), collapse = "")))
rd_rows <- list()
for (rd in tools::Rd_db(dir = ".")) {
  tags <- vapply(rd, function(x) attr(x, "Rd_tag"), "")
  aliases <- intersect(unlist(lapply(rd[tags == "\\alias"], rd_text)), wrappers)
  if (!length(aliases) || !any(tags == "\\arguments")) next
  for (item in rd[tags == "\\arguments"][[1]]) {
    if (!identical(attr(item, "Rd_tag"), "\\item")) next
    params <- trimws(strsplit(rd_text(item[[1]]), ",")[[1]])
    for (a in aliases) for (p in params) {
      rd_rows[[length(rd_rows) + 1]] <- data.frame(function_name = a, parameter = p, rd = rd_text(item[[2]]))
    }
  }
}
rd <- unique(do.call(rbind, rd_rows))
inventory <- merge(inventory, rd, all.x = TRUE, sort = FALSE)

# ---- 3. Reference values -------------------------------------------------------
values <- utils::read.csv("data-raw/nba_stats_parameter_values.csv", colClasses = "character", na.strings = NULL)
values$key <- paste(values$endpoint, values$api_name)

stopifnot(requireNamespace("wehoop", quietly = TRUE))
we <- as.data.frame(wehoop::parameter_descriptions)

# ---- 4. Text helpers -----------------------------------------------------------
# Most common non-empty value; ties go to the longest (the most specific).
top <- function(x) {
  x <- x[!is.na(x) & nzchar(x)]
  if (!length(x)) return("")
  t <- table(x)
  best <- names(t)[t == max(t)]
  best[which.max(nchar(best))]
}
squash <- function(x) gsub("[^a-z0-9]", "", tolower(x))
# "Per Mode - PerGame, Totals" -> head "Per Mode", tail "PerGame, Totals".
split_head <- function(txt) {
  m <- regexpr(" - |: ", txt)
  if (m < 0) return(c(txt, ""))
  c(substr(txt, 1, m - 1), substr(txt, m + attr(m, "match.length"), nchar(txt)))
}
# A comma-separated enum written into the @param text, or "".
rd_enum <- function(txt) {
  if (is.na(txt)) return("")
  quoted <- gsub("'", "", regmatches(txt, gregexpr("'[^']+'", txt))[[1]])
  if (length(quoted) >= 2) return(paste(unique(quoted), collapse = ", "))
  if (grepl("default|format|e\\.g\\.", txt)) return("")
  tail <- split_head(txt)[2]
  if (grepl("^[A-Za-z0-9]+/[A-Za-z0-9]+$", tail)) return(sub("/", ", ", tail))
  if (!grepl(",", tail)) return("")
  parts <- trimws(strsplit(tail, ",")[[1]])
  paste(unique(parts[nzchar(parts)]), collapse = ", ")
}
# Circular text only restates the name ("season" -> "Season", "Player ID").
is_circular <- function(txt, parameter, api) {
  if (is.na(txt) || !nzchar(txt)) return(TRUE)
  has_enum <- nzchar(rd_enum(txt))
  strip <- function(x) squash(gsub("(^|[^a-z])(player|players|filter)([^a-z]|$)", "\\1\\3", tolower(x)))
  core <- strip(if (has_enum) split_head(txt)[1] else txt)
  names <- unique(c(strip(parameter), strip(api), strip(paste(parameter, parameter)), squash(parameter)))
  # A name followed only by its values ("Pace Adjustment - Y/N") is circular too.
  core %in% c("", names) || (has_enum && any(startsWith(core, names) | startsWith(names, core)))
}
# Literal alternatives of a validation pattern: "^((East)|(West))?$" -> East, West.
pattern_enum <- function(p) {
  lit <- "\\(([^()|\\\\]+)\\)"
  groups <- regmatches(p, gregexpr(lit, p))[[1]]
  rest <- gsub("[]^$?()|[]", "", gsub(lit, "", p))
  if (!length(groups) || nzchar(rest)) return(character())
  gsub("^\\(|\\)$", "", groups)
}
endpoint_values <- function(key) {
  v <- values[values$key == key, ]
  if (!nrow(v)) return(character())
  out <- c(if (nzchar(v$enum[1])) strsplit(v$enum[1], ", ")[[1]], pattern_enum(v$pattern[1]))
  unique(out)
}
# Union of value sets, biggest set first so its natural order survives.
union_sets <- function(sets) {
  sets <- sets[order(-lengths(sets))]
  unique(unlist(sets))
}

# ---- 5. Descriptions written from the API's own semantics --------------------------
# Where hoopR's @param text restates the name and wehoop's wording does not fit
# the NBA (or does not exist), these describe what stats.nba.com does with the
# parameter.
api_semantics <- c(
  season = "Season in YYYY-YY format (e.g. '2023-24'). A bare year is not an error, but several endpoints then return zero rows.",
  game_date = "Game date as YYYY-MM-DD (e.g. '2023-03-26').",
  season_year = "Season or draft year sent as SeasonYear. The draft-combine endpoints expect a single draft year (YYYY); the others use YYYY-YY.",
  league_id = "League identifier: '00' NBA, '01' ABA (historical), '10' WNBA, '15' Summer League, '20' G League. Pin it explicitly; an empty LeagueID can duplicate In-Season Tournament games.",
  period = "Game period (0 means all periods; 1-4 are the quarters and overtime n is 4 + n).",
  number_of_games = "Number of games to return (2147483647 means all games).",
  player_or_team = "Whether to return player or team rows. PlayerOrTeam takes 'Player' or 'Team'; PlayerOrTeamAbbreviation takes 'P' or 'T'.",
  defense_category = "Shot category for the player-tracking defense endpoints. Values contain spaces, e.g. 'Less Than 6Ft'.",
  pt_measure_type = "Player-tracking measure family to return.",
  play_type = "Synergy play type. PRBallHandler and PRRollman are the pick-and-roll ball handler and roll man; OffRebound is putbacks.",
  type_grouping = "Synergy side of the ball: offensive or defensive possessions.",
  game_id = "10-digit zero-padded game identifier (e.g. '0022300061'); the leading '00' is the NBA league code and the third digit the season type."
)
api_values <- c(
  pt_measure_type = "SpeedDistance, Rebounding, Possessions, CatchShoot, PullUpShot, Defense, Drives, Passing, ElbowTouch, PostTouch, PaintTouch, Efficiency",
  defense_category = "Overall, 3 Pointers, 2 Pointers, Less Than 6Ft, Less Than 10Ft, Greater Than 15Ft"
)
# Game and streak finder comparison filters: GtPTS, LtOPPREB, EqFG3M, ...
finder_desc <- function(api) {
  m <- regmatches(api, regexec("^(Gt|Lt|Eq)(OPP)?(.+)$", api))[[1]]
  if (!length(m)) return("")
  op <- c(Gt = "greater than", Lt = "less than", Eq = "equal to")[[m[2]]]
  who <- if (nzchar(m[3])) "the opponent's " else ""
  sprintf("Game-finder filter: games where %s%s is %s this value.", who, m[4], op)
}

# ---- 6. One row per parameter --------------------------------------------------
src <- list()
build_row <- function(p) {
  d <- inventory[inventory$parameter == p, ]
  apis <- names(sort(table(d$api_name), decreasing = TRUE))
  api <- apis[1]
  w <- we[we$parameter == p, ]
  if (!nrow(w) && sum(we$api_name == api) == 1) w <- we[we$api_name == api, ]
  rd_texts <- unique(d[, c("function_name", "rd")])$rd
  rd_good <- rd_texts[!vapply(rd_texts, is_circular, logical(1), parameter = p, api = api)]

  if (p %in% names(api_semantics)) {
    desc <- api_semantics[[p]]; ds <- "api"
  } else if (length(rd_good)) {
    desc <- top(rd_good); ds <- "rd"
  } else if (nrow(w)) {
    desc <- gsub("WNBA", "NBA", w$description); ds <- "wehoop"
  } else if (nzchar(finder_desc(api))) {
    desc <- finder_desc(api); ds <- "finder"
  } else {
    desc <- top(rd_texts); ds <- "none"
  }

  sets <- lapply(unique(paste(d$endpoint, d$api_name)), endpoint_values)
  vv <- union_sets(sets[lengths(sets) > 0])
  vs <- "endpoint"
  if (p %in% names(api_values)) {
    vv <- union_sets(list(strsplit(api_values[[p]], ", ")[[1]], vv)); vs <- "api"
  }
  if (!length(vv)) {
    e <- top(vapply(rd_texts, rd_enum, ""))
    if (nzchar(e)) { vv <- strsplit(e, ", ")[[1]]; vs <- "rd" }
  }
  if (!length(vv) && nrow(w) && nzchar(w$valid_values)) {
    vv <- strsplit(w$valid_values, ", ")[[1]]; vs <- "wehoop"
  }
  if (!length(vv)) vs <- "none"

  # R default; an argument with no default shows the endpoint's own default.
  def <- top(d$r_default)
  if (!nzchar(def)) {
    k <- values[values$key %in% paste(d$endpoint, d$api_name), ]
    api_def <- top(c(k$default, k$example))
    if (nzchar(api_def)) def <- deparse(api_def)
  }

  fns <- sort(unique(d$function_name))
  src[[p]] <<- c(description = ds, valid_values = vs)
  data.frame(
    parameter = p,
    api_name = paste(apis, collapse = ", "),
    description = desc,
    valid_values = paste(vv, collapse = ", "),
    default = def,
    functions = paste(fns, collapse = ", "),
    n_functions = length(fns),
    stringsAsFactors = FALSE
  )
}
parameter_descriptions <- do.call(rbind, lapply(sort(unique(inventory$parameter)), build_row))
rownames(parameter_descriptions) <- NULL

# wehoop wording must not carry WNBA-only facts into the NBA table.
stopifnot(
  !anyDuplicated(parameter_descriptions$parameter),
  !any(grepl("WNBA endpoints|'10' identifies|YYYY format for", parameter_descriptions$description))
)

# ---- 7. Write ------------------------------------------------------------------
inv_out <- inventory[, c("function_name", "endpoint", "api_name", "parameter", "r_default")]
utils::write.csv(inv_out, "data-raw/nba_stats_parameter_inventory.csv", row.names = FALSE)
utils::write.csv(parameter_descriptions, "data-raw/parameter_descriptions.csv", row.names = FALSE)
# Where each row's description and valid_values came from: api (stats.nba.com
# semantics written above), endpoint (the frozen parameter values), rd (hoopR
# @param text), wehoop, finder (Gt/Lt/Eq pattern) or none (the @param text kept as is).
sources <- data.frame(parameter = names(src), description_source = vapply(src, `[[`, "", "description"),
                      valid_values_source = vapply(src, `[[`, "", "valid_values"))
utils::write.csv(sources, "data-raw/parameter_descriptions_sources.csv", row.names = FALSE)
usethis::use_data(parameter_descriptions, overwrite = TRUE, compress = "xz")

s <- do.call(rbind, src)
message(nrow(parameter_descriptions), " parameters from ", length(wrappers), " wrappers")
message("description source: ", paste(names(table(s[, "description"])), table(s[, "description"]), sep = "=", collapse = " "))
message("valid_values source: ", paste(names(table(s[, "valid_values"])), table(s[, "valid_values"]), sep = "=", collapse = " "))
message("no description source: ", paste(rownames(s)[s[, "description"] == "none"], collapse = ", "))
