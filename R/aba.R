# aba.R -- the ABA League `aba_*()` family: the Adriatic leagues' own sites (ABA League, ABA League 2).
#
# R mirror of sdv-py sportsdataverse/basketball/aba (e3d232e): same names, arguments, defaults
# and columns. Runtime and parsers: R/aba_utils.R. Roxygen text generated once from sdv-py's
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
#' @return A `hoopR_data` tibble.
#'   One row keyed by (`game_no`, `season`, `league_id`): round and competition labels, the date line split into
#'   `date` / `time` / `time_zone` (`CET` is wall-clock Central European time including summer time; ABA League 2
#'   prints `local`), attendance, venue (null before 2017-18), the two clubs with their global `team_id` and final
#'   score, the commissioner and the referees (`"; "`-joined, names only).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | season_label | character | Season label as the page prints it ('2025/26' on the match page, 'Season 2025/26' on the calendar and standings pages). |
#'   | round | character | Round / phase label as the page prints it: 'ROUND 1', 'Top8 - R2', 'Quarter-finals, Round 1', 'Finals, Round 4', 'Semifinal'. Same vocabulary as calendar games[].round. |
#'   | competition | character | Competition name as printed, sponsor included and applied to every season: 'AdmiralBet ABA League' (2017-18 and 2025-26), 'Regional League' (2008-09), '2. ABA liga' (ABA League 2). |
#'   | group | character | Group letter of a two-group regular season ('A', 'B'). ABSENT when the season has no groups (2008-09, 2017-18 and ABA League 2 samples). |
#'   | when | character | Date-and-time line verbatim (English weekday, dd.mm.yyyy, hh:mm, time-zone label). |
#'   | date | Date | Game date, from the date-and-time line (the first date of a window); null for 'TBA'. |
#'   | date_to | Date | Last date of a 'dd.mm.yyyy - dd.mm.yyyy' window printed before a game is scheduled; null on a game with a single date. |
#'   | time | character | Tip-off time 'hh:mm' in time_zone. |
#'   | time_zone | character | 'CET' = Central European wall-clock time INCLUDING summer time (the label never changes; the Dubai local times prove CEST in October/June, CET in winter); 'local' = the arena's local time (ABA League 2 prints 'Local time'). |
#'   | local_time | character | Arena-local tip-off 'hh:mm' when the arena is outside Central Europe ('(19:00 Dubai local time)'); null otherwise. |
#'   | local_place | character | City of local_time ('Dubai', 'Cluj-Napoca'); null when the arena is in Central Europe. |
#'   | attendance | integer | Spectators (the users icon). The parser sets null when the page prints none (never seen: every banked page prints it; null is part of the record contract). |
#'   | venue | character | Arena name ('Venue: ...'). ABSENT on the 2008-09 sample (the page has no venue line). |
#'   | home_team_id | integer | ABA team id (key space: aba-liga.com clubs, the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26, Krka = 10). The first number of /team/\{id\}/\{sez\}/\{lea\}/0/\{slug\}/ and of the logo images/club/\{size\}/\{id\}.png. Joins match game.*_team_id / players / teams / pbp, standings rows and the player page. Not a player id. |
#'   | home_team | character | Home club name as the site prints it NOW: a club's current name is applied to every season (2008-09 shows 'Partizan Mozzart Bet'); a club that no longer plays keeps its last name (2008-09 'Petrol Olimpija'). Join on the team id. |
#'   | home_city | character | Home club city (local spelling: 'Beograd', 'Novo Mesto'). |
#'   | home_score | integer | Home final score. |
#'   | away_team_id | integer | ABA team id (key space: aba-liga.com clubs, the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26, Krka = 10). The first number of /team/\{id\}/\{sez\}/\{lea\}/0/\{slug\}/ and of the logo images/club/\{size\}/\{id\}.png. Joins match game.*_team_id / players / teams / pbp, standings rows and the player page. Not a player id. |
#'   | away_team | character | Away club name as the site prints it now (see home_team). |
#'   | away_city | character | Away club city (local spelling). |
#'   | away_score | integer | Away final score. |
#'   | commissioner | character | Game commissioner's name ('Commissioner:' line); 2008-09 adds an IOC-style country code in parentheses ('(SRB)'). Null when not printed. |
#'   | referees | character | Referees' names in page order (crew chief first), joined with '; ' (2008-09 adds an IOC-style country code in parentheses). Names only. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per period played: `period` (`Q1`..`Q4`, then `OT1`, `OT2`...), its 1-based `period_no` and the points
#'   scored IN the period (not cumulative).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | period | character | 'Q1'..'Q4', then 'OT1', 'OT2' ... for overtimes. |
#'   | period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, then 5 for OT1, 6 for OT2. |
#'   | home_points | integer | Home points scored IN the period (not cumulative). |
#'   | away_points | integer | Away points scored IN the period (not cumulative). |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per player listed, in page order. `played` is false on a did-not-play row (minutes `00:00`, every stat
#'   null). `starter` and `on_court_at_end` exist from 2017-18 and are null for the whole game before. The advanced
#'   `pts_paint` / `pts_second_chance` / `pts_fast_break` trio is null where the season has none (2008-09).
#'   `plus_minus` is 0 on every row of the 2008-09 sample (not tracked then). Percentages are 0-100. Join on
#'   `player_id` (global), not on the printed name.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | side | character | 'home' or 'away' (the home team is listed first everywhere on the site). |
#'   | team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
#'   | jersey | integer | Jersey number worn in the game (the box lists players by jersey number). |
#'   | player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
#'   | player_name | character | Name as the box prints it: 'Surname I.' (diacritics kept). |
#'   | starter | logical | In the starting five: the box marks it with '*' (matches the play-by-play 'in starting lineup' rows on every sample). Null for the whole game when no row carries a '*' (box-only seasons, 2008-09 sample). |
#'   | on_court_at_end | logical | On court at the final buzzer: the box prints the name in bold (matches the substitutions in the play-by-play on every sample). Null for the whole game when no name is bold (box-only seasons). |
#'   | played | logical | False on a did-not-play row (minutes '00:00' and one empty cell across the stat columns); its stat columns are null. |
#'   | minutes | character | Minutes played, 'mm:ss' text. '00:00' on did-not-play rows. |
#'   | points | integer | Points scored (overall Pts). Null on did-not-play rows (played = false). |
#'   | fg_pct | double | Field-goal percentage over 2- and 3-point attempts, 0-100 with one decimal (FG2 + FG3 made / attempted); 0 when no attempt. Header 'overall %'. Null on did-not-play rows (played = false). |
#'   | fg2_made | integer | 2-point field goals made (FG2 M). Null on did-not-play rows (played = false). |
#'   | fg2_att | integer | 2-point field goals attempted (FG2 A). Null on did-not-play rows (played = false). |
#'   | fg2_pct | double | 2-point percentage, 0-100 with one decimal; 0 when no attempt. Null on did-not-play rows (played = false). |
#'   | fg3_made | integer | 3-point field goals made (FG3 M). Null on did-not-play rows (played = false). |
#'   | fg3_att | integer | 3-point field goals attempted (FG3 A). Null on did-not-play rows (played = false). |
#'   | fg3_pct | double | 3-point percentage, 0-100 with one decimal; 0 when no attempt. Null on did-not-play rows (played = false). |
#'   | ft_made | integer | Free throws made (FT M). Null on did-not-play rows (played = false). |
#'   | ft_att | integer | Free throws attempted (FT A). Null on did-not-play rows (played = false). |
#'   | ft_pct | double | Free-throw percentage, 0-100 with one decimal; 0 when no attempt. Null on did-not-play rows (played = false). |
#'   | reb_def | integer | Defensive rebounds (Rebs D). Null on did-not-play rows (played = false). |
#'   | reb_off | integer | Offensive rebounds (Rebs O). Null on did-not-play rows (played = false). |
#'   | reb_tot | integer | Total rebounds (Rebs T). Null on did-not-play rows (played = false). |
#'   | assists | integer | Assists made (the Ass column). |
#'   | steals | integer | Steals made (the St column). |
#'   | turnovers | integer | Turnovers (To). Null on did-not-play rows (played = false). |
#'   | blocks | integer | Shots blocked by this player or team (Blck Fv, 'in favour'). Null on did-not-play rows (played = false). |
#'   | blocks_against | integer | Own shots blocked by an opponent (Blck Ag, 'against'). Null on did-not-play rows (played = false). |
#'   | fouls | integer | Fouls committed (Foul Cm). Null on did-not-play rows (played = false). |
#'   | fouls_drawn | integer | Fouls drawn / received (Foul Rv). Null on did-not-play rows (played = false). |
#'   | pts_paint | integer | Points in the paint (Points from Paint). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | pts_second_chance | integer | Second-chance points (Points from 2ndCh). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | pts_fast_break | integer | Fast-break points (Points from FstBr). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | plus_minus | integer | Plus/minus while on court (+/-). 0 on every row of the 2008-09 sample (not tracked then). Null on did-not-play rows (played = false). |
#'   | valuation | integer | Valuation (Val, 'rank Value'): the efficiency rating (PIR-style index) the site ranks players by. Null on did-not-play rows (played = false). |
#'
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
#' @return A `hoopR_data` tibble.
#'   Two rows, home then away. `minutes` is the five on court summed (`200:00`, `225:00` with one overtime);
#'   `points` equals the final score; `reb_tot` equals the players' sum (team rebounds are not added).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | side | character | 'home' or 'away' (the home team is listed first everywhere on the site). |
#'   | team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
#'   | team_name | character | Club name as the site prints it now (see game.home_team). |
#'   | minutes | character | Minutes played, 'mm:ss' text. Team rows sum the five on court: '200:00', '225:00' with one overtime. |
#'   | points | integer | Points scored (overall Pts). |
#'   | fg_pct | double | Field-goal percentage over 2- and 3-point attempts, 0-100 with one decimal (FG2 + FG3 made / attempted); 0 when no attempt. Header 'overall %'. |
#'   | fg2_made | integer | 2-point field goals made (FG2 M). |
#'   | fg2_att | integer | 2-point field goals attempted (FG2 A). |
#'   | fg2_pct | double | 2-point percentage, 0-100 with one decimal; 0 when no attempt. |
#'   | fg3_made | integer | 3-point field goals made (FG3 M). |
#'   | fg3_att | integer | 3-point field goals attempted (FG3 A). |
#'   | fg3_pct | double | 3-point percentage, 0-100 with one decimal; 0 when no attempt. |
#'   | ft_made | integer | Free throws made (FT M). |
#'   | ft_att | integer | Free throws attempted (FT A). |
#'   | ft_pct | double | Free-throw percentage, 0-100 with one decimal; 0 when no attempt. |
#'   | reb_def | integer | Defensive rebounds (Rebs D). |
#'   | reb_off | integer | Offensive rebounds (Rebs O). |
#'   | reb_tot | integer | Total rebounds (Rebs T). Team rows equal the players' sum on every sample (team rebounds are not added). |
#'   | assists | integer | Assists made (the Ass column). |
#'   | steals | integer | Steals made (the St column). |
#'   | turnovers | integer | Turnovers (To). |
#'   | blocks | integer | Shots blocked by this player or team (Blck Fv, 'in favour'). |
#'   | blocks_against | integer | Own shots blocked by an opponent (Blck Ag, 'against'). |
#'   | fouls | integer | Fouls committed (Foul Cm). |
#'   | fouls_drawn | integer | Fouls drawn / received (Foul Rv). |
#'   | pts_paint | integer | Points in the paint (Points from Paint). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | pts_second_chance | integer | Second-chance points (Points from 2ndCh). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | pts_fast_break | integer | Fast-break points (Points from FstBr). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | plus_minus | integer | Plus/minus while on court (+/-). 0 on every row of the 2008-09 sample (not tracked then). Team rows: the final margin (0 on the 2008-09 sample). |
#'   | valuation | integer | Valuation (Val, 'rank Value'): the efficiency rating (PIR-style index) the site ranks players by. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per event, `seq` 1-based in game order (the page lists each period newest first). `period` is 1-4 for
#'   the quarters and 5 for every overtime together; `clock` is `mm:ss` REMAINING (10:00 per quarter, 05:00 in
#'   overtime) and null on starting-lineup and period markers. The score is printed only on scoring events, so
#'   `home_score` / `away_score` are null elsewhere (carry them forward for a running score). `text` is the English
#'   event; `action` is the text without its parenthesised `qualifier` (shot type, rebound side, `n of m` free
#'   throw, foul or turnover type). Team-only rows print just the qualifier, so `action` is null there. Empty before
#'   2017-18 (the page has no play-by-play tab).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | seq | integer | 1-based position in game order across the whole game (after the reversal). |
#'   | period | integer | 1-4 = quarters, 5 = overtime (the #q5 tab; every overtime of the game). |
#'   | clock | character | Clock in the period, 'mm:ss' REMAINING (counts down from 10:00; overtime from 05:00). Null on the starting-lineup rows and on game / period start and end markers. |
#'   | seconds_left | integer | The clock as whole seconds REMAINING in the period (08:34 = 514), derived by the parser; null where the clock is. |
#'   | home_score | integer | Home score after this event: only set on scoring events (the page prints the score only there); null otherwise. Carry it forward for a running score. |
#'   | away_score | integer | Away score after this event, as home_score. |
#'   | side | character | Which column the event sits in: 'home', 'away', or null for game/period markers and bare-clock rows. A timeout row gets the side of its team badge. |
#'   | team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
#'   | jersey | integer | Jersey number as printed; the play-by-play omits it on some rows (all starting-lineup rows and many home rows), so it is null there. |
#'   | player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
#'   | player_name | character | Name as the play-by-play prints it: 'SURNAME I' upper case (the trailing '.' belongs to the event text on the page and is dropped). |
#'   | text | character | Event text in English after the player's name: `<action> (<qualifier>)`, 'in starting lineup', or the whole text of a team / game row ('(defensive)', 'Timeout', 'start of 1. quarter'). Null on bare-clock rows ('10:00' with nothing else, opening some periods). |
#'   | action | character | text without its parenthesised qualifier; see the action table below the route. Null on team rows (they print only '(qualifier)') and bare-clock rows. |
#'   | qualifier | character | The parenthesised part of text (shot type, rebound side, free-throw 'n of m', foul or turnover type); see the qualifier table. Null when the text has none. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per field-goal attempt (no free throws), in the site's order. `x` and `y` are PERCENTAGES of the full
#'   court on the site's 1000x535 px image (court 28 x 15 m), cast to float (the site sends x as a string in one
#'   half of a game and a number in the other). x runs from the LEFT baseline (home shoots at x < 50, away at x >
#'   50). y is drawn upward from the bottom edge, 50 = the line through both baskets; whether "up" is the scorer's
#'   table side is unverified. `side` is `home` / `away` (the site's `ekipa` 1 / 2). `player_id` is cast from the
#'   site's string (null when the shooter was not recorded, id 0); join on it, not on the name. The chart can differ
#'   from the box score by one attempt per shooter.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | side | character | Which team took the shot: home or away (the site's ekipa, a string '1' / '2'). |
#'   | x | double | Shot x as a PERCENTAGE (0-100) of the court LENGTH from the LEFT baseline of the site's 1000x535 px full-court image. Home shoots at x < 50 and away at x > 50. The site sends it as a string in one half of a game and a number in the other; cast to float. |
#'   | y | double | Shot y as a PERCENTAGE (0-100) of the court WIDTH, drawn upward from the bottom edge (the line through both baskets is 50). Whether 'up' is the scorer's table side is unverified. |
#'   | made | logical | True when the attempt was made (the site's koordinata_uspeh '1'), false when missed. |
#'   | player_id | integer | Shooter's ABA player id (global), cast from the site's string; null when the shooter was not recorded (id 0). Join to the box score on it, never on the name. |
#'   | player_name | character | Shooter's full name, 'First Last' (the box prints 'Last F.'); null when not recorded. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per minute: `minute` 0 (tip-off) to 40, then 41-45 per overtime, and the CUMULATIVE `home_score` /
#'   `away_score` at the end of that minute (the site sends them as numeric strings; cast here). The last row equals
#'   the final score.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | minute | integer | Elapsed game minute: 0 (tip-off) to 40, then 41-45 per overtime; every minute once, in order. |
#'   | home_score | integer | Home cumulative score at the end of that minute (the site sends a numeric string). The last row equals the final score. |
#'   | away_score | integer | Away cumulative score at the end of that minute (the site sends a numeric string). The last row equals the final score. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per minute with the cumulative `home_score` / `away_score`, as :func:`parse_aba_score_flow`; for a
#'   played game the two routes carry the same rows.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | minute | integer | Elapsed game minute: 0 (tip-off) to 40, then 41-45 per overtime; every minute once, in order. |
#'   | home_score | integer | Home cumulative score at the end of that minute (the site sends a numeric string). The last row equals the final score. |
#'   | away_score | integer | Away cumulative score at the end of that minute (the site sends a numeric string). The last row equals the final score. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per game in page order (one accordion panel per `round`), keyed by (`game_no`, `season`, `league_id`).
#'   Scores are null for a game not played yet. The calendar carries club NAMES and three-letter codes only (no team
#'   ids): join to the box score on `game_no`. `when` is the cell verbatim; `date` / `date_to` / `time` are split
#'   from it (null for `TBA` or a date window). `time_zone` is `CET` (Central European wall-clock time including
#'   summer time) or `local` (ABA League 2). `group` is the group letter, null after the groups and absent on
#'   seasons without a Group column.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | season_label | character | Season label as the page prints it ('2025/26' on the match page, 'Season 2025/26' on the calendar and standings pages). |
#'   | round | character | Round or phase label, the accordion panel title ('ROUND 1', 'Top8 - R1', 'Quarter-finals, Round 1', 'Finals, Round 4'). |
#'   | group | character | Group letter ('A', 'B') from the Group column, which exists only in seasons with groups; null after the groups (Top8, Play-out, playoffs) and where the page has no Group column. |
#'   | home_team | character | Home club name as the site prints it now (see the match page's game.home_team). Null while a playoff pairing is not set (' : '): seen on the live 2026-27 page (122 of 302 games), which is NOT banked, so no committed sample shows it. |
#'   | away_team | character | Away club name; null like home_team while a pairing is not set (live 2026-27 page, not banked). |
#'   | home_abbr | character | Home club's three-letter code ('PAR', 'CZV'), from the mobile copy of the cell. |
#'   | away_abbr | character | Away club's three-letter code. |
#'   | home_score | integer | Home final score. Null for a game not played yet (empty Result cell): seen on the live 2026-27 page (282 of 302 games), which is NOT banked. |
#'   | away_score | integer | Away final score; null like home_score for a game not played yet (live 2026-27 page, not banked). |
#'   | when | character | Date and Time cell verbatim: 'Monday, 06.10.2025 18:00 CET', with '(19:00 Dubai local time)' for arenas outside Central Europe, 'Local time' on ABA League 2, a date window or 'TBA' before scheduling. |
#'   | date | Date | Game date, from the date-and-time line (the first date of a window); null for 'TBA'. |
#'   | date_to | Date | Last date of a 'dd.mm.yyyy - dd.mm.yyyy' window printed before a game is scheduled; null on a game with a single date. |
#'   | time | character | Tip-off 'hh:mm' in time_zone. Null when only a date window or 'TBA' is printed (live 2026-27 page, NOT banked). |
#'   | time_zone | character | 'CET' = Central European wall-clock time INCLUDING summer time (CET in winter, CEST in summer; the label never changes); 'local' = arena local time ('Local time', ABA League 2). Null with a date window or 'TBA' (live 2026-27 page, NOT banked). |
#'   | local_time | character | Arena-local tip-off 'hh:mm' when the arena is outside Central Europe ('(19:00 Dubai local time)'); null otherwise. |
#'   | local_place | character | City of local_time ('Dubai', 'Cluj-Napoca'); null when the arena is in Central Europe. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per team per table, in page order. A season has several tables: `table` is the phase heading (`Regular
#'   Season 2025/26`, `Top 8 Season 2025/26`, `Play-out Season 2025/26`) and `group` the group under it (`Group A`,
#'   null without one). `standing_points` are table points, 2 per win and 1 per loss. `points_for` /
#'   `points_against` are the two sides of the page's `Overall` column; Top 8 and Play-out tables carry points over
#'   from the regular season.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | season_label | character | Season label as the page prints it ('2025/26' on the match page, 'Season 2025/26' on the calendar and standings pages). |
#'   | table | character | Title of the table's phase heading (h2): 'Top 8 Season 2025/26', 'Play-out Season 2025/26', 'Regular Season 2025/26'. |
#'   | group | character | Group heading under the phase ('Group A', 'Group B'); null when the table has no group heading. |
#'   | rank | integer | Position in this table (#). |
#'   | team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
#'   | team_name | character | Club name as the site prints it now (see the match page's game.home_team). |
#'   | games | integer | Games played (GP). |
#'   | wins | integer | Games won in this table (the W column). |
#'   | losses | integer | Games lost in this table (the L column). |
#'   | points_for | integer | Points scored (left side of 'Overall' 'for:against'). |
#'   | points_against | integer | Points allowed (right side of 'Overall'). |
#'   | point_diff | integer | Point difference (Diff), points_for - points_against. |
#'   | standing_points | integer | Standings points (Points): 2 per win and 1 per loss (FIBA), e.g. 21-3 = 45. |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row keyed by (`player_id`, `season`, `league_id`) with the club (`team_id` is the global club id),
#'   position, height in cm, birth date and place, nationality (a three-letter code) and `career`, the free-text
#'   Clubs box joined with `"; "` (oldest first). These bio fields are the public player profile.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | name | character | Full name from the h1, 'First Last' (checked against the expected name). |
#'   | team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
#'   | club | character | Club name of the 'Club:' row. |
#'   | position | character | Position in English as printed ('Guard' on the sample). |
#'   | height_cm | integer | Height in centimetres ('185 cm'). |
#'   | birth_date | Date | Date of birth, ISO 'YYYY-MM-DD' (public player bio). |
#'   | birth_place | character | Place of birth as printed, 'City, COUNTRY' ('Cincinnati, USA'). |
#'   | nationality | character | Sporting nationality, a three-letter code as printed ('SSD' = South Sudan; IOC/FIBA-style codes). |
#'   | career | character | The Clubs box, one free-text line per stint, oldest first, joined with '; ' ('2021/22 - Texas Legends; 2024-27 - Partizan Mozzart Bet'). |
#'
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
#' @return A `hoopR_data` tibble.
#'   One row per game the player was listed in, keyed by (`player_id`, `game_no`, `season`, `league_id`). `round_no`
#'   is the season-wide round index (regular season 1-18, later phases continue the count) and `game` the short
#'   `Home-Away` pairing label. The stat columns are the box-score stats (`minutes` is `mm:ss`); the three `pts_*`
#'   columns are null here (the game log has no such columns).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer with nothing in
#'   it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
#'   | season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
#'   | league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
#'   | league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
#'   | round_no | integer | Season-wide round index of the game: 1-18 = regular season, later phases continue the count (ABA 2025-26: 'Top8 - R2' = 21, 'Finals, Round 4' = 48). |
#'   | game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The \{gameNo\} of the match route. |
#'   | game | character | Short pairing label 'Home-Away' with short club names ('Partizan-Krka', 'C. Zvezda-Partizan'). |
#'   | minutes | character | Minutes played, 'mm:ss' text. |
#'   | points | integer | Points scored (overall Pts). |
#'   | fg_pct | double | Field-goal percentage over 2- and 3-point attempts, 0-100 with one decimal (FG2 + FG3 made / attempted); 0 when no attempt. Header 'overall %'. |
#'   | fg2_made | integer | 2-point field goals made (FG2 M). |
#'   | fg2_att | integer | 2-point field goals attempted (FG2 A). |
#'   | fg2_pct | double | 2-point percentage, 0-100 with one decimal; 0 when no attempt. |
#'   | fg3_made | integer | 3-point field goals made (FG3 M). |
#'   | fg3_att | integer | 3-point field goals attempted (FG3 A). |
#'   | fg3_pct | double | 3-point percentage, 0-100 with one decimal; 0 when no attempt. |
#'   | ft_made | integer | Free throws made (FT M). |
#'   | ft_att | integer | Free throws attempted (FT A). |
#'   | ft_pct | double | Free-throw percentage, 0-100 with one decimal; 0 when no attempt. |
#'   | reb_def | integer | Defensive rebounds (Rebs D). |
#'   | reb_off | integer | Offensive rebounds (Rebs O). |
#'   | reb_tot | integer | Total rebounds (Rebs T). |
#'   | assists | integer | Assists made (the Ass column). |
#'   | steals | integer | Steals made (the St column). |
#'   | turnovers | integer | Turnovers (To). |
#'   | blocks | integer | Shots blocked by this player or team (Blck Fv, 'in favour'). |
#'   | blocks_against | integer | Own shots blocked by an opponent (Blck Ag, 'against'). |
#'   | fouls | integer | Fouls committed (Foul Cm). |
#'   | fouls_drawn | integer | Fouls drawn / received (Foul Rv). |
#'   | pts_paint | integer | Points in the paint (Points from Paint). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | pts_second_chance | integer | Second-chance points (Points from 2ndCh). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | pts_fast_break | integer | Fast-break points (Points from FstBr). Null where the season has no such column (2008-09) and on did-not-play rows. |
#'   | plus_minus | integer | Plus/minus while on court (+/-). 0 on every row of the 2008-09 sample (not tracked then). |
#'   | valuation | integer | Valuation (Val, 'rank Value'): the efficiency rating (PIR-style index) the site ranks players by. |
#'
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
