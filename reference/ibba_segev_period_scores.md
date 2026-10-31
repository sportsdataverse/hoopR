# **IBBA Segev Period Scores**

**Points and team fouls in each period of a finished game.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`

## Usage

``` r
ibba_segev_period_scores(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
| period | integer | Period number (1-4 regulation, 5+ overtime). |
| home_points | integer | Points the home side scored IN this period (not cumulative). |
| away_points | integer | Points the away side scored IN this period (not cumulative). |
| home_fouls | integer | Team fouls the home side committed in this period. |
| away_fouls | integer | Team fouls the away side committed in this period. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).

     ibba_segev_period_scores(game_id = 50)

## See also

Other IBBA Segev Functions:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)
