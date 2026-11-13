#' @keywords internal
.load_nba_crosswalk <- function(seasons, tag, prefix, first = 2002, last = most_recent_nba_season(),
                                default = FALSE) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  # ESPN ids match every other hoopR dataset (integer); the assets publish
  # espn_game_id / espn_athlete_id as character. The NBA Stats team and
  # player ids are integer in the load_nba_stats_*() loaders, so they are cast
  # too; the zero-padded nba_game_id ("0022300001") stays character.
  loader <- function(url) {
    .ids_as_integer(rds_from_url(url), c(
      "espn_game_id", "espn_athlete_id", "espn_team_id",
      "home_espn_team_id", "away_espn_team_id",
      "nba_team_id", "nba_home_team_id", "nba_away_team_id", "nba_player_id"
    ))
  }

  url_for <- function(seasons) paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    tag, "/", prefix, "_", seasons, ".rds"
  )
  seasons <- .loader_seasons(seasons, first, last, fn = paste0("load_", prefix),
                             url_for = url_for, default = default)

  urls <- url_for(seasons)

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
#' @param seasons A vector of 4-digit seasons, or `TRUE` for every published
#'   season. Accepted seasons are the ones the release publishes: 2002 onward for
#'   the NBA crosswalks and `load_mbb_team_crosswalk()`, 2008 onward for
#'   `load_mbb_schedule_crosswalk()`, 2025 onward for `load_mbb_player_crosswalk()`;
#'   the upper bound is [most_recent_nba_season()] / [most_recent_mbb_season()]. When `seasons` is left at
#'   its default and that season's file is not published yet, the loader reads
#'   the newest published season instead, with a message. An explicit request
#'   for that not-yet-published season is kept as asked: the read warns and
#'   returns an empty frame. A season outside the published range, or in a
#'   known gap, is an error.
#'   ESPN ids (`espn_game_id`, `espn_athlete_id`, `espn_team_id`) are returned as
#'   integer, matching the ESPN box score, schedule and roster loaders. So
#'   are the NBA Stats ids of the NBA crosswalks (`nba_team_id`,
#'   `nba_home_team_id`, `nba_away_team_id`, `nba_player_id`), matching the
#'   `load_nba_stats_*()` loaders; `nba_game_id` keeps its leading zeros as
#'   character (`"0022300001"`). The live builders ([nba_team_crosswalk()]
#'   and friends) still return the NBA Stats ids as character.
#' @return Returns a tibble of class \code{hoopR_data} with one row per
#'   NBA team per season. Columns include at minimum \code{season},
#'   \code{espn_team_id}, and \code{nba_team_id}.
#' @source The `nba_crosswalk` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_crosswalk>.
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#' load_nba_team_crosswalk(seasons = most_recent_nba_season())
#' }
load_nba_team_crosswalk <- function(seasons = most_recent_nba_season()) {
  .load_nba_crosswalk(seasons, tag = "nba_crosswalk", prefix = "nba_team_crosswalk", default = missing(seasons))
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
#' @source The `nba_crosswalk` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_crosswalk>.
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#' load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
#' }
load_nba_schedule_crosswalk <- function(seasons = most_recent_nba_season()) {
  .load_nba_crosswalk(seasons, tag = "nba_crosswalk", prefix = "nba_schedule_crosswalk", default = missing(seasons))
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
#' @source The `nba_crosswalk` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_crosswalk>.
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#' load_nba_player_crosswalk(seasons = most_recent_nba_season())
#' }
load_nba_player_crosswalk <- function(seasons = most_recent_nba_season()) {
  .load_nba_crosswalk(seasons, tag = "nba_crosswalk", prefix = "nba_player_crosswalk", default = missing(seasons))
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
#' @source The `mbb_crosswalk` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#' load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
#' }
load_mbb_team_crosswalk <- function(seasons = most_recent_mbb_season()) {
  .load_nba_crosswalk(seasons, tag = "mbb_crosswalk", prefix = "mbb_team_crosswalk", last = most_recent_mbb_season(), default = missing(seasons))
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
#' @source The `mbb_crosswalk` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#' load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#' }
load_mbb_schedule_crosswalk <- function(seasons = most_recent_mbb_season()) {
  .load_nba_crosswalk(seasons, tag = "mbb_crosswalk", prefix = "mbb_schedule_crosswalk", first = 2008, last = most_recent_mbb_season(), default = missing(seasons))
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
#' @source The `mbb_crosswalk` release: <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#' load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
#' }
load_mbb_player_crosswalk <- function(seasons = most_recent_mbb_season()) {
  .load_nba_crosswalk(seasons, tag = "mbb_crosswalk", prefix = "mbb_player_crosswalk", first = 2025, last = most_recent_mbb_season(), default = missing(seasons))
}
