# **ABA League Play-by-Play**

Play-by-play of one finished game (2017-18 on), in game order: shots,
rebounds, fouls, substitutions, timeouts and period markers.

Endpoint:
`GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
`sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_pbp(game_no, season, league = "aba")
```

## Arguments

- game_no:

  Required. Game number within the season AND league (it restarts at 1
  for every season and league), e.g. 6; `game_no` in aba_calendar.
  Playoff games that were not needed leave gaps.

- season:

  Required. Season END year (2026 = 2025-26). the wrapper sends the
  site's START-year key `sez = season - 2001` (25). The ABA League's
  first season is 2001-02 (`season=2002`).

- league:

  League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or
  `aba2` (ABA League 2, druga.aba-liga.com, lea=2). Both sites serve one
  database; the runtime asks the league's own host. Default `"aba"`.

## Value

A `hoopR_data` tibble. One row per event, `seq` 1-based in game order
(the page lists each period newest first). `period` is 1-4 for the
quarters and 5 for every overtime together; `clock` is `mm:ss` REMAINING
(10:00 per quarter, 05:00 in overtime) and null on starting-lineup and
period markers. The score is printed only on scoring events, so
`home_score` / `away_score` are null elsewhere (carry them forward for a
running score). `text` is the English event; `action` is the text
without its parenthesised `qualifier` (shot type, rebound side, `n of m`
free throw, foul or turnover type). Team-only rows print just the
qualifier, so `action` is null there. Empty before 2017-18 (the page has
no play-by-play tab). Every column below is always present (a zero-row
tibble keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The {gameNo} of the match route. |
| season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
| league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
| league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
| seq | integer | 1-based position in game order across the whole game (after the reversal). |
| period | integer | 1-4 = quarters, 5 = overtime (the \#q5 tab; every overtime of the game). |
| clock | character | Clock in the period, 'mm:ss' REMAINING (counts down from 10:00; overtime from 05:00). Null on the starting-lineup rows and on game / period start and end markers. |
| seconds_left | integer | The clock as whole seconds REMAINING in the period (08:34 = 514), derived by the parser; null where the clock is. |
| home_score | integer | Home score after this event: only set on scoring events (the page prints the score only there); null otherwise. Carry it forward for a running score. |
| away_score | integer | Away score after this event, as home_score. |
| side | character | Which column the event sits in: 'home', 'away', or null for game/period markers and bare-clock rows. A timeout row gets the side of its team badge. |
| team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
| jersey | integer | Jersey number as printed; the play-by-play omits it on some rows (all starting-lineup rows and many home rows), so it is null there. |
| player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
| player_name | character | Name as the play-by-play prints it: 'SURNAME I' upper case (the trailing '.' belongs to the event text on the page and is dropped). |
| text | character | Event text in English after the player's name: `<action> (<qualifier>)`, 'in starting lineup', or the whole text of a team / game row ('(defensive)', 'Timeout', 'start of 1. quarter'). Null on bare-clock rows ('10:00' with nothing else, opening some periods). |
| action | character | text without its parenthesised qualifier; see the action table below the route. Null on team rows (they print only '(qualifier)') and bare-clock rows. |
| qualifier | character | The parenthesised part of text (shot type, rebound side, free-throw 'n of m', foul or turnover type); see the qualifier table. Null when the text has none. |

## Details

Unofficial use of a public source: these wrappers read the leagues' own
PHP sites (www.aba-liga.com, druga.aba-liga.com), keyless, with no bot
wall; payloads are not redistributed as release assets.
www.aba-liga.com/robots.txt is the single line `User-agent: *` (nothing
disallowed, no Crawl-delay) and druga has no robots.txt; no terms page
was found. The runtime waits at least 1 s per host before every request.

Coverage: box scores from 2001-02; play-by-play, the starter and
on-court markers, the shot chart and the minute-by-minute score from
2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the
helpers). A game is keyed by (game_no, season, league_id): game_no
restarts at 1 for every season and league. Team and player ids are
global; the calendar carries club names only. Club names are the club's
CURRENT name on every season: join on team_id.

Only finished games are served: an unplayed game, or one whose period
scores, team totals or play-by-play do not add up to the final score,
raises `hoopR_asset_fetch`, as does a page for another game, season or
league than asked. The three live-match helpers echo nothing about the
game, so the runtime fetches the same game's match page first (one extra
request) and checks the helper against it.

Times: `CET` means Central European wall-clock time including summer
time (the label never changes); ABA League 2 prints `Local time`.
Officials appear by name only; the player bio (birth date and place,
nationality) is the public player profile.

Errors: `hoopR_no_data` when the site has nothing for the request (HTTP
404, an unknown game redirected to /match-not-defined/, a season the
site does not hold or before 2001-02, a live-match helper with no data
before 2017-18); `hoopR_bad_request` for an invalid argument (a
non-integer id or season, a `league` other than `aba` / `aba2`) or HTTP
400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200,
a connection failure after three attempts, a redirect off the ABA sites)
or the answer is not the one asked for (a page for another game, season
or league, an unfinished game, a helper that does not belong to the
game, layout drift). All inherit `hoopR_error`.

## See also

Other ABA:
[`aba_box_players()`](https://hoopR.sportsdataverse.org/reference/aba_box_players.md),
[`aba_box_teams()`](https://hoopR.sportsdataverse.org/reference/aba_box_teams.md),
[`aba_calendar()`](https://hoopR.sportsdataverse.org/reference/aba_calendar.md),
[`aba_game()`](https://hoopR.sportsdataverse.org/reference/aba_game.md),
[`aba_periods()`](https://hoopR.sportsdataverse.org/reference/aba_periods.md),
[`aba_player()`](https://hoopR.sportsdataverse.org/reference/aba_player.md),
[`aba_player_games()`](https://hoopR.sportsdataverse.org/reference/aba_player_games.md),
[`aba_score_difference()`](https://hoopR.sportsdataverse.org/reference/aba_score_difference.md),
[`aba_score_flow()`](https://hoopR.sportsdataverse.org/reference/aba_score_flow.md),
[`aba_shots()`](https://hoopR.sportsdataverse.org/reference/aba_shots.md),
[`aba_standings()`](https://hoopR.sportsdataverse.org/reference/aba_standings.md)

## Examples

``` r
# \donttest{
  try(aba_pbp(game_no = 6, season = 2026))
#> ── ABA League Play-by-Play ───────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:20:01 UTC
#> # A tibble: 659 × 18
#>    game_no season league_id league   seq period clock seconds_left home_score
#>      <int>  <int>     <int> <chr>  <int>  <int> <chr>        <int>      <int>
#>  1       6   2026         1 aba        1      1 NA              NA         NA
#>  2       6   2026         1 aba        2      1 NA              NA         NA
#>  3       6   2026         1 aba        3      1 NA              NA         NA
#>  4       6   2026         1 aba        4      1 NA              NA         NA
#>  5       6   2026         1 aba        5      1 NA              NA         NA
#>  6       6   2026         1 aba        6      1 NA              NA         NA
#>  7       6   2026         1 aba        7      1 NA              NA         NA
#>  8       6   2026         1 aba        8      1 NA              NA         NA
#>  9       6   2026         1 aba        9      1 NA              NA         NA
#> 10       6   2026         1 aba       10      1 NA              NA         NA
#> # ℹ 649 more rows
#> # ℹ 9 more variables: away_score <int>, side <chr>, team_id <int>,
#> #   jersey <int>, player_id <int>, player_name <chr>, text <chr>, action <chr>,
#> #   qualifier <chr>
# }
```
