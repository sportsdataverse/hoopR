# **FEB Schedule**

**Full schedule of one group (phase) of a FEB competition season: every
round, game, result and team-season id.**

Endpoint:
`GET https://baloncestoenvivo.feb.es/calendario.aspx?g={group}&t={season - 1}`

Played games carry no date or time on this page: use `round_date` or
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md)'s
`start_time`. The page renders only the FIRST phase of the group
(Segunda FEB shows group A); other phases and the playoffs need an
ASP.NET postback and are not modelled. A page for another group or
season is refused (`hoopR_asset_fetch`), an unknown group is
`hoopR_no_data`.

## Usage

``` r
feb_schedule(group, season)
```

## Arguments

- group:

  (*integer* required): The site's menu group: 1 Primera FEB, 2 Segunda
  FEB, 4 Liga Femenina Endesa, 9 and 10 LF-2, 67 LF Challenge, 73 Copa
  de Espana, 74 Liga U. A group is not a competition id (see `comp_id`).

- season:

  (*integer* required): Season END year (`2027` = 2026-27), sent to the
  site as its START-year key `t = season - 1`.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| group | integer | The site's menu group (1 Primera FEB, 2 Segunda FEB, 4 Liga Femenina Endesa); not a competition id. |
| season | integer | Season END year (2027 = 2026-27), the site's START-year key plus one. |
| competition | character | Competition name on the page header ('PRIMERA FEB'). |
| round | integer | Round number (jornada) the game belongs to. |
| round_label | character | Round heading as printed ('Jornada 4 16/10/2026'). |
| round_date | Date | Date of the round (the heading's date); played games carry no date of their own on this page. |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| home_team_id | integer | Home team-season id (new every season; joins feb_overview and the game wrappers). |
| home_team | character | Home team name, uppercase. |
| away_team_id | integer | Away team-season id (new every season). |
| away_team | character | Away team name, uppercase. |
| result_text | character | Result cell verbatim: 'home-away' points when played; before the game the calendar shows the Spanish weekday, date and time and the results page shows '*-*'. |
| home_score | integer | Home points; null before the game. |
| away_score | integer | Away points; null before the game. |
| status | character | played when the result cell holds a score, scheduled otherwise. |
| weekday | character | English weekday of a scheduled game (translated from the Spanish cell); null for played games. |
| date | Date | Game date; null for played games on the schedule page (use round_date). |
| time | character | Tip-off 'HH:MM', Spanish local time; null for played games on the schedule page. |

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

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_schedule(group = 1, season = 2027))
#> ── FEB schedule from baloncestoenvivo.feb.es ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:14:50 UTC
#> # A tibble: 306 × 18
#>    group season competition round round_label    round_date game_id home_team_id
#>    <int>  <int> <chr>       <int> <chr>          <date>       <int>        <int>
#>  1     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535725      1009716
#>  2     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535726      1008687
#>  3     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535727      1009713
#>  4     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535728      1009110
#>  5     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535729      1009109
#>  6     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535730      1010493
#>  7     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535731      1009095
#>  8     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535732      1008797
#>  9     1   2027 PRIMERA FEB     1 Jornada 1 25/… 2026-09-25 2535733      1009584
#> 10     1   2027 PRIMERA FEB     2 Jornada 2 02/… 2026-10-02 2535734      1009072
#> # ℹ 296 more rows
#> # ℹ 10 more variables: home_team <chr>, away_team_id <int>, away_team <chr>,
#> #   result_text <chr>, home_score <int>, away_score <int>, status <chr>,
#> #   weekday <chr>, date <date>, time <chr>
# }
```
