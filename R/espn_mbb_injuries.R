#' **Get ESPN Women's College Basketball Injuries**
#' @name espn_mbb_injuries
NULL
#' @title
#' **Get ESPN Women's College Basketball Injuries**
#' @rdname espn_mbb_injuries
#' @author Saiem Gilani
#' @param season Numeric or character season year (e.g. `2025`). The ESPN
#'   injury endpoint does not filter by season server-side; the value is
#'   attached as a constant column on the returned tibble for downstream joins.
#'   Defaults to `most_recent_mbb_season()`.
#' @param ... Currently unused; reserved for future argument threading.
#' @return Returns a tibble of league-wide MBB injury records. ESPN's MBB
#'   injury data is typically sparse; the function returns an empty tibble
#'   (zero rows) when no injuries are reported.
#'
#'    **Injuries**
#'
#'    Columns as documented in the shared [espn_mbb_injuries_injuries_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows mutate
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_injuries()
#' }
espn_mbb_injuries <- function(season = most_recent_mbb_season(), ...) {
  .espn_basketball_league_injuries(
    league = "mens-college-basketball",
    season = season,
    ...
  )
}


#' **Get ESPN Women's College Basketball Team Injuries**
#' @name espn_mbb_team_injuries
NULL
#' @title
#' **Get ESPN Women's College Basketball Team Injuries**
#' @rdname espn_mbb_team_injuries
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric; passed as-is).
#'   Use `espn_mbb_teams()` to look up team IDs. Example: `"2509"` (UConn).
#' @param ... Currently unused; reserved for future argument threading.
#' @return Returns a tibble of injury records for the specified MBB team.
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
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_injuries(team_id = "150")
#' }
espn_mbb_team_injuries <- function(team_id, ...) {
  .espn_basketball_team_injuries(
    league  = "mens-college-basketball",
    team_id = team_id,
    ...
  )
}
