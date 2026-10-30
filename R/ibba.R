# ibba.R -- the exported IBBA ASMX wrappers (basket.co.il web service). Generated from
# the sdv-py endpoint YAML and manual_column_descriptions.yaml, then kept by hand.

# The @details of every ibba topic that shares the ibba_configuration() notes (roxygen @eval .intl_details()).
.ibba_configuration_details <- c(
  "The IBBA wrappers read the Israel Basketball Association's ASP.NET web service at",
  "`basket.co.il/ws/ws.asmx` (the ops its own site calls): seasons, boards, teams, rosters,",
  "coaches, schedules and results, box scores from 2004-05, season stats and leaders of the",
  "Winner League (Israeli Premier League). They mirror sdv-py's",
  "`sportsdataverse.basketball.ibba` wrappers of the same names: same arguments, the same",
  "snake_case columns and types, one row per sdv-py row. The live box score, play-by-play and",
  "shot coordinates of a game are in the [ibba_segev_game_info()] family (Segev Stats).",
  "",
  "**Unofficial and unsupported.** The web service is keyless, unofficial and reverse",
  "engineered. Requests are spaced at least one second apart per host (429 / 502 / 503 / 504",
  "are retried three times; an HTTP 500 is the host's deterministic error page, a stack",
  "trace, and is not retried); keep crawls slow and incremental. Contact details (e-mail,",
  "phone, fax) and coaches' dates of birth are dropped.",
  "",
  "**Seasons and ids.** `season` is the END year and the host's own `cYear` (2026 = 2025-26):",
  "it is sent unchanged. `team_id` and `player_id` are per-SEASON registrations (Maccabi Tel",
  "Aviv = team 1109 in 2025-26, 2111 in 2026-27); the host has no cross-season person id (the",
  "stable player key is the Segev player id of the `ibba_segev_*()` family). `team_uid` is the",
  'stable club id (Maccabi = 10). A `0` means "all" where an argument says so; every parameter',
  "of an op is always sent.",
  "",
  "**Coverage.** League box scores from 2004-05 (`season = 2005`). `external_id` and",
  "`segev_game_id` exist only from 2025-26 (earlier games carry no Segev id, so",
  "`segev_game_id` is `NA`). The women's league and Liga Leumit are NOT on this host. Every",
  "value on the wire is a string and Hebrew text is HTML-entity encoded: ids, counts and dates",
  "are cast and text is unescaped.",
  "",
  "**Errors** are classed conditions, never a warning plus an empty frame: `hoopR_no_data`",
  "(HTTP 404, an empty body, which is what an unknown id answers, or an empty row list),",
  "`hoopR_bad_request` (HTTP 400 / 422, or an argument that is not a non-negative integer,",
  "a boolean or a non-empty string as the op needs) and `hoopR_asset_fetch` (any other",
  "failure: another status, a transport error, a body that is not JSON, an error or changed",
  "envelope, a row for another season, team, player, board or game, or a box score of a game",
  "that is not final). All inherit `hoopR_error`."
)

#' @title
#' **IBBA Configuration**
#' @description
#' **Season settings: the season label, round counters and the standings cut line.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Configuration`
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details, full = TRUE, "ibba_configuration(season = 2026)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | season_label | character | Season label as 'YYYY-YY' ('2025-26', '2004-05'). |
#' | red_line | integer | Standings position the site draws its cut line under (12 in 2025-26, 10 in 2004-05); meaning inferred. |
#' | active_board_id | integer | Board id the site treats as the active competition (17 = final series in 2025-26, 5 = league in 2004-05); meaning inferred. |
#' | next_round | integer | Next round (game number) to be played; meaning inferred. |
#' | total_rounds | integer | Rounds in the regular season (32 in 2025-26, 22 in 2004-05); meaning inferred. |
#' @family IBBA Functions
#' @export
ibba_configuration <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Configuration", list(cYear = season), call = rlang::current_env())
  .ibba_parse("configuration", rows)
}

#' @title
#' **IBBA Boards**
#' @description
#' **Competitions (boards) of a season: league, cup, playoff rounds, play-in, Supercup.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Boards`
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
#' | board_title_he | character | Sponsor-branded competition name in Hebrew (the Hebrew for 'Winner League'). |
#' | category_he | character | Competition format in Hebrew: the Hebrew words for table, knockout or series. |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_boards(season = 2026))
#' }
ibba_boards <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Boards", list(cYear = season), call = rlang::current_env())
  .ibba_parse("boards", rows)
}

#' @title
#' **IBBA External Boards**
#' @description
#' **External competitions a club played in during a season (European cups, national team,
#'   pre-season).**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/BoardsEx`
#' @param team_uid (*integer* required): IBBA club id, stable across seasons (Maccabi Tel Aviv = 10;
#'   `team_uid` in ibba_teams). Use 0 for all clubs only where the route says so.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details, "ibba_boards_ex(season = 2026, team_uid = 10)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
#' | board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
#' @family IBBA Functions
#' @export
ibba_boards_ex <- function(team_uid, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("BoardsEx", list(team_uid = team_uid, cYear = season), call = rlang::current_env())
  .ibba_parse("boards_ex", rows)
}

