# **Get ACB Player Box**

Per-player box score of a game, per period (quarter 0 = the whole game).

One row per team, period and player. `quarter` 0 is the whole game, 1-4
the periods, 5+ overtime (games before about 2010 carry only quarter 0).
`team_side` is home or away (the feed lists the home team first).
`play_time` is `'mm:ss'` and `seconds_played` the same in seconds;
counts are `Int64`. `player_id` is the ACB licence number; `game_role`
is the Spanish position.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_player_box(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_player_box`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
| team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| quarter | integer | Period of the row: 0 = the whole game, 1-4 quarters, 5+ overtimes. |
| player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |
| on_court | logical | True while the player is on court (false once the game is over). |
| play_time | character | Time on court as 'mm:ss' in the row's period. |
| seconds_played | integer | Time on court in whole seconds (play_time parsed). |
| is_starter | logical | True when the player started the game (the API's isStarted). |
| points | integer | Points (player box-score row) |
| free_throws_made | integer | Free throws the player made in the row's period (a count; quarter 0 is the whole game). |
| free_throws_attempted | integer | Free throws the player attempted in the row's period (a count; quarter 0 is the whole game). |
| two_pointers_made | integer | Two-point field goals made |
| two_pointers_attempted | integer | Two-point field goals attempted |
| three_pointers_made | integer | Three-point field goals made |
| three_pointers_attempted | integer | Three-point field goals attempted |
| assists | integer | Assists (player box-score row) |
| off_rebounds | integer | Offensive rebounds |
| def_rebounds | integer | Defensive rebounds |
| total_rebounds | integer | Total rebounds (player box-score row) |
| steals | integer | Steals (player box-score row) |
| turnovers | integer | Turnovers (player box-score row) |
| blocks | integer | Shots blocked (by this player or team) |
| received_blocks | integer | Own shots blocked by an opponent |
| dunks | integer | Dunks (player box-score row) |
| personal_fouls | integer | Fouls committed |
| fouls_drawn | integer | Fouls received (player box-score row) |
| plus_minus | integer | Point differential while on court (+/-) |
| rating | integer | Valoracion: ACB's efficiency rating (PIR) = points + rebounds + assists + steals + blocks + fouls received - missed field goals - missed free throws - turnovers - shots blocked by an opponent - fouls committed |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_player_box(match_id = 105401))
#> ── ACB Player Box from api2.acb.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:02:34 UTC
#> # A tibble: 120 × 39
#>    match_id edition_id season team_side team_id club_id team  team_abbr quarter
#>       <int>      <int>  <int> <chr>       <int>   <int> <chr> <chr>       <int>
#>  1   105401         91   2027 home         4467       2 Barça BAR             0
#>  2   105401         91   2027 home         4467       2 Barça BAR             0
#>  3   105401         91   2027 home         4467       2 Barça BAR             0
#>  4   105401         91   2027 home         4467       2 Barça BAR             0
#>  5   105401         91   2027 home         4467       2 Barça BAR             0
#>  6   105401         91   2027 home         4467       2 Barça BAR             0
#>  7   105401         91   2027 home         4467       2 Barça BAR             0
#>  8   105401         91   2027 home         4467       2 Barça BAR             0
#>  9   105401         91   2027 home         4467       2 Barça BAR             0
#> 10   105401         91   2027 home         4467       2 Barça BAR             0
#> # ℹ 110 more rows
#> # ℹ 30 more variables: player_id <int>, player_name <chr>, first_name <chr>,
#> #   last_name <chr>, shirt_number <chr>, game_role <chr>, on_court <lgl>,
#> #   play_time <chr>, seconds_played <int>, is_starter <lgl>, points <int>,
#> #   free_throws_made <int>, free_throws_attempted <int>,
#> #   two_pointers_made <int>, two_pointers_attempted <int>,
#> #   three_pointers_made <int>, three_pointers_attempted <int>, assists <int>, …
# }
```
