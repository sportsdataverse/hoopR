# **ABA League Shots**

Shot chart of one finished game (2017-18 on): every field-goal attempt
with its court position.

Endpoint:
`GET https://www.aba-liga.com/live-match/rezultati-1718/create_shooting_chart.php?id={game_no}&sez={sez}&lea={lea}`
(after a GET of the same game's match page, which the helper is checked
against). `sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_shots(game_no, season, league = "aba")
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

A `hoopR_data` tibble. One row per field-goal attempt (no free throws),
in the site's order. `x` and `y` are PERCENTAGES of the full court on
the site's 1000x535 px image (court 28 x 15 m), cast to float (the site
sends x as a string in one half of a game and a number in the other). x
runs from the LEFT baseline (home shoots at x \< 50, away at x \> 50). y
is drawn upward from the bottom edge, 50 = the line through both
baskets; whether "up" is the scorer's table side is unverified. `side`
is `home` / `away` (the site's `ekipa` 1 / 2). `player_id` is cast from
the site's string (null when the shooter was not recorded, id 0); join
on it, not on the name. The chart can differ from the box score by one
attempt per shooter. Every column below is always present (a zero-row
tibble keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The {gameNo} of the match route. |
| season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
| league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
| league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
| side | character | Which team took the shot: home or away (the site's ekipa, a string '1' / '2'). |
| x | double | Shot x as a PERCENTAGE (0-100) of the court LENGTH from the LEFT baseline of the site's 1000x535 px full-court image. Home shoots at x \< 50 and away at x \> 50. The site sends it as a string in one half of a game and a number in the other; cast to float. |
| y | double | Shot y as a PERCENTAGE (0-100) of the court WIDTH, drawn upward from the bottom edge (the line through both baskets is 50). Whether 'up' is the scorer's table side is unverified. |
| made | logical | True when the attempt was made (the site's koordinata_uspeh '1'), false when missed. |
| player_id | integer | Shooter's ABA player id (global), cast from the site's string; null when the shooter was not recorded (id 0). Join to the box score on it, never on the name. |
| player_name | character | Shooter's full name, 'First Last' (the box prints 'Last F.'); null when not recorded. |

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
[`aba_player()`](https://hoopR.sportsdataverse.org/reference/aba_player.md),
[`aba_player_games()`](https://hoopR.sportsdataverse.org/reference/aba_player_games.md),
[`aba_score_difference()`](https://hoopR.sportsdataverse.org/reference/aba_score_difference.md),
[`aba_score_flow()`](https://hoopR.sportsdataverse.org/reference/aba_score_flow.md),
[`aba_standings()`](https://hoopR.sportsdataverse.org/reference/aba_standings.md)

## Examples

``` r
# \donttest{
  try(aba_shots(game_no = 6, season = 2026))
#> ── ABA League Shots ──────────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:32:36 UTC
#> # A tibble: 152 × 10
#>    game_no season league_id league side      x     y made  player_id player_name
#>      <int>  <int>     <int> <chr>  <chr> <dbl> <dbl> <lgl>     <int> <chr>      
#>  1       6   2026         1 aba    home   8.92  26.1 FALSE      4781 Juwan Morg…
#>  2       6   2026         1 aba    home   7.99  37.7 TRUE       4781 Juwan Morg…
#>  3       6   2026         1 aba    away  91.1   35.1 TRUE       5110 Keondre Ke…
#>  4       6   2026         1 aba    home  14.7   64.5 TRUE       5072 Oleksandr …
#>  5       6   2026         1 aba    away  91.9   57.7 TRUE       5110 Keondre Ke…
#>  6       6   2026         1 aba    home  13.1   39.7 TRUE       5053 Jerry Fran…
#>  7       6   2026         1 aba    away  90.7   53.2 TRUE       2112 Danilo Nik…
#>  8       6   2026         1 aba    home   8.3   44.2 FALSE      4769 Rasheed Su…
#>  9       6   2026         1 aba    home  11.4   33.2 TRUE       4769 Rasheed Su…
#> 10       6   2026         1 aba    away  93.5   56.0 FALSE      2312 Nikola Reb…
#> # ℹ 142 more rows
# }
```
