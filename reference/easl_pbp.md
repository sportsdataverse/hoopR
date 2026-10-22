# **Get EASL Play-by-Play**

Play-by-play of a finished game in delivered order, with the running
score and the points each event scored.

Endpoint:
`GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/playbyplay`

## Usage

``` r
easl_pbp(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Play-by-play of a finished game in delivered
order, with the running score and the points each event scored. An empty
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `easl_pbp`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| fixture_id | character | DataCore fixture (game) UUID v1 from the request. |
| event_number | integer | 1-based position of the event in the delivered array, which is the only usable order (sequence is not monotonic). |
| sequence | integer | Event sequence number from the scorer's system: NOT in game order (the delivered array order is), and not always unique within a game (35 of 106 games repeat values). |
| period_id | integer | Period: 1-4 regulation, 11 = first overtime (12 = second overtime appears in team totals). |
| period_label | character | Q1-Q4 for periods 1-4; OT1, OT2 ... for overtimes (the server numbers the first overtime 11 in team totals; periods 5-10 are read as `OT{n-4}`, unverified). |
| event_time | character | When the event was logged, wall-clock 'YYYY-MM-DDTHH:MM:SS.mmm' in UTC with no zone marker. There is NO game clock (time remaining) in this feed. |
| received_time | double | When the event was received upstream, Unix epoch MILLISECONDS (UTC): a median 1.6 s after eventTime (5th to 95th percentile -0.6 s to +55 s over 30,874 events); meaning unverified. |
| description | character | Event text. Shots read `<2pt/3pt> <shot type> missed[ (modifier)]` for EVERY field-goal attempt, made or not: the word 'missed' is always there and the result is the change of `scores` (see the divergence notes). Shot types: Jump shot, Layup, Driving layup, Pull-up jump shot, Floating jump shot, Tip-in, Fadeaway, Step-back jump shot, Turnaround jump shot, Hook shot, Dunk, Reverse layup, Alley-oop, Alley-oop dunk, Euro step (none on 23 rows: '3pt missed'). Modifiers: in the paint, second chance, from turnover, fast break, blocked. Free throws read 'Free throw K of M made' (M = 1, 2 or 3) for every attempt, also always 'made'. Other events (complete list): Assist; Block; Steal; Substitution in; Substitution out; Defensive rebound; Defensive rebound (team); Offensive rebound; Offensive rebound (team); Foul; Foul (N FT); Foul drawn; Foul drawn (N FT); Personal foul; Personal foul (N FT); Personal foul (shooting); Personal foul (shooting) (N FT); Offensive foul; Offensive foul (charge); Technical foul; Technical foul (N FT); Bench technical foul; Bench technical foul (N FT); Coach technical foul; Coach technical foul (N FT); Unsportsmanlike foul; Unsportsmanlike foul (N FT); Disqualifying foul (N FT); Jump ball won; Jump ball won (held ball); Jump ball lost; Full timeout; Short timeout; Media timeout; Commercial timeout; Officials timeout; Officials timeout (mandatory); Coach's challenge (pending); Coach's challenge (complete) - upheld; Coach's challenge (complete) - overturned; Instant replay review (complete) - upheld; Instant replay review (complete) - overturned; Turnover - Bad pass; Ball handling; Traveling; Out of bounds; Offensive; Backcourt violation; Double dribble; Carrying; Offensive goaltending; 3 second violation; 5 second violation; 5 second violation (team); 8 second violation (team); Shot clock violation (team); Other; Other (team). N FT = free throws awarded. |
| team_id | character | DataCore team UUID v1 of the acting team; null on events with no team. |
| player_id | character | DataCore person UUID v1 of the acting player; null for team events (team rebounds, timeouts). |
| player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. Absent on some rows. |
| player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. Absent on some rows. |
| jersey_number | character | Jersey number as a string; null on one event. Absent on some rows. |
| team_score | integer | The event team's running score as of this event (the running score lags the true score on a minority of events); null on events with no team. |
| opponent_score | integer | The other team's running score as of this event; null on events with no team. |
| points_scored | integer | Points the event team gained since the previous event (change of its running score): the made shot's value. The description always says 'missed', so count points here, not strings; the running score lags on some games, which shifts points to a later event. |
| team1_id | character | First team of the body's teams array (the fixture's competitors order, arbitrary home/away); team1_score belongs to it. |
| team1_score | integer | Running score of team1_id as of this event. |
| team2_id | character | Second team of the body's teams array; team2_score belongs to it. |
| team2_score | integer | Running score of team2_id as of this event. |

## Details

- WARNING: UNOFFICIAL THIRD-PARTY INTERMEDIARY. These wrappers read
  easl.joshricha.com/api/v1, an Express server run by an individual. It
  is not EASL's and not Sportradar's: it mirrors Sportradar DataCore
  (organisation b1e0z) into SQLite and serves it keyless, and it can
  change or vanish without notice. Its routes, field names (steak,
  facebook_username) and sync freshness are the proxy author's. A
  first-party DataCore feed needs credentials this package does not
  have. The host serves no robots.txt (404) and states no terms; the
  runtime waits at least 1 s before every request, retries included, and
  honours Retry-After. Payloads are not redistributed as release assets.

- Seasons are END years (2026 = EASL 25-26). The server's season key is
  the START year; the runtime reads the season list, maps the END year
  to the DataCore seasonId and defaults to the ACTIVE season. Four
  editions exist (2023-24 to 2026-27). The server defaults to the active
  season on /matches, /standings and /leaders; the runtime always sends
  the resolved seasonId. A season is two calendar years: group by
  season_id, not by the year of the tip-off.

- Finished games only: the game routes first read the fixture and refuse
  (`hoopR_asset_fetch`) one that is not CONFIRMED with two scores, a box
  score whose player points do not add up to the score (the server
  serves one-team, four-row boxes for some games), a play-by-play that
  does not end on the final score in its highest period (4 or more, and
  the last period of the period table), and team totals that disagree
  with the score. For the ACTIVE season's fixture lists the runtime
  reads /health: a server clock more than a day from yours, or a game
  still SCHEDULED more than a day after its tip-off, means the mirror
  has stalled (`hoopR_asset_fetch`). That proves the mirror kept up with
  the games played, not that a game is final upstream.

- Ids: every DataCore id is a UUID v1 string. team_id = entityId,
  player_id = personId; fixture_number (YYSSNNN) is null on every
  2023-24 fixture; `*_row_id` columns are the sync server's own
  integers, not DataCore ids. The fixture's competitors come in
  arbitrary order: read `home_*` / `away_*`, which the parsers take from
  isHome.

- No shot x/y, no game clock and no lineups exist on this server. The
  play-by-play text always says 'missed' for field goals and 'Free throw
  K of M made' for free throws, made or not: use points_scored (the
  change of the event team's running score), which lags on a minority of
  events. 301 of 2,444 sampled box rows are players who did not play
  (null minutes and counting stats; points are 0); player_box.played
  tells them apart. easl_player_stats ignores a season filter: it is the
  career line over every season. Names: nameFullLocal is the English
  display name and nameFullLatin the native-script name, so the columns
  are name and name_native.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, an empty list or leaders object, a team or
  player without games), `hoopR_bad_request` (a malformed id, or a
  season that is not one of the server's END years, raised before the
  request that would use it) and `hoopR_asset_fetch` (any other failure:
  any non-2xx, including the server's HTTP 400 / 422 and the HTTP 500 it
  answers for an unknown fixture, which is not retried; an error
  envelope; a game that is not finished or whose box score or
  play-by-play is incomplete; a stalled sync on the active season; a
  body for another game, season, team or player than the one asked for).
  Wrappers raise; they never warn and return an empty frame.

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)

## Examples

``` r
# \donttest{
  try(easl_pbp(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Play-by-Play from easl.joshricha.com ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:35:46 UTC
#> # A tibble: 495 × 20
#>    fixture_id            event_number sequence period_id period_label event_time
#>    <chr>                        <int>    <int>     <int> <chr>        <chr>     
#>  1 10af8fd4-106e-11f1-9…            1        7         1 Q1           2026-03-2…
#>  2 10af8fd4-106e-11f1-9…            2        9         1 Q1           2026-03-2…
#>  3 10af8fd4-106e-11f1-9…            3       20         1 Q1           2026-03-2…
#>  4 10af8fd4-106e-11f1-9…            4       21         1 Q1           2026-03-2…
#>  5 10af8fd4-106e-11f1-9…            5       31         1 Q1           2026-03-2…
#>  6 10af8fd4-106e-11f1-9…            6       29         1 Q1           2026-03-2…
#>  7 10af8fd4-106e-11f1-9…            7       37         1 Q1           2026-03-2…
#>  8 10af8fd4-106e-11f1-9…            8       53         1 Q1           2026-03-2…
#>  9 10af8fd4-106e-11f1-9…            9       54         1 Q1           2026-03-2…
#> 10 10af8fd4-106e-11f1-9…           10       43         1 Q1           2026-03-2…
#> # ℹ 485 more rows
#> # ℹ 14 more variables: received_time <dbl>, description <chr>, team_id <chr>,
#> #   player_id <chr>, player_name <chr>, player_name_latin <chr>,
#> #   jersey_number <chr>, team_score <int>, opponent_score <int>,
#> #   points_scored <int>, team1_id <chr>, team1_score <int>, team2_id <chr>,
#> #   team2_score <int>
# }
```
