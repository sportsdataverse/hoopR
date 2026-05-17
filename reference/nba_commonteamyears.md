# **Get NBA Stats API Common Team Years**

**Get NBA Stats API Common Team Years**

**Get NBA Stats API Common Team Years**

## Usage

``` r
nba_commonteamyears(league_id = "00", ...)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: TeamYears

**TeamYears**

|              |           |                                  |
|--------------|-----------|----------------------------------|
| col_name     | types     | description                      |
| LEAGUE_ID    | character | League identifier ('10' = WNBA). |
| TEAM_ID      | character | Unique team identifier.          |
| MIN_YEAR     | character |                                  |
| MAX_YEAR     | character |                                  |
| ABBREVIATION | character | Short abbreviation.              |

## Details

     nba_commonteamyears(league_id = '00')

## See also

Other NBA Roster Functions:
[`nba_commonallplayers()`](https://hoopR.sportsdataverse.org/reference/nba_commonallplayers.md),
[`nba_commonplayerinfo()`](https://hoopR.sportsdataverse.org/reference/nba_commonplayerinfo.md),
[`nba_commonteamroster()`](https://hoopR.sportsdataverse.org/reference/nba_commonteamroster.md)

## Author

Saiem Gilani
