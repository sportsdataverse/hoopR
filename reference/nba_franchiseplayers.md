# **Get NBA Stats API Franchise Players**

**Get NBA Stats API Franchise Players**

**Get NBA Stats API Franchise Players**

## Usage

``` r
nba_franchiseplayers(
  league_id = "00",
  per_mode = "Totals",
  season_type = "Regular Season",
  team_id = "1610612739",
  ...
)
```

## Arguments

- league_id:

  league_id

- per_mode:

  per_mode

- season_type:

  season_type

- team_id:

  team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: FranchisePlayers

**FranchisePlayers**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| LEAGUE_ID        | character |
| TEAM_ID          | character |
| TEAM             | character |
| PERSON_ID        | character |
| PLAYER           | character |
| SEASON_TYPE      | character |
| ACTIVE_WITH_TEAM | character |
| GP               | character |
| FGM              | character |
| FGA              | character |
| FG_PCT           | character |
| FG3M             | character |
| FG3A             | character |
| FG3_PCT          | character |
| FTM              | character |
| FTA              | character |
| FT_PCT           | character |
| OREB             | character |
| DREB             | character |
| REB              | character |
| AST              | character |
| PF               | character |
| STL              | character |
| TOV              | character |
| BLK              | character |
| PTS              | character |

## Details

[Franchise
Players](https://www.nba.com/stats/team/1610612739/franchise-leaders)

     nba_franchiseplayers(league_id = '00', team_id = '1610612739')
     nba_franchiseplayers(league_id = '00', season_type = 'Playoffs', team_id = '1610612739')

## See also

Other NBA Franchise Functions:
[`nba_franchisehistory()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md),
[`nba_franchiseleaders()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaders.md),
[`nba_franchiseleaderswrank()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaderswrank.md)

## Author

Saiem Gilani