#' @title
#' **IBBA Teams**
#' @description
#' **Teams of a board and season with their standings line and club profile fields.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Teams`
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @param board_id (*integer*, default `5`): Competition (board) id: 5 league, 10 cup, 16 / 26 / 17
#'   playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup. Default 5.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_uid | integer | IBBA CLUB id, stable across seasons (Maccabi Tel Aviv = 10): the team_uid parameter of the roster routes. Not the per-season team_id. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_name_he | character | Team name in Hebrew, HTML-unescaped. |
#' | team_short_name_he | character | Short team name in Hebrew, HTML-unescaped. |
#' | team_name | character | Team name in English as registered for the season. |
#' | team_short_name | character | Short team name in English. |
#' | board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
#' | place | integer | Rank in the standings of the board (1 = first). |
#' | games | integer | Games played (in the standings or in the season stats). |
#' | wins | integer | Games won in the season so far (standings line). |
#' | losses | integer | Games lost in the season so far (standings line). |
#' | points_for | integer | Points scored over the games played. |
#' | points_against | integer | Points conceded over the games played. |
#' | table_points | integer | Standings points (2 per win, 1 per loss in the league table). |
#' | logo_url | character | Absolute URL of the team logo. |
#' | photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
#' | address_he | character | Club address in Hebrew, HTML-unescaped. |
#' | sponsors_he | character | Club sponsors in Hebrew, comma-separated. |
#' | facebook_url | character | Club Facebook page URL; null when none. |
#' | twitter_url | character | Club Twitter / X profile URL; null when none. |
#' | instagram_url | character | Club Instagram profile URL; null when none. |
#' | youtube_url | character | Club YouTube channel URL; null when none. |
#' | ticket_url | character | Ticket-sales URL; null when none. |
#' | subscribe_url | character | Season-ticket subscription URL; null when none. |
#' | coaches_he | character | Coaching staff as one Hebrew text ('head coach: ..., assistant coach: ...', in Hebrew). |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_teams(season = 2026))
#' }
ibba_teams <- function(season, board_id = 5) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Teams", list(cYear = season, board_id = board_id), call = rlang::current_env())
  .ibba_parse("teams", rows)
}

#' @title
#' **IBBA Team**
#' @description
#' **One team-season: standings line and club profile (colours, sponsors, social links, arena id).**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/TeamById`
#' @param team_id (*integer* required): Team-season id (new every season; Maccabi = 1109 in
#'   2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` / `away_team_id` or
#'   ibba_box_score.
#' @param team_uid (*integer* required): IBBA club id, stable across seasons (Maccabi Tel Aviv = 10;
#'   `team_uid` in ibba_teams). Use 0 for all clubs only where the route says so.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details, "ibba_team(season = 2026, team_id = 1109, team_uid = 10)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_uid | integer | IBBA CLUB id, stable across seasons (Maccabi Tel Aviv = 10): the team_uid parameter of the roster routes. Not the per-season team_id. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_name_he | character | Team name in Hebrew, HTML-unescaped. |
#' | team_short_name_he | character | Short team name in Hebrew, HTML-unescaped. |
#' | team_name | character | Team name in English as registered for the season. |
#' | team_short_name | character | Short team name in English. |
#' | wins | integer | Games won in the season so far (standings line). |
#' | losses | integer | Games lost in the season so far (standings line). |
#' | points_for | integer | Points scored over the games played. |
#' | points_against | integer | Points conceded over the games played. |
#' | table_points | integer | Standings points (2 per win, 1 per loss in the league table). |
#' | place | integer | Rank in the standings of the board (1 = first). |
#' | website_url | character | Club website URL. |
#' | photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
#' | icon_path | character | Site-relative path of the small team icon. |
#' | logo_url | character | Absolute URL of the team logo. |
#' | icon3_path | character | Site-relative path of the third team icon variant. |
#' | arena_id | integer | Home arena id in the IBBA site's own arena table (no arena route is modelled). |
#' | address_he | character | Club address in Hebrew, HTML-unescaped. |
#' | address | character | Club address in English, HTML-unescaped. |
#' | colors_he | character | Team colours in Hebrew. |
#' | colors | character | Team colours in English. |
#' | sponsors_he | character | Club sponsors in Hebrew, comma-separated. |
#' | sponsors | character | Club sponsors in English, comma-separated. |
#' | about_he | character | Club profile in Hebrew as HTML markup (honours, history); not stripped. |
#' | about | character | Club profile in English as HTML markup; null when the club has none. |
#' | facebook_url | character | Club Facebook page URL; null when none. |
#' | twitter_url | character | Club Twitter / X profile URL; null when none. |
#' | instagram_url | character | Club Instagram profile URL; null when none. |
#' | youtube_url | character | Club YouTube channel URL; null when none. |
#' | subscribe_url | character | Season-ticket subscription URL; null when none. |
#' | diary_url | character | Calendar-subscription (add-to-diary) URL of the club's fixtures. |
#' @family IBBA Functions
#' @export
ibba_team <- function(team_id, team_uid, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("TeamById", list(team_id = team_id, team_uid = team_uid, cYear = season), call = rlang::current_env())
  .ibba_parse("team", rows)
}

