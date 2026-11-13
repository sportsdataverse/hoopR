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
#' @eval .returns_rd("load_mbb_groups", unit = "group lineage")
#' @source The `mbb_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}

#' @rdname load_mbb_groups
#' @source The `nba_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @eval .returns_rd("load_mbb_group_seasons", unit = "group-season")
#' @source The `mbb_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}

#' @rdname load_mbb_group_seasons
#' @source The `nba_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @eval .returns_rd("load_mbb_group_aliases", unit = "alias")
#' @source The `mbb_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}

#' @rdname load_mbb_group_aliases
#' @source The `nba_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @eval .returns_rd("load_mbb_team_group_seasons", unit = "team-season")
#' @source The `mbb_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
  }
  out
}

#' @rdname load_mbb_team_group_seasons
#' @source The `nba_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.frame")
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
#' @eval .returns_rd("load_mbb_team_aliases", unit = "team alias")
#' @return `NULL` instead, after appending the rows to `tablename`, when `dbConnection` and
#'   `tablename` are both given.
#' @source The `mbb_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.
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
#' @source The `nba_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.
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
#' @eval .returns_rd("load_mbb_player_aliases", unit = "player alias")
#' @return `NULL` instead, after appending the rows to `tablename`, when `dbConnection` and
#'   `tablename` are both given.
#' @source The `mbb_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.
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
#' @source The `nba_groups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.
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
