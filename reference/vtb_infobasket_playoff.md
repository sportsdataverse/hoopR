# **Get VTB Infobasket Playoff**

Playoff bracket of a playoff stage, one row per series.

Endpoint: `GET https://org.infobasket.su/Widget/PlayOff/{comp_id}`

## Usage

``` r
vtb_infobasket_playoff(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble: Playoff bracket of a playoff stage, one row per
series. The columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_playoff`); an empty valid answer raises `hoopR_no_data`,
a valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_id | integer | Stage CompID the request asked for (50720 = the 2025-26 regular season): a stage below the season, not an END year. |
| tree | integer | Bracket tree number (1 = the main bracket). |
| round | integer | Round as the number of series in it (4 = quarter-finals, 2 = semi-finals, 1 = final). |
| is_current_round | logical | True for the round in progress. |
| sort | integer | Series order within the round. |
| round_name_ru | character | Round name, Russian. |
| round_name_en | character | Round name, English. |
| score1 | integer | Series wins of side 1. |
| score2 | integer | Series wins of side 2. |
| is_final | logical | True for a final (decided) result. |
| winner | integer | Series winner: 1 side 1, 2 side 2. |
| team1_id | integer | Infobasket TeamID of team 1. |
| team1_short_name_ru | character | The team 1 of the series's short name in Russian (as the competition names it). |
| team1_short_name_en | character | The team 1 of the series's short name in English (as the competition names it). |
| team1_name_ru | character | The team 1 of the series's name in Russian (as the competition names it). |
| team1_name_en | character | The team 1 of the series's name in English (as the competition names it). |
| team1_region_name_ru | character | The team 1 of the series's region or city in Russian (as the competition names it). |
| team1_region_name_en | character | The team 1 of the series's region or city in English (as the competition names it). |
| team2_id | integer | Infobasket TeamID of team 2. |
| team2_short_name_ru | character | The team 2 of the series's short name in Russian (as the competition names it). |
| team2_short_name_en | character | The team 2 of the series's short name in English (as the competition names it). |
| team2_name_ru | character | The team 2 of the series's name in Russian (as the competition names it). |
| team2_name_en | character | The team 2 of the series's name in English (as the competition names it). |
| team2_region_name_ru | character | The team 2 of the series's region or city in Russian (as the competition names it). |
| team2_region_name_en | character | The team 2 of the series's region or city in English (as the competition names it). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_box_score.md),
[`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md),
[`vtb_infobasket_coach()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_coach.md),
[`vtb_infobasket_comp_issue()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_comp_issue.md),
[`vtb_infobasket_cross_table()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_cross_table.md),
[`vtb_infobasket_game()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game.md),
[`vtb_infobasket_game_page()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_page.md),
[`vtb_infobasket_game_staff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_staff.md),
[`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md),
[`vtb_infobasket_player()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player.md),
[`vtb_infobasket_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_career_stats.md),
[`vtb_infobasket_player_game_log()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_game_log.md),
[`vtb_infobasket_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_season_stats.md),
[`vtb_infobasket_playoff_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff_games.md),
[`vtb_infobasket_roster()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster.md),
[`vtb_infobasket_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster_coaches.md),
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md),
[`vtb_infobasket_standings()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_standings.md),
[`vtb_infobasket_team()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team.md),
[`vtb_infobasket_team_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_box_score.md),
[`vtb_infobasket_team_coach_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_coach_stats.md),
[`vtb_infobasket_team_comps()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_comps.md),
[`vtb_infobasket_team_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_games.md),
[`vtb_infobasket_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_player_stats.md),
[`vtb_infobasket_team_preview()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_preview.md),
[`vtb_infobasket_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_season_stats.md),
[`vtb_infobasket_team_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_seasons.md),
[`vtb_infobasket_team_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats.md),
[`vtb_infobasket_team_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_coaches.md),
[`vtb_infobasket_team_stats_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_players.md),
[`vtb_league_leagues()`](https://hoopR.sportsdataverse.org/reference/vtb_league_leagues.md),
[`vtb_league_matches()`](https://hoopR.sportsdataverse.org/reference/vtb_league_matches.md),
[`vtb_league_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_league_seasons.md)

## Examples

``` r
# \donttest{
  try(vtb_infobasket_playoff(comp_id = 54281))
#> ── VTB Infobasket Playoff from org.infobasket.su ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:52:20 UTC
#> # A tibble: 8 × 25
#>   comp_id  tree round is_current_round  sort round_name_ru  round_name_en score1
#>     <int> <int> <int> <lgl>            <int> <chr>          <chr>          <int>
#> 1   54281     1     4 FALSE                1 1/4 финала     1/4 finals         3
#> 2   54281     1     4 FALSE                2 1/4 финала     1/4 finals         3
#> 3   54281     1     4 FALSE                3 1/4 финала     1/4 finals         3
#> 4   54281     1     4 FALSE                4 1/4 финала     1/4 finals         3
#> 5   54281     1     2 FALSE                1 1/2 финала     1/2 finals         4
#> 6   54281     1     2 FALSE                2 1/2 финала     1/2 finals         4
#> 7   54281     1     1 TRUE                 1 Финал          Final              4
#> 8   54281     2     1 TRUE                 2 Финал за 3 ме… Final for 3        2
#> # ℹ 17 more variables: score2 <int>, is_final <lgl>, winner <int>,
#> #   team1_id <int>, team1_short_name_ru <chr>, team1_short_name_en <chr>,
#> #   team1_name_ru <chr>, team1_name_en <chr>, team1_region_name_ru <chr>,
#> #   team1_region_name_en <chr>, team2_id <int>, team2_short_name_ru <chr>,
#> #   team2_short_name_en <chr>, team2_name_ru <chr>, team2_name_en <chr>,
#> #   team2_region_name_ru <chr>, team2_region_name_en <chr>
# }
```
