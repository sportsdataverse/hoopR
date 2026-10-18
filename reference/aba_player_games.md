# **ABA League Player Games**

One player's game log for one season and league: one row per game with
the box-score stats.

Endpoint: `GET https://www.aba-liga.com/player/{player_id}/{sez}/{lea}/`
`sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_player_games(player_id, season, league = "aba")
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

A `hoopR_data` tibble. One row per game the player was listed in, keyed
by (`player_id`, `game_no`, `season`, `league_id`). `round_no` is the
season-wide round index (regular season 1-18, later phases continue the
count) and `game` the short `Home-Away` pairing label. The stat columns
are the box-score stats (`minutes` is `mm:ss`); the three `pts_*`
columns are null here (the game log has no such columns). Every column
below is always present (a zero-row tibble keeps them and their types);
an answer with nothing in it raises `hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ABA player id (global: one person keeps one id across seasons and both leagues, e.g. Carlik Jones = 4807), cast to an integer. Join on it, never on the printed name. |
| season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
| league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
| league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
| round_no | integer | Season-wide round index of the game: 1-18 = regular season, later phases continue the count (ABA 2025-26: 'Top8 - R2' = 21, 'Finals, Round 4' = 48). |
| game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The {gameNo} of the match route. |
| game | character | Short pairing label 'Home-Away' with short club names ('Partizan-Krka', 'C. Zvezda-Partizan'). |
| minutes | character | Minutes played, 'mm:ss' text. |
| points | integer | Points scored (overall Pts). |
| fg_pct | double | Field-goal percentage over 2- and 3-point attempts, 0-100 with one decimal (FG2 + FG3 made / attempted); 0 when no attempt. Header 'overall %'. |
| fg2_made | integer | 2-point field goals made (FG2 M). |
| fg2_att | integer | 2-point field goals attempted (FG2 A). |
| fg2_pct | double | 2-point percentage, 0-100 with one decimal; 0 when no attempt. |
| fg3_made | integer | 3-point field goals made (FG3 M). |
| fg3_att | integer | 3-point field goals attempted (FG3 A). |
| fg3_pct | double | 3-point percentage, 0-100 with one decimal; 0 when no attempt. |
| ft_made | integer | Free throws made (FT M). |
| ft_att | integer | Free throws attempted (FT A). |
| ft_pct | double | Free-throw percentage, 0-100 with one decimal; 0 when no attempt. |
| reb_def | integer | Defensive rebounds (Rebs D). |
| reb_off | integer | Offensive rebounds (Rebs O). |
| reb_tot | integer | Total rebounds (Rebs T). |
| assists | integer | Assists made (the Ass column). |
| steals | integer | Steals made (the St column). |
| turnovers | integer | Turnovers (To). |
| blocks | integer | Shots blocked by this player or team (Blck Fv, 'in favour'). |
| blocks_against | integer | Own shots blocked by an opponent (Blck Ag, 'against'). |
| fouls | integer | Fouls committed (Foul Cm). |
| fouls_drawn | integer | Fouls drawn / received (Foul Rv). |
| pts_paint | integer | Points in the paint (Points from Paint). Null where the season has no such column (2008-09) and on did-not-play rows. |
| pts_second_chance | integer | Second-chance points (Points from 2ndCh). Null where the season has no such column (2008-09) and on did-not-play rows. |
| pts_fast_break | integer | Fast-break points (Points from FstBr). Null where the season has no such column (2008-09) and on did-not-play rows. |
| plus_minus | integer | Plus/minus while on court (+/-). 0 on every row of the 2008-09 sample (not tracked then). |
| valuation | integer | Valuation (Val, 'rank Value'): the efficiency rating (PIR-style index) the site ranks players by. |

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
[`aba_score_difference()`](https://hoopR.sportsdataverse.org/reference/aba_score_difference.md),
[`aba_score_flow()`](https://hoopR.sportsdataverse.org/reference/aba_score_flow.md),
[`aba_shots()`](https://hoopR.sportsdataverse.org/reference/aba_shots.md),
[`aba_standings()`](https://hoopR.sportsdataverse.org/reference/aba_standings.md)

## Examples

``` r
# \donttest{
  try(aba_player_games(player_id = 4807, season = 2026))
#> ── ABA League Player Games ───────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:32:29 UTC
#> # A tibble: 18 × 34
#>    player_id season league_id league round_no game_no game        minutes points
#>        <int>  <int>     <int> <chr>     <int>   <int> <chr>       <chr>    <int>
#>  1      4807   2026         1 aba           1       1 Partizan-K… 14:24       10
#>  2      4807   2026         1 aba           2       9 Split-Part… 18:56       14
#>  3      4807   2026         1 aba           3      17 Partizan-F… 21:20        9
#>  4      4807   2026         1 aba          21     156 Bosna-Part… 23:35        5
#>  5      4807   2026         1 aba          24     169 Partizan-C… 22:28       14
#>  6      4807   2026         1 aba          26     177 C. Zvezda-… 27:17       14
#>  7      4807   2026         1 aba          28     187 Partizan-B… 16:42        4
#>  8      4807   2026         1 aba          30     197 Budućnost-… 24:58       11
#>  9      4807   2026         1 aba          32     205 C. Olimpij… 26:51       15
#> 10      4807   2026         1 aba          34     213 Partizan-C… 25:15       13
#> 11      4807   2026         1 aba          39     231 Partizan-B… 25:01        8
#> 12      4807   2026         1 aba          40     235 Bosna-Part… 16:02        6
#> 13      4807   2026         1 aba          42     243 Partizan-C… 23:13       15
#> 14      4807   2026         1 aba          43     245 C. Zvezda-… 29:36        9
#> 15      4807   2026         1 aba          45     248 Dubai-Part… 24:46       21
#> 16      4807   2026         1 aba          46     249 Dubai-Part… 27:45       15
#> 17      4807   2026         1 aba          47     250 Partizan-D… 26:55       15
#> 18      4807   2026         1 aba          48     251 Partizan-D… 28:36       10
#> # ℹ 25 more variables: fg_pct <dbl>, fg2_made <int>, fg2_att <int>,
#> #   fg2_pct <dbl>, fg3_made <int>, fg3_att <int>, fg3_pct <dbl>, ft_made <int>,
#> #   ft_att <int>, ft_pct <dbl>, reb_def <int>, reb_off <int>, reb_tot <int>,
#> #   assists <int>, steals <int>, turnovers <int>, blocks <int>,
#> #   blocks_against <int>, fouls <int>, fouls_drawn <int>, pts_paint <int>,
#> #   pts_second_chance <int>, pts_fast_break <int>, plus_minus <int>,
#> #   valuation <int>
# }
```
