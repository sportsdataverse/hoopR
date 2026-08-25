# **Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Stats**

**Get NBA Stats API Draft Combine Drill Results**

**Get NBA Stats API Draft Combine Non-Stationary Shooting**

**Get NBA Stats API Draft Combine Player Anthropological Measurements**

**Get NBA Stats API Draft Combine - Spot Shooting**

**Get NBA Stats API Draft History**

## Usage

``` r
nba_draftboard(season = most_recent_nba_season() - 1, ...)

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

- season:

  season

- ...:

  Additional arguments passed to an underlying function like httr.

- league_id:

  league_id

- season_year:

  season_year

- college:

  college

- overall_pick:

  overall_pick

- round_pick:

  round_pick

- round_num:

  round_num

- team_id:

  team_id

- top_x:

  top_x

## Value

Returns a named list of data frames: Picks, TeamsWithoutPicks,
LiveDetails

**Picks**

|  |  |  |
|----|----|----|
| col_name | types | description |
| pick_number | integer | Pick number. |
| pick_details | character | Pick details. |
| team_id | integer | Unique team identifier. |
| team_type | character | Team type. |
| team_season | integer | Team season. |
| team_team_id | integer | Unique identifier for team team. |
| team_permalink | character | Team permalink. |
| team_app_url | character | URL for team app. |
| team_trade_details | list | Team trade details. |
| team_team_name | character | Team team name. |
| team_team_abbr | character | Team team abbr. |
| team_picked_first_round | logical | Team picked first round. |
| team_picked_second_round | logical | Team picked second round. |
| team_team_record_season | character | Team team record season. |
| team_team_record_wins_and_losses | character | Team team record wins and losses. |
| team_team_record_season_finish | character | Team team record season finish. |
| team_team_record_playoffs_finish | character | Team team record playoffs finish. |
| prospect_id | integer | Unique identifier for prospect. |
| prospect_type | character | Prospect type. |
| prospect_season | integer | Prospect season. |
| prospect_display_name | character | Prospect display name. |
| prospect_first_name | character | Prospect first name. |
| prospect_last_name | character | Prospect last name. |
| prospect_permalink | character | Prospect permalink. |
| prospect_app_url | character | URL for prospect app. |
| prospect_position | character | Prospect position. |
| prospect_weight_lbs | integer | Prospect weight lbs. |
| prospect_school | character | Prospect school. |
| prospect_status | character | Prospect status. |
| prospect_birthday | character | Prospect birthday. |
| prospect_country | character | Prospect country. |
| prospect_trade_details | list | Prospect trade details. |
| prospect_height_feet_and_inches | character | Prospect height feet and inches. |
| prospect_height_inches_only | integer | Prospect height inches only. |

**TeamsWithoutPicks**

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | integer | Id. |
| type | character | Record type / category. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| team_id | integer | Unique team identifier. |
| team_record | data.frame | Team record string (e.g. '8-3' or '8-3 Overall'). |
| permalink | character | Permalink. |
| app_url | character | URL for app. |
| trade_details | list | Trade details. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbr | character | Team abbr. |
| picked_second_round | logical | Picked second round. |
| picked_first_round | logical | Picked first round. |

**LiveDetails**

|                                |         |                                 |
|--------------------------------|---------|---------------------------------|
| col_name                       | types   | description                     |
| is_draft_live                  | logical | Is draft live.                  |
| live_draft_current_pick_number | numeric | Live draft current pick number. |

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

Returns a named list of data frames: DraftHistory

**DraftHistory**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| PLAYER_NAME | character | Player name. |
| SEASON | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| ROUND_NUMBER | character | Numeric round. |
| ROUND_PICK | character |  |
| OVERALL_PICK | character |  |
| DRAFT_TYPE | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| ORGANIZATION | character |  |
| ORGANIZATION_TYPE | character |  |
| PLAYER_PROFILE_FLAG | character |  |

## Details

      nba_draftboard(season = most_recent_nba_season() - 1)

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

[Draft History](https://www.nba.com/stats/draft/history)

     nba_drafthistory(season = most_recent_nba_season() - 1)

## Author

Saiem Gilani
