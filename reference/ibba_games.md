# **IBBA Games**

**Games (schedule and results) of a season filtered by board, round,
team and game; 0 means any.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Games`

## Usage

``` r
ibba_games(
  season,
  board_id = 0,
  board_round = 0,
  team_id = 0,
  team_uid = 0,
  game_id = 0
)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `0`): Competition (board) id: 5 league, 10 cup, 16
  / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34
  Supercup. 0 (default) for every board.

- board_round:

  (*integer*, default `0`): Round (game number) within the board; 0
  (default) for every round.

- team_id:

  (*integer*, default `0`): Team-season id; 0 (default) for every team.

- team_uid:

  (*integer*, default `0`): IBBA club id; 0 (default) for every club.

- game_id:

  (*integer*, default `0`): IBBA game id; 0 (default) for every game.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig\_ space, e.g. 8888 for a pre-season game). |
| game_date | Date | Local Israel date of the game. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| home_team_id | integer | Home team-season id (team1 on the wire; verified home against Segev). On external boards (board_id \>= 1001) an external-team id (the ig_team\_ space), not a team-season. |
| away_team_id | integer | Away team-season id (team2 on the wire). On external boards an external-team id. |
| home_team_he | character | Home team name in Hebrew, HTML-unescaped. |
| away_team_he | character | Away team name in Hebrew, HTML-unescaped. |
| home_team | character | Home team name in English; null for external games, which carry Hebrew names only. |
| away_team | character | Away team name in English; null for external games. |
| home_logo_url | character | Absolute URL of the home team logo. |
| away_logo_url | character | Absolute URL of the away team logo. |
| home_score | integer | Home final score; 0 before the game is played. |
| away_score | integer | Away final score; 0 before the game is played. |
| board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
| board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
| board_name | character | Competition name in English ('Winner League'); null for external boards. |
| round | integer | Round (game number) within the board; null for external games. |
| tip_off | character | Tip-off 'HH:MM', local Israel time, as text; null in 2004-05. It can disagree with Segev (game 26646: 20:15 here, 19:30 in Segev). |
| venue_he | character | Venue in Hebrew, HTML-unescaped; null in 2004-05. |
| venue | character | Venue in English, HTML-unescaped; null in 2004-05. |
| referees_he | character | Referees' names in Hebrew, comma-separated; ', , ' when unknown. |
| attendance | integer | Attendance; 0 when unknown. |
| overtime | logical | True when the game went to overtime. |
| overtimes | integer | Number of overtime periods played. |
| home_score_by_period | character | Home points per period, pipe-separated ('18\|23\|30\|21'); null for external games. |
| away_score_by_period | character | Away points per period, pipe-separated ('29\|26\|27\|22'); null for external games. |
| tickets_url | character | Ticketing URL; null when none. |
| external_id | character | The wire's ExternalID: the Segev game id (a string) for league games from 2025-26, a news URL for pre-season games, null before 2025-26. |
| segev_game_id | integer | external_id read as an integer Segev game id (digits only), else null; joins ibba_segev\_\* game_id. Derived by the parser. |
| is_external | logical | True when board_id \>= 1001 (an external competition, whose team ids are not team-seasons). Derived by the parser. |

## Details

The IBBA wrappers read the Israel Basketball Association's ASP.NET web
service at `basket.co.il/ws/ws.asmx` (the ops its own site calls):
seasons, boards, teams, rosters, coaches, schedules and results, box
scores from 2004-05, season stats and leaders of the Winner League
(Israeli Premier League). They mirror sdv-py's
`sportsdataverse.basketball.ibba` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per sdv-py
row. The live box score, play-by-play and shot coordinates of a game are
in the
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md)
family (Segev Stats).

**Unofficial and unsupported.** The web service is keyless, unofficial
and reverse engineered. Requests are spaced at least one second apart
per host (429 / 502 / 503 / 504 are retried three times; an HTTP 500 is
the host's deterministic error page, a stack trace, and is not retried);
keep crawls slow and incremental. Contact details (e-mail, phone, fax)
and coaches' dates of birth are dropped.

**Seasons and ids.** `season` is the END year and the host's own `cYear`
(2026 = 2025-26): it is sent unchanged. `team_id` and `player_id` are
per-SEASON registrations (Maccabi Tel Aviv = team 1109 in 2025-26, 2111
in 2026-27); the host has no cross-season person id (the stable player
key is the Segev player id of the `ibba_segev_*()` family). `team_uid`
is the stable club id (Maccabi = 10). A `0` means "all" where an
argument says so; every parameter of an op is always sent.

**Coverage.** League box scores from 2004-05 (`season = 2005`).
`external_id` and `segev_game_id` exist only from 2025-26 (earlier games
carry no Segev id, so `segev_game_id` is `NA`). The women's league and
Liga Leumit are NOT on this host. Every value on the wire is a string
and Hebrew text is HTML-entity encoded: ids, counts and dates are cast
and text is unescaped.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (HTTP 404, an empty body, which is what an unknown id
answers, or an empty row list), `hoopR_bad_request` (HTTP 400 / 422, or
an argument that is not a non-negative integer, a boolean or a non-empty
string as the op needs) and `hoopR_asset_fetch` (any other failure:
another status, a transport error, a body that is not JSON, an error or
changed envelope, a row for another season, team, player, board or game,
or a box score of a game that is not final). All inherit `hoopR_error`.

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
[`ibba_games_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_games_ex.md),
[`ibba_leaders()`](https://hoopR.sportsdataverse.org/reference/ibba_leaders.md),
[`ibba_player()`](https://hoopR.sportsdataverse.org/reference/ibba_player.md),
[`ibba_player_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_player_stats.md),
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)

## Examples

``` r
# \donttest{
  try(ibba_games(board_id = 5, board_round = 1, season = 2026))
#> ── IBBA games ─────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:16:24 UTC
#> # A tibble: 7 × 30
#>   game_id game_date  season home_team_id away_team_id home_team_he  away_team_he
#>     <int> <date>      <int>        <int>        <int> <chr>         <chr>       
#> 1   26391 2025-10-12   2026         1110         1114 "הפועל IBI ת… עירוני לאטי…
#> 2   26392 2025-10-12   2026         1120         1109 "הפועל אלטשו… מכבי Rapyd …
#> 3   26394 2025-10-12   2026         1119         1122 "הפועל Rivul… הפועל גילת …
#> 4   26393 2025-10-12   2026         1112         1116 "הפועל מידטא… עירוני חי מ…
#> 5   26390 2025-10-12   2026         1111         1123 "מכבי קבוצת … מכבי תפוזינ…
#> 6   26395 2025-10-13   2026         1124         2109 "מכבי אב־גד … אליצור נתניה
#> 7   26389 2025-12-24   2026         1118         1113 "בני Penlink… הפועל נתנאל…
#> # ℹ 23 more variables: home_team <chr>, away_team <chr>, home_logo_url <chr>,
#> #   away_logo_url <chr>, home_score <int>, away_score <int>, board_id <int>,
#> #   board_name_he <chr>, board_name <chr>, round <int>, tip_off <chr>,
#> #   venue_he <chr>, venue <chr>, referees_he <chr>, attendance <int>,
#> #   overtime <lgl>, overtimes <int>, home_score_by_period <chr>,
#> #   away_score_by_period <chr>, tickets_url <chr>, external_id <chr>,
#> #   segev_game_id <int>, is_external <lgl>
# }
```
