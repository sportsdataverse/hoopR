# **Get ESPN NBA Transactions**

**Get ESPN NBA Transactions**

**Get ESPN NBA Transactions**

## Usage

``` r
espn_nba_transactions(season = most_recent_nba_season(), limit = 100, ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent NBA
  season.

- limit:

  Maximum number of transactions to return (integer). Default `100`.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)`.

## Value

A `hoopR_data` tibble with one row per transaction.

|                |           |                                   |
|----------------|-----------|-----------------------------------|
| col_name       | types     | description                       |
| transaction_id | character |                                   |
| date           | character | Date in YYYY-MM-DD format.        |
| type           | character | Record type / category.           |
| description    | character | Long-form description text.       |
| team_id        | character | Unique team identifier.           |
| athlete_id     | character | Unique athlete identifier (ESPN). |
| athlete_name   | character | Athlete display name (ESPN).      |
| from_team_id   | character |                                   |
| to_team_id     | character |                                   |

## Details

Calls the ESPN site-v2 endpoint
`https://site.api.espn.com/apis/site/v2/sports/basketball/nba/transactions?season={year}&limit={limit}`.
Releases have a `NULL` `to_team_id`; those are stored as `NA`. Returns
an empty tibble rather than erroring when no transactions are available.

## See also

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_nba_transactions(season = 2025, limit = 10)
#> ── ESPN NBA Transactions from ESPN.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:20 UTC
#> # A tibble: 10 × 9
#>    transaction_id date         type  description team_id athlete_id athlete_name
#>    <chr>          <chr>        <chr> <chr>       <chr>   <chr>      <chr>       
#>  1 NA             2025-12-31T… NA    Signed G R… 1       NA         NA          
#>  2 NA             2025-12-29T… NA    Signed C M… 28      NA         NA          
#>  3 NA             2025-12-26T… NA    Signed F M… 20      NA         NA          
#>  4 NA             2025-12-26T… NA    Signed C M… 11      NA         NA          
#>  5 NA             2025-12-24T… NA    Signed C P… 30      NA         NA          
#>  6 NA             2025-12-24T… NA    Waived G H… 20      NA         NA          
#>  7 NA             2025-12-23T… NA    Waived F D… 30      NA         NA          
#>  8 NA             2025-12-23T… NA    Signed C M… 1       NA         NA          
#>  9 NA             2025-12-22T… NA    Signed C C… 29      NA         NA          
#> 10 NA             2025-12-20T… NA    Signed C J… 11      NA         NA          
#> # ℹ 2 more variables: from_team_id <chr>, to_team_id <chr>
# }
```
