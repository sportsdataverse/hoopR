# **NBA Franchise History (active + defunct)**

One tidy franchise timeline.
[`nba_franchisehistory()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md)
returns the active (`FranchiseHistory`) and `DefunctTeams` sets
separately; these share a schema, so this row-binds them (tactic **B**)
and tags each row `active` / `defunct`.

## Usage

``` r
nba_tidy_franchise_history(...)
```

## Arguments

- ...:

  Additional arguments passed to
  [`nba_franchisehistory()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md)
  (e.g. `proxy`).

## Value

A `hoopR_data` tibble, one row per franchise era, with a leading
`franchise_status` column (`active` / `defunct`).

## See also

Other NBA Combined Datasets:
[`nba_tidy_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_boxscore.md),
[`nba_tidy_player_profile()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_player_profile.md)

## Examples

``` r
# \donttest{
  try(nba_tidy_franchise_history())
#> ✖ 2026-06-24 03:07:42.498631: Invalid arguments or no franchise history data available for {team_id}!
#> ✖ Args: league_id = "00"
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-06-24 03:07:42.510604: No NBA franchise history available!
#> ✖ Error: No franchise history returned
#> data frame with 0 columns and 0 rows
# }
```
