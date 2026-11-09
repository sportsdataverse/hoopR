#' @title
#' **CBD Teams**
#' @description
#' **Get college basketball teams from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter
#'   (e.g. `ACC`). See [cbbd_conferences()] for valid values.
#' @param season (*integer* optional): Season, in 4-digit format ending-year
#'   (e.g. `2024` for the 2023-24 season). Defaults to
#'   `most_recent_mbb_season()`.
#' @eval .returns_rd("cbbd_teams", inline = FALSE, unit = "team")
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
#' @eval .returns_rd("cbbd_teams_roster", inline = FALSE, unit = "team")
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
#' @eval .returns_rd("cbbd_teams_directory", inline = FALSE)
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

#' @title
#' **CBD Team Season Overview**
#' @description
#' **Get a stored full-season overview of one team from the CollegeBasketballData API.**
#' @param team_id (*integer* required): CollegeBasketballData team id. See
#'   [cbbd_teams()] or [cbbd_teams_directory()] for valid values.
#' @param season (*integer* required): Season, in 4-digit format ending-year
#'   (e.g. `2025` for the 2024-25 season). Defaults to
#'   `most_recent_mbb_season()`.
#' @eval .returns_rd("cbbd_teams_season_overview", inline = FALSE)
#' @keywords CBD Teams
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble tibble
#' @family CBD Teams Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_teams_season_overview(team_id = 72, season = 2025))
#' }
cbbd_teams_season_overview <- function(team_id, season = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- list()

  tryCatch(
    expr = {
      data <- .cbbd_get(paste0("/teams/", team_id, "/season/", season, "/overview"))
      df <- list(
        # intersect(): a field upstream drops would otherwise come back as an
        # NA-named NULL and flatten into a junk `na` column
        team = .cbbd_record_tbl(c(data[intersect(c("teamId", "season", "seasonLabel", "generatedAt", "formatVersion"), names(data))], data$team)),
        record = .cbbd_record_tbl(data$record),
        ratings = .cbbd_record_tbl(data$ratings),
        efficiency = .cbbd_record_tbl(data$efficiency),
        shooting = .cbbd_rows_tbl(data$shooting$buckets),
        players = .cbbd_rows_tbl(data$players$rows),
        schedule = .cbbd_rows_tbl(data$schedule$games),
        sources = .cbbd_record_tbl(data$sources)
      )
      df <- lapply(df, make_hoopR_data, "CBD Team Season Overview from collegebasketballdata.com", Sys.time())
      attr(df$shooting, "tracked_attempts") <- data$shooting$trackedAttempts
      attr(df$shooting, "coverage") <- data$shooting$coverage
      attr(df$players, "coverage") <- data$players$coverage
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team season overview data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team season overview", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' Flatten a nested CBD record into one row's worth of named scalars
#'
#' @description Ported from cfbfastR's `.cfbd_flatten_scalars()`. Nested
#'   objects are walked with `_`-joined names; `NULL` or an empty array becomes `NA`. One
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
    if (is.null(v) || !length(v)) {
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
  # .cbbd_get() already parses with fromJSON(flatten = TRUE)
  janitor::clean_names(dplyr::as_tibble(x))
}
