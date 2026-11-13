# **Load hoopR NBA Stats player matchups**

`load_nba_stats_matchups()` reads the
`leagueseasonmatchups_regular-season_{per_mode}_{END year}.parquet`
files of the `nba_stats_matchups` release: one row per (offensive
player, defensive player) pair. The tag publishes this table for the
regular season only. `load_nba_stats_matchups_rollup()` reads the
`matchupsrollup_{season_type}_{per_mode}_{END year}.parquet` files: one
row per defender per offensive position (`G`/`F`/`C`) plus a `TOTAL`
row.

`matchup_min` is `"MM:SS"` text in `totals` files and decimal minutes in
`pergame` files, so reading both per modes makes it character. Pass one
`per_mode` to keep the native types. Per-game matchups are in
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md).

## Usage

``` r
load_nba_stats_matchups(
  seasons = most_recent_nba_stats_season(),
  per_mode = NULL,
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_matchups_rollup(
  seasons = most_recent_nba_stats_season(),
  season_type = NULL,
  per_mode = NULL,
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_matchups` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_matchups>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season). Published coverage starts at 2017 (2017-18).
  Pass `seasons = TRUE` for every published season.

- per_mode:

  `"pergame"` and/or `"totals"`; `NULL` (the default) reads both.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

- season_type:

  `"regular-season"` and/or `"playoffs"`; `NULL` (the default) reads
  both.

## Value

A `hoopR_data` tibble with one row per matchup pair per per mode
(`load_nba_stats_matchups()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| season_id | character | stats.nba.com season code: a season-type digit (2 = regular season, 4 = playoffs) followed by the season's START year, e.g. '22024' = the 2024-25 regular season. |
| off_player_id | integer | stats.nba.com identifier of the offensive player in the matchup. |
| off_player_name | character | Offensive player's display name. |
| def_player_id | integer | stats.nba.com identifier of the defender. |
| def_player_name | character | Defender's display name. |
| gp | integer | Games played in the split. |
| matchup_min | character | Time matched up: 'MM:SS' text in 'totals' files, decimal minutes in 'pergame' files (character when both are loaded together). |
| partial_poss | numeric | Possessions the pair was matched up for, apportioned by time (fractional). |
| player_pts | integer | Points the offensive player scored while guarded by the defender. |
| team_pts | integer | Points the offensive player's team scored while the pair was matched up. |
| matchup_ast | integer | Assists by the offensive player while guarded by the defender. |
| matchup_tov | integer | Turnovers by the offensive player while guarded by the defender. |
| matchup_blk | integer | Blocks by the defender on the offensive player's shots. |
| matchup_fgm | integer | Field goals made by the offensive player against the defender. |
| matchup_fga | integer | Field goals attempted by the offensive player against the defender. |
| matchup_fg_pct | numeric | Field-goal percentage (0-1) of the offensive player against the defender. |
| matchup_fg3_m | integer | Three-pointers made by the offensive player against the defender. |
| matchup_fg3_a | integer | Three-pointers attempted by the offensive player against the defender. |
| matchup_fg3_pct | numeric | Three-point percentage (0-1) of the offensive player against the defender. |
| help_blk | integer | Help-defense blocks credited to the matchup; stats.nba.com ships 0 in every row checked. |
| help_fgm | integer | Field goals made against help defense; stats.nba.com ships 0 in every row checked. |
| help_fga | integer | Field goals attempted against help defense; stats.nba.com ships 0 in every row checked. |
| help_fg_perc | integer | Field-goal percentage against help defense; stats.nba.com ships 0 in every row checked. |
| matchup_ftm | integer | Free throws made by the offensive player on fouls by the defender. |
| matchup_fta | integer | Free throws attempted by the offensive player on fouls by the defender. |
| sfl | integer | Shooting fouls committed by the defender on the offensive player. |
| matchup_time_sec | numeric | Time matched up in seconds; present only in early 'totals' files (e.g. 2017-18). |
| season | integer | END year of the NBA season (2025 = 2024-25) – the published asset's own stamp, one more than the `seasons` argument. |
| season_type | character | Season type of the source file: 'regular-season' or 'playoffs' (the release file-name token). |
| per_mode | character | Aggregation of the source file: 'pergame' (per-game averages) or 'totals' (season totals); stamped from the file name when the rows lack it. |

A `hoopR_data` tibble with one row per defender per position per season
type per per mode (`load_nba_stats_matchups_rollup()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| season_id | character | stats.nba.com season code: a season-type digit (2 = regular season, 4 = playoffs) followed by the season's START year, e.g. '22024' = the 2024-25 regular season. |
| position | character | Offensive position bucket the defender guarded: 'G', 'F' or 'C', plus a 'TOTAL' row summing the three. |
| percent_of_time | numeric | Share (0-1) of the defender's matchup time spent on this position ('TOTAL' = 1). |
| def_player_id | integer | stats.nba.com identifier of the defender. |
| def_player_name | character | Defender's display name. |
| gp | integer | Games played in the split. |
| matchup_min | character | Time the defender spent guarding this position: 'MM:SS' text in 'totals' files, decimal minutes in 'pergame' files (character when both are loaded together). |
| partial_poss | numeric | Possessions the defender spent on this position, apportioned by time (fractional). |
| player_pts | integer | Points scored by the offensive players of this position while guarded by the defender. |
| team_pts | integer | Points scored by the opposing team while the defender guarded this position. |
| matchup_ast | integer | Assists by the guarded players of this position. |
| matchup_tov | integer | Turnovers by the guarded players of this position. |
| matchup_blk | integer | Blocks by the defender against this position. |
| matchup_fgm | integer | Field goals made against the defender by this position. |
| matchup_fga | integer | Field goals attempted against the defender by this position. |
| matchup_fg_pct | numeric | Field-goal percentage (0-1) allowed to this position. |
| matchup_fg3_m | integer | Three-pointers made against the defender by this position. |
| matchup_fg3_a | integer | Three-pointers attempted against the defender by this position. |
| matchup_fg3_pct | numeric | Three-point percentage (0-1) allowed to this position. |
| matchup_ftm | integer | Free throws made by this position on the defender's fouls. |
| matchup_fta | integer | Free throws attempted by this position on the defender's fouls. |
| sfl | integer | Shooting fouls the defender committed against this position. |
| season | integer | END year of the NBA season (2025 = 2024-25) – the published asset's own stamp, one more than the `seasons` argument. |
| season_type | character | Season type of the source file: 'regular-season' or 'playoffs' (the release file-name token). |
| per_mode | character | Aggregation of the source file: 'pergame' (per-game averages) or 'totals' (season totals); stamped from the file name when the rows lack it. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the
Python twins `sportsdataverse.nba.load_nba_stats_matchups()` /
`load_nba_stats_matchups_rollup()`.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_draft_combine`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_draft_combine.md),
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md),
[`load_nba_stats_hustle`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_hustle.md),
[`load_nba_stats_injury_report()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_injury_report.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_matchups(seasons = most_recent_nba_stats_season() - 1,
                              per_mode = "totals"))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 147,303 × 30
