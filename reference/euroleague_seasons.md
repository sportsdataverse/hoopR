# **EuroLeague Seasons**

**Get the seasons of a competition.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons`

## Usage

``` r
euroleague_seasons(competition_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

## Value

A `hoopR_data` tibble with one row per season:

|  |  |  |
|----|----|----|
| col_name | types | description |
| name | character | Display name. |
| code | character | EuroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| alias | character | Short display alias. |
| competition_code | character | Competition code (E = EuroLeague, U = EuroCup; Utf8 join key). |
| year | integer | Start year of the season. |
| start_date | character | Start date (ISO 8601). |
| activation_date | character | Date the season was activated in the engine (ISO 8601). |
| end_date | character | End date (ISO 8601). |
| winner | numeric | Winning club of the season (null while in progress). |
| winner_code | character | Winning club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| winner_name | character | Winning club: display name. |
| winner_abbreviated_name | character | Winning club: abbreviated display name. |
| winner_editorial_name | character | Winning club: editorial (long-form) display name. |
| winner_tv_code | character | Winning club: three-letter broadcast abbreviation of the club. |
| winner_is_virtual | character | Winning club: whether the club is a placeholder rather than a real club. |
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
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_seasons(competition_code = "E")
  })
#> ── EuroLeague seasons from api-live.euroleague.net ───────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 03:48:59 UTC
#> # A tibble: 27 × 16
#>    name   code  alias competition_code  year start_date activation_date end_date
#>    <chr>  <chr> <chr> <chr>            <int> <chr>      <chr>           <chr>   
#>  1 EuroL… E2026 2026… E                 2026 2026-07-0… 2026-07-01T00:… 2027-06…
#>  2 EuroL… E2025 2025… E                 2025 2025-07-0… 2025-07-01T00:… 2026-06…
#>  3 EuroL… E2024 2024… E                 2024 2024-06-2… 2024-06-29T00:… 2025-06…
#>  4 EuroL… E2023 2023… E                 2023 2023-06-2… 2023-06-29T00:… 2024-07…
#>  5 EuroL… E2022 2022… E                 2022 2022-07-0… 2022-07-01T00:… 2023-07…
#>  6 EuroL… E2021 2021… E                 2021 2021-09-0… 2021-07-01T00:… 2022-06…
#>  7 EuroL… E2020 2020… E                 2020 2020-09-0… 2020-06-23T00:… 2021-07…
#>  8 EuroL… E2019 2019… E                 2019 2019-09-0… 2019-07-01T00:… 2020-05…
#>  9 EuroL… E2018 2018… E                 2018 2018-09-0… 2018-07-02T00:… 2019-05…
#> 10 EuroL… E2017 2017… E                 2017 2017-10-0… 2017-07-01T00:… 2018-05…
#> # ℹ 17 more rows
#> # ℹ 8 more variables: winner <chr>, winner_code <chr>, winner_name <chr>,
#> #   winner_abbreviated_name <chr>, winner_editorial_name <chr>,
#> #   winner_tv_code <chr>, winner_is_virtual <lgl>, winner_images_crest <chr>
# }
```
