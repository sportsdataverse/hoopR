# lba.R -- Lega Basket Serie A (Italy) wrappers over the site's own JSON API (www.legabasket.it/api), at parity
# with sdv-py sportsdataverse/basketball/lba (origin/main e3d232ebc9). Transport, season mapping and refusals:
# R/lba_runtime.R; frames: R/lba_parsers.R; columns: R/lba_schema.R. Generated from sdv-py
# tools/codegen/endpoints/legabasket.yaml and manual_column_descriptions.yaml.
# The @details of every lba topic that shares the lba_championships() notes (roxygen @eval .intl_details()).
.lba_championships_details <- c(
  "* Unofficial and unsupported: these wrappers read the JSON API that the Next.js site www.legabasket.it itself",
  "  calls. Legal notice: the site's terms say \"Non e' consentito copiare ... dati e informazioni senza",
  '  autorizzazione scritta" (copying data and information without written authorisation is not allowed), except for',
  "  personal, non-commercial use. Use the data accordingly, and check the terms before you republish it.",
  "* robots.txt allows /api and sets Crawl-delay: 2. The runtime waits 2 s before every request, retries included.",
  "  Crawl incrementally: fetch a final game once (keyed by game_id), find new games with one lba_calendar call per",
  "  round, and do not backfill a history in a burst.",
  "* Seasons are END years (2027 = 2026-27); the site sends START years and the runtime maps them (season - 1 on the",
  "  wire). Game and player ids are global; team ids are re-issued every season (join lba_teams for the stable",
  "  club_id); a championship id is one season AND one phase (Regular Season and Play Off differ).",
  "* Play-by-play starts in 2017-18 and changes shape in 2019-20 (pixel frame to court percent) and 2021-22; see",
  "  lba_pbp. Box scores reach back to 1995-96, where the period scores were not recorded (0 means missing).",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, or a body with no rows:",
  "  an unknown season, a play-by-play before 2017-18, standings of a finished championship without a round),",
  "  `hoopR_bad_request` (a season that is not an END year, a bad choice, HTTP 400 / 422) and `hoopR_asset_fetch`",
  "  (any other non-2xx, a connection failure after retries, an empty / non-JSON / error-shaped 200, a game that is",
  "  not final on the box score, play-by-play and shot routes, a truncated page, or a body for another season,",
  "  championship, game, team, player, round or category than the one asked for). An unknown id is HTTP 500, which",
  "  is not retried. A body the parser finds no rows in gives a zero-row tibble with these columns."
)

