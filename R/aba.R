# aba.R -- the ABA League `aba_*()` family: the Adriatic leagues' own sites (ABA League, ABA League 2).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/aba (e3d232e): same names, arguments, defaults
# and columns. Runtime and parsers: R/aba_utils.R. Roxygen text generated once from sportsdataverse-py's
# aba.yaml and manual_column_descriptions.yaml.

#' @title
#' **ABA League Game**
#' @description
#' Header of one finished game: round, date, venue, attendance, both clubs with their score, commissioner and
#' referees.
#'
#' Endpoint: `GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_game", inline = FALSE, unit = "(`game_no`, `season`, `league_id`)")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#' @family ABA Functions
#' @export
#' @examples
#' \donttest{
#'   try(aba_game(game_no = 6, season = 2026))
#' }
aba_game <- function(game_no, season, league = "aba") {
  .aba_wrap("game", list(game_no = game_no, season = season, league = league),
            type = "ABA League Game", call = rlang::current_env())
}

#' @title
#' **ABA League Periods**
#' @description
#' Points each team scored in each quarter and overtime of one finished game.
#'
#' Endpoint: `GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_periods", inline = FALSE, unit = "period played")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#'
#' ```r
#'  aba_periods(game_no = 6, season = 2026)
#' ```
#' @family ABA Functions
#' @export
aba_periods <- function(game_no, season, league = "aba") {
  .aba_wrap("periods", list(game_no = game_no, season = season, league = league),
            type = "ABA League Periods", call = rlang::current_env())
}

#' @title
#' **ABA League Player Box**
#' @description
#' Player box score of one finished game (2001-02 on): minutes, points, shooting splits, rebounds, assists, fouls,
#' plus/minus and valuation.
#'
#' Endpoint: `GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_box_players", inline = FALSE, unit = "player listed")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#' @family ABA Functions
#' @export
#' @examples
#' \donttest{
#'   try(aba_box_players(game_no = 6, season = 2026))
#' }
aba_box_players <- function(game_no, season, league = "aba") {
  .aba_wrap("box_players", list(game_no = game_no, season = season, league = league),
            type = "ABA League Player Box", call = rlang::current_env())
}

#' @title
#' **ABA League Team Box**
#' @description
#' Team totals of one finished game: the Team Compare table, home then away.
#'
#' Endpoint: `GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_box_teams", inline = FALSE, unit = "team in the game")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#' @family ABA Functions
#' @export
#' @examples
#' \donttest{
#'   try(aba_box_teams(game_no = 6, season = 2026))
#' }
aba_box_teams <- function(game_no, season, league = "aba") {
  .aba_wrap("box_teams", list(game_no = game_no, season = season, league = league),
            type = "ABA League Team Box", call = rlang::current_env())
}

#' @title
#' **ABA League Play-by-Play**
#' @description
#' Play-by-play of one finished game (2017-18 on), in game order: shots, rebounds, fouls, substitutions, timeouts
#' and period markers.
#'
#' Endpoint: `GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_pbp", inline = FALSE, unit = "event")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#' @family ABA Functions
#' @export
#' @examples
#' \donttest{
#'   try(aba_pbp(game_no = 6, season = 2026))
#' }
aba_pbp <- function(game_no, season, league = "aba") {
  .aba_wrap("pbp", list(game_no = game_no, season = season, league = league),
            type = "ABA League Play-by-Play", call = rlang::current_env())
}

#' @title
#' **ABA League Shots**
#' @description
#' Shot chart of one finished game (2017-18 on): every field-goal attempt with its court position.
#'
#' Endpoint: `GET https://www.aba-liga.com/live-match/rezultati-1718/create_shooting_chart.php?id={game_no}&sez={sez}&lea={lea}`
#' (after a GET of the same game's match page, which the helper is checked against).
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_shots", inline = FALSE, unit = "field-goal attempt")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#'
#' ```r
#'  aba_shots(game_no = 6, season = 2026)
#' ```
#' @family ABA Functions
#' @export
aba_shots <- function(game_no, season, league = "aba") {
  .aba_wrap("shots", list(game_no = game_no, season = season, league = league),
            type = "ABA League Shots", call = rlang::current_env())
}

#' @title
#' **ABA League Score Flow**
#' @description
#' Score after every whole minute of one finished game (the Result Graph; 2017-18 on).
#'
#' Endpoint: `GET https://www.aba-liga.com/live-match/rezultati-1718/create_json.php?id={game_no}&sez={sez}&lea={lea}`
#' (after a GET of the same game's match page, which the helper is checked against).
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_score_flow", inline = FALSE, unit = "minute")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#'
#' ```r
#'  aba_score_flow(game_no = 6, season = 2026)
#' ```
#' @family ABA Functions
#' @export
aba_score_flow <- function(game_no, season, league = "aba") {
  .aba_wrap("score_flow", list(game_no = game_no, season = season, league = league),
            type = "ABA League Score Flow", call = rlang::current_env())
}

#' @title
#' **ABA League Score Difference**
#' @description
#' Score after every whole minute of one finished game, from the Score difference chart (2017-18 on); the same rows
#' as aba_score_flow.
#'
#' Endpoint: `GET https://www.aba-liga.com/live-match/rezultati-1718/create_scoredifference.php?id={game_no}&sez={sez}&lea={lea}`
#' (after a GET of the same game's match page, which the helper is checked against).
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param game_no Required. Game number within the season AND league (it restarts at 1 for every season and league),
#' e.g. 6; `game_no` in aba_calendar. Playoff games that were not needed leave gaps.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_score_difference", inline = FALSE, unit = "minute with the cumulative home_score / away_score")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#'
#' ```r
#'  aba_score_difference(game_no = 6, season = 2026)
#' ```
#' @family ABA Functions
#' @export
aba_score_difference <- function(game_no, season, league = "aba") {
  .aba_wrap("score_difference", list(game_no = game_no, season = season, league = league),
            type = "ABA League Score Difference", call = rlang::current_env())
}

