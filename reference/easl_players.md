# **Get EASL Players**

Every EASL player of all seasons; with season and team_id a roster that
adds jersey number and position.

Endpoint: `GET https://easl.joshricha.com/api/v1/players`

## Usage

``` r
easl_players(season = NULL, team_id = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: no season filter.

- team_id:

  DataCore team (entity) UUID v1, e.g.
  '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the team_id
  of easl_teams, easl_standings and the box scores. easl_team resolves
  the 12 historical teams easl_teams does not list. Needs season for a
  roster (jersey number and position). Default `NULL`: no team filter.

## Value

A `hoopR_data` tibble: Every EASL player of all seasons; with season and
team_id a roster that adds jersey number and position. An empty answer
raises `hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `easl_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year of the filter, from the request; null when no season was passed. |
| season_id | character | DataCore season UUID v1 of the filter; null when no season was passed. |
| player_row_id | integer | The sync server's own integer row id of the player (not a DataCore id). |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
| name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
| name_abbreviated | character | Abbreviated name; null for 551 of 552 players (one empty string). |
| nationality | character | ISO 3166-1 alpha-3 code of the player's nationality; 36 codes occur, KOR 119, USA 102, JPN 81, PHL 80, TWN 61, CHN 22, MNG 16, HKG 15, MAC 13 ('PHI' also appears once, a non-ISO spelling of PHL). |
| gender | character | MALE on all 552 rows. |
| dob | Date | Date of birth, 'YYYY-MM-DD' (a public biography field; 1980-10-05 to 2023-10-16 in the data, so the latest values are implausible); 5 players have none. Null on some rows. |
| height_cm | integer | Height in centimetres; 43 of 552 players have none. Null on some rows. |
| height_feet | character | Height in feet and inches as a string (6'9); null for most players. |
| weight_kg | integer | Weight in kilograms; many players have none. Null on some rows. |
| weight_lbs | integer | Weight in pounds; null for many players. |
| status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
| jersey_number | character | Jersey number as a string. Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
| position | character | Playing position (G, F, C, PG, SG, SF, PF, GF). Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
| organization_id | character | DataCore organisation id: b1e0z (EASL). |
| created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
| updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_players(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#> ── EASL Players from easl.joshricha.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:39:16 UTC
#> # A tibble: 17 × 20
#>    season season_id    player_row_id player_id name  name_latin name_abbreviated
#>     <int> <chr>                <int> <chr>     <chr> <chr>      <chr>           
#>  1   2026 77441bb3-97…            51 2c03440a… Just… Justin HA… NA              
#>  2   2026 77441bb3-97…            55 2e016dfa… ISHI… ISHIKAWA … NA              
#>  3   2026 77441bb3-97…           105 57598895… HOSH… HOSHIKAWA… NA              
#>  4   2026 77441bb3-97…           164 85c99dab… D.J.… D.J. NEWB… NA              
#>  5   2026 77441bb3-97…           216 897d9aab… TABU… TABUSE Yu… NA              
#>  6   2026 77441bb3-97…           217 8983317f… HIEJ… HIEJIMA M… NA              
#>  7   2026 77441bb3-97…           218 8984fe11… OGAW… OGAWA Ats… NA              
#>  8   2026 77441bb3-97…           219 8986bf47… ENDO… ENDO Yusu… NA              
#>  9   2026 77441bb3-97…           220 89889819… TAKE… TAKEUCHI … NA              
#> 10   2026 77441bb3-97…           221 8a4180f3… TAKA… TAKASHIMA… NA              
#> 11   2026 77441bb3-97…           222 8a44d984… WATA… WATANABE … NA              
#> 12   2026 77441bb3-97…           223 8a4b82f4… IKAR… IKARUGA S… NA              
#> 13   2026 77441bb3-97…           224 8a4f5e97… Gran… Grant JER… NA              
#> 14   2026 77441bb3-97…           225 8a530bfe… Isaa… Isaac FOTU NA              
#> 15   2026 77441bb3-97…           388 e670b5bc… Gavi… Gavin EDW… NA              
#> 16   2026 77441bb3-97…           409 f8a930cf… Blak… Blake AOKI NA              
#> 17   2026 77441bb3-97…           424 177cdc17… MATS… NA         NA              
#> # ℹ 13 more variables: nationality <chr>, gender <chr>, dob <date>,
#> #   height_cm <int>, height_feet <chr>, weight_kg <int>, weight_lbs <int>,
#> #   status <chr>, jersey_number <chr>, position <chr>, organization_id <chr>,
#> #   created_at <chr>, updated_at <chr>
# }
```
