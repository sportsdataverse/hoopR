# **Get ESPN NBA Season Group Detail**

Returns metadata for one group (conference or division) in one (NBA
season x season-type), plus `$ref` URLs to its parent group, children
groups, member teams, and standings.

Returns the list of child groups (e.g. divisions within a conference)
for one (NBA season x season-type x parent-group).

Returns the list of team IDs that belong to one group (conference or
division) for one (NBA season x season-type).

## Usage

``` r
espn_nba_season_group(
  group_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)

espn_nba_season_group_children(
  group_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)

espn_nba_season_group_teams(
  group_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- group_id:

  ESPN group identifier.

- season:

  Season year. Defaults to most recent NBA season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

Columns as documented in the shared
[espn_mbb_season_group_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_schema.md)
table.

A tibble with one row per child group.

Columns as documented in the shared
[espn_mbb_season_group_children_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children_schema.md)
table.

A tibble with one row per team in the group.

Columns as documented in the shared
[espn_mbb_season_group_teams_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams_schema.md)
table.

## Details

**Get ESPN NBA Season Group Detail**

**Get ESPN NBA Season Group Children Index**

**Get ESPN NBA Season Group Teams Index**

## See also

Other ESPN NBA Functions:
[`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md),
[`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_nba_award.md),
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md),
[`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md),
[`espn_nba_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_record.md),
[`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_draft_athlete_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athlete_detail.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md),
[`espn_nba_draft_rounds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_rounds.md),
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md),
[`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_futures()`](https://hoopR.sportsdataverse.org/reference/espn_nba_futures.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_odds.md),
[`espn_nba_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_official_detail.md),
[`espn_nba_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play.md),
[`espn_nba_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play_personnel.md),
[`espn_nba_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_player_box.md),
[`espn_nba_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_probabilities.md),
[`espn_nba_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_propbets.md),
[`espn_nba_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_linescores.md),
[`espn_nba_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_roster_entry.md),
[`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md),
[`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md),
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md),
[`espn_nba_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_awards.md),
[`espn_nba_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_career_stats.md),
[`espn_nba_player_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contract.md),
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md),
[`espn_nba_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_eventlog_v2.md),
[`espn_nba_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_info.md),
[`espn_nba_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_overview.md),
[`espn_nba_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_seasons.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_nba_position.md),
[`espn_nba_positions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_positions.md),
[`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md),
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
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
[`espn_nba_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_odds_records.md),
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md),
[`espn_nba_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record_detail.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
[`espn_nba_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_roster.md),
[`espn_nba_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_statistics.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament.md),
[`espn_nba_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_season.md),
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
  espn_nba_season_group(group_id = 5, season = 2025)
#> ── ESPN NBA Season Group Detail ───────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:23:28 UTC
#> # A tibble: 1 × 15
#>   league season season_type group_id uid           name  abbreviation short_name
#>   <chr>   <int>       <int> <chr>    <chr>         <chr> <chr>        <chr>     
#> 1 nba      2025           2 5        s:40~l:46~g:5 East… East         NA        
#> # ℹ 7 more variables: midsize_name <chr>, is_conference <lgl>, slug <chr>,
#> #   parent_ref <chr>, children_ref <chr>, teams_ref <chr>, standings_ref <chr>
# }
# \donttest{
  espn_nba_season_group_children(group_id = 5, season = 2025)
#> ── ESPN NBA Season Group Children Index ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:23:29 UTC
#> # A tibble: 3 × 6
#>   league season season_type parent_group_id child_group_id ref                  
#>   <chr>   <int>       <int> <chr>           <chr>          <chr>                
#> 1 nba      2025           2 5               1              http://sports.core.a…
#> 2 nba      2025           2 5               2              http://sports.core.a…
#> 3 nba      2025           2 5               9              http://sports.core.a…
# }
# \donttest{
  espn_nba_season_group_teams(group_id = 5, season = 2025)
#> ── ESPN NBA Season Group Teams Index ──────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:23:29 UTC
#> # A tibble: 15 × 6
#>    league season season_type group_id team_id ref                               
#>    <chr>   <int>       <int> <chr>    <chr>   <chr>                             
#>  1 nba      2025           2 5        1       http://sports.core.api.espn.com/v…
#>  2 nba      2025           2 5        2       http://sports.core.api.espn.com/v…
#>  3 nba      2025           2 5        4       http://sports.core.api.espn.com/v…
#>  4 nba      2025           2 5        5       http://sports.core.api.espn.com/v…
#>  5 nba      2025           2 5        8       http://sports.core.api.espn.com/v…
#>  6 nba      2025           2 5        11      http://sports.core.api.espn.com/v…
#>  7 nba      2025           2 5        14      http://sports.core.api.espn.com/v…
#>  8 nba      2025           2 5        15      http://sports.core.api.espn.com/v…
#>  9 nba      2025           2 5        17      http://sports.core.api.espn.com/v…
#> 10 nba      2025           2 5        18      http://sports.core.api.espn.com/v…
#> 11 nba      2025           2 5        19      http://sports.core.api.espn.com/v…
#> 12 nba      2025           2 5        20      http://sports.core.api.espn.com/v…
#> 13 nba      2025           2 5        27      http://sports.core.api.espn.com/v…
#> 14 nba      2025           2 5        28      http://sports.core.api.espn.com/v…
#> 15 nba      2025           2 5        30      http://sports.core.api.espn.com/v…
# }
```
