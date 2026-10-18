# fiba_competitions.R -- the per-competition FIBA aliases (fiba_wc_*, fiba_bcl_*, ...).
#
# R mirror of sdv-py sportsdataverse/basketball/_competitions.py (mint_fiba, _fiba_comp). One
# family of 8 thin functions per entry of .intl_basketball_competitions$fiba (the registry in
# R/intl_basketball_competitions.R, already filtered to this package's genders): nothing here
# names a competition or a gender, so wehoop's copy mints its own registry's entries unchanged.
#   <prefix>_editions(season, to_season)            fiba_gdap_editions(family_id = <family>)
#   <prefix>_schedule / _standings / _teams(season, comp)
#                                                   fiba_gdap_schedule / _final_standings / _teams
#   <prefix>_player_box / _team_box / _pbp / _shots(game_id, season, comp)
#                                                   fiba_gamepage_box_players / _box_teams / _pbp / _shots
# `season` picks the family's edition of that season through the editions lookup (cached for an
# hour per session); omitted, the newest edition that has started (a game function needs season or
# comp). A `comp` is checked to be an edition of the family: an edition of another family, or one
# GDAP gives no family, is hoopR_asset_fetch (the wrong-edition refusal).
#
# The minting runs from .fiba_mint_aliases(), called at the end of the sourcing (R/zzz_fiba_competitions.R):
# without a Collate field this file is sourced before the registry. NAMESPACE exports come from
# the registry (@evalNamespace); each competition's Rd needs its own roxygen block below.

#' The alias suffixes, their base functions and what they return.
#' @noRd
.FIBA_ALIASES <- list(
  list(suffix = "editions", base = "fiba_gdap_editions", kind = "editions", what = "Every edition of"),
  list(suffix = "schedule", base = "fiba_gdap_schedule", kind = "comp",
       what = "Schedule and results of one edition of"),
  list(suffix = "standings", base = "fiba_gdap_final_standings", kind = "comp",
       what = "Final standings of one edition of"),
  list(suffix = "teams", base = "fiba_gdap_teams", kind = "comp", what = "Teams of one edition of"),
  list(suffix = "player_box", base = "fiba_gamepage_box_players", kind = "game", what = "Player box score of one game of"),
  list(suffix = "team_box", base = "fiba_gamepage_box_teams", kind = "game", what = "Team box score of one game of"),
  list(suffix = "pbp", base = "fiba_gamepage_pbp", kind = "game", what = "Play-by-play of one game of"),
  list(suffix = "shots", base = "fiba_gamepage_shots", kind = "game", what = "Shot chart of one game of")
)

