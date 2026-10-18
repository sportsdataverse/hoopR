# **LKL Player Box**

Per-player box score of a finished game: minutes, points, shooting
splits, rebounds, assists and plus/minus.

Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`

## Usage

``` r
lkl_player_box(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. One row per player on the team sheet (9-17 a
side), starters first as the site lists them. Every box cell is
unwrapped from its `{value[, percentage]}` object; shooting cells
`"made/attempted"` become `*_made` / `*_attempted` integers and the
one-decimal percentage string a 0-100 float. `player` is the short name
`I. Surname`; `player_slug` is the key the site uses, and `player_id` is
resolved through the game roster the runtime stamps (null on a body
without the stamp). `seconds_played` is the `mm:ss` minutes in seconds.
Team total rows are in `lkl_team_box`. A body without players gives a
zero-row tibble. Every column below is always present (a zero-row tibble
keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
| team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
| player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
| player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
| player | character | Player name as the site prints it in this route (the box score short form 'I. Surname', other routes the full name). |
| jersey | character | Cell: Shirt number, a STRING ('77'); page column \# (Marskineliu numeris). |
| is_starter | logical | True for the five starters. |
| is_captain | logical | True for the team captain. |
| is_active | logical | False in every sample, finished games included; by name the player is on court right now (live games), unverified. |
| seconds_played | integer | Time on court in seconds (the page's 'mm:ss' minutes: 32:54 = 1974). |
| points | integer | Cell: Points (TSK, Taskai). |
| fg_made | integer | Field goals made, 2PT + 3PT (the 'made' half of the 'made/attempted' cell). |
| fg_attempted | integer | Field goals attempted, 2PT + 3PT. |
| fg_pct | double | Field-goal percentage, 0-100 (the site's one-decimal string; 0 when there were no attempts). |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| fg2_pct | double | Two-point percentage, 0-100 (one-decimal string on the site; 0 when there were no attempts). |
| fg3_made | integer | Three-point field goals made. |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg3_pct | double | Three-point percentage, 0-100 (one-decimal string on the site; 0 when there were no attempts). |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| ft_pct | double | Free-throw percentage, 0-100 (one-decimal string on the site; 0 when there were no attempts). |
| total_rebounds | integer | Cell: Total rebounds (AK, Atkovoti kamuoliai). |
| offensive_rebounds | integer | Cell: Offensive rebounds (AKP, Atkovoti kamuoliai puolime). |
| defensive_rebounds | integer | Cell: Defensive rebounds (AKG, Atkovoti kamuoliai gynyboje). |
| assists | integer | Cell: Assists (RP, Rezultatyvus perdavimai). |
| steals | integer | Cell: Steals (PK, Perimti kamuoliai). |
| turnovers | integer | Cell: Turnovers (KL, Klaidos). |
| blocks | integer | Cell: Blocks made (BL, Blokai). |
| blocks_received | integer | Cell: Shots of this player/team that were blocked (GB, Gauti blokai). |
| fouls | integer | Cell: Personal fouls committed (AP, Asmenines prazangos). |
| fouls_on | integer | Cell: Fouls drawn (IP, Isprovokuotos prazangos). |
| plus_minus | integer | Cell: Plus/minus while on court (+/- rodiklis). |
| efficiency | integer | Cell: Efficiency rating (EF, Efektyvumas; see gameStatistics efficiency). |

## Details

Unofficial and unsupported: these are the routes lkl.lt's own game page
calls (found in its front-end bundle) and its server-rendered pages. The
site's robots.txt allows everything and sets no crawl-delay; the runtime
still spaces requests at least 1 s apart. SportsDataverse has not ruled
on the site's terms, so payloads are not redistributed as release
assets.

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

Other LKL:
[`lkl_game_info()`](https://hoopR.sportsdataverse.org/reference/lkl_game_info.md),
[`lkl_game_players()`](https://hoopR.sportsdataverse.org/reference/lkl_game_players.md),
[`lkl_game_score()`](https://hoopR.sportsdataverse.org/reference/lkl_game_score.md),
[`lkl_game_stats()`](https://hoopR.sportsdataverse.org/reference/lkl_game_stats.md),
[`lkl_lead_chart()`](https://hoopR.sportsdataverse.org/reference/lkl_lead_chart.md),
[`lkl_leaders()`](https://hoopR.sportsdataverse.org/reference/lkl_leaders.md),
[`lkl_pbp()`](https://hoopR.sportsdataverse.org/reference/lkl_pbp.md),
[`lkl_period_scores()`](https://hoopR.sportsdataverse.org/reference/lkl_period_scores.md),
[`lkl_results()`](https://hoopR.sportsdataverse.org/reference/lkl_results.md),
[`lkl_shots()`](https://hoopR.sportsdataverse.org/reference/lkl_shots.md),
[`lkl_standings()`](https://hoopR.sportsdataverse.org/reference/lkl_standings.md),
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)

## Examples

``` r
# \donttest{
  try(lkl_player_box(game_id = 11446))
#> Error in lkl_player_box(game_id = 11446) : 
#>   lkl.lt/rungtynes/11446 answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
