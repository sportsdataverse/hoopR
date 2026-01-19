# **Get NBA Stats API Team Game Streak Finder**

**Get NBA Stats API Team Game Streak Finder**

**Get NBA Stats API Team Game Streak Finder**

## Usage

``` r
nba_teamgamestreakfinder(
  active_streaks_only = "",
  active_teams_only = "",
  btr_opp_ast = "",
  btr_opp_blk = "",
  btr_opp_dreb = "",
  btr_opp_fg3a = "",
  btr_opp_fg3m = "",
  btr_opp_fg3_pct = "",
  btr_opp_fga = "",
  btr_opp_fgm = "",
  btr_opp_fg_pct = "",
  btr_opp_fta = "",
  btr_opp_ftm = "",
  btr_opp_ft_pct = "",
  btr_opp_oreb = "",
  btr_opp_pf = "",
  btr_opp_pts = "",
  btr_opp_pts2nd_chance = "",
  btr_opp_pts_fb = "",
  btr_opp_pts_off_tov = "",
  btr_opp_pts_paint = "",
  btr_opp_reb = "",
  btr_opp_stl = "",
  btr_opp_tov = "",
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
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
  eq_opp_pts2nd_chance = "",
  eq_opp_pts_fb = "",
  eq_opp_pts_off_tov = "",
  eq_opp_pts_paint = "",
  et_oreb = "",
  et_pf = "",
  et_pts = "",
  eq_pts2nd_chance = "",
  eq_pts_fb = "",
  eq_pts_off_tov = "",
  eq_pts_paint = "",
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
  gt_opp_ast = "",
  gt_opp_blk = "",
  gt_opp_dreb = "",
  gt_opp_fg3a = "",
  gt_opp_fg3m = "",
  gt_opp_fg3_pct = "",
  gt_opp_fga = "",
  gt_opp_fgm = "",
  gt_opp_fg_pct = "",
  gt_opp_fta = "",
  gt_opp_ftm = "",
  gt_opp_ft_pct = "",
  gt_opp_oreb = "",
  gt_opp_pf = "",
  gt_opp_pts = "",
  gt_opp_pts2nd_chance = "",
  gt_opp_pts_fb = "",
  gt_opp_pts_off_tov = "",
  gt_opp_pts_paint = "",
  gt_opp_reb = "",
  gt_opp_stl = "",
  gt_opp_tov = "",
  gt_oreb = "",
  gt_pf = "",
  gt_pts = "",
  gt_pts2nd_chance = "",
  gt_pts_fb = "",
  gt_pts_off_tov = "",
  gt_pts_paint = "",
  gt_reb = "",
  gt_stl = "",
  gt_td = "",
  gt_tov = "",
  lstreak = "",
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
  lt_opp_ast = "",
  lt_opp_blk = "",
  lt_opp_dreb = "",
  lt_opp_fg3a = "",
  lt_opp_fg3m = "",
  lt_opp_fg3_pct = "",
  lt_opp_fga = "",
  lt_opp_fgm = "",
  lt_opp_fg_pct = "",
  lt_opp_fta = "",
  lt_opp_ftm = "",
  lt_opp_ft_pct = "",
  lt_opp_oreb = "",
  lt_opp_pf = "",
  lt_opp_pts = "",
  lt_opp_pts2nd_chance = "",
  lt_opp_pts_fb = "",
  lt_opp_pts_off_tov = "",
  lt_opp_pts_paint = "",
  lt_opp_reb = "",
  lt_opp_stl = "",
  lt_opp_tov = "",
  lt_oreb = "",
  lt_pf = "",
  lt_pts = "",
  lt_pts2nd_chance = "",
  lt_pts_fb = "",
  lt_pts_off_tov = "",
  lt_pts_paint = "",
  lt_reb = "",
  lt_stl = "",
  lt_td = "",
  lt_tov = "",
  min_games = "",
  outcome = "",
  po_round = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  vs_team_id = "",
  wstreak = "",
  wrs_opp_ast = "",
  wrs_opp_blk = "",
  wrs_opp_dreb = "",
  wrs_opp_fg3a = "",
  wrs_opp_fg3m = "",
  wrs_opp_fg3_pct = "",
  wrs_opp_fga = "",
  wrs_opp_fgm = "",
  wrs_opp_fg_pct = "",
  wrs_opp_fta = "",
  wrs_opp_ftm = "",
  wrs_opp_ft_pct = "",
  wrs_opp_oreb = "",
  wrs_opp_pf = "",
  wrs_opp_pts = "",
  wrs_opp_pts2nd_chance = "",
  wrs_opp_pts_fb = "",
  wrs_opp_pts_off_tov = "",
  wrs_opp_pts_paint = "",
  wrs_opp_reb = "",
  wrs_opp_stl = "",
  wrs_opp_tov = "",
  ...
)
```

