# **Get LBA Roster**

Players of one team-season with bio, number and role.

Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster`
(`id=<team_id>`)

## Usage

``` r
lba_roster(team_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

## Value

A `hoopR_data` tibble: Players of one team-season with bio, number and
role. The columns are always these, in this order (sdv-py `lba_roster`);
a column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| club_id | integer | Club id: the cross-season join key for team ids (only here and in the `team` headers); stability across seasons is unverified. |
| club_code | character | Club code (`TVB`, `TS`); whether it is stable across seasons is unverified. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| player_id | integer | Player id (global). |
| name | character | Player's given name. |
| surname | character | Player's family name. |
| code | character | Player code `SURNAME3-NAME3-YY`. |
| place_of_birth | character | Birthplace (Italian spelling). |
| birth_date | character | Birth date, Date `YYYY-MM-DD`. |
| player_number | character | Jersey number, number sent as a string. |
| country | character | Nationality, ISO alpha-3. |
| uefa_ratio | character | Eligibility class for the foreign-player quota: `I`, `E` or `C` (7 / 6 / 1 on the Treviso roster; reading as Italian / EU / non-EU is inferred). |
| height | integer | Player's height in centimetres. |
| weight | integer | Player's weight in kilograms. |
| year | integer | Season START year of the player entry (2026 = 2026-27). |
| start_date | character | Contract start with the team, Date `YYYY-MM-DD`. |
| end_date | character | Contract end with the team, Date `YYYY-MM-DD`. |
| player_role_id | integer | Position id (position key space: the id behind `player_role`; joins the `r_id` filter). |
| player_role | character | Position, Italian: `Playmaker` (point guard), `Guardia` (guard), `Ala` (forward), `Centro` (center), `-` unknown. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| player_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
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
  try(lba_roster(team_id = 1764))
#> ── LBA Roster from legabasket.it ─────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:43:04 UTC
#> # A tibble: 14 × 23
#>    team_id club_id club_code season player_id name  surname code  place_of_birth
#>      <int>   <int> <chr>      <int>     <int> <chr> <chr>   <chr> <chr>         
#>  1    1764     107 TVU         2027       969 Ales… Cappel… CAP-… Assisi        
#>  2    1764     107 TVU         2027      9331 Chico Carter  CAR-… Columbia      
#>  3    1764     107 TVU         2027      9041 Brek… Chapman CHA-… Roy           
#>  4    1764     107 TVU         2027      4879 DeWa… Russell RUS-… Peoria        
#>  5    1764     107 TVU         2027      9014 Ed    Croswe… CRO-… Philadelphia  
#>  6    1764     107 TVU         2027      7566 Ales… Manfre… MAN-… Reggio Emilia 
#>  7    1764     107 TVU         2027      7606 Ales… Vettori VET-… Treviso       
#>  8    1764     107 TVU         2027      3714 Fede… Miaschi MIA-… Genova        
#>  9    1764     107 TVU         2027      9042 Ike   Anigbo… ANI-… San Diego     
#> 10    1764     107 TVU         2027      9332 Greg… Allinei ALL-… Firenze       
#> 11    1764     107 TVU         2027      7607 Anto… Iaquin… IAQ-… Merano        
#> 12    1764     107 TVU         2027      1189 Matt… Chillo  CHI-… Bologna       
#> 13    1764     107 TVU         2027      6191 JP    Macura  MAC-… Lakeville     
#> 14    1764     107 TVU         2027      9333 Vale… Chery   CHE-… Saint-Priest-…
#> # ℹ 14 more variables: birth_date <chr>, player_number <chr>, country <chr>,
#> #   uefa_ratio <chr>, height <int>, weight <int>, year <int>, start_date <chr>,
#> #   end_date <chr>, player_role_id <int>, player_role <chr>, team_name <chr>,
#> #   player_picture_key <chr>, team_logo_key <chr>
# }
```
