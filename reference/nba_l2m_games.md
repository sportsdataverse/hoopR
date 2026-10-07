# Fetch the list of NBA games with a Last Two Minute report for a season

Scrapes official.nba.com's season index page. JSON L2M reports exist
only from 2019-01-01 onward; earlier seasons' index pages list PDFs,
which this function ignores (use a release loader for that history once
published). Port of the scraping logic in
[atlhawksfanatic/L2M](https://github.com/atlhawksfanatic/L2M) (MIT, (c)
2019 atlhawksfanatic).

## Usage

``` r
nba_l2m_games(season, proxy = NULL)
```

## Arguments

- season:

  integer, or a numeric-like string. NBA season, END year (e.g. `2026`
  or `"2026"` for 2025-26).

- proxy:

  Optional proxy: a URL string (e.g. `"http://host:port"`) or a named
  list of
  [`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html)
  arguments. `NULL` (the default) falls back to
  `getOption("hoopR.proxy")`, then the `http_proxy`/`https_proxy`
  environment variables.

## Value

A `hoopR_data` tibble, one row per unique game id in page order:

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | 10-digit zero-padded game id from the report link. |
| season | integer | Season end year passed in, stamped on every row. |
| season_type | character | Season type from the third digit of game_id, e.g. playoffs. |
| label | character | Matchup label text of the report link, edges trimmed. |

## Errors

Raises a classed condition instead of returning on failure. Both classes
inherit from `hoopR_error`, so one handler can catch either:

- `hoopR_no_data` – official.nba.com 404s the season's page (a season
  without one), or answers 403 with an S3 `AccessDenied` body.

- `hoopR_fetch_error` – the fetch failed (network error, rate limit,
  Akamai WAF block, any other HTTP status), or a 200 response is missing
  the expected "Last Two Minute" page marker (an Akamai interstitial, a
  blank body, or a redesigned page) – checked here, not in
  [`.parse_nba_l2m_games()`](https://hoopR.sportsdataverse.org/reference/dot-parse_nba_l2m_games.md),
  so the parser itself never raises.

An invalid argument is an ordinary error, raised before any request.

## See also

Other NBA Officiating Functions:
[`nba_l2m()`](https://hoopR.sportsdataverse.org/reference/nba_l2m.md),
[`nba_referee_assignments()`](https://hoopR.sportsdataverse.org/reference/nba_referee_assignments.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try({
    games <- nba_l2m_games(season = 2026)
    head(games)
  })
#> ── NBA L2M games listing (official.nba.com) ──────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-07 16:31:15 UTC
#> # A tibble: 6 × 4
#>   game_id    season season_type label                         
#>   <chr>       <int> <chr>       <chr>                         
#> 1 0042500405   2026 playoffs    Knicks 94, Spurs 90           
#> 2 0042500404   2026 playoffs    Knicks 107, Spurs 106         
#> 3 0042500403   2026 playoffs    Spurs 115, Knicks 111         
#> 4 0042500402   2026 playoffs    Knicks 105, Spurs 104         
#> 5 0042500401   2026 playoffs    Knicks 105, Spurs 95          
#> 6 0042500301   2026 playoffs    Knicks 115, Cavaliers 104 (OT)
# }
```
