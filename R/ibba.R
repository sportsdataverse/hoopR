# ibba.R -- the exported IBBA ASMX wrappers (basket.co.il web service). Generated from
# the sportsdataverse-py endpoint YAML and manual_column_descriptions.yaml, then kept by hand.

# The @details of every ibba topic that shares the ibba_configuration() notes (roxygen @eval .intl_details()).
.ibba_configuration_details <- c(
  "The IBBA wrappers read the Israel Basketball Association's ASP.NET web service at",
  "`basket.co.il/ws/ws.asmx` (the ops its own site calls): seasons, boards, teams, rosters,",
  "coaches, schedules and results, box scores from 2004-05, season stats and leaders of the",
  "Winner League (Israeli Premier League). They mirror sportsdataverse-py's",
  "`sportsdataverse.basketball.ibba` wrappers of the same names: same arguments, the same",
  "snake_case columns and types, one row per sportsdataverse-py row. The live box score, play-by-play and",
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
#' @eval .returns_rd("ibba_configuration", inline = FALSE, unit = "season")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_boards", inline = FALSE, unit = "board")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_boards_ex", inline = FALSE, unit = "board")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_teams", inline = FALSE, unit = "team")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_team", inline = FALSE, unit = "team")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_players", inline = FALSE, unit = "player")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_player", inline = FALSE, unit = "player")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_coaches", inline = FALSE, unit = "staff member")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_box_score", inline = FALSE, unit = "player in the game")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_player_stats", inline = FALSE, unit = "player")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_stats_types", inline = FALSE, unit = "statistic type")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_leaders", inline = FALSE, unit = "leaderboard entry")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(ibba_leaders(season = 2026, stat_type = "pts"))
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
#' @eval .returns_rd("ibba_team_stats", inline = FALSE, unit = "team")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_games", inline = FALSE, unit = "game")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_games_ex", inline = FALSE, unit = "game")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_games_by_team", inline = FALSE, unit = "game")
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
#' @eval .returns_rd("ibba_segev_game_crosswalk", inline = FALSE, unit = "game")
#' @details
#' Raises `hoopR_bad_request` when `df` is not a data frame, lacks a column, has an id
#' column of the wrong type, or maps one id to two.
#'
#' ```r
#'  ibba_segev_game_crosswalk(ibba_games(season = 2026, board_id = 5, board_round = 1))
#' ```
#' @concept IBBA Functions
#' @seealso [family_ibba] lists every function in this family.
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