#>    season_id off_player_id off_player_name   def_player_id def_player_name    gp
#>    <chr>             <int> <chr>                     <int> <chr>           <int>
#>  1 22025           1628389 Bam Adebayo             1628976 Wendell Carter…     5
#>  2 22025           1631230 Dominick Barlow         1630552 Jalen Johnson       4
#>  3 22025           1642270 Donovan Clingan          203497 Rudy Gobert         4
#>  4 22025            203497 Rudy Gobert             1642270 Donovan Clingan     4
#>  5 22025           1628976 Wendell Carter J…       1628389 Bam Adebayo         5
#>  6 22025            201142 Kevin Durant            1641739 Toumani Camara      4
#>  7 22025           1630552 Jalen Johnson           1631094 Paolo Banchero      4
#>  8 22025            201142 Kevin Durant            1630183 Jaden McDaniels     3
#>  9 22025           1628983 Shai Gilgeous-Al…       1641739 Toumani Camara      4
#> 10 22025           1631094 Paolo Banchero          1630552 Jalen Johnson       4
#> # ℹ 147,293 more rows
#> # ℹ 24 more variables: matchup_min <chr>, partial_poss <dbl>, player_pts <int>,
#> #   team_pts <int>, matchup_ast <int>, matchup_tov <int>, matchup_blk <int>,
#> #   matchup_fgm <int>, matchup_fga <int>, matchup_fg_pct <dbl>,
#> #   matchup_fg3_m <int>, matchup_fg3_a <int>, matchup_fg3_pct <dbl>,
#> #   help_blk <int>, help_fgm <int>, help_fga <int>, help_fg_perc <int>,
#> #   matchup_ftm <int>, matchup_fta <int>, sfl <int>, matchup_time_sec <dbl>, …
# }
```
