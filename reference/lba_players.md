# **Get LBA Players**

Players of a season, 50 per page (walk the pages with page).

Endpoint: `GET https://www.legabasket.it/api/players/get-players`
(`items=50&year=<season>&page=<page>`)

## Usage

``` r
lba_players(season = NULL, page = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

- page:

  Page number, 1-based. Omitted = the first page.

## Value

A `hoopR_data` tibble: Players of a season, 50 per page (walk the pages
with page). The columns are always these, in this order (sdv-py
`lba_players`); a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| player_id | integer | Player id (global). |
| name | character | Player's given name. |
| surname | character | Player's family name. |
| code | character | Player code `SURNAME3-NAME3-YY`. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. The season of the team the row places the player on. |
| player_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

## Details

- Unofficial and unsupported: these wrappers read the JSON API that the
  Next.js site www.legabasket.it itself calls. Legal notice: the site's
  terms say "Non e' consentito copiare ... dati e informazioni senza
  autorizzazione scritta" (copying data and information without written
  authorisation is not allowed), except for personal, non-commercial
  use. The owner accepted the restriction for this intake on 2026-10-12.
  Payloads are not redistributed as release assets, and any published
  data release of this source needs separate sign-off.

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
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_player_stats()`](https://hoopR.sportsdataverse.org/reference/lba_player_stats.md),
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
  try(lba_players(season = 2027))
#> ── LBA Players from legabasket.it ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:39:31 UTC
#> # A tibble: 50 × 8
#>    season player_id name     surname    code  team_name  year player_picture_key
#>     <int>     <int> <chr>    <chr>      <chr> <chr>     <int> <chr>             
#>  1   2027        45 Nicola   Akele      AKE-… Armani O…  2026 sgwgsNL364vhCY9a8…
#>  2   2027        75 Amar     Alibegovic ALI-… Bertram …  2026 pZpWxP6Z5UPXzXW79…
#>  3   2027        76 Mirza    Alibegovic ALI-… Maxima R…  2026 Cx9Jyg8zFa2WqE3fF…
#>  4   2027      9332 Gregorio Allinei    ALL-… Nutribul…  2026 vcEjLiSLXW6H3CKuN…
#>  5   2027      9004 Derrick  Alston     ALS-… Virtus C…  2026 aX7pjgftNWGb3T3gG…
#>  6   2027        97 Davide   Alviti     ALV-… Openjobm…  2026 CchJHtkhZVSmQAXmh…
#>  7   2027       106 Lorenzo  Ambrosin   AMB-… Tezenis …  2026 8dQgaTER6wxGYUrXM…
#>  8   2027      9341 Andrew   Andrews    AND-… Tezenis …  2026 mFs7xD6hFHPQfxx6i…
#>  9   2027      9042 Ike      Anigbogu   ANI-… Nutribul…  2026 eNePF3FEwau1vBLPU…
#> 10   2027      9380 Gerald   Ayayi      AYA-… BC Roma    2026 wdm9w7UexGb9zaSL8…
#> # ℹ 40 more rows
# }
```
