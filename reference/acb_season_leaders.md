# **Get ACB Season Leaders**

Each team's season leaders before a game, by category.

One row per team, metric and rank, like `acb_match_leaders` but over the
season so far; `value` is a total or an average depending on the metric.

Endpoint:
`GET https://api2.acb.com/api/matchdata/Preview/season-leaders`

## Usage

``` r
acb_season_leaders(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per team, statistic and rank. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_season_leaders")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_season_leaders(match_id = 105401))
#> ── ACB Season Leaders from api2.acb.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:51:44 UTC
#> # A tibble: 40 × 17
#>    match_id edition_id season team_side team_id club_id team  team_abbr metric
#>       <int>      <int>  <int> <chr>       <int>   <int> <chr> <chr>     <chr> 
#>  1   105401         91   2027 home         4467       2 Barça BAR       rating
#>  2   105401         91   2027 home         4467       2 Barça BAR       rating
#>  3   105401         91   2027 home         4467       2 Barça BAR       rating
#>  4   105401         91   2027 home         4467       2 Barça BAR       rating
#>  5   105401         91   2027 home         4467       2 Barça BAR       rating
#>  6   105401         91   2027 home         4467       2 Barça BAR       points
#>  7   105401         91   2027 home         4467       2 Barça BAR       points
#>  8   105401         91   2027 home         4467       2 Barça BAR       points
#>  9   105401         91   2027 home         4467       2 Barça BAR       points
#> 10   105401         91   2027 home         4467       2 Barça BAR       points
#> # ℹ 30 more rows
#> # ℹ 8 more variables: rank <int>, value <dbl>, player_id <int>,
#> #   player_name <chr>, first_name <chr>, last_name <chr>, shirt_number <chr>,
#> #   game_role <chr>
# }
```
