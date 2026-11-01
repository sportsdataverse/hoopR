# **Get BNXT League Competition Teams**

Every competition team of one competition: ids, names and country.

Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/all`

## Usage

``` r
sportpress_competition_teams(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

## Value

A `hoopR_data` tibble: Every competition team of one competition: ids,
names and country. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`sportpress_competition_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id the team plays in (key space: sportpress competitions); the competition_id the route was asked for. |
| season | integer | Season END year of the team's competition. |
| uu_team_id | integer | Stable club key across seasons (key space: sportpress clubs-as-teams); competition_team_id changes every season, this does not. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
| club_name | character | Country name in English, Belgium or Netherlands. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
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
  try(sportpress_competition_teams(competition_id = 24))
#> ── BNXT League Competition Teams from Sportpress ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:51:13 UTC
#> # A tibble: 18 × 8
#>    competition_id season uu_team_id competition_team_id team     team_short_name
#>             <int>  <int>      <int>               <int> <chr>    <chr>          
#>  1             24   2026          1                 502 Val-Die… CHA            
#>  2             24   2026          2                 504 Filou O… OOS            
#>  3             24   2026          3                 506 Windros… ANT            
#>  4             24   2026          4                 508 Union M… MON            
#>  5             24   2026          5                 510 Hubo Li… LIM            
#>  6             24   2026          7                 512 Donar G… GRO            
#>  7             24   2026          8                 514 PrismaW… BAL            
#>  8             24   2026          9                 516 Landste… ZWO            
#>  9             24   2026         10                 518 Zeeuw &… RCB            
#> 10             24   2026         11                 520 LWD Bas… LWD            
#> 11             24   2026         12                 522 Zorg en… LEI            
#> 12             24   2026         14                 524 Den Hel… DHE            
#> 13             24   2026         18                 526 Heroes … DBO            
#> 14             24   2026         19                 528 Partena… AAL            
#> 15             24   2026         20                 530 AB InBe… LEU            
#> 16             24   2026         21                 532 Brussel… BRU            
#> 17             24   2026         22                 534 Kangoer… MEC            
#> 18             24   2026         32                 536 House o… KOR            
#> # ℹ 2 more variables: club_id <int>, club_name <chr>
# }
```