## Arguments

- active_streaks_only:

  active_streaks_only

- active_teams_only:

  active_teams_only

- btr_opp_ast:

  btr_opp_ast

- btr_opp_blk:

  btr_opp_blk

- btr_opp_dreb:

  btr_opp_dreb

- btr_opp_fg3a:

  btr_opp_fg3a

- btr_opp_fg3m:

  btr_opp_fg3m

- btr_opp_fg3_pct:

  btr_opp_fg3_pct

- btr_opp_fga:

  btr_opp_fga

- btr_opp_fgm:

  btr_opp_fgm

- btr_opp_fg_pct:

  btr_opp_fg_pct

- btr_opp_fta:

  btr_opp_fta

- btr_opp_ftm:

  btr_opp_ftm

- btr_opp_ft_pct:

  btr_opp_ft_pct

- btr_opp_oreb:

  btr_opp_oreb

- btr_opp_pf:

  btr_opp_pf

- btr_opp_pts:

  btr_opp_pts

- btr_opp_pts2nd_chance:

  btr_opp_pts2nd_chance

- btr_opp_pts_fb:

  btr_opp_pts_fb

- btr_opp_pts_off_tov:

  btr_opp_pts_off_tov

- btr_opp_pts_paint:

  btr_opp_pts_paint

- btr_opp_reb:

  btr_opp_reb

- btr_opp_stl:

  btr_opp_stl

- btr_opp_tov:

  btr_opp_tov

- conference:

  conference

- date_from:

  date_from

- date_to:

  date_to

- division:

  division

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

- eq_opp_pts2nd_chance:

  eq_opp_pts2nd_chance

- eq_opp_pts_fb:

  eq_opp_pts_fb

- eq_opp_pts_off_tov:

  eq_opp_pts_off_tov

- eq_opp_pts_paint:

  eq_opp_pts_paint

- et_oreb:

  et_oreb

- et_pf:

  et_pf

- et_pts:

  et_pts

- eq_pts2nd_chance:

  eq_pts2nd_chance

- eq_pts_fb:

  eq_pts_fb

- eq_pts_off_tov:

  eq_pts_off_tov

- eq_pts_paint:

  eq_pts_paint

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

- gt_opp_ast:

  gt_opp_ast

- gt_opp_blk:

  gt_opp_blk

- gt_opp_dreb:

  gt_opp_dreb

- gt_opp_fg3a:

  gt_opp_fg3a

- gt_opp_fg3m:

  gt_opp_fg3m

- gt_opp_fg3_pct:

  gt_opp_fg3_pct

- gt_opp_fga:

  gt_opp_fga

- gt_opp_fgm:

  gt_opp_fgm

- gt_opp_fg_pct:

  gt_opp_fg_pct

- gt_opp_fta:

  gt_opp_fta

- gt_opp_ftm:

  gt_opp_ftm

- gt_opp_ft_pct:

  gt_opp_ft_pct

- gt_opp_oreb:

  gt_opp_oreb

- gt_opp_pf:

  gt_opp_pf

- gt_opp_pts:

  gt_opp_pts

- gt_opp_pts2nd_chance:

  gt_opp_pts2nd_chance

- gt_opp_pts_fb:

  gt_opp_pts_fb

- gt_opp_pts_off_tov:

  gt_opp_pts_off_tov

- gt_opp_pts_paint:

  gt_opp_pts_paint

- gt_opp_reb:

  gt_opp_reb

- gt_opp_stl:

  gt_opp_stl

- gt_opp_tov:

  gt_opp_tov

- gt_oreb:

  gt_oreb

- gt_pf:

  gt_pf

- gt_pts:

  gt_pts

- gt_pts2nd_chance:

  gt_pts2nd_chance

- gt_pts_fb:

  gt_pts_fb

- gt_pts_off_tov:

  gt_pts_off_tov

- gt_pts_paint:

  gt_pts_paint

- gt_reb:

  gt_reb

- gt_stl:

  gt_stl

- gt_td:

  gt_td

- gt_tov:

  gt_tov

- lstreak:

  lstreak

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

- lt_opp_ast:

  lt_opp_ast

- lt_opp_blk:

  lt_opp_blk

- lt_opp_dreb:

  lt_opp_dreb

- lt_opp_fg3a:

  lt_opp_fg3a

- lt_opp_fg3m:

  lt_opp_fg3m

- lt_opp_fg3_pct:

  lt_opp_fg3_pct

- lt_opp_fga:

  lt_opp_fga

- lt_opp_fgm:

  lt_opp_fgm

- lt_opp_fg_pct:

  lt_opp_fg_pct

- lt_opp_fta:

  lt_opp_fta