#' @title
#' **IBBA Players**
#' @description
#' **The roster of a team-season: jersey, names, position, height and birth date.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Players`
#' @param team_id (*integer* required): Team-season id (new every season; Maccabi = 1109 in
#'   2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` / `away_team_id` or
#'   ibba_box_score.
#' @param team_uid (*integer* required): IBBA club id, stable across seasons (Maccabi Tel Aviv = 10;
#'   `team_uid` in ibba_teams). Use 0 for all clubs only where the route says so.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
#' | jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '_TEAM' and 'TOTAL' for its two non-player lines. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | player_name_he | character | Player name in Hebrew, HTML-unescaped. |
#' | player_name | character | Player name in English, HTML-unescaped. |
#' | is_replaced | logical | True when the person was replaced during the season (left the roster or staff). |
#' | is_local | logical | True for an Israeli (local) player; the isr_ leader categories count only these. |
#' | photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
#' | height_m | double | Height in metres (1.93). |
#' | position_he | character | Position in Hebrew. |
#' | position | character | Position code: PG, G, G-F, F, F-C or C. |
#' | birth_date | Date | Date of birth (public player bio); null when not published. |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_players(season = 2026, team_id = 1109, team_uid = 10))
#' }
ibba_players <- function(team_id, team_uid, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Players", list(team_id = team_id, team_uid = team_uid, cYear = season), call = rlang::current_env())
  .ibba_parse("players", rows)
}

#' @title
#' **IBBA Player**
#' @description
#' **One player-season row: jersey, team, names and photo.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/PlayerById`
#' @param player_id (*integer* required): Player-season id (new every season; Jaylen Hoard = 21912
#'   in 2025-26): `player_id` in ibba_players.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details, "ibba_player(player_id = 21912, season = 2026)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
#' | jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '_TEAM' and 'TOTAL' for its two non-player lines. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | player_name_he | character | Player name in Hebrew, HTML-unescaped. |
#' | player_name | character | Player name in English, HTML-unescaped. |
#' | is_replaced | logical | True when the person was replaced during the season (left the roster or staff). |
#' | is_local | logical | True for an Israeli (local) player; the isr_ leader categories count only these. |
#' | photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
#' @family IBBA Functions
#' @export
ibba_player <- function(player_id, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("PlayerById", list(player_id = player_id, cYear = season), call = rlang::current_env())
  .ibba_parse("player", rows)
}

#' @title
#' **IBBA Coaches**
#' @description
#' **The coaching staff of a team-season (birth dates are dropped).**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Coaches`
#' @param team_id (*integer* required): Team-season id (new every season; Maccabi = 1109 in
#'   2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` / `away_team_id` or
#'   ibba_box_score.
#' @param team_uid (*integer* required): IBBA club id, stable across seasons (Maccabi Tel Aviv = 10;
#'   `team_uid` in ibba_teams). Use 0 for all clubs only where the route says so.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details, "ibba_coaches(season = 2026, team_id = 1109, team_uid = 10)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | coach_id | integer | Coach id in the IBBA coach table (per team-season registration as far as the samples show; stability across seasons is unverified). |
#' | coach_type | integer | Staff role code: 1 = head coach, 2 = assistant coach (inferred from the Maccabi Tel Aviv sample). |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | coach_name_he | character | Coach name in Hebrew, HTML-unescaped. |
#' | coach_name | character | Coach name in English. |
#' | is_replaced | logical | True when the person was replaced during the season (left the roster or staff). |
#' | photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
#' | sort_order | integer | Display order of the coach within the staff list (mOrder). |
#' @family IBBA Functions
#' @export
ibba_coaches <- function(team_id, team_uid, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Coaches", list(team_id = team_id, team_uid = team_uid, cYear = season), call = rlang::current_env())
  .ibba_parse("coaches", rows)
}

