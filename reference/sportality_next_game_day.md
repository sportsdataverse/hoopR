# **Get Basketligaen Next Game Day**

Games of the next match day of an ssgt.

Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/next-game-day`

## Usage

``` r
sportality_next_game_day(season = NULL, game_type = "regular")
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
(`subset(return_columns, fn == "sportality_next_game_day")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_next_game_day()

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
