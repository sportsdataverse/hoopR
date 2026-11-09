# genius.R -- Genius Sports LiveStats wrappers (exported). Generated once from sportsdataverse-py
# sportsdataverse/basketball/genius/genius.py + basketball_crosswalk.py (origin/main e3d232e);
# maintained by hand from here. Transport, page records and parsers: R/genius_runtime.R.

#' Wrap a Genius frame as a `hoopR_data` tibble.
#' @noRd
.genius_data <- function(df, what) make_hoopR_data(df, paste("Genius LiveStats", what), Sys.time())

#' @title
#' **Genius Game**
#' @description
#' One row per finished game: period and clock state, both teams' names, codes and scores, officials.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' `team1` is the team listed first. `referee1` ... `commissioner` read `officials.<role>` (current feeds) or the flat `officials_refereeN` strings (older feeds); NA when absent.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_game", inline = FALSE, unit = "finished game")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_game(match_id = 2902690))
#' }
genius_game <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_game(raw), "game")
}

#' @title
#' **Genius Team Box Score**
#' @description
#' Team box score of a finished game: score by period, fouls, timeouts and the team totals.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' One row per team (`tno` 1 and 2; the feed has no team id). Percentages are numeric 0-100. `ot_score` is the points in overtime (NA without overtime).
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_team_box(match_id = 2902690)
#' ```
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_team_box", inline = FALSE, unit = "team in the game")
#' @family Genius Functions
#' @export
genius_team_box <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_team_box(raw), "team box score")
}

#' @title
#' **Genius Player Box Score**
#' @description
#' Player box score of a finished game: minutes, shooting, rebounds, assists and the efficiency formulas.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' Rows keyed by (`tno`, `pno`), both in-game numbers; `pno` is not the shirt number and the feed has no global player id (join across games on name, team code and `shirt_number`). Percentages are numeric 0-100; `minutes` is the printed `mm:ss` and `seconds_played` its seconds.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_player_box", inline = FALSE, unit = "player in the game")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_player_box(match_id = 2902690))
#' }
genius_player_box <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_player_box(raw), "player box score")
}

#' @title
#' **Genius Play-by-Play**
#' @description
#' Play-by-play of a finished game, newest action first, with the running score and lead.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' Rows in the feed's order: newest first by game time, so `row_index` 0 is the last action (normally the `game` `end` row); sort on `action_number` for entry order. `score_1` / `score_2` are always integer. `qualifier` joins the qualifier codes with commas. `clock`, `action_number` and `previous_action` are NA in the 2014-15 feed. Overtime restarts `period` at 1: read it with `period_type`.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_pbp", inline = FALSE, unit = "play-by-play event")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_pbp(match_id = 2902690))
#' }
genius_pbp <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_pbp(raw), "play-by-play")
}

#' @title
#' **Genius Shot Chart**
#' @description
#' Shot chart of a finished game: court x/y (percent of the full court), result and shooter.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' `x` and `y` are percentages (0-100) of the full court length and width, NOT normalised to one basket (a team attacks one end in periods 1-2 and the other in 3-4); the origin corner is unverified. `result` is 1 for a made shot, 0 for a miss; `action_number` joins the play-by-play row.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_shots(match_id = 2902690)
#' ```
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_shots", inline = FALSE, unit = "shot")
#' @family Genius Functions
#' @export
genius_shots <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_shots(raw), "shot chart")
}

#' @title
#' **Genius Competition Games**
#' @description
#' The recent-games window of a competition, with the global Genius team ids.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/competition/{comp_id}.json`
#'
#' A few recent or upcoming games, not the season. Scores are cast to integer (NA before tip-off). `match_time` is local (zone not stated), `match_time_utc` UTC.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param comp_id Genius competition id: one per org competition-season (`comp_id` of
#'   [genius_competitions()]), e.g. 49915.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_competition_games", inline = FALSE, unit = "game")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_competition_games(comp_id = 49915))
#' }
genius_competition_games <- function(comp_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/competition/", comp_id, ".json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_competition_games(raw), "competition games")
}

#' @title
#' **Genius Match Competition**
#' @description
#' The competition (comp_id and name) a game belongs to, from its LiveStats HTML shell.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/u/{org}/{match_id}/`
#'
#' A one-row tibble: the only way to map a `data.json` game to its competition (`comp_id`) and, through [genius_competitions()], to a season. `org` is the ORG the request used.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_match_competition(org = "ESAKE", match_id = 2902690)
#' ```
#' @param org LiveStats ORG of the game's shell (can differ from the hosted ORG: NZN vs NZNBL).
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_match_competition", inline = FALSE, unit = "game")
#' @family Genius Functions
#' @export
genius_match_competition <- function(org, match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/u/", org, "/", match_id, "/"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_match_competition(raw), "match competition")
}