#' @title
#' **IBBA Box Score**
#' @description
#' **Box score of a finished game: player lines, a team-credited line per side and the TOTAL line
#'   per side.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Boxscore`
#' @param game_id (*integer* required): IBBA game id (e.g. 26392): `game_id` in ibba_games.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
#' | jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '_TEAM' and 'TOTAL' for its two non-player lines. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig_ space, e.g. 8888 for a pre-season game). |
#' | board_id | integer | Board id of the game (5 = league). |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | round | integer | Round (game number) of the game within its board. |
#' | starter | logical | True when the player started the game. |
#' | minutes | integer | Minutes played, whole minutes; a TOTAL line holds the team's player-minutes (200 plus 25 per overtime). |
#' | pts | integer | Points scored by the player or team (free throws included). |
#' | fg2m | integer | Two-point field goals made. |
#' | fg2a | integer | Two-point field goals attempted (verified equal to Segev made + missed). |
#' | fg2_pct | double | Two-point field-goal percentage, 0-100. |
#' | fg3m | integer | Three-point field goals made. |
#' | fg3a | integer | Three-point field goals attempted. |
#' | fg3_pct | double | Three-point field-goal percentage, 0-100. |
#' | ftm | integer | Free throws made. |
#' | fta | integer | Free throws attempted. |
#' | ft_pct | double | Free-throw percentage, 0-100. |
#' | dreb | integer | Defensive rebounds. |
#' | oreb | integer | Offensive rebounds. |
#' | reb | integer | Total rebounds. |
#' | fouls_drawn | integer | Fouls DRAWN: fouls opponents committed against the player or team (the wire's fouls_against; verified equal to Segev f_drawn). |
#' | fouls | integer | Fouls COMMITTED by the player or team (the wire's fouls_for; verified equal to Segev f). |
#' | steals | integer | Steals made by the player or team. |
#' | turnovers | integer | Turnovers (the wire's misspelt tournovers). |
#' | assists | integer | Assists credited to the player or team. |
#' | blocks | integer | Shots the player or team blocked. |
#' | blocks_against | integer | Own shots that were blocked. |
#' | val | integer | Efficiency rating (valuation; verified equal to Segev rate); -1 on 2004-05 team-credited lines. |
#' | plus_minus | integer | Plus-minus; 0 on every line of the 2004-05 sample (not recorded then, inferred). |
#' | dunks | integer | Dunks made by the player or team. |
#' | row_type | character | Kind of box line: player, team (actions credited to the team: team rebounds and turnovers) or total (the team's TOTAL line, equal to players plus team lines). |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_box_score(game_id = 26392, season = 2026))
#' }
ibba_box_score <- function(game_id, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Boxscore", list(game_id = game_id, cYear = season), call = rlang::current_env())
  .ibba_parse("box_score", rows)
}

#' @title
#' **IBBA Player Stats**
#' @description
#' **A player-season's totals, or per-game averages with is_averages=True.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/PlayerStatsById`
#' @param player_id (*integer* required): Player-season id (new every season; Jaylen Hoard = 21912
#'   in 2025-26): `player_id` in ibba_players.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @param is_averages (*logical*, default `FALSE`): True returns per-game averages (decimals); False
#'   (default) the season totals.
#' @param is_playoff (*logical*, default `FALSE`): True returns the playoff games only; False
#'   (default) the regular season.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
#' | jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '_TEAM' and 'TOTAL' for its two non-player lines. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | games | integer | Games played (in the standings or in the season stats). |
#' | minutes | double | Minutes played, whole minutes; a TOTAL line holds the team's player-minutes (200 plus 25 per overtime). Season total, or the per-game average when is_averages is true. |
#' | pts | double | Points scored by the player or team (free throws included). Season total, or the per-game average when is_averages is true. |
#' | fg2m | double | Two-point field goals made. Season total, or the per-game average when is_averages is true. |
#' | fg2a | double | Two-point field goals attempted (verified equal to Segev made + missed). Season total, or the per-game average when is_averages is true. |
#' | fg2_pct | double | Two-point field-goal percentage, 0-100. Season total, or the per-game average when is_averages is true. |
#' | fg3m | double | Three-point field goals made. Season total, or the per-game average when is_averages is true. |
#' | fg3a | double | Three-point field goals attempted. Season total, or the per-game average when is_averages is true. |
#' | fg3_pct | double | Three-point field-goal percentage, 0-100. Season total, or the per-game average when is_averages is true. |
#' | ftm | double | Free throws made. Season total, or the per-game average when is_averages is true. |
#' | fta | double | Free throws attempted. Season total, or the per-game average when is_averages is true. |
#' | ft_pct | double | Free-throw percentage, 0-100. Season total, or the per-game average when is_averages is true. |
#' | dreb | double | Defensive rebounds. Season total, or the per-game average when is_averages is true. |
#' | oreb | double | Offensive rebounds. Season total, or the per-game average when is_averages is true. |
#' | reb | double | Total rebounds. Season total, or the per-game average when is_averages is true. |
#' | fouls_drawn | double | Fouls DRAWN: fouls opponents committed against the player or team (the wire's fouls_against; verified equal to Segev f_drawn). Season total, or the per-game average when is_averages is true. |
#' | fouls | double | Fouls COMMITTED by the player or team (the wire's fouls_for; verified equal to Segev f). Season total, or the per-game average when is_averages is true. |
#' | steals | double | Steals made by the player or team. Season total, or the per-game average when is_averages is true. |
#' | turnovers | double | Turnovers (the wire's misspelt tournovers). Season total, or the per-game average when is_averages is true. |
#' | assists | double | Assists credited to the player or team. Season total, or the per-game average when is_averages is true. |
#' | blocks | double | Shots the player or team blocked. Season total, or the per-game average when is_averages is true. |
#' | blocks_against | double | Own shots that were blocked. Season total, or the per-game average when is_averages is true. |
#' | val | double | Efficiency rating (valuation; verified equal to Segev rate); -1 on 2004-05 team-credited lines. Season total, or the per-game average when is_averages is true. |
#' | plus_minus | double | Plus-minus; 0 on every line of the 2004-05 sample (not recorded then, inferred). Season total, or the per-game average when is_averages is true. |
#' | dunks | double | Dunks made by the player or team. Season total, or the per-game average when is_averages is true. |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_player_stats(player_id = 21912, season = 2026))
#' }
ibba_player_stats <- function(player_id, season, is_averages = FALSE, is_playoff = FALSE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("PlayerStatsById", list(player_id = player_id, cYear = season, isAverages = is_averages, isPlayOff = is_playoff), call = rlang::current_env())
  .ibba_parse("player_stats", rows)
}

