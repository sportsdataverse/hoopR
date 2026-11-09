# **Get ESPN Women's College Basketball Event Odds**

Returns the live game situation for one MBB event: timeouts remaining,
team fouls, fouls to give, bonus state, and a `$ref` to the last play.
During a live game this reflects current state; after the game ends the
values are frozen.

Returns pre-game predictor statistics for one MBB event in long format:
one row per (team x statistic). Typical stats include matchup quality,
predicted score, win probability, and team strength metrics. Returns
empty for events without predictor data (often the case for
already-played games).

Returns the per-team power-index `$ref` URLs for one MBB event. Coverage
is sparse - many events return zero items.

Returns the live game situation for one NBA event: timeouts remaining,
team fouls, fouls to give, bonus state, and a `$ref` to the last play.
During a live game this reflects current state; after the game ends the
values are frozen.

Returns pre-game predictor statistics for one NBA event in long format:
one row per (team x statistic). Typical stats include matchup quality,
predicted score, win probability, and team strength metrics. Returns
empty for events without predictor data (often the case for
already-played games).

Returns the per-team power-index `$ref` URLs for one NBA event. Coverage
is sparse - many events return zero items.

## Usage

``` r
espn_mbb_game_odds(event_id, ...)

espn_mbb_game_officials(event_id, ...)

espn_mbb_game_broadcasts(event_id, ...)

espn_mbb_game_situation(event_id, ...)

espn_mbb_game_predictor(event_id, ...)

espn_mbb_game_powerindex(event_id, ...)

espn_nba_game_odds(event_id, ...)

espn_nba_game_officials(event_id, ...)

espn_nba_game_broadcasts(event_id, ...)

espn_nba_game_situation(event_id, ...)

espn_nba_game_predictor(event_id, ...)

espn_nba_game_powerindex(event_id, ...)
```

## Arguments

- event_id:

  ESPN event/game identifier (character or numeric).

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A `hoopR_data` tibble with one row per odds provider.

|                      |           |                                        |
|----------------------|-----------|----------------------------------------|
| col_name             | types     | description                            |
| event_id             | character | Unique event / game identifier (ESPN). |
| provider_id          | character | Unique identifier for provider.        |
| provider_name        | character | Provider name.                         |
| details              | character | Details.                               |
| over_under           | numeric   | Over under.                            |
| spread               | numeric   | Spread.                                |
| home_money_line      | integer   |                                        |
| away_money_line      | integer   |                                        |
| home_team_odds_open  | numeric   |                                        |
| home_team_odds_close | numeric   |                                        |
| away_team_odds_open  | numeric   |                                        |
| away_team_odds_close | numeric   |                                        |

A `hoopR_data` tibble with one row per official assigned to the game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_id | character | Unique event / game identifier (ESPN). |
| official_id | character | Unique official / referee identifier. |
| full_name | character | Player's full name. |
| display_name | character | Display name. |
| position_id | character | Unique position identifier. |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| position_type | character |  |
| order | integer | Display order within the result set. |

A `hoopR_data` tibble with one row per broadcast outlet for the game.

|                 |           |                                        |
|-----------------|-----------|----------------------------------------|
| col_name        | types     | description                            |
| event_id        | character | Unique event / game identifier (ESPN). |
| broadcast_id    | character |                                        |
| type_id         | character | Type identifier (numeric).             |
| type_short_name | character |                                        |
| type_long_name  | character |                                        |
| market_id       | character |                                        |
| market_type     | character |                                        |
| names           | character |                                        |
| lang            | character |                                        |
| region          | character | Region label.                          |

A single-row tibble with timeouts + fouls for both teams.

A long tibble with rows for both home and away teams.

A tibble with one row per team-game power-index entry.

A `hoopR_data` tibble with one row per odds provider.

|                      |           |                                        |
|----------------------|-----------|----------------------------------------|
| col_name             | types     | description                            |
| event_id             | character | Unique event / game identifier (ESPN). |
| provider_id          | character | Unique identifier for provider.        |
| provider_name        | character | Provider name.                         |
| details              | character | Details.                               |
| over_under           | numeric   | Over under.                            |
| spread               | numeric   | Spread.                                |
| home_money_line      | integer   |                                        |
| away_money_line      | integer   |                                        |
| home_team_odds_open  | numeric   |                                        |
| home_team_odds_close | numeric   |                                        |
| away_team_odds_open  | numeric   |                                        |
| away_team_odds_close | numeric   |                                        |

A `hoopR_data` tibble with one row per official assigned to the game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_id | character | Unique event / game identifier (ESPN). |
| official_id | character | Unique official / referee identifier. |
| full_name | character | Player's full name. |
| display_name | character | Display name. |
| position_id | character | Unique position identifier. |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| position_type | character |  |
| order | integer | Display order within the result set. |

A `hoopR_data` tibble with one row per broadcast outlet for the game.

