# **Get ESPN NBA Free Agents**

**Get ESPN NBA Free Agents**

**Get ESPN NBA Free Agents**

## Usage

``` r
espn_nba_freeagents(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent NBA
  season.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)`.

## Value

A `hoopR_data` tibble with one row per free agent:

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| position | character | Listed roster position (G, F, C, etc.). |
| prior_team_id | character |  |
| status | character | Status label. |
| signed_team_id | character |  |
| signed_date | character |  |
| contract_value | character |  |
| contract_term_years | character |  |

## Details

Calls the ESPN core-v2 endpoint
`https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{year}/freeagents`.
As of 2026-05, this endpoint returns HTTP 500 for every season tested
and there is no documented replacement; the function consequently
returns an empty tibble and emits a CLI error message. It is retained so
that downstream code does not break if ESPN restores the endpoint, but
should not be relied on in the meantime.

## See also

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_nba_freeagents(season = 2025)
#> ✖ 2026-11-09 12:04:45.442755: Failed to retrieve ESPN NBA free agents for season 2025
#> ✖ Args: season = 2025
#> ✖ Error: The API returned an error
#> data frame with 0 columns and 0 rows
# }
```
