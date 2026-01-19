# **Get NBA Stats API Shot Chart for Lineups**

**Get NBA Stats API Shot Chart for Lineups**

**Get NBA Stats API Shot Chart for Lineups**

## Usage

``` r
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

- context_measure:

  context_measure

- date_from:

  date_from

- date_to:

  date_to

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

- game_id:

  game_id

- game_segment:

  game_segment

- group_mode:

  group_mode

- group_quantity:

  group_quantity

- last_n_games:

  last_n_games

- league_id:

  league_id

- location:

  location

- month:

  month

- on_off:

  on_off

- opp_player_id:

  opp_player_id

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- po_round:

  po_round

- period:

  period

- player_id:

  player_id

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

- player_position:

  player_position

- point_diff:

  point_diff

- position:

  position

- range_type:

  range_type

- rookie_year:

  rookie_year

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- shot_clock_range:

  shot_clock_range

- start_period:

  start_period

- start_range:

  start_range

- starter_bench:

  starter_bench

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

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

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: ShotChartLineupDetail,
ShotChartLineupLeagueAverage

**ShotChartLineupDetail**

|                     |           |
|---------------------|-----------|
| col_name            | types     |
| GRID_TYPE           | character |
| GAME_ID             | character |
| GAME_EVENT_ID       | character |
| GROUP_ID            | character |
| GROUP_NAME          | character |
| PLAYER_ID           | character |
| PLAYER_NAME         | character |
| TEAM_ID             | character |
| TEAM_NAME           | character |
| PERIOD              | character |
| MINUTES_REMAINING   | character |
| SECONDS_REMAINING   | character |
| EVENT_TYPE          | character |
| ACTION_TYPE         | character |
| SHOT_TYPE           | character |
| SHOT_ZONE_BASIC     | character |
| SHOT_ZONE_AREA      | character |
| SHOT_ZONE_RANGE     | character |
| SHOT_DISTANCE       | character |
| LOC_X               | character |
| LOC_Y               | character |
| SHOT_ATTEMPTED_FLAG | character |
| SHOT_MADE_FLAG      | character |
| GAME_DATE           | character |
| HTM                 | character |
| VTM                 | character |

**ShotChartLineupLeagueAverage**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| GRID_TYPE       | character |
| SHOT_ZONE_BASIC | character |
| SHOT_ZONE_AREA  | character |
| SHOT_ZONE_RANGE | character |
| FGA             | character |
| FGM             | character |
| FG_PCT          | character |

## Details

     nba_shotchartlineupdetail(group_id = '-202689-203493-203501-1626174-1627827-',
                               group_id2 = '-202689-203493-203501-1626174-1627827-',
                               season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Shooting Functions:
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_playerdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyshootingsplits.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md),
[`nba_teamdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyshootingsplits.md)

Other NBA Lineup Functions:
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md)

## Author

Saiem Gilani
