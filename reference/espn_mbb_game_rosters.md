# **Get ESPN men's college basketball game rosters**

**Get ESPN men's college basketball game rosters**

## Usage

``` r
espn_mbb_game_rosters(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A game rosters data frame

|                          |           |
|--------------------------|-----------|
| col_name                 | types     |
| athlete_id               | integer   |
| athlete_uid              | character |
| athlete_guid             | character |
| athlete_type             | character |
| sdr                      | integer   |
| first_name               | character |
| last_name                | character |
| full_name                | character |
| athlete_display_name     | character |
| short_name               | character |
| weight                   | integer   |
| display_weight           | character |
| height                   | integer   |
| display_height           | character |
| age                      | integer   |
| date_of_birth            | character |
| birth_place_city         | character |
| birth_place_state        | character |
| birth_place_country      | character |
| slug                     | character |
| headshot_href            | character |
| headshot_alt             | character |
| jersey                   | character |
| hand_type                | character |
| hand_abbreviation        | character |
| hand_display_value       | character |
| position_id              | integer   |
| position_name            | character |
| position_display_name    | character |
| position_abbreviation    | character |
| position_leaf            | logical   |
| linked                   | logical   |
| experience_years         | integer   |
| experience_display_value | character |
| experience_abbreviation  | character |
| active                   | logical   |
| draft_display_text       | character |
| draft_round              | integer   |
| draft_year               | integer   |
| draft_selection          | integer   |
| status_id                | integer   |
| status_name              | character |
| status_type              | character |
| status_abbreviation      | character |
| starter                  | logical   |
| valid                    | logical   |
| did_not_play             | logical   |
| display_name             | character |
| ejected                  | logical   |
| team_id                  | integer   |
| team_guid                | character |
| team_uid                 | character |
| team_sdr                 | integer   |
| team_slug                | character |
| team_location            | character |
| team_name                | character |
| team_nickname            | character |
| team_abbreviation        | character |
| team_display_name        | character |
| team_short_display_name  | character |
| team_color               | character |
| team_alternate_color     | character |
| is_active                | logical   |
| is_all_star              | logical   |
| logo_href                | character |
| logo_dark_href           | character |
| game_id                  | integer   |
| order                    | integer   |
| home_away                | character |
| winner                   | logical   |
| roster_href              | character |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_game_rosters(game_id = 401256760))
#> ── ESPN MBB Game Roster Information from ESPN.com ─────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 18:14:25 UTC
#> # A tibble: 34 × 151
#>    athlete_id athlete_uid  athlete_guid athlete_type    sdr first_name last_name
#>         <int> <chr>        <chr>        <chr>         <int> <chr>      <chr>    
#>  1    4277850 s:40~l:41~a… 7b156c52-fa… basketball   4.28e6 RaiQuan    Gray     
#>  2    4432829 s:40~l:41~a… 2734604d-09… basketball   4.43e6 Balsa      Koprivica
#>  3    4433134 s:40~l:41~a… dd0bb1da-07… basketball   4.43e6 Scottie    Barnes   
#>  4    4277854 s:40~l:41~a… f44291c9-0d… basketball   4.28e6 MJ         Walker   
#>  5    4277852 s:40~l:41~a… f376da3f-46… basketball   4.28e6 Anthony    Polite   
#>  6    4279098 s:40~l:41~a… 89f097ed-f5… basketball   4.28e6 Malik      Osborne  
#>  7    4701240 s:40~l:41~a… f35c5378-4b… basketball   4.70e6 Tanor      Ngom     
#>  8    4683134 s:40~l:41~a… f878c598-70… basketball   4.68e6 Quincy     Ballard  
#>  9    4701239 s:40~l:41~a… 88820814-39… basketball   4.70e6 Sardaar    Calhoun  
#> 10    4592191 s:40~l:41~a… 066a390d-78… basketball   4.59e6 Nathanael  Jack     
#> # ℹ 24 more rows
#> # ℹ 144 more variables: full_name <chr>, athlete_display_name <chr>,
#> #   short_name <chr>, weight <int>, display_weight <chr>, height <int>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>,
#> #   birth_place_city <chr>, birth_place_state <chr>, birth_place_country <chr>,
#> #   birth_country_alternate_id <chr>, birth_country_abbreviation <chr>,
#> #   slug <chr>, headshot_href <chr>, headshot_alt <chr>, …
# }
```
