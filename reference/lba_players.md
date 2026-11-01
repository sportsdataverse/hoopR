# **Get LBA Players**

Players of a season, 50 per page (walk the pages with page).

Endpoint: `GET https://www.legabasket.it/api/players/get-players`
(`items=50&year=<season>&page=<page>`)

## Usage

``` r
lba_players(season = NULL, page = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

- page:

  Page number, 1-based. Omitted = the first page.

## Value

A `hoopR_data` tibble: Players of a season, 50 per page (walk the pages
with page). The columns are always these, in this order
(sportsdataverse-py `lba_players`); a column the site adds later is
appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| player_id | integer | Player id (global). |
| name | character | Player's given name. |
| surname | character | Player's family name. |
| code | character | Player code `SURNAME3-NAME3-YY`. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. The season of the team the row places the player on. |
| player_picture_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

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
  try(lba_players(season = 2027))
#> ── LBA Players from legabasket.it ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:49:01 UTC
#> # A tibble: 50 × 8
#>    season player_id name     surname    code  team_name  year player_picture_key
#>     <int>     <int> <chr>    <chr>      <chr> <chr>     <int> <chr>             
#>  1   2027        45 Nicola   Akele      AKE-… Armani O…  2026 sgwgsNL364vhCY9a8…
#>  2   2027        75 Amar     Alibegovic ALI-… Bertram …  2026 pZpWxP6Z5UPXzXW79…
#>  3   2027        76 Mirza    Alibegovic ALI-… Maxima R…  2026 Cx9Jyg8zFa2WqE3fF…
#>  4   2027      9332 Gregorio Allinei    ALL-… Nutribul…  2026 vcEjLiSLXW6H3CKuN…
#>  5   2027      9004 Derrick  Alston     ALS-… Virtus C…  2026 aX7pjgftNWGb3T3gG…
#>  6   2027        97 Davide   Alviti     ALV-… Openjobm…  2026 CchJHtkhZVSmQAXmh…
#>  7   2027       106 Lorenzo  Ambrosin   AMB-… Tezenis …  2026 8dQgaTER6wxGYUrXM…
#>  8   2027      9341 Andrew   Andrews    AND-… Tezenis …  2026 mFs7xD6hFHPQfxx6i…
#>  9   2027      9042 Ike      Anigbogu   ANI-… Nutribul…  2026 eNePF3FEwau1vBLPU…
#> 10   2027      9380 Gerald   Ayayi      AYA-… BC Roma    2026 wdm9w7UexGb9zaSL8…
#> # ℹ 40 more rows
# }
```
