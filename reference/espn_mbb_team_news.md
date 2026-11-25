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
#> ℹ Data updated: 2026-11-25 03:29:15 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.02e7 Story UNC in … The Tar He… 2026-11-… FALSE   Paul … https:/… 41       
#> 2  5.06e7 Story Men's c… The update… 2026-11-… FALSE   Doug … https:/… 41       
#> 3  5.00e7 Story How top… How these … 2026-11-… FALSE   Jeff … https:/… 41       
#> 4  3.03e7 Etic… NCAA Br… Kelvin Sam… 2026-11-… FALSE   Joe L… https:/… 41       
#> 5  5.06e7 Story Breakin… Stats, rec… 2026-11-… FALSE   ESPN   https:/… 41       
# }
# \donttest{
  espn_nba_team_news(team_id = "13", limit = 5)
#> ── ESPN NBA Team News (team_id=13) from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-25 03:29:15 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  5.06e7 Head… Lakers … The Lakers… 2026-11-… FALSE   Dave … https:/… 46       
#> 2  4.16e7 Story Which N… In 2024, B… 2026-11-… FALSE   Keith… https:/… NA       
#> 3  5.06e7 Media Utah Ja… Utah Jazz … 2026-11-… FALSE   NA     https:/… 46       
#> 4  5.06e7 Recap Luka Do… — Luka Don… 2026-11-… FALSE   NA     http://… 46       
#> 5  5.06e7 Story Too-ear… So what if… 2026-11-… FALSE   Ben G… https:/… 46       
# }
```