#' @title
#' **Get LBA Championships**
#' @description
#' Championships of a season, one per phase (Regular Season, Play Off); every season when none is given.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships` (`cs_id=1&items=1000&s=<season>`)
#' @param season Season END year (2027 = 2026-27). Omitted = every season (310 championships).
#' @return
#' A `hoopR_data` tibble: Championships of a season, one per phase (Regular Season, Play Off); every season when
#'   none is given. The columns are always these, in this order (sdv-py `lba_championships`); a column the site adds
#'   later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | championship_id | integer | Championship id (one season and phase). |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | name | character | Championship name, e.g. `Regular Season A`, `Play Off A1`. |
#' | status | integer | Championship status: 1 = in progress, 2 = finished (inferred from the 2026-27 and past samples). |
#' | championship_type_id | integer | Phase type id: 4 = Regular Season, 2 = Play Off. |
#' | championship_series_id | integer | Series id, 1 = Serie A. |
#' | full_name | character | Name with the season, e.g. `Regular Season A 2017`. |
#' | focus_on | logical | Highlighted on the site. |
#' | ctype_code | character | Phase type code: `RS` / `PO`. |
#' | ctype_name | character | Phase type name, as sent in English: `Regular Season`, `Play Off`. |
#' | cserie_code | character | Series code, `A1` = Serie A. |
#' | cserie_name | character | Name of the championship series, e.g. Serie A. |
#' | logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_championships(season = 2027))
#' }
#' @export
#' @family LBA Functions
lba_championships <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("championships", list(s = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Calendar**
#' @description
#' Games of one round of a championship: teams, score, venue, referees and broadcasters.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-calendar-by-id` (`id=<championship_id>&d=<round>`)
#' @param championship_id (required) Championship id (championship_id in lba_championships): one season AND one
#'   phase.
#' @param round Round number (day_serial, 1, 2, ...). Omitted = the current round (the last played for a finished
#'   championship).
#' @return
#' A `hoopR_data` tibble: Games of one round of a championship: teams, score, venue, referees and broadcasters. The
#'   columns are always these, in this order (sdv-py `lba_calendar`); a column the site adds later is appended after
#'   them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | game_status | character | Game status, number sent as a string: `0` scheduled, `1` live, `2` final (per the OSS client; only `2` sampled). |
#' | championship_id | integer | Championship id (season + phase) of the game. |
#' | championships_day_id | integer | Round id (`championships_day_id` key space: one round of one championship; joins `filters.days[].id` and standings `championships_day_id`; not the `d` param). |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | number | integer | Round number of the game, equal to `day_serial` (the `d` echo the capture checks). |
#' | match_datetime | character | Tip-off, ISO-8601 with the Italian offset (1995-96: midnight, no time kept). |
#' | match_hh | integer | Tip-off hour, local time. |
#' | match_mm | integer | Tip-off minute, local time. |
#' | home_final_score | integer | Final points of the home team. |
#' | visitor_final_score | integer | Final points of the away team. |
#' | target_score | character | Null in every sample (meaning unverified). |
#' | additional_time | integer | Overtime periods played (0 in every sample; reading inferred). |
#' | plant_id | integer | Arena id (arena key space; joins nothing specced). |
#' | websocket_match_id | integer | Live-feed game id, number sent as a string; separate from the game id. |
#' | ticketing_url | character | Ticket shop URL (null for old games). |
#' | has_streaming | integer | 1 when a stream exists, else 0. |
#' | updated_at | character | Timestamp, ISO-8601 with the Italian offset. Last update of the game row. |
#' | h_team_id | integer | Home team id (team-season). |
#' | h_team_name | character | Home team name (sponsor name of that season). |
#' | h_club_code | character | Home club code, e.g. `TVB`; null on the 2017-18 and 1995-96 calendar rows. |
#' | h_team_enabled | logical | Home team page enabled on the site. |
#' | home_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | v_team_id | integer | Away team id (team-season). |
#' | v_team_name | character | Visitor team name (the sponsor name of that season). |
#' | v_club_code | character | Away club code (`BCR`); null on the 2017-18 and 1995-96 calendar rows. |
#' | v_team_enabled | logical | Away team page enabled on the site. |
#' | v_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | town_id | integer | Town id of the arena (town key space; joins nothing specced). |
#' | plant_name | character | Name of the arena where the game is played. |
#' | town_name | character | Town of the arena. |
#' | day_code | character | Round code (`1`, `2`, ...; string in game rows, integer in standings). |
#' | day_serial | integer | Round number (`event_serial`, the `d` param). |
#' | day_name | character | Round name, Italian: `1o Giornata` = matchday 1. |
#' | match_serie_key | character | The two team ids joined low_high (`1761_1764`). |
#' | referees | character | JSON list of the game's referees (id, name, surname); null when the site lists none. |
#' | broadcasters | character | JSON list of the game's broadcasters (name, logo key); null when the site lists none. |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_calendar(championship_id = 602, round = 1))
#' }
#' @export
#' @family LBA Functions
lba_calendar <- function(championship_id, round = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("calendar", list(id = championship_id, d = round), call = rlang::current_env())
}

#' @title
#' **Get LBA Game**
#' @description
#' Game header: teams, venue, quarter scores, coaches, referees and broadcasters.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-by-id` (`sc=1&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Game header: teams, venue, quarter scores, coaches, referees and broadcasters. The columns
#'   are always these, in this order (sdv-py `lba_game`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | game_status | character | Game status, number sent as a string: `0` scheduled, `1` live, `2` final (per the OSS client; only `2` sampled). |
#' | championship_id | integer | Championship id (season + phase) of the game. |
#' | competition_name | character | Championship full name, e.g. `Regular Season 2026/27`. |
#' | championships_day_id | integer | Round id (`championships_day_id` key space: one round of one championship; joins `filters.days[].id` and standings `championships_day_id`; not the `d` param). |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | number | integer | Round number of the game, equal to `day_serial` (the `d` echo the capture checks). |
#' | match_datetime | character | Tip-off, ISO-8601 with the Italian offset (1995-96: midnight, no time kept). |
#' | match_hh | integer | Tip-off hour, local time. |
#' | match_mm | integer | Tip-off minute, local time. |
#' | target_score | character | Null in every sample (meaning unverified). |
#' | home_final_score | integer | Final points of the home team. |
#' | visitor_final_score | integer | Final points of the away team. |
#' | q1_hs | integer | Home points in the 1st quarter (null in the 1995-96 sample: no period scores then). |
#' | q1_vs | integer | Away points in the 1st quarter. |
#' | q2_hs | integer | Home points in the 2nd quarter. |
#' | q2_vs | integer | Away points in the 2nd quarter. |
#' | q3_hs | integer | Home points in the 3rd quarter (0 in the 1995-96 sample: a placeholder, not a score). |
#' | q3_vs | integer | Away points in the 3rd quarter (0 placeholder in 1995-96). |
#' | q4_hs | integer | Home points in the 4th quarter (0 placeholder in 1995-96). |
#' | q4_vs | integer | Away points in the 4th quarter (0 placeholder in 1995-96). |
#' | ot_hs | integer | Home overtime points (0 without overtime). |
#' | ot_vs | integer | Away overtime points. |
#' | home_coach_id | integer | Home head coach id. |
#' | home_coach_code | character | Home head coach code `SURNAME3-NAME3`. |
#' | home_coach_fullname | character | Home head coach, `Surname Name`. |
#' | visitor_coach_id | integer | Away head coach id. |
#' | visitor_coach_code | character | Away head coach code. |
#' | visitor_coach_fullname | character | Away head coach, `Surname Name`. |
#' | additional_time | integer | Overtime periods played (0 in every sample; reading inferred). |
#' | plant_id | integer | Arena id (arena key space; joins nothing specced). |
#' | websocket_match_id | integer | Live-feed game id, number sent as a string; separate from the game id. |
#' | has_streaming | integer | 1 when a stream exists, else 0. |
#' | live_match_data | character | Null in every sample (meaning unverified). |
#' | quarter | character | Last period played, number sent as a string (`4`; `5` = overtime). |
#' | ticketing_url | character | Ticket shop URL (null for old games). |
#' | match_serie | character | All-time head-to-head as `home wins-away wins` (`6-18`; inferred from `match_hw` / `match_vw`). |
#' | match_hw | integer | All-time head-to-head wins of the home club (inferred). |
#' | match_vw | integer | All-time head-to-head wins of the away club (inferred). |
#' | updated_at | character | Timestamp, ISO-8601 with the Italian offset. Last update of the game row. |
#' | h_team_id | integer | Home team id (team-season). |
#' | h_team_name | character | Home team name (sponsor name of that season). |
#' | h_team_enabled | logical | Home team page enabled on the site. |
#' | home_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | v_team_id | integer | Away team id (team-season). |
#' | v_team_name | character | Visitor team name (the sponsor name of that season). |
#' | v_team_enabled | logical | Away team page enabled on the site. |
#' | v_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | plant_name | character | Name of the arena where the game is played. |
#' | day_code | character | Round code (`1`, `2`, ...; string in game rows, integer in standings). |
#' | day_serial | integer | Round number (`event_serial`, the `d` param). |
#' | day_name | character | Round name, Italian: `1o Giornata` = matchday 1. |
#' | competition_type_id | integer | Phase type id: 4 = Regular Season, 2 = Play Off. |
#' | competition_type_code | character | Phase type code: `RS` / `PO`. |
#' | competition_type | character | Phase type name: `Regular Season` / `Play Off`. |
#' | competition_serie_id | integer | Series id, 1 = Serie A. |
#' | competition_serie | character | Series name, `Serie A`. |
#' | day_phase_id | integer | Phase id: 1 = `Andata` (first half of the season), 2 = `Ritorno` (second half). |
#' | spectators | integer | Attendance: spectators at the game. |
#' | referees | character | JSON list of the game's referees (id, name, surname); null when the site lists none. |
#' | broadcasters | character | JSON list of the game's broadcasters (name, logo key); null when the site lists none. |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_game(game_id = 25602))
#' }
#' @export
#' @family LBA Functions
lba_game <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("game", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Box Score**
#' @description
#' Box score of a final game: one row per player of both teams (Italian-named stat columns).
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id` (`info=true&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Box score of a final game: one row per player of both teams (Italian-named stat columns).
#'   The columns are always these, in this order (sdv-py `lba_box_score`); a column the site adds later is appended
#'   after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | side | character | Which team of the game the row belongs to: home or visitor. |
#' | team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
#' | player_id | integer | Player id (global). |
#' | player_num | integer | Jersey number the player wore in the game. |
#' | player_surname | character | Family name, upper case. |
#' | player_name | character | Player's given name. |
#' | player_code | character | Player code `SURNAME3-NAME3-YY`. |
#' | player_p_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | pun | integer | Points (`punti`). |
#' | min | integer | Minutes played, whole minutes (`minuti`); 200 in `totals` = 5 x 40. |
#' | sec | integer | Seconds played (`secondi`) = `min` x 60 in every sample. |
#' | sf | character | Starter flag (`starting five`), number sent as a string: `1` = started. |
#' | falli_c | integer | Fouls committed (`falli commessi`). |
#' | falli_sf | integer | Fouls drawn (`falli subiti`). |
#' | falli_tc1 | integer | Technical fouls (`falli tecnici`; reading `tc1` as category-1 technicals is inferred). |
#' | falli_fla | integer | Unsportsmanlike / flagrant fouls (`falli antisportivi`). |
#' | t2_r | integer | 2-point field goals made (`tiri da 2 realizzati`). |
#' | t2_t | integer | 2-point field goals attempted (`tiri da 2 tentati`). |
#' | t2_perc | double | 2-point field-goal percentage, 0-100 (number; 0 when no attempt). |
#' | sc | integer | Dunks (`schiacciate`). |
#' | t3_r | integer | 3-point field goals made. |
#' | t3_t | integer | 3-point field goals attempted. |
#' | t3_perc | double | 3-point field-goal percentage, 0-100. |
#' | tl_r | integer | Free throws made (`tiri liberi realizzati`). |
#' | tl_t | integer | Free throws attempted (`tiri liberi tentati`). |
#' | tl_perc | double | Free-throw percentage, 0-100. |
#' | rimbalzi_o | integer | Offensive rebounds (`rimbalzi offensivi`). |
#' | rimbalzi_d | integer | Defensive rebounds (`rimbalzi difensivi`). |
#' | rimbalzi_t | integer | Total rebounds (`rimbalzi totali`). |
#' | stoppate_dat | integer | Blocks (`stoppate date`). |
#' | stoppate_sub | integer | Own shots blocked (`stoppate subite`). |
#' | palle_p | integer | Turnovers (`palle perse`). |
#' | palle_r | integer | Steals (`palle recuperate`). |
#' | ass | integer | Assists credited to the player in the game. |
#' | val_lega | integer | LBA efficiency rating (`valutazione Lega`). |
#' | val_oer | double | OER = points / (FGA + turnovers + FTA / 2); verified on every 2026-27 sample row. |
#' | plus_minus | integer | Plus-minus: point margin while on court. |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_box_score(game_id = 25602))
#' }
#' @export
#' @family LBA Functions
lba_box_score <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("box_score", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Team Box Score**
#' @description
#' Team lines of a final game's box score: the team-booked stats and the totals of each side.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id` (`info=true&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Team lines of a final game's box score: the team-booked stats and the totals of each side.
#'   The columns are always these, in this order (sdv-py `lba_team_box_score`); a column the site adds later is
#'   appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | side | character | Which team of the game the row belongs to: home or visitor. |
#' | team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
#' | row_type | character | team = stats booked to the team itself (team rebounds, team turnovers); totals = the whole side. |
#' | pun | integer | Points (`punti`). (team totals (players + team row)) |
#' | falli_c | integer | Fouls committed (`falli commessi`). (team totals (players + team row)) |
#' | falli_sf | integer | Fouls drawn (`falli subiti`). (team totals (players + team row)) |
#' | falli_tc1 | integer | Technical fouls (`falli tecnici`; reading `tc1` as category-1 technicals is inferred). (team totals (players + team row)) |
#' | falli_fla | integer | Unsportsmanlike / flagrant fouls (`falli antisportivi`). (team totals (players + team row)) |
#' | rimbalzi_o | integer | Offensive rebounds (`rimbalzi offensivi`). (team totals (players + team row)) |
#' | rimbalzi_d | integer | Defensive rebounds (`rimbalzi difensivi`). (team totals (players + team row)) |
#' | rimbalzi_t | integer | Total rebounds (`rimbalzi totali`). (team totals (players + team row)) |
#' | palle_p | integer | Turnovers (`palle perse`). (team totals (players + team row)) |
#' | palle_r | integer | Steals (`palle recuperate`). (team totals (players + team row)) |
#' | val_lega | integer | LBA efficiency rating (`valutazione Lega`). (team totals (players + team row)) |
#' | min | integer | Minutes played, whole minutes (`minuti`); 200 in `totals` = 5 x 40. (team totals (players + team row)) |
#' | sec | integer | Seconds played (`secondi`) = `min` x 60 in every sample. (team totals (players + team row)) |
#' | t2_r | integer | 2-point field goals made (`tiri da 2 realizzati`). (team totals (players + team row)) |
#' | t2_t | integer | 2-point field goals attempted (`tiri da 2 tentati`). (team totals (players + team row)) |
#' | t2_perc | double | 2-point field-goal percentage, 0-100 (number; 0 when no attempt). (team totals (players + team row)) |
#' | sc | integer | Dunks (`schiacciate`). (team totals (players + team row)) |
#' | t3_r | integer | 3-point field goals made. (team totals (players + team row)) |
#' | t3_t | integer | 3-point field goals attempted. (team totals (players + team row)) |
#' | t3_perc | double | 3-point field-goal percentage, 0-100. (team totals (players + team row)) |
#' | tl_r | integer | Free throws made (`tiri liberi realizzati`). (team totals (players + team row)) |
#' | tl_t | integer | Free throws attempted (`tiri liberi tentati`). (team totals (players + team row)) |
#' | tl_perc | double | Free-throw percentage, 0-100. (team totals (players + team row)) |
#' | stoppate_dat | integer | Blocks (`stoppate date`). (team totals (players + team row)) |
#' | stoppate_sub | integer | Own shots blocked (`stoppate subite`). (team totals (players + team row)) |
#' | ass | integer | Assists. (team totals (players + team row)) |
#' | val_oer | double | OER = points / (FGA + turnovers + FTA / 2); verified on every 2026-27 sample row. (team totals (players + team row)) |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_team_box_score(game_id = 25602))
#' }
#' @export
#' @family LBA Functions
lba_team_box_score <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("team_box_score", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Play-by-Play**
#' @description
#' Play-by-play of a final game (2017-18 on), one row per action with x/y; coordinate frame by era.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play` (`info=true&sort=asc&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Play-by-play of a final game (2017-18 on), one row per action with x/y; coordinate frame
#'   by era. The columns are always these, in this order (sdv-py `lba_pbp`); a column the site adds later is
#'   appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | home_team_id | integer | Home team-season id of the game (the play-by-play ht_id). |
#' | visitor_team_id | integer | Visitor team-season id of the game (the play-by-play vt_id). |
#' | team_side | character | Side of the acting team, home or visitor; null for a clock action without a team. |
#' | home_score | integer | Home points after the action, parsed from the score text (2021-22 on; else null). |
#' | visitor_score | integer | Visitor points after the action, parsed from the score text (2021-22 on; else null). |
#' | coord_frame | character | Frame of x and y: half_court_px (2017-18 and 2018-19 image pixels) or court_pct (2019-20 on, 0-100). |
#' | action_id | integer | Action id within the game (ascending in time from 2021-22; not ordered before). |
#' | description | character | Action type in Italian, e.g. `2 punti segnato` (2-pointer made); full translation table in the Divergence notes. |
#' | player_id | integer | Player id (null for team and clock actions). |
#' | team_id | integer | Team id (team-season) of the actor. |
#' | home_club | integer | 1 = the home team acted, 0 = the away team; null for clock actions, and on every action in 2018-19 and 2019-20 (use `side` there). |
#' | in_area | logical | True on shots from the paint (zone `3`). |
#' | dunk | integer | 1 = dunk, 0 otherwise. |
#' | seconds | integer | Elapsed seconds within `minute` (0-59); 0 before 2019-20. Elapsed = minute x 60 + seconds; `print_time` = period length minus that. |
#' | minute | integer | Elapsed minute of the period (2019-20 on: 0-9, with `seconds`); 2017-18 / 2018-19: 1-10, the minute in progress, `seconds` 0. |
#' | period | integer | Period: 1-4, 5+ = overtime. |
#' | order | integer | Sort key; `sort=asc` orders by it. |
#' | side | integer | Basket the row's side_area_zone is measured from, as sent: 0 = the basket at x = 0, 1 = the one at x = 100 (zone A is that basket's half: x < 50 for 0, x >= 50 for 1). It is NOT the team of the game (that is team_side): on shots, assists, fouls committed, turnovers and offensive rebounds it is the actor's attacking basket, which changes at half-time; on defensive rebounds, steals, blocks and fouls drawn it is the opponent's. |
#' | x | integer | Court x; frame by era (see the coordinates section): 2019-20 on, 0-100 % of the 28 m length; 2017-18 / 2018-19, half-court image pixels; null (2019-20 on) or 0 (earlier) when unlocated. |
#' | y | integer | Court y; 2019-20 on, 0-100 % of the 15 m width; 2017-18 / 2018-19, image pixels (see the coordinates section). |
#' | score | character | Score after the action, `home - away` string (`0 - 0`); 2020-21 on scoring actions only, null before. |
#' | linked_action_id | integer | `action_id` of the related action: the shot an assist or rebound belongs to, the foul a drawn foul answers, the player swapped in a substitution. |
#' | print_time | character | Game clock remaining, `MM:SS` (10:00 at a period start); null before 2021-22. |
#' | action_1_qualifier_code | character | First qualifier code, number sent as a string (shot type, turnover type, foul type; see `legend`). |
#' | action_2_qualifier_code | character | Second qualifier code (fast break `500`, blocked `1005`, tip-ins `1001`-`1004`, ...). |
#' | action_1_qualifier_description | character | `legend` label of `action_1_qualifier_code`, Italian. |
#' | action_2_qualifier_description | character | `legend` label of `action_2_qualifier_code`, Italian. |
#' | side_area_zone | character | `A` = in the actor's attacking half, `D` = its defensive half (2021-22 on). |
#' | side_area_code | character | Court zone `1`-`10`, number sent as a string (see the coordinates section; 2021-22 on). |
#' | player_name | character | Given name of the acting player. |
#' | player_surname | character | Family name of the acting player. |
#' | player_number | character | Jersey number, number sent as a string. |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | id | integer | Always null (not a key). |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_pbp(game_id = 25602))
#' }
#' @export
#' @family LBA Functions
lba_pbp <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("pbp", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Play-by-Play Legend**
#' @description
#' The play-by-play qualifier code table (59 codes) with its Italian labels.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play` (`info=true&sort=asc&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @return
#' A `hoopR_data` tibble: The play-by-play qualifier code table (59 codes) with its Italian labels. The columns are
#'   always these, in this order (sdv-py `lba_pbp_legend`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | code | integer | Qualifier code, the value of action_1_qualifier_code / action_2_qualifier_code on the actions. |
#' | label | character | Italian label of the qualifier code, as sent. |
#' @eval .intl_details(.lba_championships_details, "lba_pbp_legend(game_id = 25602)")
#' @export
#' @family LBA Functions
lba_pbp_legend <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("pbp_legend", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Shots**
#' @description
#' Shooting by court zone per team for a final game (made / attempted aggregates; zone 7 includes free throws).
#'
#' Endpoint: `GET https://www.legabasket.it/api/matches/get-championship-matches-shots-by-id` (`info=1&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Shooting by court zone per team for a final game (made / attempted aggregates; zone 7
#'   includes free throws). The columns are always these, in this order (sdv-py `lba_shots`); a column the site adds
#'   later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | side | character | Which team of the game the row belongs to: home or visitor. |
#' | team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
#' | zone | integer | Court zone 1-10 (the play-by-play side_area_code); zone 7 also holds the free throws. |
#' | made | integer | Shots made in the zone, parsed from num. |
#' | attempts | integer | Shots attempted in the zone, parsed from num. |
#' | perc | double | Made / attempted x 100. |
#' | precision | integer | Decimal places the site shows (1). |
#' | num | character | Made/attempted as a string (`17/21`); zone `7` also counts free throws. |
#' | opacity | integer | Heat-map shading for the site: `perc` floored, minimum 5. |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_shots(game_id = 25602))
#' }
#' @export
#' @family LBA Functions
lba_shots <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("shots", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Standings**
#' @description
#' Standings of a championship after a round, one row per team.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championship-ranking` (`id=<championship_id>&d=<round>`)
#' @param championship_id (required) Championship id (championship_id in lba_championships; a Regular Season id
#'   carries standings).
#' @param round Standings after this round. Required in practice for a finished championship: without it the site
#'   sends none (NoDataError).
#' @return
#' A `hoopR_data` tibble: Standings of a championship after a round, one row per team. The columns are always these,
#'   in this order (sdv-py `lba_standings`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | standing_id | integer | Standings row id (one team after one round; joins nothing else). |
#' | championships_day_id | integer | Round id the standings are after. |
#' | team_id | integer | Team id (team-season). |
#' | position | integer | Rank in the standings. |
#' | wins | integer | Games the team has won through the round. |
#' | defeats | integer | Games the team has lost through the round. |
#' | points_made | integer | Points the team has scored through the round. |
#' | points_suffered | integer | Points allowed. |
#' | qp | integer | Tie-break quotient (`quoziente punti`?); 1 in the samples (unverified). |
#' | lv | character | Null in every sample (meaning unverified). |
#' | lp | character | Null in every sample (meaning unverified). |
#' | lpf | character | Null in every sample (meaning unverified). |
#' | lps | character | Null in every sample (meaning unverified). |
#' | lqp | character | Null in every sample (meaning unverified). |
#' | updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
#' | points | integer | Standings points (2 per win). |
#' | penalty_points | integer | Points deducted (0 or null). |
#' | game_played | integer | Games the team has played through the round. |
#' | home_game_played | integer | Home games played. |
#' | home_wins | integer | Home games won. |
#' | home_defeats | integer | Home games the team has lost through the round. |
#' | away_game_played | integer | Away games played. |
#' | away_wins | integer | Away games won. |
#' | away_defeats | integer | Away games the team has lost through the round. |
#' | avg_points_made | double | Points scored per game. |
#' | avg_points_suffered | double | Points allowed per game. |
#' | home_points_made | integer | Points scored at home. |
#' | home_points_suffered | integer | Points allowed at home. |
#' | home_avg_points_made | double | Points scored per home game. |
#' | home_avg_points_suffered | double | Points allowed per home game. |
#' | away_points_made | integer | Points scored away. |
#' | away_points_suffered | integer | Points allowed away. |
#' | away_avg_points_made | double | Points scored per away game. |
#' | away_avg_points_suffered | double | Points allowed per away game. |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | ties | integer | Ties (0 or null; basketball has none). |
#' | home_ties | integer | Home ties (null). |
#' | away_ties | integer | Away ties (null). |
#' | play_off_qualified | logical | Clinched a play-off place (null in old seasons). |
#' | relegation | logical | Relegated (null in old seasons). |
#' | movement | character | Position change since the previous round, signed string (`+2`, `-1`; null for finished seasons). |
#' | wins_percent | double | Win percentage as a string with `%` (`100%`). |
#' | home_wins_percent | double | Home win percentage, string with `%`. |
#' | away_wins_percent | double | Away win percentage, string with `%`. |
#' | max_points_made | integer | Most points scored in a game. |
#' | home_max_points_made | integer | Most points scored in a home game. |
#' | away_max_points_made | integer | Most points scored in an away game. |
#' | day_code | integer | Round code the standings are after (integer). |
#' | day_name | character | Round name, Italian (`4a Giornata - 2o fase` = matchday 4 of the 2nd phase). |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
#' | logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | ctp | integer | Classification marker; 0 or null in the samples (unverified). |
#' | ctp_symbol | character | Null in every sample (meaning unverified). |
#' | ctp_description | character | Null in every sample (meaning unverified). |
#' | season_start_year | integer | The wire season field: the season START year (2026 = 2026-27), same as year. |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_standings(championship_id = 602, round = 3))
#' }
#' @export
#' @family LBA Functions
lba_standings <- function(championship_id, round = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("standings", list(id = championship_id, d = round), call = rlang::current_env())
}

#' @title
#' **Get LBA Teams**
#' @description
#' Teams of a season, one row per team-season with the stable club id.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-teams` (`items=50&year=<season>`)
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @return
#' A `hoopR_data` tibble: Teams of a season, one row per team-season with the stable club id. The columns are always
#'   these, in this order (sdv-py `lba_teams`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | team_id | integer | Team id (one team-season). |
#' | name | character | Team name of that season (sponsor name). |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
#' | club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
#' | updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
#' | logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_teams(season = 2027))
#' }
#' @export
#' @family LBA Functions
lba_teams <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("teams", list(year = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Roster**
#' @description
#' Players of one team-season with bio, number and role.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster` (`id=<team_id>`)
#' @param team_id (required) Team id (team_id in lba_teams), e.g. 1764. One team-season: ids are re-issued every
#'   season.
#' @return
#' A `hoopR_data` tibble: Players of one team-season with bio, number and role. The columns are always these, in
#'   this order (sdv-py `lba_roster`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
#' | club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
#' | club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | player_id | integer | Player id (global). |
#' | name | character | Player's given name. |
#' | surname | character | Player's family name. |
#' | code | character | Player code `SURNAME3-NAME3-YY`. |
#' | place_of_birth | character | Birthplace (Italian spelling). |
#' | birth_date | character | Birth date, Date `YYYY-MM-DD`. |
#' | player_number | character | Jersey number, number sent as a string. |
#' | country | character | Nationality, ISO alpha-3. |
#' | uefa_ratio | character | Eligibility class for the foreign-player quota: `I`, `E` or `C` (7 / 6 / 1 on the Treviso roster; reading as Italian / EU / non-EU is inferred). |
#' | height | integer | Player's height in centimetres. |
#' | weight | integer | Player's weight in kilograms. |
#' | year | integer | Season START year of the player entry (2026 = 2026-27). |
#' | start_date | character | Contract start with the team, Date `YYYY-MM-DD`. |
#' | end_date | character | Contract end with the team, Date `YYYY-MM-DD`. |
#' | player_role_id | integer | Position id (position key space: the id behind `player_role`; joins the `r_id` filter). |
#' | player_role | character | Position, Italian: `Playmaker` (point guard), `Guardia` (guard), `Ala` (forward), `Centro` (center), `-` unknown. |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | player_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' @eval .intl_details(.lba_championships_details, "lba_roster(team_id = 1764)")
#' @export
#' @family LBA Functions
lba_roster <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("roster", list(id = team_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Roster Coach**
#' @description
#' Head coach of one team-season.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster` (`id=<team_id>`)
#' @param team_id (required) Team id (team_id in lba_teams), e.g. 1764. One team-season: ids are re-issued every
#'   season.
#' @return
#' A `hoopR_data` tibble: Head coach of one team-season. The columns are always these, in this order (sdv-py
#'   `lba_roster_coach`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
#' | club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
#' | club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | coach_id | integer | Coach id (global coach key space; joins the game header `home_coach_id` / `visitor_coach_id`). |
#' | name | character | Coach's given name. |
#' | surname | character | Coach's family name. |
#' | birth_date | character | Birth date, Date `YYYY-MM-DD`. |
#' | place_of_birth | character | Birthplace (Italian spelling, e.g. `Londra`). |
#' | coach_type_id | integer | Coach role id (1 = head coach). |
#' | coach_type_description | character | Coach role, Italian: `Allenatore` = head coach. |
#' | coach_type_code | character | Coach role code, number sent as a string. |
#' | team_name | character | Team, short name. |
#' | coach_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' @eval .intl_details(.lba_championships_details, "lba_roster_coach(team_id = 1764)")
#' @export
#' @family LBA Functions
lba_roster_coach <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("roster_coach", list(id = team_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Team Players Stats**
#' @description
#' Season totals of each player of a team-season.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-team-players-stats` (`cs_id=1&id=<team_id>&s=<season>`)
#' @param team_id (required) Team id (team_id in lba_teams), e.g. 1764. One team-season: ids are re-issued every
#'   season.
#' @param season Season END year (2027 = 2026-27) of the team id. Omitted = the site's default (unverified).
#' @return
#' A `hoopR_data` tibble: Season totals of each player of a team-season. The columns are always these, in this order
#'   (sdv-py `lba_team_players_stats`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
#' | club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
#' | club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | player_id | integer | Player id (global, one per career). |
#' | player_name | character | Player's given name. |
#' | player_surname | character | Player's family name. |
#' | player_season | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | player_photo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | played_matches | integer | Games the player appeared in, in the request's championship series. |
#' | total_matches | integer | Team games while the player was listed (inferred). |
#' | start_formation | integer | Games the player started, in the request's championship series. |
#' | points_sum | integer | Season total of points. |
#' | played_minutes_sum | integer | Season total of minutes played. |
#' | rating_lega_sum | integer | Season total of LBA efficiency rating (`valutazione`). |
#' | rating_oer_sum | double | Sum of the per-game OER values (3.34 over 3 games), not a season OER. |
#' | offensive_rebound_sum | integer | Season total of offensive rebounds. |
#' | defensive_rebound_sum | integer | Season total of defensive rebounds. |
#' | total_rebound_sum | integer | Season total of total rebounds. |
#' | assists_sum | integer | Season total of assists. |
#' | regain_balls_sum | integer | Season total of steals. |
#' | lost_balls_sum | integer | Season total of turnovers. |
#' | ball_stop_given_sum | integer | Season total of blocks. |
#' | ball_stop_received_sum | integer | Season total of own shots blocked. |
#' | done_fouls_sum | integer | Season total of fouls committed. |
#' | suffered_fouls_sum | integer | Season total of fouls drawn. |
#' | plus_minus_sum | integer | Season total of plus-minus. |
#' | aplus_dp_sum | integer | Season total of `aplus_dp`, an unverified metric (not plus-minus or assists: Macura 2026-27 has 9 against plus-minus 8 and 3 assists). |
#' | slam_dunk_sum | integer | Season total of dunks. |
#' | shots_2p_realized_sum | integer | Season total of 2-point field goals made. |
#' | shots_2p_total_sum | integer | Season total of 2-point field goals attempted. |
#' | shots_2p_perc_sum | double | Season 2-point percentage, 0-100 (a rate despite `_sum`). |
#' | shots_3p_realized_sum | integer | Season total of 3-point field goals made. |
#' | shots_3p_total_sum | integer | Season total of 3-point field goals attempted. |
#' | shots_3p_perc_sum | double | Season 3-point percentage, 0-100 (a rate despite `_sum`). |
#' | free_throws_realized_sum | integer | Season total of free throws made. |
#' | free_throws_total_sum | integer | Season total of free throws attempted. |
#' | free_throws_perc_sum | double | Season free-throw percentage, 0-100 (a rate despite `_sum`). |
#' @eval .intl_details(.lba_championships_details, "lba_team_players_stats(team_id = 1764, season = 2027)")
#' @export
#' @family LBA Functions
lba_team_players_stats <- function(team_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("team_players_stats", list(id = team_id, s = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Players**
#' @description
#' Players of a season, 50 per page (walk the pages with page).
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-players` (`items=50&year=<season>&page=<page>`)
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @param page Page number, 1-based. Omitted = the first page.
#' @return
#' A `hoopR_data` tibble: Players of a season, 50 per page (walk the pages with page). The columns are always these,
#'   in this order (sdv-py `lba_players`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | player_id | integer | Player id (global). |
#' | name | character | Player's given name. |
#' | surname | character | Player's family name. |
#' | code | character | Player code `SURNAME3-NAME3-YY`. |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. The season of the team the row places the player on. |
#' | player_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' @inherit lba_championships details
#' @examples
#' \donttest{
#'   try(lba_players(season = 2027))
#' }
#' @export
#' @family LBA Functions
lba_players <- function(season = NULL, page = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("players", list(year = season, page = page), call = rlang::current_env())
}

#' @title
#' **Get LBA Player**
#' @description
#' Player bio with current-season totals, highs and averages (one row).
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-player-by-id` (`stats=1&id=<player_id>`)
#' @param player_id (required) Player id (player_id in lba_players or a box score), e.g. 969. Global: one id for a
#'   whole career.
#' @return
#' A `hoopR_data` tibble: Player bio with current-season totals, highs and averages (one row). The columns are
#'   always these, in this order (sdv-py `lba_player`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player id (global). |
#' | code | character | Player code `SURNAME3-NAME3-YY`. |
#' | name | character | Player's given name. |
#' | surname | character | Player's family name. |
#' | place_of_birth | character | Birthplace (Italian spelling). |
#' | birth_date | character | Birth date, Date `YYYY-MM-DD`. |
#' | updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
#' | ext_code | character | External (data feed) player code; equals `code` in the samples. |
#' | seo_meta_title | character | SEO title (null in the samples). |
#' | seo_meta_description | character | SEO description (null in the samples). |
#' | photo_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | fullbody_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). Null in every sample. |
#' | start_date | character | Contract start with the team, Date `YYYY-MM-DD`. |
#' | end_date | character | Contract end with the team, Date `YYYY-MM-DD`. |
#' | player_number | character | Jersey number, number sent as a string. |
#' | uefa_ratio | character | Eligibility class for the foreign-player quota: `I`, `E` or `C` (7 / 6 / 1 on the Treviso roster; reading as Italian / EU / non-EU is inferred). |
#' | height | integer | Player's height in centimetres. |
#' | weight | integer | Player's weight in kilograms. |
#' | team_id | integer | Team id (team-season) of his current team. |
#' | player_role_description | character | Position, Italian (see `players[].player_role` of the roster route). |
#' | player_alpha3 | character | Nationality, ISO alpha-3. |
#' | player_country_name | character | Nationality, Italian country name (`Italia` = Italy); map to English through `player_alpha3` (ISO 3166 alpha-3), not by translating the name. |
#' | player_country | character | Continent, Italian name (`Europa` = Europe; the other values are presumably `Africa`, `America`, `Asia`, `Oceania`, unobserved). |
#' | team_code | character | `<season>\|<team code>` of his current team (`2026\|TVU`). |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. The season of the team the row places the player on. |
#' | team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | stats_played_matches | integer | Games played this regular season. |
#' | stats_totals_highs_rs_player_id | integer | Player id (global, one per career). |
#' | stats_totals_highs_rs_championship_serie_code | character | Series code, `A1` = Serie A. |
#' | stats_totals_highs_rs_quintet_sum | integer | Current regular-season total of starts (in the starting five). |
#' | stats_totals_highs_rs_points_sum | integer | Current regular-season total of points. |
#' | stats_totals_highs_rs_played_minutes_sum | integer | Current regular-season total of minutes played. |
#' | stats_totals_highs_rs_played_matches_sum | integer | Current regular-season total of games played. |
#' | stats_totals_highs_rs_total_matches_sum | integer | Current regular-season total of team games while the player was listed (a player with 3 of 21 shows 21; inferred). |
#' | stats_totals_highs_rs_done_fouls_sum | integer | Current regular-season total of fouls committed. |
#' | stats_totals_highs_rs_suffered_fouls_sum | integer | Current regular-season total of fouls drawn. |
#' | stats_totals_highs_rs_shots_2p_realized_sum | integer | Current regular-season total of 2-point field goals made. |
#' | stats_totals_highs_rs_shots_2p_total_sum | integer | Current regular-season total of 2-point field goals attempted. |
#' | stats_totals_highs_rs_slam_dunk_sum | integer | Current regular-season total of dunks. |
#' | stats_totals_highs_rs_shots_3p_realized_sum | integer | Current regular-season total of 3-point field goals made. |
#' | stats_totals_highs_rs_shots_3p_total_sum | integer | Current regular-season total of 3-point field goals attempted. |
#' | stats_totals_highs_rs_free_throws_realized_sum | integer | Current regular-season total of free throws made. |
#' | stats_totals_highs_rs_free_throws_total_sum | integer | Current regular-season total of free throws attempted. |
#' | stats_totals_highs_rs_offensive_rebound_sum | integer | Current regular-season total of offensive rebounds. |
#' | stats_totals_highs_rs_defensive_rebound_sum | integer | Current regular-season total of defensive rebounds. |
#' | stats_totals_highs_rs_ball_stop_given_sum | integer | Current regular-season total of blocks. |
#' | stats_totals_highs_rs_ball_stop_received_sum | integer | Current regular-season total of own shots blocked. |
#' | stats_totals_highs_rs_lost_balls_sum | integer | Current regular-season total of turnovers. |
#' | stats_totals_highs_rs_regain_balls_sum | integer | Current regular-season total of steals. |
#' | stats_totals_highs_rs_assists_sum | integer | Current regular-season total of assists. |
#' | stats_totals_highs_rs_rating_lega_sum | integer | Current regular-season total of LBA efficiency rating (`valutazione`). |
#' | stats_totals_highs_rs_rating_oer_sum | double | OER over the regular season (1.04 for 3 games: an average despite `_sum`; inferred). |
#' | stats_totals_highs_rs_avg_points_sum | integer | Current regular-season total of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`). |
#' | stats_totals_highs_rs_quintet_max | integer | Current regular-season single-game high of starts (in the starting five). |
#' | stats_totals_highs_rs_points_max | integer | Current regular-season single-game high of points. |
#' | stats_totals_highs_rs_played_minutes_max | integer | Current regular-season single-game high of minutes played. |
#' | stats_totals_highs_rs_done_fouls_max | integer | Current regular-season single-game high of fouls committed. |
#' | stats_totals_highs_rs_suffered_fouls_max | integer | Current regular-season single-game high of fouls drawn. |
#' | stats_totals_highs_rs_shots_2p_realized_max | integer | Current regular-season single-game high of 2-point field goals made. |
#' | stats_totals_highs_rs_shots_2p_total_max | integer | Current regular-season single-game high of 2-point field goals attempted. |
#' | stats_totals_highs_rs_shots_2p_perc_max | integer | Current regular-season single-game high of 2-point field-goal percentage, 0-100. |
#' | stats_totals_highs_rs_slam_dunk_max | integer | Current regular-season single-game high of dunks. |
#' | stats_totals_highs_rs_shots_3p_realized_max | integer | Current regular-season single-game high of 3-point field goals made. |
#' | stats_totals_highs_rs_shots_3p_total_max | integer | Current regular-season single-game high of 3-point field goals attempted. |
#' | stats_totals_highs_rs_shots_3p_perc_max | integer | Current regular-season single-game high of 3-point field-goal percentage, 0-100. |
#' | stats_totals_highs_rs_free_throws_realized_max | integer | Current regular-season single-game high of free throws made. |
#' | stats_totals_highs_rs_free_throws_total_max | integer | Current regular-season single-game high of free throws attempted. |
#' | stats_totals_highs_rs_free_throws_perc_max | integer | Current regular-season single-game high of free-throw percentage, 0-100. |
#' | stats_totals_highs_rs_offensive_rebound_max | integer | Current regular-season single-game high of offensive rebounds. |
#' | stats_totals_highs_rs_defensive_rebound_max | integer | Current regular-season single-game high of defensive rebounds. |
#' | stats_totals_highs_rs_total_rebounds_max | integer | Current regular-season single-game high of total rebounds. |
#' | stats_totals_highs_rs_ball_stop_given_max | integer | Current regular-season single-game high of blocks. |
#' | stats_totals_highs_rs_ball_stop_received_max | integer | Current regular-season single-game high of own shots blocked. |
#' | stats_totals_highs_rs_lost_balls_max | integer | Current regular-season single-game high of turnovers. |
#' | stats_totals_highs_rs_regain_balls_max | integer | Current regular-season single-game high of steals. |
#' | stats_totals_highs_rs_assists_max | integer | Current regular-season single-game high of assists. |
#' | stats_totals_highs_rs_rating_lega_max | integer | Current regular-season single-game high of LBA efficiency rating (`valutazione`). |
#' | stats_totals_highs_rs_rating_oer_max | double | Current regular-season single-game high of OER (points / (FGA + turnovers + FTA / 2)). |
#' | stats_totals_highs_rs_avg_points_max | integer | Current regular-season single-game high of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`). |
#' | stats_totals_highs_rs_adp_max | integer | Current regular-season single-game high of plus-minus (as `match_adp`). |
#' | stats_totals_highs_rs_id | integer | Always null (not a key). |
#' | stats_avg_rs_player_id | integer | Player id (global, one per career). |
#' | stats_avg_rs_championship_serie_code | character | Series code, `A1` = Serie A. |
#' | stats_avg_rs_quintet_avg | double | Current regular-season per-game average of starts (in the starting five), number sent as a string. |
#' | stats_avg_rs_points_avg | double | Current regular-season per-game average of points, number sent as a string. |
#' | stats_avg_rs_played_minutes_avg | double | Current regular-season per-game average of minutes played, number sent as a string. |
#' | stats_avg_rs_played_matches_avg | double | Always `1.0` (games divided by games), number sent as a string. |
#' | stats_avg_rs_total_matches_avg | double | Always `1.0`, number sent as a string. |
#' | stats_avg_rs_done_fouls_avg | double | Current regular-season per-game average of fouls committed, number sent as a string. |
#' | stats_avg_rs_suffered_fouls_avg | double | Current regular-season per-game average of fouls drawn, number sent as a string. |
#' | stats_avg_rs_shots_2p_realized_avg | double | Current regular-season per-game average of 2-point field goals made, number sent as a string. |
#' | stats_avg_rs_shots_2p_total_avg | double | Current regular-season per-game average of 2-point field goals attempted, number sent as a string. |
#' | stats_avg_rs_slam_dunk_avg | double | Current regular-season per-game average of dunks, number sent as a string. |
#' | stats_avg_rs_shots_3p_realized_avg | double | Current regular-season per-game average of 3-point field goals made, number sent as a string. |
#' | stats_avg_rs_shots_3p_total_avg | double | Current regular-season per-game average of 3-point field goals attempted, number sent as a string. |
#' | stats_avg_rs_free_throws_realized_avg | double | Current regular-season per-game average of free throws made, number sent as a string. |
#' | stats_avg_rs_free_throws_total_avg | double | Current regular-season per-game average of free throws attempted, number sent as a string. |
#' | stats_avg_rs_offensive_rebound_avg | double | Current regular-season per-game average of offensive rebounds, number sent as a string. |
#' | stats_avg_rs_defensive_rebound_avg | double | Current regular-season per-game average of defensive rebounds, number sent as a string. |
#' | stats_avg_rs_ball_stop_given_avg | double | Current regular-season per-game average of blocks, number sent as a string. |
#' | stats_avg_rs_ball_stop_received_avg | double | Current regular-season per-game average of own shots blocked, number sent as a string. |
#' | stats_avg_rs_lost_balls_avg | double | Current regular-season per-game average of turnovers, number sent as a string. |
#' | stats_avg_rs_regain_balls_avg | double | Current regular-season per-game average of steals, number sent as a string. |
#' | stats_avg_rs_assists_avg | double | Current regular-season per-game average of assists, number sent as a string. |
#' | stats_avg_rs_rating_lega_avg | double | Current regular-season per-game average of LBA efficiency rating (`valutazione`), number sent as a string. |
#' | stats_avg_rs_rating_oer_avg | double | Per-game average OER (a number, unlike the other `_avg` values). |
#' | stats_avg_rs_avg_points_avg | double | Current regular-season per-game average of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`), number sent as a string. |
#' | stats_avg_rs_id | integer | Always null (not a key). |
#' @eval .intl_details(.lba_championships_details, "lba_player(player_id = 969)")
#' @export
#' @family LBA Functions
lba_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("player", list(id = player_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Player Stats**
#' @description
#' A player's career by championship: per-game averages, single-game highs and totals.
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-player-stats` (`id=<player_id>`)
#' @param player_id (required) Player id (player_id in lba_players or a box score), e.g. 969. Global: one id for a
#'   whole career.
#' @return
#' A `hoopR_data` tibble: A player's career by championship: per-game averages, single-game highs and totals. The
#'   columns are always these, in this order (sdv-py `lba_player_stats`); a column the site adds later is appended
#'   after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player id (global: one id for a whole career); the request's player. |
#' | stat_type | character | Statistic of the row: avg (per game), max (single-game high) or sum (total). |
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | championship_year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | championship_position | integer | Display order of the competition within the season (1 = Regular Season; inferred). |
#' | championship_name | character | Competition name (`Regular Season`, `Play Off`, `Coppa Italia`, ...). |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | quintet | integer | Per-game average of starts (in the starting five) in that season, competition and team. |
#' | points | double | Per-game average of points in that season, competition and team. |
#' | played_minutes | double | Per-game average of minutes played in that season, competition and team. |
#' | played_matches | integer | Games played in that season, competition and team: a count, the same in the avg, max and sum rows. |
#' | total_matches | integer | Team games while the player was listed (a player with 3 of 21 shows 21; inferred) in that season, competition and team: a count, the same in the avg, max and sum rows. |
#' | done_fouls | integer | Per-game average of fouls committed in that season, competition and team. |
#' | suffered_fouls | integer | Per-game average of fouls drawn in that season, competition and team. |
#' | shots_2p_realized | double | Per-game average of 2-point field goals made in that season, competition and team. |
#' | shots_2p_total | integer | Per-game average of 2-point field goals attempted in that season, competition and team. |
#' | slam_dunk | integer | Per-game average of dunks in that season, competition and team. |
#' | shots_3p_realized | integer | Per-game average of 3-point field goals made in that season, competition and team. |
#' | shots_3p_total | integer | Per-game average of 3-point field goals attempted in that season, competition and team. |
#' | free_throws_realized | integer | Per-game average of free throws made in that season, competition and team. |
#' | free_throws_total | integer | Per-game average of free throws attempted in that season, competition and team. |
#' | offensive_rebound | integer | Per-game average of offensive rebounds in that season, competition and team. |
#' | defensive_rebound | integer | Per-game average of defensive rebounds in that season, competition and team. |
#' | total_rebound | integer | Per-game average of total rebounds in that season, competition and team. |
#' | ball_stop_given | integer | Per-game average of blocks in that season, competition and team. |
#' | ball_stop_received | integer | Per-game average of own shots blocked in that season, competition and team. |
#' | lost_balls | integer | Per-game average of turnovers in that season, competition and team. |
#' | regain_balls | integer | Per-game average of steals in that season, competition and team. |
#' | assists | integer | Per-game average of assists in that season, competition and team. |
#' | rating_lega | integer | Per-game average of LBA efficiency rating (`valutazione`) in that season, competition and team. |
#' | rating_oer | double | Per-game average of OER (points / (FGA + turnovers + FTA / 2)) in that season, competition and team. |
#' | avg_points | double | Per-game average of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`) in that season, competition and team. |
#' | aplus_dp | integer | Per-game average of `aplus_dp`, an unverified metric (not plus-minus or assists: Macura 2026-27 has 9 against plus-minus 8 and 3 assists) in that season, competition and team. |
#' @eval .intl_details(.lba_championships_details, "lba_player_stats(player_id = 969)")
#' @export
#' @family LBA Functions
lba_player_stats <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("player_stats", list(id = player_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Game Log**
#' @description
#' A player's game log for one season, one row per game.
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-player-matches` (`cs_id=1&id=<player_id>&s=<season>`)
#' @param player_id (required) Player id (player_id in lba_players or a box score), e.g. 969. Global: one id for a
#'   whole career.
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @return
#' A `hoopR_data` tibble: A player's game log for one season, one row per game. The columns are always these, in
#'   this order (sdv-py `lba_game_log`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | stat_line_id | integer | Id of the player's stat line for the game (one per player and game). |
#' | championship_id | integer | Championship id of the game. |
#' | championships_match_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
#' | player_id | integer | Player id (global, one per career). |
#' | team_id | integer | Team id (team-season) of the player. |
#' | number | integer | Jersey number the player wore in the game. |
#' | played_minutes | integer | Minutes played, in that game. |
#' | points | integer | Points, in that game. |
#' | suffered_fouls | integer | Fouls drawn, in that game. |
#' | done_fouls | integer | Fouls committed, in that game. |
#' | shots_2p_realized | integer | 2-point field goals made, in that game. |
#' | shots_2p_total | integer | 2-point field goals attempted, in that game. |
#' | shots_3p_realized | integer | 3-point field goals made, in that game. |
#' | shots_3p_total | integer | 3-point field goals attempted, in that game. |
#' | free_throws_realized | integer | Free throws made, in that game. |
#' | free_throws_total | integer | Free throws attempted, in that game. |
#' | restricted_area_p1 | character | Null in every sample (meaning unverified). |
#' | restricted_area_p2 | character | Null in every sample (meaning unverified). |
#' | restricted_area_p3 | character | Null in every sample (meaning unverified). |
#' | slam_dunk | integer | Dunks, in that game. |
#' | offensive_rebound | integer | Offensive rebounds, in that game. |
#' | defensive_rebound | integer | Defensive rebounds, in that game. |
#' | ball_stop_given | integer | Blocks, in that game. |
#' | ball_stop_received | integer | Own shots blocked, in that game. |
#' | lost_balls | integer | Turnovers, in that game. |
#' | regain_balls | integer | Steals, in that game. |
#' | assists | integer | Assists, in that game. |
#' | technical_fouls | character | Technical fouls (null in old seasons). |
#' | minute5_fouls | integer | Minute of the fifth foul (0 = did not foul out; inferred, unverified). |
#' | time5_fouls | integer | Game time of the fifth foul (0 = did not foul out; inferred, unverified). |
#' | rating_lega | integer | LBA efficiency rating (`valutazione`), in that game. |
#' | quintet | integer | Starts (in the starting five), in that game. |
#' | rating_oer | double | OER (points / (FGA + turnovers + FTA / 2)), in that game. |
#' | avg_points | integer | The player's plus-minus in the game (the site's name is misleading). |
#' | wp_id | integer | Null in every sample (meaning unverified). |
#' | deleted_at | character | Null in every sample (meaning unverified). |
#' | created_at | character | Timestamp, ISO-8601 with the Italian offset. |
#' | updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
#' | player_role_id | integer | Position id (position key space: the id behind `player_role`; joins the `r_id` filter). |
#' | order | integer | Row order in the box score. |
#' | captain | logical | Team captain in that game. |
#' | shots_2p_perc | integer | 2-point field-goal percentage, 0-100, in that game. |
#' | shots_3p_perc | integer | 3-point field-goal percentage, 0-100, in that game. |
#' | free_throws_perc | integer | Free-throw percentage, 0-100, in that game. |
#' | total_rebound | integer | Total rebounds, in that game. |
#' | ext_code | character | `<websocket_match_id>\|<team code>\|<player code>` (`1674778\|TVU\|CAP-ALE-95`). |
#' | fouls_first_category | integer | Category-1 technical fouls (null in old seasons; reading inferred). |
#' | fouls_flagrant | integer | Unsportsmanlike / flagrant fouls. |
#' | championship_day_name | character | Round code, number sent as a string. |
#' | home_score | integer | Home points after the action, parsed from the score text (2021-22 on; else null). |
#' | visitor_score | integer | Visitor points after the action, parsed from the score text (2021-22 on; else null). |
#' | match_date | character | Tip-off in UTC, ISO-8601 `Z` (local time in `match_hh` / `match_mm`). |
#' | match_hh | integer | Tip-off hour, local time. |
#' | match_mm | integer | Tip-off minute, local time. |
#' | championship_match_id | integer | Game id (repeated). |
#' | player_team_id | integer | Team id (team-season) of the player (repeated). |
#' | player_team_name | character | Short name of the player's team in the game (without the season sponsor). |
#' | player_team_code | character | `<season>\|<team code>` (`1995\|BOF`). |
#' | visitor_team_id | integer | Visitor team-season id of the game (the play-by-play vt_id). |
#' | visitor_team_name | character | Away team short name. |
#' | visitor_team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | home_team_id | integer | Home team-season id of the game (the play-by-play ht_id). |
#' | home_team_name | character | Home team short name. |
#' | home_team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | phase_description | character | Phase code: `And` (Andata, 1st half of the season) / `Rit` (Ritorno). |
#' | match_adp | integer | The player's plus-minus in the game (the site's name is misleading). |
#' | home_match_result | character | `w` / `l` for the home team when the player was on it, else null. |
#' | visitor_match_result | character | `w` / `l` for the away team when the player was on it, else null. |
#' @eval .intl_details(.lba_championships_details, "lba_game_log(player_id = 969, season = 2027)")
#' @export
#' @family LBA Functions
lba_game_log <- function(player_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("game_log", list(id = player_id, s = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Players Leaderboard**
#' @description
#' Season player leaderboard for one category (per-game average).
#'
#' Endpoint: `GET https://www.legabasket.it/api/statistics/get-players-statistics` (`cs_id=1&s=<season>&cat=<category>`)
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @param category Category: points, rating_lega, total_rebound, assists, shots_3p_perc, ... (the site's
#'   filters.categories).
#' @return
#' A `hoopR_data` tibble: Season player leaderboard for one category (per-game average). The columns are always
#'   these, in this order (sdv-py `lba_players_leaderboard`); a column the site adds later is appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | category | character | Category of this row (the `cat` param, e.g. `points`). |
#' | player_id | integer | Player id (global, one per career). |
#' | name | character | Given name (players) / team name (teams). |
#' | surname | character | Player's family name. |
#' | team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
#' | tv_name | character | Short team name for TV graphics. |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | category_filter_total | integer | Season total in the category. |
#' | attempts | integer | Shots attempted in the zone, parsed from num. |
#' | presences | integer | Games the player appeared in, counted for the leaderboard. |
#' | minutes | double | Minutes per game (players: decimal string `28.67`) / total minutes (teams: integer). |
#' | score_40_min | double | Value per 40 minutes. |
#' | score | double | Value in the category under the `ob` order (default `avg` = per game); players send a decimal string, teams a number. |
#' | team_id | integer | Team id (team-season). |
#' | player_photo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' @eval .intl_details(.lba_championships_details, 'lba_players_leaderboard(season = 2027, category = "points")')
#' @export
#' @family LBA Functions
lba_players_leaderboard <- function(season = NULL, category = "points") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("players_leaderboard", list(s = season, cat = category), call = rlang::current_env())
}

#' @title
#' **Get LBA Teams Leaderboard**
#' @description
#' Season team leaderboards, offensive or defensive, one row per team and category.
#'
#' Endpoint: `GET https://www.legabasket.it/api/statistics/get-teams-statistics-by-type` (`cs_id=1&type=<board>&s=<season>`)
#' @param board (required) Board: teams_offensive or teams_defensive. One of `"teams_offensive"`,
#'   `"teams_defensive"`.
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @return
#' A `hoopR_data` tibble: Season team leaderboards, offensive or defensive, one row per team and category. The
#'   columns are always these, in this order (sdv-py `lba_teams_leaderboard`); a column the site adds later is
#'   appended after them:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
#' | category | character | Category of this row (the `cat` param, e.g. `points`). |
#' | name | character | Given name (players) / team name (teams). |
#' | sponsor_name | character | Sponsor name (empty or null in the samples). |
#' | short_name | character | Short name of the team, e.g. BC Roma. |
#' | tv_name | character | Short team name for TV graphics. |
#' | year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
#' | logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
#' | attempts | integer | Shots attempted in the zone, parsed from num. |
#' | total_played_matches | integer | Games the team has played, counted for the leaderboard. |
#' | total_points | integer | Points scored (offensive) or allowed (defensive) in the season. |
#' | minutes | integer | Minutes per game (players: decimal string `28.67`) / total minutes (teams: integer). |
#' | score_40_min | double | Value per 40 minutes. |
#' | score | double | Value in the category under the `ob` order (default `avg` = per game); players send a decimal string, teams a number. |
#' | team_id | integer | Team id (team-season). |
#' @eval .intl_details(.lba_championships_details, 'lba_teams_leaderboard(board = "teams_offensive", season = 2027)')
#' @export
#' @family LBA Functions
lba_teams_leaderboard <- function(board, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_choice(board, c("teams_offensive", "teams_defensive"), "board", call = rlang::current_env())
  .lba_call("teams_leaderboard", list(type = board, s = season), call = rlang::current_env())
}
