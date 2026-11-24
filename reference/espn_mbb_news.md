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
#> ℹ Data updated: 2026-11-24 20:41:46 UTC
#> # A tibble: 5 × 8
#>         id type  headline       description published premium link_web league_id
#>      <int> <chr> <chr>          <chr>       <chr>     <lgl>   <chr>    <chr>    
#> 1 50585593 Recap Beamer’s 31 l… — Trey Bea… 2026-11-… FALSE   http://… 41       
#> 2 50585527 Recap Rolison score… — Tyler Ro… 2026-11-… FALSE   http://… 41       
#> 3 50585456 Media Southern Utah… Southern U… 2026-11-… FALSE   https:/… 41       
#> 4 50585282 Media Belmont Bruin… Belmont Br… 2026-11-… FALSE   https:/… 41       
#> 5 50584814 Recap Paveletzke’s … — Jackson … 2026-11-… FALSE   http://… 41       
# }
# \donttest{
  espn_nba_news(limit = 5)
#> ── ESPN NBA News from ESPN.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-24 20:41:46 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.06e7 Story Fantasy… Eric Karab… 2026-11-… FALSE   Eric … https:/… 3090     
#> 2  5.06e7 Story Fantasy… Eric Moody… 2026-11-… FALSE   Eric … https:/… 22000    
#> 3  5.06e7 Head… Sources… The Timber… 2026-11-… FALSE   NA     https:/… 46       
#> 4  5.00e7 Story NBA buz… The NBA is… 2026-11-… FALSE   ESPN … https:/… 46       
#> 5  5.05e7 Story NBA Roo… Our first … 2026-11-… FALSE   Zach … https:/… 46       
# }
```
