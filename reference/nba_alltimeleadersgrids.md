# **Get NBA Stats API All-time Leaders Grid**

**Get NBA Stats API All-time Leaders Grid**

**Get NBA Stats API All-time Leaders Grid**

## Usage

``` r
nba_alltimeleadersgrids(
  league_id = "00",
  per_mode = "PerGame",
  season_type = "Regular Season",
  top_x = 10,
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- per_mode:

  Per Mode - PerGame, Totals

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- top_x:

  Top X

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: ASTLeaders, BLKLeaders,
DREBLeaders, FG3ALeaders, FG3MLeaders, FG3_PCTLeaders, FGALeaders,
FGMLeaders, FG_PCTLeaders, FTALeaders, FTMLeaders, FT_PCTLeaders,
GPLeaders, OREBLeaders, PFLeaders, PTSLeaders, REBLeaders, STLLeaders,
TOVLeaders

**GPLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| GP             | character |
| GP_RANK        | character |
| IS_ACTIVE_FLAG | character |

**PTSLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| PTS            | character |
| PTS_RANK       | character |
| IS_ACTIVE_FLAG | character |

**ASTLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| AST            | character |
| AST_RANK       | character |
| IS_ACTIVE_FLAG | character |

**STLLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| STL            | character |
| STL_RANK       | character |
| IS_ACTIVE_FLAG | character |

**OREBLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| OREB           | character |
| OREB_RANK      | character |
| IS_ACTIVE_FLAG | character |

**DREBLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| DREB           | character |
| DREB_RANK      | character |
| IS_ACTIVE_FLAG | character |

**REBLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| REB            | character |
| REB_RANK       | character |
| IS_ACTIVE_FLAG | character |

**BLKLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| BLK            | character |
| BLK_RANK       | character |
| IS_ACTIVE_FLAG | character |

**FGMLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FGM            | character |
| FGM_RANK       | character |
| IS_ACTIVE_FLAG | character |

**FGALeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FGA            | character |
| FGA_RANK       | character |
| IS_ACTIVE_FLAG | character |

**FG_PCTLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FG_PCT         | character |
| FG_PCT_RANK    | character |
| IS_ACTIVE_FLAG | character |

**TOVLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| TOV            | character |
| TOV_RANK       | character |
| IS_ACTIVE_FLAG | character |

**FG3MLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FG3M           | character |
| FG3M_RANK      | character |
| IS_ACTIVE_FLAG | character |

**FG3ALeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FG3A           | character |
| FG3A_RANK      | character |
| IS_ACTIVE_FLAG | character |

**FG3_PCTLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FG3_PCT        | character |
| FG3_PCT_RANK   | character |
| IS_ACTIVE_FLAG | character |

**PFLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| PF             | character |
| PF_RANK        | character |
| IS_ACTIVE_FLAG | character |

**FTMLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FTM            | character |
| FTM_RANK       | character |
| IS_ACTIVE_FLAG | character |

**FTALeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FTA            | character |
| FTA_RANK       | character |
| IS_ACTIVE_FLAG | character |

**FT_PCTLeaders**

|                |           |
|----------------|-----------|
| col_name       | types     |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| FT_PCT         | character |
| FT_PCT_RANK    | character |
| IS_ACTIVE_FLAG | character |

## Details

     nba_alltimeleadersgrids(league_id = '00')

## See also

Other NBA Leaders Functions:
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
