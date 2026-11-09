# **Get Basketligaen Layout Info (ssgt Directory)**

Directory of every ssgt (season + series + game type) with its teams,
and the stats modules.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/layout-info`

## Usage

``` r
sportality_layout_info()
```

## Value

A `hoopR_data` tibble: Directory of every ssgt (season + series + game
type) with its teams, and the stats modules. An empty valid answer
raises `hoopR_no_data`; the documented columns come first, in this order
(sportsdataverse-py `sportality_layout_info`), then any column the API
added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025/26). |
| season_code | character | Provider season code: the START year (2025 = 2025/26). |
| season_name | character | Season name as 'YYYY/YYYY' (start/end year). |
| game_type | character | Game type of the game (” on every line seen). |
| game_type_name | character | Game type name in Danish (Grundspil = regular season, Slutspil = playoffs). |
| series_code | character | Series code (DBL = Basketligaen). |
| ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
| state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `active` = current ssgt; `closed` = past ssgt. |
| season_uuid | character | Season uuid (platform key space). |
| series_uuid | character | Series uuid (platform key space). |
| game_type_uuid | character | Game type uuid (platform key space). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_layout_info()

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
