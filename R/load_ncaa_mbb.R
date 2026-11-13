# NCAA MBB release-dataset loaders -- thin wrappers around rds_from_url()
# mirroring wehoop's load_ncaa_wbb.R loader shape. Backed by
# the sportsdataverse-py `ncaa_mbb` engine's published output on the `ncaa_mbb_*`
# sportsdataverse-data release tags.

# The NCAA <-> ESPN bridge columns are character in the assets; cast them to
# integer so they join to ESPN game_id / team_id. NCAA ids (contest_id,
# *_ncaa_team_id, player_id) are opaque and stay character.
.ncaa_mbb_rds <- function(url) {
  df <- rds_from_url(url)
  .ids_as_integer(df, grep("(^|_)espn_(game|team)_id$", names(df), value = TRUE))
}

#' @title
#' **Load cleaned NCAA men's college basketball play-by-play from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads season-level NCAA men's college basketball
#'   play-by-play. One row per event, with reconstructed 5-man lineups,
#'   possession numbering, shot context (transition/paint/second-chance), and
#'   an ESPN game-id crosswalk. Produced by the sportsdataverse-py `ncaa_mbb` engine
#'   (stats.ncaa.org play-by-play parsed, cleaned, and enriched); backed by
#'   the `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_pbp`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_pbp", inline = FALSE, unit = "play-by-play event")
#' @source The `ncaa_mbb_pbp` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_pbp>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~80 MB download.
#'   try(load_ncaa_mbb_pbp(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_pbp <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_pbp/ncaa_mbb_pbp_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball shot events from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads shot-chart events for NCAA men's college basketball --
#'   one row per field goal attempt, with court coordinates, distance, shot
#'   zone, and made/missed result. Coordinates are only available from the
#'   2019 season onward (stats.ncaa.org did not publish shot-location data
#'   before then), so `seasons` has a 2019 floor even though most sibling NCAA
#'   MBB datasets start at 2010. Produced by the sportsdataverse-py `ncaa_mbb` engine;
#'   backed by the `ncaa-mbb-hoops-data` pipeline, published to the
#'   `ncaa_mbb_shots` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_shots", inline = FALSE, unit = "shot attempt")
#' @source The `ncaa_mbb_shots` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_shots>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~10 MB download.
#'   try(load_ncaa_mbb_shots(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_shots <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2019:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2019),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_shots/ncaa_mbb_shots_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' **Load NCAA men's college basketball 5-man lineup stints from the data repo**
#' @name load_ncaa_mbb_lineups
NULL
#' @title
#' **Load NCAA men's college basketball 5-man lineup stints from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads reconstructed 5-man lineup stints for NCAA men's
#'   college basketball -- one row per contiguous stretch a specific 5-player
#'   lineup was on court for a team, with on/off scoring, shooting, and
#'   rebounding splits plus the matching opponent (`opp_*`) splits. Produced
#'   by the sportsdataverse-py `ncaa_mbb` engine's lineup reconstructor; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_lineups`
#'   release tag as csv.gz/parquet/rds.
#' @param seasons A vector of 4-digit season-ending years for NCAA men's
#'   college basketball (e.g. `2024` for the 2023-24 season). Published
#'   coverage runs 2010 through the most recent season, with no gaps. Pass
#'   `seasons = TRUE` for every published season. (Min: 2010)
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_lineups", inline = FALSE, unit = "lineup stint")
#' @source The `ncaa_mbb_lineups` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_lineups>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~20 MB download.
#'   try(load_ncaa_mbb_lineups(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_lineups <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_lineups/ncaa_mbb_lineups_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball 10-man matchup stints from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads reconstructed 10-man matchup stints (the home 5-man
#'   lineup crossed with the away 5-man lineup) for NCAA men's college
#'   basketball -- one row per contiguous stretch both lineups were on court
#'   together, with the score at stint start/end and both team's lineup
#'   rosters. Produced by the sportsdataverse-py `ncaa_mbb` engine's lineup reconstructor;
#'   backed by the `ncaa-mbb-hoops-data` pipeline, published to the
#'   `ncaa_mbb_matchup_stints` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_matchup_stints", inline = FALSE, unit = "matchup stint")
#' @source The `ncaa_mbb_matchup_stints` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_matchup_stints>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~12 MB download.
#'   try(load_ncaa_mbb_matchup_stints(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_matchup_stints <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_matchup_stints/ncaa_mbb_matchup_stints_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball possessions from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads possession-level data for NCAA men's college
#'   basketball -- one row per offensive possession, with the on-court 5-man
#'   lineups for both teams, points scored, assist/transition/garbage-time
#'   flags, and the possession's first and last event types. Produced by the
#'   sportsdataverse-py `ncaa_mbb` engine's possession detector; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_possessions`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_possessions", inline = FALSE, unit = "possession")
#' @source The `ncaa_mbb_possessions` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_possessions>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~17 MB download.
#'   try(load_ncaa_mbb_possessions(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_possessions <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_possessions/ncaa_mbb_possessions_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball within-team RAPM ratings from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads within-team regularized adjusted plus-minus (RAPM)
#'   ratings for NCAA men's college basketball -- one row per
#'   player-team-season, fit against teammate lineup variation within that
#'   team's own possessions (not a cross-team national RAPM). Produced by the
#'   sportsdataverse-py `ncaa_mbb` engine's RAPM model on top of the reconstructed
#'   lineup/possession data; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_rapm_within_team` release tag as
#'   csv.gz/parquet/rds. The default season falls back to the newest published
#'   one, with a message, until its file is published.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_rapm_within_team", inline = FALSE, unit = "player-team-season")
#' @source The `ncaa_mbb_rapm_within_team` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_rapm_within_team>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_rapm_within_team(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_rapm_within_team <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_", seasons, ".rds"
  )
  seasons <- .loader_seasons(seasons, 2010, most_recent_mbb_season(),
                             fn = "load_ncaa_mbb_rapm_within_team", url_for = url_for,
                             default = missing(seasons))
  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball league-wide RAPM ratings from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads league-wide regularized adjusted plus-minus (RAPM)