#' @title
#' **IBBA Stats Types**
#' @description
#' **The stat categories ibba_leaders accepts (the stat_type codes) with their Hebrew names.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/StatsTypes`
#' @eval .intl_details(.ibba_configuration_details, "ibba_stats_types()")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | stat_type | character | Stat category code to pass to ibba_leaders as stat_type (bracketed codes such as '\[OR\]' are literal). |
#' | stat_name_he | character | Stat category name in Hebrew. |
#' @family IBBA Functions
#' @export
ibba_stats_types <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("StatsTypes", list(), call = rlang::current_env())
  .ibba_parse("stats_types", rows)
}

#' @title
#' **IBBA Leaders**
#' @description
#' **The top five players of a season in one stat category, for all teams or one team.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/LeaderByType`
#' @param stat_type (*character* required): Stat category code from ibba_stats_types: VAL, pts,
#'   isr_pts, plusminus, dunk, ASS, TR, `[OR]`, DR, isr_TR, ST, `[TO]`, ASSTO, BKF, FF, `[min]`, p2,
#'   p3, p1, p32T, p22T, p12T, PTSMIN, TRMIN, ASSMIN.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @param team_id (*integer*, default `0`): Team-season id to restrict the list to one team; 0
#'   (default) for all teams.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | value | double | The leader's value in the requested category (per-game average, percentage or count). |
#' | games | integer | Games the leader played. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_id | integer | Team-season id of the leader's team. |
#' | jersey | character | The leader's jersey number as a zero-padded string. |
#' | player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
#' | player_name_he | character | Player name in Hebrew, HTML-unescaped. |
#' | photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_leaders(season = 2026, stat_type = pts))
#' }
ibba_leaders <- function(stat_type, season, team_id = 0) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("LeaderByType", list(stat_type = stat_type, cYear = season, team_id = team_id), call = rlang::current_env())
  .ibba_parse("leaders", rows)
}