#' @title
#' **ABA League Calendar**
#' @description
#' Full schedule and results of one season of one league: every round and game.
#'
#' Endpoint: `GET https://www.aba-liga.com/calendar/{sez}/{lea}/`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_calendar", inline = FALSE, unit = "game")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#' @family ABA Functions
#' @export
#' @examples
#' \donttest{
#'   try(aba_calendar(season = 2026))
#' }
aba_calendar <- function(season, league = "aba") {
  .aba_wrap("calendar", list(season = season, league = league),
            type = "ABA League Calendar", call = rlang::current_env())
}

#' @title
#' **ABA League Standings**
#' @description
#' Standings tables of one season of one league: regular season groups, Top 8 and Play-out.
#'
#' Endpoint: `GET https://www.aba-liga.com/standings/{sez}/{lea}/`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_standings", inline = FALSE, unit = "team in each table")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#' @family ABA Functions
#' @export
#' @examples
#' \donttest{
#'   try(aba_standings(season = 2026))
#' }
aba_standings <- function(season, league = "aba") {
  .aba_wrap("standings", list(season = season, league = league),
            type = "ABA League Standings", call = rlang::current_env())
}

#' @title
#' **ABA League Player**
#' @description
#' One player's bio for one season and league: club, position, height, birth date and place, nationality and the
#' career line.
#'
#' Endpoint: `GET https://www.aba-liga.com/player/{player_id}/{sez}/{lea}/`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param player_id Required. ABA player id (global: one person keeps one id across seasons and both leagues), e.g.
#' 4807 (Carlik Jones); `player_id` in aba_box_players.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_player", inline = FALSE, unit = "(`player_id`, `season`, `league_id`)")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#'
#' ```r
#'  aba_player(player_id = 4807, season = 2026)
#' ```
#' @family ABA Functions
#' @export
aba_player <- function(player_id, season, league = "aba") {
  .aba_wrap("player", list(player_id = player_id, season = season, league = league),
            type = "ABA League Player", call = rlang::current_env())
}

#' @title
#' **ABA League Player Games**
#' @description
#' One player's game log for one season and league: one row per game with the box-score stats.
#'
#' Endpoint: `GET https://www.aba-liga.com/player/{player_id}/{sez}/{lea}/`
#' `sez = season - 2001`; `league = "aba2"` reads `https://druga.aba-liga.com` with `lea = 2`.
#' @param player_id Required. ABA player id (global: one person keeps one id across seasons and both leagues), e.g.
#' 4807 (Carlik Jones); `player_id` in aba_box_players.
#' @param season Required. Season END year (2026 = 2025-26). the wrapper sends the site's START-year key `sez =
#' season - 2001` (25). The ABA League's first season is 2001-02 (`season=2002`).
#' @param league League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or `aba2` (ABA League 2,
#' druga.aba-liga.com, lea=2). Both sites serve one database; the runtime asks the league's own host. Default
#' `"aba"`.
#' @eval .returns_rd("aba_player_games", inline = FALSE, unit = "game the player was listed in")
#' @details
#' Unofficial use of a public source: these wrappers read the leagues' own PHP sites (www.aba-liga.com,
#' druga.aba-liga.com), keyless, with no bot wall.
#' www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing disallowed, no Crawl-delay) and druga has
#' no robots.txt; no terms page was found. The runtime waits at least 1 s per host before every request.
#'
#' Coverage: box scores from 2001-02; play-by-play, the starter and on-court markers, the shot chart and the
#' minute-by-minute score from 2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the helpers). A
#' game is keyed by (game_no, season, league_id): game_no restarts at 1 for every season and league. Team and player
#' ids are global; the calendar carries club names only. Club names are the club's CURRENT name on every season:
#' join on team_id.
#'
#' Only finished games are served: an unplayed game, or one whose period scores, team totals or play-by-play do not
#' add up to the final score, raises `hoopR_asset_fetch`, as does a page for another game, season or league than
#' asked. The three live-match helpers echo nothing about the game, so the runtime fetches the same game's match
#' page first (one extra request) and checks the helper against it.
#'
#' Times: `CET` means Central European wall-clock time including summer time (the label never changes); ABA League 2
#' prints `Local time`. Officials appear by name only; the player bio (birth date and place, nationality) is the
#' public player profile.
#'
#' Errors: `hoopR_no_data` when the site has nothing for the request (HTTP 404, an unknown game redirected to
#' /match-not-defined/, a season the site does not hold or before 2001-02, a live-match helper with no data before
#' 2017-18); `hoopR_bad_request` for an invalid argument (a non-integer id or season, a `league` other than `aba` /
#' `aba2`) or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200, a connection failure
#' after three attempts, a redirect off the ABA sites) or the answer is not the one asked for (a page for another
#' game, season or league, an unfinished game, a helper that does not belong to the game, layout drift). All inherit
#' `hoopR_error`.
#'
#' ```r
#'  aba_player_games(player_id = 4807, season = 2026)
#' ```
#' @family ABA Functions
#' @export
aba_player_games <- function(player_id, season, league = "aba") {
  .aba_wrap("player_games", list(player_id = player_id, season = season, league = league),
            type = "ABA League Player Games", call = rlang::current_env())
}
