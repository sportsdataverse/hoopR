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

A `hoopR_data` tibble. Two rows, home then away. `minutes` is the five
on court summed (`200:00`, `225:00` with one overtime); `points` equals
the final score; `reb_tot` equals the players' sum (team rebounds are
not added). Every column below is always present (a zero-row tibble
keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The {gameNo} of the match route. |
| season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
| league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
| league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
| side | character | 'home' or 'away' (the home team is listed first everywhere on the site). |
| team_id | integer | ABA club id (global: the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26). Joins every frame that carries it; the calendar has club names only. |
| team_name | character | Club name as the site prints it now (see game.home_team). |
| minutes | character | Minutes played, 'mm:ss' text. Team rows sum the five on court: '200:00', '225:00' with one overtime. |
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
| reb_tot | integer | Total rebounds (Rebs T). Team rows equal the players' sum on every sample (team rebounds are not added). |
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
| plus_minus | integer | Plus/minus while on court (+/-). 0 on every row of the 2008-09 sample (not tracked then). Team rows: the final margin (0 on the 2008-09 sample). |
| valuation | integer | Valuation (Val, 'rank Value'): the efficiency rating (PIR-style index) the site ranks players by. |

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
  try(aba_box_teams(game_no = 6, season = 2026))
#> ── ABA League Team Box ────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:26:17 UTC
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
