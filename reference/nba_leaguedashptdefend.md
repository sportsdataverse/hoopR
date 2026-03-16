# **Get NBA Stats API League Dashboard Player Tracking - Defense**

**Get NBA Stats API League Dashboard Player Tracking - Defense**

**Get NBA Stats API League Dashboard Player Tracking - Defense**

## Usage

``` r
nba_leaguedashptdefend(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  defense_category = "Overall",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_segment = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "Totals",
  period = "",
  player_experience = "",
  player_id = "",
  player_position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)
```

## Arguments

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

- defense_category:

  defense_category

- division:

  division

- draft_pick:

  draft_pick

- draft_year:

  draft_year

- game_segment:

  game_segment

- height:

  height

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

- po_round:

  po_round

- per_mode:

  per_mode

- period:

  period

- player_experience:

  player_experience

- player_id:

  player_id

- player_position:

  player_position

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- starter_bench:

  starter_bench

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- weight:

  weight

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: LeagueDashPTDefend

**LeagueDashPTDefend**

|                               |           |
|-------------------------------|-----------|
| col_name                      | types     |
| CLOSE_DEF_PERSON_ID           | character |
| PLAYER_NAME                   | character |
| PLAYER_LAST_TEAM_ID           | character |
| PLAYER_LAST_TEAM_ABBREVIATION | character |
| PLAYER_POSITION               | character |
| AGE                           | character |
| GP                            | character |
| G                             | character |
| FREQ                          | character |
| D_FGM                         | character |
| D_FGA                         | character |
| D_FG_PCT                      | character |
| NORMAL_FG_PCT                 | character |
| PCT_PLUSMINUS                 | character |

## Details

[Defensive
Dashboard](https://www.nba.com/stats/players/defense-dash-overall)

     nba_leaguedashptdefend(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

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
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
[`nba_playerdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshots.md),
[`nba_synergyplaytypes()`](https://hoopR.sportsdataverse.org/reference/nba_synergyplaytypes.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md)

## Author

Saiem Gilani