#' @title
#' **IBBA Team Stats**
#' @description
#' **A team-season's totals, or per-game averages with is_averages=True.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/TeamStatsById`
#' @param team_id (*integer* required): Team-season id (new every season; Maccabi = 1109 in
#'   2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` / `away_team_id` or
#'   ibba_box_score.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @param is_averages (*logical*, default `FALSE`): True returns per-game averages (decimals); False
#'   (default) the season totals.
#' @param is_playoff (*logical*, default `FALSE`): True returns the playoff games only; False
#'   (default) the regular season.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
#' | games | integer | Games played (in the standings or in the season stats). |
#' | minutes | double | Minutes played, whole minutes; a TOTAL line holds the team's player-minutes (200 plus 25 per overtime). Season total, or the per-game average when is_averages is true. |
#' | pts | double | Points scored by the player or team (free throws included). Season total, or the per-game average when is_averages is true. |
#' | fg2m | double | Two-point field goals made. Season total, or the per-game average when is_averages is true. |
#' | fg2a | double | Two-point field goals attempted (verified equal to Segev made + missed). Season total, or the per-game average when is_averages is true. |
#' | fg2_pct | double | Two-point field-goal percentage, 0-100. Season total, or the per-game average when is_averages is true. |
#' | fg3m | double | Three-point field goals made. Season total, or the per-game average when is_averages is true. |
#' | fg3a | double | Three-point field goals attempted. Season total, or the per-game average when is_averages is true. |
#' | fg3_pct | double | Three-point field-goal percentage, 0-100. Season total, or the per-game average when is_averages is true. |
#' | ftm | double | Free throws made. Season total, or the per-game average when is_averages is true. |
#' | fta | double | Free throws attempted. Season total, or the per-game average when is_averages is true. |
#' | ft_pct | double | Free-throw percentage, 0-100. Season total, or the per-game average when is_averages is true. |
#' | dreb | double | Defensive rebounds. Season total, or the per-game average when is_averages is true. |
#' | oreb | double | Offensive rebounds. Season total, or the per-game average when is_averages is true. |
#' | reb | double | Total rebounds. Season total, or the per-game average when is_averages is true. |
#' | fouls_drawn | double | Fouls DRAWN: fouls opponents committed against the player or team (the wire's fouls_against; verified equal to Segev f_drawn). Season total, or the per-game average when is_averages is true. |
#' | fouls | double | Fouls COMMITTED by the player or team (the wire's fouls_for; verified equal to Segev f). Season total, or the per-game average when is_averages is true. |
#' | steals | double | Steals made by the player or team. Season total, or the per-game average when is_averages is true. |
#' | turnovers | double | Turnovers (the wire's misspelt tournovers). Season total, or the per-game average when is_averages is true. |
#' | assists | double | Assists credited to the player or team. Season total, or the per-game average when is_averages is true. |
#' | blocks | double | Shots the player or team blocked. Season total, or the per-game average when is_averages is true. |
#' | blocks_against | double | Own shots that were blocked. Season total, or the per-game average when is_averages is true. |
#' | val | double | Efficiency rating (valuation; verified equal to Segev rate); -1 on 2004-05 team-credited lines. Season total, or the per-game average when is_averages is true. |
#' | plus_minus | double | Plus-minus; 0 on every line of the 2004-05 sample (not recorded then, inferred). Season total, or the per-game average when is_averages is true. |
#' | dunks | double | Dunks made by the player or team. Season total, or the per-game average when is_averages is true. |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_team_stats(season = 2026, team_id = 1109))
#' }
ibba_team_stats <- function(team_id, season, is_averages = FALSE, is_playoff = FALSE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("TeamStatsById", list(team_id = team_id, cYear = season, isAverages = is_averages, isPlayOff = is_playoff), call = rlang::current_env())
  .ibba_parse("team_stats", rows)
}

#' @title
#' **IBBA Games**
#' @description
#' **Games (schedule and results) of a season filtered by board, round, team and game; 0 means
#'   any.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/Games`
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @param board_id (*integer*, default `0`): Competition (board) id: 5 league, 10 cup, 16 / 26 / 17
#'   playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup. 0 (default) for every
#'   board.
#' @param board_round (*integer*, default `0`): Round (game number) within the board; 0 (default)
#'   for every round.
#' @param team_id (*integer*, default `0`): Team-season id; 0 (default) for every team.
#' @param team_uid (*integer*, default `0`): IBBA club id; 0 (default) for every club.
#' @param game_id (*integer*, default `0`): IBBA game id; 0 (default) for every game.
#' @eval .intl_details(.ibba_configuration_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig_ space, e.g. 8888 for a pre-season game). |
#' | game_date | Date | Local Israel date of the game. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | home_team_id | integer | Home team-season id (team1 on the wire; verified home against Segev). On external boards (board_id >= 1001) an external-team id (the ig_team_ space), not a team-season. |
#' | away_team_id | integer | Away team-season id (team2 on the wire). On external boards an external-team id. |
#' | home_team_he | character | Home team name in Hebrew, HTML-unescaped. |
#' | away_team_he | character | Away team name in Hebrew, HTML-unescaped. |
#' | home_team | character | Home team name in English; null for external games, which carry Hebrew names only. |
#' | away_team | character | Away team name in English; null for external games. |
#' | home_logo_url | character | Absolute URL of the home team logo. |
#' | away_logo_url | character | Absolute URL of the away team logo. |
#' | home_score | integer | Home final score; 0 before the game is played. |
#' | away_score | integer | Away final score; 0 before the game is played. |
#' | board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
#' | board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
#' | board_name | character | Competition name in English ('Winner League'); null for external boards. |
#' | round | integer | Round (game number) within the board; null for external games. |
#' | tip_off | character | Tip-off 'HH:MM', local Israel time, as text; null in 2004-05. It can disagree with Segev (game 26646: 20:15 here, 19:30 in Segev). |
#' | venue_he | character | Venue in Hebrew, HTML-unescaped; null in 2004-05. |
#' | venue | character | Venue in English, HTML-unescaped; null in 2004-05. |
#' | referees_he | character | Referees' names in Hebrew, comma-separated; ', , ' when unknown. |
#' | attendance | integer | Attendance; 0 when unknown. |
#' | overtime | logical | True when the game went to overtime. |
#' | overtimes | integer | Number of overtime periods played. |
#' | home_score_by_period | character | Home points per period, pipe-separated ('18\|23\|30\|21'); null for external games. |
#' | away_score_by_period | character | Away points per period, pipe-separated ('29\|26\|27\|22'); null for external games. |
#' | tickets_url | character | Ticketing URL; null when none. |
#' | external_id | character | The wire's ExternalID: the Segev game id (a string) for league games from 2025-26, a news URL for pre-season games, null before 2025-26. |
#' | segev_game_id | integer | external_id read as an integer Segev game id (digits only), else null; joins ibba_segev_* game_id. Derived by the parser. |
#' | is_external | logical | True when board_id >= 1001 (an external competition, whose team ids are not team-seasons). Derived by the parser. |
#' @family IBBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_games(board_id = 5, board_round = 1, season = 2026))
#' }
ibba_games <- function(season, board_id = 0, board_round = 0, team_id = 0, team_uid = 0, game_id = 0) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("Games", list(cYear = season, board_id = board_id, board_round = board_round, team_id = team_id, team_uid = team_uid, game_id = game_id), call = rlang::current_env())
  .ibba_parse("games", rows)
}

