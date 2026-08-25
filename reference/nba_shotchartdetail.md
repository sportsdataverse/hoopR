# **Get NBA Stats API Shot Chart Detail**

**Get NBA Stats API Shot Chart Detail**

**Get NBA Stats API Shot Chart Detail**

**Get NBA Stats API Shot Chart League-Wide**

**Get NBA Stats API Shot Chart League-Wide**

**Get NBA Stats API Shot Chart for Lineups**

**Get NBA Stats API Shot Chart for Lineups**

## Usage

``` r
nba_shotchartdetail(
  context_measure = "FGA",
  date_from = "",
  date_to = "",
  game_id = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  period = 0,
  player_id = "202696",
  player_position = "",
  rookie_year = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = 0,
  vs_conference = "",
  vs_division = "",
  ...
)

nba_shotchartleaguewide(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  ...
)

nba_shotchartlineupdetail(
  ahead_behind = "",
  cfid = "",
  cfparams = "",
  clutch_time = "",
  conference = "",
  context_filter = "",
  context_measure = "FGA",
  date_from = "",
  date_to = "",
  division = "",
  end_period = "10",
  end_range = "28800",
  group_id = "-202689-203493-203501-1626174-1627827-",
  game_event_id = "",
  game_id = "",
  game_segment = "",
  group_mode = "",
  group_quantity = "5",
  last_n_games = "0",
  league_id = "00",
  location = "",
  month = "0",
  on_off = "",
  opp_player_id = "",
  opponent_team_id = "0",
  outcome = "",
  po_round = "0",
  period = "0",
  player_id = "0",
  player_id1 = "",
  player_id2 = "",
  player_id3 = "",
  player_id4 = "",
  player_id5 = "",
  player_position = "",
  point_diff = "",
  position = "",
  range_type = "0",
  rookie_year = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  start_period = "1",
  start_range = "0",
  starter_bench = "",
  team_id = "1610612742",
  vs_conference = "",
  vs_division = "",
  vs_player_id1 = "",
  vs_player_id2 = "",
  vs_player_id3 = "",
  vs_player_id4 = "",
  vs_player_id5 = "",
  vs_team_id = "",
  ...
)
```

## Arguments

- context_measure:

  context_measure

- date_from:

  date_from

- date_to:

  date_to

- game_id:

  game_id

- game_segment:

  game_segment

- last_n_games:

  last_n_games

- league_id:

  league_id

- location:

  location

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- period:

  period

- player_id:

  player_id

- player_position:

  player_position

- rookie_year:

  rookie_year

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

- ahead_behind:

  ahead_behind

- cfid:

  cfid

- cfparams:

  cfparams

- clutch_time:

  clutch_time

- conference:

  conference

- context_filter:

  context_filter

- division:

  division

- end_period:

  end_period

- end_range:

  end_range

- group_id:

  group_id

- game_event_id:

  game_event_id

- group_mode:

  group_mode

- group_quantity:

  group_quantity

- on_off:

  on_off

- opp_player_id:

  opp_player_id

- po_round:

  po_round

- player_id1:

  player_id1

- player_id2:

  player_id2

- player_id3:

  player_id3

- player_id4:

  player_id4

- player_id5:

  player_id5

- point_diff:

  point_diff

- position:

  position

- range_type:

  range_type

- shot_clock_range:

  shot_clock_range

- start_period:

  start_period

- start_range:

  start_range

- starter_bench:

  starter_bench

- vs_player_id1:

  vs_player_id1

- vs_player_id2:

  vs_player_id2

- vs_player_id3:

  vs_player_id3

- vs_player_id4:

  vs_player_id4

- vs_player_id5:

  vs_player_id5

- vs_team_id:

  vs_team_id

## Value

Return a named list of data frames: LeagueAverages, Shot_Chart_Detail

