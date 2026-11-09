# **Get ESPN MBB Team News**

**Get ESPN MBB Team News**

**Get ESPN Women's College Basketball Team News**

**Get ESPN NBA Team News**

**Get ESPN NBA Team News**

## Usage

``` r
espn_mbb_team_news(team_id, limit = 25)

espn_nba_team_news(team_id, limit = 25)
```

## Arguments

- team_id:

  character or integer. ESPN team ID (e.g. `2509` for UConn).

- limit:

  integer. Maximum number of articles to return. Default `25`.

## Value

Returns a tibble of team news articles.

Columns as documented in the shared
[espn_mbb_news_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_news_schema.md)
table.

Returns a tibble of team news articles.

Columns as documented in the shared
[espn_mbb_news_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_news_schema.md)
table.

## Details

Retrieve ESPN women's college basketball news for a specific team. Uses
`getOption("hoopR.proxy")` or `http_proxy`/`https_proxy` environment
variables for proxy configuration (per-call proxy override is not
supported for ESPN wrappers).

Retrieve ESPN NBA news for a specific team. Uses
`getOption("hoopR.proxy")` or `http_proxy`/`https_proxy` environment
variables for proxy configuration (per-call proxy override is not
supported for ESPN wrappers).

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
  espn_mbb_team_news(team_id = "150", limit = 5)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team News (team_id=150) from ESPN.com ──────────
#> ℹ Data updated: 2026-11-09 12:04:31 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.04e7 Prev… No. 6 M… Duke Blue … 2026-11-… FALSE   NA     http://… 41       
#> 2  5.04e7 Media Coastal… Coastal Ca… 2026-11-… FALSE   NA     https:/… 41       
#> 3  5.04e7 Recap Ngongba… — Patrick … 2026-11-… FALSE   NA     http://… 41       
#> 4  5.02e7 Story Early t… The highes… 2026-11-… FALSE   Paul … https:/… 41       
#> 5  5.04e7 Story The Bil… It's that … 2026-11-… FALSE   Jay B… https:/… 41       
# }
# \donttest{
  espn_nba_team_news(team_id = "13", limit = 5)
#> ── ESPN NBA Team News (team_id=13) from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:31 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.04e7 Prev… Los Ang… Los Angele… 2026-11-… FALSE   NA     http://… 46       
#> 2  4.16e7 Story Which N… In 2024, B… 2026-11-… FALSE   Keith… https:/… NA       
#> 3  5.04e7 Head… Reaves … Austin Rea… 2026-11-… FALSE   Dave … https:/… 46       
#> 4  5.04e7 Recap Austin … — Austin R… 2026-11-… FALSE   NA     http://… 46       
#> 5  5.04e7 Media Los Ang… Los Angele… 2026-11-… FALSE   NA     https:/… 46       
# }
```
