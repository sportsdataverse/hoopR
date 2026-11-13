# **Get ESPN men's college basketball schedule for a specific year**

**Get ESPN men's college basketball schedule for a specific year**

**Get ESPN NBA schedule for a specific year**

## Usage

``` r
espn_mbb_scoreboard(season)

espn_nba_scoreboard(season)
```

## Arguments

- season:

  Either numeric or character

## Value

A `hoopR_data` tibble with one row per game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| matchup | character | Matchup. |
| matchup_short | character | Matchup short. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| season_slug | character | Season slug. |
| game_id | integer | Unique game identifier. |
| game_uid | character | Game uid. |
| game_date | Date | Game date (YYYY-MM-DD). |
| attendance | integer | Reported attendance. |
| status_name | character | Status label. |
| broadcast_market | character | Broadcast market label (e.g. 'national', 'home'). |
| broadcast_name | character | Broadcast name. |
| start_date | character | Start date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| home_team_name | character | Home team name. |
| home_team_logo | character | Home team logo URL. |
| home_team_abb | character | Home team's team abb. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_location | character | Home team's team location. |
| home_team_full_name | character | Full home team name (e.g. 'Las Vegas Aces'). |
| home_team_color | character | Home team primary color (hex). |
| home_score | integer | Home team score at the time of the play. |
| home_win | integer | Home team's win. |
| home_record | character | Home win-loss record. |
| away_team_name | character | Away team name. |
| away_team_logo | character | Away team logo URL. |
| away_team_abb | character | Away team's team abb. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_location | character | Away team's team location. |
| away_team_full_name | character | Full away team name (e.g. 'Las Vegas Aces'). |
| away_team_color | character | Away team primary color (hex). |
| away_score | integer | Away team score at the time of the play. |
| away_win | integer | Away team's win. |
| away_record | character | Away win-loss record. |

A `hoopR_data` tibble with one row per game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| matchup | character | Matchup. |
| matchup_short | character | Matchup short. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| season_slug | character | Season slug. |
| game_id | integer | Unique game identifier. |
| game_uid | character | Game uid. |
| game_date | Date | Game date (YYYY-MM-DD). |
| attendance | integer | Reported attendance. |
| notes | logical | Free-form notes attached to the record. |
| status_name | character | Status label. |
| broadcasts | logical | JSON array of broadcast records. |
| start_date | character | Start date (YYYY-MM-DD). |
| geo_broadcasts | logical | Geo broadcasts. |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| home_team_name | character | Home team name. |
| home_team_logo | character | Home team logo URL. |
| home_team_abb | character | Home team's team abb. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_location | character | Home team's team location. |
| home_team_full_name | character | Full home team name (e.g. 'Las Vegas Aces'). |
| home_team_color | character | Home team primary color (hex). |
| home_score | integer | Home team score at the time of the play. |
| home_win | integer | Home team's win. |
| home_record | character | Home win-loss record. |
| away_team_name | character | Away team name. |
| away_team_logo | character | Away team logo URL. |
| away_team_abb | character | Away team's team abb. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_location | character | Away team's team location. |
| away_team_full_name | character | Full away team name (e.g. 'Las Vegas Aces'). |
| away_team_color | character | Away team primary color (hex). |
| away_score | integer | Away team score at the time of the play. |
| away_win | integer | Away team's win. |
| away_record | character | Away win-loss record. |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Examples

``` r

# Get schedule from date 2022-11-17
# \donttest{
try(espn_mbb_scoreboard(season = "20221117"))
#> ✖ 2026-11-13 13:58:00.003051: Invalid arguments or no scoreboard data for 20221117 available!
#> ✖ Args: group = "56", season_dates = "20221117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-11-13 13:58:00.139752: Invalid arguments or no scoreboard data for 20221117 available!
#> ✖ Args: group = "55", season_dates = "20221117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-11-13 13:58:00.369577: Invalid arguments or no scoreboard data for 20221117 available!
#> ✖ Args: group = "100", season_dates = "20221117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ── ESPN MBB Scoreboard Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:58:00 UTC
#> # A tibble: 50 × 36
#>    matchup         matchup_short season season_type season_slug game_id game_uid
#>    <chr>           <chr>          <int>       <int> <chr>         <int> <chr>   
#>  1 South Carolina… SCST @ UK       2023           2 regular-se…  4.01e8 s:40~l:…
#>  2 UC Riverside H… UCR @ CREI      2023           2 regular-se…  4.01e8 s:40~l:…
#>  3 Utah Tech Trai… UTU @ ARIZ      2023           2 regular-se…  4.01e8 s:40~l:…
#>  4 Furman Paladin… FUR VS PSU      2023           2 regular-se…  4.01e8 s:40~l:…
#>  5 Colorado Buffa… COLO VS MASS    2023           2 regular-se…  4.01e8 s:40~l:…
#>  6 Old Dominion M… ODU VS VT       2023           2 regular-se…  4.01e8 s:40~l:…
#>  7 Murray State R… MUR VS TA&M     2023           2 regular-se…  4.01e8 s:40~l:…
#>  8 Colorado State… CSU VS SC       2023           2 regular-se…  4.01e8 s:40~l:…
#>  9 Saint Francis … SFPA @ BTLR     2023           2 regular-se…  4.01e8 s:40~l:…
#> 10 Kansas City Ro… KC @ KSU        2023           2 regular-se…  4.01e8 s:40~l:…
#> # ℹ 40 more rows
#> # ℹ 29 more variables: game_date <date>, attendance <int>,
#> #   play_by_play_available <lgl>, status_name <chr>, broadcast_market <chr>,
#> #   broadcast_name <chr>, start_date <chr>, broadcast <chr>,
#> #   game_date_time <dttm>, home_team_name <chr>, home_team_logo <chr>,
#> #   home_team_abb <chr>, home_team_id <int>, home_team_location <chr>,
#> #   home_team_full_name <chr>, home_team_color <chr>, home_score <int>, …
# }

# Get schedule from date 2022-11-17 (returns 1000 results, max allowable.)
# \donttest{
try(espn_nba_scoreboard(season = 20230423))
#> ── ESPN NBA Scoreboard Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:58:00 UTC
#> # A tibble: 4 × 37
#>   matchup          matchup_short season season_type season_slug game_id game_uid
#>   <chr>            <chr>          <int>       <int> <chr>         <int> <chr>   
#> 1 Cleveland Caval… CLE @ NY        2023           3 post-season  4.02e8 s:40~l:…
#> 2 Sacramento King… SAC @ GS        2023           3 post-season  4.02e8 s:40~l:…
#> 3 Boston Celtics … BOS @ ATL       2023           3 post-season  4.02e8 s:40~l:…
#> 4 Denver Nuggets … DEN @ MIN       2023           3 post-season  4.02e8 s:40~l:…
#> # ℹ 30 more variables: game_date <date>, attendance <int>,
#> #   play_by_play_available <lgl>, status_name <chr>, broadcast_market <chr>,
#> #   broadcast_name <chr>, start_date <chr>, broadcast <chr>, highlights <lgl>,
#> #   game_date_time <dttm>, home_team_name <chr>, home_team_logo <chr>,
#> #   home_team_abb <chr>, home_team_id <int>, home_team_location <chr>,
#> #   home_team_full_name <chr>, home_team_color <chr>, home_score <int>,
#> #   home_win <int>, home_record <chr>, away_team_name <chr>, …
# }
```
