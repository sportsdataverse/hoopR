# **IBBA Leaders**

**The top five players of a season in one stat category, for all teams
or one team.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/LeaderByType`

## Usage

``` r
ibba_leaders(stat_type, season, team_id = 0)
```

## Arguments

- stat_type:

  (*character* required): Stat category code from ibba_stats_types: VAL,
  pts, isr_pts, plusminus, dunk, ASS, TR, `[OR]`, DR, isr_TR, ST,
  `[TO]`, ASSTO, BKF, FF, `[min]`, p2, p3, p1, p32T, p22T, p12T, PTSMIN,
  TRMIN, ASSMIN.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- team_id:

  (*integer*, default `0`): Team-season id to restrict the list to one
  team; 0 (default) for all teams.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| value | double | The leader's value in the requested category (per-game average, percentage or count). |
| games | integer | Games the leader played. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_id | integer | Team-season id of the leader's team. |
| jersey | character | The leader's jersey number as a zero-padded string. |
| player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
| player_name_he | character | Player name in Hebrew, HTML-unescaped. |
| photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |

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
[`ibba_games_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_games_ex.md),
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
  try(ibba_leaders(season = 2026, stat_type = pts))
#> Error in eval(expr, envir) : object 'pts' not found
# }
```
