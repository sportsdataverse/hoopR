# **Get CEBL Player Leaders**

Top five players per requested statistic (long frame, one row per
statistic and leader).

Endpoint: `GET https://api.data.cebl.ca/players/statistics/leaders/`

## Usage

``` r
cebl_player_leaders(
  statistics = "POINTS,REBOUNDS,ASSISTS,TARGET_SCORES",
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  team_id = NULL
)
```

## Arguments

- statistics:

  (default `"POINTS,REBOUNDS,ASSISTS,TARGET_SCORES"`) Comma-separated
  statistic names; the frame has one block per name. Names the Stats Hub
  sends: POINTS, REBOUNDS, ASSISTS, BLOCKS, STEALS, TARGET_SCORES,
  FIELD_GOAL_PERCENTAGE, THREE_POINTS_MADE, THREE_POINT_PERCENTAGE,
  FREE_THROW_PERCENTAGE, FOULS, TURNOVERS, MINUTES.

- mode:

  (default `"PER_GAME"`) TOTALS (sums over the selected games) or
  PER_GAME (per-game averages); the API requires one.

- season:

  (default `NULL`) Season: the calendar year (May to August) = the sdv
  END year. `NULL` = every season combined (the Stats Hub's All-Time).
  An unknown year answers `hoopR_no_data`.

- competition:

  (default `NULL`) REGULAR (regular season) or FINALS (the playoffs).
  `NULL` = both.

- team_id:

  (default `NULL`) CEBL team id (`team_id` in cebl_teams): limits the
  rows to that team; the rows echo it.

## Value

A `hoopR_data` tibble: Top five players per requested statistic (long
frame, one row per statistic and leader). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`cebl_player_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| statistic | character | Statistic this leader row ranks, the body's key for the list: POINTS, REBOUNDS, ASSISTS, TARGET_SCORES and the other names the request asked for. |
| ranking | integer | Rank in this statistic, 1 = best; ties share a rank and skip the next (1, 1, 1, 4). The list is the top 5 rows, no more. |
| season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
| mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
| competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
| player_id | integer | CEBL player id (its own key space). Joins /players/{player_id}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
| full_name | character | Player's full name. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
| team_name_en | character | Full English name of the player's team. |
| team_short_name_en | character | Short English name (city) of the player's team. |
| team_name_fr | character | Full French name of the player's team. |
| team_short_name_fr | character | Short French name (city) of the player's team. |
| team_abbreviated_name | character | Three-letter code of the player's team ('OTT', 'VAN'). |
| team_logo_url | character | Logo URL (icon with the name) of the player's team. |
| value | double | The player's figure for the statistic this list is keyed by, in the requested mode (TOTALS sum or PER_GAME average; percentages 0-100). A decimal string ('25.9'). |
| photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |

## Details

- CEBL own API, owner-approved gray area: these wrappers read the
  league's own FastAPI service (api.data.cebl.ca, the backend of the
  CEBL Stats Hub) with the X-Api-Key that the hub's own page bundle
  ships to every browser. The key is not issued to third parties and no
  developer terms were found; cebl.ca's terms of use were not reviewed.
  The runtime reads the key from the bundle at run time, falls back to a
  documented constant, never prints it, and raises `hoopR_asset_fetch`
  with a 'key rotated?' hint on a persistent 401. www.cebl.ca/robots.txt
  disallows nothing. Payloads are not redistributed as release assets;
  requests are spaced at least 1 s apart.

- Season is the calendar year (May to August) = the sdv END year: no
  mapping. The first season is 2019. An unknown season, team or player
  answers an empty list, which the runtime raises as `hoopR_no_data`.
  Ids are CEBL's own; a relocated franchise has two team ids (cebl_teams
  lists all 15).

- This API has no box-score, play-by-play or shot route. They live in
  Genius LiveStats (organisation CEBL, see the genius family):
  cebl_games and cebl_player_gamelog carry the Genius match id as
  genius_match_id, parsed from the stats URLs (derived, not fetched; the
  match of a cancelled game may have no data). home_team_id is Genius
  team 1 and away_team_id team 2 (checked on match 2600563).

- Some completed schedule rows have null scores (2026), and a cancelled
  game has status CANELLED (the API's spelling) with null or zero
  scores. The schedule lists unplayed games too, so no wrapper refuses
  an unfinished game. Aggregates are decimal strings upstream and double
  here. Players' names, nationality and birth date are the public bio;
  no contact data is served.

- Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty
  list, an all-null profile: an unknown season, team or player),
  `hoopR_bad_request` (a bad argument, HTTP 400 / 422) and
  `hoopR_asset_fetch` (a key the API still refuses after one re-read,
  any other non-200, a non-JSON body, an error envelope, a body for
  another season, team or player), all inheriting `hoopR_error`. HTTP
  500 is the API's answer to a bad id and is not retried. Wrappers
  raise; they never return an empty frame.

- Deliberate divergence: a string column that the API sends as an
  object, or a list of objects, carries compact JSON here
  (`{"name":"TSN"}`), where sdv-py's String cast writes Python's
  `str(dict)` repr (`{'name': 'TSN'}`). No string column of the
  committed fixtures carries an object.

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_player_leaders(mode = "PER_GAME", season = 2025))
#> ── CEBL Player Leaders from the CEBL Stats API ───────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:35:46 UTC
#> # A tibble: 20 × 16
#>    statistic     ranking season mode     competition player_id full_name team_id
#>    <chr>           <int>  <int> <chr>    <chr>           <int> <chr>       <int>
#>  1 POINTS              1   2025 PER_GAME NA             570965 Javonte …      20
#>  2 POINTS              2   2025 PER_GAME NA             193258 Mitch Cr…      16
#>  3 POINTS              3   2025 PER_GAME NA              16918 Donovan …      22
#>  4 POINTS              4   2025 PER_GAME NA             410504 Sean Eas…      18
#>  5 POINTS              5   2025 PER_GAME NA             570771 Terquavi…      22
#>  6 REBOUNDS            1   2025 PER_GAME NA              36982 Isaih Mo…      20
#>  7 REBOUNDS            2   2025 PER_GAME NA                111 Simi Shi…      24
#>  8 REBOUNDS            3   2025 PER_GAME NA             406695 Tyrese S…      16
#>  9 REBOUNDS            4   2025 PER_GAME NA             180348 Jaden Be…      15
#> 10 REBOUNDS            5   2025 PER_GAME NA             406002 Greg Bro…      17
#> 11 ASSISTS             1   2025 PER_GAME NA             404887 Nate Pie…      15
#> 12 ASSISTS             2   2025 PER_GAME NA              16080 Corey Da…      16
#> 13 ASSISTS             3   2025 PER_GAME NA                 44 Deng Adel      20
#> 14 ASSISTS             4   2025 PER_GAME NA                  7 Cat Barb…      22
#> 15 ASSISTS             5   2025 PER_GAME NA             501763 Tavian D…      21
#> 16 TARGET_SCORES       1   2025 PER_GAME NA             406695 Tyrese S…      16
#> 17 TARGET_SCORES       2   2025 PER_GAME NA                102 Sean Mil…      17
#> 18 TARGET_SCORES       3   2025 PER_GAME NA                155 Khalil A…      14
#> 19 TARGET_SCORES       4   2025 PER_GAME NA                  8 Jalen Ha…      24
#> 20 TARGET_SCORES       5   2025 PER_GAME NA             638406 Evan Gil…      17
#> # ℹ 8 more variables: team_name_en <chr>, team_short_name_en <chr>,
#> #   team_name_fr <chr>, team_short_name_fr <chr>, team_abbreviated_name <chr>,
#> #   team_logo_url <chr>, value <dbl>, photo_url <chr>
# }
```
