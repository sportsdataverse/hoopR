# **Get ESPN MBB News**

**Get ESPN MBB News**

**Get ESPN Women's College Basketball News**

**Get ESPN NBA News**

**Get ESPN NBA News**

## Usage

``` r
espn_mbb_news(limit = 50)

espn_nba_news(limit = 50)
```

## Arguments

- limit:

  integer. Maximum number of articles to return. Default `50`.

## Value

Returns a tibble of news articles.

Columns as documented in the shared
[espn_mbb_news_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_news_schema.md)
table.

Returns a tibble of news articles.

Columns as documented in the shared
[espn_mbb_news_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_news_schema.md)
table.

## Details

Retrieve ESPN women's college basketball news. Uses
`getOption("hoopR.proxy")` or `http_proxy`/`https_proxy` environment
variables for proxy configuration (per-call proxy override is not
supported for ESPN wrappers).

Retrieve ESPN NBA news. Uses `getOption("hoopR.proxy")` or
`http_proxy`/`https_proxy` environment variables for proxy configuration
(per-call proxy override is not supported for ESPN wrappers).

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_news(limit = 5)
#> ── ESPN MENS-COLLEGE-BASKETBALL News from ESPN.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:22 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.04e7 Head… FSU hir… Florida St… 2026-11-… FALSE   Andre… https:/… 23       
#> 2  5.04e7 Prev… Iona vi… Iona Gaels… 2026-11-… FALSE   NA     http://… 41       
#> 3  5.04e7 Prev… Fairfie… Fairfield … 2026-11-… FALSE   NA     http://… 41       
#> 4  5.04e7 Prev… No. 24 … Memphis Ti… 2026-11-… FALSE   NA     http://… 41       
#> 5  5.04e7 Prev… McMilli… Jackson St… 2026-11-… FALSE   NA     http://… 41       
# }
# \donttest{
  espn_nba_news(limit = 5)
#> ── ESPN NBA News from ESPN.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:22 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.04e7 Story Fantasy… "Steve Ale… 2026-11-… FALSE   Steve… https:/… 3090     
#> 2  5.00e7 Story NBA buz… "The NBA i… 2026-11-… FALSE   ESPN … https:/… 46       
#> 3  5.04e7 Head… Giannis… "Giannis A… 2026-11-… FALSE   NA     https:/… 46       
#> 4  5.04e7 Story Bobby M… "With tax … 2026-11-… FALSE   Bobby… https:/… 46       
#> 5  5.04e7 Story What's … "At 4-6, t… 2026-11-… FALSE   Ramon… https:/… 46       
# }
```
