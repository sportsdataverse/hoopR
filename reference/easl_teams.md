# **Get EASL Teams**

The 12 ACTIVE EASL teams (historical teams resolve only through
easl_team).

Endpoint: `GET https://easl.joshricha.com/api/v1/teams`

## Usage

``` r
easl_teams()
```

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(easl_teams())
#> ── EASL Teams from easl.joshricha.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:59:42 UTC
#> # A tibble: 12 × 22
#>    team_row_id team_id          name  name_native code_latin code_local standard
#>          <int> <chr>            <chr> <chr>       <chr>      <chr>      <chr>   
#>  1           1 0548e9a7-99e0-1… Alva… NA           NA        NA         ELITE   
#>  2           2 27492b3f-5ada-1… Hong… Hong Kong … "HKE"      HKE        ELITE   
#>  3           4 6c173781-a6bf-1… Maca… Macau Hou … "MHC"      MHC        ELITE   
#>  4           5 71f8b351-5acf-1… Busa… Busan KCC … "KCC"      KCC        ELITE   
#>  5           8 86515908-b0f5-1… Taip… NA          "TFB"      富邦勇士   ELITE   
#>  6          11 865db37a-b0f5-1… Ryuk… 琉球ゴールデンキング… ""         RGK        ELITE   
#>  7          14 992dc7e4-a6c0-1… TSG … TSG Ghosth… "TSG"      TSG        ELITE   
#>  8          16 9f419ff5-a6be-1… Abra… Abra Weave… "ABR"      ABR        ELITE   
#>  9          18 a6c6b0a0-a6c0-1… Naga… Nagasaki V… "NAG"      NAG        ELITE   
#> 10          20 b9a6e682-a6bf-1… Goya… Goyang Son… "SON"      SON        ELITE   
#> 11          22 cbf7cf59-99df-1… Sout… NA           NA        BRO        ELITE   
#> 12          25 f170040e-5ad9-1… Taoy… Taoyuan Pa… ""         TPP        ELITE   
#> # ℹ 15 more variables: age_group <chr>, gender <chr>, status <chr>,
#> #   primary_color <chr>, secondary_color <chr>, tertiary_color <chr>,
#> #   logo <chr>, website <chr>, facebook_username <chr>, twitter_username <chr>,
#> #   instagram_username <chr>, wikipedia_url <chr>, organization_id <chr>,
#> #   created_at <chr>, updated_at <chr>
# }
```
