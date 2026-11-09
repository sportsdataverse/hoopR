# **EuroLeague Competitions**

**Get the competitions of the EuroLeague Competition Engine (EuroLeague
`E`, EuroCup `U`, ...).**

Endpoint: `GET https://api-live.euroleague.net/v2/competitions`

## Usage

``` r
euroleague_competitions()
```

## Value

A `hoopR_data` tibble with one row per competition. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_competitions")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sportsdataverse-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    euroleague_competitions()
  })
#> ── EuroLeague competitions from api-live.euroleague.net ───────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:53:32 UTC
#> # A tibble: 43 × 2
#>    name                   code 
#>    <chr>                  <chr>
#>  1 Adriatic League        AL   
#>  2 Belgium League         BE   
#>  3 Belgium National Cup   BEC  
#>  4 Bulgarian League       BU   
#>  5 Bulgarian National Cup BUC  
#>  6 Croatian League        CR   
#>  7 Croatian National Cup  CRC  
#>  8 Euroleague             E    
#>  9 English League         EN   
#> 10 English National Cup   ENC  
#> # ℹ 33 more rows
# }
```
