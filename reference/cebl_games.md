# **Get CEBL Games**

Schedule and results of one season (regular season and finals), with the
Genius match id that joins play-by-play and shots; optionally one team's
games.

Endpoint: `GET https://api.data.cebl.ca/games/{season}/`

## Usage

``` r
cebl_games(season, team_id = NULL)
```

## Arguments

- season:

  (required) Season: the calendar year it is played in (May to August) =
  the sdv END year (2025 = the 2025 season). The CEBL's first season
  is 2019. A season with no data answers `hoopR_no_data`.

- team_id:

  (default `NULL`) CEBL team id (`team_id` in cebl_teams): limits the
  rows to that team; the rows echo it.

## Value

A `hoopR_data` tibble: Schedule and results of one season (regular
season and finals), with the Genius match id that joins play-by-play and
shots; optionally one team's games. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`cebl_games`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season of the game: the year of start_time_utc (the calendar year = the sdv END year). |
| game_id | integer | CEBL game id (its own key space: 568 in 2019, 8 digits from 2025, e.g. 14708701). No route is keyed by it; the Genius match id is in `stats_url_en`. |
| genius_match_id | integer | Genius LiveStats match id parsed from the stats URL (the join to the genius family, organisation CEBL, where play-by-play and shots live). Derived from the URL, not fetched; null when the URL is absent. |
| start_time_utc | POSIXct | Scheduled tip-off, ISO 8601 in UTC ('2025-05-11T22:00:00Z'). |
| competition | character | REGULAR (regular season) or FINALS (playoffs). |
| status | character | Game status. Observed: COMPLETE (final) and CANELLED (sic: cancelled; 1 game in 2025, 2 in 2026). The Stats Hub also knows SCHEDULED, IN_PROGRESS, DELAYED and FINISHED. |
| period | integer | Last period played when the API sets it (seen only on a cancelled game, which carried period 3); null on a finished game. |
| venue_name | character | Arena name ('Edmonton EXPO Centre'). |
| home_team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The home team. |
| home_team_name | character | Home team full English name. |
| home_team_score | integer | Home team final score. On the 3 cancelled games: null, 0 or a partial score; before tip-off unobserved. |
| away_team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The away team. |
| away_team_name | character | Away team full English name. |
| away_team_score | integer | Away team final score. On the 3 cancelled games: null, 0 or a partial score; before tip-off unobserved. |
| home_team_logo_url | character | URL of the home team's logo image as the games feed lists it (a team-level asset, the same on every game of that team in the season). |
| home_team_stats_url_en | character | Home team's cebl.ca stats page (English). |
| home_team_stats_url_fr | character | Home team's cebl.ca stats page (French). |
| away_team_logo_url | character | URL of the away team's logo image as the games feed lists it (a team-level asset, the same on every game of that team in the season). |
| away_team_stats_url_en | character | Away team's cebl.ca stats page (English). |
| away_team_stats_url_fr | character | Away team's cebl.ca stats page (French). |
| stats_url_en | character | Genius LiveStats box-score page, `https://fibalivestats.dcd.shared.geniussports.com/u/CEBL/{matchId}/`. The segment after `/u/CEBL/` is the Genius match id: the join to genius-livestats/ (org CEBL), whose `data/{matchId}/data.json` holds the box score, play-by-play and shot chart. Only match 2600563 is banked there; the others are derived, and cancelled (CANELLED) games carry a filled-in URL whose `data.json` is unverified. |
| stats_url_fr | character | The same Genius LiveStats page in French (`.../u/CEBL/{matchId}/index_fr_FR.html`). |
| cebl_stats_url_en | character | The game page on cebl.ca, `https://www.cebl.ca/game?id={matchId}`: `id` is the Genius match id, not this row's `id`. |
| cebl_stats_url_fr | character | The French cebl.ca game page (`https://www.cebl.ca/fr-ca/game?id={matchId}`). |
| tickets_url_en | character | Ticket-sales page for the game (English). |
| tickets_url_fr | character | Ticket-sales page for the game (French). |
| broadcast_partner_logo_urls | character | Logo URLs of the game's broadcasters (TSN+, CEBL+, ...); 2 to 7 per game. |

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
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
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
  try(cebl_games(season = 2025))
#> ── CEBL Games from the CEBL Stats API ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:27:46 UTC
#> # A tibble: 128 × 27
#>    season  game_id genius_match_id start_time_utc      competition status period
#>     <int>    <int>           <int> <dttm>              <chr>       <chr>   <int>
#>  1   2025 14708701         2600563 2025-05-11 22:00:00 REGULAR     COMPL…     NA
#>  2   2025 14708702         2600564 2025-05-16 01:30:00 REGULAR     COMPL…     NA
#>  3   2025 14708703         2600565 2025-05-16 23:00:00 REGULAR     COMPL…     NA
#>  4   2025 14708704         2600566 2025-05-17 00:30:00 REGULAR     COMPL…     NA
#>  5   2025 14708705         2600567 2025-05-18 19:00:00 REGULAR     COMPL…     NA
#>  6   2025 14708706         2600568 2025-05-18 20:00:00 REGULAR     COMPL…     NA
#>  7   2025 14708707         2600569 2025-05-21 23:30:00 REGULAR     COMPL…     NA
#>  8   2025 14708708         2600570 2025-05-23 01:30:00 REGULAR     COMPL…     NA
#>  9   2025 14708709         2600571 2025-05-23 02:00:00 REGULAR     COMPL…     NA
#> 10   2025 14708711         2600573 2025-05-24 00:30:00 REGULAR     COMPL…     NA
#> # ℹ 118 more rows
#> # ℹ 20 more variables: venue_name <chr>, home_team_id <int>,
#> #   home_team_name <chr>, home_team_score <int>, away_team_id <int>,
#> #   away_team_name <chr>, away_team_score <int>, home_team_logo_url <chr>,
#> #   home_team_stats_url_en <chr>, home_team_stats_url_fr <chr>,
#> #   away_team_logo_url <chr>, away_team_stats_url_en <chr>,
#> #   away_team_stats_url_fr <chr>, stats_url_en <chr>, stats_url_fr <chr>, …
# }
```
