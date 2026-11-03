# Conference / division group loaders for the `mbb_groups` and `nba_groups`
# release tags on sportsdataverse-data, published by
# sportsdataverse/sdv-reference-data (table contract: that repo's CONTRACT.md).
# Parquet only -- the tags' csv siblings would re-type the character ids
# ("150") as integers. Same shape as the load_models.R loaders.

#' **Load conference and division lineages (MBB / NBA) from the data repo**
#' @name load_mbb_groups
NULL
#' @title
#' **Load conference and division lineages (MBB / NBA) from the data repo**
#' @rdname load_mbb_groups
#' @author Saiem Gilani
#' @description Loads one row per group lineage -- the league or subdivision,
#'   each conference, and each division -- with the first and last season
#'   each had at least one member. A lineage keeps one `group_id` across
#'   renames that keep continuity (American Athletic to American stays
#'   `mbb:american`); a new body gets a new id. `load_mbb_groups()` reads the
#'   `mbb_groups` release tag and `load_nba_groups()` the `nba_groups` tag.
#'
#'   See [load_mbb_group_seasons()] for per-season names and parents,
#'   [load_mbb_group_aliases()] for the names and ids other sources use, and
#'   [load_mbb_team_group_seasons()] for team membership.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per group lineage.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League key: \code{mbb} or \code{nba}. \cr
#'       group_id \tab character \tab SDV group id, \code{\{league\}:\{slug\}} (e.g. \code{mbb:big-east}, \code{nba:atlantic}); one id per lineage across renames. \cr
#'       level \tab character \tab Group level: \code{league} (NBA), \code{subdivision} (MBB Division I), \code{conference}, or \code{division}. \cr
#'       first_season \tab integer \tab First season (ending year) with at least one member. \cr
#'       last_season \tab integer \tab Last season (ending year) with at least one member. \cr
#'       notes \tab character \tab Lineage decisions and source caveats. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family Conference and Division Group loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_groups())
#' }
load_mbb_groups <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_groups/mbb_groups.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

#' @rdname load_mbb_groups
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_groups())
#' }
load_nba_groups <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_groups/nba_groups.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Load conference and division names by season (MBB / NBA) from the data repo**
#' @name load_mbb_group_seasons
NULL
#' @title
#' **Load conference and division names by season (MBB / NBA) from the data repo**
#' @rdname load_mbb_group_seasons
#' @author Saiem Gilani
#' @description Loads one row per group per season it existed, with the
#'   group's name, short name, abbreviation, and parent group **as of that
#'   season** rather than today's labels, plus its member count.
#'   `load_mbb_group_seasons()` reads the `mbb_groups` release tag and
#'   `load_nba_group_seasons()` the `nba_groups` tag.
#' @inheritParams load_mbb_groups
#' @return Returns a `hoopR_data` tibble with one row per group-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League key: \code{mbb} or \code{nba}. \cr
#'       group_id \tab character \tab SDV group id, \code{\{league\}:\{slug\}}. \cr
#'       season \tab integer \tab Season (ending year; 2025 = 2024-25). \cr
#'       level \tab character \tab Group level: \code{league}, \code{subdivision}, \code{conference}, or \code{division}. \cr
#'       name \tab character \tab Group name as of that season. \cr
#'       short_name \tab character \tab Group short name as of that season. \cr
#'       abbreviation \tab character \tab Group abbreviation as of that season. \cr
#'       parent_group_id \tab character \tab Parent group id as of that season (division to conference to subdivision or league). \cr
#'       n_teams \tab integer \tab Number of member teams that season. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family Conference and Division Group loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_group_seasons())
#' }
load_mbb_group_seasons <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_groups/mbb_group_seasons.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

