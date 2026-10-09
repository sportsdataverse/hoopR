# **EuroLeague Competitions**

**Get the competitions of the EuroLeague Competition Engine (EuroLeague
`E`, EuroCup `U`, ...).**

Endpoint: `GET https://api-live.euroleague.net/v2/competitions`

## Usage

``` r
euroleague_competitions()
```

## Value

A `hoopR_data` tibble with one row per competition:

|  |  |  |
|----|----|----|
| col_name | types | description |
| name | character | Display name. |
| code | character | EuroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |

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
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_competitions()
  })
#> ── EuroLeague competitions from api-live.euroleague.net ──── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 04:32:35 UTC
#> # A tibble: 43 × 2
#>    name                   code 
#>    <chr>                  <chr>
#>  1 Adriatic League        AL   
#>  2 Belgium League         BE   
#>  3 Belgium National Cup   BEC  
#>  4 Bulgarian League       BU   
#>  5 Bulgarian National Cup BUC  
#>  6 Croatian League        CR   
#>  7 Croatian National Cup  CRC  
#>  8 Euroleague             E    
#>  9 English League         EN   
#> 10 English National Cup   ENC  
#> # ℹ 33 more rows
# }
```
