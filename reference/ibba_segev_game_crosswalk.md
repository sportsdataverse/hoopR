# **IBBA to Segev Game Crosswalk**

**IBBA `game_id` \<-\> Segev `game_id`, from an
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md)
(or
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md))
frame you already have: no request is made.**

The pairs come from the frame's `segev_game_id` column (the host's own
`ExternalID`, read as a Segev game id); nothing is guessed from names.
Games before 2025-26 and external-team news links carry no Segev id and
are dropped. The id types are checked (no float or string id casts) and
the mapping must be one-to-one both ways.

## Usage

``` r
ibba_segev_game_crosswalk(df)
```

## Arguments

- df:

  A data frame from
  [`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md)
  or
  [`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_segev_game_crosswalk")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Raises `hoopR_bad_request` when `df` is not a data frame, lacks a
column, has an id column of the wrong type, or maps one id to two.

     ibba_segev_game_crosswalk(ibba_games(season = 2026, board_id = 5, board_round = 1))

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
