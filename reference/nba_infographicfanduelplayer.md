# **Get NBA Stats API Player Index**

Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use
`nba_playercareerbycollegerollup()` instead.

Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use
`nba_playerprofilev2()` instead.

## Usage

``` r
nba_playerindex(
  college = "",
  country = "",
  draft_pick = "",
  draft_round = "",
  draft_year = "",
  height = "",
  historical = 1,
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  team_id = "0",
  weight = "",
  ...
)

nba_playerheadshot(player_id = "2544", ...)

nba_playerawards(player_id, ...)

nba_playercareerbycollege(
  college = "Florida State",
  league_id = "00",
  per_mode = "Totals",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playercareerbycollegerollup(
  league_id = "00",
  per_mode = "Totals",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playercareerstats(
  league_id = "00",
  per_mode = "Totals",
  player_id = "2544",
  ...
)

nba_infographicfanduelplayer(game_id, ...)

nba_playerfantasyprofile(
  league_id = "00",
  measure_type = "Base",
  pace_adjust = "N",
  per_mode = "Totals",
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playerfantasyprofilebargraph(
  league_id = "00",
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playerestimatedmetrics(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playergamelog(
  date_from = "",
  date_to = "",
  league_id = "00",
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playergamelogs(
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
  po_round = "",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playergamestreakfinder(
  active_streaks_only = "",
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_year = "",
  draft_team_id = "",
  draft_round = "",
  draft_number = "",
  et_ast = "",
  et_blk = "",
  et_dd = "",
  et_dreb = "",
  et_fg3a = "",
  et_fg3m = "",
  et_fg3_pct = "",
  et_fga = "",
  et_fgm = "",
  et_fg_pct = "",
  et_fta = "",
  et_ftm = "",
  et_ft_pct = "",
  et_minutes = "",
  et_oreb = "",
  et_pf = "",
  et_pts = "",
  et_reb = "",
  et_stl = "",
  et_td = "",
  et_tov = "",
  game_id = "",
  gt_ast = "",
  gt_blk = "",
  gt_dd = "",
  gt_dreb = "",
  gt_fg3a = "",
  gt_fg3m = "",
  gt_fg3_pct = "",
  gt_fga = "",
  gt_fgm = "",
  gt_fg_pct = "",
  gt_fta = "",
  gt_ftm = "",
  gt_ft_pct = "",
  gt_minutes = "",
  gt_oreb = "",
  gt_pf = "",
  gt_pts = "",
  gt_reb = "",
  gt_stl = "",
  gt_td = "",
  gt_tov = "",
  league_id = "00",
  location = "",
  lt_ast = "",
  lt_blk = "",
  lt_dd = "",
  lt_dreb = "",
  lt_fg3a = "",
  lt_fg3m = "",
  lt_fg3_pct = "",
  lt_fga = "",
  lt_fgm = "",
  lt_fg_pct = "",
  lt_fta = "",
  lt_ftm = "",
  lt_ft_pct = "",
  lt_minutes = "",
  lt_oreb = "",
  lt_pf = "",
  lt_pts = "",
  lt_reb = "",
  lt_stl = "",
  lt_td = "",
  lt_tov = "",
  min_games = "",
  outcome = "",
  po_round = "",
  player_id = "",
  rookie_year = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  vs_team_id = "",
  years_experience = "",
  ...
)

nba_playernextngames(
  league_id = "",
  number_of_games = 2147483647,
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_playerprofilev2(
  league_id = "",
  per_mode = "Totals",
  player_id = "2544",
  ...
)

nba_playervsplayer(
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
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  vs_conference = "",
  vs_division = "",
  vs_player_id = "203076",
  ...
)

nba_playercompare(
  conference = "",
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
  player_id_list = "202681,203078,2544,201567,203954",
  plus_minus = "N",
  rank = "N",
  season = "2020-21",
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  vs_player_id_list = "201566,201939,201935,201142,203076",
  ...
)
```

## Arguments

- college:

  Player College

- country:

  Player Country

- draft_pick:

  Draft Pick

- draft_round:

  Draft Round

- draft_year:

  Draft Year

- height:

  Player Height

- historical:

  Whether to include only current players (0) or all historical (1).

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- team_id:

  Team ID. Default: 0 (all teams).

- weight:

  Player weight

- ...:

  Additional arguments passed to an underlying function like httr.

- player_id:

  Player ID

