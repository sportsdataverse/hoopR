# **ABA League Team Box**

Team totals of one finished game: the Team Compare table, home then
away.

Endpoint:
`GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
`sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_box_teams(game_no, season, league = "aba")
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

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "aba_box_teams")`) and in the searchable
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
[`aba_calendar()`](https://hoopR.sportsdataverse.org/reference/aba_calendar.md),
[`aba_game()`](https://hoopR.sportsdataverse.org/reference/aba_game.md),
[`aba_pbp()`](https://hoopR.sportsdataverse.org/reference/aba_pbp.md),
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
  # Interactive only: parsing the box-score page takes 2-4 s.
  try(aba_box_teams(game_no = 6, season = 2026))
#> ── ABA League Team Box ────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:57:42 UTC
#> # A tibble: 2 × 34
#>   game_no season league_id league side  team_id team_name  minutes points fg_pct
#>     <int>  <int>     <int> <chr>  <chr>   <int> <chr>      <chr>    <int>  <dbl>
#> 1       6   2026         1 aba    home       12 Budućnost… 225:00      93   42.3
#> 2       6   2026         1 aba    away       91 Spartak O… 225:00      97   49.3
#> # ℹ 24 more variables: fg2_made <int>, fg2_att <int>, fg2_pct <dbl>,
#> #   fg3_made <int>, fg3_att <int>, fg3_pct <dbl>, ft_made <int>, ft_att <int>,
#> #   ft_pct <dbl>, reb_def <int>, reb_off <int>, reb_tot <int>, assists <int>,
#> #   steals <int>, turnovers <int>, blocks <int>, blocks_against <int>,
#> #   fouls <int>, fouls_drawn <int>, pts_paint <int>, pts_second_chance <int>,
#> #   pts_fast_break <int>, plus_minus <int>, valuation <int>
# }
```
