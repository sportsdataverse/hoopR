# **NBL Rosetta Standings**

Regular-season ladder: position, record, points for and against, home
and away splits and form.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/standings/{season}/regular`

## Usage

``` r
nbl_rosetta_standings(season, org = "nbl", limit = NULL)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble (one row per ladder entry):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| rosetta_standing_id | character | Rosetta's id of this ladder row (UUID v4); not an entity id. |
| position | integer | Ladder position (1 = top) |
| won | integer | Wins in the season. |
| lost | integer | Losses in the season. |
| played | integer | Games played in the season (wins plus losses). |
| points_percentage | double | points_for / points_against, a RATIO (1.1379 = 113.79 %) |
| win_percentage | double | Won / played, a 0-1 FRACTION. |
| last_5 | character | Results string, W/L oldest first. Despite the name it can hold the whole season (33 characters in NBL 2025-26) |
| streak | integer | Current streak length (the type is the last letter of last_5) |
| points_for | integer | Points scored by the team in the season. |
| points_against | integer | Points conceded. |
| away_losses | integer | Away losses in the season. |
| away_wins | integer | Away wins in the season. |
| home_losses | integer | Home losses in the season. |
| home_wins | integer | Home wins in the season. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

Columns the body adds beyond these follow, in body order
(sportsdataverse-py keeps them too).

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

## See also

Other NBL Rosetta Functions:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
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
[`nbl_rosetta_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_stats_leaders.md),
[`nbl_rosetta_team_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_players.md),
[`nbl_rosetta_team_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats.md),
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_standings(org = "nbl", season = 2026))
#> ── NBL Rosetta standings from prod.rosetta.nbl.com.au ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:33:15 UTC
#> # A tibble: 10 × 24
#>    org   rosetta_standing_id       position   won  lost played points_percentage
#>    <chr> <chr>                        <int> <int> <int>  <int>             <dbl>
#>  1 nbl   49b90e1d-4806-4142-9e73-…        1    24     9     33             1.14 
#>  2 nbl   469aff8e-afc6-4867-9d5b-…        3    22    11     33             1.09 
#>  3 nbl   f3db1c02-d617-442b-b029-…        4    21    12     33             1.05 
#>  4 nbl   11dc80a4-035b-41e0-b79d-…        2    23    10     33             1.05 
#>  5 nbl   c08140c3-7ce8-4030-b428-…        5    20    13     33             1.05 
#>  6 nbl   0a7b5591-3b70-42f7-a102-…        6    14    19     33             0.996
#>  7 nbl   d923eb2b-1f11-4b4a-8ce6-…        7    13    20     33             0.988
#>  8 nbl   6d5a2929-416e-4885-86d5-…        8    13    20     33             0.959
#>  9 nbl   f57a0e71-c3ff-4acf-b98c-…        9     9    24     33             0.862
#> 10 nbl   d2538239-3147-4ada-a09d-…       10     6    27     33             0.848
#> # ℹ 17 more variables: win_percentage <dbl>, last_5 <chr>, streak <int>,
#> #   points_for <int>, points_against <int>, away_losses <int>, away_wins <int>,
#> #   home_losses <int>, home_wins <int>, team_id <chr>, rosetta_team_id <chr>,
#> #   team_code <chr>, team_name <chr>, season_year <int>, season_type <chr>,
#> #   season_competition_division <chr>, season_end_year <int>
# }
```
