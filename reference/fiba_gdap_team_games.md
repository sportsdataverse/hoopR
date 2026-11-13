# **FIBA GDAP: team games**

A team's games with each team's leaders.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapgameswithleaderdetailsbyteamid`

## Usage

``` r
fiba_gdap_team_games(team_id, return_parsed = TRUE)
```

## Arguments

- team_id:

  (integer, required) Required. Competition team id: one per team per
  competition (teamA.teamId of a game row; Germany is 279569 at the 2023
  World Cup and 281545 at Paris 2024). Not the federation organisationId

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_team_games")`) and in the
searchable [return
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
  try(fiba_gdap_team_games(team_id = 279569))
#> ── FIBA gdap_team_games from fiba.basketball ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:13:37 UTC
#> # A tibble: 8 × 78
#>   game_id round_name     game_number status    status_code game_day team_a_from 
#>     <int> <chr>          <chr>       <chr>     <chr>          <int> <chr>       
#> 1  100720 Final          A           Validated VALID              1 Winner of G…
#> 2  100723 Semi-Finals    A           Validated VALID              1 Winner of G…
#> 3  100724 Quarter-Finals A           Validated VALID              1 1st of grou…
#> 4  100743 First Round    3           Validated VALID              2 NA          
#> 5  100744 First Round    1           Validated VALID              1 NA          
#> 6  100748 First Round    5           Validated VALID              3 NA          
#> 7  100797 Second Round   1           Validated VALID              1 1st of grou…
#> 8  100806 Second Round   4           Validated VALID              2 1st of grou…
#> # ℹ 71 more variables: team_b_from <chr>, team_a_team_id <int>,
#> #   team_a_organisation_id <int>, team_a_code <chr>,
#> #   team_a_official_name <chr>, team_a_short_name <chr>, team_b_team_id <int>,
#> #   team_b_organisation_id <int>, team_b_code <chr>,
#> #   team_b_official_name <chr>, team_b_short_name <chr>, team_a_score <int>,
#> #   team_b_score <int>, host_city <chr>, host_country <chr>,
#> #   host_country_code <chr>, venue_id <int>, venue_name <chr>, …
# }
```
