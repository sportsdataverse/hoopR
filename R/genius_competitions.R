# genius_competitions.R -- per-competition aliases over the Genius family (exported).
#
# R mirror of sdv-py basketball/_competitions.py mint_genius() (origin/main e3d232e): one set of
# <prefix>_competitions / _schedule / _team_box / _player_box / _pbp / _shots per Genius entry of
# the competition registry (R/intl_basketball_competitions.R, already filtered to this package's
# genders). The aliases are minted from that registry by .genius_mint_aliases(), called from
# R/zzz_genius_competitions.R (R sources R/ in C-locale order, so the registry file loads after
# this one); their Rd topics come from .genius_competition_rd() and their exports from
# .genius_alias_exports(), so the gender filtering stays registry-driven: a package mirror
# (wehoop) keeps this file and lists one 2-line Rd block per entry of its own registry.
#
# The game aliases fetch the base frame, then check the game on its LiveStats /u/ shell (one extra
# request per game, cached per process for an hour): data.json names no competition and match ids
# are one global sequence across every Genius customer, so the shell's competition name must pass
# the entry's label rule (label_include, and not label_exclude, case-insensitive).

.GENIUS_CACHE_TTL <- 3600
.GENIUS_CACHE_MAX <- 1024L
.genius_cache <- new.env(parent = emptyenv())

#' `fetch()` memoised per process for an hour, at most 1024 entries (least recently used dropped
#' first). An empty listing is not remembered.
#' @noRd
.genius_cached <- function(key, fetch) {
  key <- paste(key, collapse = "|")
  now <- .intl_now()
  hit <- .genius_cache[[key]]
  if (!is.null(hit) && now - hit$born < .GENIUS_CACHE_TTL) {
    hit$used <- now
    assign(key, hit, envir = .genius_cache)
    return(hit$value)
  }
  value <- fetch()
  if (!is.data.frame(value) || nrow(value) > 0L) {
    assign(key, list(value = value, born = now, used = now), envir = .genius_cache)
    keys <- ls(.genius_cache, all.names = TRUE)
    if (length(keys) > .GENIUS_CACHE_MAX) {
      used <- vapply(keys, function(k) .genius_cache[[k]]$used, numeric(1))
      rm(list = keys[order(used)][seq_len(length(keys) - .GENIUS_CACHE_MAX)], envir = .genius_cache)
    }
  }
  value
}

#' The registry entry of a Genius competition key (this package's genders only).
#' @noRd
.genius_entry <- function(key) {
  hit <- Filter(function(e) identical(e$key, key), .intl_basketball_competitions$genius)
  if (!length(hit)) cli::cli_abort("{.val {key}} is not a Genius entry of the competition registry.", .internal = TRUE)
  hit[[1]]
}

#' The entry's label rule over a character vector of competition labels (NA reads as "").
#' @noRd
.genius_label_ok <- function(entry, label) {
  label <- ifelse(is.na(label), "", label)
  grepl(entry$label_include, label, ignore.case = TRUE, perl = TRUE) &
    !grepl(entry$label_exclude, label, ignore.case = TRUE, perl = TRUE)
}

#' The Genius competition id of `season`: `comp_id` as given, else the org competition whose label
#' matches the entry (the newest season when `season` is NULL).
#' @noRd
.genius_comp <- function(entry, season, comp_id, call = rlang::caller_env()) {
  if (!is.null(comp_id)) return(as.integer(comp_id))
  org <- entry$ids$org
  label <- entry$label
  frame <- .genius_cached(c("genius", org), function() genius_competitions(org = org))
  hit <- frame[.genius_label_ok(entry, frame$label), ]
  if (is.null(season)) {
    if (nrow(hit)) hit <- hit[!is.na(hit$season) & hit$season == suppressWarnings(max(hit$season, na.rm = TRUE)), ]
  } else {
    hit <- hit[!is.na(hit$season) & hit$season == season, ]
  }
  shown <- if (is.null(season)) "None" else season
  if (!nrow(hit)) .abort_no_data("Genius lists no {label} competition for season={shown}.", call = call)
  ids <- sort(unique(hit$comp_id[!is.na(hit$comp_id)]))
  if (!length(ids)) .abort_no_data("Genius lists no {label} competition id for season={shown}.", call = call)
  if (length(ids) > 1L) {
    .abort_bad_request(
      "{label} season={shown} matches several competitions ({paste(ids, collapse = ', ')}); pass {.arg comp_id} to pick one.",
      call = call
    )
  }
  ids
}

