# **Load hoopR NBA Stats rolling windows**

Loads the `nba_stats_rolling_windows` release: every shooter's rolling
form over his last `window_n` field-goal attempts (`metric = "fg_pct"`)
and three-point attempts (`"fg3_pct"`), for `window_n` 50 and 200,
computed from
[`load_nba_stats_shots()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md).
One row per player per window unit per window size. Windows count
attempts, not games, and cross season boundaries: `cur` is the make rate
over the last `n` attempts through the season, `prev` the window before
it, `season_start` the window entering the season and `career_baseline`
every attempt before `cur`'s window (each `NA` rather than partial
without a full window of history). `delta_prev_rank` is 1 for the
biggest riser among qualified rows.

## Usage

``` r
load_nba_stats_rolling_windows(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_rolling_windows` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_rolling_windows>,
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

A `hoopR_data` tibble with one row per entity per metric per window.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | END year of the NBA season (2025 = 2024-25), the asset's own stamp: one more than the `seasons` argument. |
| entity_type | character | Which aggregate the row is: "league" (every counted attempt that season), "team" or "player" on metric_curves; always "player" on rolling_windows. |
| entity_id | character | stats.nba.com id of the entity as TEXT – the team_id on a team row, the person_id on a player row, NA on the league row. |
| entity_name | character | Label for the entity: the team tricode ("GSW") on a team row, the shooter's name as the pbp ships it on a player row; NA on the league row. |
| team_id | character | stats.nba.com team id (e.g. 1610612737 = Atlanta Hawks). |
| metric | character | What the row measures: "fg_pct_by_shot_distance" on metric_curves (field-goal percentage by shot distance in feet); "fg_pct" (window_unit "fga") or "fg3_pct" (window_unit "fg3a") on rolling_windows. |
| window_unit | character | What the window counts: "fga" (every field-goal attempt) or "fg3a" (three-point attempts). Regular-season and playoff attempts only. |
| window_n | integer | Window size in attempts (50 or 200), not games. |
| cur | numeric | Make rate over the player's last n attempts through the season (the current window). |
| prev | numeric | Make rate over the window_n attempts just before the current window; NA unless that whole window exists. |
| season_start | numeric | Make rate over the window_n attempts just before the season began (form entering the season); NA unless the career before the season holds a full window. |
| career_baseline | numeric | Make rate over every career attempt (since 1996-97) before the current window, earlier games of this season included; NA unless that history holds at least window_n attempts. |
| delta_prev | numeric | cur - prev; NA when either side is NA. |
| delta_season | numeric | cur - season_start; NA when either side is NA. |
| delta_career | numeric | cur - career_baseline; NA when either side is NA. |
| delta_prev_rank | integer | Rank of delta_prev within (window_unit, window_n, metric), 1 = biggest riser, ties share the lowest rank; NA unless the row is qualified and has a prev. |
| n | integer | Attempts the current window averages: window_n, or fewer for a career shorter than the window. |
| qualified | logical | TRUE when n == window_n (a full window, not a short career). Filter on it before ranking or comparing players. |
| last_event_date | Date | Date of the player's latest counted attempt through the season. |
| as_of_date | Date | Date of the latest counted attempt league-wide that season: the date the windows are current through. |
| id_source | character | Namespace of `entity_id` / `team_id` on this row – "nba_stats" here; the cross-league contract carries "espn", "gsis" and "wnba_stats" elsewhere. |

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
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_rolling_windows(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 1,728 × 21
#>    season entity_type entity_id entity_name team_id  metric window_unit window_n
#>     <int> <chr>       <chr>     <chr>       <chr>    <chr>  <chr>          <int>
#>  1   2027 player      1626145   Jones       1610612… fg3_p… fg3a              50
#>  2   2027 player      1626157   Towns       1610612… fg3_p… fg3a              50
#>  3   2027 player      1626162   Oubre Jr.   1610612… fg3_p… fg3a              50
#>  4   2027 player      1626164   Booker      1610612… fg3_p… fg3a              50
#>  5   2027 player      1626167   Turner      1610612… fg3_p… fg3a              50
#>  6   2027 player      1626168   Lyles       1610612… fg3_p… fg3a              50
#>  7   2027 player      1626171   Portis Jr.  1610612… fg3_p… fg3a              50
#>  8   2027 player      1626181   Powell      1610612… fg3_p… fg3a              50
#>  9   2027 player      1626204   Nance Jr.   1610612… fg3_p… fg3a              50
#> 10   2027 player      1626209   Hezonja     1610612… fg3_p… fg3a              50
#> # ℹ 1,718 more rows
#> # ℹ 13 more variables: cur <dbl>, prev <dbl>, season_start <dbl>,
#> #   career_baseline <dbl>, delta_prev <dbl>, delta_season <dbl>,
#> #   delta_career <dbl>, delta_prev_rank <int>, n <int>, qualified <lgl>,
#> #   last_event_date <date>, as_of_date <date>, id_source <chr>
# }
```