#' @rdname load_mbb_group_seasons
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_group_seasons())
#' }
load_nba_group_seasons <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_groups/nba_group_seasons.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Load conference and division aliases (MBB / NBA) from the data repo**
#' @name load_mbb_group_aliases
NULL
#' @title
#' **Load conference and division aliases (MBB / NBA) from the data repo**
#' @rdname load_mbb_group_aliases
#' @author Saiem Gilani
#' @description Loads every name and id that a source (ESPN, NCAA, KenPom,
#'   NBA Stats, SDV) uses for a group, with the seasons each alias is valid
#'   for. Use it to map a source's conference id or name onto an SDV
#'   `group_id`. `load_mbb_group_aliases()` reads the `mbb_groups` release tag
#'   and `load_nba_group_aliases()` the `nba_groups` tag.
#' @inheritParams load_mbb_groups
#' @return Returns a `hoopR_data` tibble with one row per alias.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League key: \code{mbb} or \code{nba}. \cr
#'       group_id \tab character \tab SDV group id, \code{\{league\}:\{slug\}}. \cr
#'       source \tab character \tab Source that uses the alias: \code{espn}, \code{ncaa}, \code{kenpom} or \code{sdv} (MBB); \code{espn}, \code{nba_stats} or \code{sdv} (NBA). \cr
#'       source_id \tab character \tab The source's own id for the group (e.g. ESPN group id, NCAA conference id), when it has one. \cr
#'       name_kind \tab character \tab Kind of alias: \code{name}, \code{short_name}, \code{abbreviation}, \code{slug}, or \code{code}. \cr
#'       value \tab character \tab The alias itself. \cr
#'       valid_from \tab integer \tab First season (ending year) the alias applies, inclusive; \code{NA} means unbounded. \cr
#'       valid_to \tab integer \tab Last season (ending year) the alias applies, inclusive; \code{NA} means unbounded. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family Conference and Division Group loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_group_aliases())
#' }
load_mbb_group_aliases <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_groups/mbb_group_aliases.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

#' @rdname load_mbb_group_aliases
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_group_aliases())
#' }
load_nba_group_aliases <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_groups/nba_group_aliases.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Load team conference membership by season (MBB / NBA) from the data repo**
#' @name load_mbb_team_group_seasons
NULL
#' @title
#' **Load team conference membership by season (MBB / NBA) from the data repo**
#' @rdname load_mbb_team_group_seasons
#' @author Saiem Gilani
#' @description Loads one row per team per season with the team's
#'   subdivision, conference, and division that season, taken from the most
#'   reliable per-season source and cross-checked against a second source
#'   where one exists. Membership is never back-filled from today's
#'   alignment. `load_mbb_team_group_seasons()` reads the `mbb_groups`
#'   release tag and `load_nba_team_group_seasons()` the `nba_groups` tag.
#' @param seasons A vector of 4-digit season-ending years (2025 = 2024-25).
#'   Published coverage runs from 2002 (MBB) or 1971 (NBA) through the most
#'   recent season. Pass `seasons = TRUE` to read every published season from one file.
#'   (Min: 2002 for MBB, 1971 for NBA)
#' @inheritParams load_mbb_groups
#' @return Returns a `hoopR_data` tibble with one row per team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League key: \code{mbb} or \code{nba}. \cr
#'       season \tab integer \tab Season (ending year; 2025 = 2024-25). \cr
#'       team_id \tab character \tab ESPN team id. \cr
#'       team_id_source \tab character \tab Id system of \code{team_id}: \code{espn}. \cr
#'       team_name \tab character \tab Team name as of that season. \cr
#'       subdivision_id \tab character \tab SDV group id of the subdivision (\code{mbb:d1}); \code{NA} for the NBA. \cr
#'       conference_id \tab character \tab SDV group id of the conference. \cr
#'       division_id \tab character \tab SDV group id of the division; \code{NA} where the league or conference had none. \cr
#'       source \tab character \tab Source the membership came from: \code{espn_standings}, \code{espn_core_groups} or \code{kenpom} (MBB); \code{nba_stats} or \code{curated} (NBA). \cr
#'       sources_agree \tab logical \tab Whether a second source agrees; \code{NA} when only one source covers the season. \cr
#'       notes \tab character \tab Membership caveats. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family Conference and Division Group loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_team_group_seasons(seasons = most_recent_mbb_season()))
#' }
load_mbb_team_group_seasons <- function(seasons = most_recent_mbb_season(),
                                        ...,
                                        dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  loader <- parquet_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) {
    # the release's single all-seasons file
    files <- "mbb_team_group_seasons"
  } else {
    stopifnot(is.numeric(seasons),
              all(seasons >= 2002),
              all(seasons == trunc(seasons)))
    files <- paste0("mbb_team_group_seasons_", unique(seasons))
  }

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "mbb_groups/", files, ".parquet"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = urls)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

