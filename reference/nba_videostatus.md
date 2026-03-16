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

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| GAME_ID                   | character |
| GAME_DATE                 | character |
| VISITOR_TEAM_ID           | character |
| VISITOR_TEAM_CITY         | character |
| VISITOR_TEAM_NAME         | character |
| VISITOR_TEAM_ABBREVIATION | character |
| HOME_TEAM_ID              | character |
| HOME_TEAM_CITY            | character |
| HOME_TEAM_NAME            | character |
| HOME_TEAM_ABBREVIATION    | character |
| GAME_STATUS               | character |
| GAME_STATUS_TEXT          | character |
| IS_AVAILABLE              | character |
| PT_XYZ_AVAILABLE          | character |

## Details

     nba_videostatus(game_date = '2023-03-10', league_id = '00')

## See also

Other NBA Video Functions:
[`nba_videodetails()`](https://hoopR.sportsdataverse.org/reference/nba_videodetails.md),
[`nba_videodetailsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videodetailsasset.md),
[`nba_videoevents()`](https://hoopR.sportsdataverse.org/reference/nba_videoevents.md),
[`nba_videoeventsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videoeventsasset.md)

## Author

Saiem Gilani
