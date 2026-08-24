# Model-dataset release loaders, mirroring the load_ncaa_mbb.R loader shape.
# Backed by the sdv-py model programs described in CLAUDE.md
# (nba-possession-engine-program, mbb-wbb-player-value-spine).
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
#'   the sdv-py NBA/WNBA possession-engine model program; published to the
#'   `nba_player_impact` release tag as csv/parquet/rds.
#' @param seasons A vector of 4-digit years associated with given NBA
#'   seasons. Published coverage runs 1997 through the most recent season,
#'   with no gaps. Pass `seasons = TRUE` for every published season. (Min:
#'   1997)
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player_id \tab integer \tab Unique NBA Stats player identifier. \cr
#'       player_name \tab character \tab Player display name. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_abbreviation \tab character \tab Team abbreviation. \cr
#'       team_name \tab character \tab Full team display name. \cr
#'       teams \tab character \tab Team abbreviation(s) the player appeared for this season. \cr
#'       season \tab integer \tab Season identifier (4-digit year). \cr
#'       season_type \tab character \tab Season portion (e.g. 'Regular Season'). \cr
#'       o_rapm \tab numeric \tab Offensive regularized adjusted plus-minus. \cr
#'       d_rapm \tab numeric \tab Defensive regularized adjusted plus-minus. \cr
#'       rapm \tab numeric \tab Net regularized adjusted plus-minus (o_rapm + d_rapm). \cr
#'       off_poss \tab integer \tab Offensive possessions used in the RAPM fit. \cr
#'       def_poss \tab integer \tab Defensive possessions used in the RAPM fit. \cr
#'       o_adj_rapm \tab numeric \tab Offensive RAPM adjusted for minutes/possession stability. \cr
#'       d_adj_rapm \tab numeric \tab Defensive RAPM adjusted for minutes/possession stability. \cr
#'       adj_rapm \tab numeric \tab Net adjusted RAPM (o_adj_rapm + d_adj_rapm). \cr
#'       ospm \tab numeric \tab Offensive statistical plus-minus (box-score component). \cr
#'       dspm \tab numeric \tab Defensive statistical plus-minus (box-score component). \cr
#'       spm \tab numeric \tab Net statistical plus-minus. \cr
#'       min \tab numeric \tab Minutes played. \cr
#'       gp \tab integer \tab Games played. \cr
#'       obpm \tab numeric \tab Offensive box plus-minus. \cr
#'       dbpm \tab numeric \tab Defensive box plus-minus. \cr
#'       bpm \tab numeric \tab Net box plus-minus. \cr
#'       war \tab numeric \tab Wins above replacement. \cr
#'       darko_filtered_skill \tab numeric \tab DARKO-style filtered skill rating. \cr
#'       darko_projected_rating \tab numeric \tab DARKO-style forward-looking projected rating. \cr
#'       darko_projected_sd \tab numeric \tab Standard deviation of the DARKO-style projected rating. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
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
#'   csv/rds sibling assets. Produced by the sdv-py NCAA MBB model program;
#'   published to the `mbb_player_value` release tag.
#' @param seasons A vector of 4-digit season-ending years for NCAA men's
#'   college basketball. Published coverage runs 2006 through the most recent
#'   season, with no gaps. Pass `seasons = TRUE` for every published season.
#'   (Min: 2006)
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player_id \tab character \tab stats.ncaa.org player identifier. \cr
#'       player \tab character \tab Player display name (title-cased). \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       min \tab numeric \tab Minutes played. \cr
#'       box_obpm \tab numeric \tab Box-score offensive box plus-minus. \cr
#'       box_dbpm \tab numeric \tab Box-score defensive box plus-minus. \cr
#'       box_bpm \tab numeric \tab Box-score net box plus-minus (box_obpm + box_dbpm). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
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
#'   csv/rds sibling assets. Produced by the sdv-py NCAA MBB model program;
#'   published to the `mbb_ratings` release tag.
#' @param seasons A vector of 4-digit season-ending years for NCAA men's
#'   college basketball. Published coverage runs 2006 through the most recent
#'   season, with no gaps. Pass `seasons = TRUE` for every published season.
#'   (Min: 2006)
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       adj_o \tab numeric \tab Adjusted offensive efficiency (points per 100 possessions, opponent-adjusted). \cr
#'       adj_d \tab numeric \tab Adjusted defensive efficiency (points allowed per 100 possessions, opponent-adjusted). \cr
#'       adj_em \tab numeric \tab Adjusted efficiency margin (adj_o minus adj_d). \cr
#'       adj_tempo \tab numeric \tab Adjusted possessions per 40 minutes. \cr
#'       raw_o \tab numeric \tab Unadjusted (raw) offensive efficiency. \cr
#'       raw_d \tab numeric \tab Unadjusted (raw) defensive efficiency. \cr
#'       games \tab integer \tab Games played (season total). \cr
#'       rank \tab integer \tab National rank by adj_em. \cr
#'       adj_em_z \tab numeric \tab Z-score of adj_em relative to the season's team distribution. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}
