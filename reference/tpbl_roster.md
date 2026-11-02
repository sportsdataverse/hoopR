# **Get TPBL Roster**

The registered roster of one team in one division (birth dates omitted).

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/teams/{team_id}/players`

## Usage

``` r
tpbl_roster(division_id, team_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- team_id:

  Required. TPBL team id (the franchise, 2-8, stable across seasons);
  `team_id` in tpbl_teams. Not the GoHoops id.

## Value

A `hoopR_data` tibble: The registered roster of one team in one division
(birth dates omitted). An empty answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`tpbl_roster`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
| gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
| gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). The key of the box score players: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
| gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. |
| gohoops_season_id | integer | GoHoops season id (key space: GoHoops seasons, the id system the API echoes beside its own; 101 = 2024-25, 213 = 2025-26, 275 = 2026-27). Not the TPBL season id. |
| player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
| alt_name | character | Romanized name (e.g. 'Chian Kuang-Chien'); ” when none. |
| number | character | Jersey number as text (so '0' and '00' stay distinct). |
| position | character | Playing position as a PascalCase enum: PointGuard, ShootingGuard, SmallForward, PowerForward, Center, and the combinations PointGuardAndShootingGuard, ShootingGuardAndSmallForward, SmallForwardAndPowerForward and PowerForwardAndCenter; ” when unset. |
| height_cm | integer | Height in centimetres. |
| weight_kg | double | Weight in kilograms (a number; fractions possible). |
| nationality | character | Nationality text: 'Local' for a Taiwan-born player, ” when unset. |
| national_identity | character | Player category: 'Local' (Taiwanese), ” when unset (foreign and naturalized categories use other strings). |
| national_identity_detail | character | Free-text detail on the category; ” in every sample. |
| registered | logical | True when the player is registered with the squad. |
| is_listing | logical | True when the player is shown on the team's public roster page. |

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
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)

## Examples

``` r
# \donttest{
  try(tpbl_roster(division_id = 2, team_id = 4))
#> ── TPBL Roster from api.tpbl.basketball ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:57:39 UTC
#> # A tibble: 13 × 20
#>    division_id team_id team        player_id gohoops_person_id gohoops_roster_id
#>          <int>   <int> <chr>           <int>             <int>             <int>
#>  1           2       4 新竹御嵿攻城獅……        71             70828            126991
#>  2           2       4 新竹御嵿攻城獅……        75             70832            126997
#>  3           2       4 新竹御嵿攻城獅……        76             70833            126998
#>  4           2       4 新竹御嵿攻城獅……        78             70835            127000
#>  5           2       4 新竹御嵿攻城獅……        82             70839            127005
#>  6           2       4 新竹御嵿攻城獅……        87             70845            127011
#>  7           2       4 新竹御嵿攻城獅……        88             70846            127013
#>  8           2       4 新竹御嵿攻城獅……        93             70851            127019
#>  9           2       4 新竹御嵿攻城獅……        96             70854            127023
#> 10           2       4 新竹御嵿攻城獅……       100             70859            127030
#> 11           2       4 新竹御嵿攻城獅……      4182             79430            144851
#> 12           2       4 新竹御嵿攻城獅……      7894             80361            148576
#> 13           2       4 新竹御嵿攻城獅……      9034             82278            150660
#> # ℹ 14 more variables: gohoops_squad_id <int>, gohoops_event_id <int>,
#> #   gohoops_season_id <int>, player <chr>, alt_name <chr>, number <chr>,
#> #   position <chr>, height_cm <int>, weight_kg <dbl>, nationality <chr>,
#> #   national_identity <chr>, national_identity_detail <chr>, registered <lgl>,
#> #   is_listing <lgl>
# }
```
