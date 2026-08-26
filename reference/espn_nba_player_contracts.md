# **Get ESPN NBA Athlete Contracts Index**

Returns the index of contract seasons recorded for an NBA athlete from
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/athletes/{athlete_id}/contracts`.
Each row is one contract year — pass the season to
`espn_nba_player_contract()` for the full contract record.

Returns the full contract record for one NBA athlete in one season,
including salary, cap-rule flags, option type, Bird status, and trade
protections. Backed by
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/athletes/{athlete_id}/contracts/{season}`.

## Usage

``` r
espn_nba_player_contracts(athlete_id, ...)

espn_nba_player_contract(athlete_id, season = most_recent_nba_season(), ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

- season:

  Season year (numeric). Defaults to the most recent NBA season.

## Value

A tibble with one row per contract year.

|            |           |                                          |
|------------|-----------|------------------------------------------|
| col_name   | types     | description                              |
| athlete_id | character | ESPN athlete identifier.                 |
| season     | integer   | Contract season year.                    |
| ref        | character | Full `$ref` URL for the contract detail. |
| league     | character | League slug (`"nba"`).                   |

A single-row tibble.

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | character | ESPN athlete identifier. |
| season | integer | Contract season year. |
| bird_status | integer | Bird-rights tier (0 = Non, 1 = Early, 2 = Full). |
| salary | numeric | Total cap-counting salary for the season (\$). |
| salary_remaining | numeric | Remaining salary owed. |
| years_remaining | integer | Years left on the contract. |
| incoming_trade_value | numeric | Trade value if receiving this contract (\$). |
| outgoing_trade_value | numeric | Trade value if sending out this contract (\$). |
| option_type | integer | Option type code (e.g. team / player option). |
| minimum_salary_exception | logical | Signed under the minimum-salary exception. |
| trade_restriction | logical | Whether a trade restriction is active. |
| unsigned_foreign_pick | logical | Unsigned-foreign-pick flag. |
| active | logical | Whether the contract is currently active. |
| base_year_compensation_active | logical | Base-year-compensation rule active. |
| poison_pill_provision_active | logical | Poison-pill provision active. |
| trade_kicker_active | logical | Trade kicker active. |
| trade_kicker_percentage | numeric | Trade kicker percentage of salary. |
| trade_kicker_value | numeric | Trade kicker dollar value. |
| trade_kicker_trade_value | numeric | Trade kicker post-trade dollar value. |
| season_ref | character | `$ref` to the season resource. |
| team_ref | character | `$ref` to the team-in-season resource. |
| team_id | character | ESPN team id parsed from `team_ref`. |
| league | character | League slug (`"nba"`). |

## See also

Other ESPN NBA Functions:
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md),
[`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md),
[`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md),
[`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md),
[`espn_mbb_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_official_detail.md),
[`espn_mbb_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play.md),
[`espn_mbb_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play_personnel.md),
[`espn_mbb_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_player_box.md),
[`espn_mbb_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities.md),
[`espn_mbb_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_propbets.md),
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
[`espn_mbb_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md),
[`espn_mbb_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
[`espn_mbb_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_groups.md),
[`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md),
[`espn_mbb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders.md),
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md),
[`espn_mbb_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_rankings.md),
[`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md),
[`espn_mbb_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_types.md),
[`espn_mbb_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_week.md),
[`espn_mbb_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_weeks.md),
[`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md),
[`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md),
[`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  # LeBron James — athlete id 1966
  espn_nba_player_contracts(athlete_id = 1966)
#> ── ESPN NBA Athlete Contracts Index ───────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:09:15 UTC
#> # A tibble: 20 × 4
#>    athlete_id season ref                                                  league
#>    <chr>       <int> <chr>                                                <chr> 
#>  1 1966         2026 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  2 1966         2025 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  3 1966         2024 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  4 1966         2023 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  5 1966         2022 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  6 1966         2021 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  7 1966         2020 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  8 1966         2019 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  9 1966         2017 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 10 1966         2016 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 11 1966         2015 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 12 1966         2014 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 13 1966         2013 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 14 1966         2012 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 15 1966         2011 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 16 1966         2010 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 17 1966         2009 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 18 1966         2008 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 19 1966         2007 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 20 1966         2006 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
# }
# \donttest{
  # LeBron James 2025 contract
  espn_nba_player_contract(athlete_id = 1966, season = 2025)
#> ── ESPN NBA Athlete Contract from ESPN.com ────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:09:16 UTC
#> # A tibble: 1 × 23
#>   athlete_id season bird_status   salary salary_remaining years_remaining
#>   <chr>       <int>       <int>    <int>            <int>           <int>
#> 1 1966         2025           0 48728845                0               2
#> # ℹ 17 more variables: incoming_trade_value <int>, outgoing_trade_value <int>,
#> #   option_type <int>, minimum_salary_exception <lgl>, trade_restriction <lgl>,
#> #   unsigned_foreign_pick <lgl>, active <lgl>,
#> #   base_year_compensation_active <lgl>, poison_pill_provision_active <lgl>,
#> #   trade_kicker_active <lgl>, trade_kicker_percentage <dbl>,
#> #   trade_kicker_value <int>, trade_kicker_trade_value <int>, season_ref <chr>,
#> #   team_ref <chr>, team_id <chr>, league <chr>
# }
```
