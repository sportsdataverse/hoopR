# **Get LBA Player**

Player bio with current-season totals, highs and averages (one row).

Endpoint: `GET https://www.legabasket.it/api/players/get-player-by-id`
(`stats=1&id=<player_id>`)

## Usage

``` r
lba_player(player_id)
```

## Arguments

- player_id:

  (required) Player id (player_id in lba_players or a box score),
  e.g. 969. Global: one id for a whole career.

## Value

A `hoopR_data` tibble: Player bio with current-season totals, highs and
averages (one row). The columns are always these, in this order (sdv-py
`lba_player`); a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Player id (global). |
| code | character | Player code `SURNAME3-NAME3-YY`. |
| name | character | Player's given name. |
| surname | character | Player's family name. |
| place_of_birth | character | Birthplace (Italian spelling). |
| birth_date | character | Birth date, Date `YYYY-MM-DD`. |
| updated_at | character | Timestamp, ISO-8601 with the Italian offset. |
| ext_code | character | External (data feed) player code; equals `code` in the samples. |
| seo_meta_title | character | SEO title (null in the samples). |
| seo_meta_description | character | SEO description (null in the samples). |
| photo_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| fullbody_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). Null in every sample. |
| start_date | character | Contract start with the team, Date `YYYY-MM-DD`. |
| end_date | character | Contract end with the team, Date `YYYY-MM-DD`. |
| player_number | character | Jersey number, number sent as a string. |
| uefa_ratio | character | Eligibility class for the foreign-player quota: `I`, `E` or `C` (7 / 6 / 1 on the Treviso roster; reading as Italian / EU / non-EU is inferred). |
| height | integer | Player's height in centimetres. |
| weight | integer | Player's weight in kilograms. |
| team_id | integer | Team id (team-season) of his current team. |
| player_role_description | character | Position, Italian (see `players[].player_role` of the roster route). |
| player_alpha3 | character | Nationality, ISO alpha-3. |
| player_country_name | character | Nationality, Italian country name (`Italia` = Italy); map to English through `player_alpha3` (ISO 3166 alpha-3), not by translating the name. |
| player_country | character | Continent, Italian name (`Europa` = Europe; the other values are presumably `Africa`, `America`, `Asia`, `Oceania`, unobserved). |
| team_code | character | `<season>\|<team code>` of his current team (`2026\|TVU`). |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. The season of the team the row places the player on. |
| team_logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| stats_played_matches | integer | Games played this regular season. |
| stats_totals_highs_rs_player_id | integer | Player id (global, one per career). |
| stats_totals_highs_rs_championship_serie_code | character | Series code, `A1` = Serie A. |
| stats_totals_highs_rs_quintet_sum | integer | Current regular-season total of starts (in the starting five). |
| stats_totals_highs_rs_points_sum | integer | Current regular-season total of points. |
| stats_totals_highs_rs_played_minutes_sum | integer | Current regular-season total of minutes played. |
| stats_totals_highs_rs_played_matches_sum | integer | Current regular-season total of games played. |
| stats_totals_highs_rs_total_matches_sum | integer | Current regular-season total of team games while the player was listed (a player with 3 of 21 shows 21; inferred). |
| stats_totals_highs_rs_done_fouls_sum | integer | Current regular-season total of fouls committed. |
| stats_totals_highs_rs_suffered_fouls_sum | integer | Current regular-season total of fouls drawn. |
| stats_totals_highs_rs_shots_2p_realized_sum | integer | Current regular-season total of 2-point field goals made. |
| stats_totals_highs_rs_shots_2p_total_sum | integer | Current regular-season total of 2-point field goals attempted. |
| stats_totals_highs_rs_slam_dunk_sum | integer | Current regular-season total of dunks. |
| stats_totals_highs_rs_shots_3p_realized_sum | integer | Current regular-season total of 3-point field goals made. |
| stats_totals_highs_rs_shots_3p_total_sum | integer | Current regular-season total of 3-point field goals attempted. |
| stats_totals_highs_rs_free_throws_realized_sum | integer | Current regular-season total of free throws made. |
| stats_totals_highs_rs_free_throws_total_sum | integer | Current regular-season total of free throws attempted. |
| stats_totals_highs_rs_offensive_rebound_sum | integer | Current regular-season total of offensive rebounds. |
| stats_totals_highs_rs_defensive_rebound_sum | integer | Current regular-season total of defensive rebounds. |
| stats_totals_highs_rs_ball_stop_given_sum | integer | Current regular-season total of blocks. |
| stats_totals_highs_rs_ball_stop_received_sum | integer | Current regular-season total of own shots blocked. |
| stats_totals_highs_rs_lost_balls_sum | integer | Current regular-season total of turnovers. |
| stats_totals_highs_rs_regain_balls_sum | integer | Current regular-season total of steals. |
| stats_totals_highs_rs_assists_sum | integer | Current regular-season total of assists. |
| stats_totals_highs_rs_rating_lega_sum | integer | Current regular-season total of LBA efficiency rating (`valutazione`). |
| stats_totals_highs_rs_rating_oer_sum | double | OER over the regular season (1.04 for 3 games: an average despite `_sum`; inferred). |
| stats_totals_highs_rs_avg_points_sum | integer | Current regular-season total of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`). |
| stats_totals_highs_rs_quintet_max | integer | Current regular-season single-game high of starts (in the starting five). |
| stats_totals_highs_rs_points_max | integer | Current regular-season single-game high of points. |
| stats_totals_highs_rs_played_minutes_max | integer | Current regular-season single-game high of minutes played. |
| stats_totals_highs_rs_done_fouls_max | integer | Current regular-season single-game high of fouls committed. |
| stats_totals_highs_rs_suffered_fouls_max | integer | Current regular-season single-game high of fouls drawn. |
| stats_totals_highs_rs_shots_2p_realized_max | integer | Current regular-season single-game high of 2-point field goals made. |
| stats_totals_highs_rs_shots_2p_total_max | integer | Current regular-season single-game high of 2-point field goals attempted. |
| stats_totals_highs_rs_shots_2p_perc_max | integer | Current regular-season single-game high of 2-point field-goal percentage, 0-100. |
| stats_totals_highs_rs_slam_dunk_max | integer | Current regular-season single-game high of dunks. |
| stats_totals_highs_rs_shots_3p_realized_max | integer | Current regular-season single-game high of 3-point field goals made. |
| stats_totals_highs_rs_shots_3p_total_max | integer | Current regular-season single-game high of 3-point field goals attempted. |
| stats_totals_highs_rs_shots_3p_perc_max | integer | Current regular-season single-game high of 3-point field-goal percentage, 0-100. |
| stats_totals_highs_rs_free_throws_realized_max | integer | Current regular-season single-game high of free throws made. |
| stats_totals_highs_rs_free_throws_total_max | integer | Current regular-season single-game high of free throws attempted. |
| stats_totals_highs_rs_free_throws_perc_max | integer | Current regular-season single-game high of free-throw percentage, 0-100. |
| stats_totals_highs_rs_offensive_rebound_max | integer | Current regular-season single-game high of offensive rebounds. |
| stats_totals_highs_rs_defensive_rebound_max | integer | Current regular-season single-game high of defensive rebounds. |
| stats_totals_highs_rs_total_rebounds_max | integer | Current regular-season single-game high of total rebounds. |
| stats_totals_highs_rs_ball_stop_given_max | integer | Current regular-season single-game high of blocks. |
| stats_totals_highs_rs_ball_stop_received_max | integer | Current regular-season single-game high of own shots blocked. |
| stats_totals_highs_rs_lost_balls_max | integer | Current regular-season single-game high of turnovers. |
| stats_totals_highs_rs_regain_balls_max | integer | Current regular-season single-game high of steals. |
| stats_totals_highs_rs_assists_max | integer | Current regular-season single-game high of assists. |
| stats_totals_highs_rs_rating_lega_max | integer | Current regular-season single-game high of LBA efficiency rating (`valutazione`). |
| stats_totals_highs_rs_rating_oer_max | double | Current regular-season single-game high of OER (points / (FGA + turnovers + FTA / 2)). |
| stats_totals_highs_rs_avg_points_max | integer | Current regular-season single-game high of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`). |
| stats_totals_highs_rs_adp_max | integer | Current regular-season single-game high of plus-minus (as `match_adp`). |
| stats_totals_highs_rs_id | integer | Always null (not a key). |
| stats_avg_rs_player_id | integer | Player id (global, one per career). |
| stats_avg_rs_championship_serie_code | character | Series code, `A1` = Serie A. |
| stats_avg_rs_quintet_avg | double | Current regular-season per-game average of starts (in the starting five), number sent as a string. |
| stats_avg_rs_points_avg | double | Current regular-season per-game average of points, number sent as a string. |
| stats_avg_rs_played_minutes_avg | double | Current regular-season per-game average of minutes played, number sent as a string. |
| stats_avg_rs_played_matches_avg | double | Always `1.0` (games divided by games), number sent as a string. |
| stats_avg_rs_total_matches_avg | double | Always `1.0`, number sent as a string. |
| stats_avg_rs_done_fouls_avg | double | Current regular-season per-game average of fouls committed, number sent as a string. |
| stats_avg_rs_suffered_fouls_avg | double | Current regular-season per-game average of fouls drawn, number sent as a string. |
| stats_avg_rs_shots_2p_realized_avg | double | Current regular-season per-game average of 2-point field goals made, number sent as a string. |
| stats_avg_rs_shots_2p_total_avg | double | Current regular-season per-game average of 2-point field goals attempted, number sent as a string. |
| stats_avg_rs_slam_dunk_avg | double | Current regular-season per-game average of dunks, number sent as a string. |
| stats_avg_rs_shots_3p_realized_avg | double | Current regular-season per-game average of 3-point field goals made, number sent as a string. |
| stats_avg_rs_shots_3p_total_avg | double | Current regular-season per-game average of 3-point field goals attempted, number sent as a string. |
| stats_avg_rs_free_throws_realized_avg | double | Current regular-season per-game average of free throws made, number sent as a string. |
| stats_avg_rs_free_throws_total_avg | double | Current regular-season per-game average of free throws attempted, number sent as a string. |
| stats_avg_rs_offensive_rebound_avg | double | Current regular-season per-game average of offensive rebounds, number sent as a string. |
| stats_avg_rs_defensive_rebound_avg | double | Current regular-season per-game average of defensive rebounds, number sent as a string. |
| stats_avg_rs_ball_stop_given_avg | double | Current regular-season per-game average of blocks, number sent as a string. |
| stats_avg_rs_ball_stop_received_avg | double | Current regular-season per-game average of own shots blocked, number sent as a string. |
| stats_avg_rs_lost_balls_avg | double | Current regular-season per-game average of turnovers, number sent as a string. |
| stats_avg_rs_regain_balls_avg | double | Current regular-season per-game average of steals, number sent as a string. |
| stats_avg_rs_assists_avg | double | Current regular-season per-game average of assists, number sent as a string. |
| stats_avg_rs_rating_lega_avg | double | Current regular-season per-game average of LBA efficiency rating (`valutazione`), number sent as a string. |
| stats_avg_rs_rating_oer_avg | double | Per-game average OER (a number, unlike the other `_avg` values). |
| stats_avg_rs_avg_points_avg | double | Current regular-season per-game average of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`), number sent as a string. |
| stats_avg_rs_id | integer | Always null (not a key). |

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
  try(lba_player(player_id = 969))
#> ── LBA Player from legabasket.it ─────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:55 UTC
#> # A tibble: 1 × 109
#>   player_id code     name  surname place_of_birth birth_date updated_at ext_code
#>       <int> <chr>    <chr> <chr>   <chr>          <chr>      <chr>      <chr>   
#> 1       969 CAP-ALE… Ales… Cappel… Assisi         1995-10-22 2022-10-2… CAP-ALE…
#> # ℹ 101 more variables: seo_meta_title <chr>, seo_meta_description <chr>,
#> #   photo_picture_key <chr>, fullbody_picture_key <chr>, start_date <chr>,
#> #   end_date <chr>, player_number <chr>, uefa_ratio <chr>, height <int>,
#> #   weight <int>, team_id <int>, player_role_description <chr>,
#> #   player_alpha3 <chr>, player_country_name <chr>, player_country <chr>,
#> #   team_code <chr>, team_name <chr>, year <int>, team_logo_key <chr>,
#> #   stats_played_matches <int>, stats_totals_highs_rs_player_id <int>, …
# }
```
