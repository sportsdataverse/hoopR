# **Genius Play-by-Play**

Play-by-play of a finished game, newest action first, with the running
score and lead.

Endpoint:
`GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`

Rows in the feed's order: newest first by game time, so `row_index` 0 is
the last action (normally the `game` `end` row); sort on `action_number`
for entry order. `score_1` / `score_2` are always integer. `qualifier`
joins the qualifier codes with commas. `clock`, `action_number` and
`previous_action` are NA in the 2014-15 feed. Overtime restarts `period`
at 1: read it with `period_type`.

## Usage

``` r
genius_pbp(match_id, return_parsed = TRUE)
```

## Arguments

- match_id:

  Genius match id (`match_id` of
  [`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
  [`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md)
  or
  [`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md)),
  e.g. 2902690.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the sdv-internal-refs capture shape of a page.

## Value

A `hoopR_data` tibble (a zero-row tibble with these columns when Genius
answers an empty valid page), or the raw list when
`return_parsed = FALSE`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| row_index | integer | Position of the action in the feed order, 0 = the newest action by game time (normally the game end row). The feed is not strictly sorted by action_number, so sort on action_number for entry order. |
| action_number | integer | Action sequence number, unique within the game (gaps where actions were deleted); a shot joins its play-by-play row on it. Null in the 2014-15 feed. |
| previous_action | integer | action_number of the linked earlier action (the shot an assist or rebound belongs to); null when the feed sends an empty string. |
| period | integer | Period number; restarts at 1 for the first overtime (read it with period_type). |
| period_type | character | Period type: REGULAR or OVERTIME. |
| gt | character | Game clock, 'mm:ss' remaining in the period |
| clock | character | Game clock with hundredths, 'mm:ss:cc' remaining in the period; absent in older feeds (the 2014-15 WBBL sample has gt only) |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
| player | character | Player display name; ” when no player |
| shirt_number | character | Player shirt number (string); ” when no player |
| first_name | character | Given name in the competition's own script and spelling (Greek, Hebrew, Czech, ... as entered) |
| family_name | character | Family name in the competition's own script |
| international_first_name | character | Given name in Latin script |
| international_family_name | character | Family name in Latin script (often upper case) |
| scoreboard_name | character | Short display name ('T. Nichols'), in the local script when the org enters one |
| action_type | character | Action type: 2pt, 3pt, freethrow, rebound, assist, turnover, steal, block, foul, foulon (foul drawn), substitution, timeout, jumpball, period, game, headcoachchallenge |
| sub_type | character | Action subtype, free-text code per actionType: shot type for 2pt/3pt (layup, drivinglayup, jumpshot, pullupjumpshot, turnaroundjumpshot, ...), 'in'/'out' for substitutions, 'start'/'end' for period and game, foul kind for fouls; empty string when none |
| qualifier | character | Qualifier codes of the action joined with commas (pointsinthepaint, fromturnover, 2ndchance, fastbreak, blocked, ...); null when none. |
| success | integer | 1 = made / successful, 0 = missed (shots, free throws); 1 for other actions |
| scoring | integer | 1 when the action is a scoring attempt (shot or free throw), else 0 |
| score_1 | integer | Team 1 score after the action, always an integer (the feed sends a string in most games). |
| score_2 | integer | Team 2 score after the action, always an integer (the feed sends a string in most games). |
| lead | integer | Score margin after the action, team 1 minus team 2 (negative when team 2 leads) |

## Details

**Access.** The Genius hosts publish no robots.txt and no terms.
CloudFront refuses datacenter IPs on the LiveStats and hosted hosts:
from a server set `options(hoopR.proxy = ...)` or the `GENIUS_PROXY`
environment variable to an http(s) proxy URL (never printed or logged).
Requests are spaced at least one second apart per host; keep crawls slow
and incremental. Some league sites (the NZ NBL) forbid AI crawlers in
their own robots.txt, which does not cover these hosts. Unofficial use
of a public source: payloads are not redistributed as release assets.

**Org and season.** Every competition is an ORG code plus a competition
id (`comp_id`):
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)
lists an org's competitions with the sdv END-year `season` (a START-year
org lists 2025-26 as season 2026),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md)
maps a game to its competition, and `data.json` itself names no date,
competition or season. The hosted ORG can differ from the LiveStats ORG
of `/u/` (NZNBL vs NZN). Match ids are one global sequence across every
Genius customer. `data.json` carries no global team or player id: `tno`
(1 or 2) and `pno` are in-game numbers; only finished games are read.

**Errors** (classed conditions, all inheriting `hoopR_error`):
`hoopR_no_data` when Genius has nothing for the request (HTTP 404, the
S3 `AccessDenied` 403, an empty 200 from the hosted host, an empty
recent-games window, a schedule or widget with no matches);
`hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius
route (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is
unknown: the CloudFront "Request blocked" 403, a rate limit or 5xx, the
intermittent HTTP 500 "A website error has occurred" page
(`transient = TRUE`: retry later), a dead connection, an error envelope,
a cut-off page, an unfinished game, or a body for another match,
competition or ORG.

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_pbp(match_id = 2902690))
#> ── Genius LiveStats play-by-play ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:13:33 UTC
#> # A tibble: 663 × 25
#>    match_id row_index action_number previous_action period period_type gt   
#>       <int>     <int>         <int>           <int>  <int> <chr>       <chr>
#>  1  2902690         0          1052              NA      1 OVERTIME    00:00
#>  2  2902690         1          1051              NA      1 OVERTIME    00:00
#>  3  2902690         2          1048              NA      1 OVERTIME    00:00
#>  4  2902690         3          1044              NA      1 OVERTIME    00:02
#>  5  2902690         4          1045              NA      1 OVERTIME    00:02
#>  6  2902690         5          1043              NA      1 OVERTIME    00:02
#>  7  2902690         6          1042              NA      1 OVERTIME    00:02
#>  8  2902690         7          1040              NA      1 OVERTIME    00:02
#>  9  2902690         8          1041              NA      1 OVERTIME    00:02
#> 10  2902690         9          1039              NA      1 OVERTIME    00:02
#> # ℹ 653 more rows
#> # ℹ 18 more variables: clock <chr>, tno <int>, pno <int>, player <chr>,
#> #   shirt_number <chr>, first_name <chr>, family_name <chr>,
#> #   international_first_name <chr>, international_family_name <chr>,
#> #   scoreboard_name <chr>, action_type <chr>, sub_type <chr>, qualifier <chr>,
#> #   success <int>, scoring <int>, score_1 <int>, score_2 <int>, lead <int>
# }
```
