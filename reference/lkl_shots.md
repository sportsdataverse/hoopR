# **LKL Shots**

Every field-goal attempt of a finished game (2024-25 onward) with its
court position (Genius LiveStats data).

Endpoint: `GET https://lkl.lt/api/livestream/shot-chart/{game_id}`

## Usage

``` r
lkl_shots(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. One row per attempt (free throws are not
charted), periods ascending. The data is Genius LiveStats'. `x` is the
percent (0-100) of the court LENGTH from the left baseline of a
horizontal full court (baskets near 5 and 95) and `y` the percent of the
WIDTH (baskets at 50); metres are `x / 100 x 28` and `y / 100 x 15`, an
inference. Which sideline is `y` 0 is unverified. `side` is the basket
half (`LEFT` = x \< 50) except backcourt heaves, and teams switch
baskets at half-time, so normalise to one basket before plotting. `area`
is a zone code, `left` / `right` from the shooter's view. The shooter is
named by `player_id` (lkl.lt persons); `player_slug` is the reverse
lookup through the runtime's roster (null on a body without the stamp).
The site charts shots from 2024-25 on. A body without shots gives a
zero-row tibble. Every column below is always present (a zero-row tibble
keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| shot_id | integer | Shot event id (key space: lkl.lt shot events, increasing over time); joins nothing else and is not the Genius action number. |
| period | integer | Period number: 1-4 regulation, 5 the first overtime, 6 the second. |
| period_type | character | regular for periods 1-4, overtime from period 5. |
| team_side | character | Side of the shooter's team (the line's is_home flag): home or away. |
| team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
| player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
| player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
| type | character | 2pt or 3pt (free throws are not in the chart). |
| made | logical | True when the shot was made, false when missed. |
| x | double | Court x position: percent (0-100) of the LENGTH of a horizontal full court from the left baseline (baskets near 5 and 95). Teams switch baskets at half-time; metres (x / 100 x 28) are an inference. |
| y | double | Court y position: percent (0-100) of the court WIDTH (baskets at 50). Metres (y / 100 x 15) are an inference; which sideline is y = 0 is unverified. |
| side | character | Basket half the shot is at: LEFT (x \< 50) or RIGHT, except backcourt heaves (area backcourt). |
| area | character | Court zone code (e.g. inthepaint, underbasket, outsideleft); left and right are from the shooter's view, so zones are point-symmetric between the two baskets. |

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
[`lkl_results()`](https://hoopR.sportsdataverse.org/reference/lkl_results.md),
[`lkl_standings()`](https://hoopR.sportsdataverse.org/reference/lkl_standings.md),
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)

## Examples

``` r
# \donttest{
  try(lkl_shots(game_id = 11446))
#> Error in lkl_shots(game_id = 11446) : 
#>   lkl.lt/rungtynes/11446 answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