**Shot_Chart_Detail**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GRID_TYPE | character |  |
| GAME_ID | character | Unique game identifier. |
| GAME_EVENT_ID | character |  |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| PERIOD | character | Period of the game (1-4 quarters; 5+ for OT). |
| MINUTES_REMAINING | character |  |
| SECONDS_REMAINING | character | Seconds remaining in the period. |
| EVENT_TYPE | character | Event / play type code (V2 PBP). |
| ACTION_TYPE | character | Action type label (e.g. 'Made Shot', 'Substitution'). |
| SHOT_TYPE | character | Shot type label (e.g. 'Jump Shot', 'Layup'). |
| SHOT_ZONE_BASIC | character | Shot zone (e.g. 'Restricted Area', 'Mid-Range', 'Above the Break 3'). |
| SHOT_ZONE_AREA | character | Shot zone area ('Left Side', 'Right Side', 'Center'). |
| SHOT_ZONE_RANGE | character | Shot zone range ('Less Than 8 ft.', '8-16 ft.', '16-24 ft.', etc.). |
| SHOT_DISTANCE | character | Shot distance from the basket, in feet. |
| LOC_X | character | X coordinate on the court (units of inches; 0 = basket center). |
| LOC_Y | character | Y coordinate on the court (units of inches; baseline at 0). |
| SHOT_ATTEMPTED_FLAG | character | 1 if a shot was attempted on this event. |
| SHOT_MADE_FLAG | character | 1 if the shot was made; 0 if missed. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| HTM | character |  |
| VTM | character |  |

**LeagueAverages**

Columns as documented in the shared
[nba_shotchartdetail_leagueaverages_schema](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail_leagueaverages_schema.md)
table.

Return a named list of data frames: League_Wide

**League_Wide**

Columns as documented in the shared
[nba_shotchartdetail_leagueaverages_schema](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail_leagueaverages_schema.md)
table.

Return a named list of data frames: ShotChartLineupDetail,
ShotChartLineupLeagueAverage

**ShotChartLineupDetail**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GRID_TYPE | character |  |
| GAME_ID | character | Unique game identifier. |
| GAME_EVENT_ID | character |  |
| GROUP_ID | character | Group identifier (e.g. conference group_id). |
| GROUP_NAME | character | Group name. |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| PERIOD | character | Period of the game (1-4 quarters; 5+ for OT). |
| MINUTES_REMAINING | character |  |
| SECONDS_REMAINING | character | Seconds remaining in the period. |
| EVENT_TYPE | character | Event / play type code (V2 PBP). |
| ACTION_TYPE | character | Action type label (e.g. 'Made Shot', 'Substitution'). |
| SHOT_TYPE | character | Shot type label (e.g. 'Jump Shot', 'Layup'). |
| SHOT_ZONE_BASIC | character | Shot zone (e.g. 'Restricted Area', 'Mid-Range', 'Above the Break 3'). |
| SHOT_ZONE_AREA | character | Shot zone area ('Left Side', 'Right Side', 'Center'). |
| SHOT_ZONE_RANGE | character | Shot zone range ('Less Than 8 ft.', '8-16 ft.', '16-24 ft.', etc.). |
| SHOT_DISTANCE | character | Shot distance from the basket, in feet. |
| LOC_X | character | X coordinate on the court (units of inches; 0 = basket center). |
| LOC_Y | character | Y coordinate on the court (units of inches; baseline at 0). |
| SHOT_ATTEMPTED_FLAG | character | 1 if a shot was attempted on this event. |
| SHOT_MADE_FLAG | character | 1 if the shot was made; 0 if missed. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| HTM | character |  |
| VTM | character |  |

**ShotChartLineupLeagueAverage**

Columns as documented in the shared
[nba_shotchartdetail_leagueaverages_schema](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail_leagueaverages_schema.md)
table.

## Details

     nba_shotchartdetail(league_id = '00', player_id = '202696', season = year_to_season(most_recent_nba_season() - 1))

     nba_shotchartleaguewide(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

     nba_shotchartlineupdetail(group_id = '-202689-203493-203501-1626174-1627827-',
                               group_id2 = '-202689-203493-203501-1626174-1627827-',
                               season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Shooting Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA League Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md)

Other NBA Lineup Functions:
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shot_zones()`](https://hoopR.sportsdataverse.org/reference/nba_shot_zones.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

## Author

Saiem Gilani
