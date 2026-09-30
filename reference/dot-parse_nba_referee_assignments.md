# Parse a referee-assignments payload (internal)

Parse a referee-assignments payload (internal)

## Usage

``` r
.parse_nba_referee_assignments(x, league = "nba")
```

## Arguments

- x:

  list. Result of `jsonlite::fromJSON(path, simplifyVector = FALSE)` on
  an official.nba.com `get-game-officials` payload (top-level keys
  `nba`, `gl`, `wnba`).

- league:

  character(1). One of `"nba"`, `"gl"`, `"wnba"`.

## Value

Named list of `hoopR_data` tibbles: `officials`, `replay_center`.
