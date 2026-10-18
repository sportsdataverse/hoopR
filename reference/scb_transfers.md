# **Get BBL Transfers**

Latest transfers, one row per move (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/transfers`

## Usage

``` r
scb_transfers()
```

## Value

A `hoopR_data` tibble: Latest transfers, one row per move (BBL only). An
empty valid answer raises `hoopR_no_data`; the columns are always these,
in this order (sdv-py `scb_transfers`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| transfer_date | character | Date of the transfer, YYYY-MM-DD (the API's `sortingDate`). |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
| real_player_id | integer | Global person id (integer): the same player across clubs and seasons. Join players across seasons on this. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
| source_team_id | character | Club id the player left; null when the source is not a league club. |
| source_team_name | character | Name of the club the player left (the free-text field, else the short club name). |
| destination_team_id | character | Club id the player joined; null when the destination is not a league club. |
| destination_team_name | character | Name of the club the player joined (the free-text field, else the short club name). |

## Details

- Unofficial use of a public source: these wrappers read the front-end
  API of the German Bundesliga sites (easycredit-bbl.de,
  toyota-dbbl.de), run by SCB; payloads are not redistributed as release
  assets.

- Legal notice: the BBL Impressum forbids storing BBL content
  (`Inhalte`) in an information system without BBL's written permission.
  That is a copyright term, not a robots rule (the API host has no
  robots.txt). The owner reviewed it and accepted the intake (2026-10-12
  ruling); keep requests slow (the runtime waits at least 1 s per host)
  and raise any published data release with the owner. The DBBL host is
  the same operator and API; its site notice was not separately
  reviewed.

- Both hosts need two headers: a constant `x-api-key` and an
  `x-api-secret` that rotates. The runtime derives the secret on first
  use from the key embedded in an easycredit-bbl.de page (reversed, `:`
  turned into `-`) and never logs or returns it. The derivation was
  reverse-engineered from observed requests and responses and has not
  been checked against the site's own front-end code; if the site
  changes how it signs requests, every call fails with
  `hoopR_asset_fetch`.

- Id key spaces: seasonId is the START year (2025 = 2025-26), so a
  wrapper's END-year `season` is sent as `season - 1`. Teams are keyed
  by teamId (seasonTeamId equals it in every sample). seasonPlayerId is
  per player per season and per club (a player traded mid-season has
  two); realPlayerId is the person. playerId is ambiguous (the
  seasonPlayerId in box scores, records and /season-players; the person
  in /transfers). Game ids are strings.

- Errors are classed conditions: `hoopR_no_data` (404, 204, a 400 "not a
  valid" id, no rows, a box score of a game not yet started),
  `hoopR_bad_request` (a bad argument, another 400 / 422) and
  `hoopR_asset_fetch` (a refused secret after one re-derive, any other
  non-2xx, an HTML / non-JSON / error-shaped body, a truncated page, a
  body for another game, season, club or league, a box score still in
  play), all inheriting `hoopR_error`. Wrappers raise; they never return
  an empty frame.

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
[`scb_game_teams()`](https://hoopR.sportsdataverse.org/reference/scb_game_teams.md),
[`scb_games()`](https://hoopR.sportsdataverse.org/reference/scb_games.md),
[`scb_games_recent()`](https://hoopR.sportsdataverse.org/reference/scb_games_recent.md),
[`scb_player_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_player_statistics.md),
[`scb_playoff_games()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_games.md),
[`scb_playoff_series()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_series.md),
[`scb_records_per_game()`](https://hoopR.sportsdataverse.org/reference/scb_records_per_game.md),
[`scb_records_season_averages()`](https://hoopR.sportsdataverse.org/reference/scb_records_season_averages.md),
[`scb_referees()`](https://hoopR.sportsdataverse.org/reference/scb_referees.md),
[`scb_season_player()`](https://hoopR.sportsdataverse.org/reference/scb_season_player.md),
[`scb_season_players()`](https://hoopR.sportsdataverse.org/reference/scb_season_players.md),
[`scb_season_teams()`](https://hoopR.sportsdataverse.org/reference/scb_season_teams.md),
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md),
[`scb_standings()`](https://hoopR.sportsdataverse.org/reference/scb_standings.md),
[`scb_team()`](https://hoopR.sportsdataverse.org/reference/scb_team.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_transfers())
#> ── BBL/DBBL Transfers from the SCB API ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:02:01 UTC
#> # A tibble: 20 × 11
#>    league transfer_date season_player_id real_player_id first_name  last_name   
#>    <chr>  <chr>         <chr>                     <int> <chr>       <chr>       
#>  1 bbl    2026-10-16    2005402               140183503 Yankuba     Sima Fatty  
#>  2 bbl    2026-10-14    2005387                   59866 Ryan        Mikesell    
#>  3 bbl    2026-10-06    2005312               140183148 Terrell     Harris      
#>  4 bbl    2026-10-01    2005281                   50012 Sacar       Anim        
#>  5 bbl    2026-09-29    2005242               140179958 Musa        Abra        
#>  6 bbl    2026-09-18    2005199                   45587 Christian   Skladanowski
#>  7 bbl    2026-09-16    2005169               140183479 De'Jour     Reaves      
#>  8 bbl    2026-09-15    2004505               140180029 Cedric Paul Anderson Jr.
#>  9 bbl    2026-09-14    2005104                   27255 Marvin      Heckel      
#> 10 bbl    2026-09-14    2005111               140183473 Juom Maker  Bol Meen    
#> 11 bbl    2026-09-14    2005111               140183473 Juom Maker  Bol Meen    
#> 12 bbl    2026-09-14    2005114               140183474 Julian      Hilt        
#> 13 bbl    2026-09-14    2005118                   50349 Nils        Piprek      
#> 14 bbl    2026-09-12    2005088               140183470 Stefan      Momirov     
#> 15 bbl    2026-09-11    2005038               140180799 Kilian      Dück        
#> 16 bbl    2026-09-07    2005022               140183461 Kihei       Clark       
#> 17 bbl    2026-09-01    2005090               140183455 Kyle        Gruhler     
#> 18 bbl    2026-09-01    2005090               140183455 Kyle        Gruhler     
#> 19 bbl    2026-09-01    2005089               140181646 Finn        Stuehlmeyer 
#> 20 bbl    2026-09-01    2005110                   58374 Noah        Wendland    
#> # ℹ 5 more variables: position <chr>, source_team_id <chr>,
#> #   source_team_name <chr>, destination_team_id <chr>,
#> #   destination_team_name <chr>
# }
```
