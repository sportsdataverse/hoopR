# **Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**

**Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**

**Get NBA Stats API League Dashboard Player Tracking - Opponent Shots**

**Get NBA Stats API League Dashboard Player Biographical Stats**

**Get NBA Stats API League Dashboard Player Biographical Stats**

**Get NBA Stats API League Dashboard by Player Clutch Splits**

**Get NBA Stats API League Dashboard by Player Clutch Splits**

**Get NBA Stats API League Dashboard Player Tracking - Player Shots**

**Get NBA Stats API League Dashboard Player Tracking - Player Shots**

**Get NBA Stats API League Dashboard Player Stats**

**Get NBA Stats API League Dashboard Player Stats**

**Get NBA Stats API League Dashboard Player Shot Locations**

**Get NBA Stats API League Dashboard Player Shot Locations**

**Get NBA Stats API League Dashboard Player Tracking - Defense**

**Get NBA Stats API League Dashboard Player Tracking - Defense**

**Get NBA Stats API League Dashboard Player Tracking - Stats**

**Get NBA Stats API League Dashboard Player Tracking - Stats**

**Get NBA Stats API League Dashboard Player Tracking - Team Defense**

**Get NBA Stats API League Dashboard Player Tracking - Team Defense**

**Get NBA Stats API League Dashboard by Team Clutch Splits**

**Get NBA Stats API League Dashboard by Team Clutch Splits**

**Get NBA Stats API League Dashboard Player Tracking - Team Shots**

**Get NBA Stats API League Dashboard Player Tracking - Team Shots**

**Get NBA Stats API League Dashboard Team Stats**

**Get NBA Stats API League Dashboard Team Stats**

**Get NBA Stats API League Dashboard Team Shot Locations**

**Get NBA Stats API League Dashboard Team Shot Locations**

## Usage

``` r
nba_leaguedashoppptshot(
  close_def_dist_range = "",
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  dribble_range = "",
  game_segment = "",
  general_range = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  plus_minus = "N",
  rank = "Y",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  shot_dist_range = "",
  team_id = "",
  touch_time_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguedashplayerbiostats(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_segment = "",
  game_scope = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "Totals",
  period = "",
  player_experience = "",
  player_position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  touch_time_range = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashplayerclutch(
  ahead_behind = "Ahead or Behind",
  clutch_time = "Last 5 Minutes",
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_scope = "",
  game_segment = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  pace_adjust = "N",
  plus_minus = "N",
  point_diff = 5,
  po_round = "",
  per_mode = "Totals",
  period = 0,
  player_experience = "",
  player_position = "",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  touch_time_range = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashplayerptshot(
  close_def_dist_range = "",
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  distance_range = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  dribble_range = "",
  game_scope = "",
  game_segment = "",
  general_range = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  pace_adjust = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  player_experience = "",
  player_position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  shot_dist_range = "",
  starter_bench = "",
  team_id = "",
  touch_time_range = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashplayerstats(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_scope = "",
  game_segment = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  pace_adjust = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  player_experience = "",
  player_position = "",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  two_way = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashplayershotlocations(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  distance_range = "By Zone",
  division = "",
  draft_pick = "",
  draft_year = "",
  dribble_range = "",
  game_scope = "",
  game_segment = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_experience = "",
  player_position = "",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashptdefend(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  defense_category = "Overall",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_segment = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "Totals",
  period = "",
  player_experience = "",
  player_id = "",
  player_position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashptstats(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_scope = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "PerGame",
  period = "",
  player_experience = "",
  player_or_team = "Player",
  player_position = "",
  pt_measure_type = "Drives",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)

nba_leaguedashptteamdefend(
  conference = "",
  date_from = "",
  date_to = "",
  defense_category = "Overall",
  division = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "PerGame",
  period = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguedashteamclutch(
  ahead_behind = "Ahead or Behind",
  clutch_time = "Last 5 Minutes",
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  game_scope = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  pace_adjust = "N",
  plus_minus = "N",
  point_diff = 5,
  po_round = "",
  per_mode = "Totals",
  period = 0,
  player_experience = "",
  player_position = "",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguedashteamptshot(
  close_def_dist_range = "",
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  dribble_range = "",
  game_segment = "",
  general_range = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  shot_dist_range = "",
  team_id = "",
  touch_time_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguedashteamstats(
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  game_scope = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  two_way = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguedashteamshotlocations(
  conference = "",
  date_from = "",
  date_to = "",
  distance_range = "By Zone",
  division = "",
  game_scope = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_experience = "",
  player_position = "",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  ...
)
```

