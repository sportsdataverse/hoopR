# **Get Basketligaen Last Game Day**

Games of the last played match day of an ssgt.

Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/last-game-day`

## Usage

``` r
sportality_last_game_day(season = NULL, game_type = "regular")
```

## Arguments

- season:

  (default `NULL`) Season END year (2026 = 2025/26), mapped to its ssgt
  through layout-info. NULL = the active ssgt (these match-day views
  follow the current season).

- game_type:

  (default `"regular"`) Game type: regular (the league season) or finals
  (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_last_game_day")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_last_game_day())
#> Error in sportality_last_game_day() : 
#>   www.basketligaen.dk/api/statistics-v2/layout-info: 0 ssgts in the body,
#> expected the 40+ of 25 seasons.
# }
```
