# **LKL Results**

Every played game of one LKL season (all pages of the site's results
list, merged), newest first.

Endpoint: `GET https://lkl.lt/loadResults`

## Usage

``` r
lkl_results(season)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season). The site keys a
  season by two opaque ids (a results id and a standings id, neither a
  year); the runtime reads them from the site's season selects by the
  label `YYYY-YYYY m. sezonas`. A year the selects do not list raises
  `hoopR_no_data`.

## Value

A `hoopR_data` tibble. One row per played game, in the site's order
(newest first). `season_end_year` is the END year of the season (2026 =
2025-26) and `season_id` the site's opaque results-season id (from
2016-17 it is the Genius LiveStats competition id). Teams are given by
slug, code and name only (no team id); map a slug to `team_id` with
`lkl_game_info`. `time` is the Lithuanian local tip-off `HH:MM`.
`winner_highlighted` is the side whose score the page shows in bold.
Played games only; the unplayed schedule is not wrapped. A record
without games gives a zero-row tibble. Every column below is always
present (a zero-row tibble keeps them and their types); an answer with
nothing in it raises `hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season_id | integer | Results season id (key space: lkl.lt championships; LKL 2026-27 = 49436). From 2016-17 it is the Genius LiveStats competition id (leagueId 110). |
| season_end_year | integer | Season END year (2026 = 2025-26), read from the season label 'YYYY-YYYY m. sezonas'. |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| date | Date | Game date from the site's Lithuanian day header; checked to fall in the season (Aug 1 - Jul 31). |
| weekday | character | Weekday of the header, translated to English ('sestadienis' -\> 'Saturday'). |
| time | character | Tip-off 'HH:MM', Europe/Vilnius. |
| arena | character | Arena name ('Arena dar nezinoma' = arena not yet known, on some 2007-08 games). |
| city | character | City, from 'Arena , City'; null when the venue line has no city (2007-08 'Arena dar nezinoma'). |
| home_slug | character | Home team: Team slug (key space: lkl.lt clubs; the `{slug}` of https://lkl.lt/komandos/`{slug}`; one per club, stable across renamings: 'rytas' for Lietuvos Rytas / Rytas). The results and standings rows carry only this; the game page teams_info gives slug + id. |
| home_code | character | Home three-letter team code ('LIE'). |
| home_name | character | Home team name as printed (the logo alt text; the CURRENT club name even on old games: 2007-08 'Rytas'). |
| home_score | integer | Home team points in the game (the final score). |
| away_slug | character | Away team: Team slug (key space: lkl.lt clubs; the `{slug}` of https://lkl.lt/komandos/`{slug}`; one per club, stable across renamings: 'rytas' for Lietuvos Rytas / Rytas). The results and standings rows carry only this; the game page teams_info gives slug + id. |
| away_code | character | Away three-letter team code. |
| away_name | character | Away team name as printed. |
| away_score | integer | Away team points in the game (the final score). |
| winner_highlighted | character | Which side's score the page sets in bold: home or away (the winner). |

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
[`lkl_player_box()`](https://hoopR.sportsdataverse.org/reference/lkl_player_box.md),
[`lkl_shots()`](https://hoopR.sportsdataverse.org/reference/lkl_shots.md),
[`lkl_standings()`](https://hoopR.sportsdataverse.org/reference/lkl_standings.md),
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)

## Examples

``` r
# \donttest{
  try(lkl_results(season = 2026))
#> Error in lkl_results(season = 2026) : 
#>   lkl.lt/rezultatai answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
