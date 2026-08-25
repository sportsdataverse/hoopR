# **NBA Player Box Score with Team Context**

A traditional player box score with each player's team totals joined on
(tactic **C**).
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md)
returns player-grain `PlayerStats` and team-grain `TeamStats`
separately; this left-joins the team totals onto every player row by
`GAME_ID` + `TEAM_ID`, suffixing the team columns with `_team`.

## Usage

``` r
nba_tidy_boxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID (10-digit, zero-padded e.g. `"0022300061"`).

- ...:

  Additional arguments passed to
  [`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md).

## Value

A `hoopR_data` tibble, one row per player, with the player's stats and
their team's totals (team columns suffixed `_team`).

## See also

Other NBA Combined Datasets:
[`nba_tidy_franchise_history()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_franchise_history.md),
[`nba_tidy_player_profile()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_player_profile.md)

## Examples

``` r
# \donttest{
  try(nba_tidy_boxscore(game_id = "0022300061"))
#> ── NBA player box score with team context from stats.nba.com ──── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:32:31 UTC
#> # A tibble: 27 × 52
#>    GAME_ID    TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME NICKNAME
#>    <chr>      <chr>   <chr>             <chr>     <chr>     <chr>       <chr>   
#>  1 0022300061 161061… LAL               Los Ange… 1627752   Taurean Pr… Taurean 
#>  2 0022300061 161061… LAL               Los Ange… 2544      LeBron Jam… LeBron  
#>  3 0022300061 161061… LAL               Los Ange… 203076    Anthony Da… Anthony 
#>  4 0022300061 161061… LAL               Los Ange… 1630559   Austin Rea… Austin  
#>  5 0022300061 161061… LAL               Los Ange… 1626156   D'Angelo R… D'Angelo
#>  6 0022300061 161061… LAL               Los Ange… 1629060   Rui Hachim… Rui     
#>  7 0022300061 161061… LAL               Los Ange… 1629216   Gabe Vince… Gabe    
#>  8 0022300061 161061… LAL               Los Ange… 1629637   Jaxson Hay… Jaxson  
#>  9 0022300061 161061… LAL               Los Ange… 1629629   Cam Reddish Cam     
#> 10 0022300061 161061… LAL               Los Ange… 1626174   Christian … Christi…
#> # ℹ 17 more rows
#> # ℹ 45 more variables: START_POSITION <chr>, COMMENT <chr>, MIN <chr>,
#> #   FGM <chr>, FGA <chr>, FG_PCT <chr>, FG3M <chr>, FG3A <chr>, FG3_PCT <chr>,
#> #   FTM <chr>, FTA <chr>, FT_PCT <chr>, OREB <chr>, DREB <chr>, REB <chr>,
#> #   AST <chr>, STL <chr>, BLK <chr>, TO <chr>, PF <chr>, PTS <chr>,
#> #   PLUS_MINUS <chr>, TEAM_NAME <chr>, TEAM_ABBREVIATION_team <chr>,
#> #   TEAM_CITY_team <chr>, MIN_team <chr>, FGM_team <chr>, FGA_team <chr>, …
# }
```