- per_mode:

  Per Mode - PerGame, Totals

- game_id:

  game_id

- measure_type:

  measure_type

- pace_adjust:

  Pace Adjustment - Y/N

- plus_minus:

  Plus Minus - Y/N

- rank:

  Rank - Y/N

- date_from:

  date_from

- date_to:

  date_to

- game_segment:

  game_segment

- last_n_games:

  last_n_games

- location:

  location

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- po_round:

  po_round

- period:

  period

- season_segment:

  season_segment

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- active_streaks_only:

  active_streaks_only

- conference:

  conference

- division:

  division

- draft_team_id:

  draft_team_id

- draft_number:

  draft_number

- et_ast:

  et_ast

- et_blk:

  et_blk

- et_dd:

  et_dd

- et_dreb:

  et_dreb

- et_fg3a:

  et_fg3a

- et_fg3m:

  et_fg3m

- et_fg3_pct:

  et_fg3_pct

- et_fga:

  et_fga

- et_fgm:

  et_fgm

- et_fg_pct:

  et_fg_pct

- et_fta:

  et_fta

- et_ftm:

  et_ftm

- et_ft_pct:

  et_ft_pct

- et_minutes:

  et_minutes

- et_oreb:

  et_oreb

- et_pf:

  et_pf

- et_pts:

  et_pts

- et_reb:

  et_reb

- et_stl:

  et_stl

- et_td:

  et_td

- et_tov:

  et_tov

- gt_ast:

  gt_ast

- gt_blk:

  gt_blk

- gt_dd:

  gt_dd

- gt_dreb:

  gt_dreb

- gt_fg3a:

  gt_fg3a

- gt_fg3m:

  gt_fg3m

- gt_fg3_pct:

  gt_fg3_pct

- gt_fga:

  gt_fga

- gt_fgm:

  gt_fgm

- gt_fg_pct:

  gt_fg_pct

- gt_fta:

  gt_fta

- gt_ftm:

  gt_ftm

- gt_ft_pct:

  gt_ft_pct

- gt_minutes:

  gt_minutes

- gt_oreb:

  gt_oreb

- gt_pf:

  gt_pf

- gt_pts:

  gt_pts

- gt_reb:

  gt_reb

- gt_stl:

  gt_stl

- gt_td:

  gt_td

- gt_tov:

  gt_tov

- lt_ast:

  lt_ast

- lt_blk:

  lt_blk

- lt_dd:

  lt_dd

- lt_dreb:

  lt_dreb

- lt_fg3a:

  lt_fg3a

- lt_fg3m:

  lt_fg3m

- lt_fg3_pct:

  lt_fg3_pct

- lt_fga:

  lt_fga

- lt_fgm:

  lt_fgm

- lt_fg_pct:

  lt_fg_pct

- lt_fta:

  lt_fta

- lt_ftm:

  lt_ftm

- lt_ft_pct:

  lt_ft_pct

- lt_minutes:

  lt_minutes

- lt_oreb:

  lt_oreb

- lt_pf:

  lt_pf

- lt_pts:

  lt_pts

- lt_reb:

  lt_reb

- lt_stl:

  lt_stl

- lt_td:

  lt_td

- lt_tov:

  lt_tov

- min_games:

  min_games

- rookie_year:

  rookie_year

- starter_bench:

  starter_bench

- vs_team_id:

  vs_team_id

- years_experience:

  years_experience

- number_of_games:

  N in number of games

- vs_player_id:

  vs_player_id

- player_id_list:

  Player ID

- shot_clock_range:

  shot_clock_range

- vs_player_id_list:

  vs_player_id_list

## Value

Return a named list of data frames: PlayerIndex

**PlayerIndex**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| PLAYER_LAST_NAME | character |  |
| PLAYER_FIRST_NAME | character |  |
| PLAYER_SLUG | character | URL-safe player identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_SLUG | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| IS_DEFUNCT | character |  |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| JERSEY_NUMBER | character |  |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| HEIGHT | character | Player height (string e.g. '6-2' or inches). |
| WEIGHT | character | Player weight in pounds. |
| COLLEGE | character | College or school attended. |
| COUNTRY | character | Country (full name or code). |
| DRAFT_YEAR | character | Draft year (4-digit). |
| DRAFT_ROUND | character | Round of the draft selection. |
| DRAFT_NUMBER | character |  |
| ROSTER_STATUS | character |  |
| PTS | character | Points scored. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| STATS_TIMEFRAME | character |  |
| FROM_YEAR | character |  |
| TO_YEAR | character |  |

