# **FIBA GDAP: game**

One game's header: teams, score, venue, attendance and status codes (no
box score or play-by-play: see fiba_gamepage).

Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`

## Usage

``` r
fiba_gdap_game(game_id, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) Required. FIBA game id (global GDAP key space):
  gameId of a schedule row; the `<gameId>` of a game page URL

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_game")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
  try(fiba_gdap_game(game_id = 100720))
#> ── FIBA gdap_game from fiba.basketball ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:15:49 UTC
#> # A tibble: 1 × 50
#>   game_id round_name technical_name round_type    group_pairing_code game_number
#>     <int> <chr>      <chr>          <chr>         <chr>              <chr>      
#> 1  100720 Final      25283-92-A     Non Group Ro… 92                 A          
#> # ℹ 44 more variables: status_code <chr>, game_day <int>, team_a_from <chr>,
#> #   team_b_from <chr>, team_a_team_id <int>, team_a_organisation_id <int>,
#> #   team_a_code <chr>, team_a_official_name <chr>, team_a_short_name <chr>,
#> #   team_b_team_id <int>, team_b_organisation_id <int>, team_b_code <chr>,
#> #   team_b_official_name <chr>, team_b_short_name <chr>, team_a_score <int>,
#> #   team_b_score <int>, team_a_aggregated_score <int>,
#> #   team_b_aggregated_score <int>, host_city <chr>, host_country <chr>, …
# }
```
