# **Get VTB Infobasket Playoff Games**

The games of every series of a playoff stage.

Endpoint: `GET https://org.infobasket.su/Widget/PlayOff/{comp_id}`

## Usage

``` r
vtb_infobasket_playoff_games(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_playoff_games")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_playoff_games(comp_id = 54281))
#> ── VTB Infobasket Playoff Games from org.infobasket.su ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:17:43 UTC
#> # A tibble: 34 × 17
#>    comp_id  tree round  sort game_id game_status score  plus_minus game_date 
#>      <int> <int> <int> <int>   <int>       <int> <chr>       <int> <chr>     
#>  1   54281     1     4     1 1058377          21 104:66         38 2026-04-27
#>  2   54281     1     4     1 1058378          21 85:67          18 2026-04-29
#>  3   54281     1     4     1 1058379          21 94:65          29 2026-05-03
#>  4   54281     1     4     2 1058382          21 93:80          13 2026-04-27
#>  5   54281     1     4     2 1058383          21 79:76           3 2026-04-29
#>  6   54281     1     4     2 1058384          21 87:82           5 2026-05-03
#>  7   54281     1     4     3 1058387          21 87:62          25 2026-04-26
#>  8   54281     1     4     3 1058388          21 83:63          20 2026-04-28
#>  9   54281     1     4     3 1058389          21 74:63          11 2026-05-02
#> 10   54281     1     4     4 1058392          21 78:85          -7 2026-04-26
#> # ℹ 24 more rows
#> # ℹ 8 more variables: team1_id <int>, team2_id <int>, team1_place <int>,
#> #   team2_place <int>, home_team <int>, win_team <int>, score1 <int>,
#> #   score2 <int>
# }
```