Returns a url of the png for the player_id selected

Return a named list of data frames: PlayerAwards

**PlayerAwards**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| TEAM | character | Team-side label or team identifier. |
| DESCRIPTION | character | Long-form description text. |
| ALL_NBA_TEAM_NUMBER | character |  |
| SEASON | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| MONTH | character | Month number. |
| WEEK | character | Week number within the season. |
| CONFERENCE | character | Conference. |
| TYPE | character | Record type / category. |
| SUBTYPE1 | character |  |
| SUBTYPE2 | character |  |
| SUBTYPE3 | character |  |

Return a named list of data frames: PlayerCareerByCollege

**PlayerCareerByCollege**

|             |           |                                          |
|-------------|-----------|------------------------------------------|
| col_name    | types     | description                              |
| PLAYER_ID   | character | Unique player identifier.                |
| PLAYER_NAME | character | Player name.                             |
| COLLEGE     | character | College or school attended.              |
| GP          | character | Games played.                            |
| MIN         | character | Minutes played.                          |
| FGM         | character | Field goals made.                        |
| FGA         | character | Field goal attempts.                     |
| FG_PCT      | character | Field goal percentage (0-1).             |
| FG3M        | character | Three-point field goals made.            |
| FG3A        | character | Three-point field goal attempts.         |
| FG3_PCT     | character | Three-point field goal percentage (0-1). |
| FTM         | character | Free throws made.                        |
| FTA         | character | Free throw attempts.                     |
| FT_PCT      | character | Free throw percentage (0-1).             |
| OREB        | character | Offensive rebounds.                      |
| DREB        | character | Defensive rebounds.                      |
| REB         | character | Total rebounds.                          |
| AST         | character | Assists.                                 |
| TOV         | character | Turnovers.                               |
| STL         | character | Steals.                                  |
| BLK         | character | Blocks.                                  |
| PF          | character | Personal fouls.                          |
| PTS         | character | Points scored.                           |

Return a named list of data frames: East, Midwest, South, West

**East**

|          |           |                                          |
|----------|-----------|------------------------------------------|
| col_name | types     | description                              |
| REGION   | character | Region label.                            |
| SEED     | character | Tournament seed.                         |
| COLLEGE  | character | College or school attended.              |
| PLAYERS  | character |                                          |
| GP       | character | Games played.                            |
| MIN      | character | Minutes played.                          |
| FGM      | character | Field goals made.                        |
| FGA      | character | Field goal attempts.                     |
| FG_PCT   | character | Field goal percentage (0-1).             |
| FG3M     | character | Three-point field goals made.            |
| FG3A     | character | Three-point field goal attempts.         |
| FG3_PCT  | character | Three-point field goal percentage (0-1). |
| FTM      | character | Free throws made.                        |
| FTA      | character | Free throw attempts.                     |
| FT_PCT   | character | Free throw percentage (0-1).             |
| OREB     | character | Offensive rebounds.                      |
| DREB     | character | Defensive rebounds.                      |
| REB      | character | Total rebounds.                          |
| AST      | character | Assists.                                 |
| STL      | character | Steals.                                  |
| BLK      | character | Blocks.                                  |
| TOV      | character | Turnovers.                               |
| PF       | character | Personal fouls.                          |
| PTS      | character | Points scored.                           |

**South**

Same columns as the **East** table above.

**Midwest**

Same columns as the **East** table above.

**West**

Same columns as the **East** table above.

Return a named list of data frames: CareerTotalsAllStarSeason,
CareerTotalsCollegeSeason, CareerTotalsPostSeason,
CareerTotalsRegularSeason, SeasonRankingsPostSeason,
SeasonRankingsRegularSeason, SeasonTotalsAllStarSeason,
SeasonTotalsCollegeSeason, SeasonTotalsPostSeason,
SeasonTotalsRegularSeason

**SeasonTotalsRegularSeason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsRegularSeason**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| LEAGUE_ID | character | League identifier ('10' = WNBA).         |
| Team_ID   | character | Unique team identifier.                  |
| GP        | character | Games played.                            |
| GS        | character | Games started.                           |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

**SeasonTotalsPostSeason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsPostSeason**

Same columns as the **CareerTotalsRegularSeason** table above.

**SeasonTotalsAllStarSeason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsAllStarSeason**

