# **Get NBA Stats API play-by-play**

**Get NBA Stats API play-by-play**

**Get NBA Stats API play-by-play**

## Usage

``` r
nba_pbp(game_id, on_court = TRUE, version = "v3", p = NULL, ...)
```

## Arguments

- game_id:

  Game ID - 10-digit zero-padded ID (e.g., '0022201086')

- on_court:

  If TRUE (default), on-court player IDs are added for each play event.
  V3 uses
  [`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md)
  stint data; V2 infers lineups from substitution events.

- version:

  Play-by-play version - `"v3"` (default) or `"v2"`. V3 returns richer
  data with shot coordinates, shot values, and V3 action types. V2 is
  available from 2016-17 onwards.

- p:

  Optional progress object from `progressr` (default: NULL). Used
  internally by
  [`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md).

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame: PlayByPlay

Columns as documented in the shared
[nba_pbp_schema](https://hoopR.sportsdataverse.org/reference/nba_pbp_schema.md)
table.

## Details

     nba_pbp(game_id = '0022201086')
     nba_pbp(game_id = '0022201086', version = "v2")

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

## Author

Jason Lee