#' @rdname load_mbb_team_group_seasons
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_team_group_seasons(seasons = most_recent_nba_season()))
#' }
load_nba_team_group_seasons <- function(seasons = most_recent_nba_season(),
                                        ...,
                                        dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  loader <- parquet_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) {
    # the release's single all-seasons file
    files <- "nba_team_group_seasons"
  } else {
    stopifnot(is.numeric(seasons),
              all(seasons >= 1971),
              all(seasons == trunc(seasons)))
    files <- paste0("nba_team_group_seasons_", unique(seasons))
  }

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_groups/", files, ".parquet"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = urls)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Load provider team id and name aliases (MBB / NBA) from the data repo**
#' @name load_mbb_team_aliases
NULL
#' @title
#' **Load provider team id and name aliases (MBB / NBA) from the data repo**
#' @rdname load_mbb_team_aliases
#' @author Saiem Gilani
#' @description Loads every team id and name another source uses for an
#'   ESPN team, with the seasons the source shows it on that team. Use it to
#'   map a Fox, Yahoo, CBS, 247Sports, On3, KenPom, Torvik, NCAA or NBA Stats
#'   team id or name onto the ESPN `team_id`. A source id means something
#'   only within its source (Fox 25 is not ESPN 25), so always join on
#'   `source` as well. `load_mbb_team_aliases()` reads the `mbb_groups`
#'   release tag and `load_nba_team_aliases()` the `nba_groups` tag.
#'
#'   See [load_mbb_player_aliases()] for player ids and
#'   [load_mbb_group_aliases()] for conference and division aliases.
#' @inheritParams load_mbb_groups
#' @return Returns a `hoopR_data` tibble with one row per team alias, or `NULL` after
#'   appending the rows to `tablename` when `dbConnection` and `tablename` are both given.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League key: \code{mbb} or \code{nba}. \cr
#'       team_id \tab character \tab ESPN team id. \cr
#'       team_id_source \tab character \tab Id system of \code{team_id}: \code{espn}. \cr
#'       source \tab character \tab Source that uses the alias: \code{fox}, \code{yahoo}, \code{torvik}, \code{kenpom}, \code{ncaa}, \code{sports247} (247Sports) or \code{on3} (MBB); \code{fox}, \code{yahoo}, \code{cbs} or \code{nba_stats} (NBA). \cr
#'       source_id \tab character \tab The source's own team id (e.g. \code{25}, \code{nba.t.1}); \code{NA} for a name-only source (KenPom, Torvik). \cr
#'       id_kind \tab character \tab \code{team} (the source's id for this sport's team) or \code{school} (one id for every sport of a school: the stats.ncaa.org org id, 247Sports \code{institutionKey}, On3 \code{orgKey}). \cr
#'       name_kind \tab character \tab \code{name} or \code{abbreviation} when the source gives its own spelling, else \code{NA}. An id with a name and an abbreviation is two rows. \cr
#'       value \tab character \tab The source's own spelling of the name or abbreviation; \code{NA} when \code{name_kind} is \code{NA}. \cr
#'       valid_from \tab integer \tab First season (ending year) the source shows this id or name on the team, inclusive. \cr
#'       valid_to \tab integer \tab Last season (ending year) the source shows this id or name on the team, inclusive; a gap in the source splits the window into two rows. \cr
#'       match_method \tab character \tab How the row was matched: \code{deterministic} (a formula or shared key), \code{crosswalk} (carried from a published crosswalk), \code{curated} (a cited hand-made map); for a captured team directory, \code{alias}, \code{exact_name} (normalized name) or \code{dict} (curated name dictionary). \cr
#'       evidence \tab character \tab The asset or file the row came from. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family Conference and Division Group loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_team_aliases())
#' }
load_mbb_team_aliases <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_groups/mbb_team_aliases.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}