Same columns as the **CareerTotalsRegularSeason** table above.

**SeasonTotalsCollegeSeason**

**CareerTotalsCollegeSeason**

**SeasonTotalsShowcaseSeason**

**CareerTotalsShowcaseSeason**

**SeasonRankingsRegularSeason**

Columns as documented in the shared
[nba_playercareerstats_seasonrankingsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasonrankingsregularseason_schema.md)
table.

**SeasonRankingsPostSeason**

Columns as documented in the shared
[nba_playercareerstats_seasonrankingsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasonrankingsregularseason_schema.md)
table.

Return a named list of data frames: FanDuelPlayer

**FanDuelPlayer**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| JERSEY_NUM | character | Jersey number worn by the player. |
| PLAYER_POSITION | character |  |
| LOCATION | character | Location. |
| FAN_DUEL_PTS | character |  |
| NBA_FANTASY_PTS | character |  |
| USG_PCT | character | Usage percentage (0-1). |
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

Return a named list of data frames: DaysRestModified, LastNGames,
Location, Opponent, Overall

**Overall**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| GROUP_SET       | character |                                               |
| GROUP_VALUE     | character |                                               |
| GP              | character | Games played.                                 |
| W               | character | Wins.                                         |
| L               | character | Losses.                                       |
| W_PCT           | character |                                               |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| TOV             | character | Turnovers.                                    |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| BLKA            | character |                                               |
| PF              | character | Personal fouls.                               |
| PFD             | character |                                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| DD2             | character |                                               |
| TD3             | character |                                               |
| FAN_DUEL_PTS    | character |                                               |
| NBA_FANTASY_PTS | character |                                               |

**Location**

Same columns as the **Overall** table above.

**LastNGames**

Same columns as the **Overall** table above.

**DaysRestModified**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| GROUP_SET       | character |                                               |
| GROUP_VALUE     | character |                                               |
| SEASON_YEAR     | character | Season year string ('YYYY-YY' format).        |
| GP              | character | Games played.                                 |
| W               | character | Wins.                                         |
| L               | character | Losses.                                       |
| W_PCT           | character |                                               |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| TOV             | character | Turnovers.                                    |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| BLKA            | character |                                               |
| PF              | character | Personal fouls.                               |
| PFD             | character |                                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| DD2             | character |                                               |
| TD3             | character |                                               |
| FAN_DUEL_PTS    | character |                                               |
| NBA_FANTASY_PTS | character |                                               |

**Opponent**

Same columns as the **Overall** table above.

Return a named list of data frames: LastFiveGamesAvg, SeasonAvg

**SeasonAvg**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| FAN_DUEL_PTS      | character |                                       |
| NBA_FANTASY_PTS   | character |                                       |
| PTS               | character | Points scored.                        |
| REB               | character | Total rebounds.                       |
| AST               | character | Assists.                              |
| FG3M              | character | Three-point field goals made.         |
| FT_PCT            | character | Free throw percentage (0-1).          |
| STL               | character | Steals.                               |
| BLK               | character | Blocks.                               |
| TOV               | character | Turnovers.                            |
| FG_PCT            | character | Field goal percentage (0-1).          |

**LastFiveGamesAvg**

Same columns as the **SeasonAvg** table above.

Return a named list of data frames: PlayerEstimatedMetrics

**PlayerEstimatedMetrics**

|                   |           |                           |
|-------------------|-----------|---------------------------|
| col_name          | types     | description               |
| PLAYER_ID         | character | Unique player identifier. |
| PLAYER_NAME       | character | Player name.              |
| GP                | character | Games played.             |
| W                 | character | Wins.                     |
| L                 | character | Losses.                   |
| W_PCT             | character |                           |
| MIN               | character | Minutes played.           |
| E_OFF_RATING      | character |                           |
| E_DEF_RATING      | character |                           |
| E_NET_RATING      | character |                           |
| E_AST_RATIO       | character |                           |
| E_OREB_PCT        | character |                           |
| E_DREB_PCT        | character |                           |
| E_REB_PCT         | character |                           |
| E_TOV_PCT         | character |                           |
| E_USG_PCT         | character |                           |
| E_PACE            | character |                           |
| GP_RANK           | character |                           |
| W_RANK            | character |                           |
| L_RANK            | character |                           |
| W_PCT_RANK        | character |                           |
| MIN_RANK          | character |                           |
| E_OFF_RATING_RANK | character |                           |
| E_DEF_RATING_RANK | character |                           |
| E_NET_RATING_RANK | character |                           |
| E_AST_RATIO_RANK  | character |                           |
| E_OREB_PCT_RANK   | character |                           |
| E_DREB_PCT_RANK   | character |                           |
| E_REB_PCT_RANK    | character |                           |
| E_TOV_PCT_RANK    | character |                           |
| E_USG_PCT_RANK    | character |                           |
| E_PACE_RANK       | character |                           |

