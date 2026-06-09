# Internal: valid default sort keys for the team-stats table by stat type. The
# sort only affects display order (the table always returns all 30 teams), but
# RealGM 404s on a sort key that is invalid for the chosen stat type.
.realgm_team_sort <- function(stat_type) {
  switch(stat_type,
    "Advanced_Stats" = "ortg",
    "ppg"
  )
}

#' @title
#' **RealGM NBA Player Stats**
#' @description
#' **Get season player statistics leaders from
#' [RealGM](https://basketball.realgm.com).**
#'
#' Returns the qualified-player leaderboard for a season, statistic family and
#' season segment. RealGM exposes basic box-score averages as well as advanced
#' and miscellaneous splits not all available from first-party feeds.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @param season Season (the year the season ends, e.g. `2026` for 2025-26).
#'   Defaults to `most_recent_nba_season()`.
#' @param stat_type Statistic family. One of `"Averages"` (default), `"Totals"`,
#'   `"Per_48"`, `"Per_40"`, `"Per_36"`, `"Per_Minute"`, `"Advanced_Stats"` or
#'   `"Misc_Stats"`.
#' @param season_type Season segment. One of `"Regular_Season"` (default),
#'   `"Playoffs"`, `"Preseason"` or `"Summer_League"`.
#' @return A `hoopR_data` tibble (one row per qualified player) carrying the
#'   requested `season`, `stat_type` and `season_type` as columns. Columns vary
#'   by `stat_type`; for `"Averages"`:
#'
#'    |col_name |types     |description                |
#'    |:--------|:---------|:--------------------------|
#'    |player   |character |Player name.               |
#'    |team     |character |Team abbreviation.         |
#'    |gp       |integer   |Games played.              |
#'    |mpg      |numeric   |Minutes per game.          |
#'    |ppg      |numeric   |Points per game.           |
#'    |rpg      |numeric   |Rebounds per game.         |
#'    |apg      |numeric   |Assists per game.          |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_player_stats(season = 2025, stat_type = "Averages"))
#' }
realgm_player_stats <- function(season = most_recent_nba_season(),
                                stat_type = "Averages",
                                season_type = "Regular_Season") {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      path <- sprintf("/nba/stats/%s/%s/Qualified/points/All/desc/1/%s",
                      season, stat_type, season_type)
      cand <- .realgm_pick(.realgm_tables(.realgm_doc(path)), must_have = "player")
      if (is.null(cand)) stop("RealGM player-stats table not found", call. = FALSE)
      cand$season <- as.numeric(season)
      cand$stat_type <- stat_type
      cand$season_type <- season_type
      df <- .realgm_finish(cand, "NBA player stats from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM player-stats data for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM player stats", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Team Stats**
#' @description
#' **Get season team statistics from [RealGM](https://basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @param season Season (the year the season ends, e.g. `2026`). Defaults to
#'   `most_recent_nba_season()`.
#' @param stat_type Statistic family. One of `"Averages"` (default), `"Totals"`,
#'   `"Advanced_Stats"` or `"Misc_Stats"`.
#' @param season_type Season segment. One of `"Regular_Season"` (default),
#'   `"Playoffs"`, `"Preseason"` or `"Summer_League"`.
#' @return A `hoopR_data` tibble (one row per team) carrying the requested
#'   `season`, `stat_type` and `season_type` as columns. Columns vary by
#'   `stat_type`; for `"Averages"`: `team`, `gp`, `mpg`, `ppg`, `rpg`, `apg`, etc.
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_team_stats(season = 2025, stat_type = "Averages"))
#' }
realgm_team_stats <- function(season = most_recent_nba_season(),
                              stat_type = "Averages",
                              season_type = "Regular_Season") {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      path <- sprintf("/nba/team-stats/%s/%s/Team_Totals/%s/%s/desc",
                      season, stat_type, season_type, .realgm_team_sort(stat_type))
      cand <- .realgm_pick(.realgm_tables(.realgm_doc(path)), must_have = "team")
      if (is.null(cand)) stop("RealGM team-stats table not found", call. = FALSE)
      cand$season <- as.numeric(season)
      cand$stat_type <- stat_type
      cand$season_type <- season_type
      df <- .realgm_finish(cand, "NBA team stats from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM team-stats data for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM team stats", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Best Individual Seasons**
#' @description
#' **Get the all-time best individual NBA seasons leaderboard from
#' [RealGM](https://basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per player-season (`player`,
#'   `season`, `team`, `gp`, `min`, `pts`, shooting splits, `reb`, `ast`, etc.).
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_individual_seasons())
#' }
realgm_individual_seasons <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/individual-seasons")),
                           must_have = c("player", "season"))
      if (is.null(cand)) stop("RealGM individual-seasons table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA best individual seasons from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM individual-seasons data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM individual seasons", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Best Individual Games**
#' @description
#' **Get the all-time best individual NBA games leaderboard from
#' [RealGM](https://basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per player-game (`player`, `date`,
#'   `team`, `min`, `pts`, `fgm`, `fga`, `reb`, `ast`, `stl`, `blk`, etc.).
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_individual_games())
#' }
realgm_individual_games <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/individual-games")),
                           must_have = c("player", "date"))
      if (is.null(cand)) stop("RealGM individual-games table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA best individual games from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM individual-games data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM individual games", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Draft Prospect Stats**
#' @description
#' **Get current NBA draft-prospect statistics from
#' [RealGM](https://basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per prospect (`player`, `team`
#'   (school/club), `gp`, `mpg`, `ppg`, shooting splits, `rpg`, `apg`, `spg`,
#'   `bpg`).
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_draft_prospects())
#' }
realgm_draft_prospects <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/draft/prospects/stats")),
                           must_have = c("player", "ppg"))
      if (is.null(cand)) stop("RealGM draft-prospects table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA draft prospect stats from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM draft-prospect data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM draft prospects", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
