# **FIBA GDAP: competition**

One competition (edition): season, dates, hosts, zone, category and
competition family.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getGdapCompetitionById`

## Usage

``` r
fiba_gdap_competition(comp, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per competition. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_competition")`) and in the
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
  try(fiba_gdap_competition(comp = 208182))
#> ── FIBA gdap_competition from fiba.basketball ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:48 UTC
#> # A tibble: 1 × 29
#>   hosts  competition_id competition_code season official_name start end   status
#>   <chr>           <int> <chr>             <int> <chr>         <chr> <chr> <chr> 
#> 1 "[{\"…         208182 WMM                2023 FIBA Basketb… 2023… 2023… Compl…
#> # ℹ 21 more variables: age_category <chr>, gender <chr>, fiba_zone <chr>,
#> #   zone_information_zone_id <int>, zone_information_zone_official_name <chr>,
#> #   zone_information_zone_code <chr>, zone_information_top_zone_id <int>,
#> #   zone_information_top_zone_official_name <chr>,
#> #   zone_information_top_zone_code <chr>, competition_type <chr>,
#> #   competition_category_is_league <lgl>, competition_category_age_type <chr>,
#> #   competition_category_code <chr>, competition_category_name <chr>, …
# }
```
