# **EuroLeague Games**

**Get the games of a season.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/games`

## Usage

``` r
euroleague_games(competition_code, season_code, limit = NULL, offset = NULL)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- limit:

  (*integer* optional): Page size (number of rows to return).

- offset:

  (*integer* optional): Row offset into the full list.

## Value

A `hoopR_data` tibble with one row per game:

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | Provider identifier for the entity (Utf8 join key). |
| identifier | character | Season-qualified game identifier, e.g. E2025_1. |
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
| audience | integer | Attendance. |
| audience_confirmed | logical | Whether the attendance figure is confirmed. |
| social_feed | character | Social-media hashtag or feed tag for the game. |
| operations_code | character | Engine operations code of the game. |
| referee4 | character | Fourth referee (null unless a fourth official is assigned). |
| is_neutral_venue | logical | Whether the game is played at a neutral venue. |
| game_status | character | Game status (scheduled, live, result). |
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
| local_partials_partials1 | integer | Home side: quarter scores: points scored in the 1st quarter. |
| local_partials_partials2 | integer | Home side: quarter scores: points scored in the 2nd quarter. |
| local_partials_partials3 | integer | Home side: quarter scores: points scored in the 3rd quarter. |
| local_partials_partials4 | integer | Home side: quarter scores: points scored in the 4th quarter. |
| road_club_code | character | Away side: club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| road_club_name | character | Away side: club: display name. |
| road_club_abbreviated_name | character | Away side: club: abbreviated display name. |
| road_club_editorial_name | character | Away side: club: editorial (long-form) display name. |
| road_club_tv_code | character | Away side: club: three-letter broadcast abbreviation of the club. |
| road_club_is_virtual | logical | Away side: club: whether the club is a placeholder rather than a real club. |
| road_club_images_crest | character | Away side: club: URL of the club crest image. |
| road_score | integer | Away side: final score of the side. |
| road_standings_score | integer | Away side: score of the side as counted for the standings. |
| road_partials_partials1 | integer | Away side: quarter scores: points scored in the 1st quarter. |
| road_partials_partials2 | integer | Away side: quarter scores: points scored in the 2nd quarter. |
| road_partials_partials3 | integer | Away side: quarter scores: points scored in the 3rd quarter. |
| road_partials_partials4 | integer | Away side: quarter scores: points scored in the 4th quarter. |
| referee1_code | character | First referee: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| referee1_name | character | First referee: display name. |
| referee1_alias | character | First referee: short display alias. |
| referee1_country_code | character | First referee: ISO country code. |
| referee1_country_name | character | First referee: country name. |
| referee1_images_vertical_small | character | First referee: URL of the small portrait image. |
| referee1_active | logical | First referee: whether the record is currently active. |
| referee2_code | character | Second referee: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| referee2_name | character | Second referee: display name. |
| referee2_alias | character | Second referee: short display alias. |
| referee2_country_code | character | Second referee: ISO country code. |
| referee2_country_name | character | Second referee: country name. |
| referee2_images_vertical_small | character | Second referee: URL of the small portrait image. |
| referee2_active | logical | Second referee: whether the record is currently active. |
| referee3_code | character | Third referee: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| referee3_name | character | Third referee: display name. |
| referee3_alias | character | Third referee: short display alias. |
| referee3_country_code | character | Third referee: ISO country code. |
| referee3_country_name | character | Third referee: country name. |
| referee3_images_vertical_small | character | Third referee: URL of the small portrait image. |
| referee3_active | logical | Third referee: whether the record is currently active. |
| venue_name | character | Venue: display name. |
| venue_code | character | Code of the venue the club or game plays at (Utf8 join key). |
| venue_capacity | integer | Venue: seating capacity of the venue. |
| venue_address | character | Venue: street address. |
| venue_images_medium | character | Venue: URL of the medium-size venue image. |
| venue_active | logical | Venue: whether the record is currently active. |
| venue_notes | character | Venue: venue notes. |
| winner_code | character | Winning club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| winner_name | character | Winning club: display name. |
| winner_abbreviated_name | character | Winning club: abbreviated display name. |
| winner_editorial_name | character | Winning club: editorial (long-form) display name. |
| winner_tv_code | character | Winning club: three-letter broadcast abbreviation of the club. |
| winner_is_virtual | logical | Winning club: whether the club is a placeholder rather than a real club. |
| winner_images_crest | character | Winning club: URL of the club crest image. |

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
[`euroleague_game_report()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_report.md),
[`euroleague_game_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_stats.md),
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
    euroleague_games(competition_code = "E", season_code = "E2025")
  })
#> ── EuroLeague games from api-live.euroleague.net ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-10 23:07:39 UTC
#> # A tibble: 402 × 101
#>    id             identifier game_code round round_alias round_name played date 
#>    <chr>          <chr>      <chr>     <int> <chr>       <chr>      <lgl>  <chr>
#>  1 13302d2b-97e6… E2025_406  406          47 Round 47    Round 47   TRUE   2026…
#>  2 1f32f9dc-91bf… E2025_405  405          46 Round 46    Round 46   TRUE   2026…
#>  3 8de7a6c5-68ab… E2025_404  404          46 Round 46    Round 46   TRUE   2026…
#>  4 9b5ebfbd-3338… E2025_403  403          45 Round 45    Round 45   TRUE   2026…
#>  5 5ffbcdf2-9182… E2025_399  399          44 Round 44    Round 44   TRUE   2026…
#>  6 e58d48f0-0537… E2025_397  397          44 Round 44    Round 44   TRUE   2026…
#>  7 93413528-9072… E2025_398  398          44 Round 44    Round 44   TRUE   2026…
#>  8 84fefa93-abdb… E2025_395  395          43 Round 43    Round 43   TRUE   2026…
#>  9 37a8e805-55b6… E2025_393  393          43 Round 43    Round 43   TRUE   2026…
#> 10 9b7f950f-b54a… E2025_392  392          43 Round 43    Round 43   TRUE   2026…
#> # ℹ 392 more rows
#> # ℹ 93 more variables: confirmed_date <lgl>, confirmed_hour <lgl>,
#> #   local_time_zone <int>, local_date <chr>, utc_date <chr>, audience <int>,
#> #   audience_confirmed <lgl>, social_feed <chr>, operations_code <chr>,
#> #   referee4 <chr>, is_neutral_venue <lgl>, game_status <chr>,
#> #   season_name <chr>, season_code <chr>, season_alias <chr>,
#> #   season_competition_code <chr>, season_year <int>, …
# }
```
