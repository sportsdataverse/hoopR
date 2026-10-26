# **Get CEBL Teams**

Every franchise identity, past and present (15 team ids; a relocated
franchise has a second id).

Endpoint: `GET https://api.data.cebl.ca/teams/`

## Usage

``` r
cebl_teams()
```

## Value

A `hoopR_data` tibble: Every franchise identity, past and present (15
team ids; a relocated franchise has a second id). An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `cebl_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
| name_en | character | Team full name in English ('Niagara River Lions'). |
| short_name_en | character | Team short name in English, usually the city ('Niagara'). |
| name_fr | character | Team full name in French ('River Lions de Niagara'). |
| short_name_fr | character | Team short name in French, usually the city. |
| is_active | logical | True for a team in the current league; false for a former identity (Guelph Nighthawks, Hamilton Honey Badgers, Fraser Valley Bandits, Saskatchewan Rattlers, Newfoundland Growlers). |
| logo_url | character | Team logo URL (icon with the team name; upstream: 'Should include the icon and team name'). |
| icon_url | character | Team icon URL (upstream: 'Should not include the team name'). |

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
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md)

## Examples

``` r
# \donttest{
  try(cebl_teams())
#> ── CEBL Teams from the CEBL Stats API ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:13:41 UTC
#> # A tibble: 15 × 8
#>    team_id name_en        short_name_en name_fr short_name_fr is_active logo_url
#>      <int> <chr>          <chr>         <chr>   <chr>         <lgl>     <chr>   
#>  1      16 Vancouver Ban… Vancouver     Les Ba… Vancouver     TRUE      https:/…
#>  2      22 Scarborough S… Scarborough   Shooti… Scarborough   TRUE      https:/…
#>  3      23 Newfoundland … Newfoundland  Growle… Terre-Neuve   FALSE     https:/…
#>  4      14 Niagara River… Niagara       River … Niagara       TRUE      https:/…
#>  5      54 Fraser Valley… Fraser Valley Les Ba… Fraser Valley FALSE     https:/…
#>  6      18 Edmonton Stin… Edmonton      Stinge… Edmonton      TRUE      https:/…
#>  7      15 Saskatchewan … Saskatchewan  Rattle… Saskatchewan  FALSE     https:/…
#>  8      53 Guelph Nighth… Guelph        Les Ni… Guelph        FALSE     https:/…
#>  9      55 Hamilton Hone… Hamilton      Honey … Hamilton      FALSE     https:/…
#> 10      21 Montreal Alli… Montreal      Allian… Montréal      TRUE      https:/…
#> 11      20 Ottawa BlackJ… Ottawa        BlackJ… Ottawa        TRUE      https:/…
#> 12      17 Calgary Surge  Calgary       Surge … Calgary       TRUE      https:/…
#> 13      19 Brampton Hone… Brampton      Honey … Brampton      TRUE      https:/…
#> 14      56 Saskatoon Mam… Saskatoon     Saskat… Saskatoon     TRUE      https:/…
#> 15      24 Winnipeg Sea … Winnipeg      Sea Be… Winnipeg      TRUE      https:/…
#> # ℹ 1 more variable: icon_url <chr>
# }
```
