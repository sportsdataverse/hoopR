# **Load hoopR NBA Stats hustle stats**

`load_nba_stats_hustle_player()` and `load_nba_stats_hustle_team()` load
the `nba_stats_hustle` release: eight files per season
(`leaguehustlestats{player|team}_{season_type}_{per_mode}_{END year}.parquet`),
contested shots, deflections, charges drawn, screen assists, loose balls
and box-outs. The requested season types and per modes (all of them by
default) are bound into one frame, with `season_type` and `per_mode`
columns saying which file a row came from.

## Usage

``` r
load_nba_stats_hustle_player(
  seasons = most_recent_nba_stats_season(),
  season_type = NULL,
  per_mode = NULL,
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_hustle_team(
  seasons = most_recent_nba_stats_season(),
  season_type = NULL,
  per_mode = NULL,
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_hustle` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_hustle>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season). Published coverage starts at 2015 (2015-16).
  Pass `seasons = TRUE` for every published season.

- season_type:

  `"regular-season"` and/or `"playoffs"`; `NULL` (the default) reads
  both.

- per_mode:

  `"pergame"` and/or `"totals"`; `NULL` reads both.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per player per season type per per
mode (`load_nba_stats_hustle_player()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_id | integer | stats.nba.com player identifier (PERSON_ID); joins to every other nba_stats loader. |
| player_name | character | Player's full name as stats.nba.com lists it (e.g. 'Nikola Jokic'). |
| team_id | integer | stats.nba.com team identifier. |
| team_abbreviation | character | Team tricode (e.g. 'BOS'). |
| age | numeric | Player age in years at the season's reference date, as stats.nba.com reports it. |
| g | integer | Games played in the split. |
| min | numeric | Minutes played (per game in 'pergame' files, season total in 'totals' files). |
| contested_shots | integer | Shots the player (or team) contested. |
| contested_shots_2_pt | integer | Two-point shots contested. |
| contested_shots_3_pt | integer | Three-point shots contested. |
| deflections | integer | Deflections of opponent passes or dribbles. |
| charges_drawn | integer | Offensive fouls (charges) drawn. |
| screen_assists | integer | Screens set that led directly to a teammate's made field goal. |
| screen_ast_pts | integer | Points scored on field goals created by the screen assists. |
| off_loose_balls_recovered | integer | Loose balls recovered on offense. |
| def_loose_balls_recovered | integer | Loose balls recovered on defense. |
| loose_balls_recovered | integer | Loose balls recovered (offense plus defense). |
| pct_loose_balls_recovered_off | numeric | Share (0-1) of loose-ball recoveries made on offense. |
| pct_loose_balls_recovered_def | numeric | Share (0-1) of loose-ball recoveries made on defense. |
| off_boxouts | integer | Box-outs on offense. |
| def_boxouts | integer | Box-outs on defense. |
| box_out_player_team_rebs | integer | Rebounds secured by the player's team on the player's box-outs. |
| box_out_player_rebs | integer | Rebounds secured by the player himself on his own box-outs. |
| box_outs | integer | Box-outs executed (offense plus defense). |
| pct_box_outs_off | numeric | Share (0-1) of box-outs made on offense. |
| pct_box_outs_def | numeric | Share (0-1) of box-outs made on defense. |
| pct_box_outs_team_reb | numeric | Share (0-1) of the player's box-outs that ended in a team rebound. |
| pct_box_outs_reb | numeric | Share (0-1) of the player's box-outs that ended in his own rebound. |
| season | integer | END year of the NBA season (2025 = 2024-25) – the published asset's own stamp, one more than the `seasons` argument. |
| season_type | character | Season type of the source file: 'regular-season' or 'playoffs' (the release file-name token). |
| per_mode | character | Aggregation of the source file: 'pergame' (per-game averages) or 'totals' (season totals); stamped from the file name when the rows lack it. |

A `hoopR_data` tibble with one row per team per season type per per mode
(`load_nba_stats_hustle_team()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | stats.nba.com team identifier. |
| team_name | character | Team nickname (e.g. 'Celtics'). |
| min | numeric | Minutes played (per game in 'pergame' files, season total in 'totals' files). |
| contested_shots | integer | Shots the team contested. |
| contested_shots_2_pt | integer | Two-point shots contested. |
| contested_shots_3_pt | integer | Three-point shots contested. |
| deflections | integer | Deflections of opponent passes or dribbles. |
| charges_drawn | integer | Offensive fouls (charges) drawn. |
| screen_assists | integer | Screens set that led directly to a teammate's made field goal. |
| screen_ast_pts | integer | Points scored on field goals created by the screen assists. |
| off_loose_balls_recovered | integer | Loose balls recovered on offense. |
| def_loose_balls_recovered | integer | Loose balls recovered on defense. |
| loose_balls_recovered | integer | Loose balls recovered (offense plus defense). |
| pct_loose_balls_recovered_off | numeric | Share (0-1) of loose-ball recoveries made on offense. |
| pct_loose_balls_recovered_def | numeric | Share (0-1) of loose-ball recoveries made on defense. |
| off_boxouts | integer | Box-outs on offense. |
| def_boxouts | integer | Box-outs on defense. |
| box_outs | integer | Box-outs executed (offense plus defense). |
| pct_box_outs_off | numeric | Share (0-1) of box-outs made on offense. |
| pct_box_outs_def | numeric | Share (0-1) of box-outs made on defense. |
| season | integer | END year of the NBA season (2025 = 2024-25) – the published asset's own stamp, one more than the `seasons` argument. |
| season_type | character | Season type of the source file: 'regular-season' or 'playoffs' (the release file-name token). |
| per_mode | character | Aggregation of the source file: 'pergame' (per-game averages) or 'totals' (season totals); stamped from the file name when the rows lack it. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the
Python twins `sportsdataverse.nba.load_nba_stats_hustle_player()` /
`load_nba_stats_hustle_team()`.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_draft_combine`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_draft_combine.md),
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md),
[`load_nba_stats_injury_report()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_injury_report.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md),
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_hustle_player(seasons = most_recent_nba_stats_season(),
                                   season_type = "regular-season", per_mode = "totals"))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 455 × 31
