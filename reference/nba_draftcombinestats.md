# **Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Drill Results**

**Get NBA Stats API Draft Combine Non-Stationary Shooting**

**Get NBA Stats API Draft Combine Player Anthropological Measurements**

**Get NBA Stats API Draft Combine - Spot Shooting**

## Usage

``` r
nba_draftcombinestats(
  league_id = "00",
  season_year = most_recent_nba_season() - 1,
  ...
)

nba_draftcombinedrillresults(
  league_id = "00",
  season_year = most_recent_nba_season() - 1,
  ...
)

nba_draftcombinenonstationaryshooting(
  league_id = "00",
  season_year = most_recent_nba_season() - 1,
  ...
)

nba_draftcombineplayeranthro(
  league_id = "00",
  season_year = most_recent_nba_season() - 1,
  ...
)

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

Returns a named list of data frames: DraftCombineStats

**DraftCombineStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| SEASON | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| PLAYER_ID | character | Unique player identifier. |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| PLAYER_NAME | character | Player name. |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| HEIGHT_WO_SHOES | character |  |
| HEIGHT_WO_SHOES_FT_IN | character |  |
| HEIGHT_W_SHOES | character |  |
| HEIGHT_W_SHOES_FT_IN | character |  |
| WEIGHT | character | Player weight in pounds. |
| WINGSPAN | character |  |
| WINGSPAN_FT_IN | character |  |
| STANDING_REACH | character |  |
| STANDING_REACH_FT_IN | character |  |
| BODY_FAT_PCT | character |  |
| HAND_LENGTH | character |  |
| HAND_WIDTH | character |  |
| STANDING_VERTICAL_LEAP | character |  |
| MAX_VERTICAL_LEAP | character |  |
| LANE_AGILITY_TIME | character |  |
| MODIFIED_LANE_AGILITY_TIME | character |  |
| THREE_QUARTER_SPRINT | character |  |
| BENCH_PRESS | character |  |
| SPOT_FIFTEEN_CORNER_LEFT | character |  |
| SPOT_FIFTEEN_BREAK_LEFT | character |  |
| SPOT_FIFTEEN_TOP_KEY | character |  |
| SPOT_FIFTEEN_BREAK_RIGHT | character |  |
| SPOT_FIFTEEN_CORNER_RIGHT | character |  |
| SPOT_COLLEGE_CORNER_LEFT | character |  |
| SPOT_COLLEGE_BREAK_LEFT | character |  |
| SPOT_COLLEGE_TOP_KEY | character |  |
| SPOT_COLLEGE_BREAK_RIGHT | character |  |
| SPOT_COLLEGE_CORNER_RIGHT | character |  |
| SPOT_NBA_CORNER_LEFT | character |  |
| SPOT_NBA_BREAK_LEFT | character |  |
| SPOT_NBA_TOP_KEY | character |  |
| SPOT_NBA_BREAK_RIGHT | character |  |
| SPOT_NBA_CORNER_RIGHT | character |  |
| OFF_DRIB_FIFTEEN_BREAK_LEFT | character |  |
| OFF_DRIB_FIFTEEN_TOP_KEY | character |  |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT | character |  |
| OFF_DRIB_COLLEGE_BREAK_LEFT | character |  |
| OFF_DRIB_COLLEGE_TOP_KEY | character |  |
| OFF_DRIB_COLLEGE_BREAK_RIGHT | character |  |
| ON_MOVE_FIFTEEN | character |  |
| ON_MOVE_COLLEGE | character |  |

Returns a named list of data frames: Results

**Results**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEMP_PLAYER_ID | character |  |
| PLAYER_ID | character | Unique player identifier. |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| PLAYER_NAME | character | Player name. |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| STANDING_VERTICAL_LEAP | character |  |
| MAX_VERTICAL_LEAP | character |  |
| LANE_AGILITY_TIME | character |  |
| MODIFIED_LANE_AGILITY_TIME | character |  |
| THREE_QUARTER_SPRINT | character |  |
| BENCH_PRESS | character |  |

Returns a named list of data frames: Results

**Results**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEMP_PLAYER_ID | character |  |
| PLAYER_ID | character | Unique player identifier. |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| PLAYER_NAME | character | Player name. |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| OFF_DRIB_FIFTEEN_BREAK_LEFT_MADE | character |  |
| OFF_DRIB_FIFTEEN_BREAK_LEFT_ATTEMPT | character |  |
| OFF_DRIB_FIFTEEN_BREAK_LEFT_PCT | character |  |
| OFF_DRIB_FIFTEEN_TOP_KEY_MADE | character |  |
| OFF_DRIB_FIFTEEN_TOP_KEY_ATTEMPT | character |  |
| OFF_DRIB_FIFTEEN_TOP_KEY_PCT | character |  |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT_MADE | character |  |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT_ATTEMPT | character |  |
| OFF_DRIB_FIFTEEN_BREAK_RIGHT_PCT | character |  |
| OFF_DRIB_COLLEGE_BREAK_LEFT_MADE | character |  |
| OFF_DRIB_COLLEGE_BREAK_LEFT_ATTEMPT | character |  |
| OFF_DRIB_COLLEGE_BREAK_LEFT_PCT | character |  |
| OFF_DRIB_COLLEGE_TOP_KEY_MADE | character |  |
| OFF_DRIB_COLLEGE_TOP_KEY_ATTEMPT | character |  |
| OFF_DRIB_COLLEGE_TOP_KEY_PCT | character |  |
| OFF_DRIB_COLLEGE_BREAK_RIGHT_MADE | character |  |
| OFF_DRIB_COLLEGE_BREAK_RIGHT_ATTEMPT | character |  |
| OFF_DRIB_COLLEGE_BREAK_RIGHT_PCT | character |  |
| ON_MOVE_FIFTEEN_MADE | character |  |
| ON_MOVE_FIFTEEN_ATTEMPT | character |  |
| ON_MOVE_FIFTEEN_PCT | character |  |
| ON_MOVE_COLLEGE_MADE | character |  |
| ON_MOVE_COLLEGE_ATTEMPT | character |  |
| ON_MOVE_COLLEGE_PCT | character |  |

Returns a named list of data frames: Results

**Results**

|                       |           |                                         |
|-----------------------|-----------|-----------------------------------------|
| col_name              | types     | description                             |
| TEMP_PLAYER_ID        | character |                                         |
| PLAYER_ID             | character | Unique player identifier.               |
| FIRST_NAME            | character | Player's first name.                    |
| LAST_NAME             | character | Player's last name.                     |
| PLAYER_NAME           | character | Player name.                            |
| POSITION              | character | Listed roster position (G, F, C, etc.). |
| HEIGHT_WO_SHOES       | character |                                         |
| HEIGHT_WO_SHOES_FT_IN | character |                                         |
| HEIGHT_W_SHOES        | character |                                         |
| HEIGHT_W_SHOES_FT_IN  | character |                                         |
| WEIGHT                | character | Player weight in pounds.                |
| WINGSPAN              | character |                                         |
| WINGSPAN_FT_IN        | character |                                         |
| STANDING_REACH        | character |                                         |
| STANDING_REACH_FT_IN  | character |                                         |
| BODY_FAT_PCT          | character |                                         |
| HAND_LENGTH           | character |                                         |
| HAND_WIDTH            | character |                                         |

Returns a named list of data frames: Results

**Results**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEMP_PLAYER_ID | character |  |
| PLAYER_ID | character | Unique player identifier. |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| PLAYER_NAME | character | Player name. |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| FIFTEEN_CORNER_LEFT_MADE | character |  |
| FIFTEEN_CORNER_LEFT_ATTEMPT | character |  |
| FIFTEEN_CORNER_LEFT_PCT | character |  |
| FIFTEEN_BREAK_LEFT_MADE | character |  |
| FIFTEEN_BREAK_LEFT_ATTEMPT | character |  |
| FIFTEEN_BREAK_LEFT_PCT | character |  |
| FIFTEEN_TOP_KEY_MADE | character |  |
| FIFTEEN_TOP_KEY_ATTEMPT | character |  |
| FIFTEEN_TOP_KEY_PCT | character |  |
| FIFTEEN_BREAK_RIGHT_MADE | character |  |
| FIFTEEN_BREAK_RIGHT_ATTEMPT | character |  |
| FIFTEEN_BREAK_RIGHT_PCT | character |  |
| FIFTEEN_CORNER_RIGHT_MADE | character |  |
| FIFTEEN_CORNER_RIGHT_ATTEMPT | character |  |
| FIFTEEN_CORNER_RIGHT_PCT | character |  |
| COLLEGE_CORNER_LEFT_MADE | character |  |
| COLLEGE_CORNER_LEFT_ATTEMPT | character |  |
| COLLEGE_CORNER_LEFT_PCT | character |  |
| COLLEGE_BREAK_LEFT_MADE | character |  |
| COLLEGE_BREAK_LEFT_ATTEMPT | character |  |
| COLLEGE_BREAK_LEFT_PCT | character |  |
| COLLEGE_TOP_KEY_MADE | character |  |
| COLLEGE_TOP_KEY_ATTEMPT | character |  |
| COLLEGE_TOP_KEY_PCT | character |  |
| COLLEGE_BREAK_RIGHT_MADE | character |  |
| COLLEGE_BREAK_RIGHT_ATTEMPT | character |  |
| COLLEGE_BREAK_RIGHT_PCT | character |  |
| COLLEGE_CORNER_RIGHT_MADE | character |  |
| COLLEGE_CORNER_RIGHT_ATTEMPT | character |  |
| COLLEGE_CORNER_RIGHT_PCT | character |  |
| NBA_CORNER_LEFT_MADE | character |  |
| NBA_CORNER_LEFT_ATTEMPT | character |  |
| NBA_CORNER_LEFT_PCT | character |  |
| NBA_BREAK_LEFT_MADE | character |  |
| NBA_BREAK_LEFT_ATTEMPT | character |  |
| NBA_BREAK_LEFT_PCT | character |  |
| NBA_TOP_KEY_MADE | character |  |
| NBA_TOP_KEY_ATTEMPT | character |  |
| NBA_TOP_KEY_PCT | character |  |
| NBA_BREAK_RIGHT_MADE | character |  |
| NBA_BREAK_RIGHT_ATTEMPT | character |  |
| NBA_BREAK_RIGHT_PCT | character |  |
| NBA_CORNER_RIGHT_MADE | character |  |
| NBA_CORNER_RIGHT_ATTEMPT | character |  |
| NBA_CORNER_RIGHT_PCT | character |  |

## Details

     nba_draftcombinestats(season_year = most_recent_nba_season() - 1)

[Draft Combine](https://www.nba.com/stats/draft/combine)

     nba_draftcombinedrillresults(season_year = most_recent_nba_season() - 1)

[Draft Combine Non-stationary
Shooting](https://www.nba.com/stats/draft/combine-non-stationary)

     nba_draftcombinenonstationaryshooting(season_year = most_recent_nba_season() - 1)

[Draft Combine Player Anthro](https://www.nba.com/stats/draft/combine)

     nba_draftcombineplayeranthro(season_year = most_recent_nba_season() - 1)

[Draft Combine Spot
Shooting](https://www.nba.com/stats/draft/combine-spot-up)

     nba_draftcombinespotshooting(season_year = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftboard()`](https://hoopR.sportsdataverse.org/reference/nba_draftboard.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