#' @title
#' **Genius Competitions**
#' @description
#' Every competition of an org from the hosted WebStats chooser, with its END-year season.
#'
#' Endpoint: `GET https://hosted.dcd.shared.geniussports.com/{org}/en/schedule`
#'
#' One row per competition-season. `year` is the Genius year (START year for a two-year org, the year itself for a calendar org) and `season` the sdv END year: a two-year span in the label wins (`2019 - 20` is 2020), else the Genius year plus one for a split org, else the year itself; `season_rule` names the rule (NA season when none applies). `selected` marks the competition the chooser pre-selects.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param org Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see [genius_competitions()].
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_competitions", inline = FALSE, unit = "competition-season")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_competitions(org = "ESAKE"))
#' }
genius_competitions <- function(org, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_HOSTED, "/", org, "/en/schedule"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_competitions(raw), "competitions")
}

#' @title
#' **Genius Schedule**
#' @description
#' Every match of a competition (hosted WebStats): ids, status, venue, teams and scores.
#'
#' Endpoint: `GET https://hosted.dcd.shared.geniussports.com/{org}/en/competition/{comp_id}/schedule?roundNumber={round_number}`
#'
#' One row per match in page order. Scores are NA before tip-off and for some completed games whose score the page does not print. `date_time` is the page's text (local time, zone not stated). `link_match_id` is NA for orgs that hide match pages (FFBB); `venue_id` is NA when the venue is plain text. An unfilled play-off slot ('To be determined', no team or match link) takes the scope the page's other blocks prove; a page of nothing but such slots is refused.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param org Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see [genius_competitions()].
#' @param comp_id Genius competition id: one per org competition-season (`comp_id` of
#'   [genius_competitions()]), e.g. 49915.
#' @param round_number Round to list; -1 (default) lists every round of the competition.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_schedule", inline = FALSE, unit = "match in page order")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_schedule(org = "CEBL", comp_id = 47852))
#' }
genius_schedule <- function(org, comp_id, round_number = -1, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_HOSTED, "/", org, "/en/competition/", comp_id, "/schedule"), query = list(roundNumber = round_number))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_matches(raw, "schedule"), "schedule")
}

#' @title
#' **Genius Schedule (Embed)**
#' @description
#' Every match of a competition from the JSON-wrapped embed page (orgs whose plain pages answer 500).
#'
#' Endpoint: `GET https://hosted.dcd.shared.geniussports.com/embednf/{org}/en/competition/{comp_id}/schedule?roundNumber={round_number}`
#'
#' The same columns and rules as [genius_schedule()], read from the `/embednf/` `{css, js, html}` envelope.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_schedule_embed(org = "HKS", comp_id = 49946)
#' ```
#' @param org Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see [genius_competitions()].
#' @param comp_id Genius competition id: one per org competition-season (`comp_id` of
#'   [genius_competitions()]), e.g. 49915.
#' @param round_number Round to list; -1 (default) lists every round of the competition.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_schedule_embed", inline = FALSE, unit = "game")
#' @family Genius Functions
#' @export
genius_schedule_embed <- function(org, comp_id, round_number = -1, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_HOSTED, "/embednf/", org, "/en/competition/", comp_id, "/schedule"), query = list(roundNumber = round_number))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_matches(raw, "schedule"), "embed schedule")
}

#' @title
#' **Genius Widget Games**
#' @description
#' The latest games a league site's results widget shows (needs no proxy).
#'
#' Endpoint: `GET https://widget.wh.geniussports.com/widget/?{widget_key}`
#'
#' About 5 to 50 games, newest competition first. `webcast_org` is the LiveStats ORG of the webcast link (`NZN` for the hosted `NZNBL`); a known widget key must return its own ORG's games.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_widget_games(widget_key = "RFJIN037I07QV520B7WEXKV1GYNA31")
#' ```
#' @param widget_key The league site's public widget key (the bare query string of
#'   `widget.wh.geniussports.com/widget/`), e.g. `"RFJIN037I07QV520B7WEXKV1GYNA31"` (ESAKE).
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   record parsed from an HTML page.
#' @eval .returns_rd("genius_widget_games", inline = FALSE, unit = "game")
#' @family Genius Functions
#' @export
genius_widget_games <- function(widget_key, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_WIDGET, "/widget/?", widget_key))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_matches(raw, "widget_games"), "widget games")
}

