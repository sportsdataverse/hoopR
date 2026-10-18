# **Get LBA Roster Coach**

Head coach of one team-season.

Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster`
(`id=<team_id>`)

## Usage

``` r
lba_roster_coach(team_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

## Value

A `hoopR_data` tibble: Head coach of one team-season. The columns are
always these, in this order (sdv-py `lba_roster_coach`); a column the
site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| coach_id | integer | Coach id (global coach key space; joins the game header `home_coach_id` / `visitor_coach_id`). |
| name | character | Coach's given name. |
| surname | character | Coach's family name. |
| birth_date | character | Birth date, Date `YYYY-MM-DD`. |
| place_of_birth | character | Birthplace (Italian spelling, e.g. `Londra`). |
| coach_type_id | integer | Coach role id (1 = head coach). |
| coach_type_description | character | Coach role, Italian: `Allenatore` = head coach. |
| coach_type_code | character | Coach role code, number sent as a string. |
| team_name | character | Team, short name. |
| coach_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

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
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_roster_coach(team_id = 1764))
#> ── LBA Roster Coach from legabasket.it ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:43:14 UTC
#> # A tibble: 1 × 15
#>   team_id club_id club_code season coach_id name    surname birth_date
#>     <int>   <int> <chr>      <int>    <int> <chr>   <chr>   <chr>     
#> 1    1764     107 TVU         2027      339 Marcelo Nicola  1971-05-12
#> # ℹ 7 more variables: place_of_birth <chr>, coach_type_id <int>,
#> #   coach_type_description <chr>, coach_type_code <chr>, team_name <chr>,
#> #   coach_picture_key <chr>, team_logo_key <chr>
# }
```
