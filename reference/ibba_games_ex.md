# **IBBA External Games**

**A club's games of a season in external competitions (BoardsEx boards:
European cups, pre-season).**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/GamesEx`

## Usage

``` r
ibba_games_ex(team_uid, season, board_id = 0)
```

## Arguments

- team_uid:

  (*integer* required): IBBA club id, stable across seasons (Maccabi Tel
  Aviv = 10; `team_uid` in ibba_teams). Use 0 for all clubs only where
  the route says so.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `0`): External board id from ibba_boards_ex (1001
  EuroLeague, 1003 Champions League, ...); 0 (default) for all.

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
| home_logo_url | character | Absolute URL of the home team logo. |
| away_logo_url | character | Absolute URL of the away team logo. |
| home_score | integer | Home final score; 0 before the game is played. |
| away_score | integer | Away final score; 0 before the game is played. |
| board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
| board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
| round | integer | Round (game number) within the board; null for external games. |
| tip_off | character | Tip-off 'HH:MM', local Israel time, as text; null in 2004-05. It can disagree with Segev (game 26646: 20:15 here, 19:30 in Segev). |
| venue_he | character | Venue in Hebrew, HTML-unescaped; null in 2004-05. |

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

Other IBBA:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
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
  try(ibba_games_ex(season = 2026, team_uid = 10))
#> ── IBBA games ex ─────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:41:08 UTC
#> # A tibble: 45 × 16
#>    game_id game_date  season home_team_id away_team_id home_team_he away_team_he
#>      <int> <date>      <int>        <int>        <int> <chr>        <chr>       
#>  1    8888 2025-09-07   2026          120          119 "מכבי ת\"א"  "בני הרצליה"
#>  2    9895 2025-09-12   2026          120          252 "מכבי ת\"א"  "זניט"      
#>  3    9896 2025-09-13   2026          120          240 "מכבי ת\"א"  "פרטיזן בלג…
#>  4    9897 2025-09-17   2026          120          266 "מכבי ת\"א"  "מכבי רעננה"
#>  5    7886 2025-09-30   2026          172          120 "אנאדולו אפ… "מכבי ת\"א" 
#>  6    7888 2025-10-03   2026          120          304 "מכבי ת\"א"  "פריז"      
#>  7    7891 2025-10-08   2026          127          120 "הפועל ת\"א" "מכבי ת\"א" 
#>  8    7894 2025-10-14   2026          120          163 "מכבי ת\"א"  "ברצלונה"   
#>  9    7898 2025-10-16   2026          120          135 "מכבי ת\"א"  "אולימפיאקו…
#> 10    7902 2025-10-22   2026          120          166 "מכבי ת\"א"  "ריאל מדריד"
#> # ℹ 35 more rows
#> # ℹ 9 more variables: home_logo_url <chr>, away_logo_url <chr>,
#> #   home_score <int>, away_score <int>, board_id <int>, board_name_he <chr>,
#> #   round <int>, tip_off <chr>, venue_he <chr>
# }
```
