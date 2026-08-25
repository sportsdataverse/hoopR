# **Get NBA Stats API Fantasy Widget**

**Get NBA Stats API Fantasy Widget**

**Get NBA Stats API Fantasy Widget**

**Get NBA Stats API League Dashboard Lineups**

**Get NBA Stats API League Dashboard Lineups**

**Get NBA Stats API League Lineup Visual Data**

**Get NBA Stats API League Lineup Visual Data**

**Get NBA Stats API League Player On/Off Details**

**Get NBA Stats API League Player On/Off Details**

**Get NBA Stats API League Season Matchups**

**Get NBA Stats API League Season Matchups**

**Get NBA Stats API Matchups Rollup**

**Get NBA Stats API Matchups Rollup**

## Usage

``` r
nba_fantasywidget(
  active_players = "N",
  date_from = "",
  date_to = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = "",
  opponent_team_id = "",
  po_round = "",
  player_id = "",
  position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "",
  todays_opponent = 0,
  todays_players = "N",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguedashlineups(
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  game_segment = "",
  group_quantity = 5,
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
  team_id = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leaguelineupviz(
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  game_segment = "",
  group_quantity = 5,
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  minutes_min = 10,
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
  team_id = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leagueplayerondetails(
  date_from = "",
  date_to = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_leagueseasonmatchups(
  def_player_id = "",
  def_team_id = "",
  league_id = "00",
  off_player_id = "",
  off_team_id = "",
  per_mode = "Totals",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_matchupsrollup(
  def_player_id = "",
  def_team_id = "",
  league_id = "00",
  off_player_id = "",
  off_team_id = "",
  per_mode = "Totals",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)
```

## Arguments

- active_players:

  active_players

- date_from:

  date_from date_from

- date_to:

  date_to date_to

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

- po_round:

  po_round

- player_id:

  player_id

- position:

  position

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- team_id:

  team_id

- todays_opponent:

  todays_opponent

- todays_players:

  todays_players

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

- conference:

  conference

- division:

  division

- game_segment:

  game_segment

- group_quantity:

  group_quantity

- measure_type:

  measure_type

- outcome:

  outcome

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

- shot_clock_range:

  shot_clock_range

- minutes_min:

  minutes_min

- def_player_id:

  def_player_id

- def_team_id:

  def_team_id

- off_player_id:

  off_player_id

- off_team_id:

  off_team_id

## Value

Returns a named list of data frames: FantasyWidgetResult

**FantasyWidgetResult**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| PLAYER_POSITION   | character |                                       |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| GP                | character | Games played.                         |
| MIN               | character | Minutes played.                       |
| FAN_DUEL_PTS      | character |                                       |
| NBA_FANTASY_PTS   | character |                                       |
| PTS               | character | Points scored.                        |
| REB               | character | Total rebounds.                       |
| AST               | character | Assists.                              |
| BLK               | character | Blocks.                               |
| STL               | character | Steals.                               |
| TOV               | character | Turnovers.                            |
| FG3M              | character | Three-point field goals made.         |
| FGA               | character | Field goal attempts.                  |
| FG_PCT            | character | Field goal percentage (0-1).          |
| FTA               | character | Free throw attempts.                  |
| FT_PCT            | character | Free throw percentage (0-1).          |

Returns a named list of data frames: Lineups

**Lineups**

|                   |           |                                               |
|-------------------|-----------|-----------------------------------------------|
| col_name          | types     | description                                   |
| GROUP_SET         | character |                                               |
| GROUP_ID          | character | Group identifier (e.g. conference group_id).  |
| GROUP_NAME        | character | Group name.                                   |
| TEAM_ID           | character | Unique team identifier.                       |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').         |
| GP                | character | Games played.                                 |
| W                 | character | Wins.                                         |
| L                 | character | Losses.                                       |
| W_PCT             | character |                                               |
| MIN               | character | Minutes played.                               |
| FGM               | character | Field goals made.                             |
| FGA               | character | Field goal attempts.                          |
| FG_PCT            | character | Field goal percentage (0-1).                  |
| FG3M              | character | Three-point field goals made.                 |
| FG3A              | character | Three-point field goal attempts.              |
| FG3_PCT           | character | Three-point field goal percentage (0-1).      |
| FTM               | character | Free throws made.                             |
| FTA               | character | Free throw attempts.                          |
| FT_PCT            | character | Free throw percentage (0-1).                  |
| OREB              | character | Offensive rebounds.                           |
| DREB              | character | Defensive rebounds.                           |
| REB               | character | Total rebounds.                               |
| AST               | character | Assists.                                      |
| TOV               | character | Turnovers.                                    |
| STL               | character | Steals.                                       |
| BLK               | character | Blocks.                                       |
| BLKA              | character |                                               |
| PF                | character | Personal fouls.                               |
| PFD               | character |                                               |
| PTS               | character | Points scored.                                |
| PLUS_MINUS        | character | Plus/minus point differential while on court. |
| GP_RANK           | character |                                               |
| W_RANK            | character |                                               |
| L_RANK            | character |                                               |
| W_PCT_RANK        | character |                                               |
| MIN_RANK          | character |                                               |
| FGM_RANK          | character |                                               |
| FGA_RANK          | character |                                               |
| FG_PCT_RANK       | character |                                               |
| FG3M_RANK         | character |                                               |
| FG3A_RANK         | character |                                               |
| FG3_PCT_RANK      | character |                                               |
| FTM_RANK          | character |                                               |
| FTA_RANK          | character |                                               |
| FT_PCT_RANK       | character |                                               |
| OREB_RANK         | character |                                               |
| DREB_RANK         | character |                                               |
| REB_RANK          | character |                                               |
| AST_RANK          | character |                                               |
| TOV_RANK          | character |                                               |
| STL_RANK          | character |                                               |
| BLK_RANK          | character |                                               |
| BLKA_RANK         | character |                                               |
| PF_RANK           | character |                                               |
| PFD_RANK          | character |                                               |
| PTS_RANK          | character |                                               |
| PLUS_MINUS_RANK   | character |                                               |

