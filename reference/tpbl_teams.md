# **Get TPBL Teams**

The teams of one season (bracket placeholders flagged).

Endpoint: `GET https://api.tpbl.basketball/api/events/{season}/teams`

## Usage

``` r
tpbl_teams(season)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season; 2025 is the
  first). The API keys a season by its own small integer (1, 2, 3 =
  2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the
  same number): the runtime reads /seasons once and sends that id, so
  the example URL shows the year. A year the list lacks raises
  `hoopR_no_data`.

## Value

A `hoopR_data` tibble: The teams of one season (bracket placeholders
flagged). An empty answer raises `hoopR_no_data`; the columns are always
these, in this order (sportsdataverse-py `tpbl_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
| season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
| name | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| is_real_team | logical | True for a real club; false for a bracket placeholder (67 higher-seed team, 68 lower-seed team in 2025-26). |
| status | character | Team status. 'ACTIVE' is the only value seen in every sampled route; the full set of statuses is unknown. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md),
[`tpbl_box_team_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_team_periods.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_divisions()`](https://hoopR.sportsdataverse.org/reference/tpbl_divisions.md),
[`tpbl_game()`](https://hoopR.sportsdataverse.org/reference/tpbl_game.md),
[`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md),
[`tpbl_player_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_games.md),
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md)

## Examples

``` r
# \donttest{
  try(tpbl_teams(season = 2026))
#> ── TPBL Teams from api.tpbl.basketball ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:35:12 UTC
#> # A tibble: 9 × 7
#>   season season_id team_id gohoops_team_id name             is_real_team status
#>    <int>     <int>   <int>           <int> <chr>            <lgl>        <chr> 
#> 1   2026         2       8             946 臺北台新戰神     TRUE         ACTIVE
#> 2   2026         2       7             945 新北國王         TRUE         ACTIVE
#> 3   2026         2       6             944 新北中信特攻     TRUE         ACTIVE
#> 4   2026         2       5             943 桃園台啤永豐雲豹 TRUE         ACTIVE
#> 5   2026         2       4             942 新竹御嵿攻城獅   TRUE         ACTIVE
#> 6   2026         2       3             941 福爾摩沙夢想家   TRUE         ACTIVE
#> 7   2026         2       2             940 高雄全家海神     TRUE         ACTIVE
#> 8   2026         2      67            2054 高順位隊伍       FALSE        ACTIVE
#> 9   2026         2      68            2055 低順位隊伍       FALSE        ACTIVE
# }
```