Return a named list of data frames: PlayerGameLog

**PlayerGameLog**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| SEASON_ID       | character | Unique season identifier.                     |
| Player_ID       | character | Unique player identifier.                     |
| Game_ID         | character | Unique game identifier.                       |
| GAME_DATE       | character | Game date (YYYY-MM-DD).                       |
| MATCHUP         | character | Matchup.                                      |
| WL              | character | Wl.                                           |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| TOV             | character | Turnovers.                                    |
| PF              | character | Personal fouls.                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| VIDEO_AVAILABLE | character | Video available.                              |

Return a named list of data frames: PlayerGameLogs

**PlayerGameLogs**

|  |  |  |
|----|----|----|
| col_name | types | description |
| SEASON_YEAR | character | Season year string ('YYYY-YY' format). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| GAME_ID | character | Unique game identifier. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| MATCHUP | character | Matchup. |
| WL | character | Wl. |
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
| VIDEO_AVAILABLE_FLAG | character | Video available flag. |

Return a named list of data frames: PlayerGameStreakFinderResults

**PlayerGameStreakFinderResults**

|                        |           |                           |
|------------------------|-----------|---------------------------|
| col_name               | types     | description               |
| PLAYER_NAME_LAST_FIRST | character |                           |
| PLAYER_ID              | character | Unique player identifier. |
| GAMESTREAK             | character |                           |
| STARTDATE              | character |                           |
| ENDDATE                | character |                           |
| ACTIVESTREAK           | character |                           |
| NUMSEASONS             | character |                           |
| LASTSEASON             | character |                           |
| FIRSTSEASON            | character |                           |

Return a named list of data frames: NextNGames

**NextNGames**

|                           |           |                                      |
|---------------------------|-----------|--------------------------------------|
| col_name                  | types     | description                          |
| GAME_ID                   | character | Unique game identifier.              |
| GAME_DATE                 | character | Game date (YYYY-MM-DD).              |
| HOME_TEAM_ID              | character | Unique identifier for the home team. |
| VISITOR_TEAM_ID           | character |                                      |
| HOME_TEAM_NAME            | character | Home team name.                      |
| VISITOR_TEAM_NAME         | character |                                      |
| HOME_TEAM_ABBREVIATION    | character |                                      |
| VISITOR_TEAM_ABBREVIATION | character |                                      |
| HOME_TEAM_NICKNAME        | character |                                      |
| VISITOR_TEAM_NICKNAME     | character |                                      |
| GAME_TIME                 | character | Game start time.                     |
| HOME_WL                   | character |                                      |
| VISITOR_WL                | character |                                      |

Return a named list of data frames: CareerHighs,
CareerTotalsAllStarSeason, CareerTotalsCollegeSeason,
CareerTotalsPostSeason, CareerTotalsPreseason,
CareerTotalsRegularSeason, NextGame, SeasonHighs,
SeasonRankingsPostSeason, SeasonRankingsRegularSeason,
SeasonTotalsAllStarSeason, SeasonTotalsCollegeSeason,
SeasonTotalsPostSeason, SeasonTotalsPreseason, SeasonTotalsRegularSeason

**SeasonTotalsRegularSeason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsRegularSeason**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| LEAGUE_ID | character | League identifier ('10' = WNBA).         |
| TEAM_ID   | character | Unique team identifier.                  |
| GP        | character | Games played.                            |
| GS        | character | Games started.                           |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

**SeasonTotalsPostSeason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsPostSeason**

Same columns as the **CareerTotalsRegularSeason** table above.

**SeasonTotalsAllStarSeason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsAllStarSeason**

Same columns as the **CareerTotalsRegularSeason** table above.

**SeasonTotalsCollegeSeason**

**CareerTotalsCollegeSeason**

**SeasonTotalsPreseason**

Columns as documented in the shared
[nba_playercareerstats_seasontotalsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasontotalsregularseason_schema.md)
table.

