# **EuroLeague Game Report**

**Get the report of one game: date, round, phase, both clubs with score
and last-5 form, one row.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/seasons/{season_code}/games/{game_code}/report`

## Usage

``` r
euroleague_game_report(competition_code, season_code, game_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- game_code:

  (*integer* required): Game number within the season (1-based; the
  `game_code` column of
  [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md)).

## Value

A `hoopR_data` tibble with one row (the game):

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_code | character | Game number within the season (1-based; Utf8 join key). |
| round | integer | Round number within the season. |
| round_alias | character | Short alias of the round. |
| round_name | character | Display name of the round. |
| played | logical | Whether the game has been played. |
| date | character | Scheduled tip-off (ISO 8601, venue local time). |
| confirmed_date | logical | Whether the game date is confirmed. |
| confirmed_hour | logical | Whether the tip-off time is confirmed. |
| local_time_zone | integer | UTC offset of the venue, in hours. |
| local_date | character | Scheduled tip-off in venue local time (ISO 8601). |
| utc_date | character | Scheduled tip-off in UTC (ISO 8601). |
| local_last5_form | character | Home side: results of the last five games, oldest first (W / L), JSON-encoded. |
| road_last5_form | character | Away side: results of the last five games, oldest first (W / L), JSON-encoded. |
| season_name | character | Season: display name. |
| season_code | character | Season code: competition code + start year, e.g. E2025 for 2025-26 (Utf8 join key). |
| season_alias | character | Season: short display alias. |
| season_competition_code | character | Season: competition code (E = EuroLeague, U = EuroCup; Utf8 join key). |
| season_year | integer | Season: start year of the season. |
| season_start_date | character | Season: start date (ISO 8601). |
| group_id | character | Group: provider identifier for the entity (Utf8 join key). |
| group_order | integer | Group: display order within the roster. |
| group_name | character | Group: display name. |
| group_raw_name | character | Group: group name as stored by the engine. |
| phase_type_code | character | Phase type code (RS = regular season, PO = playoffs, ...). |
| phase_type_alias | character | Phase type: short display alias. |
| phase_type_name | character | Phase type: display name. |
| phase_type_is_group_phase | logical | Phase type: whether the phase is played in groups. |
| local_club_code | character | Home side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| local_club_name | character | Home side: club: display name. |
| local_club_abbreviated_name | character | Home side: club: abbreviated display name. |
| local_club_editorial_name | character | Home side: club: editorial (long-form) display name. |
| local_club_tv_code | character | Home side: club: three-letter broadcast abbreviation of the club. |
| local_club_is_virtual | logical | Home side: club: whether the club is a placeholder rather than a real club. |
| local_club_images_crest | character | Home side: club: URL of the club crest image. |
| local_score | integer | Home side: final score of the side. |
| local_standings_score | integer | Home side: score of the side as counted for the standings. |
| road_club_code | character | Away side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| road_club_name | character | Away side: club: display name. |
| road_club_abbreviated_name | character | Away side: club: abbreviated display name. |
| road_club_editorial_name | character | Away side: club: editorial (long-form) display name. |
| road_club_tv_code | character | Away side: club: three-letter broadcast abbreviation of the club. |
| road_club_is_virtual | logical | Away side: club: whether the club is a placeholder rather than a real club. |
| road_club_images_crest | character | Away side: club: URL of the club crest image. |
| road_score | integer | Away side: final score of the side. |
| road_standings_score | integer | Away side: score of the side as counted for the standings. |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors its sdv-py twin of the same name: same
arguments, defaults and snake_case columns, one row per sdv-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sdv-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

Other Euroleague:
[`euroleague_clubs()`](https://hoopR.sportsdataverse.org/reference/euroleague_clubs.md),
[`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md),
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
[`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md),
[`euroleague_game_points()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_points.md),
[`euroleague_game_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_stats.md),
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_game_report(competition_code = "E", season_code = "E2025", game_code = 1)
  })
#> ── EuroLeague game report from api-live.euroleague.net ───── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-10 23:07:37 UTC
#> # A tibble: 1 × 45
#>   game_code round round_alias round_name played date              confirmed_date
#>   <chr>     <int> <chr>       <chr>      <lgl>  <chr>             <lgl>         
#> 1 1             1 Round 1     Round 1    TRUE   2025-09-30T19:45… TRUE          
#> # ℹ 38 more variables: confirmed_hour <lgl>, local_time_zone <int>,
#> #   local_date <chr>, utc_date <chr>, local_last5_form <chr>,
#> #   road_last5_form <chr>, season_name <chr>, season_code <chr>,
#> #   season_alias <chr>, season_competition_code <chr>, season_year <int>,
#> #   season_start_date <chr>, group_id <chr>, group_order <int>,
#> #   group_name <chr>, group_raw_name <chr>, phase_type_code <chr>,
#> #   phase_type_alias <chr>, phase_type_name <chr>, …
# }
```