#>    player_id player_name      team_id team_abbreviation   age     g   min
#>        <int> <chr>              <int> <chr>             <dbl> <int> <dbl>
#>  1   1643407 AJ Dybantsa   1610612764 WAS                  19     9   305
#>  2   1631260 AJ Green      1610612749 MIL                  27    12   217
#>  3   1642358 AJ Johnson    1610612740 NOP                  21     2    15
#>  4    203932 Aaron Gordon  1610612743 DEN                  31    10   291
#>  5   1630174 Aaron Nesmith 1610612754 IND                  27    10   252
#>  6   1630598 Aaron Wiggins 1610612737 ATL                  27    12   310
#>  7   1642846 Ace Bailey    1610612762 UTA                  20    12   372
#>  8   1643530 Aday Mara     1610612760 OKC                  21    12   255
#>  9   1641737 Adem Bona     1610612755 PHI                  23     9   128
#> 10   1642876 Adou Thiero   1610612747 LAL                  22     4    37
#> # ℹ 445 more rows
#> # ℹ 24 more variables: contested_shots <int>, contested_shots_2_pt <int>,
#> #   contested_shots_3_pt <int>, deflections <int>, charges_drawn <int>,
#> #   screen_assists <int>, screen_ast_pts <int>,
#> #   off_loose_balls_recovered <int>, def_loose_balls_recovered <int>,
#> #   loose_balls_recovered <int>, pct_loose_balls_recovered_off <dbl>,
#> #   pct_loose_balls_recovered_def <dbl>, off_boxouts <int>, …
# }
```
