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

#' @title
#' **CBD Team Season Overview**
#' @description
#' **Get a stored full-season overview of one team from the CollegeBasketballData API.**
#' @param team_id (*integer* required): CollegeBasketballData team id. See
#'   [cbbd_teams()] or [cbbd_teams_directory()] for valid values.
#' @param season (*integer* required): Season, in 4-digit format ending-year
#'   (e.g. `2025` for the 2024-25 season). Defaults to
#'   `most_recent_mbb_season()`.
#' @return A named list of `hoopR_data` tibbles, one per section of the overview.
#'   `team`, `record`, `ratings`, `efficiency` and `sources` are one row each;
#'   `shooting` (one row per shot bucket), `players` (one row per player) and
#'   `schedule` (one row per game) are row tables. `shooting` also carries the
#'   attributes `tracked_attempts` (integer) and `coverage`, and `players` carries
#'   `coverage`: a list of `state`, `reason`, `coveredGames` and `eligibleGames`.
#'   A section upstream leaves empty comes back as a 0-column tibble. Types
#'   follow the values: a field upstream sends as `null` parses as logical `NA`,
#'   a whole-number value as integer, and a nullable object sent as `null`
#'   (e.g. the adjusted ratings) as one `NA` column in place of its fields.
#'
#'   **team** - one row:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab integer \tab CollegeBasketballData team id. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       season_label \tab character \tab Upstream season label. \cr
#'       generated_at \tab character \tab When upstream built the overview (ISO 8601). \cr
#'       format_version \tab integer \tab Upstream overview format version. \cr
#'       school \tab character \tab School name. \cr
#'       mascot \tab character \tab Team mascot. \cr
#'       source_id \tab character \tab Source (ESPN) team id. \cr
#'       conference_id \tab integer \tab Conference id. \cr
#'       conference_name \tab character \tab Conference name. \cr
#'       conference_abbreviation \tab character \tab Conference abbreviation. \cr
#'    }}
#'
#'   **record** - one row:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       overall_games, overall_wins, overall_losses, overall_unresolved \tab integer \tab All games: played, won, lost, not yet resolved. \cr
#'       conference_games, conference_wins, conference_losses, conference_unresolved \tab integer \tab Conference games, same counts. \cr
#'       complete \tab logical \tab Whether the record covers every game. \cr
#'       unknown_conference_games \tab integer \tab Games whose conference status is unknown. \cr
#'       unknown_eligibility_games \tab integer \tab Games whose eligibility is unknown. \cr
#'    }}
#'
#'   **ratings** - one row:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       elo \tab numeric \tab Elo rating. \cr
#'       srs \tab numeric \tab Simple Rating System rating. \cr
#'       polls_ap_state, polls_coaches_state \tab character \tab Poll standing state (e.g. ranked). \cr
#'       polls_ap_date, polls_coaches_date \tab character \tab Date of the poll used. \cr
#'       polls_ap_week, polls_coaches_week \tab integer \tab Week of the poll used. \cr
#'       polls_ap_season_type, polls_coaches_season_type \tab character \tab Season type of the poll used. \cr
#'       polls_ap_rank, polls_coaches_rank \tab integer \tab AP / Coaches poll rank. \cr
#'       adjusted_offense_value, adjusted_defense_value, adjusted_net_value \tab numeric \tab Adjusted efficiency ratings. \cr
#'       adjusted_offense_rank, adjusted_defense_rank, adjusted_net_rank \tab integer \tab Ranks of the adjusted ratings. \cr
#'       adjusted_population \tab integer \tab Number of teams ranked. \cr
#'    }}
#'
#'   **efficiency** - one row; every offense_ column has a defense_ twin (opponents):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       pace \tab numeric \tab Possessions per 40 minutes. \cr
#'       pace_games \tab integer \tab Games in the pace sample. \cr
#'       coverage_state, coverage_reason \tab character \tab Data coverage state and reason. \cr
#'       coverage_covered_games, coverage_eligible_games \tab integer \tab Games covered / eligible. \cr
#'       offense_points, offense_possessions \tab integer \tab Points scored and possessions. \cr
#'       offense_raw_rating \tab numeric \tab Unadjusted points per 100 possessions. \cr
#'       offense_effective_field_goal_pct, offense_turnover_pct, offense_offensive_rebound_pct, offense_free_throw_rate \tab numeric \tab Four factors. \cr
#'       offense_box_score_field_goals_*, offense_box_score_two_point_field_goals_*, offense_box_score_three_point_field_goals_*, offense_box_score_free_throws_* \tab integer, numeric \tab made and attempted (integer), pct (numeric). \cr
#'       offense_box_score_rebounds_total, _offensive, _defensive \tab integer \tab Rebounds. \cr
#'       offense_box_score_assists, _steals, _blocks, _turnovers, _team_turnovers, _fouls, _technical_fouls, _flagrant_fouls, _minutes \tab integer \tab Box score counting stats. \cr
#'       offense_box_score_points_in_paint, _points_off_turnovers, _fast_break_points \tab integer \tab Scoring splits. \cr
#'       offense_box_score_true_shooting_pct \tab numeric \tab True shooting percentage. \cr
#'    }}
#'
#'   **shooting** - one row per shot bucket:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       key \tab character \tab Shot bucket. \cr
#'       attempts, made \tab integer \tab Tracked attempts and makes. \cr
#'       attempt_pct \tab numeric \tab Share of classified tracked attempts. \cr
#'       field_goal_pct \tab numeric \tab Field goal percentage. \cr
#'    }}
#'
#'   **players** - one row per player:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       athlete_id \tab integer \tab CollegeBasketballData athlete id. \cr
#'       name \tab character \tab Player name. \cr
#'       position \tab character \tab Position. \cr
#'       on_roster, has_stats, complete \tab logical \tab Roster / stats / completeness flags. \cr
#'       games, minutes, points, rebounds, assists \tab integer \tab Season totals. \cr
#'       minutes_per_game, points_per_game \tab numeric \tab Per-game averages. \cr
#'       usage_pct, true_shooting_pct, effective_field_goal_pct \tab numeric \tab Rate stats. \cr
#'       usage_games \tab integer \tab Games in the usage sample. \cr
#'       season_stats_* \tab integer, numeric \tab Season box line: field goal, two, three and free throw made / attempted / pct; rebounds total / offensive / defensive; assists, steals, blocks, turnovers, fouls, starts; assist_turnover_ratio, free_throw_rate, offensive_rebound_pct. \cr
#'       season_stats_advanced_* \tab numeric \tab games, porpag, net_rating, offensive_rating, defensive_rating, win_shares_total / offensive / defensive / per40. \cr
#'    }}
#'
#'   **schedule** - one row per game:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData game id. \cr
#'       opponent_id \tab integer \tab Opponent team id. \cr
#'       opponent \tab character \tab Opponent name. \cr
#'       opponent_has_profile \tab logical \tab Whether the opponent has an overview. \cr
#'       start_date \tab character \tab Tipoff (ISO 8601). \cr
#'       calendar_date \tab character \tab Local calendar date. \cr
#'       start_time_tbd \tab logical \tab Tipoff time to be determined. \cr
#'       location \tab character \tab home, away or neutral. \cr
#'       status \tab character \tab Game status. \cr
#'       season_type \tab character \tab Season type. \cr
#'       game_type \tab character \tab Game type. \cr
#'       eligibility \tab character \tab Whether the game counts toward the overview. \cr
#'       conference_game \tab logical \tab Conference game. \cr
#'       team_points, opponent_points \tab integer \tab Final score. \cr
#'       result \tab character \tab Result (W / L). \cr
#'       venue \tab character \tab Venue name. \cr
#'    }}
#'
#'   **sources** - one row:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       notes \tab character \tab Upstream notes, joined with a semicolon. \cr
#'       latest_final_start_date \tab character \tab Tipoff of the latest final game included. \cr
#'       leaderboard_updated_at \tab character \tab When the leaderboard source last updated. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column tables.}
#'
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
        team = .cbbd_record_tbl(c(data[c("teamId", "season", "seasonLabel", "generatedAt", "formatVersion")], data$team)),
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
