# **Load hoopR NBA depth charts**

Loads the `espn_nba_depthcharts` release: daily snapshots of every NBA
team's ESPN depth chart, one row per athlete per depth-chart slot per
snapshot date (`as_of_date`), with the slot's position and the athlete's
`depth_rank` in it. The tag holds the current season only (2027 =
2026-27, the first season captured), as parquet.

## Usage

``` r
load_nba_depthcharts(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `espn_nba_depthcharts` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_depthcharts>.

## Arguments

- seasons:

  A vector of 4-digit season-ending years (`2027` = 2026-27), like the
  other ESPN `load_nba_*()` loaders. Published coverage starts at 2027.
  Pass `seasons = TRUE` for every published season.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per athlete per depth-chart slot per
snapshot date.

|  |  |  |
|----|----|----|
| col_name | types | description |
| as_of_date | Date | Date of the daily snapshot the row comes from. |
| league | character | League slug ('nba'). |
| season | integer | Season END year (2027 = 2026-27). |
| season_type | integer | ESPN season type of the snapshot: 1 preseason, 2 regular season, 3 postseason. |
| team_id | integer | ESPN team identifier. |
| team_display_name | character | Full team display name (e.g. 'Boston Celtics'). |
| team_abbreviation | character | ESPN team abbreviation (e.g. 'BOS'). |
| group_id | integer | ESPN depth-chart group id (one group, 'Depth Chart', for the NBA). |
| group_name | character | ESPN depth-chart group name ('Depth Chart'). |
| position_slot | character | Depth-chart slot key, the lowercase position abbreviation (e.g. 'pg', 'c'). |
| position_id | integer | ESPN position id of the slot. |
| position_abbreviation | character | Position abbreviation of the slot (e.g. 'PG', 'C'). |
| position_name | character | Position name of the slot (e.g. 'Point Guard', 'Center'). |
| depth_rank | integer | The athlete's place in the slot: 1 = starter, 2 = first backup, and so on. |
| athlete_id | integer | ESPN athlete identifier. |
| athlete_display_name | character | Athlete display name (full). |
| athlete_short_name | character | Athlete short display name. |
| espn_timestamp | character | ESPN's last-updated time of the team's depth chart (UTC, ISO 8601 text). |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md)

## Examples

``` r
# \donttest{
  try(load_nba_depthcharts(seasons = most_recent_nba_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 64,878 × 18
#>    as_of_date league season season_type team_id team_display_name
#>    <date>     <chr>   <int>       <int>   <int> <chr>            
#>  1 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  2 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  3 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  4 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  5 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  6 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  7 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  8 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#>  9 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#> 10 2026-09-08 nba      2027           1       1 Atlanta Hawks    
#> # ℹ 64,868 more rows
#> # ℹ 12 more variables: team_abbreviation <chr>, group_id <int>,
#> #   group_name <chr>, position_slot <chr>, position_id <int>,
#> #   position_abbreviation <chr>, position_name <chr>, depth_rank <int>,
#> #   athlete_id <int>, athlete_display_name <chr>, athlete_short_name <chr>,
#> #   espn_timestamp <chr>
# }
```
