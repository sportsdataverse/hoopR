# **Get BNXT League Player Rankings**

Qualified-player per-game leaders in nine categories (one row per player
and category).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/player/average-rankings/{competition_id}`

## Usage

``` r
sportpress_player_rankings(
  competition_id,
  phase_id = NULL,
  limit = NULL,
  type = NULL
)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- phase_id:

  (default `NULL`) Restrict to one phase (integer), from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md).
  Omitted = every phase.

- limit:

  (default `NULL`) Cap each ranking list at this many rows. Omitted =
  the complete lists.

- type:

  (default `NULL`) Return one ranking category only (e.g. `points`);
  `all` or omitted = the nine categories.

## Value

A `hoopR_data` tibble: Qualified-player per-game leaders in nine
categories (one row per player and category). An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_player_rankings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| category | character | Ranking category: efficiency, points, total_rebound, block, assist, steal, two_point_percent, three_point_percent or free_throw_percent. |
| rank | integer | Place in the category list, 1 = the leader (the list is sorted best first). |
| roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| value | double | The player's per-game mean (or percentage 0-100) in the row's category. |
| throw_made | double | Field goals made per game; filled in the three percentage categories only. |
| throw_attempted | double | Field goals attempted per game; filled in the three percentage categories only. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
[`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md),
[`sportpress_game_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_box.md),
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
  try(sportpress_player_rankings(competition_id = 24))
#> ── BNXT League Player Rankings from Sportpress ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:49:47 UTC
#> # A tibble: 1,414 × 15
#>    competition_id category    rank roster_id player_id first_name last_name    
#>             <int> <chr>      <int>     <int>     <int> <chr>      <chr>        
#>  1             24 efficiency     1     10885      5403 Dante      Maddox Jr    
#>  2             24 efficiency     2     10361      3002 Zaba       Bangala      
#>  3             24 efficiency     3     10681      5287 Maks       Klanjscek    
#>  4             24 efficiency     4     10917      5417 Shakael    Pryce        
#>  5             24 efficiency     5     10753      5317 Noam       Yaacov       
#>  6             24 efficiency     6     10803      5343 Dane       Erikstrup    
#>  7             24 efficiency     7     10663      5277 Jalen      Blackmon     
#>  8             24 efficiency     8     10779      5327 Rasheed    Bello        
#>  9             24 efficiency     9     10841      5373 Tyreek     Scott-Grayson
#> 10             24 efficiency    10     10381       219 Niels      Van Den Eynde
#> # ℹ 1,404 more rows
#> # ℹ 8 more variables: nationality_code <chr>, birth_date <date>,
#> #   competition_team_id <int>, team <chr>, team_short_name <chr>, value <dbl>,
#> #   throw_made <dbl>, throw_attempted <dbl>
# }
```
