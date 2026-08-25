# **Get NBA Stats API Player Dashboard by Clutch Splits**

**Get NBA Stats API Player Dashboard by Clutch Splits**

**Get NBA Stats API Player Dashboard by Game Splits**

**Get NBA Stats API Player Dashboard by General Splits**

**Get NBA Stats API Player Dashboard by Last N Games**

**Get NBA Stats API Player Dashboard by Opponent**

**Get NBA Stats API Player Dashboard by Shooting Splits**

**Get NBA Stats API Player Dashboard by Team Performance**

**Get NBA Stats API Player Dashboard Year over Year**

## Usage

``` r
nba_playerdashboardbyclutch(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbygamesplits(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbygeneralsplits(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbylastngames(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbyopponent(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbyshootingsplits(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbyteamperformance(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashboardbyyearoveryear(
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
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashptpass(
  date_from = "",
  date_to = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  per_mode = "Totals",
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "0",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashptreb(
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
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "0",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashptshotdefend(
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
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "0",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_playerdashptshots(
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
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "0",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_synergyplaytypes(
  league_id = "00",
  per_mode = "PerGame",
  play_type = "Isolation",
  player_or_team = "P",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  type_grouping = "Offensive",
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

- po_round:

  po_round

- pace_adjust:

  pace_adjust

- per_mode:

  per_mode

- period:

  period

- player_id:

  player_id

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

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

- team_id:

  team_id

- play_type:

  play_type - 'Isolation', 'Transition', 'PRBallHandler', 'PRRollman',
  'Postup', 'Spotup', 'Handoff', 'Cut', 'OffScreen', 'OffRebound',
  'Misc'

- player_or_team:

  player_or_team ('P' or 'T')

- type_grouping:

  type_grouping - Offensive, Defensive

## Value

Return a named list of data frames: Last10Sec3Point2PlayerDashboard,
Last10Sec3PointPlayerDashboard, Last1Min5PointPlayerDashboard,
Last1MinPlusMinus5PointPlayerDashboard, Last30Sec3Point2PlayerDashboard,
Last30Sec3PointPlayerDashboard, Last3Min5PointPlayerDashboard,
Last3MinPlusMinus5PointPlayerDashboard, Last5Min5PointPlayerDashboard,
Last5MinPlusMinus5PointPlayerDashboard, OverallPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: ByActualMarginPlayerDashboard,
ByHalfPlayerDashboard, ByPeriodPlayerDashboard,
ByScoreMarginPlayerDashboard, OverallPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: DaysRestPlayerDashboard,
LocationPlayerDashboard, MonthPlayerDashboard, OverallPlayerDashboard,
PrePostAllStarPlayerDashboard, StartingPosition,
WinsLossesPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: GameNumberPlayerDashboard,
Last10PlayerDashboard, Last15PlayerDashboard, Last20PlayerDashboard,
Last5PlayerDashboard, OverallPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: ConferencePlayerDashboard,
DivisionPlayerDashboard, OpponentPlayerDashboard, OverallPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: AssistedBy,
AssitedShotPlayerDashboard, OverallPlayerDashboard,
Shot5FTPlayerDashboard, Shot8FTPlayerDashboard, ShotAreaPlayerDashboard,
ShotTypePlayerDashboard, ShotTypeSummaryPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: OverallPlayerDashboard,
PointsScoredPlayerDashboard, PointsAgainstPlayerDashboard,
ScoreDifferentialPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: ByYearPlayerDashboard,
OverallPlayerDashboard

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: PassesMade, PassesReceived

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: NumContestedRebounding,
OverallRebounding, RebDistanceRebounding, ShotDistanceRebounding,
ShotTypeRebounding

Return a named list of data frames: DefendingShots

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: ClosestDefender10ftPlusShooting,
ClosestDefenderShooting, DribbleShooting, GeneralShooting, Overall,
ShotClockShooting, TouchTimeShooting

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

Return a named list of data frames: SynergyPlayType

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

## Details

[Player Clutch Stats
Dashboard](https://www.nba.com/stats/players/clutch-traditional)

     nba_playerdashboardbyclutch(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by Game
Splits](https://www.nba.com/stats/player/2544/traditional?Split=ingame)

     nba_playerdashboardbygamesplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by General
Splits](https://www.nba.com/stats/player/2544/traditional)

     nba_playerdashboardbygeneralsplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by Last N
Games](https://www.nba.com/stats/player/2544/traditional?Split=lastn)

     nba_playerdashboardbylastngames(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by
Opponent](https://www.nba.com/stats/player/2544/traditional?Split=opp)

     nba_playerdashboardbyopponent(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by Shooting
Splits](https://www.nba.com/stats/player/2544/shooting)

     nba_playerdashboardbyshootingsplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by Team
Performance](https://www.nba.com/stats/player/2544/traditional?Split=teamperf&PerMode=PerGame)

     nba_playerdashboardbyteamperformance(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Stats Dashboard by Team
Performance](https://www.nba.com/stats/player/2544/traditional?Split=yoy&PerMode=PerGame)

     nba_playerdashboardbyyearoveryear(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Tracking (Second Spectrum) Stats -
Passing](https://www.nba.com/stats/player/2544/passes-dash)

     nba_playerdashptpass(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Tracking (Second Spectrum) Stats -
Rebounding](https://www.nba.com/stats/player/2544/rebounds-dash)

     nba_playerdashptreb(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Tracking (Second Spectrum) Stats -
Defending](https://www.nba.com/stats/player/2544/defense-dash)

     nba_playerdashptshotdefend(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Player Tracking (Second Spectrum) Stats -
Shooting](https://www.nba.com/stats/player/2544/shots-dash)

     nba_playerdashptshots(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

[Synergy Play Type Stats](https://www.nba.com/stats/teams/isolation)

     nba_synergyplaytypes(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Player Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)

Other NBA Clutch Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA Shooting Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA Player Tracking Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

## Author

Saiem Gilani