#' The GDAP competition id of one edition (sdv-py `_fiba_comp`): `comp` as given (checked to be an
#' edition of `family_id`), else the family's edition of `season` (the newest started one if NULL).
#' @noRd
.fiba_comp <- function(family_id, season, comp, label, game = FALSE, call = rlang::caller_env()) {
  if (!is.null(comp)) {
    comp <- .fiba_int_id(comp, "comp", call = call)
    family <- .fiba_competition_family(comp, call = call)
    if (is.null(family)) {
      then <- if (game) {
        "; its game page URL cannot be built either (the URL slug is the family's marketing name)"
      } else {
        paste0("; call the fiba_gdap_* wrapper with comp = ", comp, " to read it unchecked")
      }
      .abort_asset_fetch(paste0("FIBA competition {comp}: GDAP gives it no competition family (no marketing name), ",
                                "so it cannot be checked as an edition of {label}{then}."), call = call)
    }
    if (family[["family"]] != family_id) {
      fam <- family[["family"]]
      .abort_asset_fetch("FIBA competition {comp} is an edition of family {fam}, not of {label} (family {family_id}).",
                         call = call)
    }
    return(comp)
  }
  season <- .fiba_season(season, call = call)
  key <- paste0("editions_", family_id, "_", if (is.null(season)) "latest" else season)
  hit <- .fiba_cache[[key]]
  if (!is.null(hit) && .intl_now() - hit[["at"]] < 3600) {
    ed <- hit[["value"]]
  } else {
    ed <- fiba_gdap_editions(family_id = family_id, season = season, to_season = season)
    if (nrow(ed)) .fiba_cache[[key]] <- list(at = .intl_now(), value = ed) # an empty listing is not remembered
  }
  if (is.null(season) && nrow(ed) && "start" %in% names(ed)) {
    started <- ed[!is.na(ed[["start"]]) & as.character(ed[["start"]]) <= format(Sys.Date(), "%Y-%m-%d"), ]
    if (nrow(started)) ed <- started
  }
  shown <- if (is.null(season)) "None" else season
  if (!nrow(ed)) .abort_no_data("FIBA lists no {label} edition for season={shown}.", call = call)
  if (is.null(season)) ed <- ed[!is.na(ed[["season"]]) & ed[["season"]] == max(ed[["season"]], na.rm = TRUE), ]
  ids <- sort(unique(stats::na.omit(as.integer(ed[["competition_id"]]))))
  if (!length(ids)) .abort_no_data("FIBA lists no {label} edition id for season={shown}.", call = call)
  if (length(ids) > 1L) {
    listed <- paste(ids, collapse = ", ")
    .abort_bad_request("{label} season={shown} lists several editions [{listed}]; pass comp= to pick one.", call = call)
  }
  ids[[1]]
}

#' One alias function of one registry entry.
#' @noRd
.fiba_alias <- function(entry, spec) {
  fam <- entry[["ids"]][["family_id"]]
  label <- entry[["label"]]
  rule <- entry[["season_rule"]]
  base <- spec[["base"]]
  switch(spec[["kind"]],
    editions = function(season = NULL, to_season = NULL, return_parsed = TRUE) {
      fiba_gdap_editions(family_id = fam, season = season, to_season = to_season, return_parsed = return_parsed)
    },
    comp = function(season = NULL, comp = NULL, return_parsed = TRUE) {
      call <- rlang::current_env()
      get(base, mode = "function")(comp = .fiba_comp(fam, season, comp, label, call = call),
                                   return_parsed = return_parsed)
    },
    game = function(game_id, season = NULL, comp = NULL, return_parsed = TRUE) {
      call <- rlang::current_env()
      if (is.null(season) && is.null(comp)) {
        .abort_bad_request(paste0("pass {.arg season} (the edition's season key: {rule}) or {.arg comp} ",
                                  "(the GDAP competition id) for a {label} game."), call = call)
      }
      get(base, mode = "function")(game_id = game_id,
                                   comp = .fiba_comp(fam, season, comp, label, game = TRUE, call = call),
                                   return_parsed = return_parsed)
    }
  )
}

#' Every alias name of the registry, in registry order.
#' @noRd
.fiba_alias_names <- function() {
  unlist(lapply(.intl_basketball_competitions[["fiba"]], function(e) {
    paste0(e[["prefix"]], "_", vapply(.FIBA_ALIASES, `[[`, "", "suffix"))
  }), use.names = FALSE)
}

#' Bind every registry entry's aliases into `env` (the namespace).
#' @noRd
.fiba_mint_aliases <- function(env = parent.frame()) {
  for (entry in .intl_basketball_competitions[["fiba"]]) {
    for (spec in .FIBA_ALIASES) assign(paste0(entry[["prefix"]], "_", spec[["suffix"]]), .fiba_alias(entry, spec), envir = env)
  }
  invisible()
}

