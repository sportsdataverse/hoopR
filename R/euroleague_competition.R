#' @title
#' **EuroLeague Competitions**
#' @description
#' **Get the competitions of the EuroLeague Competition Engine (EuroLeague `E`,
#' EuroCup `U`, ...).**
#'
#' Endpoint: `GET https://api-live.euroleague.net/v2/competitions`
#' @details
#' Unofficial, keyless API, not supported by Euroleague Basketball; hoopR only
#' wraps it (wrap-only: payloads are not redistributed as release assets). This
#' function mirrors its sdv-py twin of the same name: same arguments, defaults
#' and snake_case columns, one row per sdv-py row.
#'
#' A failed request raises a classed condition instead of returning an empty
#' frame, mirroring sdv-py's error vocabulary: a 404 is `hoopR_no_data`, a
#' 400 / 422 is `hoopR_invalid_request`, any other failure (another status, a
#' transport error, a non-JSON body) is `hoopR_fetch_error`; all three inherit
#' `hoopR_error`.
#' @return A `hoopR_data` tibble with one row per competition:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       name \tab character \tab Display name. \cr
#'       code \tab character \tab EuroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row per season:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       name \tab character \tab Display name. \cr
#'       code \tab character \tab EuroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       alias \tab character \tab Short display alias. \cr
#'       competition_code \tab character \tab Competition code (E = EuroLeague, U = EuroCup; Utf8 join key). \cr
#'       year \tab integer \tab Start year of the season. \cr
#'       start_date \tab character \tab Start date (ISO 8601). \cr
#'       activation_date \tab character \tab Date the season was activated in the engine (ISO 8601). \cr
#'       end_date \tab character \tab End date (ISO 8601). \cr
#'       winner \tab numeric \tab Winning club of the season (null while in progress). \cr
#'       winner_code \tab character \tab Winning club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       winner_name \tab character \tab Winning club: display name. \cr
#'       winner_abbreviated_name \tab character \tab Winning club: abbreviated display name. \cr
#'       winner_editorial_name \tab character \tab Winning club: editorial (long-form) display name. \cr
#'       winner_tv_code \tab character \tab Winning club: three-letter broadcast abbreviation of the club. \cr
#'       winner_is_virtual \tab character \tab Winning club: whether the club is a placeholder rather than a real club. \cr
#'       winner_images_crest \tab character \tab Winning club: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row per round:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season_code \tab character \tab Season code: competition code + start year, e.g. E2025 for 2025-26 (Utf8 join key). \cr
#'       phase_type_code \tab character \tab Phase type code (RS = regular season, PO = playoffs, ...). \cr
#'       round \tab integer \tab Round number within the season. \cr
#'       index \tab integer \tab Ordinal position of the round within the season. \cr
#'       name \tab character \tab Display name. \cr
#'       min_game_start_date \tab character \tab Earliest game start in the round (ISO 8601). \cr
#'       max_game_start_date \tab character \tab Latest game start in the round (ISO 8601). \cr
#'       dates_formmated \tab character \tab Human-readable date range of the round (sic: the API spells it this way). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row per club:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       code \tab character \tab EuroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       name \tab character \tab Display name. \cr
#'       abbreviated_name \tab character \tab Abbreviated display name. \cr
#'       editorial_name \tab character \tab Editorial (long-form) display name. \cr
#'       tv_code \tab character \tab Three-letter broadcast abbreviation of the club. \cr
#'       is_virtual \tab logical \tab Whether the club is a placeholder rather than a real club. \cr
#'       sponsor \tab character \tab Club sponsor. \cr
#'       club_permanent_name \tab character \tab Permanent club name independent of sponsor naming. \cr
#'       club_permanent_alias \tab character \tab Permanent club alias independent of sponsor naming. \cr
#'       address \tab character \tab Street address. \cr
#'       website \tab character \tab Official website URL. \cr
#'       tickets_url \tab character \tab Ticketing URL. \cr
#'       twitter_account \tab character \tab Twitter / X handle. \cr
#'       venue_code \tab character \tab Code of the venue the club or game plays at (Utf8 join key). \cr
#'       city \tab character \tab City the club is based in. \cr
#'       president \tab character \tab Club president. \cr
#'       phone \tab character \tab Contact phone number. \cr
#'       images_crest \tab character \tab URL of the club crest image. \cr
#'       country_code \tab character \tab ISO country code. \cr
#'       country_name \tab character \tab Country name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row per person-club registration:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       type \tab character \tab Person type code (J = player, E = coach, ...). \cr
#'       type_name \tab character \tab Person type name. \cr
#'       active \tab logical \tab Whether the record is currently active. \cr
#'       start_date \tab character \tab Start date (ISO 8601). \cr
#'       end_date \tab character \tab End date (ISO 8601). \cr
#'       order \tab integer \tab Display order within the roster. \cr
#'       dorsal \tab character \tab Jersey number as displayed. \cr
#'       dorsal_raw \tab character \tab Jersey number as stored by the engine. \cr
#'       position \tab integer \tab Position code of the player (engine integer). \cr
#'       position_name \tab character \tab Position name of the player. \cr
#'       last_team \tab character \tab Previous club of the person. \cr
#'       external_id \tab character \tab External (statistics-provider) identifier of the person (Utf8 join key). \cr
#'       person_code \tab character \tab Person: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       person_name \tab character \tab Person: display name. \cr
#'       person_alias \tab character \tab Person: short display alias. \cr
#'       person_alias_raw \tab character \tab Person: short alias as stored by the engine. \cr
#'       person_passport_name \tab character \tab Person: given name as on the passport. \cr
#'       person_passport_surname \tab character \tab Person: surname as on the passport. \cr
#'       person_jersey_name \tab character \tab Person: name printed on the jersey. \cr
#'       person_abbreviated_name \tab character \tab Person: abbreviated display name. \cr
#'       person_country_code \tab character \tab Person: ISO country code. \cr
#'       person_country_name \tab character \tab Person: country name. \cr
#'       person_height \tab integer \tab Person: height in centimetres. \cr
#'       person_weight \tab integer \tab Person: weight in kilograms. \cr
#'       person_birth_date \tab character \tab Person: date of birth (ISO 8601). \cr
#'       person_birth_country_code \tab character \tab Person: birth country: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       person_birth_country_name \tab character \tab Person: birth country: display name. \cr
#'       person_twitter_account \tab character \tab Person: twitter / X handle. \cr
#'       person_instagram_account \tab character \tab Person: instagram handle. \cr
#'       person_facebook_account \tab character \tab Person: facebook handle. \cr
#'       person_is_referee \tab logical \tab Person: whether the person is a referee. \cr
#'       club_code \tab character \tab Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       club_name \tab character \tab Club: display name. \cr
#'       club_abbreviated_name \tab character \tab Club: abbreviated display name. \cr
#'       club_editorial_name \tab character \tab Club: editorial (long-form) display name. \cr
#'       club_tv_code \tab character \tab Club: three-letter broadcast abbreviation of the club. \cr
#'       club_is_virtual \tab logical \tab Club: whether the club is a placeholder rather than a real club. \cr
#'       club_images_crest \tab character \tab Club: URL of the club crest image. \cr
#'       season_name \tab character \tab Season: display name. \cr
#'       season_code \tab character \tab Season code: competition code + start year, e.g. E2025 for 2025-26 (Utf8 join key). \cr
#'       season_alias \tab character \tab Season: short display alias. \cr
#'       season_competition_code \tab character \tab Season: competition code (E = EuroLeague, U = EuroCup; Utf8 join key). \cr
#'       season_year \tab integer \tab Season: start year of the season. \cr
#'       season_start_date \tab character \tab Season: start date (ISO 8601). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row per game:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab character \tab Provider identifier for the entity (Utf8 join key). \cr
#'       identifier \tab character \tab Season-qualified game identifier, e.g. E2025_1. \cr
#'       game_code \tab character \tab Game number within the season (1-based; Utf8 join key). \cr
#'       round \tab integer \tab Round number within the season. \cr
#'       round_alias \tab character \tab Short alias of the round. \cr
#'       round_name \tab character \tab Display name of the round. \cr
#'       played \tab logical \tab Whether the game has been played. \cr
#'       date \tab character \tab Scheduled tip-off (ISO 8601, venue local time). \cr
#'       confirmed_date \tab logical \tab Whether the game date is confirmed. \cr
#'       confirmed_hour \tab logical \tab Whether the tip-off time is confirmed. \cr
#'       local_time_zone \tab integer \tab UTC offset of the venue, in hours. \cr
#'       local_date \tab character \tab Scheduled tip-off in venue local time (ISO 8601). \cr
#'       utc_date \tab character \tab Scheduled tip-off in UTC (ISO 8601). \cr
#'       audience \tab integer \tab Attendance. \cr
#'       audience_confirmed \tab logical \tab Whether the attendance figure is confirmed. \cr
#'       social_feed \tab character \tab Social-media hashtag or feed tag for the game. \cr
#'       operations_code \tab character \tab Engine operations code of the game. \cr
#'       referee4 \tab character \tab Fourth referee (null unless a fourth official is assigned). \cr
#'       is_neutral_venue \tab logical \tab Whether the game is played at a neutral venue. \cr
#'       game_status \tab character \tab Game status (scheduled, live, result). \cr
#'       season_name \tab character \tab Season: display name. \cr
#'       season_code \tab character \tab Season code: competition code + start year, e.g. E2025 for 2025-26 (Utf8 join key). \cr
#'       season_alias \tab character \tab Season: short display alias. \cr
#'       season_competition_code \tab character \tab Season: competition code (E = EuroLeague, U = EuroCup; Utf8 join key). \cr
#'       season_year \tab integer \tab Season: start year of the season. \cr
#'       season_start_date \tab character \tab Season: start date (ISO 8601). \cr
#'       group_id \tab character \tab Group: provider identifier for the entity (Utf8 join key). \cr
#'       group_order \tab integer \tab Group: display order within the roster. \cr
#'       group_name \tab character \tab Group: display name. \cr
#'       group_raw_name \tab character \tab Group: group name as stored by the engine. \cr
#'       phase_type_code \tab character \tab Phase type code (RS = regular season, PO = playoffs, ...). \cr
#'       phase_type_alias \tab character \tab Phase type: short display alias. \cr
#'       phase_type_name \tab character \tab Phase type: display name. \cr
#'       phase_type_is_group_phase \tab logical \tab Phase type: whether the phase is played in groups. \cr
#'       local_club_code \tab character \tab Home side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       local_club_name \tab character \tab Home side: club: display name. \cr
#'       local_club_abbreviated_name \tab character \tab Home side: club: abbreviated display name. \cr
#'       local_club_editorial_name \tab character \tab Home side: club: editorial (long-form) display name. \cr
#'       local_club_tv_code \tab character \tab Home side: club: three-letter broadcast abbreviation of the club. \cr
#'       local_club_is_virtual \tab logical \tab Home side: club: whether the club is a placeholder rather than a real club. \cr
#'       local_club_images_crest \tab character \tab Home side: club: URL of the club crest image. \cr
#'       local_score \tab integer \tab Home side: final score of the side. \cr
#'       local_standings_score \tab integer \tab Home side: score of the side as counted for the standings. \cr
#'       local_partials_partials1 \tab integer \tab Home side: quarter scores: points scored in the 1st quarter. \cr
#'       local_partials_partials2 \tab integer \tab Home side: quarter scores: points scored in the 2nd quarter. \cr
#'       local_partials_partials3 \tab integer \tab Home side: quarter scores: points scored in the 3rd quarter. \cr
#'       local_partials_partials4 \tab integer \tab Home side: quarter scores: points scored in the 4th quarter. \cr
#'       road_club_code \tab character \tab Away side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       road_club_name \tab character \tab Away side: club: display name. \cr
#'       road_club_abbreviated_name \tab character \tab Away side: club: abbreviated display name. \cr
#'       road_club_editorial_name \tab character \tab Away side: club: editorial (long-form) display name. \cr
#'       road_club_tv_code \tab character \tab Away side: club: three-letter broadcast abbreviation of the club. \cr
#'       road_club_is_virtual \tab logical \tab Away side: club: whether the club is a placeholder rather than a real club. \cr
#'       road_club_images_crest \tab character \tab Away side: club: URL of the club crest image. \cr
#'       road_score \tab integer \tab Away side: final score of the side. \cr
#'       road_standings_score \tab integer \tab Away side: score of the side as counted for the standings. \cr
#'       road_partials_partials1 \tab integer \tab Away side: quarter scores: points scored in the 1st quarter. \cr
#'       road_partials_partials2 \tab integer \tab Away side: quarter scores: points scored in the 2nd quarter. \cr
#'       road_partials_partials3 \tab integer \tab Away side: quarter scores: points scored in the 3rd quarter. \cr
#'       road_partials_partials4 \tab integer \tab Away side: quarter scores: points scored in the 4th quarter. \cr
#'       referee1_code \tab character \tab First referee: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       referee1_name \tab character \tab First referee: display name. \cr
#'       referee1_alias \tab character \tab First referee: short display alias. \cr
#'       referee1_country_code \tab character \tab First referee: ISO country code. \cr
#'       referee1_country_name \tab character \tab First referee: country name. \cr
#'       referee1_images_vertical_small \tab character \tab First referee: URL of the small portrait image. \cr
#'       referee1_active \tab logical \tab First referee: whether the record is currently active. \cr
#'       referee2_code \tab character \tab Second referee: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       referee2_name \tab character \tab Second referee: display name. \cr
#'       referee2_alias \tab character \tab Second referee: short display alias. \cr
#'       referee2_country_code \tab character \tab Second referee: ISO country code. \cr
#'       referee2_country_name \tab character \tab Second referee: country name. \cr
#'       referee2_images_vertical_small \tab character \tab Second referee: URL of the small portrait image. \cr
#'       referee2_active \tab logical \tab Second referee: whether the record is currently active. \cr
#'       referee3_code \tab character \tab Third referee: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       referee3_name \tab character \tab Third referee: display name. \cr
#'       referee3_alias \tab character \tab Third referee: short display alias. \cr
#'       referee3_country_code \tab character \tab Third referee: ISO country code. \cr
#'       referee3_country_name \tab character \tab Third referee: country name. \cr
#'       referee3_images_vertical_small \tab character \tab Third referee: URL of the small portrait image. \cr
#'       referee3_active \tab logical \tab Third referee: whether the record is currently active. \cr
#'       venue_name \tab character \tab Venue: display name. \cr
#'       venue_code \tab character \tab Code of the venue the club or game plays at (Utf8 join key). \cr
#'       venue_capacity \tab integer \tab Venue: seating capacity of the venue. \cr
#'       venue_address \tab character \tab Venue: street address. \cr
#'       venue_images_medium \tab character \tab Venue: URL of the medium-size venue image. \cr
#'       venue_active \tab logical \tab Venue: whether the record is currently active. \cr
#'       venue_notes \tab character \tab Venue: venue notes. \cr
#'       winner_code \tab character \tab Winning club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       winner_name \tab character \tab Winning club: display name. \cr
#'       winner_abbreviated_name \tab character \tab Winning club: abbreviated display name. \cr
#'       winner_editorial_name \tab character \tab Winning club: editorial (long-form) display name. \cr
#'       winner_tv_code \tab character \tab Winning club: three-letter broadcast abbreviation of the club. \cr
#'       winner_is_virtual \tab logical \tab Winning club: whether the club is a placeholder rather than a real club. \cr
#'       winner_images_crest \tab character \tab Winning club: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row (the game):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       local_coach_code \tab character \tab Home side: head coach code (Utf8 join key). \cr
#'       local_coach_name \tab character \tab Home side: head coach name. \cr
#'       local_players \tab character \tab Home side: per-player box-score rows for the side, JSON-encoded. \cr
#'       local_team_time_played \tab numeric \tab Home side: team-only (not attributed to a player): seconds played. \cr
#'       local_team_valuation \tab numeric \tab Home side: team-only (not attributed to a player): performance index rating (PIR). \cr
#'       local_team_points \tab numeric \tab Home side: team-only (not attributed to a player): points. \cr
#'       local_team_field_goals_made2 \tab numeric \tab Home side: team-only (not attributed to a player): two-point field goals made. \cr
#'       local_team_field_goals_attempted2 \tab numeric \tab Home side: team-only (not attributed to a player): two-point field goals attempted. \cr
#'       local_team_field_goals_made3 \tab numeric \tab Home side: team-only (not attributed to a player): three-point field goals made. \cr
#'       local_team_field_goals_attempted3 \tab numeric \tab Home side: team-only (not attributed to a player): three-point field goals attempted. \cr
#'       local_team_free_throws_made \tab numeric \tab Home side: team-only (not attributed to a player): free throws made. \cr
#'       local_team_free_throws_attempted \tab numeric \tab Home side: team-only (not attributed to a player): free throws attempted. \cr
#'       local_team_field_goals_made_total \tab numeric \tab Home side: team-only (not attributed to a player): field goals made. \cr
#'       local_team_field_goals_attempted_total \tab numeric \tab Home side: team-only (not attributed to a player): field goals attempted. \cr
#'       local_team_accuracy_made \tab numeric \tab Home side: team-only (not attributed to a player): shots made (accuracy numerator). \cr
#'       local_team_accuracy_attempted \tab numeric \tab Home side: team-only (not attributed to a player): shots attempted (accuracy denominator). \cr
#'       local_team_total_rebounds \tab numeric \tab Home side: team-only (not attributed to a player): total rebounds. \cr
#'       local_team_defensive_rebounds \tab numeric \tab Home side: team-only (not attributed to a player): defensive rebounds. \cr
#'       local_team_offensive_rebounds \tab numeric \tab Home side: team-only (not attributed to a player): offensive rebounds. \cr
#'       local_team_assistances \tab numeric \tab Home side: team-only (not attributed to a player): assists. \cr
#'       local_team_steals \tab numeric \tab Home side: team-only (not attributed to a player): steals. \cr
#'       local_team_turnovers \tab numeric \tab Home side: team-only (not attributed to a player): turnovers. \cr
#'       local_team_blocks_favour \tab numeric \tab Home side: team-only (not attributed to a player): blocks made. \cr
#'       local_team_blocks_against \tab numeric \tab Home side: team-only (not attributed to a player): shots blocked by the opponent. \cr
#'       local_team_fouls_commited \tab numeric \tab Home side: team-only (not attributed to a player): personal fouls committed. \cr
#'       local_team_fouls_received \tab numeric \tab Home side: team-only (not attributed to a player): fouls drawn. \cr
#'       local_team_plus_minus \tab numeric \tab Home side: team-only (not attributed to a player): plus/minus. \cr
#'       local_total_time_played \tab numeric \tab Home side: totals: seconds played. \cr
#'       local_total_valuation \tab numeric \tab Home side: totals: performance index rating (PIR). \cr
#'       local_total_points \tab numeric \tab Home side: totals: points. \cr
#'       local_total_field_goals_made2 \tab numeric \tab Home side: totals: two-point field goals made. \cr
#'       local_total_field_goals_attempted2 \tab numeric \tab Home side: totals: two-point field goals attempted. \cr
#'       local_total_field_goals_made3 \tab numeric \tab Home side: totals: three-point field goals made. \cr
#'       local_total_field_goals_attempted3 \tab numeric \tab Home side: totals: three-point field goals attempted. \cr
#'       local_total_free_throws_made \tab numeric \tab Home side: totals: free throws made. \cr
#'       local_total_free_throws_attempted \tab numeric \tab Home side: totals: free throws attempted. \cr
#'       local_total_field_goals_made_total \tab numeric \tab Home side: totals: field goals made. \cr
#'       local_total_field_goals_attempted_total \tab numeric \tab Home side: totals: field goals attempted. \cr
#'       local_total_accuracy_made \tab numeric \tab Home side: totals: shots made (accuracy numerator). \cr
#'       local_total_accuracy_attempted \tab numeric \tab Home side: totals: shots attempted (accuracy denominator). \cr
#'       local_total_total_rebounds \tab numeric \tab Home side: totals: total rebounds. \cr
#'       local_total_defensive_rebounds \tab numeric \tab Home side: totals: defensive rebounds. \cr
#'       local_total_offensive_rebounds \tab numeric \tab Home side: totals: offensive rebounds. \cr
#'       local_total_assistances \tab numeric \tab Home side: totals: assists. \cr
#'       local_total_steals \tab numeric \tab Home side: totals: steals. \cr
#'       local_total_turnovers \tab numeric \tab Home side: totals: turnovers. \cr
#'       local_total_blocks_favour \tab numeric \tab Home side: totals: blocks made. \cr
#'       local_total_blocks_against \tab numeric \tab Home side: totals: shots blocked by the opponent. \cr
#'       local_total_fouls_commited \tab numeric \tab Home side: totals: personal fouls committed. \cr
#'       local_total_fouls_received \tab numeric \tab Home side: totals: fouls drawn. \cr
#'       local_total_plus_minus \tab numeric \tab Home side: totals: plus/minus. \cr
#'       road_coach_code \tab character \tab Away side: head coach code (Utf8 join key). \cr
#'       road_coach_name \tab character \tab Away side: head coach name. \cr
#'       road_players \tab character \tab Away side: per-player box-score rows for the side, JSON-encoded. \cr
#'       road_team_time_played \tab numeric \tab Away side: team-only (not attributed to a player): seconds played. \cr
#'       road_team_valuation \tab numeric \tab Away side: team-only (not attributed to a player): performance index rating (PIR). \cr
#'       road_team_points \tab numeric \tab Away side: team-only (not attributed to a player): points. \cr
#'       road_team_field_goals_made2 \tab numeric \tab Away side: team-only (not attributed to a player): two-point field goals made. \cr
#'       road_team_field_goals_attempted2 \tab numeric \tab Away side: team-only (not attributed to a player): two-point field goals attempted. \cr
#'       road_team_field_goals_made3 \tab numeric \tab Away side: team-only (not attributed to a player): three-point field goals made. \cr
#'       road_team_field_goals_attempted3 \tab numeric \tab Away side: team-only (not attributed to a player): three-point field goals attempted. \cr
#'       road_team_free_throws_made \tab numeric \tab Away side: team-only (not attributed to a player): free throws made. \cr
#'       road_team_free_throws_attempted \tab numeric \tab Away side: team-only (not attributed to a player): free throws attempted. \cr
#'       road_team_field_goals_made_total \tab numeric \tab Away side: team-only (not attributed to a player): field goals made. \cr
#'       road_team_field_goals_attempted_total \tab numeric \tab Away side: team-only (not attributed to a player): field goals attempted. \cr
#'       road_team_accuracy_made \tab numeric \tab Away side: team-only (not attributed to a player): shots made (accuracy numerator). \cr
#'       road_team_accuracy_attempted \tab numeric \tab Away side: team-only (not attributed to a player): shots attempted (accuracy denominator). \cr
#'       road_team_total_rebounds \tab numeric \tab Away side: team-only (not attributed to a player): total rebounds. \cr
#'       road_team_defensive_rebounds \tab numeric \tab Away side: team-only (not attributed to a player): defensive rebounds. \cr
#'       road_team_offensive_rebounds \tab numeric \tab Away side: team-only (not attributed to a player): offensive rebounds. \cr
#'       road_team_assistances \tab numeric \tab Away side: team-only (not attributed to a player): assists. \cr
#'       road_team_steals \tab numeric \tab Away side: team-only (not attributed to a player): steals. \cr
#'       road_team_turnovers \tab numeric \tab Away side: team-only (not attributed to a player): turnovers. \cr
#'       road_team_blocks_favour \tab numeric \tab Away side: team-only (not attributed to a player): blocks made. \cr
#'       road_team_blocks_against \tab numeric \tab Away side: team-only (not attributed to a player): shots blocked by the opponent. \cr
#'       road_team_fouls_commited \tab numeric \tab Away side: team-only (not attributed to a player): personal fouls committed. \cr
#'       road_team_fouls_received \tab numeric \tab Away side: team-only (not attributed to a player): fouls drawn. \cr
#'       road_team_plus_minus \tab numeric \tab Away side: team-only (not attributed to a player): plus/minus. \cr
#'       road_total_time_played \tab numeric \tab Away side: totals: seconds played. \cr
#'       road_total_valuation \tab numeric \tab Away side: totals: performance index rating (PIR). \cr
#'       road_total_points \tab numeric \tab Away side: totals: points. \cr
#'       road_total_field_goals_made2 \tab numeric \tab Away side: totals: two-point field goals made. \cr
#'       road_total_field_goals_attempted2 \tab numeric \tab Away side: totals: two-point field goals attempted. \cr
#'       road_total_field_goals_made3 \tab numeric \tab Away side: totals: three-point field goals made. \cr
#'       road_total_field_goals_attempted3 \tab numeric \tab Away side: totals: three-point field goals attempted. \cr
#'       road_total_free_throws_made \tab numeric \tab Away side: totals: free throws made. \cr
#'       road_total_free_throws_attempted \tab numeric \tab Away side: totals: free throws attempted. \cr
#'       road_total_field_goals_made_total \tab numeric \tab Away side: totals: field goals made. \cr
#'       road_total_field_goals_attempted_total \tab numeric \tab Away side: totals: field goals attempted. \cr
#'       road_total_accuracy_made \tab numeric \tab Away side: totals: shots made (accuracy numerator). \cr
#'       road_total_accuracy_attempted \tab numeric \tab Away side: totals: shots attempted (accuracy denominator). \cr
#'       road_total_total_rebounds \tab numeric \tab Away side: totals: total rebounds. \cr
#'       road_total_defensive_rebounds \tab numeric \tab Away side: totals: defensive rebounds. \cr
#'       road_total_offensive_rebounds \tab numeric \tab Away side: totals: offensive rebounds. \cr
#'       road_total_assistances \tab numeric \tab Away side: totals: assists. \cr
#'       road_total_steals \tab numeric \tab Away side: totals: steals. \cr
#'       road_total_turnovers \tab numeric \tab Away side: totals: turnovers. \cr
#'       road_total_blocks_favour \tab numeric \tab Away side: totals: blocks made. \cr
#'       road_total_blocks_against \tab numeric \tab Away side: totals: shots blocked by the opponent. \cr
#'       road_total_fouls_commited \tab numeric \tab Away side: totals: personal fouls committed. \cr
#'       road_total_fouls_received \tab numeric \tab Away side: totals: fouls drawn. \cr
#'       road_total_plus_minus \tab numeric \tab Away side: totals: plus/minus. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row (the game):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_code \tab character \tab Game number within the season (1-based; Utf8 join key). \cr
#'       round \tab integer \tab Round number within the season. \cr
#'       round_alias \tab character \tab Short alias of the round. \cr
#'       round_name \tab character \tab Display name of the round. \cr
#'       played \tab logical \tab Whether the game has been played. \cr
#'       date \tab character \tab Scheduled tip-off (ISO 8601, venue local time). \cr
#'       confirmed_date \tab logical \tab Whether the game date is confirmed. \cr
#'       confirmed_hour \tab logical \tab Whether the tip-off time is confirmed. \cr
#'       local_time_zone \tab integer \tab UTC offset of the venue, in hours. \cr
#'       local_date \tab character \tab Scheduled tip-off in venue local time (ISO 8601). \cr
#'       utc_date \tab character \tab Scheduled tip-off in UTC (ISO 8601). \cr
#'       local_last5_form \tab character \tab Home side: results of the last five games, oldest first (W / L), JSON-encoded. \cr
#'       road_last5_form \tab character \tab Away side: results of the last five games, oldest first (W / L), JSON-encoded. \cr
#'       season_name \tab character \tab Season: display name. \cr
#'       season_code \tab character \tab Season code: competition code + start year, e.g. E2025 for 2025-26 (Utf8 join key). \cr
#'       season_alias \tab character \tab Season: short display alias. \cr
#'       season_competition_code \tab character \tab Season: competition code (E = EuroLeague, U = EuroCup; Utf8 join key). \cr
#'       season_year \tab integer \tab Season: start year of the season. \cr
#'       season_start_date \tab character \tab Season: start date (ISO 8601). \cr
#'       group_id \tab character \tab Group: provider identifier for the entity (Utf8 join key). \cr
#'       group_order \tab integer \tab Group: display order within the roster. \cr
#'       group_name \tab character \tab Group: display name. \cr
#'       group_raw_name \tab character \tab Group: group name as stored by the engine. \cr
#'       phase_type_code \tab character \tab Phase type code (RS = regular season, PO = playoffs, ...). \cr
#'       phase_type_alias \tab character \tab Phase type: short display alias. \cr
#'       phase_type_name \tab character \tab Phase type: display name. \cr
#'       phase_type_is_group_phase \tab logical \tab Phase type: whether the phase is played in groups. \cr
#'       local_club_code \tab character \tab Home side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       local_club_name \tab character \tab Home side: club: display name. \cr
#'       local_club_abbreviated_name \tab character \tab Home side: club: abbreviated display name. \cr
#'       local_club_editorial_name \tab character \tab Home side: club: editorial (long-form) display name. \cr
#'       local_club_tv_code \tab character \tab Home side: club: three-letter broadcast abbreviation of the club. \cr
#'       local_club_is_virtual \tab logical \tab Home side: club: whether the club is a placeholder rather than a real club. \cr
#'       local_club_images_crest \tab character \tab Home side: club: URL of the club crest image. \cr
#'       local_score \tab integer \tab Home side: final score of the side. \cr
#'       local_standings_score \tab integer \tab Home side: score of the side as counted for the standings. \cr
#'       road_club_code \tab character \tab Away side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       road_club_name \tab character \tab Away side: club: display name. \cr
#'       road_club_abbreviated_name \tab character \tab Away side: club: abbreviated display name. \cr
#'       road_club_editorial_name \tab character \tab Away side: club: editorial (long-form) display name. \cr
#'       road_club_tv_code \tab character \tab Away side: club: three-letter broadcast abbreviation of the club. \cr
#'       road_club_is_virtual \tab logical \tab Away side: club: whether the club is a placeholder rather than a real club. \cr
#'       road_club_images_crest \tab character \tab Away side: club: URL of the club crest image. \cr
#'       road_score \tab integer \tab Away side: final score of the side. \cr
#'       road_standings_score \tab integer \tab Away side: score of the side as counted for the standings. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
