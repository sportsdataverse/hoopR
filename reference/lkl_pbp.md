# **LKL Play-by-Play**

Play-by-play of a finished game (2024-25 onward), oldest first, with the
running score and the lkl.lt player id.

Endpoint: `GET https://lkl.lt/api/livestream/play-by-play/{game_id}`

## Usage

``` r
lkl_pbp(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. One row per play, chronological (the site lists
them newest first, per period). `event_num` is a 1-based sequence the
parser assigns. `period` of a regulation line is its quarter; the site
gives overtime lines as one merged list without a period, so the parser
DERIVES the overtime number (the oldest overtime is 5; each `period` /
`end` line closes one): checked on a one-overtime game only, so a
multi-overtime game's numbering is unverified. `clock` is the time
REMAINING (`mm:ss`) and `clock_seconds` the same in seconds. `type` /
`subtype` are English codes, `description` the site's Lithuanian phrase.
`score_home` / `score_away` are the running score AFTER the play on
every line. Team, period and game lines have no player. `player_id` is
resolved through the game roster the runtime stamps. The site charts
play-by-play from 2024-25 on. A body without plays gives a zero-row
tibble. Every column below is always present (a zero-row tibble keeps
them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| event_num | integer | Play sequence number the parser assigns, 1 = the first play of the game (the site lists plays newest first per period, with no id). |
| period | integer | Period of the play. Regulation lines carry it in the site's body; overtime lines come as one merged list without it, so the parser derives it (oldest overtime = 5, each period-end line closes one): checked on a one-overtime game only, so multi-overtime numbering is unverified. |
| period_type | character | regular for periods 1-4, overtime from period 5. |
| clock | character | Game clock REMAINING in the period as 'mm:ss' (it counts down from 10:00, from 05:00 in overtime). |
| clock_seconds | integer | The clock REMAINING as whole seconds (08:34 = 514), derived by the parser. |
| team_side | character | Side of the acting team (the line's is_home flag): home or away. |
| team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
| player | character | Player name as the site prints it in this route (the box score short form 'I. Surname', other routes the full name). |
| player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
| player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
| type | character | Event type (English code): 2pt, 3pt, freethrow, rebound, assist, steal, block, turnover, foul, foulon (foul drawn), substitution, timeout, jumpball, headcoachchallenge, period, game. |
| subtype | character | Event subtype (English code; ” when none). 2pt/3pt: shot kind (jumpshot, layup, drivinglayup, reverselayup, dunk, alleyoop, alleyoopdunk, tipinlayup, tipindunk, hookshot, fadeaway, floatingjumpshot, pullupjumpshot, stepbackjumpshot, turnaroundjumpshot, eurostep). freethrow: 'NofM' = attempt N of M (1of1, 1of2, 2of2, 1of3, 2of3, 3of3). rebound: offensive / defensive. foul: personal, offensive, technical, benchTechnical. turnover: badpass, ballhandling, offensive, outofbounds, travel, backcourt (backcourt violation), 3sec, 24sec. substitution: in / out. timeout: full (team), officials. jumpball: startperiod, won, lost, heldball. headcoachchallenge: the challenged call (foul, outofbounds). period / game: start, end. |
| description | character | Event text in Lithuanian, one fixed phrase per type and subtype ('3 tasku metimas pataikytas' = 3-point shot made). |
| success | logical | Shots and free throws: true = made. Every other type: always true. |
| is_points_info | logical | True on lines that changed the score (made shots and free throws). |
| score_home | integer | Home points after the play (on every line, not only scoring lines). |
| score_away | integer | Away points after the play (on every line, not only scoring lines). |

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
  try(lkl_pbp(game_id = 11446))
#> Error in lkl_pbp(game_id = 11446) : 
#>   lkl.lt/rungtynes/11446 answered HTTP 403: <!DOCTYPE html><html
#> lang="en-US"><head><title>Just a moment...</title><meta
#> http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta
#> http-equiv="X-UA-Compatible" content="IE=Edge"><meta nam
# }
```
