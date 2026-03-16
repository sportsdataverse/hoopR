# **Get NBA Stats API League Leaders**

**Get NBA Stats API League Leaders**

**Get NBA Stats API League Leaders**

## Usage

``` r
nba_leagueleaders(
  active_flag = "",
  league_id = "00",
  per_mode = "Totals",
  scope = "S",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat_category = "PTS",
  ...
)
```

## Arguments

- active_flag:

  Active Flag

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- per_mode:

  Per Mode - Totals, PerGame, Per48

- scope:

  Scope - RS, S, Rookies

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs

- stat_category:

  Stat Category: PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: LeagueLeaders

**LeagueLeaders**

|           |           |
|-----------|-----------|
| col_name  | types     |
| PLAYER_ID | character |
| RANK      | character |
| PLAYER    | character |
| TEAM_ID   | character |
| TEAM      | character |
| GP        | character |
| MIN       | character |
| FGM       | character |
| FGA       | character |
| FG_PCT    | character |
| FG3M      | character |
| FG3A      | character |
| FG3_PCT   | character |
| FTM       | character |
| FTA       | character |
| FT_PCT    | character |
| OREB      | character |
| DREB      | character |
| REB       | character |
| AST       | character |
| STL       | character |
| BLK       | character |
| TOV       | character |
| PF        | character |
| PTS       | character |
| EFF       | character |
| AST_TOV   | character |
| STL_TOV   | character |

## Details

[League Leaders](https://www.nba.com/stats/leaders)

     nba_leagueleaders(league_id = '00')

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md)

## Author

Saiem Gilani
