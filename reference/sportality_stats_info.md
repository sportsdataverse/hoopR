# **Get Basketligaen Stats Table**

Stats table of one module for a season (players, teams, games,
standings).

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/stats-info/{module}`

## Usage

``` r
sportality_stats_info(module, season, game_type = "regular")
```

## Arguments

- module:

  (required) Stats table: players\_\* (summary, fieldGoal, rebound,
  point, offensive, defensive, foul), teams\_\* (summary, attendance,
  possession, fieldGoal, point, rebound, offensive, defensive, foul),
  games_games or standings_standings. One of `games_games`,
  `players_defensive`, `players_fieldGoal`, `players_foul`,
  `players_offensive`, `players_point`, `players_rebound`,
  `players_summary`, `standings_standings`, `teams_attendance`,
  `teams_defensive`, `teams_fieldGoal`, `teams_foul`, `teams_offensive`,
  `teams_point`, `teams_possession`, `teams_rebound`, `teams_summary`.

- season:

  (required) Season END year (2026 = 2025/26). Mapped to the provider's
  ssgt through /statistics-v2/layout- info (Basketligaen 2002/03 on); a
  season it does not list raises `hoopR_no_data`.

- game_type:

  (default `"regular"`) Game type: regular (the league season) or finals
  (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble: Stats table of one module for a season (players,
teams, games, standings). An empty valid answer raises `hoopR_no_data`;
the documented columns come first, in this order (sdv-py
`sportality_stats_info`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
| gp | integer | Number of games played. |
| eff | double | Efficiency (valuation) per game; the formula is the site's own (unverified). |
| mins | double | Average minutes played per game ('27.3'). |
| ppg | double | Points per game. |
| rpg | double | Rebounds per game. |
| apg | double | Assists per game. |
| stpg | double | Steals per game. |
| blkpg | double | Blocks per game. |
| info_uuid | character | Athlete uuid on player tables, team uuid on team tables (platform key space). |
| info_full_name | character | Full display name of the player. |
| info_first_name | character | Given (first) name(s) of the player. |
| info_last_name | character | Family name (surname) of the player. |
| info_nationality | character | ISO 3166-1 alpha-2 country code. |
| info_shoots | character | Shooting hand (null). |
| info_gender | character | Gender of the person as recorded by the site (male in every row seen). |
| info_weight_value | integer | Weight of the player in kilograms. |
| info_weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
| info_height_value | integer | Height of the player in centimetres. |
| info_height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
| info_team_uuid | character | Team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
| info_team_name | character | Name of the team. |
| info_team_code | character | Three-letter team code. |
| info_team_media | character | URL of the team logo image. |
| info_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
| info_team_site_display_name | character | Team name as the league site displays it. |
| info_team_id | integer | Genius team id (Genius key space; an integer here). |
| info_number | integer | Jersey (shirt) number of the player. |
| info_position | character | Position code (G, F, C, SG, SF ...). |
| w | integer | Wins. Team and standings modules: wins of the team in the ssgt. |
| p_avg | double | Points per game. |
| r_avg | double | Rebounds per game. |
| a_avg | double | Assists per game. |
| s_avg | double | Steals per game. |
| b_avg | double | Blocks per game. |
| f_avg | double | Fouls per game. |
| 2_p_perc | double | Two-point percentage, 0-100. |
| 3_p_perc | double | Three-point percentage, 0-100. |
| ft_perc | double | Free-throw percentage, 0-100. |
| info_name | character | Name of the team. |
| info_site_display_name | character | Team name as the league site displays it. |
| info_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
| date_time | character | Start time 'YYYY-MM-DD HH:MM:SS', LOCAL (Europe/Copenhagen) wall time with no zone. |
| home_team | character | Name of the home team. |
| away_team | character | Name of the away team. |
| venue | character | Name of the venue the game was played in. |
| attendance | integer | Attendance as an integer; present and non-null on all 706 rows of the six seasons sampled (2012/13-2026/27). |
| home_score | integer | Points scored by the home team (games_games; Int64 on the wire). |
| away_score | integer | Points scored by the away team (games_games; Int64 on the wire). |
| decided_in | character | How the game was decided: null after regulation, otherwise the extra period (OT = overtime). |
| info_game_id | integer | Genius match id of the row (Genius key space). |
| info_home_team_id | integer | Genius team id of the home team (Genius key space). |
| info_away_team_id | integer | Genius team id of the away team (Genius key space). |
| blk | integer | Blocks (total). |
| br | integer | Blocks received (shots of the player that were blocked), total (read from BLKR in the box score; unverified). |
| stl | integer | Steals (total). |
| plus | integer | Team points scored while the player was on court (total; unverified). |
| minus | integer | Opponent points scored while the player was on court (total; unverified). |
| fgm | integer | Field goals made (total). |
| fga | integer | Field goals attempted (total). |
| fg_perc | double | Field-goal percentage, 0-100. |
| fge_perc | double | Effective field-goal percentage ((FGM + 0.5 x 3PM) / FGA), 0-100. |
| 3_pm | integer | Three-pointers made (total). |
| 3_pa | integer | Three-pointers attempted (total). |
| 2_pm | integer | Two-pointers made (total). |
| 2_pa | integer | Two-pointers attempted (total). |
| pf | integer | Personal fouls (total). |
| tf | integer | Technical fouls (total). |
| of | integer | Offensive fouls (total). |
| f_on | double | Fouls on (fouls drawn), total. |
| uf | integer | Unsportsmanlike fouls (total). |
| f_outs | integer | Times fouled out. |
| o_rat | double | Offensive rating (points produced per 100 possessions, the site's formula; unverified). |
| tsa | integer | True-shooting attempts (FGA + 0.44 x FTA), total. |
| ts_perc | double | True-shooting percentage, 0-100. |
| a | integer | Assists (total). |
| atr | double | Assist-to-turnover ratio. |
| u_perc | double | Usage percentage, 0-100. |
| egs | double | Game score per game (unverified). |
| tp | integer | Total points scored. |
| fbp | integer | Fast-break points (total). |
| fbp_perc | double | Fast-break points as a percentage of the player's points (unverified). |
| pitp | integer | Points in the paint (total). |
| pitp_perc | double | Points in the paint as a percentage of the player's points (unverified). |
| 2nd_ch_p | integer | Second-chance points (total). |
| 2nd_ch_p_perc | double | Second-chance points as a percentage of the player's points (unverified). |
| plus_minus | integer | Plus/minus (team points minus opponent points while on court), total. |
| dr | double | Defensive rebounds (total). |
| or | integer | Offensive rebounds (total). |
| reb | integer | Total rebounds. |
| or_perc | double | Offensive rebound percentage; the denominator is the site's own (unverified). |
| dr_perc | double | Defensive rebound percentage; values far below ORPerc in the same row suggest a different base (unverified). |
| rank | integer | Unobserved: null in every sample and every full body. When filled: Always null on this table: the rows are sorted, not ranked. |
| l | integer | Losses. Standings module: losses of the team in the ssgt. |
| for | integer | Points scored by the team (points for). |
| ga | integer | Points conceded. |
| strk | character | Current streak: a positive number = wins in a row, '-n' = losses in a row. |
| gp_home | integer | Home games played. |
| att_total_overall | integer | Total attendance over all games (the site's own sum). |
| att_avg_overall | integer | Average attendance per game. |
| br_avg | double | Blocks received per game. |
| dr_avg | double | Defensive rebounds per game. |
| td | integer | Takeaways or turnovers forced (unverified). |
| td_avg | double | Per-game average of TD (unverified). |
| fgm_avg | double | Field goals made per game. |
| fga_avg | double | Field goals attempted per game. |
| fg_perc_avg | double | Field-goal percentage per game average (values near 0.1 in the rows seen; unverified). |
| 3_pa_avg | double | Three-pointers attempted per game. |
| 3_pm_avg | double | Three-pointers made per game. |
| 2_pm_avg | double | Two-pointers made per game. |
| 2_pa_avg | double | Two-pointers attempted per game. |
| fd | integer | Fouls drawn (0 in every row seen; unverified). |
| fd_avg | integer | Fouls drawn per game (unverified, as FD). |
| of_avg | double | Offensive fouls per game. |
| f_on_avg | double | Fouls on per game. |
| pf_avg | double | Personal fouls per game. |
| tf_avg | double | Technical fouls per game. |
| tfo | integer | Technical fouls on the opponent (unverified). |
| tfo_avg | integer | Per-game average of TFO (unverified). |
| uf_avg | double | Unsportsmanlike fouls per game. |
| fo | integer | Fouls-out count (unverified). |
| fo_avg | integer | Per-game average of FO (unverified). |
| fcd | integer | Coach disqualifying fouls (unverified). |
| fcd_avg | integer | Per-game average of FCD (unverified). |
| fct | integer | Coach technical fouls (read from the play-by-play foul subtype coachTechnical; unverified). |
| fct_avg | double | Coach technical fouls per game. |
| fbt | integer | Bench technical fouls (read from the play-by-play foul subtype benchTechnical; unverified). |
| fbt_avg | double | Bench technical fouls per game. |
| f | integer | Total personal fouls committed. |
| f_team | integer | Team fouls (unverified). |
| f_team_avg | double | Team fouls per game (unverified). |
| o_rat_avg | double | Offensive rating per game average. |
| ad | integer | Assists difference or assists allowed (0 in every row seen; unverified). |
| ad_avg | integer | Per-game average of AD (0 in every row seen; unverified). |
| ec | double | Unverified (in the hundreds, e.g. '509.0'; possibly an efficiency sum). |
| to | integer | Turnovers (total). |
| to_avg | double | Turnovers per game. |
| fbp_avg | double | Fast-break points per game. |
| fbpa | integer | Fast-break points attempts (unverified). |
| fbpm | integer | Fast-break points made (unverified). |
| pitp_avg | double | Points in the paint per game. |
| pitpa | integer | Paint shots attempted (unverified). |
| pitpa_avg | double | Paint shots attempted per game (unverified). |
| pitpm | integer | Paint shots made (unverified). |
| pitpm_avg | double | Paint shots made per game (unverified). |
| pfto | integer | Points from turnovers (total). |
| pfto_avg | double | Points from turnovers per game. |
| 2nd_ch_pm | integer | Second-chance field goals made (unverified). |
| 2nd_ch_pm_avg | double | Second-chance field goals made per game (unverified). |
| 2nd_ch_pa | integer | Second-chance field goals attempted (unverified). |
| 2nd_ch_pa_avg | double | Second-chance field goals attempted per game (unverified). |
| ftm | integer | Free throws made (total). |
| ftm_avg | double | Free throws made per game. |
| fta | integer | Free throws attempted (total). |
| fta_avg | double | Free throws attempted per game. |
| poss | integer | Possessions (total). |
| poss_avg | double | Possessions per game. |
| poss_o | integer | Offensive possessions (total; equal to Poss in every row seen). |
| poss_o_avg | double | Offensive possessions per game. |
| dppp | double | Defensive points per possession (unverified). |
| dppp_avg | double | Defensive points per possession, per game average (unverified). |
| oppp | double | Offensive points per possession. |
| oppp_avg | double | Offensive points per possession, per game average. |
| pace | integer | Pace (possessions per 40 minutes; 0 in every row seen, unverified). |
| pace_avg | integer | Pace, per game average (0 in every row seen). |
| tl | integer | Team leads / lead changes (unverified). |
| otr | integer | Offensive team rebounds (unverified). |
| dtr | integer | Defensive team rebounds (unverified). |
| tr | integer | Total team rebounds (unverified). |
| tr_avg | double | Team rebounds per game (unverified). |
| pr | integer | Player rebounds (total; Reb minus TR, unverified). |
| pr_avg | double | Player rebounds per game (unverified). |
| ord | integer | Offensive rebounds allowed or the opponent's offensive rebounds (0 in every row seen; unverified). |

## Details

- Unofficial: the JSON API behind www.basketligaen.dk, the Danish men's
  basketball league (Basketligaen, series code DBL). The site runs on
  the Sportality platform (the vendor behind the SHL and
  HockeyAllsvenskan wrappers). The terms page was not read; payloads are
  not redistributed as release assets.

- Stats provider: genius-basketball, a relay of Genius Sports LiveStats.
  The Genius match, team and person ids in play-by-play, box scores and
  stats tables (game_id, team_id, player_id, all Int64) join the genius
  family; the platform uuids (game, team, athlete, ssgt) are not Genius
  ids and exist only on this site. The Genius ORG code of Denmark is not
  exposed.

- Season = the END year (2026 = 2025/26) everywhere; the runtime maps
  it, with game_type ('regular' or 'finals', the playoffs), to the
  site's ssgt (season + series + game type) through layout-info.
  Schedules, standings and season tables start in 2002/03; game-level
  data (play-by-play with shot x/y, box scores, team stats) starts in
  2023/24.

- Source defects the runtime refuses (`hoopR_asset_fetch`): an
  unfinished game or a truncated play-by-play feed, a box score or feed
  that names another game, a cut stats table. The 2002/03 regular-season
  schedule lists 109 finished games where its own standings count 110: a
  source gap.

- Personal data is removed from every body: birth dates, e-mail
  addresses, phone numbers, addresses and contact blocks.

- No women's league: Dameligaen has its own domain (dameligaen.dk),
  which answers 401 to anonymous requests.

- Errors are classed conditions: `hoopR_no_data` (404, an empty gameday
  body, [`{}`](https://rdrr.io/r/base/Paren.html) / `[]`, a table with
  no rows, a season or game type layout-info does not list),
  `hoopR_bad_request` (a bad argument, a 400 / 422) and
  `hoopR_asset_fetch` (an error envelope or non-JSON 200, a body for
  another game / team / athlete / ssgt, an unfinished game or truncated
  play-by-play, a cut stats table, any other non-2xx; a 500 is the
  site's answer for an unknown uuid and is not retried), all inheriting
  `hoopR_error`. Wrappers raise; they never return an empty frame.

     sportality_stats_info(module = "players_summary", season = 2026)

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md),
[`sportality_roster()`](https://hoopR.sportsdataverse.org/reference/sportality_roster.md),
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)