#' @title
#' **IBBA External Games**
#' @description
#' **A club's games of a season in external competitions (BoardsEx boards: European cups,
#'   pre-season).**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/GamesEx`
#' @param team_uid (*integer* required): IBBA club id, stable across seasons (Maccabi Tel Aviv = 10;
#'   `team_uid` in ibba_teams). Use 0 for all clubs only where the route says so.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @param board_id (*integer*, default `0`): External board id from ibba_boards_ex (1001 EuroLeague,
#'   1003 Champions League, ...); 0 (default) for all.
#' @eval .intl_details(.ibba_configuration_details, "ibba_games_ex(season = 2026, team_uid = 10)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig_ space, e.g. 8888 for a pre-season game). |
#' | game_date | Date | Local Israel date of the game. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | home_team_id | integer | Home team-season id (team1 on the wire; verified home against Segev). On external boards (board_id >= 1001) an external-team id (the ig_team_ space), not a team-season. |
#' | away_team_id | integer | Away team-season id (team2 on the wire). On external boards an external-team id. |
#' | home_team_he | character | Home team name in Hebrew, HTML-unescaped. |
#' | away_team_he | character | Away team name in Hebrew, HTML-unescaped. |
#' | home_logo_url | character | Absolute URL of the home team logo. |
#' | away_logo_url | character | Absolute URL of the away team logo. |
#' | home_score | integer | Home final score; 0 before the game is played. |
#' | away_score | integer | Away final score; 0 before the game is played. |
#' | board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
#' | board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
#' | round | integer | Round (game number) within the board; null for external games. |
#' | tip_off | character | Tip-off 'HH:MM', local Israel time, as text; null in 2004-05. It can disagree with Segev (game 26646: 20:15 here, 19:30 in Segev). |
#' | venue_he | character | Venue in Hebrew, HTML-unescaped; null in 2004-05. |
#' @family IBBA Functions
#' @export
ibba_games_ex <- function(team_uid, season, board_id = 0) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("GamesEx", list(team_uid = team_uid, cYear = season, board_id = board_id), call = rlang::current_env())
  .ibba_parse("games_ex", rows)
}

