# **Load hoopR NBA Stats Synergy play-type stats**

Loads the `nba_stats_synergy` release: 72 files per season, one per
season type, play type, offensive/defensive split and per mode
(`{season_type}_{play_type}_{type_grouping}_{per_mode}_{END year}.parquet`).
The requested combinations (all of them by default) are bound into one
frame, one row per player per play type per split. `season_type` and
`per_mode` are added from the file name when a file's rows lack them.
Reading both per modes widens the counting columns (`poss`, `pts`,
`fgm`, `fga`, `fgmx`), which are integer in `totals` files and decimal
in `pergame` files, to double.

## Usage

``` r
load_nba_stats_synergy(
  seasons = most_recent_nba_stats_season(),
  season_type = NULL,
  per_mode = NULL,
  type_grouping = NULL,
  play_type = NULL,
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_synergy` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_synergy>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season), like every `load_nba_stats_*()` loader.
  Published coverage starts at 2015 (2015-16). Pass `seasons = TRUE` for
  every published season.

- season_type:

  `"regular-season"` and/or `"playoffs"`; `NULL` (the default) reads
  both.

- per_mode:

  `"pergame"` and/or `"totals"`; `NULL` reads both.

- type_grouping:

  `"offensive"` and/or `"defensive"`; `NULL` reads both.

- play_type:

  One or more of `cut`, `handoff`, `isolation`, `misc`, `offrebound`,
  `offscreen`, `postup`, `prballhandler`, `prrollman`, `spotup`,
  `transition`; `NULL` reads every play type of each requested type
  grouping. `cut`, `misc`, `offrebound` and `transition` are published
  for the offensive split only.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per player per play type per split.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season_id | character | stats.nba.com season code: a season-type digit (2 = regular season, 4 = playoffs) followed by the season's START year, e.g. '22024' = the 2024-25 regular season. |
| player_id | integer | stats.nba.com player identifier (PERSON_ID); joins to every other nba_stats loader. |
| player_name | character | Player's full name as stats.nba.com lists it (e.g. 'Nikola Jokic'). |
| team_id | integer | stats.nba.com team identifier. |
| team_abbreviation | character | Team tricode (e.g. 'BOS'). |
| team_name | character | Team nickname (e.g. 'Celtics'). |
| play_type | character | Synergy play type as stats.nba.com labels it, e.g. 'Isolation', 'PRBallHandler', 'Spotup', 'Transition'. |
| type_grouping | character | 'Offensive' (the player's own possessions of this play type) or 'Defensive' (opponent possessions of this play type the player defended). |
| percentile | numeric | Percentile rank (0-1) of the row's points per possession among players with this play type. |
| gp | integer | Games played in the split. |
| poss_pct | numeric | Frequency: share (0-1) of the player's possessions that were this play type. |
| ppp | numeric | Points per possession on this play type. |
| fg_pct | numeric | Field-goal percentage (0-1) on this play type. |
| ft_poss_pct | numeric | Share (0-1) of this play type's possessions that produced free throws. |
| tov_poss_pct | numeric | Share (0-1) of this play type's possessions that ended in a turnover. |
| sf_poss_pct | numeric | Share (0-1) of this play type's possessions that drew a shooting foul. |
| plusone_poss_pct | numeric | Share (0-1) of this play type's possessions that ended in an and-one. |
| score_poss_pct | numeric | Share (0-1) of this play type's possessions that scored at least one point. |
| efg_pct | numeric | Effective field-goal percentage (0-1), weighting made threes by 1.5. |
| poss | integer | Possessions of this play type (integer in 'totals' files, double per game). |
| pts | integer | Points scored on this play type. |
| fgm | integer | Field goals made on this play type. |
| fga | integer | Field goals attempted on this play type. |
| fgmx | integer | Field goals missed on this play type. |
| season | integer | END year of the NBA season (2025 = 2024-25) – the published asset's own stamp, one more than the `seasons` argument. |
| season_type | character | Season type of the source file: 'regular-season' or 'playoffs' (the release file-name token). |
| per_mode | character | Aggregation of the source file: 'pergame' (per-game averages) or 'totals' (season totals); stamped from the file name when the rows lack it. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the
Python twin `sportsdataverse.nba.load_nba_stats_synergy()`.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_draft_combine`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_draft_combine.md),
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md),
[`load_nba_stats_hustle`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_hustle.md),
[`load_nba_stats_injury_report()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_injury_report.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md),
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_synergy(seasons = most_recent_nba_stats_season(),
                             play_type = "isolation", per_mode = "totals"))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 159 × 27
#>    season_id player_id player_name team_id team_abbreviation team_name play_type
#>    <chr>         <int> <chr>         <int> <chr>             <chr>     <chr>    
#>  1 22026       1629029 Luka Dončić  1.61e9 LAL               Los Ange… Isolation
#>  2 22026       1628983 Shai Gilge…  1.61e9 OKC               Oklahoma… Isolation
#>  3 22026       1630559 Austin Rea…  1.61e9 LAL               Los Ange… Isolation
#>  4 22026        201935 James Hard…  1.61e9 CLE               Clevelan… Isolation
#>  5 22026       1628369 Jayson Tat…  1.61e9 BOS               Boston C… Isolation
#>  6 22026       1626164 Devin Book…  1.61e9 PHX               Phoenix … Isolation
#>  7 22026       1628973 Jalen Brun…  1.61e9 NYK               New York… Isolation
#>  8 22026       1630163 LaMelo Ball  1.61e9 MIN               Minnesot… Isolation
#>  9 22026       1643411 Darius Acu…  1.61e9 SAC               Sacramen… Isolation
#> 10 22026        203507 Giannis An…  1.61e9 MIA               Miami He… Isolation
#> # ℹ 149 more rows
#> # ℹ 20 more variables: type_grouping <chr>, percentile <dbl>, gp <int>,
#> #   poss_pct <dbl>, ppp <dbl>, fg_pct <dbl>, ft_poss_pct <dbl>,
#> #   tov_poss_pct <dbl>, sf_poss_pct <dbl>, plusone_poss_pct <dbl>,
#> #   score_poss_pct <dbl>, efg_pct <dbl>, poss <int>, pts <int>, fgm <int>,
#> #   fga <int>, fgmx <int>, season <int>, season_type <chr>, per_mode <chr>
# }
```
