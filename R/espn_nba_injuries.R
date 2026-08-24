#' **Get ESPN NBA Injuries**
#' @name espn_nba_injuries
NULL
#' @title
#' **Get ESPN NBA Injuries**
#' @rdname espn_nba_injuries
#' @author Saiem Gilani
#' @param season Numeric or character season year (e.g. `2025`). The ESPN
#'   injury endpoint does not filter by season server-side; the value is
#'   attached as a constant column on the returned tibble for downstream joins.
#'   Defaults to `most_recent_nba_season()`.
#' @param ... Currently unused; reserved for future argument threading.
#' @return Returns a tibble of league-wide NBA injury records.
#'   Returns an empty tibble (zero rows) when no injuries are reported.
#'
#'    **Injuries**
#'
#'    Columns as documented in the shared [espn_mbb_injuries_injuries_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows mutate
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_injuries()
#' }
espn_nba_injuries <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_league_injuries(
    league = "nba",
    season = season,
    ...
  )
}


#' **Get ESPN NBA Team Injuries**
#' @name espn_nba_team_injuries
NULL
#' @title
#' **Get ESPN NBA Team Injuries**
#' @rdname espn_nba_team_injuries
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric; passed as-is).
#'   Use `espn_nba_teams()` to look up team IDs. Example: `"17"` (Las Vegas
#'   Aces).
#' @param ... Currently unused; reserved for future argument threading.
#' @return Returns a tibble of injury records for the specified NBA team.
#'   Returns an empty tibble (zero rows) when the team has no reported
#'   injuries.
#'
#'    **Injuries**
#'
#'    Columns as documented in the shared [espn_mbb_team_injuries_injuries_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_injuries(team_id = "13")
#' }
espn_nba_team_injuries <- function(team_id, ...) {
  .espn_basketball_team_injuries(
    league  = "nba",
    team_id = team_id,
    ...
  )
}
