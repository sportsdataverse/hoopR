# **Get ESPN NBA Athlete Career Stats (Long Format)**

Returns career stats for an NBA athlete in long format. Default
`stat_type = 0L` fetches the standard "All Splits" / regular-season
view. Pass a vector like `c(0L, 1L, 2L)` to attempt multiple types and
bind them via a `stat_type_id` column; variants that 404 for that
athlete are silently skipped. Stat types: 0 = regular season (default
endpoint), 1 = postseason, 2 = career aggregate. Coverage of types 1 and
2 is sparse — many athletes only have type 0 populated.

## Usage

``` r
espn_nba_athlete_career_stats(athlete_id, stat_type = 0L, ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier.

- stat_type:

  Integer or integer vector of stat-type codes. Default `0L` fetches the
  standard "All Splits" / regular-season view. Pass a vector like
  `c(0L, 1L, 2L)` to bind multiple types via a `stat_type_id` column;
  non-existent variants are silently skipped.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble (one row per stat_type × split × category × stat).

|                  |           |                                                 |
|------------------|-----------|-------------------------------------------------|
| col_name         | types     | description                                     |
| league           | character | League slug.                                    |
| athlete_id       | character | ESPN athlete id.                                |
| stat_type_id     | character | Stat-type code (0 = reg, 1 = post, 2 = career). |
| split_id         | character | Split id.                                       |
| split_name       | character | Split name (typically "All Splits").            |
| split_type       | character | Split type code.                                |
| category_name    | character | Category key (e.g. "defensive").                |
| category_display | character | Category display name.                          |
| category_short   | character | Category short display.                         |
| category_abbrev  | character | Category abbreviation.                          |
| stat_name        | character | Stat key.                                       |
| stat_abbrev      | character | Stat abbreviation.                              |
| stat_display     | character | Stat display name.                              |
| stat_short       | character | Stat short display.                             |
| description      | character | Stat description.                               |
| value            | numeric   | Stat value.                                     |
| display_value    | character | Display-formatted value.                        |

## Details

**Get ESPN NBA Athlete Career Stats (Long Format)**

## See also

Other ESPN NBA Functions:
[`espn_nba_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_awards.md),
[`espn_nba_athlete_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_contracts.md),
[`espn_nba_athlete_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_contract.md),
[`espn_nba_athlete_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_eventlog_v2.md),
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
[`espn_nba_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_record.md),
[`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft_athlete_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athlete_detail.md),
[`espn_nba_draft_athletes()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athletes.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md),
[`espn_nba_draft_rounds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_rounds.md),
[`espn_nba_draft_status()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_status.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_broadcasts.md),
[`espn_nba_event_competitor_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_leaders.md),
[`espn_nba_event_competitor_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_linescores.md),
[`espn_nba_event_competitor_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_records.md),
[`espn_nba_event_competitor_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_roster_entry.md),
[`espn_nba_event_competitor_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_roster.md),
[`espn_nba_event_competitor_score()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_score.md),
[`espn_nba_event_competitor_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_statistics.md),
[`espn_nba_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_odds.md),
[`espn_nba_event_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_official_detail.md),
[`espn_nba_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_officials.md),
[`espn_nba_event_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_play_personnel.md),
[`espn_nba_event_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_player_box.md),
[`espn_nba_event_play()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_play.md),
[`espn_nba_event_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_powerindex.md),
[`espn_nba_event_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_predictor.md),
[`espn_nba_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_probabilities.md),
[`espn_nba_event_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_propbets.md),
[`espn_nba_event_situation()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_situation.md),
[`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md),
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md),
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
[`espn_nba_positions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_positions.md),
[`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_nba_position.md),
[`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md),
[`espn_nba_season_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_draft.md),
[`espn_nba_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_children.md),
[`espn_nba_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_teams.md),
[`espn_nba_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_groups.md),
[`espn_nba_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group.md),
[`espn_nba_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_info.md),
[`espn_nba_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_leaders.md),
[`espn_nba_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_rankings.md),
[`espn_nba_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_ranking.md),
[`espn_nba_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_types.md),
[`espn_nba_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_type.md),
[`espn_nba_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_weeks.md),
[`espn_nba_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_week.md),
[`espn_nba_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_seasons.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_leaders.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
[`espn_nba_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_odds_records.md),
[`espn_nba_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record_detail.md),
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md),
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
[`espn_nba_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_profile.md),
[`espn_nba_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_roster.md),
[`espn_nba_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_statistics.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_team()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team.md),
[`espn_nba_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_seasons.md),
[`espn_nba_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_season.md),
[`espn_nba_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournaments.md),
[`espn_nba_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament.md),
[`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md),
[`espn_nba_venues()`](https://hoopR.sportsdataverse.org/reference/espn_nba_venues.md),
[`espn_nba_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_rankings.md),
[`espn_nba_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_ranking.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  # LeBron James — regular + postseason combined
  espn_nba_athlete_career_stats(athlete_id = 1966)
#> ── ESPN NBA Athlete Career Stats ──────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-30 12:02:29 UTC
#> # A tibble: 114 × 17
#>    league athlete_id stat_type_id split_id split_name split_type category_name
#>    <chr>  <chr>      <chr>        <chr>    <chr>      <chr>      <chr>        
#>  1 nba    1966       0            0        All Splits total      defensive    
#>  2 nba    1966       0            0        All Splits total      defensive    
#>  3 nba    1966       0            0        All Splits total      defensive    
#>  4 nba    1966       0            0        All Splits total      defensive    
#>  5 nba    1966       0            0        All Splits total      defensive    
#>  6 nba    1966       0            0        All Splits total      defensive    
#>  7 nba    1966       0            0        All Splits total      defensive    
#>  8 nba    1966       0            0        All Splits total      defensive    
#>  9 nba    1966       0            0        All Splits total      defensive    
#> 10 nba    1966       0            0        All Splits total      defensive    
#> # ℹ 104 more rows
#> # ℹ 10 more variables: category_display <chr>, category_short <chr>,
#> #   category_abbrev <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, stat_short <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>
  # Just career aggregate
  espn_nba_athlete_career_stats(athlete_id = 1966, stat_type = 2L)
#> ── ESPN NBA Athlete Career Stats ──────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-30 12:02:29 UTC
#> # A tibble: 0 × 17
#> # ℹ 17 variables: league <chr>, athlete_id <chr>, stat_type_id <chr>,
#> #   split_id <chr>, split_name <chr>, split_type <chr>, category_name <chr>,
#> #   category_display <chr>, category_short <chr>, category_abbrev <chr>,
#> #   stat_name <chr>, stat_abbrev <chr>, stat_display <chr>, stat_short <chr>,
#> #   description <chr>, value <dbl>, display_value <chr>
# }
```
