# **Get NBA Stats API Draft Combine Drill Results**

**Get NBA Stats API Draft Combine Drill Results**

**Get NBA Stats API Draft Combine Drill Results**

## Usage

``` r
nba_draftcombinedrillresults(
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

Returns a named list of data frames: Results

**Results**

|                            |           |
|----------------------------|-----------|
| col_name                   | types     |
| TEMP_PLAYER_ID             | character |
| PLAYER_ID                  | character |
| FIRST_NAME                 | character |
| LAST_NAME                  | character |
| PLAYER_NAME                | character |
| POSITION                   | character |
| STANDING_VERTICAL_LEAP     | character |
| MAX_VERTICAL_LEAP          | character |
| LANE_AGILITY_TIME          | character |
| MODIFIED_LANE_AGILITY_TIME | character |
| THREE_QUARTER_SPRINT       | character |
| BENCH_PRESS                | character |

## Details

[Draft Combine](https://www.nba.com/stats/draft/combine)

     nba_draftcombinedrillresults(season_year = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
