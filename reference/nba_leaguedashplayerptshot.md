# **Get NBA Stats API League Dashboard Player Tracking - Player Shots**

**Get NBA Stats API League Dashboard Player Tracking - Player Shots**

**Get NBA Stats API League Dashboard Player Tracking - Player Shots**

## Usage

``` r
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
```

## Arguments

- close_def_dist_range:

  close_def_dist_range

- college:

  college

- conference:

  conference

- country:

  country

- date_from:

  date_from

- date_to:

  date_to

- distance_range:

  distance_range

- division:

  division

- draft_pick:

  draft_pick

- draft_year:

  draft_year

- dribble_range:

  dribble_range

- game_scope:

  game_scope

- game_segment:

  game_segment

- general_range:

  general_range

- height:

  height

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

- po_round:

  po_round

- per_mode:

  per_mode

- period:

  period

- player_experience:

  player_experience

- player_position:

  player_position

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

- starter_bench:

  starter_bench

- team_id:

  team_id

- touch_time_range:

  touch_time_range

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- weight:

  weight

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

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

## Details

[Players Shot
Dashboard](https://www.nba.com/stats/players/shots-general)

     nba_leaguedashplayerptshot(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
[`nba_iststandings()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerbiostats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerbiostats.md),
[`nba_leaguedashplayerclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerclutch.md),
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashplayerstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerstats.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
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

Other NBA Player Tracking Functions:
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_synergyplaytypes()`](https://hoopR.sportsdataverse.org/reference/nba_synergyplaytypes.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

## Author

Saiem Gilani
