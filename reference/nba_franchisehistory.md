# **Get NBA Stats API Franchise History**

**Get NBA Stats API Franchise History**

**Get NBA Stats API Franchise History**

## Usage

``` r
nba_franchisehistory(league_id = "00", ...)
```

## Arguments

- league_id:

  league_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: DefunctTeams, FranchiseHistory

**FranchiseHistory**

|                |           |
|----------------|-----------|
| col_name       | types     |
| LEAGUE_ID      | character |
| TEAM_ID        | character |
| TEAM_CITY      | character |
| TEAM_NAME      | character |
| START_YEAR     | character |
| END_YEAR       | character |
| YEARS          | character |
| GAMES          | character |
| WINS           | character |
| LOSSES         | character |
| WIN_PCT        | character |
| PO_APPEARANCES | character |
| DIV_TITLES     | character |
| CONF_TITLES    | character |
| LEAGUE_TITLES  | character |

**DefunctTeams**

|                |           |
|----------------|-----------|
| col_name       | types     |
| LEAGUE_ID      | character |
| TEAM_ID        | character |
| TEAM_CITY      | character |
| TEAM_NAME      | character |
| START_YEAR     | character |
| END_YEAR       | character |
| YEARS          | character |
| GAMES          | character |
| WINS           | character |
| LOSSES         | character |
| WIN_PCT        | character |
| PO_APPEARANCES | character |
| DIV_TITLES     | character |
| CONF_TITLES    | character |
| LEAGUE_TITLES  | character |

## Details

[Franchise History](https://www.nba.com/stats/history)

     nba_franchisehistory(league_id = '00')
     nba_franchisehistory(league_id = '01')
     nba_franchisehistory(league_id = '10')
     nba_franchisehistory(league_id = '20')

## See also

Other NBA Franchise Functions:
[`nba_franchiseleaders()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaders.md),
[`nba_franchiseleaderswrank()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaderswrank.md),
[`nba_franchiseplayers()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseplayers.md)

## Author

Saiem Gilani
