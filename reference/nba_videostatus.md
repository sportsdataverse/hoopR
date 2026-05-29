# **Get NBA Stats API Video Status**

**Get NBA Stats API Video Status**

**Get NBA Stats API Video Status**

## Usage

``` r
nba_videostatus(game_date = "2023-03-10", league_id = "00", ...)
```

## Arguments

- game_date:

  game_date

- league_id:

  league_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a list of tibbles: VideoStatus

**VideoStatus**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| VISITOR_TEAM_ID | character |  |
| VISITOR_TEAM_CITY | character |  |
| VISITOR_TEAM_NAME | character |  |
| VISITOR_TEAM_ABBREVIATION | character |  |
| HOME_TEAM_ID | character | Unique identifier for the home team. |
| HOME_TEAM_CITY | character | Home team city / location. |
| HOME_TEAM_NAME | character | Home team name. |
| HOME_TEAM_ABBREVIATION | character |  |
| GAME_STATUS | character | Game status label. |
| GAME_STATUS_TEXT | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| IS_AVAILABLE | character |  |
| PT_XYZ_AVAILABLE | character | Pt xyz available. |

## Details

     nba_videostatus(game_date = '2023-03-10', league_id = '00')

## See also

Other NBA Video Functions:
[`nba_videodetailsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videodetailsasset.md),
[`nba_videodetails()`](https://hoopR.sportsdataverse.org/reference/nba_videodetails.md),
[`nba_videoeventsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videoeventsasset.md),
[`nba_videoevents()`](https://hoopR.sportsdataverse.org/reference/nba_videoevents.md)

## Author

Saiem Gilani