|                 |           |                                        |
|-----------------|-----------|----------------------------------------|
| col_name        | types     | description                            |
| event_id        | character | Unique event / game identifier (ESPN). |
| broadcast_id    | character |                                        |
| type_id         | character | Type identifier (numeric).             |
| type_short_name | character |                                        |
| type_long_name  | character |                                        |
| market_id       | character |                                        |
| market_type     | character |                                        |
| names           | character |                                        |
| lang            | character |                                        |
| region          | character | Region label.                          |

A single-row tibble with timeouts + fouls for both teams.

A long tibble with rows for both home and away teams.

A tibble with one row per team-game power-index entry.

## Details

**Get ESPN MBB Event Predictor (Pre-game)**

**Get ESPN MBB Event Power Index Index**

**Get ESPN NBA Event Predictor (Pre-game)**

**Get ESPN NBA Event Power Index Index**

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_game_odds(event_id = "401256760")
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Odds (event_id=401256760) from ESPN.com ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 9 × 12
#>   event_id  provider_id provider_name  details over_under spread home_money_line
#>   <chr>     <chr>       <chr>          <chr>        <dbl>  <dbl>           <int>
#> 1 401256760 38          Caesars (New … FSU -1…       136.   -1.5              NA
#> 2 401256760 45          Caesars Sport… FSU -1…       134.   -1.5              NA
#> 3 401256760 43          Caesars Sport… FSU -1…       136.   -1.5              NA
#> 4 401256760 36          Unibet         FSU -1…       136.   -1.5              NA
#> 5 401256760 25          Westgate       FSU -1…       135    -1.5              NA
#> 6 401256760 1001        accuscore      FSU -1…       135    -1.5              NA
#> 7 401256760 1004        consensus      FSU -1…       136.   -1.5              NA
#> 8 401256760 1003        numberfire     FSU -1…       134.   -1.5              NA
#> 9 401256760 1002        teamrankings   FSU -1        134.   -1                NA
#> # ℹ 5 more variables: away_money_line <int>, home_team_odds_open <dbl>,
#> #   home_team_odds_close <dbl>, away_team_odds_open <dbl>,
#> #   away_team_odds_close <dbl>
# }
# \donttest{
  espn_mbb_game_officials(event_id = "401256760")
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Officials (event_id=401256760) from ESPN.c
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 3 × 8
#>   event_id  official_id full_name     display_name  position_id position_name
#>   <chr>     <chr>       <chr>         <chr>         <chr>       <chr>        
#> 1 401256760 70901       Doug Shows    Doug Shows    40          Referee      
#> 2 401256760 69487       Lee Cassell   Lee Cassell   40          Referee      
#> 3 401256760 2615317     Ted Valentine Ted Valentine 40          Referee      
#> # ℹ 2 more variables: position_type <chr>, order <int>
# }
# \donttest{
  espn_mbb_game_broadcasts(event_id = "401256760")
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Broadcasts (event_id=401256760) from ESPN.
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 1 × 10
#>   event_id  broadcast_id type_id type_short_name type_long_name market_id
#>   <chr>     <chr>        <chr>   <chr>           <chr>          <chr>    
#> 1 401256760 NA           1       TV              Television     1        
#> # ℹ 4 more variables: market_type <chr>, names <chr>, lang <chr>, region <chr>
# }
# \donttest{
  espn_mbb_game_situation(event_id = 401256760)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Situation ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 1 × 15
#>   league                  event_id  home_timeouts_current home_timeouts_remain…¹
#>   <chr>                   <chr>                     <int>                  <int>
#> 1 mens-college-basketball 401256760                     0                      0
#> # ℹ abbreviated name: ¹​home_timeouts_remaining
#> # ℹ 11 more variables: away_timeouts_current <int>,
#> #   away_timeouts_remaining <int>, home_team_fouls <int>,
#> #   home_team_fouls_current <int>, home_fouls_to_give <int>,
#> #   home_bonus_state <chr>, away_team_fouls <int>,
#> #   away_team_fouls_current <int>, away_fouls_to_give <int>,
#> #   away_bonus_state <chr>, last_play_ref <chr>
# }
# \donttest{
  espn_mbb_game_predictor(event_id = 401256760)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Predictor ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 16 × 13
#>    league        event_id name  short_name last_modified side  team_id stat_name
#>    <chr>         <chr>    <chr> <chr>      <chr>         <chr> <chr>   <chr>    
#>  1 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      matchupq…
#>  2 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      rawgames…
#>  3 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      teampred…
#>  4 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      teampred…
#>  5 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      opponent…
#>  6 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      gameProj…
#>  7 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      teamChan…
#>  8 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… home  52      teamChan…
#>  9 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      matchupq…
#> 10 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      rawgames…
#> 11 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      teampred…
#> 12 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      teampred…
#> 13 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      opponent…
#> 14 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      gameProj…
#> 15 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      teamChan…
#> 16 mens-college… 4012567… Flor… FLA @ FSU  2020-12-12T1… away  57      teamChan…
#> # ℹ 5 more variables: stat_display <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>, team_ref <chr>
# }
# \donttest{
  espn_mbb_game_powerindex(event_id = 401256760)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Power Index ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 2 × 4
