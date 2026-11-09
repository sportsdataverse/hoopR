# **RealGM NBA Player Index**

**Get the active NBA player index from RealGM (basketball.realgm.com).**

Returns RealGM's roster of active NBA players, including position,
listed height/weight, age, current team, years of service and pre-draft
team – the pre-draft / international detail RealGM is known for.

**Requires a headless browser.** RealGM is behind a Cloudflare
JavaScript challenge, so the `realgm_*()` functions drive headless
Chrome via the optional chromote package (install it and Google Chrome).
A plain HTTP client receives an HTTP 403 challenge page.

## Usage

``` r
realgm_players()
```

## Value

A `hoopR_data` tibble with one row per active player. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_players")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_players())
} # }
```
