# **Get NBA Stats API Franchise Leaders**

**Get NBA Stats API Franchise Leaders**

**Get NBA Stats API Franchise Leaders**

## Usage

``` r
nba_franchiseleaders(league_id = "00", team_id = "1610612739", ...)
```

## Arguments

- league_id:

  league_id

- team_id:

  team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: FranchiseLeaders

**FranchiseLeaders**

|               |           |                         |
|---------------|-----------|-------------------------|
| col_name      | types     | description             |
| TEAM_ID       | character | Unique team identifier. |
| PTS           | character | Points scored.          |
| PTS_PERSON_ID | character |                         |
| PTS_PLAYER    | character |                         |
| AST           | character | Assists.                |
| AST_PERSON_ID | character |                         |
| AST_PLAYER    | character |                         |
| REB           | character | Total rebounds.         |
| REB_PERSON_ID | character |                         |
| REB_PLAYER    | character |                         |
| BLK           | character | Blocks.                 |
| BLK_PERSON_ID | character |                         |
| BLK_PLAYER    | character |                         |
| STL           | character | Steals.                 |
| STL_PERSON_ID | character |                         |
| STL_PLAYER    | character |                         |

## Details

[Franchise
Leaders](https://www.nba.com/stats/team/1610612737/franchise-leaders)

     nba_franchiseleaders(league_id = '00', team_id = '1610612739')

## See also

Other NBA Franchise Functions:
[`nba_franchisehistory()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md),
[`nba_franchiseleaderswrank()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaderswrank.md),
[`nba_franchiseplayers()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseplayers.md)

## Author

Saiem Gilani
