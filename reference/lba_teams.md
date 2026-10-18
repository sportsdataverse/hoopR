# **Get LBA Teams**

Teams of a season, one row per team-season with the stable club id.

Endpoint: `GET https://www.legabasket.it/api/teams/get-teams`
(`items=50&year=<season>`)

## Usage

``` r
lba_teams(season = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

## Value

A `hoopR_data` tibble: Teams of a season, one row per team-season with
the stable club id. The columns are always these, in this order (sdv-py
`lba_teams`); a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| team_id | integer | Team id (one team-season). |
| name | character | Team name of that season (sponsor name). |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
| logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

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
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_teams(season = 2027))
#> ── LBA Teams from legabasket.it ──────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:43:28 UTC
#> # A tibble: 16 × 8
#>    season team_id name                year club_id club_code updated_at logo_key
#>     <int>   <int> <chr>              <int>   <int> <chr>     <chr>      <chr>   
#>  1   2027    1765 Acqua S.Bernardo …  2026      12 CNT       2026-09-2… YSC9dyn…
#>  2   2027    1771 APU Old Wild West…  2026      57 UD        2026-09-2… PdkXq2W…
#>  3   2027    1751 Armani Olimpia Mi…  2026      28 MIO       2026-07-0… e5xdeyc…
#>  4   2027    1761 BC Roma             2026     246 RMB       2026-09-2… gxrVRq4…
#>  5   2027    1752 Bertram Derthona …  2026     111 BDBT      2026-09-2… LQkDL6W…
#>  6   2027    1763 Dolomiti Energia …  2026     104 TN        2026-09-2… iQJMb4i…
#>  7   2027    1768 Longobardi Scafat…  2026      50 SCF       2026-09-2… jEWc31d…
#>  8   2027    1762 Maxima Roma         2026     247 RMX       2026-09-2… YzevUx1…
#>  9   2027    1772 Napoli Basketball   2026      42 PZZ       2026-08-1… 48PaXiF…
#> 10   2027    1764 Nutribullet Trevi…  2026     107 TVU       2026-09-2… Y6Kc6v8…
#> 11   2027    1766 Openjobmetis Vare…  2026      60 VA        2026-09-2… dvvAgKm…
#> 12   2027    1767 Pallacanestro Tri…  2026     106 TSS       2026-09-2… T5zGJQ7…
#> 13   2027    1769 Tezenis Verona      2026      63 VR        2026-09-2… FCHwHiU…
#> 14   2027    1753 Umana Reyer Venez…  2026      61 VE        2026-07-0… EGx6Svr…
#> 15   2027    1760 UNA Hotels Reggio…  2026      44 RE        2026-09-2… tBq5sA3…
#> 16   2027    1750 Virtus Costa Bolo…  2026       6 BOV       2026-09-1… tcKLhHt…
# }
```
