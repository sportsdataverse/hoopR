# **Get BNXT League Player Games**

Game-by-game box lines of a roster entry (including games with 0
minutes).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/boxscore/player/season-games/{roster_id}`

## Usage

``` r
sportpress_player_games(roster_id)
```

## Arguments

- roster_id:

  (required) Roster id (integer): one player on one team in one season;
  from the roster frames.

## Value

A `hoopR_data` tibble with one row per game the player played. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_player_games")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_player_games(roster_id = 11193)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
