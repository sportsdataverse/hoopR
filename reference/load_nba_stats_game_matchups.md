# **Load hoopR NBA Stats game matchups**

Loads the `nba_stats_game_matchups` release: the `boxscorematchupsv3`
matchups of every game of a season, one row per (offensive player,
defensive player) pair per game, with matchup time, partial possessions,
switches and the points, assists, turnovers, blocks and shooting the
defender allowed. Season-long matchup totals are in
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md).

## Usage

``` r
load_nba_stats_game_matchups(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_game_matchups` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_game_matchups>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season). Published coverage starts at 2017 (2017-18).
  Pass `seasons = TRUE` for every published season.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per matchup pair per game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| off_team_id | integer | Team id of the offensive player. Taken from the payload's team block. |
| off_team_city | character | City/market of the offensive player's team ("Indiana"). |
| off_team_name | character | Nickname of the offensive player's team ("Pacers") – pair with `off_team_city` for the full club name. |
| off_team_tricode | character | Three-letter abbreviation of the offensive player's team ("IND"). |
| off_team_slug | character | URL slug of the offensive player's team ("pacers"). |
| def_team_id | integer | Team id of the defender, read from the game envelope's homeTeamId/awayTeamId rather than the nested team object, which is 0 on uncovered captures. |
| side | character | Which side of the game the row's team was on: "home" or "away". In `game_matchups`, where a row carries two teams, it is the OFFENSIVE player's team (`off_team_id`) – the defender is always the other side. |
| off_person_id | integer | stats.nba.com person id of the offensive player – the one being guarded. |
| off_first_name | character | First name of the offensive player. |
| off_family_name | character | Family name of the offensive player. |
| off_name_i | character | Offensive player's abbreviated display name ("B. Mathurin"). |
| off_player_slug | character | URL slug of the offensive player ("bennedict-mathurin"). |
| off_position | character | Starting position of the offensive player as the payload reports it; empty for players who did not start. |
| off_comment | character | Availability note on the offensive player (DNP reason); empty when they played. |
| off_jersey_num | character | Jersey number of the offensive player, as a string (it can carry a leading zero, e.g. "00"). |
| def_person_id | integer | stats.nba.com person id of the defender guarding the offensive player. |
| def_first_name | character | First name of the defender. |
| def_family_name | character | Family name of the defender. |
| def_name_i | character | Defender's abbreviated display name ("J. Allen"). |
| def_player_slug | character | URL slug of the defender ("jarrett-allen"). |
| def_jersey_num | character | Jersey number of the defender, as a string (it can carry a leading zero). |
| matchup_minutes | character | Time the pair were matched up, as the payload's MM:SS string; use `matchup_minutes_sort` for arithmetic. |
| matchup_minutes_sort | numeric | The same matchup time in seconds, as a float – the sortable/summable form. |
| partial_possessions | numeric | Possessions credited to the matchup. Fractional because a possession is split across every defender who guarded the ball-handler during it, which is why matchup counting stats do not sum exactly to a player's game totals. |
| percentage_defender_total_time | numeric | Share of the defender's floor time spent guarding this offensive player. |
| percentage_offensive_total_time | numeric | Share of the offensive player's floor time spent guarded by this defender. |
| percentage_total_time_both_on | numeric | Share of the time both players were on the floor together that they were matched up. |
| switches_on | integer | Times the defense switched this defender onto the offensive player. |
| player_points | integer | Points the offensive player scored while guarded by this defender. |
| team_points | integer | Points the offensive player's team scored while this matchup was on. |
| matchup_assists | integer | Assists by the offensive player while guarded by this defender. |
| matchup_potential_assists | integer | Passes by the offensive player that would have been assists had the shot fallen, while guarded by this defender. |
| matchup_turnovers | integer | Turnovers by the offensive player while guarded by this defender. |
| matchup_blocks | integer | Shots by the offensive player blocked by this defender. |
| matchup_field_goals_made | integer | Field goals made by the offensive player against this defender. |
| matchup_field_goals_attempted | integer | Field goals attempted by the offensive player against this defender. |
| matchup_field_goals_percentage | numeric | Field-goal percentage of the offensive player against this defender. |
| matchup_three_pointers_made | integer | Three-pointers made by the offensive player against this defender. |
| matchup_three_pointers_attempted | integer | Three-pointers attempted by the offensive player against this defender. |
| matchup_three_pointers_percentage | numeric | Three-point percentage of the offensive player against this defender. |
| help_blocks | integer | Blocks by this defender on the offensive player when helping off another assignment rather than as the primary defender. |
| help_field_goals_made | integer | Field goals the offensive player made against this defender in help defense. |
| help_field_goals_attempted | integer | Field goals the offensive player attempted against this defender in help defense. |
| help_field_goals_percentage | numeric | Field-goal percentage allowed by this defender in help defense. |
| matchup_free_throws_made | integer | Free throws made by the offensive player on trips drawn against this defender. |
| matchup_free_throws_attempted | integer | Free throws attempted by the offensive player on trips drawn against this defender. |
| shooting_fouls | integer | Shooting fouls committed by this defender on the offensive player. |
| game_id | character | 10-digit zero-padded stats.nba.com game id (e.g. '0022500001'). |
| season | integer | END year of the NBA season (2025 = 2024-25), the asset's own stamp: one more than the `seasons` argument. |
| season_type_id | character | Season-type digit: the 3rd character of game_id (and the leading digit of season_id). 1 = preseason, 2 = regular season, 3 = All-Star, 4 = playoffs, 5 = play-in, 6 = NBA Cup final, 9 = international. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the
Python twin `sportsdataverse.nba.load_nba_stats_game_matchups()`.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_draft_combine`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_draft_combine.md),
[`load_nba_stats_hustle`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_hustle.md),
[`load_nba_stats_injury_report()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_injury_report.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md),
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  # Interactive only: a 5.6 MB file of about 260,000 rows per season.
  try(load_nba_stats_game_matchups(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 32,470 × 50
#>    off_team_id off_team_city off_team_name off_team_tricode off_team_slug
#>          <int> <chr>         <chr>         <chr>            <chr>        
#>  1  1610612765 Detroit       Pistons       DET              pistons      
#>  2  1610612765 Detroit       Pistons       DET              pistons      
#>  3  1610612765 Detroit       Pistons       DET              pistons      
#>  4  1610612765 Detroit       Pistons       DET              pistons      
#>  5  1610612765 Detroit       Pistons       DET              pistons      
#>  6  1610612765 Detroit       Pistons       DET              pistons      
#>  7  1610612765 Detroit       Pistons       DET              pistons      
#>  8  1610612765 Detroit       Pistons       DET              pistons      
#>  9  1610612765 Detroit       Pistons       DET              pistons      
#> 10  1610612765 Detroit       Pistons       DET              pistons      
#> # ℹ 32,460 more rows
#> # ℹ 45 more variables: def_team_id <int>, side <chr>, off_person_id <int>,
#> #   off_first_name <chr>, off_family_name <chr>, off_name_i <chr>,
#> #   off_player_slug <chr>, off_position <chr>, off_comment <chr>,
#> #   off_jersey_num <chr>, def_person_id <int>, def_first_name <chr>,
#> #   def_family_name <chr>, def_name_i <chr>, def_player_slug <chr>,
#> #   def_jersey_num <chr>, matchup_minutes <chr>, matchup_minutes_sort <dbl>, …
# }
```
