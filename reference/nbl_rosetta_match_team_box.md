# **NBL Rosetta Match Team Box Score**

One match's team box score by period, one row per team and period (0 =
whole game).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_team_box(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble (one row per team and period):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
| match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
| stat_line_id | character | Provider record hash of this statistics row (64 hex characters) |
| rosetta_stat_line_id | character | Rosetta id of this statistics row (UUID v4) |
| assists | integer | Assists in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| blocks | integer | Blocks in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| defensive_rebounds | integer | Defensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_attempted | integer | Field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_made | integer | Field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
| fouls | integer | Fouls committed (personal + technical + others) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_attempted | integer | Free throws attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_made | integer | Free throws made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
| minutes | double | Minutes played: "MM:SS" string in player_match_statistics, decimal minutes in calculated_player_statistics, player-minutes (integer, 5 x period length) in team rows; "00:00" or 0 where not recorded. |
| offensive_rebounds | integer | Offensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
| period_type | character | Period type: regular (overtime unobserved) |
| personal_fouls | integer | Personal fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| points | integer | Points in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| rebounds | integer | Total rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| steals | integer | Steals in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| technical_fouls | integer | Technical fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| three_points_attempted | integer | Three-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| three_points_made | integer | Three-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
| turnovers | integer | Turnovers in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| two_points_attempted | integer | Two-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| two_points_made | integer | Two-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
| rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| timeouts | integer | Timeouts taken in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |

Columns the body adds beyond these follow, in body order (sdv-py keeps
them too).

## Details

- Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL
  documents or supports). The terms of use were not reviewed; payloads
  are not redistributed as release assets.

- Gated by a referer, not a key: every request carries Origin / Referer
  set to nbl.com.au (the runtime sends them); without them the host
  answers 403 MISSING_API_KEY, which is raised as `hoopR_asset_fetch`.

- Fills a hole in ESPN: ESPN's nbl feed has box scores but no plays for
  the 2025-26 NBL season (the stats provider changed from Genius Sports
  to Sportradar DataCore that year). nbl_rosetta_match_pbp has the full
  event log with shot x/y for 2025-26 and, in the same shape, back to
  2011-12 (WNBL about 2014-15). Matches from 1979 have box scores only.

- One host serves three organisations; pass org='nbl' (default), 'wnbl'
  or 'nbl1'. NBL1 is the second tier (men's and women's conferences,
  calendar-year seasons).

- Season = the END year (2026 = 2025-26) everywhere. Rosetta's own year
  is the START year for the NBL and WNBL from 1998-99 and a calendar
  year for NBL1 and the 1979-1997 winter seasons; the runtime maps it.
  Year 1998 holds two seasons (calendar 1998 and 1998-99).

- Ids: `<entity>`*id columns are DataCore ids (UUID v1; join on them),
  rosetta*`<entity>`\_id Rosetta's own. match_id is the DataCore fixture
  id every match route is keyed on.

- Unknown ids, orgs and types answer 200 with no rows (`hoopR_no_data`).
  Rosetta caches a body per path and serves it whatever the query
  string, so a page cut by someone else's limit is refused
  (`hoopR_asset_fetch`); retry after the cache entry expires.

Errors: `hoopR_no_data` when Rosetta answers 404 or no rows (an unknown
match, team, player or season id, an org or season type with nothing, or
no season in progress); `hoopR_asset_fetch` for the 403 gate body, a
stub or error envelope, a page cut by Rosetta's path cache, a body for
another org, season or entity than the one asked for, or any other
failed fetch; `hoopR_bad_request` for an unknown `org` / `season_type`,
a malformed id, or HTTP 400 / 422.

## See also

Other NBL Rosetta Functions:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md),
[`nbl_rosetta_next_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match.md),
[`nbl_rosetta_next_match_team()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match_team.md),
[`nbl_rosetta_next_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_matches.md),
[`nbl_rosetta_outcomes()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_outcomes.md),
[`nbl_rosetta_player_game_log()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_game_log.md),
[`nbl_rosetta_player_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_stats.md),
[`nbl_rosetta_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_players.md),
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md),
[`nbl_rosetta_seasons_current()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons_current.md),
[`nbl_rosetta_standings()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_standings.md),
[`nbl_rosetta_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_stats_leaders.md),
[`nbl_rosetta_team_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_players.md),
[`nbl_rosetta_team_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats.md),
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_match_team_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match_team_box from prod.rosetta.nbl.com.au ────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:37:22 UTC
#> # A tibble: 10 × 36
#>    match_id        match_status stat_line_id rosetta_stat_line_id assists blocks
#>    <chr>           <chr>        <chr>        <chr>                  <int>  <int>
#>  1 b217a699-4bef-… complete     3db61a3d115… 02c748ef-70b6-43c3-…       2      2
#>  2 b217a699-4bef-… complete     b58e3d8d43d… 0805fced-6fb6-4831-…       3      0
#>  3 b217a699-4bef-… complete     3718e495e92… 310918d6-b7d4-4bb0-…       6      1
#>  4 b217a699-4bef-… complete     a6ba64e3851… 4a84f4b4-bb82-4a9a-…       1      0
#>  5 b217a699-4bef-… complete     08567e1d2bf… 719c47df-c663-44c7-…       7      2
#>  6 b217a699-4bef-… complete     30cc3bd15c0… 869c5e78-268f-4c73-…      14      4
#>  7 b217a699-4bef-… complete     5abf7cc10fe… a7ce2bd9-59e1-4788-…       1      0
#>  8 b217a699-4bef-… complete     29f2f7f1aab… abaf4417-79eb-41f3-…       5      1
#>  9 b217a699-4bef-… complete     f5fc779ac41… b514ae2c-431a-458c-…      13      2
#> 10 b217a699-4bef-… complete     cca5bf7851a… fd636482-5e3c-433c-…       2      0
#> # ℹ 30 more variables: defensive_rebounds <int>, field_goals_attempted <int>,
#> #   field_goals_made <int>, field_goals_percentage <dbl>, fouls <int>,
#> #   free_throws_attempted <int>, free_throws_made <int>,
#> #   free_throws_percentage <dbl>, minutes <dbl>, offensive_rebounds <int>,
#> #   period <int>, period_type <chr>, personal_fouls <int>, points <int>,
#> #   rebounds <int>, steals <int>, technical_fouls <int>,
#> #   three_points_attempted <int>, three_points_made <int>, …
# }
```
