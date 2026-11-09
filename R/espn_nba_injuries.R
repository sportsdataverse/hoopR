#' **Get ESPN NBA Injuries**
#' @rdname espn_mbb_injuries
#' @name espn_nba_injuries
NULL
#' @title
#' **Get ESPN NBA Injuries**
#' @rdname espn_mbb_injuries
#' @author Saiem Gilani
#' @param ... Currently unused; reserved for future argument threading.
#' @eval .returns_rd("espn_nba_injuries")
#' @return An empty tibble (zero rows) when no injuries are reported.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows mutate
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @rdname espn_mbb_team_injuries
#' @name espn_nba_team_injuries
NULL
#' @title
#' **Get ESPN NBA Team Injuries**
#' @rdname espn_mbb_team_injuries
#' @author Saiem Gilani
#' @param ... Currently unused; reserved for future argument threading.
#' @eval .returns_rd("espn_nba_team_injuries")
#' @return An empty tibble (zero rows) when no injuries are reported.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
