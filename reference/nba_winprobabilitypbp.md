# **Get NBA Stats API Win Probability PBP**

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md)
instead.

## Usage

``` r
nba_winprobabilitypbp(game_id = "0021700807", run_type = "each second", ...)
```

## Arguments

- game_id:

  Game ID

- run_type:

  Run Type

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: WinProbPBP, GameInfo

**WinProbPBP**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_ID           | character |
| EVENT_NUM         | character |
| HOME_PCT          | character |
| VISITOR_PCT       | character |
| HOME_PTS          | character |
| VISITOR_PTS       | character |
| HOME_SCORE_MARGIN | character |
| PERIOD            | character |
| SECONDS_REMAINING | character |
| HOME_POSS_IND     | character |
| HOME_G            | character |
| DESCRIPTION       | character |
| LOCATION          | character |
| PCTIMESTRING      | character |
| ISVISIBLE         | character |

**GameInfo**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| GAME_ID          | character |
| GAME_DATE        | character |
| HOME_TEAM_ID     | character |
| HOME_TEAM_ABR    | character |
| HOME_TEAM_PTS    | character |
| VISITOR_TEAM_ID  | character |
| VISITOR_TEAM_ABR | character |
| VISITOR_TEAM_PTS | character |

## Details

     nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md)

## Author

Saiem Gilani
