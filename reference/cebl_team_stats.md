# **Get CEBL Team Statistics**

Team statistic table (totals or per game) with a league row; filter by
season, competition, segment, opponent team or opponent conference.

Endpoint: `GET https://api.data.cebl.ca/teams/statistics/aggregated/`

## Usage

``` r
cebl_team_stats(
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  segment = NULL,
  vs_team_id = NULL,
  vs_conference = NULL
)
```

## Arguments

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

- segment:

  (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last
  5 games), L10G (last 10 games), MAY, JUNE, JULY or AUGUST. `NULL` =
  all games. Values from the CEBL Stats Hub bundle.

- vs_team_id:

  (default `NULL`) CEBL team id of the opponent: only games against that
  team count.

- vs_conference:

  (default `NULL`) EAST or WEST: only games against that conference's
  teams count.

## Value

A `hoopR_data` tibble: Team statistic table (totals or per game) with a
league row; filter by season, competition, segment, opponent team or
opponent conference. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sdv-py `cebl_team_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
| mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
| competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
| segment | character | Game-subset filter of the request (HOME, AWAY, L5G, MAY ...); null for all games. The body does not echo it. |
| vs_conference | character | Opponent-conference filter of the request (EAST or WEST); null when not asked. The body does not echo it. |
| vs_team_id | integer | Opponent team filter of the request (CEBL team id); null when not asked. The body does not echo it. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). Null on the league row. |
| is_league_row | logical | True on the one league row of a team table (null team_id and names): the league's own figures, where played counts team-games and, in TOTALS, points equals points_against. |
| name_en | character | Team full name in English ('Niagara River Lions'). Null on the league row. |
| short_name_en | character | Team short name in English, usually the city ('Niagara'). Null on the league row. |
| name_fr | character | Team full name in French ('River Lions de Niagara'). Null on the league row. |
| short_name_fr | character | Team short name in French, usually the city. Null on the league row. |
| played | integer | Games played (a count in both modes). On the league row: team-games (twice the games). |
| wins | integer | Wins (a count in both modes). |
| win_percentage | double | Wins / games played, 0-1 with 3 decimals ('0.625'). A string. |
| losses | integer | Losses (a count in both modes). |
| points | double | Points scored. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| points_against | double | Points allowed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| point_difference | double | Points scored minus points allowed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| field_goals_made | double | Field goals made (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| field_goals_attempted | double | Field goals attempted (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
| three_points_made | double | Three-pointers made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| three_points_attempted | double | Three-pointers attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
| free_throws_made | double | Free throws made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| free_throws_attempted | double | Free throws attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
| offensive_rebounds | double | Offensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| defensive_rebounds | double | Defensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| rebounds | double | Total rebounds (offensive + defensive). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| assists | double | Assists. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| turn_overs | double | Turnovers. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| steals | double | Steals. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| blocks | double | Shots blocked. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| fouls | double | Personal fouls committed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| fouls_drawn | double | Fouls drawn (committed by opponents). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| efficiency | double | Efficiency rating (EFF); CEBL does not publish its formula (unverified: the usual Genius / FIBA EFF is PTS + REB + AST + STL + BLK - missed FG - missed FT - TO). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| logo_url | character | Team logo URL (icon with the team name) on Google Cloud Storage. Null on the league row. |
| icon_url | character | Team icon URL (without the team name) on Google Cloud Storage. Null on the league row. |
| stats_url_en | character | The team's stats page on cebl.ca (`https://cebl.ca/stats/{slug}`). Null on the league row. |
| stats_url_fr | character | The team's stats page on the French cebl.ca (`https://cebl.ca/fr-ca/stats/{slug}`). Null on the league row. |

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
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_team_stats(mode = "TOTALS", season = 2025, competition = "REGULAR"))
#> ── CEBL Team Statistics from the CEBL Stats API ──────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:35:52 UTC
#> # A tibble: 11 × 42
#>    season mode   competition segment vs_conference vs_team_id team_id
#>     <int> <chr>  <chr>       <chr>   <chr>              <int>   <int>
#>  1   2025 TOTALS REGULAR     NA      NA                    NA      18
#>  2   2025 TOTALS REGULAR     NA      NA                    NA      16
#>  3   2025 TOTALS REGULAR     NA      NA                    NA      19
#>  4   2025 TOTALS REGULAR     NA      NA                    NA      17
#>  5   2025 TOTALS REGULAR     NA      NA                    NA      14
#>  6   2025 TOTALS REGULAR     NA      NA                    NA      15
#>  7   2025 TOTALS REGULAR     NA      NA                    NA      20
#>  8   2025 TOTALS REGULAR     NA      NA                    NA      22
#>  9   2025 TOTALS REGULAR     NA      NA                    NA      21
#> 10   2025 TOTALS REGULAR     NA      NA                    NA      24
#> 11   2025 TOTALS REGULAR     NA      NA                    NA      NA
#> # ℹ 35 more variables: is_league_row <lgl>, name_en <chr>, short_name_en <chr>,
#> #   name_fr <chr>, short_name_fr <chr>, played <int>, wins <int>,
#> #   win_percentage <dbl>, losses <int>, points <dbl>, points_against <dbl>,
#> #   point_difference <dbl>, field_goals_made <dbl>,
#> #   field_goals_attempted <dbl>, field_goal_percentage <dbl>,
#> #   three_points_made <dbl>, three_points_attempted <dbl>,
#> #   three_point_percentage <dbl>, free_throws_made <dbl>, …
# }
```
