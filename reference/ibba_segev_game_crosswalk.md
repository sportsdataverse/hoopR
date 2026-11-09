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

A `hoopR_data` tibble, one row per game:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | IBBA game id (key space: basket.co.il games): the `game_id` of [`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md) and [`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md). |
| segev_game_id | integer | The Segev game id of the same game: the `game_id` every `ibba_segev_*()` wrapper takes. |

## Details

Raises `hoopR_bad_request` when `df` is not a data frame, lacks a
column, has an id column of the wrong type, or maps one id to two.

     ibba_segev_game_crosswalk(ibba_games(season = 2026, board_id = 5, board_round = 1))

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
