# **Get CEBL Player**

One player's profile and current team: name, nationality, birth date,
position, jersey.

Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/`

## Usage

``` r
cebl_player(player_id)
```

## Arguments

- player_id:

  (required) CEBL player id (global across seasons and teams), e.g.
  570965 (Javonte Smart); `player_id` in cebl_player_stats.

## Value

A `hoopR_data` tibble: One player's profile and current team: name,
nationality, birth date, position, jersey. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`cebl_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | CEBL player id (its own key space). Joins /players/{player_id}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
| full_name | character | Player's full name. |
| nationality | character | Nationality: an upper-case English country name ('CANADA', 'UNITED STATES', 'SOUTH SUDAN'); null when unknown. |
| birth_date | Date | Date of birth, YYYY-MM-DD (players' public bio field); null when unknown. |
| age | integer | Age in whole years on the day of the request (computed by the API); null when the birth date is unknown. |
| position | character | Playing position: G (guard), F (forward), C (center), or a combination such as 'C/F'; null when unknown. |
| jersey_number | character | Jersey number, as a string of up to 2 characters ('0', '00' and '1' are distinct); null when unknown. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The player's latest team. |
| team_name_en | character | Full English name of the player's team. |
| team_short_name_en | character | Short English name (city) of the player's team. |
| team_name_fr | character | Full French name of the player's team. |
| team_short_name_fr | character | Short French name (city) of the player's team. |
| team_icon_url | character | Icon URL (without the name) of the player's team. |
| team_stats_url_en | character | cebl.ca stats page of the player's team (English). |
| team_stats_url_fr | character | cebl.ca stats page of the player's team (French). |
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
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
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
  try(cebl_player(player_id = 570965))
#> ── CEBL Player from the CEBL Stats API ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:35:44 UTC
#> # A tibble: 1 × 16
#>   player_id full_name     nationality   birth_date   age position jersey_number
#>       <int> <chr>         <chr>         <date>     <int> <chr>    <chr>        
#> 1    570965 Javonte Smart UNITED STATES 1999-06-03    27 G        1            
#> # ℹ 9 more variables: team_id <int>, team_name_en <chr>,
#> #   team_short_name_en <chr>, team_name_fr <chr>, team_short_name_fr <chr>,
#> #   team_icon_url <chr>, team_stats_url_en <chr>, team_stats_url_fr <chr>,
#> #   photo_url <chr>
# }
```
