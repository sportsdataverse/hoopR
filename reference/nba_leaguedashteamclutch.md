# **Get NBA Stats API League Dashboard by Team Clutch Splits**

**Get NBA Stats API League Dashboard by Team Clutch Splits**

**Get NBA Stats API League Dashboard by Team Clutch Splits**

## Usage

``` r
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
```

## Arguments

- ahead_behind:

  ahead_behind

- clutch_time:

  clutch_time

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

- pace_adjust:

  pace_adjust

- plus_minus:

  plus_minus

- point_diff:

  point_diff

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

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: LeagueDashTeamClutch

**LeagueDashTeamClutch**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| TEAM_ID         | character |
| TEAM_NAME       | character |
| GP              | character |
| W               | character |
| L               | character |
| W_PCT           | character |
| MIN             | character |
| FGM             | character |
| FGA             | character |
| FG_PCT          | character |
| FG3M            | character |
| FG3A            | character |
| FG3_PCT         | character |
| FTM             | character |
| FTA             | character |
| FT_PCT          | character |
| OREB            | character |
| DREB            | character |
| REB             | character |
| AST             | character |
| TOV             | character |
| STL             | character |
| BLK             | character |
| BLKA            | character |
| PF              | character |
| PFD             | character |
| PTS             | character |
| PLUS_MINUS      | character |
| GP_RANK         | character |
| W_RANK          | character |
| L_RANK          | character |
| W_PCT_RANK      | character |
| MIN_RANK        | character |
| FGM_RANK        | character |
| FGA_RANK        | character |
| FG_PCT_RANK     | character |
| FG3M_RANK       | character |
| FG3A_RANK       | character |
| FG3_PCT_RANK    | character |
| FTM_RANK        | character |
| FTA_RANK        | character |
| FT_PCT_RANK     | character |
| OREB_RANK       | character |
| DREB_RANK       | character |
| REB_RANK        | character |
| AST_RANK        | character |
| TOV_RANK        | character |
| STL_RANK        | character |
| BLK_RANK        | character |
| BLKA_RANK       | character |
| PF_RANK         | character |
| PFD_RANK        | character |
| PTS_RANK        | character |
| PLUS_MINUS_RANK | character |

## Details

[Team Clutch Stats](https://www.nba.com/stats/teams/clutch-traditional)

     nba_leaguedashteamclutch(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
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

Other NBA Clutch Functions:
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyclutch.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyclutch.md)

## Author

Saiem Gilani