#' @title
#' **Genius Game Crosswalk**
#' @description
#' Provider game key <-> Genius LiveStats match id, from a frame that carries both.
#'
#' Reads a frame you already have (no request is made), checks the id types and returns
#' the distinct id pairs, one-to-one both ways. Rows without a Genius id (older seasons,
#' upcoming games) are dropped.
#' @details
#' Sources: `sportpress` (BNXT `sportpress_game_slider`: `game_id` / `genius_id`), `cebl`
#' (`game_id` / `genius_match_id`), `tbf` (`match_id` / `genius_id`), `kzs` (`match_id` /
#' `genius_match_id`) and `sportality` (`game_uuid` / `game_id`, the Genius match id). The
#' provider key is integer for every source but `sportality` (a character uuid); the
#' Genius id is integer. A wrong source, a missing column, a wrong id type or a key that
#' maps to two ids raises `hoopR_bad_request`.
#' @param df A data frame from the wrapper named for `source`.
#' @param source One of `"sportpress"`, `"cebl"`, `"tbf"`, `"kzs"`, `"sportality"`.
#' @eval .returns_rd("genius_game_crosswalk", inline = FALSE, unit = "game")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   slider <- data.frame(game_id = c(1L, 2L), genius_id = c(2902690L, NA))
#'   genius_game_crosswalk(slider, "sportpress")
#' }
genius_game_crosswalk <- function(df, source) {
  src <- .GENIUS_GAME_SOURCES[[source %||% ""]]
  if (is.null(src)) {
    choices <- names(.GENIUS_GAME_SOURCES)
    .abort_bad_request("Unknown source {.val {source}}; choose from {.val {choices}}.")
  }
  out <- .genius_pairs(df, src[1], src[3], c(src[2], "integer"), paste0("genius_game_crosswalk[", source, "]"))
  names(out) <- c("game_key", "genius_match_id")
  .genius_data(out, "game crosswalk")
}

#' @title
#' **Genius Team Crosswalk**
#' @description
#' Sportality platform team uuid <-> Genius team id, from a Sportality frame that carries both.
#'
#' The Genius ids are the ones the genius schedule frames call `home_team_id` /
#' `away_team_id`. No request is made.
#' @details
#' Sources: `sportality_standings` (`team_uuid` / `team_id`), `sportality_teams`
#' (`info_uuid` / `info_team_id`) and `sportality_players` (`info_team_uuid` /
#' `info_team_id`). A wrong source, a missing column, a wrong id type or a key that maps
#' to two ids raises `hoopR_bad_request`.
#' @param df A Sportality data frame.
#' @param source One of `"sportality_standings"`, `"sportality_teams"`, `"sportality_players"`.
#' @eval .returns_rd("genius_team_crosswalk", inline = FALSE, unit = "team")
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   standings <- data.frame(team_uuid = c("a1", "b2"), team_id = c(101L, 102L))
#'   genius_team_crosswalk(standings, "sportality_standings")
#' }
genius_team_crosswalk <- function(df, source) {
  src <- .GENIUS_TEAM_SOURCES[[source %||% ""]]
  if (is.null(src)) {
    choices <- names(.GENIUS_TEAM_SOURCES)
    .abort_bad_request("Unknown source {.val {source}}; choose from {.val {choices}}.")
  }
  out <- .genius_pairs(df, src[1], src[2], c("character", "integer"), paste0("genius_team_crosswalk[", source, "]"))
  names(out) <- c("team_uuid", "genius_team_id")
  .genius_data(out, "team crosswalk")
}

# source -> c(provider key column, its type, Genius match id column)
.GENIUS_GAME_SOURCES <- list(
  sportpress = c("game_id", "integer", "genius_id"),
  cebl = c("game_id", "integer", "genius_match_id"),
  tbf = c("match_id", "integer", "genius_id"),
  kzs = c("match_id", "integer", "genius_match_id"),
  sportality = c("game_uuid", "character", "game_id")
)

# source -> c(platform team uuid column, Genius team id column), on Sportality frames
.GENIUS_TEAM_SOURCES <- list(
  sportality_standings = c("team_uuid", "team_id"),
  sportality_teams = c("info_uuid", "info_team_id"),
  sportality_players = c("info_team_uuid", "info_team_id")
)

#' Distinct non-NA `(left, right)` pairs; types asserted; one-to-one both ways (sportsdataverse-py `_pairs`).
#' @noRd
.genius_pairs <- function(df, left, right, types, label, call = rlang::caller_env()) {
  if (!is.data.frame(df)) {
    cls <- class(df)[1]
    .abort_bad_request("{label}: expected a data frame, got {cls}.", call = call)
  }
  if (nrow(df) == 0L) return(.empty_tibble(rlang::set_names(types, c(left, right))))
  missing <- setdiff(c(left, right), names(df))
  if (length(missing)) .abort_bad_request("{label}: the frame has no column {.val {missing}}.", call = call)
  for (i in 1:2) {
    col <- c(left, right)[i]
    got <- class(df[[col]])[1]
    if (!identical(got, types[i])) {
      want <- types[i]
      .abort_bad_request("{label}: {col} is {got}, expected {want} (no float or string id casts).", call = call)
    }
  }
  out <- dplyr::as_tibble(df[, c(left, right)])
  out <- out[!is.na(out[[left]]) & !is.na(out[[right]]), ]
  out <- out[!duplicated(out), ]
  for (k in list(c(left, right), c(right, left))) {
    a <- k[1]
    n <- tapply(out[[k[2]]], out[[a]], function(v) length(unique(v)))
    dup <- names(n)[n > 1]
    if (length(dup)) {
      other <- k[2]
      .abort_bad_request("{label}: {a} maps to more than one {other}: {.val {utils::head(dup, 3)}}.", call = call)
    }
  }
  out
}
