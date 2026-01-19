# **Get NBA Stats API Draft Combine Player Anthropological Measurements**

**Get NBA Stats API Draft Combine Player Anthropological Measurements**

**Get NBA Stats API Draft Combine Player Anthropological Measurements**

## Usage

``` r
nba_draftcombineplayeranthro(
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

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| TEMP_PLAYER_ID        | character |
| PLAYER_ID             | character |
| FIRST_NAME            | character |
| LAST_NAME             | character |
| PLAYER_NAME           | character |
| POSITION              | character |
| HEIGHT_WO_SHOES       | character |
| HEIGHT_WO_SHOES_FT_IN | character |
| HEIGHT_W_SHOES        | character |
| HEIGHT_W_SHOES_FT_IN  | character |
| WEIGHT                | character |
| WINGSPAN              | character |
| WINGSPAN_FT_IN        | character |
| STANDING_REACH        | character |
| STANDING_REACH_FT_IN  | character |
| BODY_FAT_PCT          | character |
| HAND_LENGTH           | character |
| HAND_WIDTH            | character |

## Details

[Draft Combine Player Anthro](https://www.nba.com/stats/draft/combine)

     nba_draftcombineplayeranthro(season_year = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
