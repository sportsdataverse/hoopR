# **Load hoopR NBA Stats League Dashboard cube**

Loads one asset of the `nba_stats_leaguedash` release tag – the
parameter cube that supersedes the narrower `Base`-measure tags
([`load_nba_stats_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_lineups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_standings()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md)).
The cube publishes 36 tables per season and is the only route to
`Advanced`/`Misc`/`Scoring`/`Usage`/`Defense`/`Opponent`/`Four Factors`
measures, 2/3/4-man lineup groupings, the `*_bio`/`*_master` wide joins,
and player tracking (drives, passing, touches, catch-and-shoot, pull-up
shooting, rebounding, speed/distance).

Coverage floors differ by table and are **not** individually enforced
here (only the global 1996 floor is): the `lineups_*` tables start at
the 2007-08 season and the `player_tracking_*` tables (other than
`catchshoot`/`pullupshot`, which go back to 1996) start at the 2013-14
season. Requesting an out-of-range season for those tables 404s
gracefully with a warning and contributes no rows, same as any other
`nba_stats_*` loader.

## Usage

``` r
load_nba_stats_leaguedash(
  seasons = most_recent_nba_stats_season(),
  table = NULL,
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season). Published coverage runs 1996 through the most
  recent season for most tables (see Description for per-table floors).
  Pass `seasons = TRUE` for every published season. (Min: 1996)

- table:

  Name of the cube table to load. One of `player_bio`, `player_master`,
  `player_stats_base`, `player_stats_advanced`, `player_stats_misc`,
  `player_stats_scoring`, `player_stats_usage`, `player_stats_defense`,
  `player_tracking_catchshoot`, `player_tracking_defense`,
  `player_tracking_drives`, `player_tracking_efficiency`,
  `player_tracking_elbowtouch`, `player_tracking_painttouch`,
  `player_tracking_passing`, `player_tracking_possessions`,
  `player_tracking_posttouch`, `player_tracking_pullupshot`,
  `player_tracking_rebounding`, `player_tracking_speeddistance`,
  `team_master`, `team_stats_base`, `team_stats_advanced`,
  `team_stats_misc`, `team_stats_scoring`, `team_stats_defense`,
  `team_stats_opponent`, `team_stats_fourfactors`, `lineups_master`,
  `lineups_base`, `lineups_advanced`, `lineups_misc`, `lineups_scoring`,
  `lineups_opponent`, `lineups_fourfactors`, `standings`.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

Returns a `hoopR_data` tibble of the requested cube table, one row per
player-season, team-season or lineup-season depending on `table`. Column
sets differ per table (11 to 625 columns); the `*_master` tables are
wide joins of every measure type for that entity.

## See also

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_leaguedash(seasons = most_recent_nba_stats_season(),
                                table = "player_bio"))
#> Warning: downloaded length 0 != reported length 9
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_stats_leaguedash/player_bio_2027.parquet': HTTP status was '404 Not Found'
#> Warning: Failed to download parquet from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/nba_stats_leaguedash/player_bio_2027.parquet>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
```
