# **Get LBA Play-by-Play**

Play-by-play of a final game (2017-18 on), one row per action with x/y;
coordinate frame by era.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play`
(`info=true&sort=asc&id=<game_id>`)

## Usage

``` r
lba_pbp(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble: Play-by-play of a final game (2017-18 on), one
row per action with x/y; coordinate frame by era. The columns are always
these, in this order (sdv-py `lba_pbp`); a column the site adds later is
appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| home_team_id | integer | Home team-season id of the game (the play-by-play ht_id). |
| visitor_team_id | integer | Visitor team-season id of the game (the play-by-play vt_id). |
| team_side | character | Side of the acting team, home or visitor; null for a clock action without a team. |
| home_score | integer | Home points after the action, parsed from the score text (2021-22 on; else null). |
| visitor_score | integer | Visitor points after the action, parsed from the score text (2021-22 on; else null). |
| coord_frame | character | Frame of x and y: half_court_px (2017-18 and 2018-19 image pixels) or court_pct (2019-20 on, 0-100). |
| action_id | integer | Action id within the game (ascending in time from 2021-22; not ordered before). |
| description | character | Action type in Italian, e.g. `2 punti segnato` (2-pointer made); full translation table in the Divergence notes. |
| player_id | integer | Player id (null for team and clock actions). |
| team_id | integer | Team id (team-season) of the actor. |
| home_club | integer | 1 = the home team acted, 0 = the away team; null for clock actions, and on every action in 2018-19 and 2019-20 (use `side` there). |
| in_area | logical | True on shots from the paint (zone `3`). |
| dunk | integer | 1 = dunk, 0 otherwise. |
| seconds | integer | Elapsed seconds within `minute` (0-59); 0 before 2019-20. Elapsed = minute x 60 + seconds; `print_time` = period length minus that. |
| minute | integer | Elapsed minute of the period (2019-20 on: 0-9, with `seconds`); 2017-18 / 2018-19: 1-10, the minute in progress, `seconds` 0. |
| period | integer | Period: 1-4, 5+ = overtime. |
| order | integer | Sort key; `sort=asc` orders by it. |
| side | integer | Basket the row's side_area_zone is measured from, as sent: 0 = the basket at x = 0, 1 = the one at x = 100 (zone A is that basket's half: x \< 50 for 0, x \>= 50 for 1). It is NOT the team of the game (that is team_side): on shots, assists, fouls committed, turnovers and offensive rebounds it is the actor's attacking basket, which changes at half-time; on defensive rebounds, steals, blocks and fouls drawn it is the opponent's. |
| x | integer | Court x; frame by era (see the coordinates section): 2019-20 on, 0-100 % of the 28 m length; 2017-18 / 2018-19, half-court image pixels; null (2019-20 on) or 0 (earlier) when unlocated. |
| y | integer | Court y; 2019-20 on, 0-100 % of the 15 m width; 2017-18 / 2018-19, image pixels (see the coordinates section). |
| score | character | Score after the action, `home - away` string (`0 - 0`); 2020-21 on scoring actions only, null before. |
| linked_action_id | integer | `action_id` of the related action: the shot an assist or rebound belongs to, the foul a drawn foul answers, the player swapped in a substitution. |
| print_time | character | Game clock remaining, `MM:SS` (10:00 at a period start); null before 2021-22. |
| action_1_qualifier_code | character | First qualifier code, number sent as a string (shot type, turnover type, foul type; see `legend`). |
| action_2_qualifier_code | character | Second qualifier code (fast break `500`, blocked `1005`, tip-ins `1001`-`1004`, ...). |
| action_1_qualifier_description | character | `legend` label of `action_1_qualifier_code`, Italian. |
| action_2_qualifier_description | character | `legend` label of `action_2_qualifier_code`, Italian. |
| side_area_zone | character | `A` = in the actor's attacking half, `D` = its defensive half (2021-22 on). |
| side_area_code | character | Court zone `1`-`10`, number sent as a string (see the coordinates section; 2021-22 on). |
| player_name | character | Given name of the acting player. |
| player_surname | character | Family name of the acting player. |
| player_number | character | Jersey number, number sent as a string. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| id | integer | Always null (not a key). |

## Details

- Unofficial and unsupported: these wrappers read the JSON API that the
  Next.js site www.legabasket.it itself calls. Legal notice: the site's
  terms say "Non e' consentito copiare ... dati e informazioni senza
  autorizzazione scritta" (copying data and information without written
  authorisation is not allowed), except for personal, non-commercial
  use. The owner accepted the restriction for this intake on 2026-10-12.
  Payloads are not redistributed as release assets, and any published
  data release of this source needs separate sign-off.

- robots.txt allows /api and sets Crawl-delay: 2. The runtime waits 2 s
  before every request, retries included. Crawl incrementally: fetch a
  final game once (keyed by game_id), find new games with one
  lba_calendar call per round, and do not backfill a history in a burst.

- Seasons are END years (2027 = 2026-27); the site sends START years and
  the runtime maps them (season - 1 on the wire). Game and player ids
  are global; team ids are re-issued every season (join lba_teams for
  the stable club_id); a championship id is one season AND one phase
  (Regular Season and Play Off differ).

- Play-by-play starts in 2017-18 and changes shape in 2019-20 (pixel
  frame to court percent) and 2021-22; see lba_pbp. Box scores reach
  back to 1995-96, where the period scores were not recorded (0 means
  missing).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or a body with no rows: an unknown season,
  a play-by-play before 2017-18, standings of a finished championship
  without a round), `hoopR_bad_request` (a season that is not an END
  year, a bad choice, HTTP 400 / 422) and `hoopR_asset_fetch` (any other
  non-2xx, a connection failure after retries, an empty / non-JSON /
  error-shaped 200, a game that is not final on the box score,
  play-by-play and shot routes, a truncated page, or a body for another
  season, championship, game, team, player, round or category than the
  one asked for). An unknown id is HTTP 500, which is not retried. A
  body the parser finds no rows in gives a zero-row tibble with these
  columns.

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_player_stats()`](https://hoopR.sportsdataverse.org/reference/lba_player_stats.md),
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_pbp(game_id = 25602))
#> ── LBA Play-by-Play from legabasket.it ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:47 UTC
#> # A tibble: 605 × 36
#>    game_id season home_team_id visitor_team_id team_side home_score
#>      <int>  <int>        <int>           <int> <chr>          <int>
#>  1   25602   2027         1764            1761 NA                 0
#>  2   25602   2027         1764            1761 home               0
#>  3   25602   2027         1764            1761 home               0
#>  4   25602   2027         1764            1761 home               0
#>  5   25602   2027         1764            1761 home               0
#>  6   25602   2027         1764            1761 home               0
#>  7   25602   2027         1764            1761 home               0
#>  8   25602   2027         1764            1761 visitor            0
#>  9   25602   2027         1764            1761 visitor            0
#> 10   25602   2027         1764            1761 visitor            0
#> # ℹ 595 more rows
#> # ℹ 30 more variables: visitor_score <int>, coord_frame <chr>, action_id <int>,
#> #   description <chr>, player_id <int>, team_id <int>, home_club <int>,
#> #   in_area <lgl>, dunk <int>, seconds <int>, minute <int>, period <int>,
#> #   order <int>, side <int>, x <int>, y <int>, score <chr>,
#> #   linked_action_id <int>, print_time <chr>, action_1_qualifier_code <chr>,
#> #   action_2_qualifier_code <chr>, action_1_qualifier_description <chr>, …
# }
```
