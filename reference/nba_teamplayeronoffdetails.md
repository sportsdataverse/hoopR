# **Get NBA Stats API Teams**

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use
[`nba_franchiseleaders()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md)
instead.

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use `nba_teamgamelogs()`
instead.

## Usage

``` r
nba_teams(...)

nba_teamdetails(team_id = "1610612749", ...)

nba_teamestimatedmetrics(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_teamgamelog(
  date_from = "",
  date_to = "",
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  team_id = "1610612749",
  ...
)

nba_teamgamelogs(
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
  player_id = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_teamhistoricalleaders(
  league_id = "00",
  season_id = "22022",
  team_id = "1610612749",
  ...
)

nba_teaminfocommon(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  team_id = "1610612749",
  ...
)

nba_teamplayeronoffdetails(
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

nba_teamplayeronoffsummary(
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

nba_teamplayerdashboard(
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

nba_teamyearbyyearstats(
  league_id = "00",
  per_mode = "Totals",
  season_type = "Regular Season",
  team_id = "1610612749",
  ...
)

nba_teamvsplayer(
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
  player_id = "",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  vs_player_id = "2544",
  ...
)

nba_teamandplayersvsplayers(
  team_id,
  vs_team_id,
  player_id1,
  player_id2,
  player_id3,
  player_id4,
  player_id5,
  vs_player_id1,
  vs_player_id2,
  vs_player_id3,
  vs_player_id4,
  vs_player_id5,
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  measure_type = "Base",
  per_mode = "Totals",
  plus_minus = "N",
  pace_adjust = "N",
  rank = "N",
  league_id = "00",
  last_n_games = 0,
  month = 0,
  opponent_team_id = 0,
  period = 0,
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  game_segment = "",
  location = "",
  outcome = "",
  season_segment = "",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)

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

- ...:

  Additional arguments passed to an underlying function like httr.

- team_id:

  team_id

- league_id:

  league_id

- season:

  season

- season_type:

  season_type

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

- per_mode:

  per_mode

- period:

  period

- player_id:

  Player ID

- season_segment:

  season_segment

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- season_id:

  season_id

- pace_adjust:

  pace_adjust

- plus_minus:

  plus_minus

- rank:

  rank

- shot_clock_range:

  shot_clock_range

- vs_player_id:

  vs_player_id

- vs_team_id:

  Opponent Team ID to compare against

- player_id1:

  Player ID 1 for team lineup

- player_id2:

  Player ID 2 for team lineup

- player_id3:

  Player ID 3 for team lineup

- player_id4:

  Player ID 4 for team lineup

- player_id5:

  Player ID 5 for team lineup

- vs_player_id1:

  Opponent Player ID 1 for comparison lineup

- vs_player_id2:

  Opponent Player ID 2 for comparison lineup

- vs_player_id3:

  Opponent Player ID 3 for comparison lineup

- vs_player_id4:

  Opponent Player ID 4 for comparison lineup

- vs_player_id5:

  Opponent Player ID 5 for comparison lineup

- conference:

  Conference filter - 'East', 'West', or ”

- division:

  Division filter

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

## Value

Return a data frame with the following columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| league_id | character | League identifier ('10' = WNBA). |
| season_id | character | Unique season identifier. |
| team_id | character | Unique team identifier. |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| conference | character | Conference. |
| division | character | Team division. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_name_full | character | Team name full. |
| season | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| espn_team_id | integer | Unique identifier for espn team. |
| abbreviation | character | Short abbreviation. |
| display_name | character | Display name. |
| mascot | character | Team mascot. |
| nickname | character | Team or athlete nickname. |
| team | character | Team-side label or team identifier. |
| color | character | Primary color (hex without leading '#'). |
| alternate_color | character | Alternate color (hex without leading '#'). |
| logo | character | Team or league logo URL. |
| logo_dark | character | Logo dark. |
| logos_href_3 | character | Logos href 3. |
| logos_href_4 | character | Logos href 4. |
| nba_logo_svg | character | Nba logo svg. |

Return a named list of data frames: TeamAwardsChampionships,
TeamAwardsConf, TeamAwardsDiv, TeamBackground, TeamHistory, TeamHof,
TeamRetired, TeamSocialSites

**TeamBackground**

|                    |           |                           |
|--------------------|-----------|---------------------------|
| col_name           | types     | description               |
| TEAM_ID            | character | Unique team identifier.   |
| ABBREVIATION       | character | Short abbreviation.       |
| NICKNAME           | character | Team or athlete nickname. |
| YEARFOUNDED        | character |                           |
| CITY               | character | City.                     |
| ARENA              | character | Arena.                    |
| ARENACAPACITY      | character |                           |
| OWNER              | character |                           |
| GENERALMANAGER     | character |                           |
| HEADCOACH          | character |                           |
| DLEAGUEAFFILIATION | character |                           |

**TeamHistory**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| TEAM_ID        | character | Unique team identifier.   |
| CITY           | character | City.                     |
| NICKNAME       | character | Team or athlete nickname. |
| YEARFOUNDED    | character |                           |
| YEARACTIVETILL | character |                           |

**TeamSocialSites**

|              |           |             |
|--------------|-----------|-------------|
| col_name     | types     | description |
| ACCOUNTTYPE  | character |             |
| WEBSITE_LINK | character |             |

**TeamAwardsChampionships**

|              |           |             |
|--------------|-----------|-------------|
| col_name     | types     | description |
| YEARAWARDED  | character |             |
| OPPOSITETEAM | character |             |

**TeamAwardsConf**

|              |         |             |
|--------------|---------|-------------|
| col_name     | types   | description |
| YEARAWARDED  | integer |             |
| OPPOSITETEAM | integer |             |

**TeamAwardsDiv**

Same columns as the **TeamAwardsConf** table above.

**TeamHof**

|                 |           |                                         |
|-----------------|-----------|-----------------------------------------|
| col_name        | types     | description                             |
| PLAYERID        | character | Playerid.                               |
| PLAYER          | character | Player.                                 |
| POSITION        | character | Listed roster position (G, F, C, etc.). |
| JERSEY          | character | Jersey number worn by the player.       |
| SEASONSWITHTEAM | character |                                         |
| YEAR            | character | 4-digit year.                           |

**TeamRetired**

Same columns as the **TeamHof** table above.

Return a named list of data frames: TeamEstimatedMetrics

**TeamEstimatedMetrics**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ID | character | Unique team identifier. |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
| MIN | character | Minutes played. |
| E_OFF_RATING | character |  |
| E_DEF_RATING | character |  |
| E_NET_RATING | character |  |
| E_PACE | character |  |
| E_AST_RATIO | character |  |
| E_OREB_PCT | character |  |
| E_DREB_PCT | character |  |
| E_REB_PCT | character |  |
| E_TM_TOV_PCT | character |  |
| GP_RANK | character |  |
| W_RANK | character |  |
| L_RANK | character |  |
| W_PCT_RANK | character |  |
| MIN_RANK | character |  |
| E_OFF_RATING_RANK | character |  |
| E_DEF_RATING_RANK | character |  |
| E_NET_RATING_RANK | character |  |
| E_AST_RATIO_RANK | character |  |
| E_OREB_PCT_RANK | character |  |
| E_DREB_PCT_RANK | character |  |
| E_REB_PCT_RANK | character |  |
| E_TM_TOV_PCT_RANK | character |  |
| E_PACE_RANK | character |  |

Return a named list of data frames: TeamGameLog

**TeamGameLog**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| Team_ID   | character | Unique team identifier.                  |
| Game_ID   | character | Unique game identifier.                  |
| GAME_DATE | character | Game date (YYYY-MM-DD).                  |
| MATCHUP   | character | Matchup.                                 |
| WL        | character | Wl.                                      |
| W         | character | Wins.                                    |
| L         | character | Losses.                                  |
| W_PCT     | character |                                          |
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

Return a named list of data frames: TeamGameLogs

**TeamGameLogs**

|  |  |  |
|----|----|----|
| col_name | types | description |
| SEASON_YEAR | character | Season year string ('YYYY-YY' format). |
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

Return a named list of data frames: CareerLeadersByTeam

**CareerLeadersByTeam**

|               |           |                                        |
|---------------|-----------|----------------------------------------|
| col_name      | types     | description                            |
| TEAM_ID       | character | Unique team identifier.                |
| PTS           | character | Points scored.                         |
| PTS_PERSON_ID | character |                                        |
| PTS_PLAYER    | character |                                        |
| AST           | character | Assists.                               |
| AST_PERSON_ID | character |                                        |
| AST_PLAYER    | character |                                        |
| REB           | character | Total rebounds.                        |
| REB_PERSON_ID | character |                                        |
| REB_PLAYER    | character |                                        |
| BLK           | character | Blocks.                                |
| BLK_PERSON_ID | character |                                        |
| BLK_PLAYER    | character |                                        |
| STL           | character | Steals.                                |
| STL_PERSON_ID | character |                                        |
| STL_PLAYER    | character |                                        |
| SEASON_YEAR   | character | Season year string ('YYYY-YY' format). |

Return a named list of data frames: AvailableSeasons, TeamInfoCommon,
TeamSeasonRanks

**TeamInfoCommon**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| SEASON_YEAR | character | Season year string ('YYYY-YY' format). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CONFERENCE | character |  |
| TEAM_DIVISION | character |  |
| TEAM_CODE | character |  |
| TEAM_SLUG | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| W | character | Wins. |
| L | character | Losses. |
| PCT | character | Pct. |
| CONF_RANK | character |  |
| DIV_RANK | character |  |
| MIN_YEAR | character |  |
| MAX_YEAR | character |  |

**TeamSeasonRanks**

|              |           |                                  |
|--------------|-----------|----------------------------------|
| col_name     | types     | description                      |
| LEAGUE_ID    | character | League identifier ('10' = WNBA). |
| SEASON_ID    | character | Unique season identifier.        |
| TEAM_ID      | character | Unique team identifier.          |
| PTS_RANK     | character |                                  |
| PTS_PG       | character |                                  |
| REB_RANK     | character |                                  |
| REB_PG       | character |                                  |
| AST_RANK     | character |                                  |
| AST_PG       | character |                                  |
| OPP_PTS_RANK | character |                                  |
| OPP_PTS_PG   | character |                                  |

**AvailableSeasons**

|           |           |                           |
|-----------|-----------|---------------------------|
| col_name  | types     | description               |
| SEASON_ID | character | Unique season identifier. |

Return a named list of data frames: OverallTeamPlayerOnOffDetails,
PlayersOffCourtTeamPlayerOnOffDetails,
PlayersOnCourtTeamPlayerOnOffDetails

**OverallTeamPlayerOnOffDetails**

Columns as documented in the shared
[nba_teamplayeronoffdetails_overallteamplayeronoffdetails_schema](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails_overallteamplayeronoffdetails_schema.md)
table.

**PlayersOnCourtTeamPlayerOnOffDetails**

Columns as documented in the shared
[nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema.md)
table.

**PlayersOffCourtTeamPlayerOnOffDetails**

Columns as documented in the shared
[nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema.md)
table.

Return a named list of data frames: OverallTeamPlayerOnOffSummary,
PlayersOffCourtTeamPlayerOnOffSummary,
PlayersOnCourtTeamPlayerOnOffSummary

**OverallTeamPlayerOnOffSummary**

Columns as documented in the shared
[nba_teamplayeronoffdetails_overallteamplayeronoffdetails_schema](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails_overallteamplayeronoffdetails_schema.md)
table.

**PlayersOnCourtTeamPlayerOnOffSummary**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GP | character | Games played. |
| MIN | character | Minutes played. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |
| OFF_RATING | character | Offensive rating (points produced per 100 possessions). |
| DEF_RATING | character | Defensive rating (points allowed per 100 possessions). |
| NET_RATING | character | Net rating (off rating - def rating). |

**PlayersOffCourtTeamPlayerOnOffSummary**

Same columns as the **PlayersOnCourtTeamPlayerOnOffSummary** table
above.

Return a named list of data frames: PlayersSeasonTotals, TeamOverall

**TeamOverall**

|                 |           |                                                 |
|-----------------|-----------|-------------------------------------------------|
| col_name        | types     | description                                     |
| GROUP_SET       | character |                                                 |
| TEAM_ID         | character | Unique team identifier.                         |
| TEAM_NAME       | character | Full team display name (e.g. 'Las Vegas Aces'). |
| GROUP_VALUE     | character |                                                 |
| GP              | character | Games played.                                   |
| W               | character | Wins.                                           |
| L               | character | Losses.                                         |
| W_PCT           | character |                                                 |
| MIN             | character | Minutes played.                                 |
| FGM             | character | Field goals made.                               |
| FGA             | character | Field goal attempts.                            |
| FG_PCT          | character | Field goal percentage (0-1).                    |
| FG3M            | character | Three-point field goals made.                   |
| FG3A            | character | Three-point field goal attempts.                |
| FG3_PCT         | character | Three-point field goal percentage (0-1).        |
| FTM             | character | Free throws made.                               |
| FTA             | character | Free throw attempts.                            |
| FT_PCT          | character | Free throw percentage (0-1).                    |
| OREB            | character | Offensive rebounds.                             |
| DREB            | character | Defensive rebounds.                             |
| REB             | character | Total rebounds.                                 |
| AST             | character | Assists.                                        |
| TOV             | character | Turnovers.                                      |
| STL             | character | Steals.                                         |
| BLK             | character | Blocks.                                         |
| BLKA            | character |                                                 |
| PF              | character | Personal fouls.                                 |
| PFD             | character |                                                 |
| PTS             | character | Points scored.                                  |
| PLUS_MINUS      | character | Plus/minus point differential while on court.   |
| GP_RANK         | character |                                                 |
| W_RANK          | character |                                                 |
| L_RANK          | character |                                                 |
| W_PCT_RANK      | character |                                                 |
| MIN_RANK        | character |                                                 |
| FGM_RANK        | character |                                                 |
| FGA_RANK        | character |                                                 |
| FG_PCT_RANK     | character |                                                 |
| FG3M_RANK       | character |                                                 |
| FG3A_RANK       | character |                                                 |
| FG3_PCT_RANK    | character |                                                 |
| FTM_RANK        | character |                                                 |
| FTA_RANK        | character |                                                 |
| FT_PCT_RANK     | character |                                                 |
| OREB_RANK       | character |                                                 |
| DREB_RANK       | character |                                                 |
| REB_RANK        | character |                                                 |
| AST_RANK        | character |                                                 |
| TOV_RANK        | character |                                                 |
| STL_RANK        | character |                                                 |
| BLK_RANK        | character |                                                 |
| BLKA_RANK       | character |                                                 |
| PF_RANK         | character |                                                 |
| PFD_RANK        | character |                                                 |
| PTS_RANK        | character |                                                 |
| PLUS_MINUS_RANK | character |                                                 |

**PlayersSeasonTotals**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
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

Return a named list of data frames: TeamStats

**TeamStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| YEAR | character | 4-digit year. |
| GP | character | Games played. |
| WINS | character | Total wins. |
| LOSSES | character | Total losses. |
| WIN_PCT | character |  |
| CONF_RANK | character |  |
| DIV_RANK | character |  |
| PO_WINS | character |  |
| PO_LOSSES | character |  |
| CONF_COUNT | character |  |
| DIV_COUNT | character |  |
| NBA_FINALS_APPEARANCE | character |  |
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
| PF | character | Personal fouls. |
| STL | character | Steals. |
| TOV | character | Turnovers. |
| BLK | character | Blocks. |
| PTS | character | Points scored. |
| PTS_RANK | character |  |

Return a named list of data frames: OnOffCourt, Overall,
ShotAreaOffCourt, ShotAreaOnCourt, ShotAreaOverall,
ShotDistanceOffCourt, ShotDistanceOnCourt, ShotDistanceOverall,
vsPlayerOverall

**Overall**

|                   |           |                                               |
|-------------------|-----------|-----------------------------------------------|
| col_name          | types     | description                                   |
| GROUP_SET         | character |                                               |
| GROUP_VALUE       | character |                                               |
| TEAM_ID           | character | Unique team identifier.                       |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').         |
| GP                | character | Games played.                                 |
| W                 | character | Wins.                                         |
| L                 | character | Losses.                                       |
| W_PCT             | character |                                               |
| MIN               | character | Minutes played.                               |
| FGM               | character | Field goals made.                             |
| FGA               | character | Field goal attempts.                          |
| FG_PCT            | character | Field goal percentage (0-1).                  |
| FG3M              | character | Three-point field goals made.                 |
| FG3A              | character | Three-point field goal attempts.              |
| FG3_PCT           | character | Three-point field goal percentage (0-1).      |
| FTM               | character | Free throws made.                             |
| FTA               | character | Free throw attempts.                          |
| FT_PCT            | character | Free throw percentage (0-1).                  |
| OREB              | character | Offensive rebounds.                           |
| DREB              | character | Defensive rebounds.                           |
| REB               | character | Total rebounds.                               |
| AST               | character | Assists.                                      |
| TOV               | character | Turnovers.                                    |
| STL               | character | Steals.                                       |
| BLK               | character | Blocks.                                       |
| BLKA              | character |                                               |
| PF                | character | Personal fouls.                               |
| PFD               | character |                                               |
| PTS               | character | Points scored.                                |
| PLUS_MINUS        | character | Plus/minus point differential while on court. |
| GP_RANK           | character |                                               |
| W_RANK            | character |                                               |
| L_RANK            | character |                                               |
| W_PCT_RANK        | character |                                               |
| MIN_RANK          | character |                                               |
| FGM_RANK          | character |                                               |
| FGA_RANK          | character |                                               |
| FG_PCT_RANK       | character |                                               |
| FG3M_RANK         | character |                                               |
| FG3A_RANK         | character |                                               |
| FG3_PCT_RANK      | character |                                               |
| FTM_RANK          | character |                                               |
| FTA_RANK          | character |                                               |
| FT_PCT_RANK       | character |                                               |
| OREB_RANK         | character |                                               |
| DREB_RANK         | character |                                               |
| REB_RANK          | character |                                               |
| AST_RANK          | character |                                               |
| TOV_RANK          | character |                                               |
| STL_RANK          | character |                                               |
| BLK_RANK          | character |                                               |
| BLKA_RANK         | character |                                               |
| PF_RANK           | character |                                               |
| PFD_RANK          | character |                                               |
| PTS_RANK          | character |                                               |
| PLUS_MINUS_RANK   | character |                                               |

**vsPlayerOverall**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| GROUP_VALUE | character |  |
| PLAYER_ID | character | Unique player identifier. |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
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

**OnOffCourt**

Columns as documented in the shared
[nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails_playersoncourtleagueplayerdetails_schema.md)
table.

**ShotDistanceOverall**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| GROUP_VALUE | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotDistanceOnCourt**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GROUP_VALUE | character |  |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotDistanceOffCourt**

Same columns as the **ShotDistanceOnCourt** table above.

**ShotAreaOverall**

Same columns as the **ShotDistanceOverall** table above.

**ShotAreaOnCourt**

Same columns as the **ShotDistanceOnCourt** table above.

**ShotAreaOffCourt**

Same columns as the **ShotDistanceOnCourt** table above.

Returns a named list of data frames: PlayersVsPlayers,
TeamPlayersVsPlayersOff, TeamPlayersVsPlayersOn, TeamVsPlayers,
TeamVsPlayersOff

**PlayersVsPlayers**

|                   |           |                                               |
|-------------------|-----------|-----------------------------------------------|
| col_name          | types     | description                                   |
| GROUP_SET         | character |                                               |
| TITLE_DESCRIPTION | character |                                               |
| DESCRIPTION       | character | Long-form description text.                   |
| MIN               | character | Minutes played.                               |
| FGM               | character | Field goals made.                             |
| FGA               | character | Field goal attempts.                          |
| FG_PCT            | character | Field goal percentage (0-1).                  |
| FG3M              | character | Three-point field goals made.                 |
| FG3A              | character | Three-point field goal attempts.              |
| FG3_PCT           | character | Three-point field goal percentage (0-1).      |
| FTM               | character | Free throws made.                             |
| FTA               | character | Free throw attempts.                          |
| FT_PCT            | character | Free throw percentage (0-1).                  |
| OREB              | character | Offensive rebounds.                           |
| DREB              | character | Defensive rebounds.                           |
| REB               | character | Total rebounds.                               |
| AST               | character | Assists.                                      |
| TOV               | character | Turnovers.                                    |
| STL               | character | Steals.                                       |
| BLK               | character | Blocks.                                       |
| BLKA              | character |                                               |
| PF                | character | Personal fouls.                               |
| PFD               | character |                                               |
| PTS               | character | Points scored.                                |
| PLUS_MINUS        | character | Plus/minus point differential while on court. |

**TeamPlayersVsPlayersOn**

|                   |           |                                               |
|-------------------|-----------|-----------------------------------------------|
| col_name          | types     | description                                   |
| GROUP_SET         | character |                                               |
| TITLE_DESCRIPTION | character |                                               |
| PLAYER_ID         | character | Unique player identifier.                     |
| PLAYER_NAME       | character | Player name.                                  |
| MIN               | character | Minutes played.                               |
| FGM               | character | Field goals made.                             |
| FGA               | character | Field goal attempts.                          |
| FG_PCT            | character | Field goal percentage (0-1).                  |
| FG3M              | character | Three-point field goals made.                 |
| FG3A              | character | Three-point field goal attempts.              |
| FG3_PCT           | character | Three-point field goal percentage (0-1).      |
| FTM               | character | Free throws made.                             |
| FTA               | character | Free throw attempts.                          |
| FT_PCT            | character | Free throw percentage (0-1).                  |
| OREB              | character | Offensive rebounds.                           |
| DREB              | character | Defensive rebounds.                           |
| REB               | character | Total rebounds.                               |
| AST               | character | Assists.                                      |
| TOV               | character | Turnovers.                                    |
| STL               | character | Steals.                                       |
| BLK               | character | Blocks.                                       |
| BLKA              | character |                                               |
| PF                | character | Personal fouls.                               |
| PFD               | character |                                               |
| PTS               | character | Points scored.                                |
| PLUS_MINUS        | character | Plus/minus point differential while on court. |

**TeamPlayersVsPlayersOff**

Same columns as the **TeamPlayersVsPlayersOn** table above.

**TeamVsPlayers**

Same columns as the **PlayersVsPlayers** table above.

**TeamVsPlayersOff**

Same columns as the **PlayersVsPlayers** table above.

Return a named list of data frames:
TeamGameStreakFinderParametersResults

**TeamGameStreakFinderParametersResults**

|              |           |                                                 |
|--------------|-----------|-------------------------------------------------|
| col_name     | types     | description                                     |
| TEAM_NAME    | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ID      | character | Unique team identifier.                         |
| GAMESTREAK   | character |                                                 |
| STARTDATE    | character |                                                 |
| ENDDATE      | character |                                                 |
| ACTIVESTREAK | character |                                                 |
| NUMSEASONS   | character |                                                 |
| LASTSEASON   | character |                                                 |
| FIRSTSEASON  | character |                                                 |
| ABBREVIATION | character | Short abbreviation.                             |

## Details

     nba_teams()

     nba_teamdetails(team_id = '1610612749')

[Team Estimated
Metrics](https://www.nba.com/stats/teams/estimated-advanced)

     nba_teamestimatedmetrics()

[Teams Game Log](https://www.nba.com/stats/team/1610612749/boxscores)

     nba_teamgamelog(team_id = '1610612749')

[Teams Game Log](https://www.nba.com/stats/team/1610612749/boxscores)

     nba_teamgamelogs(team_id = '1610612749')

     nba_teamhistoricalleaders(team_id = '1610612749')

     nba_teaminfocommon(team_id = '1610612749')

     nba_teamplayeronoffdetails(team_id = '1610612749')

     nba_teamplayeronoffsummary(team_id = '1610612749')

     nba_teamplayerdashboard(team_id = '1610612749')

[Team Year by Year
Stats](https://www.nba.com/stats/team/1610612756/seasons)

     nba_teamyearbyyearstats(team_id = '1610612749')

     nba_teamvsplayer(team_id = '1610612749', vs_player_id = '2544')

     nba_teamandplayersvsplayers(
       team_id = '1610612739',
       vs_team_id = '1610612765',
       player_id1 = '202681', player_id2 = '203078',
       player_id3 = '203507', player_id4 = '201567',
       player_id5 = '203954',
       vs_player_id1 = '201566', vs_player_id2 = '201939',
       vs_player_id3 = '201935', vs_player_id4 = '201142',
       vs_player_id5 = '203076',
       season = '2019-20')

     nba_teamgamestreakfinder()

## See also

Other NBA Team Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

Other NBA Game Finder Functions:
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)

## Author

Saiem Gilani
