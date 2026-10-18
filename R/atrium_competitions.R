# atrium_competitions.R -- the per-site aliases of the Atrium family (lnb_*, lnbp_*, ...).
#
# R mirror of sdv-py sportsdataverse/basketball/_competitions.py `mint_atrium()`: for
# every atrium entry of .intl_basketball_competitions (this package's genders only),
# eight thin bindings of a base wrapper to the entry's website_id:
#   <prefix>_seasons / _schedule / _standings / _teams / _player_box / _team_box /
#   _pbp / _shots
# Everything is driven by the registry: .atrium_mint_aliases() defines the functions
# (called from zzz_atrium_competitions.R, which R sources after the registry file),
# the exports come from @evalNamespace, and each site's Rd from @eval. A site block
# below whose prefix is not in this package's registry renders nothing (@noRd), so a
# copy of this file serves a package with another gender filter unchanged.

#' What each alias suffix binds: the base wrapper, its arguments and a summary.
#' @noRd
.atrium_alias_specs <- list(
  seasons = list(base = "atrium_seasons", args = "locale", what = "Every season and competition id"),
  schedule = list(base = "atrium_fixtures", args = c("season", "season_id", "competition_id", "locale"),
                  what = "Fixtures (schedule and results) of a season"),
  standings = list(base = "atrium_standings", args = c("season", "season_id", "competition_id", "locale"),
                   what = "Standings of a season"),
  teams = list(base = "atrium_teams", args = c("season", "season_id", "competition_id", "locale"),
               what = "Teams of a season"),
  player_box = list(base = "atrium_box_score", args = c("fixture_id", "locale"), what = "Player box score of a game"),
  team_box = list(base = "atrium_team_box_score", args = c("fixture_id", "locale"), what = "Team box score of a game"),
  pbp = list(base = "atrium_pbp", args = c("fixture_id", "locale"), what = "Play-by-play of a game"),
  shots = list(base = "atrium_shots", args = c("fixture_id", "locale"), what = "Shot chart of a game")
)

#' Source lines of the package's R/ files, read once per session (roxygen `@eval` helpers only).
#' @noRd
.intl_rd_src <- new.env(parent = emptyenv())

#' The returns table (the `| col_name | type | description |` lines) of base wrapper `fn`'s
#' `@return`, read from its roxygen source at document time, so an alias topic carries the base's
#' table verbatim and is regenerated with it by the same `devtools::document()` run. Used by the
#' `@eval` Rd generators of the atrium, fiba and genius aliases; it aborts (failing `document()`)
#' when the base has no such table.
#' @noRd
.intl_base_returns_table <- function(fn) {
  dir <- file.path(getNamespaceInfo(topenv(), "path"), "R")
  if (is.null(.intl_rd_src[[dir]])) {
    files <- list.files(dir, pattern = "[.][Rr]$", full.names = TRUE)
    .intl_rd_src[[dir]] <- lapply(stats::setNames(files, files), readLines, warn = FALSE, encoding = "UTF-8")
  }
  for (lines in .intl_rd_src[[dir]]) {
    def <- grep(paste0("^", fn, " <- function"), lines)
    if (length(def) != 1L) next
    top <- def
    while (top > 1L && startsWith(lines[[top - 1L]], "#'")) top <- top - 1L
    block <- sub("^#' ?", "", lines[seq_len(def - top) + top - 1L])
    ret <- grep("^@return", block)
    if (length(ret) != 1L) break
    end <- c(grep("^@[A-Za-z]", block), length(block) + 1L)
    end <- min(end[end > ret])
    table <- grep("^[|]", block[seq_len(end - ret - 1L) + ret], value = TRUE)
    if (length(table) >= 3L && grepl("^[|] *col_name *[|] *type *[|] *description *[|]", table[[1]])) return(table)
    break
  }
  cli::cli_abort("{.fn {fn}}: no {.code | col_name | type | description |} table in its {.code @return} roxygen.",
                 .internal = TRUE)
}

#' One alias route's returns subsection: `## <alias>()`, the base it mirrors, and the base's table.
#' @noRd
.intl_alias_returns <- function(alias, base) {
  c("", paste0("## `", alias, "()`"), "", paste0("The columns of [", base, "()]:"), "",
    .intl_base_returns_table(base))
}

#' The atrium registry entry with `prefix`, or NULL when this package does not carry it.
#' @noRd
.atrium_competition <- function(prefix) {
  Find(function(e) identical(e$prefix, prefix), .intl_basketball_competitions$atrium)
}

