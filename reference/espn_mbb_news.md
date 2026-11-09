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
#> ℹ Data updated: 2026-11-09 12:03:57 UTC
#> # A tibble: 5 × 8
#>         id type    headline     description published premium link_web league_id
#>      <int> <chr>   <chr>        <chr>       <chr>     <lgl>   <chr>    <chr>    
#> 1 50431078 Preview Iona visits… Iona Gaels… 2026-11-… FALSE   http://… 41       
#> 2 50431077 Preview Fairfield S… Fairfield … 2026-11-… FALSE   http://… 41       
#> 3 50431073 Preview No. 24 Vand… Memphis Ti… 2026-11-… FALSE   http://… 41       
#> 4 50431072 Preview McMillian l… Jackson St… 2026-11-… FALSE   http://… 41       
#> 5 50431071 Preview Central Mic… Youngstown… 2026-11-… FALSE   http://… 41       
# }
# \donttest{
  espn_nba_news(limit = 5)
#> ── ESPN NBA News from ESPN.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:03:57 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.04e7 Story Bobby M… With tax a… 2026-11-… FALSE   Bobby… https:/… 46       
#> 2  5.04e7 Prev… Los Ang… Los Angele… 2026-11-… FALSE   NA     http://… 46       
#> 3  5.04e7 Prev… Utah fa… Miami Heat… 2026-11-… FALSE   NA     http://… 46       
#> 4  5.04e7 Prev… Golden … New Orlean… 2026-11-… FALSE   NA     http://… 46       
#> 5  5.04e7 Prev… Washing… Washington… 2026-11-… FALSE   NA     http://… 46       
# }
```
