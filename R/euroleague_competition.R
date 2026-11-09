#' @title
#' **EuroLeague Competitions**
#' @description
#' **Get the competitions of the EuroLeague Competition Engine (EuroLeague `E`,
#' EuroCup `U`, ...).**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions`
#' @details
#' Unofficial, keyless API, not supported by Euroleague Basketball; hoopR only
#' wraps it. This
#' function mirrors its sportsdataverse-py twin of the same name: same arguments, defaults
#' and snake_case columns, one row per sportsdataverse-py row.
#'
#' A failed request raises a classed condition instead of returning an empty
#' frame, mirroring sportsdataverse-py's error vocabulary: a 404 is `hoopR_no_data`, a
#' 400 / 422 is `hoopR_invalid_request`, any other failure (another status, a
#' transport error, a non-JSON body) is `hoopR_fetch_error`; all three inherit
#' `hoopR_error`.
#' @eval .returns_rd("euroleague_competitions", inline = FALSE, unit = "competition")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_competitions()
#'   })
#' }
euroleague_competitions <- function() {
  raw <- euroleague_api("/competitions", host = "v2")
  .euroleague_data(.euroleague_frame(raw), "competitions")
}

#' @title
#' **EuroLeague Seasons**
#' @description
#' **Get the seasons of a competition.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons`
#' @inherit euroleague_competitions details
#' @param competition_code (*character* required): `E` = EuroLeague, `U` = EuroCup
#'   (see [euroleague_competitions()]).
#' @eval .returns_rd("euroleague_seasons", inline = FALSE, unit = "season")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_seasons(competition_code = "E")
#'   })
#' }
euroleague_seasons <- function(competition_code) {
  raw <- euroleague_api(sprintf("/competitions/%s/seasons", competition_code), host = "v2")
  .euroleague_data(.euroleague_frame(raw), "seasons")
}

#' @title
#' **EuroLeague Rounds**
#' @description
#' **Get the rounds of a season.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/rounds`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_seasons
#' @param season_code (*character* required): Competition code + start year,
#'   e.g. `E2025` for 2025-26.
#' @eval .returns_rd("euroleague_rounds", inline = FALSE, unit = "round")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_rounds(competition_code = "E", season_code = "E2025")
#'   })
#' }
euroleague_rounds <- function(competition_code, season_code) {
  raw <- euroleague_api(sprintf("/competitions/%s/seasons/%s/rounds", competition_code, season_code), host = "v2")
  .euroleague_data(.euroleague_frame(raw), "rounds")
}

#' @title
#' **EuroLeague Clubs**
#' @description
#' **Get the clubs in a season.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/clubs`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_rounds
#' @eval .returns_rd("euroleague_clubs", inline = FALSE, unit = "club")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_clubs(competition_code = "E", season_code = "E2025")
#'   })
#' }
euroleague_clubs <- function(competition_code, season_code) {
  raw <- euroleague_api(sprintf("/competitions/%s/seasons/%s/clubs", competition_code, season_code), host = "v2")
  .euroleague_data(.euroleague_frame(raw), "clubs")
}

#' @title
#' **EuroLeague People**
#' @description
#' **Get the people (players, coaches) in a season.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/people`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_rounds
#' @param limit (*integer* optional): Page size (number of rows to return).
#' @param offset (*integer* optional): Row offset into the full list.
#' @eval .returns_rd("euroleague_people", inline = FALSE, unit = "person-club registration")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_people(competition_code = "E", season_code = "E2025", limit = 50)
#'   })
#' }
euroleague_people <- function(competition_code, season_code, limit = NULL, offset = NULL) {
  raw <- euroleague_api(
    sprintf("/competitions/%s/seasons/%s/people", competition_code, season_code),
    params = list(limit = limit, offset = offset), host = "v2"
  )
  .euroleague_data(.euroleague_frame(raw), "people")
}

#' @title
#' **EuroLeague Games**
#' @description
#' **Get the games of a season.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/games`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_people
#' @eval .returns_rd("euroleague_games", inline = FALSE, unit = "game")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_games(competition_code = "E", season_code = "E2025")
#'   })
#' }
euroleague_games <- function(competition_code, season_code, limit = NULL, offset = NULL) {
  raw <- euroleague_api(
    sprintf("/competitions/%s/seasons/%s/games", competition_code, season_code),
    params = list(limit = limit, offset = offset), host = "v2"
  )
  .euroleague_data(.euroleague_frame(raw), "games")
}

#' @title
#' **EuroLeague Game Stats (Competition Engine box score)**
#' @description
#' **Get the box score of one game from the Competition Engine: one row with the
#' `local` and `road` sides flattened to prefixed columns; each side's `players`
#' list is kept JSON-encoded.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/games/{game_code}/stats`
#'
#' For one row per player use [euroleague_game_boxscore()] (the live API).
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_rounds
#' @param game_code (*integer* required): Game number within the season (1-based;
#'   the `game_code` column of [euroleague_games()]).
#' @eval .returns_rd("euroleague_game_stats", inline = FALSE, unit = "game")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_game_stats(competition_code = "E", season_code = "E2025", game_code = 1)
#'   })
#' }
euroleague_game_stats <- function(competition_code, season_code, game_code) {
  raw <- euroleague_api(
    sprintf("/competitions/%s/seasons/%s/games/%s/stats", competition_code, season_code, game_code),
    host = "v2"
  )
  .euroleague_data(.euroleague_frame(raw), "game stats")
}

#' @title
#' **EuroLeague Game Report**
#' @description
#' **Get the report of one game: date, round, phase, both clubs with score and
#' last-5 form, one row.**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v3/competitions/{competition_code}/seasons/{season_code}/games/{game_code}/report`
#' @inherit euroleague_competitions details
#' @inheritParams euroleague_game_stats
#' @eval .returns_rd("euroleague_game_report", inline = FALSE, unit = "game")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_game_report(competition_code = "E", season_code = "E2025", game_code = 1)
#'   })
#' }
euroleague_game_report <- function(competition_code, season_code, game_code) {
  raw <- euroleague_api(
    sprintf("/competitions/%s/seasons/%s/games/%s/report", competition_code, season_code, game_code),
    host = "v3"
  )
  .euroleague_data(.euroleague_frame(raw), "game report")
}
