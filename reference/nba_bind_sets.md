# Reduce NBA Stats API result sets

Convenience helpers to munge hoopR's structure-faithful named-list
result sets into a single tibble. hoopR's `nba_*()` wrappers return the
endpoint's `resultSets` verbatim as a named list of tibbles (lossless,
no munging); these reduce that list on demand, making explicit – and
composable – the three reductions `nbastatR` hard-coded inside each
function.

## Usage

``` r
nba_bind_sets(result_sets, tag_column = "set_name")

nba_join_sets(result_sets, join_key)

nba_nest_sets(result_sets, keep_cols, nest_col = ".data")
```

## Arguments

- result_sets:

  A named list of tibbles (an `nba_*()` return).

- tag_column:

  Name of the origin column `nba_bind_sets()` adds (holds the set
  names). Defaults to `"set_name"`.

- join_key:

  Single shared column name `nba_join_sets()` joins the sets on.

- keep_cols:

  Grouping key column(s) `nba_nest_sets()` keeps wide; every other
  column is nested.

- nest_col:

  Name of the list-column `nba_nest_sets()` creates. Defaults to
  `".data"`.

## Value

A single `tbl_df` (bound, joined, or nested).

## Details

`nba_bind_sets()` row-binds the sets into one long tibble, tagging each
row with its origin (tactic **B**). Use when the sets share a schema, or
you simply want them stacked with an origin column (e.g. draft rounds,
per-mode stat blocks). Columns absent from a given set fill with `NA`.

`nba_join_sets()` successively left-joins the sets into one wide tibble
on a shared key (tactic **C**). Use when the sets are different facets
of the same entity (e.g. player stats + team stats keyed on a game or
player id).

`nba_nest_sets()` keeps `keep_cols` (plus the set name) wide and nests
every other column into a list-column, preserving all data when no
single flat schema can hold it (tactic **D**). Use for incompatible sets
(e.g. a player profile's season totals + career totals + awards).
Recover a set with
[`tidyr::unnest()`](https://tidyr.tidyverse.org/reference/unnest.html).

All three accept a named list of tibbles – an `nba_*()` return, or the
output of `nba_stats_map_result_sets()` – and return a single tibble.

## Examples

``` r
sets <- list(
  PlayerStats = data.frame(GAME_ID = "1", PERSON_ID = c(1, 2), PTS = c(10, 20)),
  TeamStats   = data.frame(GAME_ID = "1", TEAM_ID = 99, PTS = 30)
)
nba_bind_sets(sets, tag_column = "set")          # B: row-bind + tag
#> # A tibble: 3 × 5
#>   set         GAME_ID PERSON_ID   PTS TEAM_ID
#>   <chr>       <chr>       <dbl> <dbl>   <dbl>
#> 1 PlayerStats 1               1    10      NA
#> 2 PlayerStats 1               2    20      NA
#> 3 TeamStats   1              NA    30      99
nba_join_sets(sets, join_key = "GAME_ID")        # C: join/widen on a key
#> # A tibble: 2 × 5
#>   GAME_ID PERSON_ID PTS.x TEAM_ID PTS.y
#>   <chr>       <dbl> <dbl>   <dbl> <dbl>
#> 1 1               1    10      99    30
#> 2 1               2    20      99    30
nba_nest_sets(sets, keep_cols = "GAME_ID")       # D: nest into a list-column
#> # A tibble: 2 × 3
#>   set_name    GAME_ID .data           
#>   <chr>       <chr>   <list>          
#> 1 PlayerStats 1       <tibble [2 × 3]>
#> 2 TeamStats   1       <tibble [1 × 3]>
```
