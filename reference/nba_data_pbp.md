# **Get NBA Data API Play-by-Play**

**Get NBA Data API Play-by-Play**

**Get NBA Data API Play-by-Play**

## Usage

``` r
nba_data_pbp(game_id = "0021900001", ...)
```

## Arguments

- game_id:

  Game ID - 10 digits, i.e. "0021900001"

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a tibble

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| league | character | League. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| event_num | integer | Sequential event number within the game (V2 PBP). |
| clock | character | Game clock value. |
| description | character | Long-form description text. |
| locX | integer |  |
| locY | integer |  |
| opt1 | integer | Opt1. |
| opt2 | integer | Opt2. |
| event_action_type | integer | Numeric event-action-type code (V2 PBP). |
| event_type | integer | Event / play type code (V2 PBP). |
| team_id | integer | Unique team identifier. |
| offense_team_id | integer | Unique identifier for offense team. |
| player1_id | integer | V2 PBP primary player ID (e.g. shooter / fouler). |
| player2_id | integer | V2 PBP secondary player ID (e.g. assister / fouled-by). |
| player3_id | integer | V2 PBP tertiary player ID (e.g. blocker). |
| home_score | integer | Home team score at the time of the play. |
| away_score | integer | Away team score at the time of the play. |
| order | integer | Display order within the result set. |

Event Message Types (event_type):

1 -\> MAKE

2 -\> MISS

3 -\> FreeThrow

4 -\> Rebound

5 -\> Turnover

6 -\> Foul

7 -\> Violation

8 -\> Substitution

9 -\> Timeout

10 -\> JumpBall

11 -\> Ejection

12 -\> StartOfPeriod

13 -\> EndOfPeriod

14 -\> Empty

## Details

     nba_data_pbp(game_id = "0021900001")

## See also

Other NBA PBP Functions:
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

## Author

Saiem Gilani
