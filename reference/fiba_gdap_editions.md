# **FIBA GDAP: editions**

Every edition of a competition family between two seasons.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionsbyseasonsandcompetitionmarketingname`

## Usage

``` r
fiba_gdap_editions(
  family_id,
  season = NULL,
  to_season = NULL,
  return_parsed = TRUE
)
```

## Arguments

- family_id:

  (integer, required) Required. Competition family id
  (competitionMarketingName.competitionMarketingNameId): 201 = World
  Cup, 320 = men's Olympics, 306 = Women's World Cup, 112 = BCL tier 1,
  211 = EuroLeague Women.

- season:

  (integer, optional) Season key: the END year for club competitions
  (BCL 2024-25 = 2025), the event year for national-team events (World
  Cup 2023 = 2023); qualifiers carry the TARGET tournament year (World
  Cup 2027 qualifiers played in 2025 = 2027). Sent unchanged. First
  season, inclusive; omitted = no lower bound.

- to_season:

  (integer, optional) Last season, inclusive (same key as season).
  Omitted with season given = the same season.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per edition. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_editions")`) and in the
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
  try(fiba_gdap_editions(family_id = 201, season = 2023))
#> ── FIBA gdap_editions from fiba.basketball ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:01:43 UTC
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
