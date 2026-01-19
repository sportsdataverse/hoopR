# **Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Stats**

## Usage

``` r
nba_draftcombinestats(
  league_id = "00",
  season_year = most_recent_nba_season() - 1,
  ...
)
```

## Arguments

- league_id:

  league_id

- season_year:

  season_year

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: DraftCombineStats

**DraftCombineStats**

|                              |           |
|------------------------------|-----------|
| col_name                     | types     |
| SEASON                       | character |
| PLAYER_ID                    | character |
| FIRST_NAME                   | character |
| LAST_NAME                    | character |
| PLAYER_NAME                  | character |
| POSITION                     | character |
| HEIGHT_WO_SHOES              | character |
| HEIGHT_WO_SHOES_FT_IN        | character |
| HEIGHT_W_SHOES               | character |
| HEIGHT_W_SHOES_FT_IN         | character |
| WEIGHT                       | character |
| WINGSPAN                     | character |
| WINGSPAN_FT_IN               | character |
| STANDING_REACH               | character |
| STANDING_REACH_FT_IN         | character |
| BODY_FAT_PCT                 | character |
| HAND_LENGTH                  | character |
| HAND_WIDTH                   | character |
| STANDING_VERTICAL_LEAP       | character |
| MAX_VERTICAL_LEAP            | character |
| LANE_AGILITY_TIME            | character |
| MODIFIED_LANE_AGILITY_TIME   | character |
| THREE_QUARTER_SPRINT         | character |
| BENCH_PRESS                  | character |
| SPOT_FIFTEEN_CORNER_LEFT     | character |
| SPOT_FIFTEEN_BREAK_LEFT      | character |
| SPOT_FIFTEEN_TOP_KEY         | character |
| SPOT_FIFTEEN_BREAK_RIGHT     | character |
| SPOT_FIFTEEN_CORNER_RIGHT    | character |
| SPOT_COLLEGE_CORNER_LEFT     | character |
| SPOT_COLLEGE_BREAK_LEFT      | character |
| SPOT_COLLEGE_TOP_KEY         | character |
| SPOT_COLLEGE_BREAK_RIGHT     | character |
| SPOT_COLLEGE_CORNER_RIGHT    | character |
| SPOT_NBA_CORNER_LEFT         | character |
| SPOT_NBA_BREAK_LEFT          | character |
| SPOT_NBA_TOP_KEY             | character |
| SPOT_NBA_BREAK_RIGHT         | character |
| SPOT_NBA_CORNER_RIGHT        | character |
| OFF_DRIB_FIFTEEN_BREAK_LEFT  | character |
| OFF_DRIB_FIFTEEN_TOP_KEY     | character |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT | character |
| OFF_DRIB_COLLEGE_BREAK_LEFT  | character |
| OFF_DRIB_COLLEGE_TOP_KEY     | character |
| OFF_DRIB_COLLEGE_BREAK_RIGHT | character |
| ON_MOVE_FIFTEEN              | character |
| ON_MOVE_COLLEGE              | character |

## Details

     nba_draftcombinestats(season_year = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
