# **Load hoopR NBA player crosswalk**

Loads a pre-built per-season NBA player crosswalk that maps ESPN athlete
identifiers to NBA.com player identifiers. The files are versioned
`.rds` snapshots stored in the `nba_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_nba_player_crosswalk(seasons = most_recent_nba_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given NBA seasons. (Min:
  2002; default:
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per NBA player per
season. Columns include at minimum `season`, `espn_athlete_id`, and
`nba_player_id`.

## See also

Other NBA Crosswalk Functions:
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_nba_player_crosswalk(seasons = most_recent_nba_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_crosswalk/nba_player_crosswalk_2026.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_crosswalk/nba_player_crosswalk_2026.rds>
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 0 × 0
# }
```