#>   league                  event_id  team_id ref                                 
#>   <chr>                   <chr>     <chr>   <chr>                               
#> 1 mens-college-basketball 401256760 52      http://sports.core.api.espn.com/v2/…
#> 2 mens-college-basketball 401256760 57      http://sports.core.api.espn.com/v2/…
# }
# \donttest{
  espn_nba_game_odds(event_id = "401283399")
#> ── ESPN NBA Event Odds (event_id=401283399) from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 16 × 12
#>    event_id  provider_id provider_name details over_under spread home_money_line
#>    <chr>     <chr>       <chr>         <chr>        <dbl>  <dbl>           <int>
#>  1 401283399 50          BetfairSport… MEM -7…       227    -7.5              NA
#>  2 401283399 38          Caesars       MEM -7        227    -7                NA
#>  3 401283399 44          Caesars (New… MEM -10        NA   -10                NA
#>  4 401283399 31          Caesars Spor… MEM -7        227    -7                NA
#>  5 401283399 45          Caesars Spor… MEM -7        227    -7                NA
#>  6 401283399 46          Caesars Spor… NA            236.   NA                NA
#>  7 401283399 43          Caesars Spor… MEM -7        227    -7                NA
#>  8 401283399 47          MGM           MEM -6…       228.   -6.5              NA
#>  9 401283399 48          PointsBet     MEM -7        226.   -7                NA
#> 10 401283399 41          SugarHouse    MEM -7…       226.   -7.5              NA
#> 11 401283399 36          Unibet        MEM -7…       226.   -7.5              NA
#> 12 401283399 25          Westgate      MEM -7        227    -7                NA
#> 13 401283399 1001        accuscore     MEM -7        227    -7                NA
#> 14 401283399 1004        consensus     MEM -7        227    -7                NA
#> 15 401283399 1003        numberfire    MEM -7        228    -7                NA
#> 16 401283399 1002        teamrankings  MEM -7        228    -7                NA
#> # ℹ 5 more variables: away_money_line <int>, home_team_odds_open <dbl>,
#> #   home_team_odds_close <dbl>, away_team_odds_open <dbl>,
#> #   away_team_odds_close <dbl>
# }
# \donttest{
  espn_nba_game_officials(event_id = "401283399")
#> ── ESPN NBA Event Officials (event_id=401283399) from ESPN.com ── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 3 × 8
#>   event_id  official_id full_name   display_name position_id position_name
#>   <chr>     <chr>       <chr>       <chr>        <chr>       <chr>        
#> 1 401283399 6856        Eric Lewis  Eric Lewis   40          Referee      
#> 2 401283399 2612372     Jacyn Goble Jacyn Goble  40          Referee      
#> 3 401283399 4394825     Evan Scott  Evan Scott   40          Referee      
#> # ℹ 2 more variables: position_type <chr>, order <int>
# }
# \donttest{
  espn_nba_game_broadcasts(event_id = "401283399")
#> ── ESPN NBA Event Broadcasts (event_id=401283399) from ESPN.com ────────────────
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 0 × 10
#> # ℹ 10 variables: event_id <chr>, broadcast_id <chr>, type_id <chr>,
#> #   type_short_name <chr>, type_long_name <chr>, market_id <chr>,
#> #   market_type <chr>, names <chr>, lang <chr>, region <chr>
# }
# \donttest{
  espn_nba_game_situation(event_id = 401283399)
#> ── ESPN NBA Event Situation ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 1 × 15
#>   league event_id  home_timeouts_current home_timeouts_remaining
#>   <chr>  <chr>                     <int>                   <int>
#> 1 nba    401283399                     3                       0
#> # ℹ 11 more variables: away_timeouts_current <int>,
#> #   away_timeouts_remaining <int>, home_team_fouls <int>,
#> #   home_team_fouls_current <int>, home_fouls_to_give <int>,
#> #   home_bonus_state <chr>, away_team_fouls <int>,
#> #   away_team_fouls_current <int>, away_fouls_to_give <int>,
#> #   away_bonus_state <chr>, last_play_ref <chr>
# }
# \donttest{
  espn_nba_game_predictor(event_id = 401283399)
#> ── ESPN NBA Event Predictor ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:47 UTC
#> # A tibble: 6 × 13
#>   league event_id  name         short_name last_modified side  team_id stat_name
#>   <chr>  <chr>     <chr>        <chr>      <chr>         <chr> <chr>   <chr>    
#> 1 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      gameProj…
#> 2 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      matchupQ…
#> 3 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      teamChan…
#> 4 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      teamPred…
#> 5 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      teamExpe…
#> 6 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      oppExpec…
#> # ℹ 5 more variables: stat_display <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_game_powerindex(event_id = 401283399)
#> ── ESPN NBA Event Power Index ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:48 UTC
#> # A tibble: 2 × 4
#>   league event_id  team_id ref                                                  
#>   <chr>  <chr>     <chr>   <chr>                                                
#> 1 nba    401283399 25      http://sports.core.api.espn.com/v2/sports/basketball…
#> 2 nba    401283399 29      http://sports.core.api.espn.com/v2/sports/basketball…
# }
```
