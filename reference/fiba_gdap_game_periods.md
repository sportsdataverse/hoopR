# **FIBA GDAP: game periods**

Period scores of one game.

Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`

## Usage

``` r
fiba_gdap_game_periods(game_id, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) Required. FIBA game id (global GDAP key space):
  gameId of a schedule row; the `<gameId>` of a game page URL

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64) of the game the period belongs to. |
| name | character | Period name ('Q1'...'OT1'). |
| number | integer | Period number (1-based). |
| team_a_score | integer | Team A points in the period. |
| team_b_score | integer | Team B points in the period. |
| team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
| team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gdap_game_periods(game_id = 100720))
#> ── FIBA gdap_game_periods from fiba.basketball ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:05:38 UTC
#> # A tibble: 4 × 7
#>   game_id name  number team_a_score team_b_score team_a_from       team_b_from  
#>     <int> <chr>  <int>        <int>        <int> <chr>             <chr>        
#> 1  100720 Q1         1           23           26 Winner of Game 87 Winner of Ga…
#> 2  100720 Q2         2           24           21 Winner of Game 87 Winner of Ga…
#> 3  100720 Q3         3           22           10 Winner of Game 87 Winner of Ga…
#> 4  100720 Q4         4           14           20 Winner of Game 87 Winner of Ga…
# }
```
