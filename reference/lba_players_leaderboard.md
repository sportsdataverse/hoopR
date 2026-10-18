# **Get LBA Players Leaderboard**

Season player leaderboard for one category (per-game average).

Endpoint:
`GET https://www.legabasket.it/api/statistics/get-players-statistics`
(`cs_id=1&s=<season>&cat=<category>`)

## Usage

``` r
lba_players_leaderboard(season = NULL, category = "points")
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

- category:

  Category: points, rating_lega, total_rebound, assists, shots_3p_perc,
  ... (the site's filters.categories).

## Value

A `hoopR_data` tibble: Season player leaderboard for one category
(per-game average). The columns are always these, in this order (sdv-py
`lba_players_leaderboard`); a column the site adds later is appended
after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| category | character | Category of this row (the `cat` param, e.g. `points`). |
| player_id | integer | Player id (global, one per career). |
| name | character | Given name (players) / team name (teams). |
| surname | character | Player's family name. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| tv_name | character | Short team name for TV graphics. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| category_filter_total | integer | Season total in the category. |
| attempts | integer | Shots attempted in the zone, parsed from num. |
| presences | integer | Games the player appeared in, counted for the leaderboard. |
| minutes | double | Minutes per game (players: decimal string `28.67`) / total minutes (teams: integer). |
| score_40_min | double | Value per 40 minutes. |
| score | double | Value in the category under the `ob` order (default `avg` = per game); players send a decimal string, teams a number. |
| team_id | integer | Team id (team-season). |
| player_photo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

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
  try(lba_players_leaderboard(season = 2027, category = "points"))
#> ── LBA Players Leaderboard from legabasket.it ────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:59 UTC
#> # A tibble: 50 × 16
#>    season category player_id name     surname team_name            tv_name  year
#>     <int> <chr>        <int> <chr>    <chr>   <chr>                <chr>   <int>
#>  1   2027 points        6191 JP       Macura  Nutribullet Treviso… Nutrib…  2026
#>  2   2027 points        9328 Quincy   Olivari Dolomiti Energia Tr… Dolomi…  2026
#>  3   2027 points        4879 DeWayne  Russell Nutribullet Treviso… Nutrib…  2026
#>  4   2027 points        7079 Kyle     Wiltjer Umana Reyer Venezia  Umana …  2026
#>  5   2027 points        6604 Colbey   Ross    Pallacanestro Tries… Pallac…  2026
#>  6   2027 points        6640 Riccardo Rossato UNA Hotels Reggio E… UNA Ho…  2026
#>  7   2027 points         314 Jaylen   Barford UNA Hotels Reggio E… UNA Ho…  2026
#>  8   2027 points        9334 Hunter   Hale    Openjobmetis Varese  Openjo…  2026
#>  9   2027 points        9302 Raequan  Battle  APU Old Wild West U… APU Ol…  2026
#> 10   2027 points        6138 Niccolò  Mannion BC Roma              BC Roma  2026
#> # ℹ 40 more rows
#> # ℹ 8 more variables: category_filter_total <int>, attempts <int>,
#> #   presences <int>, minutes <dbl>, score_40_min <dbl>, score <dbl>,
#> #   team_id <int>, player_photo_key <chr>
# }
```