#' Refuse a match of another competition: data.json names none, so read the game's /u/ shell.
#'
#' A dead connection or a 429 / 5xx on the shell request is retried once; a refusal (the CloudFront
#' block) is not. When the check cannot run the frame is NOT returned unchecked.
#' @noRd
.genius_check <- function(entry, match_id, base_name, call = rlang::caller_env()) {
  org <- entry$ids$live_org
  label <- entry$label
  match_id <- as.integer(match_id)
  unchecked <- paste0("read it unchecked with ", base_name, "(match_id = ...)")
  shell <- paste0("/u/", org, "/", match_id, "/")
  rec <- NULL
  for (attempt in 1:2) {
    rec <- tryCatch(
      .genius_cached(c("genius-u", org, match_id),
                     function() genius_match_competition(org = org, match_id = match_id, return_parsed = FALSE)),
      hoopR_no_data = function(e) {
        msg <- paste0("match ", match_id, " is not a ", label, " game: Genius has no ", shell,
                      " shell (another org's game); ", unchecked)
        .abort_asset_fetch("{msg}", call = call)
      },
      hoopR_asset_fetch = function(e) {
        transient <- isTRUE(e$transient)
        if (attempt == 2L || !transient) {
          msg <- paste0("match ", match_id, ": the ", label, " scope check could not run (the ", shell,
                        " shell request failed", if (transient) " twice", ": ", conditionMessage(e),
                        "); the game data was fetched but is not returned unchecked: retry, or ", unchecked)
          .abort_asset_fetch("{msg}", call = call)
        }
        NULL
      }
    )
    if (!is.null(rec)) break
  }
  name <- rec$competition_name
  if (!(is.character(name) && length(name) == 1L && !is.na(name) && nzchar(trimws(name)))) {
    msg <- paste0("match ", match_id, ": the ", shell, " shell names no competition, so it cannot be checked as a ",
                  label, " game; ", unchecked)
    .abort_asset_fetch("{msg}", call = call)
  }
  if (!.genius_label_ok(entry, name)) {
    msg <- paste0("match ", match_id, " belongs to '", name, "' (comp_id ", rec$comp_id, "), not to ", label,
                  "; read it with ", base_name, "(match_id = ...)")
    .abort_asset_fetch("{msg}", call = call)
  }
  invisible(TRUE)
}

.genius_alias_competitions <- function(key, return_parsed = TRUE) {
  genius_competitions(org = .genius_entry(key)$ids$org, return_parsed = return_parsed)
}

.genius_alias_schedule <- function(key, season = NULL, comp_id = NULL, round_number = -1, return_parsed = TRUE,
                                   call = rlang::caller_env()) {
  entry <- .genius_entry(key)
  genius_schedule(org = entry$ids$org, comp_id = .genius_comp(entry, season, comp_id, call = call),
                  round_number = round_number, return_parsed = return_parsed)
}

.genius_alias_game <- function(key, base_name, match_id, return_parsed = TRUE, call = rlang::caller_env()) {
  entry <- .genius_entry(key)
  res <- get(base_name, mode = "function")(match_id = match_id, return_parsed = return_parsed)
  .genius_check(entry, match_id, base_name, call = call)
  res
}

# ------------------------------------------------------------------------------ minting

#' Alias suffix -> base wrapper of the game aliases.
#' @noRd
.GENIUS_ALIAS_GAMES <- c(team_box = "genius_team_box", player_box = "genius_player_box", pbp = "genius_pbp",
                         shots = "genius_shots")

#' The six alias functions of one registry entry, named `<prefix>_<suffix>`.
#' @noRd
.genius_alias_fns <- function(entry, env) {
  key <- entry$key
  p <- entry$prefix
  fns <- list()
  fns[[paste0(p, "_competitions")]] <- rlang::new_function(
    rlang::pairlist2(return_parsed = TRUE),
    rlang::call2(".genius_alias_competitions", key, return_parsed = rlang::sym("return_parsed")), env
  )
  fns[[paste0(p, "_schedule")]] <- rlang::new_function(
    rlang::pairlist2(season = NULL, comp_id = NULL, round_number = -1, return_parsed = TRUE),
    rlang::call2(".genius_alias_schedule", key, season = rlang::sym("season"), comp_id = rlang::sym("comp_id"),
                 round_number = rlang::sym("round_number"), return_parsed = rlang::sym("return_parsed")), env
  )
  for (suffix in names(.GENIUS_ALIAS_GAMES)) {
    base <- .GENIUS_ALIAS_GAMES[[suffix]]
    fns[[paste0(p, "_", suffix)]] <- rlang::new_function(
      rlang::pairlist2(match_id = , return_parsed = TRUE),
      rlang::call2(".genius_alias_game", key, base, rlang::sym("match_id"),
                   return_parsed = rlang::sym("return_parsed")), env
    )
  }
  fns
}

#' Mint every Genius alias of the registry into `env` (the namespace; see R/zzz_genius_competitions.R).
#' @noRd
.genius_mint_aliases <- function(env = parent.frame()) {
  for (entry in .intl_basketball_competitions$genius) {
    fns <- .genius_alias_fns(entry, env)
    for (name in names(fns)) assign(name, fns[[name]], envir = env)
  }
  invisible(.genius_alias_names())
}

