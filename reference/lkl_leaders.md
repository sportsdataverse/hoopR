# **LKL Leaders**

Leaders tab: each team's top players in points, rebounds, assists,
efficiency, steals and blocks.

Endpoint: `GET https://lkl.lt/api/livestream/leaders/{game_id}`

## Usage

``` r
lkl_leaders(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. One row per team, category and ranked player.
`category` is points, total_rebounds, assists, efficiency, steals or
blocks; `category_label` the site's Lithuanian label. `rank` 1 is the
category leader and 2 and up are the runners-up, in the order the site
lists them (up to 4 a side). `player_slug` is the site's key and
`player_id` is resolved through the game roster the runtime stamps (null
on a body without the stamp). A body without leaders gives a zero-row
tibble. Every column below is always present (a zero-row tibble keeps
them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| category | character | Leader category: points, total_rebounds, assists, efficiency, steals or blocks. |
| category_label | character | Category label in Lithuanian ('Pelnomi taskai' = points scored, 'Naudingumas' = efficiency rating). |
| team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
| team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
| rank | integer | Place in the team's category list: 1 = the category leader, 2 and up = the runners-up in the order the site lists them (up to 4). |
| player | character | Player name as the site prints it in this route (the box score short form 'I. Surname', other routes the full name). |
| player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
| player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
| value | integer | The player's count in the row's category. |

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

     lkl_leaders(game_id = 11446)

## See also

Other LKL:
[`lkl_game_info()`](https://hoopR.sportsdataverse.org/reference/lkl_game_info.md),
[`lkl_game_players()`](https://hoopR.sportsdataverse.org/reference/lkl_game_players.md),
[`lkl_game_score()`](https://hoopR.sportsdataverse.org/reference/lkl_game_score.md),
[`lkl_game_stats()`](https://hoopR.sportsdataverse.org/reference/lkl_game_stats.md),
[`lkl_lead_chart()`](https://hoopR.sportsdataverse.org/reference/lkl_lead_chart.md),
[`lkl_pbp()`](https://hoopR.sportsdataverse.org/reference/lkl_pbp.md),
[`lkl_period_scores()`](https://hoopR.sportsdataverse.org/reference/lkl_period_scores.md),
[`lkl_player_box()`](https://hoopR.sportsdataverse.org/reference/lkl_player_box.md),
[`lkl_results()`](https://hoopR.sportsdataverse.org/reference/lkl_results.md),
[`lkl_shots()`](https://hoopR.sportsdataverse.org/reference/lkl_shots.md),
[`lkl_standings()`](https://hoopR.sportsdataverse.org/reference/lkl_standings.md),
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)
