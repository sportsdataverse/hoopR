# **ABA League Player**

One player's bio for one season and league: club, position, height,
birth date and place, nationality and the career line.

Endpoint: `GET https://www.aba-liga.com/player/{player_id}/{sez}/{lea}/`
`sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_player(player_id, season, league = "aba")
```

## Arguments

- player_id:

  Required. ABA player id (global: one person keeps one id across
  seasons and both leagues), e.g. 4807 (Carlik Jones); `player_id` in
  aba_box_players.

- season:

  Required. Season END year (2026 = 2025-26). the wrapper sends the
  site's START-year key `sez = season - 2001` (25). The ABA League's
  first season is 2001-02 (`season=2002`).

- league:

  League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or
  `aba2` (ABA League 2, druga.aba-liga.com, lea=2). Both sites serve one
  database; the runtime asks the league's own host. Default `"aba"`.

## Value

A `hoopR_data` tibble. One row keyed by (`player_id`, `season`,
`league_id`) with the club (`team_id` is the global club id), position,
height in cm, birth date and place, nationality (a three-letter code)
and `career`, the free-text Clubs box joined with `"; "` (oldest first).
These bio fields are the public player profile. Every column below is
always present (a zero-row tibble keeps them and their types); an answer
with nothing in it raises `hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
| season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
| league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
| league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
| name | character | Full name from the h1, 'First Last' (checked against the expected name). |
| team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
| club | character | Club name of the 'Club:' row. |
| position | character | Position in English as printed ('Guard' on the sample). |
| height_cm | integer | Height in centimetres ('185 cm'). |
| birth_date | Date | Date of birth, ISO 'YYYY-MM-DD' (public player bio). |
| birth_place | character | Place of birth as printed, 'City, COUNTRY' ('Cincinnati, USA'). |
| nationality | character | Sporting nationality, a three-letter code as printed ('SSD' = South Sudan; IOC/FIBA-style codes). |
| career | character | The Clubs box, one free-text line per stint, oldest first, joined with '; ' ('2021/22 - Texas Legends; 2024-27 - Partizan Mozzart Bet'). |

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
[`aba_pbp()`](https://hoopR.sportsdataverse.org/reference/aba_pbp.md),
[`aba_periods()`](https://hoopR.sportsdataverse.org/reference/aba_periods.md),
[`aba_player_games()`](https://hoopR.sportsdataverse.org/reference/aba_player_games.md),
[`aba_score_difference()`](https://hoopR.sportsdataverse.org/reference/aba_score_difference.md),
[`aba_score_flow()`](https://hoopR.sportsdataverse.org/reference/aba_score_flow.md),
[`aba_shots()`](https://hoopR.sportsdataverse.org/reference/aba_shots.md),
[`aba_standings()`](https://hoopR.sportsdataverse.org/reference/aba_standings.md)

## Examples

``` r
# \donttest{
  try(aba_player(player_id = 4807, season = 2026))
#> ── ABA League Player ─────────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:32:28 UTC
#> # A tibble: 1 × 13
#>   player_id season league_id league name        team_id club  position height_cm
#>       <int>  <int>     <int> <chr>  <chr>         <int> <chr> <chr>        <int>
#> 1      4807   2026         1 aba    Carlik Jon…      22 Part… Guard          185
#> # ℹ 4 more variables: birth_date <date>, birth_place <chr>, nationality <chr>,
#> #   career <chr>
# }
```