## Arguments

- close_def_dist_range:

  close_def_dist_range

- conference:

  conference

- date_from:

  date_from

- date_to:

  date_to

- division:

  division

- dribble_range:

  dribble_range

- game_segment:

  game_segment

- general_range:

  general_range

- last_n_games:

  last_n_games

- league_id:

  league_id

- location:

  location

- measure_type:

  measure_type

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- po_round:

  po_round

- pace_adjust:

  pace_adjust

- per_mode:

  per_mode

- period:

  period

- plus_minus:

  plus_minus

- rank:

  rank

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- shot_clock_range:

  shot_clock_range

- shot_dist_range:

  shot_dist_range

- team_id:

  team_id

- touch_time_range:

  touch_time_range

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

- college:

  college

- country:

  country

- draft_pick:

  draft_pick

- draft_year:

  draft_year

- game_scope:

  game_scope

- height:

  height

- player_experience:

  player_experience

- player_position:

  player_position

- starter_bench:

  starter_bench

- weight:

  weight

- ahead_behind:

  ahead_behind

- clutch_time:

  clutch_time

- point_diff:

  point_diff

- distance_range:

  distance_range

- two_way:

  two_way

- defense_category:

  defense_category

- player_id:

  player_id

- player_or_team:

  player_or_team

- pt_measure_type:

  pt_measure_type

## Value

Returns a named list of data frames: LeagueDashPTShots

**LeagueDashPTShots**

Columns as documented in the shared
[nba_leaguedashoppptshot_leaguedashptshots_schema](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot_leaguedashptshots_schema.md)
table.

Returns a named list of data frames: LeagueDashPlayerBioStats

**LeagueDashPlayerBioStats**

|                      |           |                                       |
|----------------------|-----------|---------------------------------------|
| col_name             | types     | description                           |
| PLAYER_ID            | character | Unique player identifier.             |
| PLAYER_NAME          | character | Player name.                          |
| TEAM_ID              | character | Unique team identifier.               |
| TEAM_ABBREVIATION    | character | Short team abbreviation (e.g. 'LAS'). |
| AGE                  | character | Player age (in years).                |
| PLAYER_HEIGHT        | character |                                       |
| PLAYER_HEIGHT_INCHES | character |                                       |
| PLAYER_WEIGHT        | character |                                       |
| COLLEGE              | character | College or school attended.           |
| COUNTRY              | character | Country (full name or code).          |
| DRAFT_YEAR           | character | Draft year (4-digit).                 |
| DRAFT_ROUND          | character | Round of the draft selection.         |
| DRAFT_NUMBER         | character |                                       |
| GP                   | character | Games played.                         |
| PTS                  | character | Points scored.                        |
| REB                  | character | Total rebounds.                       |
| AST                  | character | Assists.                              |
| NET_RATING           | character | Net rating (off rating - def rating). |
| OREB_PCT             | character | Offensive rebound percentage (0-1).   |
| DREB_PCT             | character | Defensive rebound percentage (0-1).   |
| USG_PCT              | character | Usage percentage (0-1).               |
| TS_PCT               | character | True shooting percentage (0-1).       |
| AST_PCT              | character | Assist percentage (0-1).              |

Returns a named list of data frames: LeagueDashPlayerClutch

