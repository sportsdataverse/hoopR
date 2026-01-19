# **Get NBA Stats API Draft Combine Non-Stationary Shooting**

**Get NBA Stats API Draft Combine Non-Stationary Shooting**

**Get NBA Stats API Draft Combine Non-Stationary Shooting**

## Usage

``` r
nba_draftcombinenonstationaryshooting(
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

|                                      |           |
|--------------------------------------|-----------|
| col_name                             | types     |
| TEMP_PLAYER_ID                       | character |
| PLAYER_ID                            | character |
| FIRST_NAME                           | character |
| LAST_NAME                            | character |
| PLAYER_NAME                          | character |
| POSITION                             | character |
| OFF_DRIB_FIFTEEN_BREAK_LEFT_MADE     | character |
| OFF_DRIB_FIFTEEN_BREAK_LEFT_ATTEMPT  | character |
| OFF_DRIB_FIFTEEN_BREAK_LEFT_PCT      | character |
| OFF_DRIB_FIFTEEN_TOP_KEY_MADE        | character |
| OFF_DRIB_FIFTEEN_TOP_KEY_ATTEMPT     | character |
| OFF_DRIB_FIFTEEN_TOP_KEY_PCT         | character |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT_MADE    | character |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT_ATTEMPT | character |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT_PCT     | character |
| OFF_DRIB_COLLEGE_BREAK_LEFT_MADE     | character |
| OFF_DRIB_COLLEGE_BREAK_LEFT_ATTEMPT  | character |
| OFF_DRIB_COLLEGE_BREAK_LEFT_PCT      | character |
| OFF_DRIB_COLLEGE_TOP_KEY_MADE        | character |
| OFF_DRIB_COLLEGE_TOP_KEY_ATTEMPT     | character |
| OFF_DRIB_COLLEGE_TOP_KEY_PCT         | character |
| OFF_DRIB_COLLEGE_BREAK_RIGHT_MADE    | character |
| OFF_DRIB_COLLEGE_BREAK_RIGHT_ATTEMPT | character |
| OFF_DRIB_COLLEGE_BREAK_RIGHT_PCT     | character |
| ON_MOVE_FIFTEEN_MADE                 | character |
| ON_MOVE_FIFTEEN_ATTEMPT              | character |
| ON_MOVE_FIFTEEN_PCT                  | character |
| ON_MOVE_COLLEGE_MADE                 | character |
| ON_MOVE_COLLEGE_ATTEMPT              | character |
| ON_MOVE_COLLEGE_PCT                  | character |

## Details

[Draft Combine Non-stationary
Shooting](https://www.nba.com/stats/draft/combine-non-stationary)

     nba_draftcombinenonstationaryshooting(season_year = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
