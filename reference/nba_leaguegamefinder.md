# **Get NBA Stats API League Game Streak Finder**

**Get NBA Stats API League Game Streak Finder**

**Get NBA Stats API League Game Streak Finder**

## Usage

``` r
nba_leaguegamefinder(
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
  outcome = "",
  po_round = "",
  player_id = "",
  player_or_team = "T",
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

- draft_year:

  draft_year

- draft_team_id:

  draft_team_id

- draft_round:

  draft_round

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

- game_id:

  game_id

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

- league_id:

  league_id

- location:

  location

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

- outcome:

  outcome

- po_round:

  po_round

- player_id:

  player_id

- player_or_team:

  player_or_team

- rookie_year:

  rookie_year

- season:

  season - Min: '1983-84'

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

- vs_team_id:

  vs_team_id

- years_experience:

  years_experience

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: LeagueGameFinderResults

**LeagueGameFinderResults**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| SEASON_ID         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| GAME_ID           | character |
| GAME_DATE         | character |
| MATCHUP           | character |
| WL                | character |
| MIN               | character |
| PTS               | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| FTM               | character |
| FTA               | character |
| FT_PCT            | character |
| OREB              | character |
| DREB              | character |
| REB               | character |
| AST               | character |
| STL               | character |
| BLK               | character |
| TOV               | character |
| PF                | character |
| PLUS_MINUS        | character |

## Details

     nba_leaguegamefinder(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

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
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamelog.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_leagueplayerondetails()`](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails.md),
[`nba_leagueseasonmatchups()`](https://hoopR.sportsdataverse.org/reference/nba_leagueseasonmatchups.md),
[`nba_leaguestandings()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandings.md),
[`nba_leaguestandingsv3()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandingsv3.md),
[`nba_matchupsrollup()`](https://hoopR.sportsdataverse.org/reference/nba_matchupsrollup.md),
[`nba_playoffpicture()`](https://hoopR.sportsdataverse.org/reference/nba_playoffpicture.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md)

Other NBA Game Finder Functions:
[`nba_playergamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_playergamestreakfinder.md),
[`nba_teamgamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamestreakfinder.md)

## Author

Saiem Gilani
