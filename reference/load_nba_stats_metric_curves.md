# **Load hoopR NBA Stats metric curves**

Loads the `nba_stats_metric_curves` release: field-goal percentage by
shot distance for the league, every team and every player of a season,
computed from
[`load_nba_stats_shots()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md).
One row per entity per distance bucket (1-ft bins from 0 to 35 ft, then
35-50 and 50-95 ft; `x_lo` inclusive, `x_hi` exclusive) with its
`attempts`, `successes` (makes) and `rate`; an empty bucket has no row.
Regular-season and playoff shots only. `entity_id` / `team_id` are
stats.nba.com ids as text; `down` and `epa_per_att` are always `NA` (the
football columns of the cross-league contract).

## Usage

``` r
load_nba_stats_metric_curves(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_metric_curves` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_metric_curves>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season). Published coverage starts at 1996 (1996-97).
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

A `hoopR_data` tibble with one row per entity per metric per bin.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | END year of the NBA season (2025 = 2024-25), the asset's own stamp: one more than the `seasons` argument. |
| entity_type | character | Which aggregate the row is: "league" (every counted attempt that season), "team" or "player" on metric_curves; always "player" on rolling_windows. |
| entity_id | character | stats.nba.com id of the entity as TEXT – the team_id on a team row, the person_id on a player row, NA on the league row. |
| entity_name | character | Label for the entity: the team tricode ("GSW") on a team row, the shooter's name as the pbp ships it on a player row; NA on the league row. |
| team_id | character | stats.nba.com team id (e.g. 1610612737 = Atlanta Hawks). |
| id_source | character | Namespace of `entity_id` / `team_id` on this row – "nba_stats" here; the cross-league contract carries "espn", "gsis" and "wnba_stats" elsewhere. |
| metric | character | What the row measures: "fg_pct_by_shot_distance" on metric_curves (field-goal percentage by shot distance in feet); "fg_pct" (window_unit "fga") or "fg3_pct" (window_unit "fg3a") on rolling_windows. |
| down | integer | Null on every row: the second axis of the football-only success_by_down_distance curve, carried for the cross-league contract. |
| x_lo | numeric | Bucket lower edge in feet, inclusive: 1-ft bins from 0 to 35, then 35 and 50. |
| x_hi | numeric | Bucket upper edge in feet, exclusive: x_lo + 1 below 35 ft, then 50 and 95. |
| attempts | integer | Field-goal attempts in the bucket – regular-season and playoff shots only (season_type_id 2 and 4; play-in and NBA Cup final games are not counted). An empty bucket is absent, never a zero row. |
| successes | integer | Made field goals in the bucket. |
| rate | numeric | successes / attempts, one exact division (no smoothing or prior). |
| epa_per_att | numeric | Null on every row: shots carry no EPA. Populated on the football twins of this contract. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_draft_combine`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_draft_combine.md),
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md),
[`load_nba_stats_hustle`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_hustle.md),
[`load_nba_stats_injury_report()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_injury_report.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_metric_curves(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 8,123 × 14
#>    season entity_type entity_id entity_name team_id id_source metric  down  x_lo
#>     <int> <chr>       <chr>     <chr>       <chr>   <chr>     <chr>  <int> <dbl>
#>  1   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     0
#>  2   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     1
#>  3   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     2
#>  4   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     3
#>  5   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     4
#>  6   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     5
#>  7   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     6
#>  8   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     7
#>  9   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     8
#> 10   2027 league      NA        NA          NA      nba_stats fg_pc…    NA     9
#> # ℹ 8,113 more rows
#> # ℹ 5 more variables: x_hi <dbl>, attempts <int>, successes <int>, rate <dbl>,
#> #   epa_per_att <dbl>
# }
```
