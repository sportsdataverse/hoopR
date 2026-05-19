# **Get NBA Stats API Team Dashboard - Lineups**

**Get NBA Stats API Team Dashboard - Lineups**

**Get NBA Stats API Team Dashboard - Lineups**

## Usage

``` r
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
```

## Arguments

- date_from:

  date_from

- date_to:

  date_to

- game_id:

  game_id

- game_segment:

  game_segment

- group_quantity:

  group_quantity

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

## Value

Return a named list of data frames: Lineups, Overall

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_teamdashboard_columns.md` for full column tables.

## Details

[Team Lineups
Dashboard](https://www.nba.com/stats/team/1610612749/lineups-traditional)

     nba_teamdashlineups(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_teamdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamdetails.md),
[`nba_teamestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_teamestimatedmetrics.md),
[`nba_teamgamelog()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelog.md),
[`nba_teamgamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelogs.md),
[`nba_teamgamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamestreakfinder.md),
[`nba_teamhistoricalleaders()`](https://hoopR.sportsdataverse.org/reference/nba_teamhistoricalleaders.md),
[`nba_teaminfocommon()`](https://hoopR.sportsdataverse.org/reference/nba_teaminfocommon.md),
[`nba_teamplayerdashboard()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayerdashboard.md),
[`nba_teamplayeronoffdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md),
[`nba_teamplayeronoffsummary()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffsummary.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md),
[`nba_teamvsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_teamvsplayer.md),
[`nba_teamyearbyyearstats()`](https://hoopR.sportsdataverse.org/reference/nba_teamyearbyyearstats.md)

Other NBA Lineup Functions:
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md)

## Author

Saiem Gilani