#' @title
#' **IBBA Games by Team**
#' @description
#' **Every game of a club in a season, domestic and external, in one frame.**
#'
#' Endpoint: `GET https://basket.co.il/ws/ws.asmx/GamesByTeam`
#' @param team_uid (*integer* required): IBBA club id, stable across seasons (Maccabi Tel Aviv = 10;
#'   `team_uid` in ibba_teams). Use 0 for all clubs only where the route says so.
#' @param season (*integer* required): Season END year (2026 = 2025-26); sent to the host as `cYear`
#'   unchanged.
#' @eval .intl_details(.ibba_configuration_details, "ibba_games_by_team(season = 2026, team_uid = 10)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig_ space, e.g. 8888 for a pre-season game). |
#' | game_date | Date | Local Israel date of the game. |
#' | season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
#' | home_team_id | integer | Home team-season id (team1 on the wire; verified home against Segev). On external boards (board_id >= 1001) an external-team id (the ig_team_ space), not a team-season. |
#' | away_team_id | integer | Away team-season id (team2 on the wire). On external boards an external-team id. |
#' | home_team_he | character | Home team name in Hebrew, HTML-unescaped. |
#' | away_team_he | character | Away team name in Hebrew, HTML-unescaped. |
#' | home_team | character | Home team name in English; null for external games, which carry Hebrew names only. |
#' | away_team | character | Away team name in English; null for external games. |
#' | home_logo_url | character | Absolute URL of the home team logo. |
#' | away_logo_url | character | Absolute URL of the away team logo. |
#' | home_score | integer | Home final score; 0 before the game is played. |
#' | away_score | integer | Away final score; 0 before the game is played. |
#' | board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
#' | board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
#' | board_name | character | Competition name in English ('Winner League'); null for external boards. |
#' | round | integer | Round (game number) within the board; null for external games. |
#' | tip_off | character | Tip-off 'HH:MM', local Israel time, as text; null in 2004-05. It can disagree with Segev (game 26646: 20:15 here, 19:30 in Segev). |
#' | venue_he | character | Venue in Hebrew, HTML-unescaped; null in 2004-05. |
#' | venue | character | Venue in English, HTML-unescaped; null in 2004-05. |
#' | referees_he | character | Referees' names in Hebrew, comma-separated; ', , ' when unknown. |
#' | attendance | integer | Attendance; 0 when unknown. |
#' | overtime | logical | True when the game went to overtime. |
#' | overtimes | integer | Number of overtime periods played. |
#' | home_score_by_period | character | Home points per period, pipe-separated ('18\|23\|30\|21'); null for external games. |
#' | away_score_by_period | character | Away points per period, pipe-separated ('29\|26\|27\|22'); null for external games. |
#' | tickets_url | character | Ticketing URL; null when none. |
#' | external_id | character | The wire's ExternalID: the Segev game id (a string) for league games from 2025-26, a news URL for pre-season games, null before 2025-26. |
#' | segev_game_id | integer | external_id read as an integer Segev game id (digits only), else null; joins ibba_segev_* game_id. Derived by the parser. |
#' | is_external | logical | True when board_id >= 1001 (an external competition, whose team ids are not team-seasons). Derived by the parser. |
#' @family IBBA Functions
#' @export
ibba_games_by_team <- function(team_uid, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rows <- .ibba_get("GamesByTeam", list(team_uid = team_uid, cYear = season), call = rlang::current_env())
  .ibba_parse("games_by_team", rows)
}

#' @title
#' **IBBA to Segev Game Crosswalk**
#' @description
#' **IBBA `game_id` <-> Segev `game_id`, from an [ibba_games()] (or [ibba_games_by_team()])
#' frame you already have: no request is made.**
#'
#' The pairs come from the frame's `segev_game_id` column (the host's own `ExternalID`, read
#' as a Segev game id); nothing is guessed from names. Games before 2025-26 and external-team
#' news links carry no Segev id and are dropped. The id types are checked (no float or string
#' id casts) and the mapping must be one-to-one both ways.
#' @param df A data frame from [ibba_games()] or [ibba_games_by_team()].
#' @return A `hoopR_data` tibble, one row per game:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | IBBA game id (key space: basket.co.il games): the `game_id` of [ibba_games()] and [ibba_box_score()]. |
#' | segev_game_id | integer | The Segev game id of the same game: the `game_id` every `ibba_segev_*()` wrapper takes. |
#' @details
#' Raises `hoopR_bad_request` when `df` is not a data frame, lacks a column, has an id
#' column of the wrong type, or maps one id to two.
#'
#' ```r
#'  ibba_segev_game_crosswalk(ibba_games(season = 2026, board_id = 5, board_round = 1))
#' ```
#' @family IBBA Functions
#' @export
ibba_segev_game_crosswalk <- function(df) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  label <- "ibba_segev_game_crosswalk"
  cols <- c("game_id", "segev_game_id")
  if (!is.data.frame(df)) {
    cls <- class(df)[1]
    .abort_bad_request("{label}: expected a data frame, got {cls}.")
  }
  if (nrow(df) == 0L) return(.ibba_out(as.list(.empty_tibble(c(game_id = "integer", segev_game_id = "integer"))),
                                       "game crosswalk"))
  missing <- setdiff(cols, names(df))
  if (length(missing)) .abort_bad_request("{label}: the frame has no column {.val {missing}}.")
  for (col in cols) {
    if (!is.integer(df[[col]])) {
      got <- class(df[[col]])[1]
      .abort_bad_request("{label}: {col} is {got}, expected integer (no float or string id casts).")
    }
  }
  out <- data.frame(game_id = df$game_id, segev_game_id = df$segev_game_id)
  out <- out[!is.na(out$game_id) & !is.na(out$segev_game_id), , drop = FALSE]
  out <- out[!duplicated(out), , drop = FALSE]
  for (k in list(cols, rev(cols))) {
    n <- tapply(out[[k[2]]], out[[k[1]]], function(v) length(unique(v)))
    dup <- names(n)[n > 1]
    if (length(dup)) {
      a <- k[1]
      b <- k[2]
      .abort_bad_request("{label}: {a} maps to more than one {b}: {.val {utils::head(dup, 3)}}.")
    }
  }
  .ibba_out(as.list(out), "game crosswalk")
}
