# **Get LBA Team Box Score**

Team lines of a final game's box score: the team-booked stats and the
totals of each side.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id`
(`info=true&id=<game_id>`)

## Usage

``` r
lba_team_box_score(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble: Team lines of a final game's box score: the
team-booked stats and the totals of each side. The columns are always
these, in this order (sdv-py `lba_team_box_score`); a column the site
adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| side | character | Which team of the game the row belongs to: home or visitor. |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| row_type | character | team = stats booked to the team itself (team rebounds, team turnovers); totals = the whole side. |
| pun | integer | Points (`punti`). (team totals (players + team row)) |
| falli_c | integer | Fouls committed (`falli commessi`). (team totals (players + team row)) |
| falli_sf | integer | Fouls drawn (`falli subiti`). (team totals (players + team row)) |
| falli_tc1 | integer | Technical fouls (`falli tecnici`; reading `tc1` as category-1 technicals is inferred). (team totals (players + team row)) |
| falli_fla | integer | Unsportsmanlike / flagrant fouls (`falli antisportivi`). (team totals (players + team row)) |
| rimbalzi_o | integer | Offensive rebounds (`rimbalzi offensivi`). (team totals (players + team row)) |
| rimbalzi_d | integer | Defensive rebounds (`rimbalzi difensivi`). (team totals (players + team row)) |
| rimbalzi_t | integer | Total rebounds (`rimbalzi totali`). (team totals (players + team row)) |
| palle_p | integer | Turnovers (`palle perse`). (team totals (players + team row)) |
| palle_r | integer | Steals (`palle recuperate`). (team totals (players + team row)) |
| val_lega | integer | LBA efficiency rating (`valutazione Lega`). (team totals (players + team row)) |
| min | integer | Minutes played, whole minutes (`minuti`); 200 in `totals` = 5 x 40. (team totals (players + team row)) |
| sec | integer | Seconds played (`secondi`) = `min` x 60 in every sample. (team totals (players + team row)) |
| t2_r | integer | 2-point field goals made (`tiri da 2 realizzati`). (team totals (players + team row)) |
| t2_t | integer | 2-point field goals attempted (`tiri da 2 tentati`). (team totals (players + team row)) |
| t2_perc | double | 2-point field-goal percentage, 0-100 (number; 0 when no attempt). (team totals (players + team row)) |
| sc | integer | Dunks (`schiacciate`). (team totals (players + team row)) |
| t3_r | integer | 3-point field goals made. (team totals (players + team row)) |
| t3_t | integer | 3-point field goals attempted. (team totals (players + team row)) |
| t3_perc | double | 3-point field-goal percentage, 0-100. (team totals (players + team row)) |
| tl_r | integer | Free throws made (`tiri liberi realizzati`). (team totals (players + team row)) |
| tl_t | integer | Free throws attempted (`tiri liberi tentati`). (team totals (players + team row)) |
| tl_perc | double | Free-throw percentage, 0-100. (team totals (players + team row)) |
| stoppate_dat | integer | Blocks (`stoppate date`). (team totals (players + team row)) |
| stoppate_sub | integer | Own shots blocked (`stoppate subite`). (team totals (players + team row)) |
| ass | integer | Assists. (team totals (players + team row)) |
| val_oer | double | OER = points / (FGA + turnovers + FTA / 2); verified on every 2026-27 sample row. (team totals (players + team row)) |

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
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_team_box_score(game_id = 25602))
#> ── LBA Team Box Score from legabasket.it ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:19:10 UTC
#> # A tibble: 4 × 32
#>   game_id season side    team_id row_type   pun falli_c falli_sf falli_tc1
#>     <int>  <int> <chr>     <int> <chr>    <int>   <int>    <int>     <int>
#> 1   25602   2027 home       1764 team         0       0        0         0
#> 2   25602   2027 home       1764 totals     109      21       27         0
#> 3   25602   2027 visitor    1761 team         0       0        0         0
#> 4   25602   2027 visitor    1761 totals      94      27       21         0
#> # ℹ 23 more variables: falli_fla <int>, rimbalzi_o <int>, rimbalzi_d <int>,
#> #   rimbalzi_t <int>, palle_p <int>, palle_r <int>, val_lega <int>, min <int>,
#> #   sec <int>, t2_r <int>, t2_t <int>, t2_perc <dbl>, sc <int>, t3_r <int>,
#> #   t3_t <int>, t3_perc <dbl>, tl_r <int>, tl_t <int>, tl_perc <dbl>,
#> #   stoppate_dat <int>, stoppate_sub <int>, ass <int>, val_oer <dbl>
# }
```
