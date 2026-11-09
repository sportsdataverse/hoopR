# **FIBA GDAP: rounds**

Rounds of a competition (group stage, knockout rounds).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`

## Usage

``` r
fiba_gdap_rounds(comp, return_parsed = TRUE)
```

## Arguments

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per round. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_rounds")`) and in the
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
  try(fiba_gdap_rounds(comp = 208182))
#> ── FIBA gdap_rounds from fiba.basketball ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:54:08 UTC
#> # A tibble: 10 × 18
#>    game_system game_system_code parent_round_id round_code round_id round_name  
#>    <chr>       <chr>                      <int> <chr>         <int> <chr>       
#>  1 Single      S                          25274 FR            25276 First Round 
#>  2 Single      S                          25274 SR            25285 Second Round
#>  3 Single      S                             NA CL17-32       25284 Classificat…
#>  4 Single      S                          25275 QF            25277 Quarter-Fin…
#>  5 Single      S                          25275 CL5-8         25278 Class. Game…
#>  6 Single      S                          25275 SF            25279 Semi-Finals 
#>  7 Single      S                          25275 CL7-8         25280 Class. Game…
#>  8 Single      S                          25275 CL5-6         25281 Class. Game…
#>  9 Single      S                          25275 3PG           25282 3rd Place G…
#> 10 Single      S                          25275 F             25283 Final       
#> # ℹ 12 more variables: round_number <int>, round_type <chr>,
#> #   round_type_code <chr>, round_status_code <chr>, start_date <chr>,
#> #   end_date <chr>, has_teams_assigned <lgl>, round_kind <chr>,
#> #   standing_header_code <chr>, standing_header_name <chr>,
#> #   qualified_team_information <chr>, round_order <int>
# }
```
