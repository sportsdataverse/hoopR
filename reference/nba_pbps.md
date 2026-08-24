# **Get NBA Stats API play-by-play (Multiple Games)**

**Get NBA Stats API play-by-play (Multiple Games)**

**Get NBA Stats API play-by-play (Multiple Games)**

## Usage

``` r
nba_pbps(
  game_ids = NULL,
  on_court = TRUE,
  version = "v3",
  nest_data = FALSE,
  ...
)
```

## Arguments

- game_ids:

  Game IDs

- on_court:

  IF TRUE will be added ID of players on court

- version:

  Play-by-play version ("v3" is the default, "v2" available from 2016-17
  onwards)

- nest_data:

  If TRUE returns nested data by game

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame: PlayByPlay

Columns as documented in the shared
[nba_pbp_schema](https://hoopR.sportsdataverse.org/reference/nba_pbp_schema.md)
table.

## Details

    y <- c("0022201086", "0022200021")

    nba_pbps(game_ids = y)
    nba_pbps(game_ids = y, version = "v2")

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

## Author

Jason Lee
