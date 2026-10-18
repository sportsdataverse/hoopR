# **FEB Game Leaders**

**Each team's top players of one FEB game by points, rebounds, assists
and fouls.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/Ranking/{game_id}`

One row per team, category and ranked player (`rank` 1 = the leader, in
the order the feed lists them).

## Usage

``` r
feb_leaders(game_id)
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
| category | character | Leader category: points, rebounds, assists or fouls (the feed's Puntos, Rebotes, Asistencias, Faltas). |
| rank | integer | Place in the team's category list, 1 = the leader, in the order the feed lists them. |
| player_id | integer | FEB person id: stable across seasons and clubs (A. Jorda Rodriguez = 1676991 in 2025-26 and 2026-27). Joins the box score, play-by-play, shots and leaders; not the per-season licence_id. |
| shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
| player | character | Player name as 'I. SURNAME(S)', uppercase ('V. AGUILAR HERNANDEZ'). |
| starter | logical | True when the player was in the starting five (the page's I column), false when on the bench. |
| captain | logical | True for the team captain. Null on 2020-21 games, where the feed does not send it. |
| value | integer | The player's count in the row's category (points, rebounds, assists or personal fouls). |

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
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_leaders(game_id = 2535725))
#> ── FEB leaders from intrafeb.feb.es ──────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:38:22 UTC
#> # A tibble: 24 × 12
#>    game_id team_side team_id team   category  rank player_id shirt_number player
#>      <int> <chr>       <int> <chr>  <chr>    <int>     <int> <chr>        <chr> 
#>  1 2535725 home      1009716 BUENO… points       1   1603635 11           J. GO…
#>  2 2535725 home      1009716 BUENO… points       2   2813013 5            N. RE…
#>  3 2535725 home      1009716 BUENO… points       3   2880241 6            J. ZE…
#>  4 2535725 home      1009716 BUENO… rebounds     1   2880232 16           A. MA…
#>  5 2535725 home      1009716 BUENO… rebounds     2   2432962 10           S. ME…
#>  6 2535725 home      1009716 BUENO… rebounds     3   1981843 44           B. VA…
#>  7 2535725 home      1009716 BUENO… assists      1   2432962 10           S. ME…
#>  8 2535725 home      1009716 BUENO… assists      2   1371559 3            V. AG…
#>  9 2535725 home      1009716 BUENO… assists      3   2813013 5            N. RE…
#> 10 2535725 home      1009716 BUENO… fouls        1   2813013 5            N. RE…
#> # ℹ 14 more rows
#> # ℹ 3 more variables: starter <lgl>, captain <lgl>, value <int>
# }
```
