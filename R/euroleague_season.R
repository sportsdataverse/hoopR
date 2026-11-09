#' @title
#' **EuroLeague Standings**
#' @description
#' **Get the standings as of a round: basic (W-L, points, home / away / last-10
#' records), calendar (per-round result streaks), streaks (longest win / loss
#' runs) or aheadbehind (records when ahead / behind / tied after Q1, the half
#' and Q3), one row per team.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v3/competitions/{competition_code}/seasons/{season_code}/rounds/{round}/{kind}`
#'
#' The standings live under a **round**, not the season: pass the `round`
#' number the table should be as of (the `round` column of
#' [euroleague_rounds()]). The season winner block of the payload is dropped
#' (it is `null` while the season is in progress).
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_rounds
#' @param round (*integer* required): Round number within the season; the
#'   standings are as of this round.
#' @param kind (*character* default `"basicstandings"`): Standings table, one
#'   of `"basicstandings"`, `"calendarstandings"`, `"streaks"` or
#'   `"aheadbehind"`, matched exactly (no prefixes, as in sportsdataverse-py); the columns
#'   depend on it (see Returns).
#' @eval .returns_rd("euroleague_standings", inline = FALSE, unit = "team")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_standings(competition_code = "E", season_code = "E2025", round = 1)
#'     euroleague_standings(competition_code = "E", season_code = "E2025", round = 1, kind = "streaks")
#'   })
#' }
euroleague_standings <- function(competition_code, season_code, round,
                                 kind = c("basicstandings", "calendarstandings", "streaks", "aheadbehind")) {
  kind <- rlang::arg_match(kind)
  raw <- euroleague_api(
    sprintf("/competitions/%s/seasons/%s/rounds/%s/%s", competition_code, season_code, round, kind),
    host = "v3"
  )
  .euroleague_data(.euroleague_frame(raw), paste("standings", kind))
}

#' @title
#' **EuroLeague Player Stats (season)**
#' @description
#' **Get season player stats, traditional (box-score totals or per-game
#' averages) or advanced (eFG%, TS%, rebound / assist / turnover rates), one
#' row per player.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v3/competitions/{competition_code}/statistics/players/{mode}`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_seasons
#' @param mode (*character* default `"traditional"`): `"traditional"` or
#'   `"advanced"`, matched exactly (no prefixes, as in sportsdataverse-py); the columns
#'   depend on it (see Returns).
#' @param season_mode (*character* default `"Single"`): Season mode; `Single`
#'   as captured (other values unverified).
#' @param season_code (*character* required by the API): Competition code +
#'   start year, e.g. `E2025` for 2025-26 (the `SeasonCode` query parameter).
#' @param statistic_mode (*character* default `"PerGame"`): `PerGame` as
#'   captured (other values unverified).
#' @param limit (*integer* optional): Page size.
#' @param offset (*integer* optional): Row offset into the full list.
#' @eval .returns_rd("euroleague_player_stats", inline = FALSE, unit = "player")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_player_stats(competition_code = "E", season_code = "E2025", limit = 25)
#'     euroleague_player_stats(competition_code = "E", season_code = "E2025", mode = "advanced")
#'   })
#' }
euroleague_player_stats <- function(competition_code, mode = c("traditional", "advanced"),
                                    season_mode = "Single", season_code = NULL,
                                    statistic_mode = "PerGame", limit = NULL, offset = NULL) {
  mode <- rlang::arg_match(mode)
  raw <- euroleague_api(
    sprintf("/competitions/%s/statistics/players/%s", competition_code, mode),
    params = list(SeasonMode = season_mode, SeasonCode = season_code, statisticMode = statistic_mode,
                  limit = limit, offset = offset),
    host = "v3"
  )
  .euroleague_data(.euroleague_frame(raw), paste(mode, "player stats"))
}

#' @title
#' **EuroLeague Team Stats (season)**
#' @description
#' **Get season team stats, traditional (box-score totals or per-game averages)
#' or advanced (eFG%, TS%, four-factor style rates), one row per team.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v3/competitions/{competition_code}/statistics/teams/{mode}`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_player_stats
#' @eval .returns_rd("euroleague_team_stats", inline = FALSE, unit = "team")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_team_stats(competition_code = "E", season_code = "E2025")
#'     euroleague_team_stats(competition_code = "E", season_code = "E2025", mode = "advanced")
#'   })
#' }
euroleague_team_stats <- function(competition_code, mode = c("traditional", "advanced"),
                                  season_mode = "Single", season_code = NULL,
                                  statistic_mode = "PerGame", limit = NULL, offset = NULL) {
  mode <- rlang::arg_match(mode)
  raw <- euroleague_api(
    sprintf("/competitions/%s/statistics/teams/%s", competition_code, mode),
    params = list(SeasonMode = season_mode, SeasonCode = season_code, statisticMode = statistic_mode,
                  limit = limit, offset = offset),
    host = "v3"
  )
  .euroleague_data(.euroleague_frame(raw), paste(mode, "team stats"))
}
