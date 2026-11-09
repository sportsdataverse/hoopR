# **EuroLeague Game Header**

**Get the header of one game from the live API: teams, codes, coaches,
score by quarter, venue, referees, one row.**

Endpoint:
`GET https://live.euroleague.net/api/Header?gamecode={game_code}&seasoncode={season_code}`

The header is a flat object: teams, codes, coaches, the score and the
**cumulative** score at the end of each quarter (`score_quarter1_a`
...), venue, capacity (as reported; its semantics are unverified) and
referees. Team A is the home side as measured on one game.

## Usage

``` r
euroleague_game_header(game_code, season_code)
```

## Arguments

- game_code:

  (*integer* required): Game number within the season (1-based; the
  `game_code` column of
  [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md)).

- season_code:

  (*character* required): Competition code + start year: `E2025`
  (EuroLeague 2025-26), `U2025` (EuroCup).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_game_header")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

The live API's codes are space-padded fixed-width strings
(`TEAM = "IST "`); every string cell is stripped. Its "no such game"
answer is an **empty 200 body**, returned as a zero-row tibble with the
documented columns (not an error). A 404 raises `hoopR_no_data`, a 400 /
422 `hoopR_invalid_request`, any other failure `hoopR_fetch_error` (all
inherit `hoopR_error`).

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    euroleague_game_header(game_code = 1, season_code = "E2025")
  })
#> ── EuroLeague game header from live.euroleague.net ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:53:33 UTC
#> # A tibble: 1 × 44
#>   live  round date    hour  stadium capacity team_a team_b code_team_a tv_code_a
#>   <lgl> <chr> <chr>   <chr> <chr>   <chr>    <chr>  <chr>  <chr>       <chr>    
#> 1 FALSE 1     30/09/… 19:45 MORACA  2110     ANADO… MACCA… IST         EFS      
#> # ℹ 34 more variables: code_team_b <chr>, tv_code_b <chr>, im_a <chr>,
#> #   im_b <chr>, score_a <chr>, score_b <chr>, coach_a <chr>, coach_b <chr>,
#> #   game_time <chr>, remaining_partial_time <chr>, wid <chr>, quarter <chr>,
#> #   foults_a <chr>, foults_b <chr>, timeouts_a <chr>, timeouts_b <chr>,
#> #   score_quarter1_a <int>, score_quarter2_a <int>, score_quarter3_a <int>,
#> #   score_quarter4_a <int>, score_extra_time_a <int>, score_quarter1_b <int>,
#> #   score_quarter2_b <int>, score_quarter3_b <int>, score_quarter4_b <int>, …
# }
```