#' The roxygen tags of one competition's Rd (`<prefix>_competition`).
#' @noRd
.fiba_competition_rd <- function(prefix) {
  hit <- Filter(function(e) identical(e[["prefix"]], prefix), .intl_basketball_competitions[["fiba"]])
  if (!length(hit)) return("@noRd")
  e <- hit[[1]]
  ex <- e[["example_season"]]
  fns <- paste0(prefix, "_", vapply(.FIBA_ALIASES, `[[`, "", "suffix"))
  usage <- vapply(.FIBA_ALIASES, function(s) {
    args <- switch(s[["kind"]],
      editions = "season = NULL, to_season = NULL, return_parsed = TRUE",
      comp = "season = NULL, comp = NULL, return_parsed = TRUE",
      game = "game_id, season = NULL, comp = NULL, return_parsed = TRUE"
    )
    paste0(prefix, "_", s[["suffix"]], "(", args, ")")
  }, "")
  c(
    paste0("@name ", prefix, "_competition"),
    paste0("@title **FIBA competition: ", e[["label"]], "**"),
    paste0("@description Per-competition aliases of the FIBA wrappers for ", e[["label"]],
           " (GDAP competition family ", e[["ids"]][["family_id"]], "), named as in sdv-py. Season rule: ",
           e[["season_rule"]], "."),
    paste0("@aliases ", paste(fns, collapse = " ")),
    paste0("@usage ", paste(usage, collapse = "\n\n")),
    "@param game_id FIBA game id (`game_id` in the schedule).",
    paste0("@param season Edition season key (", e[["season_rule"]], "). Omitted = the newest edition that has ",
           "started; a game function needs `season` or `comp`. For `", prefix, "_editions()`: the first season ",
           "(inclusive), omitted = every edition."),
    paste0("@param to_season Last season, inclusive (`", prefix, "_editions()` only)."),
    paste0("@param comp FIBA competition id (one per edition); skips the edition lookup and is needed when a ",
           "season lists several editions. Checked to be an edition of this competition (one cached ",
           "getGdapCompetitionById request)."),
    "@param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.",
    "@details",
    paste0("FIBA's terms restrict this source: the GDAP developer-portal terms limit API use to 'Authorized ",
           "Users' and the fiba.basketball terms say no portion of the site may be duplicated, redistributed or ",
           "manipulated. The package owner reviewed both clauses on 2026-10-12, accepted them and approved the ",
           "full intake, published data releases included. Users who are not themselves authorised by FIBA ",
           "should check the terms before using the wrappers. See [fiba_gdap_awards()] for the shared notes."),
    "",
    paste0("A `comp` of another competition family, or one GDAP gives no family, is `hoopR_asset_fetch`; a ",
           "season with no edition is `hoopR_no_data`; a season listing several editions, or a game function ",
           "called with neither `season` nor `comp`, is `hoopR_bad_request`."),
    paste0("@return A `hoopR_data` tibble with the columns of the base wrapper (the raw JSON list when ",
           "`return_parsed = FALSE`), one table per function:"),
    unlist(lapply(.FIBA_ALIASES, function(s) {
      .intl_alias_returns(paste0(prefix, "_", s[["suffix"]]), s[["base"]])
    })),
    "@family FIBA Competition Functions",
    "@examples",
    "\\donttest{",
    paste0("  try(", prefix, "_editions(season = ", ex, "))"),
    paste0("  try(", prefix, "_schedule(season = ", ex, "))"),
    "}"
  )
}

#' @evalNamespace paste0("export(", .fiba_alias_names(), ")")
NULL

# One Rd per competition: one block per registry prefix (a prefix the registry lacks is @noRd).
#' @eval .fiba_competition_rd("fiba_wc")
NULL
#' @eval .fiba_competition_rd("fiba_oly")
NULL
#' @eval .fiba_competition_rd("fiba_bcl")
NULL
#' @eval .fiba_competition_rd("fiba_afrobasket")
NULL
#' @eval .fiba_competition_rd("fiba_eurobasket")
NULL
#' @eval .fiba_competition_rd("fiba_americup")
NULL
#' @eval .fiba_competition_rd("fiba_asiacup")
NULL
#' @eval .fiba_competition_rd("fiba_icup")
NULL
#' @eval .fiba_competition_rd("fiba_bcla")
NULL
