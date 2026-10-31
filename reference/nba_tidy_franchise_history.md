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
if (FALSE) { # interactive()
# \donttest{
  try(nba_tidy_franchise_history())
# }
}
```