- lt_opp_ftm:

  lt_opp_ftm

- lt_opp_ft_pct:

  lt_opp_ft_pct

- lt_opp_oreb:

  lt_opp_oreb

- lt_opp_pf:

  lt_opp_pf

- lt_opp_pts:

  lt_opp_pts

- lt_opp_pts2nd_chance:

  lt_opp_pts2nd_chance

- lt_opp_pts_fb:

  lt_opp_pts_fb

- lt_opp_pts_off_tov:

  lt_opp_pts_off_tov

- lt_opp_pts_paint:

  lt_opp_pts_paint

- lt_opp_reb:

  lt_opp_reb

- lt_opp_stl:

  lt_opp_stl

- lt_opp_tov:

  lt_opp_tov

- lt_oreb:

  lt_oreb

- lt_pf:

  lt_pf

- lt_pts:

  lt_pts

- lt_pts2nd_chance:

  lt_pts2nd_chance

- lt_pts_fb:

  lt_pts_fb

- lt_pts_off_tov:

  lt_pts_off_tov

- lt_pts_paint:

  lt_pts_paint

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

- outcome:

  outcome

- po_round:

  po_round

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_team_id:

  vs_team_id

- wstreak:

  wstreak

- wrs_opp_ast:

  wrs_opp_ast

- wrs_opp_blk:

  wrs_opp_blk

- wrs_opp_dreb:

  wrs_opp_dreb

- wrs_opp_fg3a:

  wrs_opp_fg3a

- wrs_opp_fg3m:

  wrs_opp_fg3m

- wrs_opp_fg3_pct:

  wrs_opp_fg3_pct

- wrs_opp_fga:

  wrs_opp_fga

- wrs_opp_fgm:

  wrs_opp_fgm

- wrs_opp_fg_pct:

  wrs_opp_fg_pct

- wrs_opp_fta:

  wrs_opp_fta

- wrs_opp_ftm:

  wrs_opp_ftm

- wrs_opp_ft_pct:

  wrs_opp_ft_pct

- wrs_opp_oreb:

  wrs_opp_oreb

- wrs_opp_pf:

  wrs_opp_pf

- wrs_opp_pts:

  wrs_opp_pts

- wrs_opp_pts2nd_chance:

  wrs_opp_pts2nd_chance

- wrs_opp_pts_fb:

  wrs_opp_pts_fb

- wrs_opp_pts_off_tov:

  wrs_opp_pts_off_tov

- wrs_opp_pts_paint:

  wrs_opp_pts_paint

- wrs_opp_reb:

  wrs_opp_reb

- wrs_opp_stl:

  wrs_opp_stl

- wrs_opp_tov:

  wrs_opp_tov

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames:
TeamGameStreakFinderParametersResults

**TeamGameStreakFinderParametersResults**

|              |           |
|--------------|-----------|
| col_name     | types     |
| TEAM_NAME    | character |
| TEAM_ID      | character |
| GAMESTREAK   | character |
| STARTDATE    | character |
| ENDDATE      | character |
| ACTIVESTREAK | character |
| NUMSEASONS   | character |
| LASTSEASON   | character |
| FIRSTSEASON  | character |
| ABBREVIATION | character |

## Details

     nba_teamgamestreakfinder()

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyclutch.md),
[`nba_teamdashboardbygamesplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbygamesplits.md),
[`nba_teamdashboardbygeneralsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbygeneralsplits.md),
[`nba_teamdashboardbylastngames()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbylastngames.md),
[`nba_teamdashboardbyopponent()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyopponent.md),
[`nba_teamdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyshootingsplits.md),
[`nba_teamdashboardbyteamperformance()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyteamperformance.md),
[`nba_teamdashboardbyyearoveryear()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyyearoveryear.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_teamdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamdetails.md),
[`nba_teamestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_teamestimatedmetrics.md),
[`nba_teamgamelog()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelog.md),
[`nba_teamgamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelogs.md),
[`nba_teamhistoricalleaders()`](https://hoopR.sportsdataverse.org/reference/nba_teamhistoricalleaders.md),
[`nba_teaminfocommon()`](https://hoopR.sportsdataverse.org/reference/nba_teaminfocommon.md),
[`nba_teamplayerdashboard()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayerdashboard.md),
[`nba_teamplayeronoffdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md),
[`nba_teamplayeronoffsummary()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffsummary.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md),
[`nba_teamvsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_teamvsplayer.md),
[`nba_teamyearbyyearstats()`](https://hoopR.sportsdataverse.org/reference/nba_teamyearbyyearstats.md)

Other NBA Game Finder Functions:
[`nba_leaguegamefinder()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamefinder.md),
[`nba_playergamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_playergamestreakfinder.md)

## Author

Saiem Gilani
