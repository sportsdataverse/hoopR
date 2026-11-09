# **Get LBA Standings**

Standings of a championship after a round, one row per team.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championship-ranking`
(`id=<championship_id>&d=<round>`)

## Usage

``` r
lba_standings(championship_id, round = NULL)
```

## Arguments

- championship_id:

  (required) Championship id (championship_id in lba_championships; a
  Regular Season id carries standings).

- round:

  Standings after this round. Required in practice for a finished
  championship: without it the site sends none (NoDataError).

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_standings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(lba_standings(championship_id = 602, round = 3))
#> ── LBA Standings from legabasket.it ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:13:08 UTC
#> # A tibble: 16 × 57
#>    season standing_id championships_day_id team_id position  wins defeats
#>     <int>       <int>                <int>   <int>    <int> <int>   <int>
#>  1   2027       44970                 4488    1772        1     3       0
#>  2   2027       44968                 4488    1750        2     3       0
#>  3   2027       44975                 4488    1769        3     2       1
#>  4   2027       44978                 4488    1751        4     2       1
#>  5   2027       44972                 4488    1764        5     2       1
#>  6   2027       44976                 4488    1763        6     2       1
#>  7   2027       44971                 4488    1753        7     2       1
#>  8   2027       44977                 4488    1766        8     2       1
#>  9   2027       44969                 4488    1771        9     2       1
#> 10   2027       44980                 4488    1760       10     1       2
#> 11   2027       44982                 4488    1762       11     1       2
#> 12   2027       44973                 4488    1761       12     1       2
#> 13   2027       44974                 4488    1752       13     1       2
#> 14   2027       44979                 4488    1767       14     0       3
#> 15   2027       44981                 4488    1765       15     0       3
#> 16   2027       44983                 4488    1768       16     0       3
#> # ℹ 50 more variables: points_made <int>, points_suffered <int>, qp <int>,
#> #   lv <chr>, lp <chr>, lpf <chr>, lps <chr>, lqp <chr>, updated_at <chr>,
#> #   points <int>, penalty_points <int>, game_played <int>,
#> #   home_game_played <int>, home_wins <int>, home_defeats <int>,
#> #   away_game_played <int>, away_wins <int>, away_defeats <int>,
#> #   avg_points_made <dbl>, avg_points_suffered <dbl>, home_points_made <int>,
#> #   home_points_suffered <int>, home_avg_points_made <dbl>, …
# }
```
