# Model-dataset release loaders, mirroring the load_ncaa_mbb.R loader shape.
# Backed by the sportsdataverse-py model programs that publish these
# releases (NBA possession engine, MBB/WBB player value).
# nba_player_impact ships csv/parquet/rds -- rds_from_url() is used to match
# the NBA loader family convention. mbb_player_value / mbb_ratings are
# parquet-only (no csv/rds sibling assets), so those two use parquet_from_url().

#' @title
#' **Load NBA player-impact ratings (RAPM / SPM / BPM / DARKO) from the data repo**
#' @rdname load_mbb_player_value
#' @author Saiem Gilani
#' @description Loads season-level NBA player-impact ratings -- one row per
#'   player-team-season, combining regularized adjusted plus-minus (RAPM),
#'   statistical plus-minus (SPM), box plus-minus (BPM), wins above
#'   replacement (WAR), and a DARKO-style skill/projection pair. Produced by
#'   the sportsdataverse-py NBA/WNBA possession-engine model program; published to the
#'   `nba_player_impact` release tag as csv/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_player_impact", unit = "player-team-season")
#' @source The `nba_player_impact` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_player_impact>.
#' @export
#' @family Model Dataset loader functions
#' @examples
#' \donttest{
#'   try(load_nba_player_impact(seasons = most_recent_nba_season()))
#' }
load_nba_player_impact <- function(seasons = most_recent_nba_season(),
                            ...,
                            dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 1997:most_recent_nba_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 1997),
            all(seasons <= most_recent_nba_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "nba_player_impact/nba_player_impact_", seasons, ".rds"
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
#' **Load NBA current-impact ratings (weekly as-of ratings) from the data repo**
#' @rdname load_mbb_player_value
#' @author Saiem Gilani
#' @description Loads the `nba_current_impact` release: each NBA player's
#'   current offensive/defensive impact (points per 100 possessions) as of
#'   opening night and every 7 days after, from every game before that date
#'   -- a box-score prior plus a Kalman-filtered deviation carried across
#'   seasons. Where [load_nba_player_impact()] says what a player did in a
#'   season, this says what to expect from him on a date. Produced by the
#'   sportsdataverse-py `nba_current_impact()` model (published by
#'   `hoopR-nba-stats-data`'s `nba_model_publish current-impact`); `player_id`
#'   is the NBA Stats `person_id`. Coverage is 2007 (2006-07) to 2026.
#' @eval .returns_rd("load_nba_current_impact", unit = "player per as-of date")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_current_impact>
#' @export
#' @examples
#' \donttest{
#'   try(load_nba_current_impact(seasons = 2026))
#' }
load_nba_current_impact <- function(seasons = most_recent_nba_season(),
                                    ...,
                                    dbConnection = NULL, tablename = NULL) {
  # END-year seasons, like load_nba_player_impact(): the asset suffix and the
  # `season` column are both the END year.
  .load_release_assets("load_nba_current_impact", "nba_current_impact",
                       list(list(stem = "nba_current_impact", stamps = list())), seasons,
                       first = 2007, last = most_recent_nba_season(),
                       default = missing(seasons), offset = 0L, ext = "rds",
                       dbConnection = dbConnection, tablename = tablename, ...)
}


#' **Load NCAA men's college basketball player-value ratings (box BPM) from the data repo**
#' @name load_mbb_player_value
NULL
#' @title
#' **Load NCAA men's college basketball player-value ratings (box BPM) from the data repo**
#' @rdname load_mbb_player_value
#' @author Saiem Gilani
#' @description Loads season-level NCAA men's college basketball
#'   player-value ratings -- one row per player-team-season, with a
#'   box-score-derived offensive/defensive/net box plus-minus (BPM). Coverage
#'   starts at 2006 (the earliest season with published box-score inputs of
#'   sufficient quality for the model); this tag is parquet-only, with no
#'   csv/rds sibling assets. Produced by the sportsdataverse-py NCAA MBB model program;
#'   published to the `mbb_player_value` release tag.
#' @param seasons A vector of 4-digit season-ending years for NCAA men's
#'   college basketball. Published coverage runs 2006 through the most recent
#'   season, with no gaps. Pass `seasons = TRUE` for every published season.
#'   (Min: 2006)
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_mbb_player_value", unit = "player-team-season")
#' @source The `mbb_player_value` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_player_value>.
#' @export
#' @family Model Dataset loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_player_value(seasons = most_recent_mbb_season()))
#' }
load_mbb_player_value <- function(seasons = most_recent_mbb_season(),
                            ...,
                            dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- parquet_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2006:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2006),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "mbb_player_value/mbb_player_value_", seasons, ".parquet"
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
#' **Load NCAA men's college basketball adjusted efficiency team ratings from the data repo**
#' @rdname load_mbb_player_value
#' @author Saiem Gilani
#' @description Loads season-level NCAA men's college basketball team
#'   ratings -- one row per team-season, with adjusted
#'   (opponent-strength-normalized) offensive/defensive efficiency, adjusted
#'   tempo, raw efficiency, and a national rank. A KenPom-style
#'   adjusted-efficiency-margin rating. This tag is parquet-only, with no
#'   csv/rds sibling assets. Produced by the sportsdataverse-py NCAA MBB model program;
#'   published to the `mbb_ratings` release tag.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_mbb_ratings", unit = "team-season")
#' @source The `mbb_ratings` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_ratings>.
#' @export
#' @family Model Dataset loader functions
#' @examples
#' \donttest{
#'   try(load_mbb_ratings(seasons = most_recent_mbb_season()))
#' }
load_mbb_ratings <- function(seasons = most_recent_mbb_season(),
                            ...,
                            dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- parquet_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2006:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2006),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "mbb_ratings/mbb_ratings_", seasons, ".parquet"
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
