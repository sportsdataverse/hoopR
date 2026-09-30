# Parse a Last Two Minute report payload (internal)

Parse a Last Two Minute report payload (internal)

## Usage

``` r
.parse_nba_l2m(x)
```

## Arguments

- x:

  list. Result of `jsonlite::fromJSON(path, simplifyVector = TRUE)` on
  an official.nba.com `l2m/json/<game_id>.json` payload.

## Value

Named list of `hoopR_data` tibbles: `calls`, `game`, `stats`.
