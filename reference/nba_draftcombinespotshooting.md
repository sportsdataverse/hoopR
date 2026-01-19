# **Get NBA Stats API Draft Combine - Spot Shooting**

**Get NBA Stats API Draft Combine - Spot Shooting**

**Get NBA Stats API Draft Combine - Spot Shooting**

## Usage

``` r
nba_draftcombinespotshooting(
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

|                              |           |
|------------------------------|-----------|
| col_name                     | types     |
| TEMP_PLAYER_ID               | character |
| PLAYER_ID                    | character |
| FIRST_NAME                   | character |
| LAST_NAME                    | character |
| PLAYER_NAME                  | character |
| POSITION                     | character |
| FIFTEEN_CORNER_LEFT_MADE     | character |
| FIFTEEN_CORNER_LEFT_ATTEMPT  | character |
| FIFTEEN_CORNER_LEFT_PCT      | character |
| FIFTEEN_BREAK_LEFT_MADE      | character |
| FIFTEEN_BREAK_LEFT_ATTEMPT   | character |
| FIFTEEN_BREAK_LEFT_PCT       | character |
| FIFTEEN_TOP_KEY_MADE         | character |
| FIFTEEN_TOP_KEY_ATTEMPT      | character |
| FIFTEEN_TOP_KEY_PCT          | character |
| FIFTEEN_BREAK_RIGHT_MADE     | character |
| FIFTEEN_BREAK_RIGHT_ATTEMPT  | character |
| FIFTEEN_BREAK_RIGHT_PCT      | character |
| FIFTEEN_CORNER_RIGHT_MADE    | character |
| FIFTEEN_CORNER_RIGHT_ATTEMPT | character |
| FIFTEEN_CORNER_RIGHT_PCT     | character |
| COLLEGE_CORNER_LEFT_MADE     | character |
| COLLEGE_CORNER_LEFT_ATTEMPT  | character |
| COLLEGE_CORNER_LEFT_PCT      | character |
| COLLEGE_BREAK_LEFT_MADE      | character |
| COLLEGE_BREAK_LEFT_ATTEMPT   | character |
| COLLEGE_BREAK_LEFT_PCT       | character |
| COLLEGE_TOP_KEY_MADE         | character |
| COLLEGE_TOP_KEY_ATTEMPT      | character |
| COLLEGE_TOP_KEY_PCT          | character |
| COLLEGE_BREAK_RIGHT_MADE     | character |
| COLLEGE_BREAK_RIGHT_ATTEMPT  | character |
| COLLEGE_BREAK_RIGHT_PCT      | character |
| COLLEGE_CORNER_RIGHT_MADE    | character |
| COLLEGE_CORNER_RIGHT_ATTEMPT | character |
| COLLEGE_CORNER_RIGHT_PCT     | character |
| NBA_CORNER_LEFT_MADE         | character |
| NBA_CORNER_LEFT_ATTEMPT      | character |
| NBA_CORNER_LEFT_PCT          | character |
| NBA_BREAK_LEFT_MADE          | character |
| NBA_BREAK_LEFT_ATTEMPT       | character |
| NBA_BREAK_LEFT_PCT           | character |
| NBA_TOP_KEY_MADE             | character |
| NBA_TOP_KEY_ATTEMPT          | character |
| NBA_TOP_KEY_PCT              | character |
| NBA_BREAK_RIGHT_MADE         | character |
| NBA_BREAK_RIGHT_ATTEMPT      | character |
| NBA_BREAK_RIGHT_PCT          | character |
| NBA_CORNER_RIGHT_MADE        | character |
| NBA_CORNER_RIGHT_ATTEMPT     | character |
| NBA_CORNER_RIGHT_PCT         | character |

## Details

[Draft Combine Spot
Shooting](https://www.nba.com/stats/draft/combine-spot-up)

     nba_draftcombinespotshooting(season_year = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
