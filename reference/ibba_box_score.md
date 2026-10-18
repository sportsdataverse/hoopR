# **IBBA Box Score**

**Box score of a finished game: player lines, a team-credited line per
side and the TOTAL line per side.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Boxscore`

## Usage

``` r
ibba_box_score(game_id, season)
```

## Arguments

- game_id:

  (*integer* required): IBBA game id (e.g. 26392): `game_id` in
  ibba_games.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
| jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '\_TEAM' and 'TOTAL' for its two non-player lines. |
| team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
| game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig\_ space, e.g. 8888 for a pre-season game). |
| board_id | integer | Board id of the game (5 = league). |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| round | integer | Round (game number) of the game within its board. |
| starter | logical | True when the player started the game. |
| minutes | integer | Minutes played, whole minutes; a TOTAL line holds the team's player-minutes (200 plus 25 per overtime). |
| pts | integer | Points scored by the player or team (free throws included). |
| fg2m | integer | Two-point field goals made. |
| fg2a | integer | Two-point field goals attempted (verified equal to Segev made + missed). |
| fg2_pct | double | Two-point field-goal percentage, 0-100. |
| fg3m | integer | Three-point field goals made. |
| fg3a | integer | Three-point field goals attempted. |
| fg3_pct | double | Three-point field-goal percentage, 0-100. |
| ftm | integer | Free throws made. |
| fta | integer | Free throws attempted. |
| ft_pct | double | Free-throw percentage, 0-100. |
| dreb | integer | Defensive rebounds. |
| oreb | integer | Offensive rebounds. |
| reb | integer | Total rebounds. |
| fouls_drawn | integer | Fouls DRAWN: fouls opponents committed against the player or team (the wire's fouls_against; verified equal to Segev f_drawn). |
| fouls | integer | Fouls COMMITTED by the player or team (the wire's fouls_for; verified equal to Segev f). |
| steals | integer | Steals made by the player or team. |
| turnovers | integer | Turnovers (the wire's misspelt tournovers). |
| assists | integer | Assists credited to the player or team. |
| blocks | integer | Shots the player or team blocked. |
| blocks_against | integer | Own shots that were blocked. |
| val | integer | Efficiency rating (valuation; verified equal to Segev rate); -1 on 2004-05 team-credited lines. |
| plus_minus | integer | Plus-minus; 0 on every line of the 2004-05 sample (not recorded then, inferred). |
| dunks | integer | Dunks made by the player or team. |
| row_type | character | Kind of box line: player, team (actions credited to the team: team rebounds and turnovers) or total (the team's TOTAL line, equal to players plus team lines). |

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
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
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
  try(ibba_box_score(game_id = 26392, season = 2026))
#> ── IBBA box score ────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:24:17 UTC
#> # A tibble: 27 × 33
#>    player_id jersey team_id game_id board_id season round starter minutes   pts
#>        <int> <chr>    <int>   <int>    <int>  <int> <int> <lgl>     <int> <int>
#>  1        NA _TEAM     1109   26392        5   2026     1 FALSE         0     0
#>  2     21917 02        1109   26392        5   2026     1 FALSE        21     8
#>  3     21903 03        1109   26392        5   2026     1 FALSE        21    17
#>  4     21911 04        1109   26392        5   2026     1 TRUE         18     2
#>  5     24797 07        1109   26392        5   2026     1 FALSE         1     0
#>  6     21906 08        1109   26392        5   2026     1 TRUE         18     6
#>  7     21913 09        1109   26392        5   2026     1 TRUE         18     9
#>  8     21901 10        1109   26392        5   2026     1 TRUE         16    11
#>  9     21919 11        1109   26392        5   2026     1 FALSE        11     0
#> 10     21915 12        1109   26392        5   2026     1 FALSE        23    18
#> # ℹ 17 more rows
#> # ℹ 23 more variables: fg2m <int>, fg2a <int>, fg2_pct <dbl>, fg3m <int>,
#> #   fg3a <int>, fg3_pct <dbl>, ftm <int>, fta <int>, ft_pct <dbl>, dreb <int>,
#> #   oreb <int>, reb <int>, fouls_drawn <int>, fouls <int>, steals <int>,
#> #   turnovers <int>, assists <int>, blocks <int>, blocks_against <int>,
#> #   val <int>, plus_minus <int>, dunks <int>, row_type <chr>
# }
```
