#' @title
#' **CBD Teams**
#' @description
#' **Get college basketball teams from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter
#'   (e.g. `ACC`). See [cbbd_conferences()] for valid values.
#' @param season (*integer* optional): Season, in 4-digit format ending-year
#'   (e.g. `2024` for the 2023-24 season). Defaults to
#'   `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData team id. \cr
#'       source_id \tab character \tab Source (ESPN) team id. \cr
#'       school \tab character \tab School name. \cr
#'       mascot \tab character \tab Team mascot. \cr
#'       abbreviation \tab character \tab Team abbreviation. \cr
#'       display_name \tab character \tab Full team display name. \cr
#'       short_display_name \tab character \tab Short team display name. \cr
#'       primary_color \tab character \tab Primary team color (hex). \cr
#'       secondary_color \tab character \tab Secondary team color (hex). \cr
#'       current_venue_id \tab integer \tab Current home venue id. \cr
#'       current_venue \tab character \tab Current home venue name. \cr
#'       current_city \tab character \tab Current home venue city. \cr
#'       current_state \tab character \tab Current home venue state. \cr
#'       conference_id \tab integer \tab Conference id. \cr
#'       conference \tab character \tab Conference name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords CBD Teams
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Teams Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_teams(conference = "ACC"))
#' }
cbbd_teams <- function(conference = NULL, season = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/teams", query = list(conference = conference, season = season))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Teams from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no teams data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD teams", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Team Roster**
#' @rdname cbbd_teams
#' @description
#' **Get a college basketball team roster from the CollegeBasketballData API.**
#' @param team (*character* optional): Team name filter (e.g. `Duke`).
#' @return A `hoopR_data` tibble with one row per team. The `players` column is a
#'   nested list of roster players:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab integer \tab CollegeBasketballData team id. \cr
#'       team_source_id \tab character \tab Source (ESPN) team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference name. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       players \tab list \tab Nested list of roster players. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords CBD Teams
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Teams Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_teams_roster(season = 2024, team = "Duke"))
#' }
cbbd_teams_roster <- function(season = most_recent_mbb_season(), team = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/teams/roster", query = list(season = season, team = team))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Team Roster from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no roster data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team roster", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Team Directory**
#' @description
#' **Get the full team directory and conference metadata for a season from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, in 4-digit format ending-year
#'   (e.g. `2025` for the 2024-25 season). Defaults to
#'   `most_recent_mbb_season()`.
#' @return A named list of two `hoopR_data` tibbles, `teams` and `conferences`.
#'   Both carry the season as attributes: `season` (integer) and
#'   `season_label` (character, the upstream season label).
#'
#'   **teams** - one row per team:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData team id. \cr
#'       source_id \tab character \tab Source (ESPN) team id. \cr
#'       school \tab character \tab School name. \cr
#'       mascot \tab character \tab Team mascot. \cr
#'       abbreviation \tab character \tab Team abbreviation. \cr
#'       display_name \tab character \tab Full team display name. \cr
#'       short_display_name \tab character \tab Short team display name. \cr
#'       conference_id \tab integer \tab Conference id; joins to the id column of conferences. \cr
#'    }}
#'
#'   **conferences** - one row per conference:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab Conference id. \cr
#'       name \tab character \tab Conference name. \cr
#'       abbreviation \tab character \tab Conference abbreviation. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column tables.}
#'
#' @keywords CBD Teams
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Teams Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_teams_directory(season = 2025))
#' }
cbbd_teams_directory <- function(season = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- list()

  tryCatch(
    expr = {
      data <- .cbbd_get("/teams/directory", query = list(season = season))
      df <- list(
        teams = .cbbd_rows_tbl(data$teams),
        conferences = .cbbd_rows_tbl(data$conferences)
      )
      df <- lapply(df, function(x) {
        x <- make_hoopR_data(x, "CBD Team Directory from collegebasketballdata.com", Sys.time())
        attr(x, "season") <- data$season
        attr(x, "season_label") <- data$seasonLabel
        x
      })
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team directory data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team directory", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' Flatten a nested CBD record into one row's worth of named scalars
#'
#' @description Ported from cfbfastR's `.cfbd_flatten_scalars()`. Nested
#'   objects are walked with `_`-joined names; `NULL` becomes `NA`. One
#'   difference: an atomic vector longer than one (`sources$notes`) is kept,
#'   collapsed with `"; "`, instead of dropped. Data frames are skipped --
#'   array sections go through [.cbbd_rows_tbl()].
#' @keywords internal
#' @noRd
.cbbd_flatten_scalars <- function(x, prefix = "") {
  out <- list()
  if (is.null(x) || !length(x)) return(out)
  for (nm in names(x)) {
    v <- x[[nm]]
    key <- if (nzchar(prefix)) paste0(prefix, "_", nm) else nm
    if (is.null(v) || (is.atomic(v) && !length(v))) {
      out[[key]] <- NA
    } else if (is.atomic(v)) {
      out[[key]] <- if (length(v) == 1L) v else paste(v, collapse = "; ")
    } else if (is.list(v) && !is.data.frame(v) && !is.null(names(v))) {
      out <- c(out, .cbbd_flatten_scalars(v, key))
    }
  }
  out
}

#' One-row tibble from a nested CBD record; 0 columns when empty
#' @keywords internal
#' @noRd
.cbbd_record_tbl <- function(x) {
  flat <- .cbbd_flatten_scalars(x)
  if (!length(flat)) return(dplyr::tibble())
  janitor::clean_names(dplyr::as_tibble(flat))
}

#' Tibble from a CBD array of objects; 0 columns when empty
#' @keywords internal
#' @noRd
.cbbd_rows_tbl <- function(x) {
  if (!is.data.frame(x) || !nrow(x)) return(dplyr::tibble())
  janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(x)))
}
