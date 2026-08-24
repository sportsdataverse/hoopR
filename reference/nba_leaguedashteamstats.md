# **Get NBA Stats API League Dashboard Team Stats**

**Get NBA Stats API League Dashboard Team Stats**

**Get NBA Stats API League Dashboard Team Stats**

## Usage

``` r
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
```

## Arguments

- conference:

  conference

- date_from:

  date_from

- date_to:

  date_to

- division:

  division

- game_scope:

  game_scope

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

- starter_bench:

  starter_bench

- team_id:

  team_id

- two_way:

  two_way

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: LeagueDashTeamStats

**LeagueDashTeamStats**

Columns as documented in the shared
[nba_leaguedashteamclutch_leaguedashteamclutch_schema](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch_leaguedashteamclutch_schema.md)
table.

## Details

[Team Stats](https://www.nba.com/stats/teams/traditional)

     nba_leaguedashteamstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
[`nba_iststandings()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerbiostats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerbiostats.md),
[`nba_leaguedashplayerclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerclutch.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashplayerstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerstats.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_leaguegamefinder()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamefinder.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamelog.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_leagueplayerondetails()`](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails.md),
[`nba_leagueseasonmatchups()`](https://hoopR.sportsdataverse.org/reference/nba_leagueseasonmatchups.md),
[`nba_leaguestandings()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandings.md),
[`nba_leaguestandingsv3()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandingsv3.md),
[`nba_matchupsrollup()`](https://hoopR.sportsdataverse.org/reference/nba_matchupsrollup.md),
[`nba_playoffpicture()`](https://hoopR.sportsdataverse.org/reference/nba_playoffpicture.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md)

Other NBA Team Functions:
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md),
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
[`nba_teamplayeronoffdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md),
[`nba_teamvsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_teamvsplayer.md),
[`nba_teamyearbyyearstats()`](https://hoopR.sportsdataverse.org/reference/nba_teamyearbyyearstats.md)

## Author

Saiem Gilani