#' Names of every minted Genius alias.
#' @noRd
.genius_alias_names <- function() {
  unlist(lapply(.intl_basketball_competitions$genius, .genius_alias_names_of), use.names = FALSE)
}

.genius_alias_names_of <- function(entry) {
  paste0(entry$prefix, "_", c("competitions", "schedule", names(.GENIUS_ALIAS_GAMES)))
}

#' NAMESPACE export lines of the minted aliases (roxygen `@evalNamespace`).
#' @noRd
.genius_alias_exports <- function() paste0("export(", .genius_alias_names(), ")")

#' Roxygen lines of one competition's Rd topic (roxygen `@eval`).
#' @noRd
.genius_competition_rd <- function(prefix) {
  hit <- Filter(function(e) identical(e$prefix, prefix), .intl_basketball_competitions$genius)
  e <- hit[[1]]
  p <- e$prefix
  org <- e$ids$org
  live <- e$ids$live_org
  gender <- c(men = "men's", women = "women's", both = "men's and women's")[[e$gender]]
  games <- paste0(p, "_", names(.GENIUS_ALIAS_GAMES))
  c(
    paste0("@title **", e$label, " (Genius LiveStats)**"),
    paste0("@description Convenience wrappers binding the Genius family to the ", e$label, " (", gender,
           "; Genius ORG `", org, "`, LiveStats ORG `", live, "`). Season rule: ", e$season_rule, "."),
    "",
    paste0("* `", p, "_competitions()`: every competition of the `", org,
           "` org, with its END-year season ([genius_competitions()])."),
    paste0("* `", p, "_schedule()`: every match of one season ([genius_schedule()])."),
    paste0("* ", paste0("`", games, "()`", collapse = ", "), ": one finished game (",
           paste0("[", .GENIUS_ALIAS_GAMES, "()]", collapse = ", "), ")."),
    paste0("@details The season's competition is picked from the `", org, "` chooser by the label rule include = `",
           e$label_include, "`, exclude = `", e$label_exclude, "` (case-insensitive); cups and play-offs have ",
           "their own `comp_id`. Several matching competitions raise `hoopR_bad_request` (pass `comp_id`); none ",
           "raises `hoopR_no_data`."),
    "",
    paste0("Genius match ids are one global sequence shared by every customer and `data.json` names no ",
           "competition, so each game alias checks the id on the game's LiveStats shell (`/u/", live,
           "/<match_id>/`: one extra request per game, cached per process for an hour): its competition name ",
           "must pass the label rule. Another org's game, a cup or play-off game of `", org, "`, or a shell ",
           "request that fails twice (or names no competition) raises `hoopR_asset_fetch`. The base ",
           "`genius_*()` function reads any game unchecked."),
    "",
    "Access, proxy and error notes: see [genius_game()].",
    "",
    "```r",
    paste0(" ", p, "_competitions()"),
    paste0(" ", p, "_schedule()"),
    "```",
    "@usage",
    paste0(p, "_competitions(return_parsed = TRUE)"),
    "",
    paste0(p, "_schedule(season = NULL, comp_id = NULL, round_number = -1, return_parsed = TRUE)"),
    unlist(lapply(games, function(g) c("", paste0(g, "(match_id, return_parsed = TRUE)")))),
    paste0("@param season END-year season (see the season rule). `NULL` (default) = the newest season the ",
           "org lists."),
    "@param comp_id Genius competition id; skips the season lookup (needed when the label rule matches several competitions).",
    "@param round_number Round to list; -1 (default) lists every round.",
    paste0("@param match_id Genius match id (`match_id` of `", p, "_schedule()`) of a game of this competition."),
    "@param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the raw list.",
    paste0("@return The base function's `hoopR_data` tibble, same columns and types (the raw list when ",
           "`return_parsed = FALSE`) of each function:"), "",
    .intl_alias_returns(paste0(p, "_competitions"), "genius_competitions"),
    .intl_alias_returns(paste0(p, "_schedule"), "genius_schedule"),
    unlist(lapply(names(.GENIUS_ALIAS_GAMES), function(s) {
      .intl_alias_returns(paste0(p, "_", s), .GENIUS_ALIAS_GAMES[[s]])
    })),
    paste0("@name ", p, "_competition"),
    paste("@aliases", paste(.genius_alias_names_of(e), collapse = " ")),
    "@family Genius Functions"
  )
}

#' @evalNamespace .genius_alias_exports()
NULL

#' @eval .genius_competition_rd("slb")
NULL

#' @eval .genius_competition_rd("bal")
NULL

#' @eval .genius_competition_rd("nznbl")
NULL

#' @eval .genius_competition_rd("esake")
NULL

#' @eval .genius_competition_rd("lnbm")
NULL

#' @eval .genius_competition_rd("lub")
NULL
