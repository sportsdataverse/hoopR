# **EuroLeague People**

**Get the people (players, coaches) in a season.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/people`

## Usage

``` r
euroleague_people(competition_code, season_code, limit = NULL, offset = NULL)
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

A `hoopR_data` tibble with one row per person-club registration:

|  |  |  |
|----|----|----|
| col_name | types | description |
| type | character | Person type code (J = player, E = coach, ...). |
| type_name | character | Person type name. |
| active | logical | Whether the record is currently active. |
| start_date | character | Start date (ISO 8601). |
| end_date | character | End date (ISO 8601). |
| order | integer | Display order within the roster. |
| dorsal | character | Jersey number as displayed. |
| dorsal_raw | character | Jersey number as stored by the engine. |
| position | integer | Position code of the player (engine integer). |
| position_name | character | Position name of the player. |
| last_team | character | Previous club of the person. |
| external_id | character | External (statistics-provider) identifier of the person (Utf8 join key). |
| person_code | character | Person: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| person_name | character | Person: display name. |
| person_alias | character | Person: short display alias. |
| person_alias_raw | character | Person: short alias as stored by the engine. |
| person_passport_name | character | Person: given name as on the passport. |
| person_passport_surname | character | Person: surname as on the passport. |
| person_jersey_name | character | Person: name printed on the jersey. |
| person_abbreviated_name | character | Person: abbreviated display name. |
| person_country_code | character | Person: ISO country code. |
| person_country_name | character | Person: country name. |
| person_height | integer | Person: height in centimetres. |
| person_weight | integer | Person: weight in kilograms. |
| person_birth_date | character | Person: date of birth (ISO 8601). |
| person_birth_country_code | character | Person: birth country: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| person_birth_country_name | character | Person: birth country: display name. |
| person_twitter_account | character | Person: twitter / X handle. |
| person_instagram_account | character | Person: instagram handle. |
| person_facebook_account | character | Person: facebook handle. |
| person_is_referee | logical | Person: whether the person is a referee. |
| club_code | character | Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| club_name | character | Club: display name. |
| club_abbreviated_name | character | Club: abbreviated display name. |
| club_editorial_name | character | Club: editorial (long-form) display name. |
| club_tv_code | character | Club: three-letter broadcast abbreviation of the club. |
| club_is_virtual | logical | Club: whether the club is a placeholder rather than a real club. |
| club_images_crest | character | Club: URL of the club crest image. |
| season_name | character | Season: display name. |
| season_code | character | Season code: competition code + start year, e.g. E2025 for 2025-26 (Utf8 join key). |
| season_alias | character | Season: short display alias. |
| season_competition_code | character | Season: competition code (E = EuroLeague, U = EuroCup; Utf8 join key). |
| season_year | integer | Season: start year of the season. |
| season_start_date | character | Season: start date (ISO 8601). |

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
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_people(competition_code = "E", season_code = "E2025", limit = 50)
  })
#> ── EuroLeague people from api-live.euroleague.net ────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 05:33:14 UTC
#> # A tibble: 50 × 48
#>    type  type_name   active start_date end_date order dorsal dorsal_raw position
#>    <chr> <chr>       <lgl>  <chr>      <chr>    <int> <chr>  <chr>         <int>
#>  1 A     Assitant c… FALSE  2025-09-0… 2026-04…     7 ""     ""                0
#>  2 A     Assitant c… TRUE   2025-12-2… 2026-06…     5 ""     ""                0
#>  3 E     Coach       FALSE  2025-12-0… 2025-12…     5 ""     ""                0
#>  4 A     Assitant c… TRUE   2025-11-1… 2026-06…     5 ""     ""                0
#>  5 A     Assitant c… TRUE   2025-09-1… 2026-06…     5 ""     ""                0
#>  6 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#>  7 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#>  8 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#>  9 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#> 10 A     Assitant c… TRUE   2025-11-1… 2026-06…     4 ""     ""                0
#> # ℹ 40 more rows
#> # ℹ 39 more variables: position_name <chr>, last_team <chr>, external_id <chr>,
#> #   person_code <chr>, person_name <chr>, person_alias <chr>,
#> #   person_alias_raw <chr>, person_passport_name <chr>,
#> #   person_passport_surname <chr>, person_jersey_name <chr>,
#> #   person_abbreviated_name <chr>, person_country_code <chr>,
#> #   person_country_name <chr>, person_height <int>, person_weight <int>, …
# }
```
