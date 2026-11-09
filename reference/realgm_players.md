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

A `hoopR_data` tibble with one row per active player:

|                |           |                                |
|----------------|-----------|--------------------------------|
| col_name       | types     | description                    |
| number         | integer   | Row number.                    |
| player         | character | Player name.                   |
| pos            | character | Position.                      |
| ht             | character | Listed height.                 |
| wt             | integer   | Listed weight (lbs).           |
| age            | numeric   | Age.                           |
| current_team   | character | Current NBA team.              |
| yos            | integer   | Years of service.              |
| pre_draft_team | character | Pre-draft team / school.       |
| draft_status   | character | Draft pick / undrafted status. |
| nationality    | character | Player nationality.            |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_players())
} # }
```
