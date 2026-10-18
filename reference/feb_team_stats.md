# **FEB Team Stats**

**Team totals of both teams in one FEB game: shooting, rebounds,
assists, turnovers, fouls.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`

One row per team, home first. `fastb`, `ptsto`, `secpts`, `bench` and
`paint` are null on every sampled game (the stat crews do not fill
them); `seconds_played` and `val` are null on these rows.

## Usage

``` r
feb_team_stats(game_id)
```

## Arguments

- game_id:

  (*integer* required): FEB game id, e.g. `2535725`; the `game_id`
  column of
  [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
  [`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md)
  and
  [`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| team_side | character | Side of the game the row belongs to: home or away (the feed's TEAM\[0\] / TEAM\[1\], or its 1/2 and 0/1 side codes, normalised). |
| team_id | integer | Team-season id (key space: FEB team registrations; a NEW id every season, e.g. HLA Alicante = 979989 in 2025-26 and 1008687 in 2026-27). Joins the schedule's home_team_id / away_team_id; not a club or player id. |
| team | character | Team name as registered for the season (sponsor name, uppercase: 'HLA ALICANTE'). |
| team_code | character | Federation team code, 8 digits as a string: the 6-digit club_code plus a 2-digit team suffix ('03058600'). Null on 2020-21 games. |
| club_code | character | Federation club code, 6 digits as a string (the first 6 digits of team_code). Whether it is stable across seasons is unverified. Null on 2020-21 games. |
| seconds_played | integer | Seconds on court (the feed's min, an integer count of seconds: 1064 = 17:44; a team row sums its players, 12000 = 200:00). Null on /TeamStats rows. |
| min_formatted | character | Time played as 'mm:ss'; '0:00' on /TeamStats rows (only box-score totals carry a value). |
| pts | integer | Team points: the final score when the game is over, else the live score. |
| p1m | integer | Free throws made (tiros libres; integer as a string). |
| p1a | integer | Free throws attempted (integer as a string). |
| p1p | numeric | Free-throw percentage, 0-100, as a string with a DECIMAL COMMA ('77,3'); '0,0' when no attempts. |
| p2m | integer | Two-point field goals made (integer as a string). |
| p2a | integer | Two-point field goals attempted (integer as a string). |
| p2p | numeric | Two-point percentage, 0-100, string with a decimal comma ('54,1'). |
| p3m | integer | Three-point field goals made (integer as a string). |
| p3a | integer | Three-point field goals attempted (integer as a string). |
| p3p | numeric | Three-point percentage, 0-100, string with a decimal comma ('47,6'). |
| fgm | integer | Field goals made, 2PT + 3PT (tiros de campo; integer as a string). |
| fga | integer | Field goals attempted, 2PT + 3PT (integer as a string). |
| fgp | numeric | Field-goal percentage, 0-100, string with a decimal comma ('51,7'). |
| ro | integer | Offensive rebounds (rebotes ofensivos; integer as a string). |
| rd | integer | Defensive rebounds (rebotes defensivos; integer as a string). |
| rt | integer | Total rebounds (rebotes totales; integer as a string). |
| assist | integer | Assists (asistencias; integer as a string). |
| st | integer | Steals (balones robados, page column BR; integer as a string). |
| to | integer | Turnovers (balones perdidos, page column BP; integer as a string). |
| bs | integer | Blocks made (tapones a favor, page column TF; integer as a string). |
| tc | integer | Shots of this team that were blocked (tapones en contra, page column TC). Null on /TeamStats rows. |
| mt | integer | Dunks (mates, page column MT). Null on /TeamStats rows. |
| pf | integer | Personal fouls committed (faltas cometidas, page column FC; integer as a string). |
| rf | integer | Fouls received / drawn (faltas recibidas, page column FR; integer as a string). |
| fouls | integer | Team fouls committed in the game (equals pf on the samples). |
| val | integer | FEB efficiency rating (valoracion). Null on /TeamStats rows, filled on box-score totals. |
| fastb | integer | Fast-break points. Null on every sampled game: the federation's stat crews do not fill it. |
| ptsto | integer | Points off turnovers. Null on every sampled game: the federation's stat crews do not fill it. |
| secpts | integer | Second-chance points. Null on every sampled game: the federation's stat crews do not fill it. |
| bench | integer | Bench points. Null on every sampled game: the federation's stat crews do not fill it. |
| paint | integer | Points in the paint. Null on every sampled game: the federation's stat crews do not fill it. |

## Details

The Spanish Basketball Federation (FEB) wrappers cover Primera FEB,
Segunda FEB and Liga Femenina Endesa (plus the federation's other groups
on the same routes). They mirror sdv-py's
`sportsdataverse.basketball.feb` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per sdv-py
row.

**Legal notice.** The FEB's aviso legal (legal notice) asserts
intellectual-property rights over the site's content and its databases
(the EU database right). It has no explicit scraping clause, and
robots.txt answers 404 on both hosts. Fetching for your own use on your
own machine is how these wrappers are meant to be used; check the notice
before you republish the data.

**Unofficial and unsupported.** The LiveStats API (`intrafeb.feb.es`) is
the federation's own widget backend, not a documented public API. It
needs a bearer token, which is public: it is read from the home page of
`baloncestoenvivo.feb.es` at run time, kept in memory for the R session
(24 h validity, renewed once on an HTTP 401) and never printed, logged
or written. Requests are spaced at least one second apart per host; 429
and 5xx answers are retried (three attempts).

**Coverage.** The game routes answer from 2020-21 (Liga Femenina Endesa
from its first game; Primera FEB from 2021-03-12, so its earlier 2020-21
games and every earlier season answer 404). 2020-21 play-by-play is text
only. The schedule pages go back to 1996-97 (`season = 1997`).

**Seasons** are END years (`season = 2027` is 2026-27); the site's own
`t` key is the START year, so the request sends `t = season - 1`.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (HTTP 404, an unknown group, a schedule page with no
games, an empty overview window), `hoopR_bad_request` (HTTP 400 / 422,
or a `game_id`, `group` or `season` that is not a non-negative integer)
and `hoopR_asset_fetch` (any other failure: another status, a transport
error, a token the API still rejects after one renewal, a non-JSON or
non-HTML body, an error or changed envelope, a play-by-play of another
game, a page for another group or season, or layout drift). All inherit
`hoopR_error`.

## See also

Other FEB:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md)

## Examples

``` r
# \donttest{
  try(feb_team_stats(game_id = 2535725))
#> ── FEB team stats from intrafeb.feb.es ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:38:31 UTC
#> # A tibble: 2 × 39
#>   game_id team_side team_id team              team_code club_code seconds_played
#>     <int> <chr>       <int> <chr>             <chr>     <chr>              <int>
#> 1 2535725 home      1009716 BUENO ARENAS ALB… 02014401  020144                NA
#> 2 2535725 away      1010207 IBEROLEA PALENCIA 34000707  340007                NA
#> # ℹ 32 more variables: min_formatted <chr>, pts <int>, p1m <int>, p1a <int>,
#> #   p1p <dbl>, p2m <int>, p2a <int>, p2p <dbl>, p3m <int>, p3a <int>,
#> #   p3p <dbl>, fgm <int>, fga <int>, fgp <dbl>, ro <int>, rd <int>, rt <int>,
#> #   assist <int>, st <int>, to <int>, bs <int>, tc <int>, mt <int>, pf <int>,
#> #   rf <int>, fouls <int>, val <int>, fastb <int>, ptsto <int>, secpts <int>,
#> #   bench <int>, paint <int>
# }
```
