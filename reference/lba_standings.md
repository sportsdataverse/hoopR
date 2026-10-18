# **Get LBA Standings**

Standings of a championship after a round, one row per team.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championship-ranking`
(`id=<championship_id>&d=<round>`)

## Usage

``` r
lba_standings(championship_id, round = NULL)
```

## Arguments

- championship_id:

  (required) Championship id (championship_id in lba_championships; a
  Regular Season id carries standings).

- round:

  Standings after this round. Required in practice for a finished
  championship: without it the site sends none (NoDataError).

## Value

A `hoopR_data` tibble: Standings of a championship after a round, one
row per team. The columns are always these, in this order (sdv-py
`lba_standings`); a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| standing_id | integer | Standings row id (one team after one round; joins nothing else). |
| championships_day_id | integer | Round id the standings are after. |
| team_id | integer | Team id (team-season). |
| position | integer | Rank in the standings. |
| wins | integer | Games the team has won through the round. |
| defeats | integer | Games the team has lost through the round. |
| points_made | integer | Points the team has scored through the round. |
| points_suffered | integer | Points allowed. |
| qp | integer | Tie-break quotient (`quoziente punti`?); 1 in the samples (unverified). |
| lv | character | Null in every sample (meaning unverified). |
| lp | character | Null in every sample (meaning unverified). |
| lpf | character | Null in every sample (meaning unverified). |
| lps | character | Null in every sample (meaning unverified). |
| lqp | character | Null in every sample (meaning unverified). |
| updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
| points | integer | Standings points (2 per win). |
| penalty_points | integer | Points deducted (0 or null). |
| game_played | integer | Games the team has played through the round. |
| home_game_played | integer | Home games played. |
| home_wins | integer | Home games won. |
| home_defeats | integer | Home games the team has lost through the round. |
| away_game_played | integer | Away games played. |
| away_wins | integer | Away games won. |
| away_defeats | integer | Away games the team has lost through the round. |
| avg_points_made | double | Points scored per game. |
| avg_points_suffered | double | Points allowed per game. |
| home_points_made | integer | Points scored at home. |
| home_points_suffered | integer | Points allowed at home. |
| home_avg_points_made | double | Points scored per home game. |
| home_avg_points_suffered | double | Points allowed per home game. |
| away_points_made | integer | Points scored away. |
| away_points_suffered | integer | Points allowed away. |
| away_avg_points_made | double | Points scored per away game. |
| away_avg_points_suffered | double | Points allowed per away game. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| ties | integer | Ties (0 or null; basketball has none). |
| home_ties | integer | Home ties (null). |
| away_ties | integer | Away ties (null). |
| play_off_qualified | logical | Clinched a play-off place (null in old seasons). |
| relegation | logical | Relegated (null in old seasons). |
| movement | character | Position change since the previous round, signed string (`+2`, `-1`; null for finished seasons). |
| wins_percent | double | Win percentage as a string with `%` (`100%`). |
| home_wins_percent | double | Home win percentage, string with `%`. |
| away_wins_percent | double | Away win percentage, string with `%`. |
| max_points_made | integer | Most points scored in a game. |
| home_max_points_made | integer | Most points scored in a home game. |
| away_max_points_made | integer | Most points scored in an away game. |
| day_code | integer | Round code the standings are after (integer). |
| day_name | character | Round name, Italian (`4a Giornata - 2o fase` = matchday 4 of the 2nd phase). |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| ctp | integer | Classification marker; 0 or null in the samples (unverified). |
| ctp_symbol | character | Null in every sample (meaning unverified). |
| ctp_description | character | Null in every sample (meaning unverified). |
| season_start_year | integer | The wire season field: the season START year (2026 = 2026-27), same as year. |

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
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_standings(championship_id = 602, round = 3))
#> ── LBA Standings from legabasket.it ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:29:00 UTC
#> # A tibble: 16 × 57
#>    season standing_id championships_day_id team_id position  wins defeats
#>     <int>       <int>                <int>   <int>    <int> <int>   <int>
#>  1   2027       44970                 4488    1772        1     3       0
#>  2   2027       44968                 4488    1750        2     3       0
#>  3   2027       44975                 4488    1769        3     2       1
#>  4   2027       44978                 4488    1751        4     2       1
#>  5   2027       44972                 4488    1764        5     2       1
#>  6   2027       44976                 4488    1763        6     2       1
#>  7   2027       44971                 4488    1753        7     2       1
#>  8   2027       44977                 4488    1766        8     2       1
#>  9   2027       44969                 4488    1771        9     2       1
#> 10   2027       44980                 4488    1760       10     1       2
#> 11   2027       44982                 4488    1762       11     1       2
#> 12   2027       44973                 4488    1761       12     1       2
#> 13   2027       44974                 4488    1752       13     1       2
#> 14   2027       44979                 4488    1767       14     0       3
#> 15   2027       44981                 4488    1765       15     0       3
#> 16   2027       44983                 4488    1768       16     0       3
#> # ℹ 50 more variables: points_made <int>, points_suffered <int>, qp <int>,
#> #   lv <chr>, lp <chr>, lpf <chr>, lps <chr>, lqp <chr>, updated_at <chr>,
#> #   points <int>, penalty_points <int>, game_played <int>,
#> #   home_game_played <int>, home_wins <int>, home_defeats <int>,
#> #   away_game_played <int>, away_wins <int>, away_defeats <int>,
#> #   avg_points_made <dbl>, avg_points_suffered <dbl>, home_points_made <int>,
#> #   home_points_suffered <int>, home_avg_points_made <dbl>, …
# }
```
