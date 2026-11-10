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

A `hoopR_data` tibble with one row per news article.

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| id          | character | Id.                               |
| type        | character | Record type / category.           |
| headline    | character | News headline.                    |
| description | character | Long-form description text.       |
| published   | character | Publication timestamp (ISO 8601). |
| premium     | logical   |                                   |
| byline      | character | News article byline / author.     |
| link_web    | character | Web link / URL.                   |
| league_id   | character | League identifier ('10' = WNBA).  |

A `hoopR_data` tibble with one row per news article.

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| id          | character | Id.                               |
| type        | character | Record type / category.           |
| headline    | character | News headline.                    |
| description | character | Long-form description text.       |
| published   | character | Publication timestamp (ISO 8601). |
| premium     | logical   |                                   |
| byline      | character | News article byline / author.     |
| link_web    | character | Web link / URL.                   |
| league_id   | character | League identifier ('10' = WNBA).  |

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
#> ℹ Data updated: 2026-11-10 02:00:18 UTC
#> # A tibble: 5 × 8
#>         id type  headline       description published premium link_web league_id
#>      <int> <chr> <chr>          <chr>       <chr>     <lgl>   <chr>    <chr>    
#> 1 50437882 Recap Burton and Ha… — Markus B… 2026-11-… FALSE   http://… 41       
#> 2 50437863 Media Howard Bison … Howard Bis… 2026-11-… FALSE   https:/… 41       
#> 3 50437764 Media Nittany Lions… Nittany Li… 2026-11-… FALSE   https:/… 41       
#> 4 50437564 Recap John Mobley J… — John Mob… 2026-11-… FALSE   http://… 41       
#> 5 50437533 Media Marshall Thun… Marshall T… 2026-11-… FALSE   https:/… 41       
# }
# \donttest{
  espn_nba_news(limit = 5)
#> ── ESPN NBA News from ESPN.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:18 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.04e7 Head… Doc Riv… "Doc River… 2026-11-… FALSE   Marc … https:/… 46       
#> 2  5.04e7 Head… Luka Do… "Luka Donc… 2026-11-… FALSE   Dave … https:/… 46       
#> 3  5.04e7 Head… Bronny … "Lakers gu… 2026-11-… FALSE   NA     https:/… 46       
#> 4  5.00e7 Story NBA buz… "The NBA i… 2026-11-… FALSE   ESPN … https:/… 46       
#> 5  5.04e7 Story Monday'… "Andre Sne… 2026-11-… FALSE   Andre… https:/… 22000    
# }
```
