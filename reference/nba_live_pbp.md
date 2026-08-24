# **Get NBA Stats API Live play-by-play**

**Get NBA Stats API Live play-by-play**

**Get NBA Stats API Live play-by-play**

## Usage

``` r
nba_live_pbp(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame: PlayByPlay

Columns as documented in the shared
[nba_live_pbp_schema](https://hoopR.sportsdataverse.org/reference/nba_live_pbp_schema.md)
table.

## Details

     nba_live_pbp(game_id = '0022201086')

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

Other NBA Live Functions:
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
