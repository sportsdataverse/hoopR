# **Get ESPN NBA game rosters**

**Get ESPN NBA game rosters**

## Usage

``` r
espn_nba_game_rosters(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A game rosters data frame

|                                            |           |
|--------------------------------------------|-----------|
| col_name                                   | types     |
| athlete_id                                 | integer   |
| athlete_uid                                | character |
| athlete_guid                               | character |
| athlete_type                               | character |
| sdr                                        | integer   |
| first_name                                 | character |
| last_name                                  | character |
| full_name                                  | character |
| athlete_display_name                       | character |
| short_name                                 | character |
| weight                                     | integer   |
| display_weight                             | character |
| height                                     | integer   |
| display_height                             | character |
| age                                        | integer   |
| date_of_birth                              | character |
| debut_year                                 | integer   |
| birth_place_city                           | character |
| birth_place_state                          | character |
| birth_place_country                        | character |
| slug                                       | character |
| headshot_href                              | character |
| headshot_alt                               | character |
| jersey                                     | character |
| position_id                                | integer   |
| position_name                              | character |
| position_display_name                      | character |
| position_abbreviation                      | character |
| position_leaf                              | logical   |
| linked                                     | logical   |
| years                                      | integer   |
| active                                     | logical   |
| contract_bird_status                       | integer   |
| contract_active                            | logical   |
| contract_active_1                          | logical   |
| contract_incoming_trade_value              | integer   |
| contract_outgoing_trade_value              | integer   |
| contract_minimum_salary_exception          | logical   |
| contract_option_type                       | integer   |
| contract_salary                            | integer   |
| contract_salary_remaining                  | integer   |
| contract_years_remaining                   | integer   |
| contract_trade_kicker_active               | logical   |
| contract_trade_kicker_percentage           | integer   |
| contract_trade_kicker_value                | integer   |
| contract_trade_kicker_trade_value          | integer   |
| contract_trade_restriction                 | logical   |
| contract_unsigned_foreign_pick             | logical   |
| contract_active_2                          | logical   |
| draft_display_text                         | character |
| draft_round                                | integer   |
| draft_year                                 | integer   |
| draft_selection                            | integer   |
| status_id                                  | integer   |
| status_name                                | character |
| status_type                                | character |
| status_abbreviation                        | character |
| starter                                    | logical   |
| valid                                      | logical   |
| did_not_play                               | logical   |
| display_name                               | character |
| reason                                     | character |
| ejected                                    | logical   |
| team_id                                    | integer   |
| team_guid                                  | character |
| team_uid                                   | character |
| team_slug                                  | character |
| team_location                              | character |
| team_name                                  | character |
| team_abbreviation                          | character |
| team_display_name                          | character |
| team_short_display_name                    | character |
| team_color                                 | character |
| team_alternate_color                       | character |
| team_is_active                             | logical   |
| team_is_all_star                           | logical   |
| logo_href                                  | character |
| logo_dark_href                             | character |
| logos_href_2                               | character |
| logos_href_3                               | character |
| game_id                                    | integer   |
| order                                      | integer   |
| home_away                                  | character |
| winner                                     | logical   |
| citizenship                                | character |
| contract_base_year_compensation_active     | logical   |
| contract_base_year_compensation_expiration | character |
| hand_type                                  | character |
| hand_abbreviation                          | character |
| hand_display_value                         | character |

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_nba_game_rosters(game_id = 401283399))
#> ── ESPN NBA Game Roster Information from ESPN.com ─────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 16:18:57 UTC
#> # A tibble: 24 × 175
#>    athlete_id athlete_uid  athlete_guid athlete_type    sdr first_name last_name
#>         <int> <chr>        <chr>        <chr>         <int> <chr>      <chr>    
#>  1    2993874 s:40~l:46~a… 0b5e3fdc-79… basketball   2.99e6 Kyle       Anderson 
#>  2    3155526 s:40~l:46~a… 653c07b5-85… basketball   3.16e6 Dillon     Brooks   
#>  3       6477 s:40~l:46~a… 585a3d05-44… basketball   2.56e6 Jonas      Valanciu…
#>  4    3135045 s:40~l:46~a… fedd8adf-a9… basketball   3.14e6 Grayson    Allen    
#>  5    4279888 s:40~l:46~a… de5f87e0-85… basketball   4.28e6 Ja         Morant   
#>  6    3906665 s:40~l:46~a… ac9aa77d-db… basketball   3.91e6 Brandon    Clarke   
#>  7    3908903 s:40~l:46~a… 6445df83-a2… basketball   3.91e6 Sean       McDermott
#>  8    4277964 s:40~l:46~a… 4b87dfe2-26… basketball   4.28e6 Xavier     Tillman  
#>  9    3134932 s:40~l:46~a… d4c8df92-1b… basketball   3.13e6 John       Konchar  
#> 10    3135046 s:40~l:46~a… c4cddbcc-95… basketball   3.14e6 Tyus       Jones    
#> # ℹ 14 more rows
#> # ℹ 168 more variables: full_name <chr>, athlete_display_name <chr>,
#> #   short_name <chr>, weight <int>, display_weight <chr>, height <int>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>, debut_year <int>,
#> #   birth_place_city <chr>, birth_place_state <chr>, birth_place_country <chr>,
#> #   citizenship <chr>, slug <chr>, headshot_href <chr>, headshot_alt <chr>,
#> #   athlete_jersey_number <chr>, position_id <int>, position_name <chr>, …
# }
```
