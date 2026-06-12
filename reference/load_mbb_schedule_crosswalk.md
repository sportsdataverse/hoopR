# **Load hoopR MBB schedule crosswalk**

Loads a pre-built per-season MBB schedule crosswalk that links ESPN game
identifiers to Bart Torvik game identifiers. The files are versioned
`.rds` snapshots stored in the `mbb_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. (Min:
  2002; default:
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per MBB game per
season. Columns include at minimum `season` and `espn_game_id`.

## See also

Other MBB Crosswalk Functions:
[`load_mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_crosswalk.md),
[`load_mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_schedule_crosswalk_2026.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_schedule_crosswalk_2026.rds>
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 0 × 0
# }
```