**LeagueDashPlayerClutch**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE | character | Player age (in years). |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
| MIN | character | Minutes played. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| TOV | character | Turnovers. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| BLKA | character |  |
| PF | character | Personal fouls. |
| PFD | character |  |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |
| NBA_FANTASY_PTS | character |  |
| DD2 | character |  |
| TD3 | character |  |
| WNBA_FANTASY_PTS | character |  |
| GP_RANK | character |  |
| W_RANK | character |  |
| L_RANK | character |  |
| W_PCT_RANK | character |  |
| MIN_RANK | character |  |
| FGM_RANK | character |  |
| FGA_RANK | character |  |
| FG_PCT_RANK | character |  |
| FG3M_RANK | character |  |
| FG3A_RANK | character |  |
| FG3_PCT_RANK | character |  |
| FTM_RANK | character |  |
| FTA_RANK | character |  |
| FT_PCT_RANK | character |  |
| OREB_RANK | character |  |
| DREB_RANK | character |  |
| REB_RANK | character |  |
| AST_RANK | character |  |
| TOV_RANK | character |  |
| STL_RANK | character |  |
| BLK_RANK | character |  |
| BLKA_RANK | character |  |
| PF_RANK | character |  |
| PFD_RANK | character |  |
| PTS_RANK | character |  |
| PLUS_MINUS_RANK | character |  |
| NBA_FANTASY_PTS_RANK | character |  |
| DD2_RANK | character |  |
| TD3_RANK | character |  |
| WNBA_FANTASY_PTS_RANK | character |  |

Returns a named list of data frames: LeagueDashPTShots

**LeagueDashPTShots**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| PLAYER_LAST_TEAM_ID | character |  |
| PLAYER_LAST_TEAM_ABBREVIATION | character |  |
| AGE | character | Player age (in years). |
| GP | character | Games played. |
| G | character | Games played. |
| FGA_FREQUENCY | character |  |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| FG2A_FREQUENCY | character |  |
| FG2M | character |  |
| FG2A | character |  |
| FG2_PCT | character |  |
| FG3A_FREQUENCY | character |  |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |

Returns a named list of data frames: LeagueDashPlayerStats

**LeagueDashPlayerStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE | character | Player age (in years). |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
| MIN | character | Minutes played. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| TOV | character | Turnovers. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| BLKA | character |  |
| PF | character | Personal fouls. |
| PFD | character |  |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |
| NBA_FANTASY_PTS | character |  |
| DD2 | character |  |
| TD3 | character |  |
| WNBA_FANTASY_PTS | character |  |
| GP_RANK | character |  |
| W_RANK | character |  |
| L_RANK | character |  |
| W_PCT_RANK | character |  |
| MIN_RANK | character |  |
| FGM_RANK | character |  |
| FGA_RANK | character |  |
| FG_PCT_RANK | character |  |
| FG3M_RANK | character |  |
| FG3A_RANK | character |  |
| FG3_PCT_RANK | character |  |
| FTM_RANK | character |  |
| FTA_RANK | character |  |
| FT_PCT_RANK | character |  |
| OREB_RANK | character |  |
| DREB_RANK | character |  |
| REB_RANK | character |  |
| AST_RANK | character |  |
| TOV_RANK | character |  |
| STL_RANK | character |  |
| BLK_RANK | character |  |
| BLKA_RANK | character |  |
| PF_RANK | character |  |
| PFD_RANK | character |  |
| PTS_RANK | character |  |
| PLUS_MINUS_RANK | character |  |
| NBA_FANTASY_PTS_RANK | character |  |
| DD2_RANK | character |  |
| TD3_RANK | character |  |
| WNBA_FANTASY_PTS_RANK | character |  |

Returns a named list of data frames: ShotLocations

**ShotLocations**

