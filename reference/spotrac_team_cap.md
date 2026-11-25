# **Spotrac NBA Team Salary Cap**

**Get team salary-cap allocations from Spotrac (spotrac.com).**

Returns one row per team with cap allocations, cap space, active-player
counts and average age for a season. No API key is required.

## Usage

``` r
spotrac_team_cap(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "spotrac_team_cap")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Salary & Draft Functions:
[`hoopshype_salaries()`](https://hoopR.sportsdataverse.org/reference/hoopshype_salaries.md),
[`nbadraft_mock_draft()`](https://hoopR.sportsdataverse.org/reference/nbadraft_mock_draft.md)

## Examples

``` r
# \donttest{
  try(spotrac_team_cap(season = 2024))
#> ── Team salary cap from spotrac.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-25 07:00:41 UTC
#> # A tibble: 31 × 13
#>    rank  team      record cap_space cap_status total_cap active_cap dead_cap
#>    <chr> <chr>     <chr>      <dbl> <chr>          <dbl>      <dbl>    <dbl>
#>  1 1     Pistons   44-38   -1220220 Over Cap   141808220  133989678  7818542
#>  2 2     Magic     41-41  -12371238 Over Cap   152959238  152959238       NA
#>  3 3     Jazz      17-65  -13526022 Over Cap   154114022  142648013 11466009
#>  4 4     Spurs     34-48  -22221380 Over Cap   162809380  155231927  7577453
#>  5 5     Thunder   68-14  -25413694 Over Cap   166001694  162209242  3792452
#>  6 6     Hornets   19-63  -26835486 Over Cap   167423486  152436862 14986624
#>  7 7     Grizzlies 48-34  -27226933 Over Cap   167814933  155850296  8014853
#>  8 8     Bulls     39-43  -27418873 Over Cap   168006873  157180244  8739110
#>  9 9     76ers     24-58  -29752647 Over Cap   170340647  169548876   791771
#> 10 10    Pacers    50-32  -30644577 Over Cap   171232577  166839774  2530538
#> # ℹ 21 more rows
#> # ℹ 5 more variables: cap_holds <dbl>, top_3 <dbl>, players <dbl>, age <dbl>,
#> #   season <int>
# }
```