Returns a named list of data frames: LeagueLineupViz

**LeagueLineupViz**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_ID | character | Group identifier (e.g. conference group_id). |
| GROUP_NAME | character | Group name. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| MIN | character | Minutes played. |
| OFF_RATING | character | Offensive rating (points produced per 100 possessions). |
| DEF_RATING | character | Defensive rating (points allowed per 100 possessions). |
| NET_RATING | character | Net rating (off rating - def rating). |
| PACE | character | Possessions per 48 minutes. |
| TS_PCT | character | True shooting percentage (0-1). |
| FTA_RATE | character | Free throw attempt rate (FTA / FGA). |
| TM_AST_PCT | character |  |
| PCT_FGA_2PT | character |  |
| PCT_FGA_3PT | character |  |
| PCT_PTS_2PT_MR | character |  |
| PCT_PTS_FB | character |  |
| PCT_PTS_FT | character |  |
| PCT_PTS_PAINT | character |  |
| PCT_AST_FGM | character |  |
| PCT_UAST_FGM | character |  |
| OPP_FG3_PCT | character |  |
| OPP_EFG_PCT | character |  |
| OPP_FTA_RATE | character |  |
| OPP_TOV_PCT | character |  |

Returns a named list of data frames: PlayersOnCourtLeaguePlayerDetails

**PlayersOnCourtLeaguePlayerDetails**

Columns as documented in the shared
[nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema.md)
table.

Returns a named list of data frames: SeasonMatchups

**SeasonMatchups**

|                  |           |                           |
|------------------|-----------|---------------------------|
| col_name         | types     | description               |
| SEASON_ID        | character | Unique season identifier. |
| OFF_PLAYER_ID    | character |                           |
| OFF_PLAYER_NAME  | character |                           |
| DEF_PLAYER_ID    | character |                           |
| DEF_PLAYER_NAME  | character |                           |
| GP               | character | Games played.             |
| MATCHUP_MIN      | character |                           |
| PARTIAL_POSS     | character |                           |
| PLAYER_PTS       | character |                           |
| TEAM_PTS         | character |                           |
| MATCHUP_AST      | character |                           |
| MATCHUP_TOV      | character |                           |
| MATCHUP_BLK      | character |                           |
| MATCHUP_FGM      | character |                           |
| MATCHUP_FGA      | character |                           |
| MATCHUP_FG_PCT   | character |                           |
| MATCHUP_FG3M     | character |                           |
| MATCHUP_FG3A     | character |                           |
| MATCHUP_FG3_PCT  | character |                           |
| HELP_BLK         | character |                           |
| HELP_FGM         | character |                           |
| HELP_FGA         | character |                           |
| HELP_FG_PERC     | character |                           |
| MATCHUP_FTM      | character |                           |
| MATCHUP_FTA      | character |                           |
| SFL              | character |                           |
| MATCHUP_TIME_SEC | character |                           |

Returns a named list of data frames: MatchupsRollup

**MatchupsRollup**

|                 |           |                                         |
|-----------------|-----------|-----------------------------------------|
| col_name        | types     | description                             |
| SEASON_ID       | character | Unique season identifier.               |
| POSITION        | character | Listed roster position (G, F, C, etc.). |
| PERCENT_OF_TIME | character |                                         |
| DEF_PLAYER_ID   | character |                                         |
| DEF_PLAYER_NAME | character |                                         |
| GP              | character | Games played.                           |
| MATCHUP_MIN     | character |                                         |
| PARTIAL_POSS    | character |                                         |
| PLAYER_PTS      | character |                                         |
| TEAM_PTS        | character |                                         |
| MATCHUP_AST     | character |                                         |
| MATCHUP_TOV     | character |                                         |
| MATCHUP_BLK     | character |                                         |
| MATCHUP_FGM     | character |                                         |
| MATCHUP_FGA     | character |                                         |
| MATCHUP_FG_PCT  | character |                                         |
| MATCHUP_FG3M    | character |                                         |
| MATCHUP_FG3A    | character |                                         |
| MATCHUP_FG3_PCT | character |                                         |
| MATCHUP_FTM     | character |                                         |
| MATCHUP_FTA     | character |                                         |
| SFL             | character |                                         |

## Details

     nba_fantasywidget(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Lineups Dashboard](https://www.nba.com/stats/lineups/traditional)

     nba_leaguedashlineups(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Lineups Dashboard](https://www.nba.com/stats/lineups/traditional)

     nba_leaguelineupviz(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

     nba_leagueplayerondetails(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Player Season
Matchups](https://www.nba.com/stats/player/2544/head-to-head)

     nba_leagueseasonmatchups(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Player Matchups
Rollup](https://www.nba.com/stats/player/2544/by-position)

     nba_matchupsrollup(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Fantasy Functions:
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)

Other NBA League Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md)

Other NBA Lineup Functions:
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shot_zones()`](https://hoopR.sportsdataverse.org/reference/nba_shot_zones.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA Player Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)

## Author

Saiem Gilani
