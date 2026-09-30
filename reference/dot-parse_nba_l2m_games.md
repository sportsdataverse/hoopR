# Parse an L2M season listing page (internal)

Parse an L2M season listing page (internal)

## Usage

``` r
.parse_nba_l2m_games(html, season)
```

## Arguments

- html:

  character(1). HTML of the L2M season listing page.

- season:

  integer(1). NBA season (end year) to stamp onto every row.

## Value

A `hoopR_data`-ready tibble: `game_id`, `season`, `season_type`,
`label`.
