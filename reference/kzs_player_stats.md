# **Get KZS Player Season Stats**

A player's totals and per-game averages in each competition of one
season.

Endpoint:
`GET https://api.kzs.si/api/v1/public/players/{player_id}/stats`

## Usage

``` r
kzs_player_stats(player_id, season)
```

## Arguments

- player_id:

  (required) Player registry id (player_id in a box score or roster),
  e.g. 106285. Not the person id.

- season:

  (required) Season END year (2027 = 2026/2027); the wrapper maps it to
  KZS' opaque season id.

## Value

A `hoopR_data` tibble with one row per competition. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_player_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_player_stats(player_id = 106285, season = 2026))
#> ── KZS Player Season Stats from api.kzs.si ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:52:17 UTC
#> # A tibble: 2 × 51
#>   player_id season_id season competition_id    a1    a2    a3   pts   ass  blag
#>       <int>     <int>  <int>          <int> <int> <int> <int> <int> <int> <int>
#> 1    106285        26   2026            579   108   175   162   432   148    16
#> 2    106285        26   2026            584     9     8    12    25     3     1
#> # ℹ 41 more variables: blfv <int>, captain <int>, m1 <int>, m2 <int>, m3 <int>,
#> #   mins <dbl>, pfcm <int>, pfrv <int>, rd <int>, ro <int>, st <int>,
#> #   startinglineup <int>, tov <int>, played <int>, plus_minus <int>,
#> #   efficiency <int>, avgpts <dbl>, avga1 <dbl>, avga2 <dbl>, avga3 <dbl>,
#> #   avgass <dbl>, avgblag <dbl>, avgblfv <dbl>, avgm1 <dbl>, avgm2 <dbl>,
#> #   avgm3 <dbl>, avgmins <dbl>, avgpfcm <dbl>, avgpfrv <dbl>, avgrd <dbl>,
#> #   avgro <dbl>, avgsecs <int>, avgst <dbl>, avgtov <dbl>, …
# }
```
