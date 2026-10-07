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
#'   `"aheadbehind"`, matched exactly (no prefixes, as in sdv-py); the columns
#'   depend on it (see Returns).
#' @return A `hoopR_data` tibble with one row per team. The columns depend on
#'   `kind`:
#'
#'   **`kind = "basicstandings"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       position \tab integer \tab Position code of the player (engine integer). \cr
#'       position_change \tab character \tab Movement since the previous round (Up, Down, Equal). \cr
#'       games_played \tab integer \tab Games played. \cr
#'       games_won \tab integer \tab Games won. \cr
#'       games_lost \tab integer \tab Games lost. \cr
#'       qualified \tab logical \tab Whether the team has clinched qualification for the next phase. \cr
#'       win_percentage \tab character \tab Win percentage, formatted (e.g. 100\%). \cr
#'       points_difference \tab character \tab Points for minus points against, signed and formatted (e.g. +19). \cr
#'       points_for \tab integer \tab Points scored. \cr
#'       points_against \tab integer \tab Points conceded. \cr
#'       home_record \tab character \tab Home win-loss record (W-L). \cr
#'       away_record \tab character \tab Away win-loss record (W-L). \cr
#'       neutral_record \tab character \tab Neutral-venue win-loss record (W-L). \cr
#'       overtime_record \tab character \tab Overtime win-loss record (W-L). \cr
#'       last_ten_record \tab character \tab Win-loss record over the last ten games (W-L). \cr
#'       group_name \tab character \tab Group: display name. \cr
#'       last5_form \tab character \tab Results of the last five games, oldest first (W / L), JSON-encoded. \cr
#'       club_code \tab character \tab Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       club_name \tab character \tab Club: display name. \cr
#'       club_abbreviated_name \tab character \tab Club: abbreviated display name. \cr
#'       club_editorial_name \tab character \tab Club: editorial (long-form) display name. \cr
#'       club_tv_code \tab character \tab Club: three-letter broadcast abbreviation of the club. \cr
#'       club_is_virtual \tab logical \tab Club: whether the club is a placeholder rather than a real club. \cr
#'       club_images_crest \tab character \tab Club: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   **`kind = "calendarstandings"`** (the `streaks` cell is JSON text: semantically
#'   equal to sdv-py's, not byte-equal -- separators and unicode escaping differ)
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       position \tab integer \tab Position code of the player (engine integer). \cr
#'       position_change \tab character \tab Movement since the previous round (Up, Down, Equal). \cr
#'       games_played \tab integer \tab Games played. \cr
#'       games_won \tab integer \tab Games won. \cr
#'       games_lost \tab integer \tab Games lost. \cr
#'       qualified \tab logical \tab Whether the team has clinched qualification for the next phase. \cr
#'       group_name \tab character \tab Group: display name. \cr
#'       streaks \tab character \tab Per-round result streaks: start date, end date and W-L record of each run, JSON-encoded. \cr
#'       club_code \tab character \tab Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       club_name \tab character \tab Club: display name. \cr
#'       club_abbreviated_name \tab character \tab Club: abbreviated display name. \cr
#'       club_editorial_name \tab character \tab Club: editorial (long-form) display name. \cr
#'       club_tv_code \tab character \tab Club: three-letter broadcast abbreviation of the club. \cr
#'       club_is_virtual \tab logical \tab Club: whether the club is a placeholder rather than a real club. \cr
#'       club_images_crest \tab character \tab Club: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   **`kind = "streaks"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       position \tab integer \tab Position code of the player (engine integer). \cr
#'       position_change \tab character \tab Movement since the previous round (Up, Down, Equal). \cr
#'       games_played \tab integer \tab Games played. \cr
#'       games_won \tab integer \tab Games won. \cr
#'       games_lost \tab integer \tab Games lost. \cr
#'       qualified \tab logical \tab Whether the team has clinched qualification for the next phase. \cr
#'       home_record \tab character \tab Home win-loss record (W-L). \cr
#'       away_record \tab character \tab Away win-loss record (W-L). \cr
#'       last10 \tab character \tab Win-loss record over the last ten games (W-L). \cr
#'       home_last5 \tab character \tab Win-loss record over the last five home games (W-L). \cr
#'       away_last5 \tab character \tab Win-loss record over the last five away games (W-L). \cr
#'       longest_wins_streak_current_season \tab integer \tab Longest winning streak this season. \cr
#'       longest_loses_streak_current_season \tab integer \tab Longest losing streak this season. \cr
#'       longest_wins_streak_any_season \tab integer \tab Longest winning streak in any season. \cr
#'       longest_loses_streak_any_season \tab integer \tab Longest losing streak in any season. \cr
#'       group_name \tab character \tab Group: display name. \cr
#'       club_code \tab character \tab Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       club_name \tab character \tab Club: display name. \cr
#'       club_abbreviated_name \tab character \tab Club: abbreviated display name. \cr
#'       club_editorial_name \tab character \tab Club: editorial (long-form) display name. \cr
#'       club_tv_code \tab character \tab Club: three-letter broadcast abbreviation of the club. \cr
#'       club_is_virtual \tab logical \tab Club: whether the club is a placeholder rather than a real club. \cr
#'       club_images_crest \tab character \tab Club: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   **`kind = "aheadbehind"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       position \tab integer \tab Position code of the player (engine integer). \cr
#'       position_change \tab character \tab Movement since the previous round (Up, Down, Equal). \cr
#'       games_played \tab integer \tab Games played. \cr
#'       games_won \tab integer \tab Games won. \cr
#'       games_lost \tab integer \tab Games lost. \cr
#'       qualified \tab logical \tab Whether the team has clinched qualification for the next phase. \cr
#'       wins_percentage \tab character \tab Win percentage, formatted (e.g. 100\%). \cr
#'       quater1_ahead \tab character \tab Win-loss record when ahead after the 1st quarter (W-L; sic: the API spells quarter this way). \cr
#'       quater1_behind \tab character \tab Win-loss record when behind after the 1st quarter (W-L; sic: the API spells quarter this way). \cr
#'       quater1_tied \tab character \tab Win-loss record when tied after the 1st quarter (W-L; sic: the API spells quarter this way). \cr
#'       half1_ahead \tab character \tab Win-loss record when ahead at the half (W-L; sic: the API spells quarter this way). \cr
#'       half1_behind \tab character \tab Win-loss record when behind at the half (W-L; sic: the API spells quarter this way). \cr
#'       half1_tied \tab character \tab Win-loss record when tied at the half (W-L; sic: the API spells quarter this way). \cr
#'       quater3_ahead \tab character \tab Win-loss record when ahead after the 3rd quarter (W-L; sic: the API spells quarter this way). \cr
#'       quater3_behind \tab character \tab Win-loss record when behind after the 3rd quarter (W-L; sic: the API spells quarter this way). \cr
#'       quater3_tied \tab character \tab Win-loss record when tied after the 3rd quarter (W-L; sic: the API spells quarter this way). \cr
#'       group_name \tab character \tab Group: display name. \cr
#'       club_code \tab character \tab Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       club_name \tab character \tab Club: display name. \cr
#'       club_abbreviated_name \tab character \tab Club: abbreviated display name. \cr
#'       club_editorial_name \tab character \tab Club: editorial (long-form) display name. \cr
#'       club_tv_code \tab character \tab Club: three-letter broadcast abbreviation of the club. \cr
#'       club_is_virtual \tab logical \tab Club: whether the club is a placeholder rather than a real club. \cr
#'       club_images_crest \tab character \tab Club: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#'   `"advanced"`, matched exactly (no prefixes, as in sdv-py); the columns
#'   depend on it (see Returns).
#' @param season_mode (*character* default `"Single"`): Season mode; `Single`
#'   as captured (other values unverified).
#' @param season_code (*character* required by the API): Competition code +
#'   start year, e.g. `E2025` for 2025-26 (the `SeasonCode` query parameter).
#' @param statistic_mode (*character* default `"PerGame"`): `PerGame` as
#'   captured (other values unverified).
#' @param limit (*integer* optional): Page size.
#' @param offset (*integer* optional): Row offset into the full list.
#' @return A `hoopR_data` tibble with one row per player. The columns depend on
#'   `mode`:
#'
#'   **`mode = "traditional"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player_ranking \tab integer \tab Rank of the player on the requested statistic mode. \cr
#'       games_played \tab numeric \tab Games played. \cr
#'       games_started \tab numeric \tab Games started. \cr
#'       minutes_played \tab numeric \tab Minutes played. \cr
#'       points_scored \tab numeric \tab Points scored. \cr
#'       two_pointers_made \tab numeric \tab Two-point field goals made. \cr
#'       two_pointers_attempted \tab numeric \tab Two-point field goals attempted. \cr
#'       two_pointers_percentage \tab character \tab Two-point field-goal percentage, formatted. \cr
#'       three_pointers_made \tab numeric \tab Three-point field goals made. \cr
#'       three_pointers_attempted \tab numeric \tab Three-point field goals attempted. \cr
#'       three_pointers_percentage \tab character \tab Three-point field-goal percentage, formatted. \cr
#'       free_throws_made \tab numeric \tab Free throws made. \cr
#'       free_throws_attempted \tab numeric \tab Free throws attempted. \cr
#'       free_throws_percentage \tab character \tab Free-throw percentage, formatted. \cr
#'       offensive_rebounds \tab numeric \tab Offensive rebounds. \cr
#'       defensive_rebounds \tab numeric \tab Defensive rebounds. \cr
#'       total_rebounds \tab numeric \tab Total rebounds. \cr
#'       assists \tab numeric \tab Assists. \cr
#'       steals \tab numeric \tab Steals. \cr
#'       turnovers \tab numeric \tab Turnovers. \cr
#'       blocks \tab numeric \tab Blocks made. \cr
#'       blocks_against \tab numeric \tab Shots blocked by the opponent. \cr
#'       fouls_commited \tab numeric \tab Personal fouls committed. \cr
#'       fouls_drawn \tab numeric \tab Fouls drawn. \cr
#'       pir \tab numeric \tab Performance index rating (PIR). \cr
#'       player_code \tab character \tab Player: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       player_name \tab character \tab Player: display name. \cr
#'       player_age \tab integer \tab Age of the player in years. \cr
#'       player_image_url \tab character \tab Player: URL of the image. \cr
#'       player_team_code \tab character \tab Player: euroLeague club code (Utf8 join key). \cr
#'       player_team_tv_codes \tab character \tab Player: three-letter broadcast abbreviation(s) of the club. \cr
#'       player_team_name \tab character \tab Player: club display name. \cr
#'       player_team_image_url \tab character \tab Player: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   **`mode = "advanced"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player_ranking \tab integer \tab Rank of the player on the requested statistic mode. \cr
#'       games_played \tab numeric \tab Games played. \cr
#'       minutes_played \tab numeric \tab Minutes played. \cr
#'       effective_field_goal_percentage \tab character \tab Effective field-goal percentage, formatted. \cr
#'       true_shooting_percentage \tab character \tab True shooting percentage, formatted. \cr
#'       offensive_rebounds_percentage \tab character \tab Offensive rebound percentage, formatted. \cr
#'       defensive_rebounds_percentage \tab character \tab Defensive rebound percentage, formatted. \cr
#'       rebounds_percentage \tab character \tab Total rebound percentage, formatted. \cr
#'       assists_to_turnovers_ratio \tab numeric \tab Assist-to-turnover ratio. \cr
#'       assists_ratio \tab character \tab Assist ratio (assists per 100 possessions used), formatted. \cr
#'       turnovers_ratio \tab character \tab Turnover ratio (turnovers per 100 possessions used), formatted. \cr
#'       two_point_attempts_ratio \tab character \tab Share of field-goal attempts that are two-pointers, formatted. \cr
#'       three_point_attempts_ratio \tab character \tab Share of field-goal attempts that are three-pointers, formatted. \cr
#'       free_throws_rate \tab character \tab Free-throw rate (free-throw attempts per field-goal attempt), formatted. \cr
#'       possesions \tab numeric \tab Possessions (sic: the API spells it this way). \cr
#'       player_code \tab character \tab Player: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). \cr
#'       player_name \tab character \tab Player: display name. \cr
#'       player_age \tab integer \tab Age of the player in years. \cr
#'       player_image_url \tab character \tab Player: URL of the image. \cr
#'       player_team_code \tab character \tab Player: euroLeague club code (Utf8 join key). \cr
#'       player_team_tv_codes \tab character \tab Player: three-letter broadcast abbreviation(s) of the club. \cr
#'       player_team_name \tab character \tab Player: club display name. \cr
#'       player_team_image_url \tab character \tab Player: URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
#' @return A `hoopR_data` tibble with one row per team. The columns depend on
#'   `mode`:
#'
#'   **`mode = "traditional"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_ranking \tab integer \tab Rank of the team on the requested statistic mode. \cr
#'       games_played \tab numeric \tab Games played. \cr
#'       minutes_played \tab numeric \tab Minutes played. \cr
#'       points_scored \tab numeric \tab Points scored. \cr
#'       two_pointers_made \tab numeric \tab Two-point field goals made. \cr
#'       two_pointers_attempted \tab numeric \tab Two-point field goals attempted. \cr
#'       two_pointers_percentage \tab character \tab Two-point field-goal percentage, formatted. \cr
#'       three_pointers_made \tab numeric \tab Three-point field goals made. \cr
#'       three_pointers_attempted \tab numeric \tab Three-point field goals attempted. \cr
#'       three_pointers_percentage \tab character \tab Three-point field-goal percentage, formatted. \cr
#'       free_throws_made \tab numeric \tab Free throws made. \cr
#'       free_throws_attempted \tab numeric \tab Free throws attempted. \cr
#'       free_throws_percentage \tab character \tab Free-throw percentage, formatted. \cr
#'       offensive_rebounds \tab numeric \tab Offensive rebounds. \cr
#'       defensive_rebounds \tab numeric \tab Defensive rebounds. \cr
#'       total_rebounds \tab numeric \tab Total rebounds. \cr
#'       assists \tab numeric \tab Assists. \cr
#'       steals \tab numeric \tab Steals. \cr
#'       turnovers \tab numeric \tab Turnovers. \cr
#'       blocks \tab numeric \tab Blocks made. \cr
#'       blocks_against \tab numeric \tab Shots blocked by the opponent. \cr
#'       fouls_commited \tab numeric \tab Personal fouls committed. \cr
#'       fouls_drawn \tab numeric \tab Fouls drawn. \cr
#'       pir \tab numeric \tab Performance index rating (PIR). \cr
#'       team_code \tab character \tab EuroLeague club code (Utf8 join key). \cr
#'       team_tv_codes \tab character \tab Three-letter broadcast abbreviation(s) of the club. \cr
#'       team_name \tab character \tab Club display name. \cr
#'       team_image_url \tab character \tab URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   **`mode = "advanced"`**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_ranking \tab integer \tab Rank of the team on the requested statistic mode. \cr
#'       games_played \tab numeric \tab Games played. \cr
#'       effective_field_goal_percentage \tab character \tab Effective field-goal percentage, formatted. \cr
#'       true_shooting_percentage \tab character \tab True shooting percentage, formatted. \cr
#'       offensive_rebounds_percentage \tab character \tab Offensive rebound percentage, formatted. \cr
#'       defensive_rebounds_percentage \tab character \tab Defensive rebound percentage, formatted. \cr
#'       rebounds_percentage \tab character \tab Total rebound percentage, formatted. \cr
#'       assists_to_turnovers_ratio \tab numeric \tab Assist-to-turnover ratio. \cr
#'       assists_ratio \tab character \tab Assist ratio (assists per 100 possessions used), formatted. \cr
#'       turnovers_ratio \tab character \tab Turnover ratio (turnovers per 100 possessions used), formatted. \cr
#'       two_point_rate \tab character \tab Share of field-goal attempts that are two-pointers, formatted. \cr
#'       three_point_rate \tab character \tab Share of field-goal attempts that are three-pointers, formatted. \cr
#'       free_throws_rate \tab character \tab Free-throw rate (free-throw attempts per field-goal attempt), formatted. \cr
#'       points_from_two_pointers_percentage \tab character \tab Share of points from two-pointers, formatted. \cr
#'       points_from_three_pointers_percentage \tab character \tab Share of points from three-pointers, formatted. \cr
#'       points_from_free_throws_percentage \tab character \tab Share of points from free throws, formatted. \cr
#'       team_code \tab character \tab EuroLeague club code (Utf8 join key). \cr
#'       team_tv_codes \tab character \tab Three-letter broadcast abbreviation(s) of the club. \cr
#'       team_name \tab character \tab Club display name. \cr
#'       team_image_url \tab character \tab URL of the club crest image. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
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