**CareerTotalsPreseason**

Same columns as the **CareerTotalsRegularSeason** table above.

**SeasonRankingsRegularSeason**

Columns as documented in the shared
[nba_playercareerstats_seasonrankingsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasonrankingsregularseason_schema.md)
table.

**SeasonRankingsPostSeason**

Columns as documented in the shared
[nba_playercareerstats_seasonrankingsregularseason_schema](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats_seasonrankingsregularseason_schema.md)
table.

**SeasonHighs**

|                      |           |                           |
|----------------------|-----------|---------------------------|
| col_name             | types     | description               |
| PLAYER_ID            | character | Unique player identifier. |
| GAME_ID              | character | Unique game identifier.   |
| GAME_DATE            | character | Game date (YYYY-MM-DD).   |
| VS_TEAM_ID           | character |                           |
| VS_TEAM_CITY         | character |                           |
| VS_TEAM_NAME         | character |                           |
| VS_TEAM_ABBREVIATION | character |                           |
| STAT                 | character | Stat.                     |
| STAT_VALUE           | character |                           |
| STAT_ORDER           | character |                           |
| DATE_EST             | character |                           |

**CareerHighs**

Same columns as the **SeasonHighs** table above.

**NextGame**

|                          |           |                         |
|--------------------------|-----------|-------------------------|
| col_name                 | types     | description             |
| GAME_ID                  | character | Unique game identifier. |
| GAME_DATE                | character | Game date (YYYY-MM-DD). |
| GAME_TIME                | character | Game start time.        |
| LOCATION                 | character | Location.               |
| PLAYER_TEAM_ID           | character |                         |
| PLAYER_TEAM_CITY         | character |                         |
| PLAYER_TEAM_NICKNAME     | character |                         |
| PLAYER_TEAM_ABBREVIATION | character |                         |
| VS_TEAM_ID               | character |                         |
| VS_TEAM_CITY             | character |                         |
| VS_TEAM_NICKNAME         | character |                         |
| VS_TEAM_ABBREVIATION     | character |                         |

Return a named list of data frames: OnOffCourt, Overall, PlayerInfo,
ShotAreaOffCourt, ShotAreaOnCourt, ShotAreaOverall,
ShotDistanceOffCourt, ShotDistanceOnCourt, ShotDistanceOverall,
VsPlayerInfo

**Overall**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| GROUP_SET       | character |                                               |
| GROUP_VALUE     | character |                                               |
| PLAYER_ID       | character | Unique player identifier.                     |
| PLAYER_NAME     | character | Player name.                                  |
| GP              | character | Games played.                                 |
| W               | character | Wins.                                         |
| L               | character | Losses.                                       |
| W_PCT           | character |                                               |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| TOV             | character | Turnovers.                                    |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| BLKA            | character |                                               |
| PF              | character | Personal fouls.                               |
| PFD             | character |                                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| NBA_FANTASY_PTS | character |                                               |

**OnOffCourt**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| GROUP_SET       | character |                                               |
| PLAYER_ID       | character | Unique player identifier.                     |
| PLAYER_NAME     | character | Player name.                                  |
| VS_PLAYER_ID    | character |                                               |
| VS_PLAYER_NAME  | character |                                               |
| COURT_STATUS    | character |                                               |
| GP              | character | Games played.                                 |
| W               | character | Wins.                                         |
| L               | character | Losses.                                       |
| W_PCT           | character |                                               |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| TOV             | character | Turnovers.                                    |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| BLKA            | character |                                               |
| PF              | character | Personal fouls.                               |
| PFD             | character |                                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| NBA_FANTASY_PTS | character |                                               |

**ShotDistanceOverall**

|             |           |                              |
|-------------|-----------|------------------------------|
| col_name    | types     | description                  |
| GROUP_SET   | character |                              |
| GROUP_VALUE | character |                              |
| PLAYER_ID   | character | Unique player identifier.    |
| PLAYER_NAME | character | Player name.                 |
| FGM         | character | Field goals made.            |
| FGA         | character | Field goal attempts.         |
| FG_PCT      | character | Field goal percentage (0-1). |

**ShotDistanceOnCourt**

