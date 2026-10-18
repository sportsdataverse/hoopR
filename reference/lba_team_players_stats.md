# **Get LBA Team Players Stats**

Season totals of each player of a team-season.

Endpoint:
`GET https://www.legabasket.it/api/teams/get-team-players-stats`
(`cs_id=1&id=<team_id>&s=<season>`)

## Usage

``` r
lba_team_players_stats(team_id, season = NULL)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

- season:

  Season END year (2027 = 2026-27) of the team id. Omitted = the site's
  default (unverified).

## Value

A `hoopR_data` tibble: Season totals of each player of a team-season.
The columns are always these, in this order (sdv-py
`lba_team_players_stats`); a column the site adds later is appended
after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| player_id | integer | Player id (global, one per career). |
| player_name | character | Player's given name. |
| player_surname | character | Player's family name. |
| player_season | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| player_photo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| played_matches | integer | Games the player appeared in, in the request's championship series. |
| total_matches | integer | Team games while the player was listed (inferred). |
| start_formation | integer | Games the player started, in the request's championship series. |
| points_sum | integer | Season total of points. |
| played_minutes_sum | integer | Season total of minutes played. |
| rating_lega_sum | integer | Season total of LBA efficiency rating (`valutazione`). |
| rating_oer_sum | double | Sum of the per-game OER values (3.34 over 3 games), not a season OER. |
| offensive_rebound_sum | integer | Season total of offensive rebounds. |
| defensive_rebound_sum | integer | Season total of defensive rebounds. |
| total_rebound_sum | integer | Season total of total rebounds. |
| assists_sum | integer | Season total of assists. |
| regain_balls_sum | integer | Season total of steals. |
| lost_balls_sum | integer | Season total of turnovers. |
| ball_stop_given_sum | integer | Season total of blocks. |
| ball_stop_received_sum | integer | Season total of own shots blocked. |
| done_fouls_sum | integer | Season total of fouls committed. |
| suffered_fouls_sum | integer | Season total of fouls drawn. |
| plus_minus_sum | integer | Season total of plus-minus. |
| aplus_dp_sum | integer | Season total of `aplus_dp`, an unverified metric (not plus-minus or assists: Macura 2026-27 has 9 against plus-minus 8 and 3 assists). |
| slam_dunk_sum | integer | Season total of dunks. |
| shots_2p_realized_sum | integer | Season total of 2-point field goals made. |
| shots_2p_total_sum | integer | Season total of 2-point field goals attempted. |
| shots_2p_perc_sum | double | Season 2-point percentage, 0-100 (a rate despite `_sum`). |
| shots_3p_realized_sum | integer | Season total of 3-point field goals made. |
| shots_3p_total_sum | integer | Season total of 3-point field goals attempted. |
| shots_3p_perc_sum | double | Season 3-point percentage, 0-100 (a rate despite `_sum`). |
| free_throws_realized_sum | integer | Season total of free throws made. |
| free_throws_total_sum | integer | Season total of free throws attempted. |
| free_throws_perc_sum | double | Season free-throw percentage, 0-100 (a rate despite `_sum`). |

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
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_team_players_stats(team_id = 1764, season = 2027))
#> ── LBA Team Players Stats from legabasket.it ─────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:43:21 UTC
#> # A tibble: 12 × 38
#>    team_id club_id club_code season player_id player_name player_surname
#>      <int>   <int> <chr>      <int>     <int> <chr>       <chr>         
#>  1    1764     107 TVU         2027      6191 JP          Macura        
#>  2    1764     107 TVU         2027      4879 DeWayne     Russell       
#>  3    1764     107 TVU         2027       969 Alessandro  Cappelletti   
#>  4    1764     107 TVU         2027      9333 Valentine   Chery         
#>  5    1764     107 TVU         2027      9042 Ike         Anigbogu      
#>  6    1764     107 TVU         2027      9041 Brekkott    Chapman       
#>  7    1764     107 TVU         2027      9331 Chico       Carter        
#>  8    1764     107 TVU         2027      1189 Matteo      Chillo        
#>  9    1764     107 TVU         2027      3714 Federico    Miaschi       
#> 10    1764     107 TVU         2027      7607 Antonio     Iaquinta      
#> 11    1764     107 TVU         2027      7566 Alessandro  Manfredotti   
#> 12    1764     107 TVU         2027      9332 Gregorio    Allinei       
#> # ℹ 31 more variables: player_season <int>, player_photo_key <chr>,
#> #   played_matches <int>, total_matches <int>, start_formation <int>,
#> #   points_sum <int>, played_minutes_sum <int>, rating_lega_sum <int>,
#> #   rating_oer_sum <dbl>, offensive_rebound_sum <int>,
#> #   defensive_rebound_sum <int>, total_rebound_sum <int>, assists_sum <int>,
#> #   regain_balls_sum <int>, lost_balls_sum <int>, ball_stop_given_sum <int>,
#> #   ball_stop_received_sum <int>, done_fouls_sum <int>, …
# }
```
