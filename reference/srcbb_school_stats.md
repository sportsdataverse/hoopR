# **Sports-Reference Men's College Basketball School Stats**

**Get men's college basketball season school (team) statistics from
[Sports-Reference](https://www.sports-reference.com/cbb/).**

One row per school for a season. No account or API key is required.
Sports-Reference rate-limits aggressive scraping (~20 requests/minute) –
space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
srcbb_school_stats(season = most_recent_mbb_season(), table = "basic")
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024` for 2023-24). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- table:

  (*character*): Which stats table – one of `"basic"` (default),
  `"advanced"` or `"opponent"`.

## Value

A `hoopR_data` tibble with one row per school, carrying `season` and
`table` columns. Columns vary by `table`; the `"basic"` table includes
`school`, `g`, `wins`, `losses`, `srs`, `sos`, `pts`, `opp_pts`,
shooting splits, rebounds, assists, steals, blocks, turnovers and fouls.

## See also

Other Sports-Reference College Basketball Functions:
[`srcbb_rankings()`](https://hoopR.sportsdataverse.org/reference/srcbb_rankings.md)

## Examples

``` r
# \donttest{
  try(srcbb_school_stats(season = 2024, table = "basic"))
#> ── Men's college basketball school stats from sports-reference.com ─────────────
#> ℹ Data updated: 2026-06-12 02:35:25 UTC
#> # A tibble: 362 × 35
#>    ranker school              g  wins losses win_loss_pct    srs   sos wins_conf
#>     <dbl> <chr>           <dbl> <dbl>  <dbl>        <dbl>  <dbl> <dbl>     <dbl>
#>  1      1 Abilene Christ…    34    16     18        0.471  -4.12 -1.12        10
#>  2      2 Air Force          31     9     22        0.29   -4.77  1.43         2
#>  3      3 Akron NCAA         35    24     11        0.686   2.77 -2.08        13
#>  4      4 Alabama NCAA       37    25     12        0.676  20.7  11.8         13
#>  5      5 Alabama A&M        35    12     23        0.343 -14.4  -7.52         9
#>  6      6 Alabama State      32    13     19        0.406 -11.7  -6.87         8
#>  7      7 Albany (NY)        32    13     19        0.406  -6.6  -5.22         5
#>  8      8 Alcorn State       32    14     18        0.438 -11.6  -5.61        13
#>  9      9 American           32    16     16        0.5    -8.96 -8.79        10
#> 10     10 Appalachian St…    34    27      7        0.794   6.04 -2.34        16
#> # ℹ 352 more rows
#> # ℹ 26 more variables: losses_conf <dbl>, wins_home <dbl>, losses_home <dbl>,
#> #   wins_visitor <dbl>, losses_visitor <dbl>, pts <dbl>, opp_pts <dbl>,
#> #   mp <dbl>, fg <dbl>, fga <dbl>, fg_pct <dbl>, fg3 <dbl>, fg3a <dbl>,
#> #   fg3_pct <dbl>, ft <dbl>, fta <dbl>, ft_pct <dbl>, orb <dbl>, trb <dbl>,
#> #   ast <dbl>, stl <dbl>, blk <dbl>, tov <dbl>, pf <dbl>, season <int>,
#> #   table <chr>
# }
```
