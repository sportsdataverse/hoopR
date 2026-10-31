# **LKL Team Box**

Team game totals of both teams: shooting, rebounds, assists, turnovers,
fouls, paint, bench and fast-break points.

Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`

## Usage

``` r
lkl_team_box(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. Two rows (home first). The body keys the totals
by team id with no side marker, so `team_side` comes from the game page
the runtime stamps (null on a body without the stamp). Percentages are
0-100 floats (the site sends two-decimal strings); `time_leading` is
seconds (the site sends a string). `points_off_turnovers`,
`fast_break_points`, `second_chance_points` and `points_in_paint` are 0
before 2024-25 (not tracked). Per-period points are in
`lkl_period_scores`. A body without `gameStatistics` gives a zero-row
tibble. Every column below is always present (a zero-row tibble keeps
them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
| team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
| points | integer | Team points: the final score (the capture banks finished games only). |
| seconds_played | integer | Summed playing time of all the team's players in seconds (12000 = 5 x 40:00; 13500 with one overtime). |
| field_goals_made_total | integer | Field goals made, 2PT + 3PT. |
| field_goals_attempted_total | integer | Field goals attempted, 2PT + 3PT. |
| field_goals_made_2pt | integer | Two-point field goals made. |
| field_goals_attempted_2pt | integer | Two-point field goals attempted. |
| field_goals_made_3pt | integer | Three-point field goals made. |
| field_goals_attempted_3pt | integer | Three-point field goals attempted. |
| free_throws_made | integer | Free throws made by the team in the game (count). |
| free_throws_attempted | integer | Free throws attempted by the team in the game (count). |
| offensive_rebounds | integer | Team offensive rebounds in the game (count). |
| defensive_rebounds | integer | Team defensive rebounds in the game (count). |
| total_rebounds | integer | Team rebounds, offensive + defensive (count). |
| assists | integer | Team assists in the game (count). |
| steals | integer | Team steals in the game (count). |
| blocks | integer | Blocks made by the team in the game (count). |
| blocks_received | integer | Shots of this team that were blocked. |
| turnovers | integer | Team turnovers in the game (count). |
| fouls | integer | Fouls committed. |
| fouls_on | integer | Fouls drawn (fouls committed on this team). |
| efficiency | integer | Team efficiency rating (Efektyvumas), a PIR-style index (points + rebounds + assists + steals + blocks + fouls drawn - missed shots - turnovers - shots blocked - fouls). The exact formula is unverified: game 11590 home gives 121 where that formula gives 122. |
| points_off_turnovers | integer | Points off the opponent's turnovers; 0 on the 2007-08 sample (not tracked then). |
| fast_break_points | integer | Fast-break points; 0 on the 2007-08 sample. |
| second_chance_points | integer | Second-chance points (after an offensive rebound); 0 on the 2007-08 sample. |
| points_in_paint | integer | Points in the paint; 0 on the 2007-08 sample. |
| bench_points | integer | Points by players who did not start. |
| biggest_lead | integer | This team's biggest lead in points (0 when it never led). |
| biggest_scoring_run | integer | This team's longest unanswered scoring run, in points. |
| lead_changes | integer | Lead changes in the game (the same value on both rows). |
| tie_results | integer | Times the score was tied (the same value on both rows). |
| time_leading | integer | Seconds this team led during the game (the site sends it as a string; 1892 = 31:32). |
| field_goals_percentage | double | Field-goal percentage, 0-100 float (the site sends a two-decimal string). |
| field_goals_2pt_percentage | double | Two-point percentage, 0-100 float (the site sends a two-decimal string). |
| field_goals_3pt_percentage | double | Three-point percentage, 0-100 float (the site sends a two-decimal string). |
| free_throws_percentage | double | Free-throw percentage, 0-100 float (the site sends a two-decimal string). |

## Details

Unofficial and unsupported: these are the routes lkl.lt's own game page
calls (found in its front-end bundle) and its server-rendered pages. The
site's robots.txt allows everything and sets no crawl-delay; the runtime
still spaces requests at least 1 s apart. The site's terms were not
reviewed; check them before you republish the data.

Coverage: game wrappers serve FINISHED games only (an unfinished game
raises `hoopR_asset_fetch`). The box score, summary, score line,
statistics and leaders answer for every season from 1993-94 (before
2024-25 the scoring splits and lead statistics are 0). Play-by-play and
shots exist from 2024-25 only; an earlier finished game raises
`hoopR_no_data`. From 2016-17 the results season id is also the Genius
LiveStats competition id (see the `genius` family) which holds
play-by-play for older games; lkl.lt game, team and player ids are
lkl.lt's own and do not join Genius ids. The King Mindaugas Cup shares
the routes but is not wrapped. Text fields are Lithuanian.

Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP
404, an unknown game or standings season, a season the site's selects do
not list, a season without played games, a finished game before 2024-25
asked for play-by-play or shots); `hoopR_bad_request` for a game id or
season that is not an integer, or HTTP 400 / 422; `hoopR_asset_fetch`
when the fetch failed or the answer is not the one asked for (an
unfinished game, a body or page for another game or season, an error or
changed body, a truncated results list). All inherit `hoopR_error`.
Dates and times are Lithuanian local (Europe/Vilnius) as the site prints
them.

## See also

Other LKL Functions:
[`lkl_game_info()`](https://hoopR.sportsdataverse.org/reference/lkl_game_info.md),
[`lkl_game_players()`](https://hoopR.sportsdataverse.org/reference/lkl_game_players.md),
[`lkl_game_score()`](https://hoopR.sportsdataverse.org/reference/lkl_game_score.md),
[`lkl_game_stats()`](https://hoopR.sportsdataverse.org/reference/lkl_game_stats.md),
[`lkl_lead_chart()`](https://hoopR.sportsdataverse.org/reference/lkl_lead_chart.md),
[`lkl_leaders()`](https://hoopR.sportsdataverse.org/reference/lkl_leaders.md),
[`lkl_pbp()`](https://hoopR.sportsdataverse.org/reference/lkl_pbp.md),
[`lkl_period_scores()`](https://hoopR.sportsdataverse.org/reference/lkl_period_scores.md),
[`lkl_player_box()`](https://hoopR.sportsdataverse.org/reference/lkl_player_box.md),
[`lkl_results()`](https://hoopR.sportsdataverse.org/reference/lkl_results.md),
[`lkl_shots()`](https://hoopR.sportsdataverse.org/reference/lkl_shots.md),
[`lkl_standings()`](https://hoopR.sportsdataverse.org/reference/lkl_standings.md),
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md)

## Examples

``` r
# \donttest{
  try(lkl_team_box(game_id = 11446))
#> Error in lkl_team_box(game_id = 11446) : 
#>   lkl.lt/rungtynes/11446 answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
