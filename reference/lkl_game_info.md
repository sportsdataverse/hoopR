# **LKL Game Info**

Game header from the game page: status, tip-off, venue, attendance,
officials and both teams.

Endpoint: `GET https://lkl.lt/rungtynes/{game_id}`

## Usage

``` r
lkl_game_info(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. One row. `start_date` / `start_time` are the
Lithuanian local date and `HH:MM` (the page carries no offset; the zone
is Europe/Vilnius by the site's own wording). `referees` is the page's
name list as one string. `coach` / `assistant_coach` are the team's
CURRENT staff on an old game; team name and slug are historical. The
page carries no officials' contact or birth data; any such key would be
dropped by the runtime. Videos, logos and the UI config props are
dropped. An empty or unrecognised input gives a zero-row tibble with the
documented columns. Every column below is always present (a zero-row
tibble keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| game_status | character | Game state label in Lithuanian: 'Pasibaige' = finished, the only value served (the runtime refuses an unfinished game). |
| start_date | Date | Game date (Europe/Vilnius), parsed from the page header 'YYYY m. `<month>` D d., HH:MM'. |
| start_time | character | Tip-off 'HH:MM' local time (Europe/Vilnius by the site's wording; the page carries no offset). |
| arena | character | Arena name as printed on the game page header. |
| attendance | character | Attendance text as printed ('1097 ziurovai' = 1097 spectators). |
| attendance_count | integer | Attendance as an integer, parsed from the attendance text; null when the page has none. |
| referees | character | Referee names, comma-separated, crew chief first; 'Nepaskelbta' = not announced (old games). Names only: the site publishes no official's contact or birth data. |
| has_actions | logical | True when the game has play-by-play events (2024-25 onward); false on older games. |
| is_streaming | logical | True while a live stream is on; false on finished games. |
| home_team_id | integer | Home team id (key space: lkl.lt clubs, stable across seasons and renamings; joins the team_id of every other frame). Not the Genius team id. |
| home_team | character | Home team name as of that game (historical: 'Lietuvos Rytas' in 2007-08). |
| home_short_name | character | Home three-letter team code ('RYT'); can be the club's current code on old games. |
| home_slug | character | Home team slug (key space: lkl.lt clubs; the `{slug}` of lkl.lt/komandos/`{slug}`); joins the team slugs of lkl_results and lkl_standings. |
| home_winner | logical | True when the home team won the game. |
| home_coach | character | Home head coach's full name as stored for the team: on old games the CURRENT coach, not the historical one. |
| home_assistant_coach | character | Home assistant coach's full name (same caveat as the head coach: current staff on old games). |
| away_team_id | integer | Away team id (key space: lkl.lt clubs, stable across seasons and renamings; joins the team_id of every other frame). Not the Genius team id. |
| away_team | character | Away team name as of that game (historical: 'Lietuvos Rytas' in 2007-08). |
| away_short_name | character | Away three-letter team code ('RYT'); can be the club's current code on old games. |
| away_slug | character | Away team slug (key space: lkl.lt clubs; the `{slug}` of lkl.lt/komandos/`{slug}`); joins the team slugs of lkl_results and lkl_standings. |
| away_winner | logical | True when the away team won the game. |
| away_coach | character | Away head coach's full name as stored for the team: on old games the CURRENT coach, not the historical one. |
| away_assistant_coach | character | Away assistant coach's full name (same caveat as the head coach: current staff on old games). |

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
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)

## Examples

``` r
# \donttest{
  try(lkl_game_info(game_id = 11446))
#> Error in lkl_game_info(game_id = 11446) : 
#>   lkl.lt/rungtynes/11446 answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
