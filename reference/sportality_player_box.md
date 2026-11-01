# **Get Basketligaen Player Box Score**

Box score with jersey and Genius shirt numbers (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/player-stats/{game_uuid}`

## Usage

``` r
sportality_player_box(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble: Box score with jersey and Genius shirt numbers
(2023/24 on). An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_player_box`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_side | character | home or away: the side the row belongs to. |
| row_type | character | Kind of row: player, team_coach (the bench row: team rebounds, turnovers and fouls charged to the team or coach) or team_totals. |
| player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
| team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
| team_name | character | Name of the team. |
| period | integer | Period of the line: 0 = the whole game (the only value seen). |
| full_name | character | Full display name of the player. |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| nr | integer | Jersey number (null on the bench and totals rows). |
| pos | character | Position code of the line (G, F, C; null on the bench and totals rows). |
| mins | character | Minutes played as 'MM:SS' (null on the bench and totals rows). |
| pts | integer | Number of points scored. |
| fg | character | Field goals as 'made-attempted'. |
| fg_perc | double | Field-goal percentage, 0-100. |
| 2_p | character | Two-pointers as 'made-attempted'. |
| 2_p_perc | double | Two-point percentage, 0-100. |
| 3_p | character | Three-pointers as 'made-attempted'. |
| 3_p_perc | double | Three-point percentage, 0-100. |
| ft | character | Free throws as 'made-attempted'. |
| ft_perc | double | Free-throw percentage, 0-100. |
| off | integer | Offensive rebounds. |
| def | integer | Defensive rebounds. |
| reb | integer | Total rebounds. |
| ast | integer | Number of assists credited. |
| to | integer | Number of turnovers committed. |
| stl | integer | Number of steals. |
| blk | integer | Number of blocked shots made. |
| blkr | integer | Blocks received (shots of the player that were blocked). |
| pf | integer | Personal fouls. |
| f_on | integer | Fouls on (fouls drawn). |
| plus_minus | integer | Plus/minus while on court. |
| team_number | integer | Team number in the game (1 home, 2 away) as Genius numbers the shirt table. |
| pno | integer | Genius shirt-table number of the player (player-stats only). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

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
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_player_box(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Player Box Score from basketligaen.dk ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:51:02 UTC
#> # A tibble: 28 × 34
#>    team_side row_type player_id team_id team_name    period full_name first_name
#>    <chr>     <chr>        <int>   <int> <chr>         <int> <chr>     <chr>     
#>  1 home      player     1887576      NA Holbæk-Sten…      0 Oskar Fl… Oskar Flø…
#>  2 home      player     2777479      NA Holbæk-Sten…      0 Bryceson… Bryceson  
#>  3 home      player     2404639      NA Holbæk-Sten…      0 Anders J… Anders    
#>  4 home      player     2779432      NA Holbæk-Sten…      0 Sebastia… Sebastian 
#>  5 home      player     2777481      NA Holbæk-Sten…      0 Otto Jer… Otto      
#>  6 home      player     1951861      NA Holbæk-Sten…      0 August H… August    
#>  7 home      player     2495922      NA Holbæk-Sten…      0 Karl Hem… Karl      
#>  8 home      player     2380378      NA Holbæk-Sten…      0 Julius A… Julius    
#>  9 home      player     2385172      NA Holbæk-Sten…      0 Malthe A… Malthe    
#> 10 home      player     2778538      NA Holbæk-Sten…      0 Caden Fry Caden     
#> # ℹ 18 more rows
#> # ℹ 26 more variables: last_name <chr>, nr <int>, pos <chr>, mins <chr>,
#> #   pts <int>, fg <chr>, fg_perc <dbl>, `2_p` <chr>, `2_p_perc` <dbl>,
#> #   `3_p` <chr>, `3_p_perc` <dbl>, ft <chr>, ft_perc <dbl>, off <int>,
#> #   def <int>, reb <int>, ast <int>, to <int>, stl <int>, blk <int>,
#> #   blkr <int>, pf <int>, f_on <int>, plus_minus <int>, team_number <int>,
#> #   pno <int>
# }
```