|                            |           |                                       |
|----------------------------|-----------|---------------------------------------|
| col_name                   | types     | description                           |
| PLAYER_ID                  | character | Unique player identifier.             |
| PLAYER_NAME                | character | Player name.                          |
| TEAM_ID                    | character | Unique team identifier.               |
| TEAM_ABBREVIATION          | character | Short team abbreviation (e.g. 'LAS'). |
| AGE                        | character | Player age (in years).                |
| NICKNAME                   | character | Team or athlete nickname.             |
| Restricted_Area_FGM        | character |                                       |
| Restricted_Area_FGA        | character |                                       |
| Restricted_Area_FG_PCT     | character |                                       |
| In_The_Paint_Non_RA_FGM    | character |                                       |
| In_The_Paint_Non_RA_FGA    | character |                                       |
| In_The_Paint_Non_RA_FG_PCT | character |                                       |
| Mid_Range_FGM              | character |                                       |
| Mid_Range_FGA              | character |                                       |
| Mid_Range_FG_PCT           | character |                                       |
| Left_Corner_3_FGM          | character |                                       |
| Left_Corner_3_FGA          | character |                                       |
| Left_Corner_3_FG_PCT       | character |                                       |
| Right_Corner_3_FGM         | character |                                       |
| Right_Corner_3_FGA         | character |                                       |
| Right_Corner_3_FG_PCT      | character |                                       |
| Above_the_Break_3_FGM      | character |                                       |
| Above_the_Break_3_FGA      | character |                                       |
| Above_the_Break_3_FG_PCT   | character |                                       |
| Backcourt_FGM              | character |                                       |
| Backcourt_FGA              | character |                                       |
| Backcourt_FG_PCT           | character |                                       |
| Corner_3_FGM               | character |                                       |
| Corner_3_FGA               | character |                                       |
| Corner_3_FG_PCT            | character |                                       |

Returns a named list of data frames: LeagueDashPTDefend

**LeagueDashPTDefend**

|                               |           |                        |
|-------------------------------|-----------|------------------------|
| col_name                      | types     | description            |
| CLOSE_DEF_PERSON_ID           | character |                        |
| PLAYER_NAME                   | character | Player name.           |
| PLAYER_LAST_TEAM_ID           | character |                        |
| PLAYER_LAST_TEAM_ABBREVIATION | character |                        |
| PLAYER_POSITION               | character |                        |
| AGE                           | character | Player age (in years). |
| GP                            | character | Games played.          |
| G                             | character | Games played.          |
| FREQ                          | character |                        |
| D_FGM                         | character |                        |
| D_FGA                         | character |                        |
| D_FG_PCT                      | character |                        |
| NORMAL_FG_PCT                 | character |                        |
| PCT_PLUSMINUS                 | character |                        |

Returns a named list of data frames: LeagueDashPtStats

**LeagueDashPtStats**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| GP                | character | Games played.                         |
| W                 | character | Wins.                                 |
| L                 | character | Losses.                               |
| MIN               | character | Minutes played.                       |
| DRIVES            | character |                                       |
| DRIVE_FGM         | character |                                       |
| DRIVE_FGA         | character |                                       |
| DRIVE_FG_PCT      | character |                                       |
| DRIVE_FTM         | character |                                       |
| DRIVE_FTA         | character |                                       |
| DRIVE_FT_PCT      | character |                                       |
| DRIVE_PTS         | character |                                       |
| DRIVE_PTS_PCT     | character |                                       |
| DRIVE_PASSES      | character |                                       |
| DRIVE_PASSES_PCT  | character |                                       |
| DRIVE_AST         | character |                                       |
| DRIVE_AST_PCT     | character |                                       |
| DRIVE_TOV         | character |                                       |
| DRIVE_TOV_PCT     | character |                                       |
| DRIVE_PF          | character |                                       |
| DRIVE_PF_PCT      | character |                                       |

Returns a named list of data frames: LeagueDashPtTeamDefend

**LeagueDashPtTeamDefend**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| GP | character | Games played. |
| G | character | Games played. |
| FREQ | character |  |
| D_FGM | character |  |
| D_FGA | character |  |
| D_FG_PCT | character |  |
| NORMAL_FG_PCT | character |  |
| PCT_PLUSMINUS | character |  |

