# **Get LBA Championships**

Championships of a season, one per phase (Regular Season, Play Off);
every season when none is given.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships`
(`cs_id=1&items=1000&s=<season>`)

## Usage

``` r
lba_championships(season = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = every season (310
  championships).

## Value

A `hoopR_data` tibble: Championships of a season, one per phase (Regular
Season, Play Off); every season when none is given. The columns are
always these, in this order (sportsdataverse-py `lba_championships`); a
column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| championship_id | integer | Championship id (one season and phase). |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| name | character | Championship name, e.g. `Regular Season A`, `Play Off A1`. |
| status | integer | Championship status: 1 = in progress, 2 = finished (inferred from the 2026-27 and past samples). |
| championship_type_id | integer | Phase type id: 4 = Regular Season, 2 = Play Off. |
| championship_series_id | integer | Series id, 1 = Serie A. |
| full_name | character | Name with the season, e.g. `Regular Season A 2017`. |
| focus_on | logical | Highlighted on the site. |
| ctype_code | character | Phase type code: `RS` / `PO`. |
| ctype_name | character | Phase type name, as sent in English: `Regular Season`, `Play Off`. |
| cserie_code | character | Series code, `A1` = Serie A. |
| cserie_name | character | Name of the championship series, e.g. Serie A. |
| logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

## Details

- Unofficial and unsupported: these wrappers read the JSON API that the
  Next.js site www.legabasket.it itself calls. Legal notice: the site's
  terms say "Non e' consentito copiare ... dati e informazioni senza
  autorizzazione scritta" (copying data and information without written
  authorisation is not allowed), except for personal, non-commercial
  use. Use the data accordingly, and check the terms before you
  republish it.

- robots.txt allows /api and sets Crawl-delay: 2. The runtime waits 2 s
  before every request, retries included. Crawl incrementally: fetch a
  final game once (keyed by game_id), find new games with one
  lba_calendar call per round, and do not backfill a history in a burst.

- Seasons are END years (2027 = 2026-27); the site sends START years and
  the runtime maps them (season - 1 on the wire). Game and player ids
  are global; team ids are re-issued every season (join lba_teams for
  the stable club_id); a championship id is one season AND one phase
  (Regular Season and Play Off differ).

- Play-by-play starts in 2017-18 and changes shape in 2019-20 (pixel
  frame to court percent) and 2021-22; see lba_pbp. Box scores reach
  back to 1995-96, where the period scores were not recorded (0 means
  missing).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or a body with no rows: an unknown season,
  a play-by-play before 2017-18, standings of a finished championship
  without a round), `hoopR_bad_request` (a season that is not an END
  year, a bad choice, HTTP 400 / 422) and `hoopR_asset_fetch` (any other
  non-2xx, a connection failure after retries, an empty / non-JSON /
  error-shaped 200, a game that is not final on the box score,
  play-by-play and shot routes, a truncated page, or a body for another
  season, championship, game, team, player, round or category than the
  one asked for). An unknown id is HTTP 500, which is not retried. A
  body the parser finds no rows in gives a zero-row tibble with these
  columns.

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_player_stats()`](https://hoopR.sportsdataverse.org/reference/lba_player_stats.md),
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_championships(season = 2027))
#> ── LBA Championships from legabasket.it ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:31:33 UTC
#> # A tibble: 1 × 14
#>   season championship_id  year name                  status championship_type_id
#>    <int>           <int> <int> <chr>                  <int>                <int>
#> 1   2027             602  2026 Regular Season 2026/…      1                    4
#> # ℹ 8 more variables: championship_series_id <int>, full_name <chr>,
#> #   focus_on <lgl>, ctype_code <chr>, ctype_name <chr>, cserie_code <chr>,
#> #   cserie_name <chr>, logo_key <chr>
# }
```
