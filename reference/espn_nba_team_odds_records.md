# **Get ESPN NBA Team Odds-Records (Long Format)**

Returns the long-format odds-records breakdown for a team in one season.
Each row is one (category × stat) — typical categories include Money
Line Overall, Money Line Home, Money Line Road, Against The Spread
Overall, Over/Under, etc. ESPN's coverage of this endpoint is sparse;
many (team × season-type) combinations return 404, in which case the
wrapper returns an empty tibble.

## Usage

``` r
espn_nba_team_odds_records(
  team_id,
  season = most_recent_nba_season(),
  season_type = 0L,
  ...
)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year. Defaults to most recent NBA season.

- season_type:

  Season-type id. ESPN populates odds-records mostly under
  `season_type = 0` (all-types aggregate), so that is the default.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per (category × stat).

|                  |           |                                               |
|------------------|-----------|-----------------------------------------------|
| col_name         | types     | description                                   |
| league           | character | League slug.                                  |
| team_id          | character | ESPN team identifier.                         |
| season           | integer   | Season year.                                  |
| season_type      | integer   | Season-type id.                               |
| category_type    | character | Category type code (e.g. "moneyLineOverall"). |
| category_abbrev  | character | Category abbreviation (e.g. "ML").            |
| category_short   | character | Short display.                                |
| category_display | character | Full category name.                           |
| stat_type        | character | Stat type code (e.g. "win", "loss").          |
| stat_abbrev      | character | Stat abbreviation (e.g. "W", "L").            |
| stat_display     | character | Stat display name.                            |
| value            | numeric   | Numeric stat value.                           |
| display_value    | character | Display-formatted value.                      |

## See also

Other ESPN NBA Functions:
[`espn_nba_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_awards.md),
[`espn_nba_athlete_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_career_stats.md),
[`espn_nba_athlete_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_contract.md),
[`espn_nba_athlete_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_contracts.md),
[`espn_nba_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_eventlog.md),
[`espn_nba_athlete_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_gamelog.md),
[`espn_nba_athlete_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_info.md),
[`espn_nba_athlete_overview()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_overview.md),
[`espn_nba_athlete_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_seasons.md),
[`espn_nba_athlete_splits()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_splits.md),
[`espn_nba_athlete_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_statisticslog.md),
[`espn_nba_athlete_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_stats.md),
[`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md),
[`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_nba_award.md),
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md),
[`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md),
[`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md),
[`espn_nba_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_broadcasts.md),
[`espn_nba_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_odds.md),
[`espn_nba_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_officials.md),
[`espn_nba_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_probabilities.md),
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md),
[`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_futures()`](https://hoopR.sportsdataverse.org/reference/espn_nba_futures.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md),
[`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md),
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md),
[`espn_nba_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group.md),
[`espn_nba_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_children.md),
[`espn_nba_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_teams.md),
[`espn_nba_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_groups.md),
[`espn_nba_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_info.md),
[`espn_nba_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_leaders.md),
[`espn_nba_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_ranking.md),
[`espn_nba_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_rankings.md),
[`espn_nba_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_type.md),
[`espn_nba_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_types.md),
[`espn_nba_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_week.md),
[`espn_nba_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_weeks.md),
[`espn_nba_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_seasons.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_leaders.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md),
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
[`espn_nba_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_profile.md),
[`espn_nba_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament.md),
[`espn_nba_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_seasons.md),
[`espn_nba_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournaments.md),
[`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md),
[`espn_nba_venues()`](https://hoopR.sportsdataverse.org/reference/espn_nba_venues.md),
[`espn_nba_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_ranking.md),
[`espn_nba_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_rankings.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_nba_team_odds_records(team_id = 1, season = 2026)
#> ── ESPN NBA Team Odds-Records ─────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-18 23:59:18 UTC
#> # A tibble: 60 × 13
#>    league team_id season season_type category_type    category_abbrev
#>    <chr>  <chr>    <int>       <int> <chr>            <chr>          
#>  1 nba    1         2026           0 moneyLineOverall ML             
#>  2 nba    1         2026           0 moneyLineOverall ML             
#>  3 nba    1         2026           0 moneyLineOverall ML             
#>  4 nba    1         2026           0 moneyLineOverall ML             
#>  5 nba    1         2026           0 moneyLineOverall ML             
#>  6 nba    1         2026           0 moneyLineOverall ML             
#>  7 nba    1         2026           0 moneyLineHome    ML HOME        
#>  8 nba    1         2026           0 moneyLineHome    ML HOME        
#>  9 nba    1         2026           0 moneyLineHome    ML HOME        
#> 10 nba    1         2026           0 moneyLineHome    ML HOME        
#> # ℹ 50 more rows
#> # ℹ 7 more variables: category_short <chr>, category_display <chr>,
#> #   stat_type <chr>, stat_abbrev <chr>, stat_display <chr>, value <dbl>,
#> #   display_value <chr>
# }
```