Returns a named list of data frames: LeagueDashTeamClutch

**LeagueDashTeamClutch**

Columns as documented in the shared
[nba_leaguedashteamclutch_leaguedashteamclutch_schema](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch_leaguedashteamclutch_schema.md)
table.

Returns a named list of data frames: LeagueDashPTShots

**LeagueDashPTShots**

Columns as documented in the shared
[nba_leaguedashoppptshot_leaguedashptshots_schema](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot_leaguedashptshots_schema.md)
table.

Returns a named list of data frames: LeagueDashTeamStats

**LeagueDashTeamStats**

Columns as documented in the shared
[nba_leaguedashteamclutch_leaguedashteamclutch_schema](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch_leaguedashteamclutch_schema.md)
table.

Returns a named list of data frames: ShotLocations

**ShotLocations**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| Restricted_Area_FGM | character |  |
| Restricted_Area_FGA | character |  |
| Restricted_Area_FG_PCT | character |  |
| In_The_Paint_Non_RA_FGM | character |  |
| In_The_Paint_Non_RA_FGA | character |  |
| In_The_Paint_Non_RA_FG_PCT | character |  |
| Mid_Range_FGM | character |  |
| Mid_Range_FGA | character |  |
| Mid_Range_FG_PCT | character |  |
| Left_Corner_3_FGM | character |  |
| Left_Corner_3_FGA | character |  |
| Left_Corner_3_FG_PCT | character |  |
| Right_Corner_3_FGM | character |  |
| Right_Corner_3_FGA | character |  |
| Right_Corner_3_FG_PCT | character |  |
| Above_the_Break_3_FGM | character |  |
| Above_the_Break_3_FGA | character |  |
| Above_the_Break_3_FG_PCT | character |  |
| Backcourt_FGM | character |  |
| Backcourt_FGA | character |  |
| Backcourt_FG_PCT | character |  |
| Corner_3_FGM | character |  |
| Corner_3_FGA | character |  |
| Corner_3_FG_PCT | character |  |

## Details

[Opponent Shots -
General](https://www.nba.com/stats/teams/opponent-shots-general)

     nba_leaguedashoppptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Player Bio Stats](https://www.nba.com/stats/players/bio)

     nba_leaguedashplayerbiostats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Players Clutch
Stats](https://www.nba.com/stats/players/clutch-traditional)

     nba_leaguedashplayerclutch(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Players Shot
Dashboard](https://www.nba.com/stats/players/shots-general)

     nba_leaguedashplayerptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Players Stats](https://www.nba.com/stats/players/traditional)

     nba_leaguedashplayerstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Players Shooting by Shot
Location](https://www.nba.com/stats/players/shooting)

     nba_leaguedashplayershotlocations(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Defensive
Dashboard](https://www.nba.com/stats/players/defense-dash-overall)

     nba_leaguedashptdefend(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Players Tracking (Second Spectrum)
Stats](https://www.nba.com/stats/players/drives)

     nba_leaguedashptstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Team Defensive
Dashboard](https://www.nba.com/stats/teams/defense-dash-overall)

     nba_leaguedashptteamdefend(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Team Clutch Stats](https://www.nba.com/stats/teams/clutch-traditional)

     nba_leaguedashteamclutch(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Team Shot Dashboard](https://www.nba.com/stats/teams/shots-general)

     nba_leaguedashteamptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Team Stats](https://www.nba.com/stats/teams/traditional)

     nba_leaguedashteamstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Team Shooting by Shot
Location](https://www.nba.com/stats/teams/shooting)

     nba_leaguedashteamshotlocations(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md)

Other NBA Player Tracking Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

Other NBA Player Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)

Other NBA Shooting Functions:
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA Clutch Functions:
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA Team Functions:
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md)

## Author

Saiem Gilani
