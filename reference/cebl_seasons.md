# **Get CEBL Seasons**

Every CEBL season (2019 on), with the active and live flags.

Endpoint: `GET https://api.data.cebl.ca/seasons/`

## Usage

``` r
cebl_seasons()
```

## Value

A `hoopR_data` tibble: Every CEBL season (2019 on), with the active and
live flags. An empty valid answer raises `hoopR_no_data`; the columns
are always these, in this order (sdv-py `cebl_seasons`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season_id | integer | CEBL season row id (1 = 2019 ... 8 = 2026). No route takes it: routes take `year`. |
| season | integer | Season: the calendar year it is played in (May-August) = the sdv END year. The key every route's `season` param takes. |
| is_active | logical | True for the current season (one row: 2026 on 2026-10-12). |
| is_live | logical | True while the current season is in progress or open for live data (true for 2026 on 2026-10-12, after its last game: the exact meaning is unverified). |

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
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_seasons())
#> ── CEBL Seasons from the CEBL Stats API ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:13:39 UTC
#> # A tibble: 8 × 4
#>   season_id season is_active is_live
#>       <int>  <int> <lgl>     <lgl>  
#> 1         1   2019 FALSE     FALSE  
#> 2         2   2020 FALSE     FALSE  
#> 3         3   2021 FALSE     FALSE  
#> 4         4   2022 FALSE     FALSE  
#> 5         5   2023 FALSE     FALSE  
#> 6         6   2024 FALSE     FALSE  
#> 7         7   2025 FALSE     FALSE  
#> 8         8   2026 TRUE      TRUE   
# }
```
