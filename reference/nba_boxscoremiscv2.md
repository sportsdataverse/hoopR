# **Get NBA Stats API Boxscore Misc V2**

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md)
instead.

## Usage

``` r
nba_boxscoremiscv2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)
```

## Arguments

- game_id:

  Game ID

- start_period:

  start_period

- end_period:

  end_period

- start_range:

  start_range

- end_range:

  end_range

- range_type:

  range_type

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: sqlPlayersMisc, sqlTeamsMisc

**sqlPlayersMisc**

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| GAME_ID            | character |
| TEAM_ID            | character |
| TEAM_ABBREVIATION  | character |
| TEAM_CITY          | character |
| PLAYER_ID          | character |
| PLAYER_NAME        | character |
| NICKNAME           | character |
| START_POSITION     | character |
| COMMENT            | character |
| MIN                | character |
| PTS_OFF_TOV        | character |
| PTS_2ND_CHANCE     | character |
| PTS_FB             | character |
| PTS_PAINT          | character |
| OPP_PTS_OFF_TOV    | character |
| OPP_PTS_2ND_CHANCE | character |
| OPP_PTS_FB         | character |
| OPP_PTS_PAINT      | character |
| BLK                | character |
| BLKA               | character |
| PF                 | character |
| PFD                | character |

**sqlTeamsMisc**

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| GAME_ID            | character |
| TEAM_ID            | character |
| TEAM_NAME          | character |
| TEAM_ABBREVIATION  | character |
| TEAM_CITY          | character |
| MIN                | character |
| PTS_OFF_TOV        | character |
| PTS_2ND_CHANCE     | character |
| PTS_FB             | character |
| PTS_PAINT          | character |
| OPP_PTS_OFF_TOV    | character |
| OPP_PTS_2ND_CHANCE | character |
| OPP_PTS_FB         | character |
| OPP_PTS_PAINT      | character |
| BLK                | character |
| BLKA               | character |
| PF                 | character |
| PFD                | character |

## Details

     nba_boxscoremiscv2(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoreadvancedv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv2.md),
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md),
[`nba_boxscorematchups()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchups.md),
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_boxscorescoringv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv2.md),
[`nba_boxscoresummaryv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md),
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

## Author

Saiem Gilani
