# **Get NBA Stats API Draft History**

**Get NBA Stats API Draft History**

## Usage

``` r
nba_drafthistory(
  league_id = "00",
  college = "",
  overall_pick = "",
  round_pick = "",
  round_num = "",
  season = most_recent_nba_season() - 1,
  team_id = "",
  top_x = "",
  ...
)
```

## Arguments

- league_id:

  league_id

- college:

  college

- overall_pick:

  overall_pick

- round_pick:

  round_pick

- round_num:

  round_num

- season:

  season

- team_id:

  team_id

- top_x:

  top_x

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: DraftHistory

**DraftHistory**

|                     |           |
|---------------------|-----------|
| col_name            | types     |
| PERSON_ID           | character |
| PLAYER_NAME         | character |
| SEASON              | character |
| ROUND_NUMBER        | character |
| ROUND_PICK          | character |
| OVERALL_PICK        | character |
| DRAFT_TYPE          | character |
| TEAM_ID             | character |
| TEAM_CITY           | character |
| TEAM_NAME           | character |
| TEAM_ABBREVIATION   | character |
| ORGANIZATION        | character |
| ORGANIZATION_TYPE   | character |
| PLAYER_PROFILE_FLAG | character |

## Details

[Draft History](https://www.nba.com/stats/draft/history)

     nba_drafthistory(season = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md)

## Author

Saiem Gilani
