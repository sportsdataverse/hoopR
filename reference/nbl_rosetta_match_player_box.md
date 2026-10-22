# **NBL Rosetta Match Player Box Score**

One match's official player box score, one row per player line (period 0
= whole game).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_player_box(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble (one row per player line):

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
| efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_attempted | integer | Field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_made | integer | Field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
| fouls | integer | Fouls committed (personal + technical + others) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_attempted | integer | Free throws attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_made | integer | Free throws made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
| jersey_number | character | Jersey number, a STRING. |
| minutes | double | Minutes played: "MM:SS" string in player_match_statistics, decimal minutes in calculated_player_statistics, player-minutes (integer, 5 x period length) in team rows; "00:00" or 0 where not recorded. |
| minutes_string | character | Minutes played as an ISO 8601 duration (PT30M32S); null on NBL1. |
| offensive_rebounds | integer | Offensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| participated | logical | Player took part in the game. |
| period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
| period_type | character | Period type: regular (overtime unobserved) |
| personal_fouls | integer | Personal fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| plus_minus | integer | Point differential while on court in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| points | integer | Points in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| rebounds | integer | Total rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| starter | logical | Player started the game. |
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
| player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
| player_first_name | character | The player's given name, e.g. Elijah. |
| player_last_name | character | The player's family name, e.g. Pepper. |
| player_full_name | character | Given and family name. |
| player_jersey_number | character | Jersey number, a STRING. |
| player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| sc | integer | NBL SuperCoach fantasy score for the game. |

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
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_match_team_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_team_box.md),
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
  try(nbl_rosetta_match_player_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match_player_box from prod.rosetta.nbl.com.au ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:55:32 UTC
#> # A tibble: 24 × 49
#>    match_id        match_status stat_line_id rosetta_stat_line_id assists blocks
#>    <chr>           <chr>        <chr>        <chr>                  <int>  <int>
#>  1 b217a699-4bef-… complete     57f5abff663… b2a062e4-f3b3-4c60-…       1      1
#>  2 b217a699-4bef-… complete     53a507c5776… fa64d272-9870-4190-…       0      0
#>  3 b217a699-4bef-… complete     7c9a19fd0b7… f810edb8-0a31-43e4-…       0      1
#>  4 b217a699-4bef-… complete     123825a424c… f761c24a-e52b-431a-…       3      1
#>  5 b217a699-4bef-… complete     2292fcddf70… f457ee22-71c9-4896-…       0      0
#>  6 b217a699-4bef-… complete     90c8fe3e6d1… f2734872-70a2-420a-…       0      0
#>  7 b217a699-4bef-… complete     84fc18c941e… d154ac3e-cb40-4672-…       4      2
#>  8 b217a699-4bef-… complete     36e6d1629cf… ce20e283-9d82-440e-…       0      0
#>  9 b217a699-4bef-… complete     99256f46270… caf9300d-b16c-4487-…       1      0
#> 10 b217a699-4bef-… complete     7aa7ac5d9cb… c5c40b4d-3708-46eb-…       1      0
#> # ℹ 14 more rows
#> # ℹ 43 more variables: defensive_rebounds <int>, efficiency <int>,
#> #   field_goals_attempted <int>, field_goals_made <int>,
#> #   field_goals_percentage <dbl>, fouls <int>, free_throws_attempted <int>,
#> #   free_throws_made <int>, free_throws_percentage <dbl>, jersey_number <chr>,
#> #   minutes <dbl>, minutes_string <chr>, offensive_rebounds <int>,
#> #   participated <lgl>, period <int>, period_type <chr>, …
# }
```
