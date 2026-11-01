# **Get BNXT League Game Box Score**

Per-player box score of a finished game (one row per player line).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/boxscore/game/{competition_id}/{game_id}`

## Usage

``` r
sportpress_game_box(competition_id, game_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: Per-player box score of a finished game (one row
per player line). An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`sportpress_game_box`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id the box score was asked for (the body does not echo it). |
| competition_id | integer | Competition id the box score was asked for; checked against the game. |
| team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| roster_id | integer | Roster id of the line; null when the line has no player (15 of 14,142 sampled lines). |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| position_id | integer | Playing position id (key space: sportpress positions); null on 21 of 14,142 sampled lines. |
| position | character | Playing position: point_guard, shooting_guard, small_forward, power_forward or center. |
| starter | logical | True when the player was in the starting five. |
| jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
| minute | integer | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
| foul | integer | Personal fouls committed. |
| defensive_foul | integer | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
| dunk_made | integer | Dunks made (a subset of the two-point field goals). |
| dunk_all | integer | Dunks attempted. |
| dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. |
| two_point_made | integer | Two-point field goals made. |
| two_point_all | integer | Two-point field goals attempted. |
| two_point_percent | double | Two-point percentage 0-100. |
| three_point_made | integer | Three-point field goals made. |
| three_point_all | integer | Three-point field goals attempted. |
| three_point_percent | double | Three-point percentage 0-100. |
| throw_made | integer | All field goals made, two- plus three-pointers (the provider calls them 'throw'). |
| throw_all | integer | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
| throw_percent | double | Field-goal percentage 0-100. |
| free_throw_made | integer | Free throws made. |
| free_throw_all | integer | Free throws attempted. |
| free_throw_percent | double | Free-throw percentage 0-100. |
| offensive_rebound | integer | Offensive rebounds. |
| defensive_rebound | integer | Defensive rebounds. |
| total_rebound | integer | Total rebounds (offensive plus defensive). |
| block | integer | Shots blocked by the player. |
| block_against | integer | Own shots blocked by an opponent. |
| turnover | integer | Turnovers committed. |
| steal | integer | Steals (balls taken from an opponent). |
| assist | integer | Assists (passes leading directly to a made basket). |
| points | integer | Points scored (2 x two-pointers + 3 x three-pointers + free throws). |
| value | integer | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
| plusminus | integer | Plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
[`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md),
[`sportpress_game_film()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_film.md),
[`sportpress_game_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_find.md),
[`sportpress_game_leaders()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_leaders.md),
[`sportpress_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_overview.md),
[`sportpress_game_periods()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_periods.md),
[`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
[`sportpress_game_team_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_team_box.md),
[`sportpress_game_top_performers()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_top_performers.md),
[`sportpress_nationality_codes()`](https://hoopR.sportsdataverse.org/reference/sportpress_nationality_codes.md),
[`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md),
[`sportpress_player_career()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_career.md),
[`sportpress_player_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_games.md),
[`sportpress_player_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_rankings.md),
[`sportpress_referees()`](https://hoopR.sportsdataverse.org/reference/sportpress_referees.md),
[`sportpress_roster_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_roster_find.md),
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)

## Examples

``` r
# \donttest{
  try(sportpress_game_box(competition_id = 25, game_id = 11295))
#> ── BNXT League Game Box Score from Sportpress ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:44:43 UTC
#> # A tibble: 21 × 45
#>    game_id competition_id team_side competition_team_id team     team_short_name
#>      <int>          <int> <chr>                   <int> <chr>    <chr>          
#>  1   11295             25 home                      541 Windros… ANT            
#>  2   11295             25 home                      541 Windros… ANT            
#>  3   11295             25 home                      541 Windros… ANT            
#>  4   11295             25 home                      541 Windros… ANT            
#>  5   11295             25 home                      541 Windros… ANT            
#>  6   11295             25 home                      541 Windros… ANT            
#>  7   11295             25 home                      541 Windros… ANT            
#>  8   11295             25 home                      541 Windros… ANT            
#>  9   11295             25 home                      541 Windros… ANT            
#> 10   11295             25 home                      541 Windros… ANT            
#> # ℹ 11 more rows
#> # ℹ 39 more variables: roster_id <int>, player_id <int>, first_name <chr>,
#> #   last_name <chr>, nationality_code <chr>, birth_date <date>,
#> #   position_id <int>, position <chr>, starter <lgl>, jersey <chr>,
#> #   minute <int>, foul <int>, defensive_foul <int>, dunk_made <int>,
#> #   dunk_all <int>, dunk_percent <dbl>, two_point_made <int>,
#> #   two_point_all <int>, two_point_percent <dbl>, three_point_made <int>, …
# }
```
