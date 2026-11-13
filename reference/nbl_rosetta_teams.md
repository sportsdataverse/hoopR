# **NBL Rosetta Teams**

Every team record of an organisation: current, defunct, exhibition and
development sides.

Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/teams`

## Usage

``` r
nbl_rosetta_teams(org = "nbl", limit = NULL)
```

## Arguments

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble with one row per team record. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_teams")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(nbl_rosetta_teams(org = "nbl"))
#> ── NBL Rosetta teams from prod.rosetta.nbl.com.au ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:58:17 UTC
#> # A tibble: 86 × 22
#>    org   team_id          rosetta_team_id name  team_code established head_coach
#>    <chr> <chr>            <chr>           <chr> <chr>     <chr>       <chr>     
#>  1 nbl   bf0e988e-410c-1… 8d26bbf0-a2cf-… Adel… NA        NA          NA        
#>  2 nbl   bedd705b-410c-1… bbae77db-317d-… NZ B… NZL       2003        Gordon He…
#>  3 nbl   bfd26c1b-410c-1… b82a3f8a-b3d8-… Forr… NA        NA          NA        
#>  4 nbl   bf8c7fb4-410c-1… aa5dd82e-27f7-… St M… SMC       NA          NA        
#>  5 nbl   bee53184-410c-1… a898766e-bcf0-… Sout… STH       NA          NA        
#>  6 nbl   902cc282-5c76-1… a3a2db1e-315c-… Sunr… SSH       NA          NA        
#>  7 nbl   2bb351af-9a98-1… 9d3363a1-15d5-… Team… NA        NA          NA        
#>  8 nbl   c01759f4-410c-1… 9b904554-a3da-… Next… NG4       NA          NA        
#>  9 nbl   bfb698fa-410c-1… 9a4c1a5d-8eea-… Nago… NDD       NA          NA        
#> 10 nbl   c00b6850-410c-1… 9807b93f-8b98-… Next… NA        NA          NA        
#> # ℹ 76 more rows
#> # ℹ 15 more variables: championships <chr>, website <chr>,
#> #   external_media_competitor_id <chr>, conference <chr>, division <chr>,
#> #   venue_name <chr>, venue_address <chr>, venue_state <chr>,
#> #   venue_country <chr>, venue_timezone <chr>, venue_latitude <dbl>,
#> #   venue_longitude <dbl>, venue_capacity <int>, conference_name <chr>,
#> #   division_name <chr>
# }
```
