# **LKL Standings**

League table of one LKL season: overall, home and away records, and the
final ranking once it is set.

Endpoint: `GET https://lkl.lt/loadStandings/{season}`

## Usage

``` r
lkl_standings(season)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season). The site keys a
  season by two opaque ids (a results id and a standings id, neither a
  year); the runtime reads them from the site's season selects by the
  label `YYYY-YYYY m. sezonas`. A year the selects do not list raises
  `hoopR_no_data`.

## Value

A `hoopR_data` tibble. One row per team and table. `table` is `full`
(overall: with `win_pct` and `streak`), `home` and `away` (the same
record split by venue) or `final` (the final ranking: position and team
only, empty until the season is over and for old seasons). `win_pct` is
0-100, null when the site shows `-` (2007-08). `streak` is a signed
integer as the site prints it; its sign convention is unverified.
`points_for_avg` / `points_against_avg` are per-game averages. `last5`
is the last results as `W` / `L` letters in the order rendered (oldest
first, unverified). `season_id` is the site's standings-season id, a
different key space from the results id. Team slugs join `lkl_results`.
A record without tables gives a zero-row tibble. Every column below is
always present (a zero-row tibble keeps them and their types); an answer
with nothing in it raises `hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season_id | integer | STANDINGS season id (a separate small key space: 35 = 2026-27, 1 = 2016-17, 24 = 1993-94); NOT the results season id. |
| season_end_year | integer | Season END year (2026 = 2025-26), read from the season label 'YYYY-YYYY m. sezonas'. |
| table | character | Which table the row comes from: full (overall), home, away or final (the final ranking). |
| position | integer | Rank in the table (Poz.); in the final table the final place. |
| team_slug | character | Team slug (key space: lkl.lt clubs; the `{slug}` of https://lkl.lt/komandos/`{slug}`; one per club, stable across renamings: 'rytas' for Lietuvos Rytas / Rytas). The results and standings rows carry only this; the game page teams_info gives slug + id. |
| team_name | character | Team name as printed for that season ('Lietuvos Rytas' in 2007-08). |
| played | integer | Games played (Rng., rungtynes); null in the final table. |
| won | integer | Wins (Per., pergales); null in the final table. |
| lost | integer | Losses (Pr., pralaimejimai); null in the final table. |
| win_pct | double | Win percentage 0-100 (Laim.%); null in the home, away and final tables and when the site prints '-' (2007-08). |
| streak | integer | Current streak (Serija) as a signed integer: 27 = 27 wins in a row, -1 = one loss. Null outside the full table. |
| points_for_avg | double | Points scored per game (first number of Tsk. vid.); null in the final table. |
| points_against_avg | double | Points allowed per game (second number of Tsk. vid.); null in the final table. |
| last5 | character | Last five results (Paskutines 5) as W / L letters in the order the page renders them, left to right; fewer than five early in a season; null in the final table. |

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
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)

## Examples

``` r
# \donttest{
  try(lkl_standings(season = 2026))
#> Error in lkl_standings(season = 2026) : 
#>   lkl.lt/turnyrine-lentele answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
