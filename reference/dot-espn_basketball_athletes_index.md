# Internal: ESPN basketball athletes index

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{year}/athletes`
with pagination. Progress messages are emitted via
[`cli::cli_inform()`](https://cli.r-lib.org/reference/cli_abort.html)
since the MBB roster can exceed 10,000 entries across many pages.

## Usage

``` r
.espn_basketball_athletes_index(
  league,
  season,
  active = TRUE,
  limit = 25000L,
  ...
)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- season:

  numeric. Season year.

- active:

  logical. Return only active athletes when `TRUE`.

- limit:

  integer. Maximum number of rows to return.

- ...:

  Unused; reserved for forward compatibility.

## Value

A `hoopR_data` tibble, or `NULL` on error.