#' @noRd
.atrium_alias_formals <- function(args) {
  as.pairlist(stats::setNames(lapply(args, function(a) if (a == "fixture_id") quote(expr = ) else NULL), args))
}

#' Define every alias of every registry entry in `env` (the package namespace).
#' @noRd
.atrium_mint_aliases <- function(env) {
  for (e in .intl_basketball_competitions$atrium) {
    for (suffix in names(.atrium_alias_specs)) {
      spec <- .atrium_alias_specs[[suffix]]
      call <- as.call(c(as.name(spec$base), list(website_id = as.integer(e$ids$website_id)),
                        stats::setNames(lapply(spec$args, as.name), spec$args)))
      assign(paste0(e$prefix, "_", suffix), rlang::new_function(.atrium_alias_formals(spec$args), call, env), envir = env)
    }
  }
  invisible(env)
}

#' NAMESPACE export lines for every minted alias (roxygen `@evalNamespace`).
#' @noRd
.atrium_competition_exports <- function() {
  unlist(lapply(.intl_basketball_competitions$atrium, function(e) {
    sprintf("export(%s_%s)", e$prefix, names(.atrium_alias_specs))
  }))
}

#' The roxygen block of one site's Rd (`<prefix>_competition`), or `@noRd` when this
#' package's registry does not carry the prefix (roxygen `@eval`).
#' @noRd
.atrium_competition_rd <- function(prefix) {
  e <- .atrium_competition(prefix)
  if (is.null(e)) return("@noRd")
  site <- as.integer(e$ids$website_id)
  gender <- c(men = "men's", women = "women's", both = "men's and women's")[[e$gender]]
  fns <- paste0(prefix, "_", names(.atrium_alias_specs))
  usage <- vapply(names(.atrium_alias_specs), function(s) {
    args <- .atrium_alias_specs[[s]]$args
    paste0(prefix, "_", s, "(", paste(ifelse(args == "fixture_id", args, paste(args, "= NULL")), collapse = ", "), ")")
  }, character(1))
  c(
    paste0("@name ", prefix, "_competition"),
    paste0("@aliases ", paste(fns, collapse = " ")),
    "@title",
    paste0("**", e$label, " (Atrium shortcuts)**"),
    "@description",
    paste0("**Per-competition shortcuts over the Atrium embed API for ", e$label, " (`website_id = ", site,
           "`; ", gender, ").**"),
    "",
    paste0("Thin bindings of the parameterised `atrium_*()` wrappers to this site, minted from the competition ",
           "registry (sdv-py `tools/codegen/basketball_competitions.yaml`); the full surface stays on the ",
           "`atrium_*()` wrappers."),
    paste0("@usage ", usage[[1]]), usage[-1],
    "@param season (*integer* optional): Season END year (season rule below). Omit `season` and `season_id` for the site's current season.",
    "@param season_id (*character* optional): Season UUID (`season_id` in the seasons listing); skips the END-year lookup.",
    "@param competition_id (*character* optional): Competition UUID (a site carries many: conferences, cups); needed when several share the season.",
    "@param locale (*character* optional): Label locale, e.g. `\"en-EN\"`; omitted = the site's own language.",
    "@param fixture_id (*character* required): Fixture UUID (`fixture_id` in the schedule).",
    "@return A `hoopR_data` tibble with the columns of the base wrapper, one table per function:",
    unlist(lapply(names(.atrium_alias_specs), function(s) {
      .intl_alias_returns(paste0(prefix, "_", s), .atrium_alias_specs[[s]]$base)
    })),
    "@details",
    paste0("Season rule: ", e$season_rule, "."),
    "",
    paste0("Errors and terms of use are those of [atrium_fixtures()]: unofficial use of the public widget endpoint, ",
           "at least 1 s between requests, not republished as release assets.",
           if (e$gender %in% c("women", "both")) " The site also serves women's competitions (pass their `competition_id`)." else ""),
    "",
    "```r",
    paste0(" ", prefix, "_seasons()"),
    paste0(" ", prefix, "_schedule()"),
    "```",
    "@family Atrium"
  )
}

#' @evalNamespace .atrium_competition_exports()
#' @noRd
NULL

#' @eval .atrium_competition_rd("lnb")
NULL

#' @eval .atrium_competition_rd("lnbp")
NULL

#' @eval .atrium_competition_rd("nbl1")
NULL

#' @eval .atrium_competition_rd("lmb")
NULL

#' @eval .atrium_competition_rd("lpb")
NULL
