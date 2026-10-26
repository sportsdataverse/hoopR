# **Get LBA Box Score**

Box score of a final game: one row per player of both teams
(Italian-named stat columns).

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id`
(`info=true&id=<game_id>`)

## Usage

``` r
lba_box_score(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble: Box score of a final game: one row per player of
both teams (Italian-named stat columns). The columns are always these,
in this order (sdv-py `lba_box_score`); a column the site adds later is
appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| side | character | Which team of the game the row belongs to: home or visitor. |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| player_id | integer | Player id (global). |
| player_num | integer | Jersey number the player wore in the game. |
| player_surname | character | Family name, upper case. |
| player_name | character | Player's given name. |
| player_code | character | Player code `SURNAME3-NAME3-YY`. |
| player_p_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| pun | integer | Points (`punti`). |
| min | integer | Minutes played, whole minutes (`minuti`); 200 in `totals` = 5 x 40. |
| sec | integer | Seconds played (`secondi`) = `min` x 60 in every sample. |
| sf | character | Starter flag (`starting five`), number sent as a string: `1` = started. |
| falli_c | integer | Fouls committed (`falli commessi`). |
| falli_sf | integer | Fouls drawn (`falli subiti`). |
| falli_tc1 | integer | Technical fouls (`falli tecnici`; reading `tc1` as category-1 technicals is inferred). |
| falli_fla | integer | Unsportsmanlike / flagrant fouls (`falli antisportivi`). |
| t2_r | integer | 2-point field goals made (`tiri da 2 realizzati`). |
| t2_t | integer | 2-point field goals attempted (`tiri da 2 tentati`). |
| t2_perc | double | 2-point field-goal percentage, 0-100 (number; 0 when no attempt). |
| sc | integer | Dunks (`schiacciate`). |
| t3_r | integer | 3-point field goals made. |
| t3_t | integer | 3-point field goals attempted. |
| t3_perc | double | 3-point field-goal percentage, 0-100. |
| tl_r | integer | Free throws made (`tiri liberi realizzati`). |
| tl_t | integer | Free throws attempted (`tiri liberi tentati`). |
| tl_perc | double | Free-throw percentage, 0-100. |
| rimbalzi_o | integer | Offensive rebounds (`rimbalzi offensivi`). |
| rimbalzi_d | integer | Defensive rebounds (`rimbalzi difensivi`). |
| rimbalzi_t | integer | Total rebounds (`rimbalzi totali`). |
| stoppate_dat | integer | Blocks (`stoppate date`). |
| stoppate_sub | integer | Own shots blocked (`stoppate subite`). |
| palle_p | integer | Turnovers (`palle perse`). |
| palle_r | integer | Steals (`palle recuperate`). |
| ass | integer | Assists credited to the player in the game. |
| val_lega | integer | LBA efficiency rating (`valutazione Lega`). |
| val_oer | double | OER = points / (FGA + turnovers + FTA / 2); verified on every 2026-27 sample row. |
| plus_minus | integer | Plus-minus: point margin while on court. |

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
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_box_score(game_id = 25602))
#> ── LBA Box Score from legabasket.it ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:20:58 UTC
#> # A tibble: 24 × 39
#>    game_id season side  team_id player_id player_num player_surname player_name
#>      <int>  <int> <chr>   <int>     <int>      <int> <chr>          <chr>      
#>  1   25602   2027 home     1764       969          0 CAPPELLETTI    Alessandro 
#>  2   25602   2027 home     1764      9331          2 CARTER         Chico      
#>  3   25602   2027 home     1764      9041          3 CHAPMAN        Brekkott   
#>  4   25602   2027 home     1764      4879          4 RUSSELL        DeWayne    
#>  5   25602   2027 home     1764      7566          8 MANFREDOTTI    Alessandro 
#>  6   25602   2027 home     1764      3714         11 MIASCHI        Federico   
#>  7   25602   2027 home     1764      9042         13 ANIGBOGU       Ike        
#>  8   25602   2027 home     1764      9332         19 ALLINEI        Gregorio   
#>  9   25602   2027 home     1764      7607         24 IAQUINTA       Antonio    
#> 10   25602   2027 home     1764      1189         26 CHILLO         Matteo     
#> # ℹ 14 more rows
#> # ℹ 31 more variables: player_code <chr>, player_p_key <chr>, pun <int>,
#> #   min <int>, sec <int>, sf <chr>, falli_c <int>, falli_sf <int>,
#> #   falli_tc1 <int>, falli_fla <int>, t2_r <int>, t2_t <int>, t2_perc <dbl>,
#> #   sc <int>, t3_r <int>, t3_t <int>, t3_perc <dbl>, tl_r <int>, tl_t <int>,
#> #   tl_perc <dbl>, rimbalzi_o <int>, rimbalzi_d <int>, rimbalzi_t <int>,
#> #   stoppate_dat <int>, stoppate_sub <int>, palle_p <int>, palle_r <int>, …
# }
```
