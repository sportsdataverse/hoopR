# **Get TPBL Standings**

League table of one division: rank, record, games behind and streak.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/games/standings`

## Usage

``` r
tpbl_standings(division_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

## Value

A `hoopR_data` tibble: League table of one division: rank, record, games
behind and streak. An empty answer raises `hoopR_no_data`; the columns
are always these, in this order (sportsdataverse-py `tpbl_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| rank | integer | Rank in the division, 1-based. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
| gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| alt_name | character | Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
| won | integer | Games won in the division so far. |
| lost | integer | Games lost in the division so far. |
| drawn | integer | Games drawn (always 0 in basketball). |
| games_behind | double | Games behind the leader (0 for the leader); a whole number in every captured division, read as a float so half games cannot break the dtype. |
| streak | character | Current streak: 'W' + count for wins, 'L' + count for losses (W2 = two straight wins). |

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
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)

## Examples

``` r
# \donttest{
  try(tpbl_standings(division_id = 2))
#> ── TPBL Standings from api.tpbl.basketball ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:35:11 UTC
#> # A tibble: 7 × 12
#>   division_id  rank team_id gohoops_team_id gohoops_squad_id team       alt_name
#>         <int> <int>   <int>           <int>            <int> <chr>      <chr>   
#> 1           2     1       7             945             8214 新北國王   kings   
#> 2           2     2       3             941             8210 福爾摩沙夢想家…… dreamers
#> 3           2     3       2             940             8209 高雄全家海神…… aquas   
#> 4           2     4       8             946             8215 臺北台新戰神…… mars    
#> 5           2     5       5             943             8212 桃園台啤永豐雲豹…… leopards
#> 6           2     6       6             944             8213 新北中信特攻…… dea     
#> 7           2     7       4             942             8211 新竹御嵿攻城獅…… lioneers
#> # ℹ 5 more variables: won <int>, lost <int>, drawn <int>, games_behind <dbl>,
#> #   streak <chr>
# }
```