|                |           |                              |
|----------------|-----------|------------------------------|
| col_name       | types     | description                  |
| GROUP_SET      | character |                              |
| PLAYER_ID      | character | Unique player identifier.    |
| PLAYER_NAME    | character | Player name.                 |
| VS_PLAYER_ID   | character |                              |
| VS_PLAYER_NAME | character |                              |
| COURT_STATUS   | character |                              |
| GROUP_VALUE    | character |                              |
| FGM            | character | Field goals made.            |
| FGA            | character | Field goal attempts.         |
| FG_PCT         | character | Field goal percentage (0-1). |

**ShotDistanceOffCourt**

Same columns as the **ShotDistanceOnCourt** table above.

**ShotAreaOverall**

Same columns as the **ShotDistanceOverall** table above.

**ShotAreaOnCourt**

Same columns as the **ShotDistanceOnCourt** table above.

**ShotAreaOffCourt**

Same columns as the **ShotDistanceOnCourt** table above.

**PlayerInfo**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| DISPLAY_FIRST_LAST | character |  |
| DISPLAY_LAST_COMMA_FIRST | character |  |
| DISPLAY_FI_LAST | character |  |
| BIRTHDATE | character |  |
| SCHOOL | character | Player's school / college (when distinct from 'college'). |
| COUNTRY | character | Country (full name or code). |
| LAST_AFFILIATION | character |  |

**VsPlayerInfo**

Same columns as the **PlayerInfo** table above.

Return a named list of data frames: Individual, OverallCompare

**OverallCompare**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| GROUP_SET   | character |                                               |
| DESCRIPTION | character | Long-form description text.                   |
| MIN         | character | Minutes played.                               |
| FGM         | character | Field goals made.                             |
| FGA         | character | Field goal attempts.                          |
| FG_PCT      | character | Field goal percentage (0-1).                  |
| FG3M        | character | Three-point field goals made.                 |
| FG3A        | character | Three-point field goal attempts.              |
| FG3_PCT     | character | Three-point field goal percentage (0-1).      |
| FTM         | character | Free throws made.                             |
| FTA         | character | Free throw attempts.                          |
| FT_PCT      | character | Free throw percentage (0-1).                  |
| OREB        | character | Offensive rebounds.                           |
| DREB        | character | Defensive rebounds.                           |
| REB         | character | Total rebounds.                               |
| AST         | character | Assists.                                      |
| TOV         | character | Turnovers.                                    |
| STL         | character | Steals.                                       |
| BLK         | character | Blocks.                                       |
| BLKA        | character |                                               |
| PF          | character | Personal fouls.                               |
| PFD         | character |                                               |
| PTS         | character | Points scored.                                |
| PLUS_MINUS  | character | Plus/minus point differential while on court. |

**Individual**

Same columns as the **OverallCompare** table above.

## Details

[Player Index](https://www.nba.com/stats/players)

     nba_playerindex()

[Player
Headshot](https://cdn.nba.com/headshots/nba/latest/260x190/2544.png)

     nba_playerheadshot(player_id = '2544')

[Player Awards](https://www.nba.com/stats/player/2544/career)

     nba_playerawards(player_id = '2544')

     nba_playercareerbycollege(college = 'Florida State', per_mode = 'PerGame')

     nba_playercareerbycollegerollup(per_mode = 'Totals')

[Player Career Stats](https://www.nba.com/stats/player/2544/career)

     nba_playercareerstats(player_id = '2544')

     nba_infographicfanduelplayer(game_id = "0022201086")

     nba_playerfantasyprofile(player_id = '2544')

     nba_playerfantasyprofilebargraph(player_id = '2544')

[Player Estimated
Metrics](https://www.nba.com/stats/players/estimated-advanced)

     nba_playerestimatedmetrics()

[Player Game
Log](https://www.nba.com/stats/player/2544/boxscores-traditional)

     nba_playergamelog(player_id = '2544')

[Player Game
Logs](https://www.nba.com/stats/player/2544/boxscores-traditional)

     nba_playergamelogs(player_id = '2544')

     nba_playergamestreakfinder()

     nba_playernextngames(player_id = '2544')

[Player Profile](https://www.nba.com/stats/player/2544/career)

     nba_playerprofilev2(player_id = '2544')

     nba_playervsplayer(player_id = '2544', vs_player_id = '203076')

     nba_playercompare(player_id_list = '202681,203078,2544,201567,203954', vs_player_id_list = '201566,201939,201935,201142,203076')

## See also

Other NBA Player Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md)

Other NBA Fantasy Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md)

Other NBA Game Finder Functions:
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md)

## Author

Saiem Gilani