#' @rdname load_mbb_team_aliases
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_team_aliases())
#' }
load_nba_team_aliases <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_groups/nba_team_aliases.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}


#' **Load provider player id aliases (MBB / NBA) from the data repo**
#' @name load_mbb_player_aliases
NULL
#' @title
#' **Load provider player id aliases (MBB / NBA) from the data repo**
#' @rdname load_mbb_player_aliases
#' @author Saiem Gilani
#' @description Loads every player id another source uses for an ESPN
#'   athlete, with the ESPN team the athlete was on and the seasons the id
#'   held. Use it to map an NCAA (stats.ncaa.org), Fox, Yahoo, KenPom or NBA
#'   Stats player id onto the ESPN `athlete_id`. stats.ncaa.org roster ids
#'   are new every season, so an NCAA player has one row per season.
#'   Unmatched provider ids are not included. `load_mbb_player_aliases()`
#'   reads the `mbb_groups` release tag and `load_nba_player_aliases()` the
#'   `nba_groups` tag.
#'
#'   See [load_mbb_team_aliases()] for team ids and names.
#' @inheritParams load_mbb_groups
#' @return Returns a `hoopR_data` tibble with one row per player alias, or `NULL` after
#'   appending the rows to `tablename` when `dbConnection` and `tablename` are both given.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League key: \code{mbb} or \code{nba}. \cr
#'       athlete_id \tab character \tab ESPN athlete id. \cr
#'       athlete_id_source \tab character \tab Id system of \code{athlete_id}: \code{espn}. \cr
#'       source \tab character \tab Source of the player id: \code{ncaa}, \code{fox}, \code{yahoo} or \code{kenpom} (MBB); \code{nba_stats}, \code{fox} or \code{yahoo} (NBA). \cr
#'       source_player_id \tab character \tab The source's own player id (e.g. \code{nba.p.5637}, \code{76284}). \cr
#'       team_id \tab character \tab ESPN team id of the team the athlete was on when matched. \cr
#'       source_team_id \tab character \tab The source's own team id when it gives one (the season's stats.ncaa.org team id), else \code{NA}. \cr
#'       valid_from \tab integer \tab First season (ending year) the id is on that team, inclusive. \cr
#'       valid_to \tab integer \tab Last season (ending year) the id is on that team, inclusive; a gap or a change of match method splits the window into two rows. \cr
#'       match_method \tab character \tab How the id was matched: the source leg's own method (\code{exact_name}, \code{fuzzy_jw}; NCAA \code{name_jersey}, \code{name}, \code{last_jersey}, \code{jaro_winkler}), \code{crosswalk} (a leg that names none), \code{propagated} (carried from the same id's match in another season) or \code{override} (a hand-verified fix). \cr
#'       match_confidence \tab numeric \tab The leg's own confidence where it gives one (the lowest in the window; NCAA tiers score 1, 0.95, 0.9 and 0.85), else \code{NA}. \cr
#'       evidence \tab character \tab The asset or file the row came from. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family Conference and Division Group loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_player_aliases())
#' }
load_mbb_player_aliases <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_groups/mbb_player_aliases.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}

#' @rdname load_mbb_player_aliases
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_player_aliases())
#' }
load_nba_player_aliases <- function(..., dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old), add = TRUE)

  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  out <- parquet_from_url(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_groups/nba_player_aliases.parquet"
  )
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}
