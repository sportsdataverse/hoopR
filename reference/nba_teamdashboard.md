# **Get NBA Stats API Team Dashboard by Clutch Splits**

**Get NBA Stats API Team Dashboard by Clutch Splits**

**Get NBA Stats API Team Dashboard by Game Splits**

**Get NBA Stats API Team Dashboard by General Splits**

**Get NBA Stats API Team Dashboard by Last N Games**

**Get NBA Stats API Team Dashboard by Opponent**

**Get NBA Stats API Team Dashboard by Shooting Splits**

**Get NBA Stats API Team Dashboard by Team Performance**

**Get NBA Stats API Team Dashboard Year over Year**

## Usage

``` r
nba_teamdashboardbyclutch(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbygamesplits(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbygeneralsplits(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbylastngames(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbyopponent(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbyshootingsplits(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbyteamperformance(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashboardbyyearoveryear(
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
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashlineups(
  date_from = "",
  date_to = "",
  game_id = "",
  game_segment = "",
  group_quantity = 5,
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  pace_adjust = "N",
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashptpass(
  date_from = "",
  date_to = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  per_mode = "Totals",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashptreb(
  date_from = "",
  date_to = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  per_mode = "Totals",
  period = 0,
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamdashptshots(
  date_from = "",
  date_to = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  per_mode = "Totals",
  period = 0,
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)
```

## Arguments

- date_from:

  date_from

- date_to:

  date_to

- game_segment:

  game_segment

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

- pace_adjust:

  pace_adjust

- plus_minus:

  plus_minus

- po_round:

  po_round

- per_mode:

  per_mode

- period:

  period

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

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

- game_id:

  game_id

- group_quantity:

  group_quantity

## Value

Return a named list of data frames: Last10Sec3Point2TeamDashboard,
Last10Sec3PointTeamDashboard, Last1Min5PointTeamDashboard,
Last1MinPlusMinus5PointTeamDashboard, Last30Sec3Point2TeamDashboard,
Last30Sec3PointTeamDashboard, Last3Min5PointTeamDashboard,
Last3MinPlusMinus5PointTeamDashboard, Last5Min5PointTeamDashboard,
Last5MinPlusMinus5PointTeamDashboard, OverallTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: ByActualMarginTeamDashboard,
ByHalfTeamDashboard, ByPeriodTeamDashboard, ByScoreMarginTeamDashboard,
OverallTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: DaysRestTeamDashboard,
LocationTeamDashboard, MonthTeamDashboard, OverallTeamDashboard,
PrePostAllStarTeamDashboard, WinsLossesTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: GameNumberTeamDashboard,
Last10TeamDashboard, Last15TeamDashboard, Last20TeamDashboard,
Last5TeamDashboard, OverallTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: ConferenceTeamDashboard,
DivisionTeamDashboard, OpponentTeamDashboard, OverallTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: AssistedBy,
AssitedShotTeamDashboard, OverallTeamDashboard, Shot5FTTeamDashboard,
Shot8FTTeamDashboard, ShotAreaTeamDashboard, ShotTypeTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: OverallTeamDashboard,
PointsScoredTeamDashboard, PontsAgainstTeamDashboard,
ScoreDifferentialTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: ByYearTeamDashboard,
OverallTeamDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: Lineups, Overall

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: PassesMade, PassesReceived

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: NumContestedRebounding,
OverallRebounding, RebDistanceRebounding, ShotDistanceRebounding,
ShotTypeRebounding

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

Return a named list of data frames: ClosestDefender10ftPlusShooting,
ClosestDefenderShooting, DribbleShooting, GeneralShooting,
ShotClockShooting, TouchTimeShooting

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

## Details

[Team Clutch Stats
Dashboard](https://www.nba.com/stats/teams/clutch-traditional)

     nba_teamdashboardbyclutch(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by Game
Splits](https://www.nba.com/stats/team/1610612749/traditional?Split=ingame)

     nba_teamdashboardbygamesplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by General
Splits](https://www.nba.com/stats/team/1610612749/traditional?Split=general)

     nba_teamdashboardbygeneralsplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by Last N
Games](https://www.nba.com/stats/team/1610612749/traditional?Split=lastn)

     nba_teamdashboardbylastngames(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by
Opponent](https://www.nba.com/stats/team/1610612749/traditional?Split=opp)

     nba_teamdashboardbyopponent(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by Shooting
Splits](https://www.nba.com/stats/team/1610612749/shooting)

     nba_teamdashboardbyshootingsplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by Team
Performance](https://www.nba.com/stats/team/1610612749/traditional?Split=teamperf)

     nba_teamdashboardbyteamperformance(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Dashboard by Year over
Year](https://www.nba.com/stats/team/1610612749/traditional?Split=yoy)

     nba_teamdashboardbyyearoveryear(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Lineups
Dashboard](https://www.nba.com/stats/team/1610612749/lineups-traditional)

     nba_teamdashlineups(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Player Tracking (Second Spectrum) Stats -
Passing](https://www.nba.com/stats/team/1610612749/passes-dash)

     nba_teamdashptpass(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Player Tracking (Second Spectrum) Stats -
Rebounds](https://www.nba.com/stats/team/1610612749/rebounds-dash)

     nba_teamdashptreb(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

[Team Player Tracking (Second Spectrum) Stats -
Shooting](https://www.nba.com/stats/team/1610612749/shots-dash)

     nba_teamdashptshots(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Team Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md)

Other NBA Clutch Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md)

Other NBA Shooting Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md)

Other NBA Lineup Functions:
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shot_zones()`](https://hoopR.sportsdataverse.org/reference/nba_shot_zones.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md)

Other NBA Player Tracking Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

## Author

Saiem Gilani
