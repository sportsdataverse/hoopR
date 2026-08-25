#' @keywords internal
.load_nba_crosswalk <- function(seasons, tag, prefix) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  loader <- rds_from_url

  if (isTRUE(seasons)) seasons <- 2002:most_recent_nba_season()

  stopifnot(
    is.numeric(seasons),
    seasons >= 2002,
    seasons <= most_recent_nba_season()
  )

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    tag, "/", prefix, "_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  chunks <- lapply(urls, progressively(loader, p))
  .bind_crosswalk_chunks(chunks)
}

#' Bind crosswalk chunks and apply the public hoopR_data class
#' @noRd
.bind_crosswalk_chunks <- function(chunks) {
  meta_idx <- tail(which(vapply(
    chunks,
    function(x) {
      !is.null(attr(x, "hoopR_type")) || !is.null(attr(x, "hoopR_timestamp"))
    },
    logical(1)
  )), 1)

  out <- rbindlist_with_attrs(chunks)
  if (length(meta_idx) == 1L) {
    out <- make_hoopR_data(
      out,
      type = attr(chunks[[meta_idx]], "hoopR_type"),
      timestamp = attr(chunks[[meta_idx]], "hoopR_timestamp")
    )
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}


#' **Load hoopR NBA team crosswalk**
#' @name load_nba_team_crosswalk
NULL
#' @title
#' **Load cached NBA team crosswalk from the data repo**
#' @rdname load_nba_team_crosswalk
#' @description Loads a pre-built per-season NBA team crosswalk that maps ESPN
#' team identifiers to NBA.com identifiers and canonical abbreviations. The
#' files are versioned `.rds` snapshots stored in the `nba_crosswalk` release
#' of the sportsdataverse-data repository.
#' @param seasons A vector of 4-digit years associated with given NBA seasons.
#'   (Min: 2002; default: \code{most_recent_nba_season()})
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   NBA team per season. Columns include at minimum \code{season},
#'   \code{espn_team_id}, and \code{nba_team_id}.
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#' load_nba_team_crosswalk(seasons = most_recent_nba_season())
#' }
load_nba_team_crosswalk <- function(seasons = most_recent_nba_season()) {
  .load_nba_crosswalk(seasons, tag = "nba_crosswalk", prefix = "nba_team_crosswalk")
}


#' @title
#' **Load cached NBA schedule crosswalk from the data repo**
#' @rdname load_nba_team_crosswalk
#' @description Loads a pre-built per-season NBA schedule crosswalk that links
#' ESPN game identifiers to NBA.com game identifiers. The files are versioned
#' `.rds` snapshots stored in the `nba_crosswalk` release of the
#' sportsdataverse-data repository.
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   NBA game per season. Columns include at minimum \code{season},
#'   \code{espn_game_id}, and \code{nba_game_id}.
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#' load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
#' }
load_nba_schedule_crosswalk <- function(seasons = most_recent_nba_season()) {
  .load_nba_crosswalk(seasons, tag = "nba_crosswalk", prefix = "nba_schedule_crosswalk")
}


#' @title
#' **Load cached NBA player crosswalk from the data repo**
#' @rdname load_nba_team_crosswalk
#' @description Loads a pre-built per-season NBA player crosswalk that maps ESPN
#' athlete identifiers to NBA.com player identifiers. The files are versioned
#' `.rds` snapshots stored in the `nba_crosswalk` release of the
#' sportsdataverse-data repository.
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   NBA player per season. Columns include at minimum \code{season},
#'   \code{espn_athlete_id}, and \code{nba_player_id}.
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#' load_nba_player_crosswalk(seasons = most_recent_nba_season())
#' }
load_nba_player_crosswalk <- function(seasons = most_recent_nba_season()) {
  .load_nba_crosswalk(seasons, tag = "nba_crosswalk", prefix = "nba_player_crosswalk")
}


#' @title
#' **Load cached MBB team crosswalk from the data repo**
#' @rdname load_nba_team_crosswalk
#' @description Loads a pre-built per-season MBB team crosswalk that maps ESPN
#' team identifiers to Fox Sports (Bifrost), Bart Torvik, and KenPom identifiers
#' and canonical abbreviations. The files are versioned `.rds` snapshots stored
#' in the `mbb_crosswalk` release of the sportsdataverse-data repository.
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   MBB team per season. Columns include at minimum \code{season} and
#'   \code{espn_team_id}.
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#' load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
#' }
load_mbb_team_crosswalk <- function(seasons = most_recent_mbb_season()) {
  .load_nba_crosswalk(seasons, tag = "mbb_crosswalk", prefix = "mbb_team_crosswalk")
}


#' @title
#' **Load cached MBB schedule crosswalk from the data repo**
#' @rdname load_nba_team_crosswalk
#' @description Loads a pre-built per-season MBB schedule crosswalk that links
#' ESPN game identifiers to Bart Torvik game identifiers. The files are versioned
#' `.rds` snapshots stored in the `mbb_crosswalk` release of the
#' sportsdataverse-data repository.
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   MBB game per season. Columns include at minimum \code{season} and
#'   \code{espn_game_id}.
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#' load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#' }
load_mbb_schedule_crosswalk <- function(seasons = most_recent_mbb_season()) {
  .load_nba_crosswalk(seasons, tag = "mbb_crosswalk", prefix = "mbb_schedule_crosswalk")
}


#' @title
#' **Load cached MBB player crosswalk from the data repo**
#' @rdname load_nba_team_crosswalk
#' @description Loads a pre-built per-season MBB player crosswalk that maps ESPN
#' athlete identifiers to Fox Sports (Bifrost) player identifiers. The files are
#' versioned `.rds` snapshots stored in the `mbb_crosswalk` release of the
#' sportsdataverse-data repository.
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   MBB player per season. Columns include at minimum \code{season} and
#'   \code{espn_athlete_id}.
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#' load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
#' }
load_mbb_player_crosswalk <- function(seasons = most_recent_mbb_season()) {
  .load_nba_crosswalk(seasons, tag = "mbb_crosswalk", prefix = "mbb_player_crosswalk")
}
