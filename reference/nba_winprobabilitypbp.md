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

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| EVENT_NUM | character | Sequential event number within the game (V2 PBP). |
| HOME_PCT | character |  |
| VISITOR_PCT | character |  |
| HOME_PTS | character |  |
| VISITOR_PTS | character |  |
| HOME_SCORE_MARGIN | character |  |
| PERIOD | character | Period of the game (1-4 quarters; 5+ for OT). |
| SECONDS_REMAINING | character | Seconds remaining in the period. |
| HOME_POSS_IND | character |  |
| HOME_G | character |  |
| DESCRIPTION | character | Long-form description text. |
| LOCATION | character | Location. |
| PCTIMESTRING | character |  |
| ISVISIBLE | character |  |

**GameInfo**

|                  |           |                                      |
|------------------|-----------|--------------------------------------|
| col_name         | types     | description                          |
| GAME_ID          | character | Unique game identifier.              |
| GAME_DATE        | character | Game date (YYYY-MM-DD).              |
| HOME_TEAM_ID     | character | Unique identifier for the home team. |
| HOME_TEAM_ABR    | character |                                      |
| HOME_TEAM_PTS    | character |                                      |
| VISITOR_TEAM_ID  | character |                                      |
| VISITOR_TEAM_ABR | character |                                      |
| VISITOR_TEAM_PTS | character |                                      |

## Details

     nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md)

## Author

Saiem Gilani
