# **ABA League Standings**

Standings tables of one season of one league: regular season groups, Top
8 and Play-out.

Endpoint: `GET https://www.aba-liga.com/standings/{sez}/{lea}/`
`sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_standings(season, league = "aba")
```

## Arguments

- season:

  Required. Season END year (2026 = 2025-26). the wrapper sends the
  site's START-year key `sez = season - 2001` (25). The ABA League's
  first season is 2001-02 (`season=2002`).

- league:

  League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or
  `aba2` (ABA League 2, druga.aba-liga.com, lea=2). Both sites serve one
  database; the runtime asks the league's own host. Default `"aba"`.

## Value

A `hoopR_data` tibble with one row per team in each table. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "aba_standings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial use of a public source: these wrappers read the leagues' own
PHP sites (www.aba-liga.com, druga.aba-liga.com), keyless, with no bot
wall. www.aba-liga.com/robots.txt is the single line `User-agent: *`
(nothing disallowed, no Crawl-delay) and druga has no robots.txt; no
terms page was found. The runtime waits at least 1 s per host before
every request.

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

Other ABA Functions:
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
[`aba_shots()`](https://hoopR.sportsdataverse.org/reference/aba_shots.md)

## Examples

``` r
# \donttest{
  try(aba_standings(season = 2026))
#> ── ABA League Standings ───────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:32:43 UTC
#> # A tibble: 36 × 16
#>    season league_id league season_label   table    group  rank team_id team_name
#>     <int>     <int> <chr>  <chr>          <chr>    <chr> <int>   <int> <chr>    
#>  1   2026         1 aba    Season 2025/26 Top 8 S… NA        1      95 Dubai Ba…
#>  2   2026         1 aba    Season 2025/26 Top 8 S… NA        2      22 Partizan…
#>  3   2026         1 aba    Season 2025/26 Top 8 S… NA        3      18 Crvena z…
#>  4   2026         1 aba    Season 2025/26 Top 8 S… NA        4      12 Budućnos…
#>  5   2026         1 aba    Season 2025/26 Top 8 S… NA        5     100 U-BT Clu…
#>  6   2026         1 aba    Season 2025/26 Top 8 S… NA        6      66 Cedevita…
#>  7   2026         1 aba    Season 2025/26 Top 8 S… NA        7       1 Bosna BH…
#>  8   2026         1 aba    Season 2025/26 Top 8 S… NA        8      30 Igokea m…
#>  9   2026         1 aba    Season 2025/26 Play-ou… NA        1      91 Spartak …
#> 10   2026         1 aba    Season 2025/26 Play-ou… NA        2       3 Zadar    
#> # ℹ 26 more rows
#> # ℹ 7 more variables: games <int>, wins <int>, losses <int>, points_for <int>,
#> #   points_against <int>, point_diff <int>, standing_points <int>
# }
```