#'   ratings for NCAA men's college basketball -- one row per
#'   player-season, fit against lineup variation across all Division I
#'   stints for that season (not a within-team RAPM). Produced by the
#'   sportsdataverse-py `ncaa_mbb` engine's league-wide stint-ridge RAPM solver
#'   (Torvik-gated to Division I teams) on top of the reconstructed
#'   lineup/possession data; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_rapm` release tag as csv.gz/parquet/rds.
#' @details League-wide regularized adjusted plus-minus -- a single ridge
#'   fit over all Division I stints per season, distinct from
#'   [load_ncaa_mbb_rapm_within_team()]'s within-team fit. Published
#'   coverage runs seasons 2011 through 2026. The default season falls back to
#'   the newest published one, with a message, until its file is published.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_rapm", inline = FALSE, unit = "player-season")
#' @source The `ncaa_mbb_rapm` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_rapm>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_rapm(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_rapm <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  url_for <- function(seasons) paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_rapm/ncaa_mbb_rapm_", seasons, ".rds"
  )
  seasons <- .loader_seasons(seasons, 2011, most_recent_mbb_season(),
                             fn = "load_ncaa_mbb_rapm", url_for = url_for,
                             default = missing(seasons))
  urls <- url_for(seasons)

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball advanced player box scores from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads advanced per-player, per-game box scores for NCAA
#'   men's college basketball -- one row per player-game, with shooting
#'   splits by zone (rim/mid/3), transition and half-court splits,
#'   assisted-vs-unassisted splits, and shot-zone efficiency rates. A superset
#'   of the traditional box score
#'   (points/rebounds/assists/steals/blocks/turnovers/fouls are included
#'   alongside the advanced splits). Produced by the sportsdataverse-py `ncaa_mbb` engine;
#'   backed by the `ncaa-mbb-hoops-data` pipeline, published to the
#'   `ncaa_mbb_player_box` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_player_box", inline = FALSE, unit = "player-game")
#' @source The `ncaa_mbb_player_box` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_player_box>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # One season is a ~10 MB download.
#'   try(load_ncaa_mbb_player_box(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_player_box <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_player_box/ncaa_mbb_player_box_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball advanced team box scores from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads advanced per-team, per-game box scores for NCAA men's
#'   college basketball -- one row per team-game, with offensive/defensive
#'   ratings, shot-zone rates and efficiency (rim/mid/3),
#'   rebounding/assist/turnover rates, and the matching opponent (`d_*`)
#'   splits. Produced by the sportsdataverse-py `ncaa_mbb` engine; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_team_box`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_team_box", inline = FALSE, unit = "team-game")
#' @source The `ncaa_mbb_team_box` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_team_box>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_team_box(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_team_box <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_team_box/ncaa_mbb_team_box_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball season rosters from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads a lightweight season roster for NCAA men's college
#'   basketball -- one row per player-team-season with a games-played count.
#'   For the fuller roster (jersey, class, position, height, hometown, high
#'   school), use [load_ncaa_mbb_team_rosters()]. Produced by the sportsdataverse-py
#'   `ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_rosters` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_rosters", inline = FALSE, unit = "player-team-season")
#' @source The `ncaa_mbb_rosters` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_rosters>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_rosters(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_rosters <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_rosters/ncaa_mbb_rosters_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load full NCAA men's college basketball team rosters from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads the full season roster for NCAA men's college
#'   basketball -- one row per player-team-season with jersey number, class
#'   year, position, height, hometown, high school, and games played/started.
#'   Produced by the sportsdataverse-py `ncaa_mbb` engine; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_team_rosters`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_team_rosters", inline = FALSE, unit = "player-team-season")
#' @source The `ncaa_mbb_team_rosters` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_team_rosters>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_team_rosters(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_team_rosters <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_team_rosters/ncaa_mbb_team_rosters_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load NCAA men's college basketball schedules from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads season schedules/results for NCAA men's college
#'   basketball -- one row per game with home/away teams and final scores.
#'   Produced by the sportsdataverse-py `ncaa_mbb` engine; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_schedule`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_schedule", inline = FALSE, unit = "game")
#' @source The `ncaa_mbb_schedule` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_schedule>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_schedule(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_schedule <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_schedule/ncaa_mbb_schedule_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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


#' @title
#' **Load the NCAA men's college basketball team-id crosswalk from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads the season-level stats.ncaa.org team-id / conference
#'   crosswalk for NCAA men's college basketball -- one row per team-season.
#'   Useful for joining `ncaa_team_id` columns on the other `ncaa_mbb_*`
#'   datasets back to a team name and conference. Produced by the sportsdataverse-py
#'   `ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_team_ids` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_ncaa_mbb_team_ids", inline = FALSE, unit = "team-season")
#' @source The `ncaa_mbb_team_ids` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_team_ids>, published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_team_ids(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_team_ids <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- .ncaa_mbb_rds
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_team_ids/ncaa_mbb_team_ids_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

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

