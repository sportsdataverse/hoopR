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
#> ── NBA franchise history (active + defunct) from stats.nba.com ── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:14:02 UTC
#> # A tibble: 89 × 16
#>    franchise_status LEAGUE_ID TEAM_ID    TEAM_CITY TEAM_NAME START_YEAR END_YEAR
#>    <chr>            <chr>     <chr>      <chr>     <chr>     <chr>      <chr>   
#>  1 active           00        1610612737 Atlanta   Hawks     1949       2025    
#>  2 active           00        1610612737 Atlanta   Hawks     1968       2025    
#>  3 active           00        1610612737 St. Louis Hawks     1955       1967    
#>  4 active           00        1610612737 Milwaukee Hawks     1951       1954    
#>  5 active           00        1610612737 Tri-Citi… Blackhaw… 1949       1950    
#>  6 active           00        1610612738 Boston    Celtics   1946       2025    
#>  7 active           00        1610612751 Brooklyn  Nets      1976       2025    
#>  8 active           00        1610612751 Brooklyn  Nets      2012       2025    
#>  9 active           00        1610612751 New Jers… Nets      1977       2011    
#> 10 active           00        1610612751 New York  Nets      1976       1976    
#> # ℹ 79 more rows
#> # ℹ 9 more variables: YEARS <chr>, GAMES <chr>, WINS <chr>, LOSSES <chr>,
#> #   WIN_PCT <chr>, PO_APPEARANCES <chr>, DIV_TITLES <chr>, CONF_TITLES <chr>,
#> #   LEAGUE_TITLES <chr>
# }
```
