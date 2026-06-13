# **Get ESPN NBA Athlete Stats**

**Get ESPN NBA Athlete Stats**

**Get ESPN NBA Athlete Stats**

## Usage

``` r
espn_nba_player_stats_v3(athlete_id, season = most_recent_nba_season(), ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- season:

  Season year (numeric). Defaults to the most recent NBA season.

- ...:

  Additional arguments; currently unused.

## Value

A named list of per-category tibbles. Default category names are
`General`, `Offensive`, `Defensive`, `Rebounding`, `Shooting`, `Misc`.
Actual names are driven by the ESPN response; additional categories may
appear. Each tibble has columns depending on the category returned by
ESPN.

## See also

Other ESPN NBA Functions:
[`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md),
[`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_nba_award.md),
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md),
[`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md),
[`espn_nba_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_record.md),
[`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_draft_athlete_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athlete_detail.md),
[`espn_nba_draft_athletes()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athletes.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md),
[`espn_nba_draft_rounds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_rounds.md),
[`espn_nba_draft_status()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_status.md),
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md),
[`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_futures()`](https://hoopR.sportsdataverse.org/reference/espn_nba_futures.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_broadcasts.md),
[`espn_nba_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_odds.md),
[`espn_nba_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_official_detail.md),
[`espn_nba_game_officials()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_officials.md),
[`espn_nba_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play.md),
[`espn_nba_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_play_personnel.md),
[`espn_nba_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_player_box.md),
[`espn_nba_game_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_powerindex.md),
[`espn_nba_game_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_predictor.md),
[`espn_nba_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_probabilities.md),
[`espn_nba_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_propbets.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_game_situation()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_situation.md),
[`espn_nba_game_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_leaders.md),
[`espn_nba_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_linescores.md),
[`espn_nba_game_team_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_records.md),
[`espn_nba_game_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_roster.md),
[`espn_nba_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_roster_entry.md),
[`espn_nba_game_team_score()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_score.md),
[`espn_nba_game_team_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_team_statistics.md),
[`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md),
[`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md),
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_awards.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_career_stats.md),
[`espn_nba_player_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contract.md),
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md),
[`espn_nba_player_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_eventlog.md),
[`espn_nba_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_eventlog_v2.md),
[`espn_nba_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_gamelog.md),
[`espn_nba_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_info.md),
[`espn_nba_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_overview.md),
[`espn_nba_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_seasons.md),
[`espn_nba_player_splits()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_splits.md),
[`espn_nba_player_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_statisticslog.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_nba_position.md),
[`espn_nba_positions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_positions.md),
[`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md),
[`espn_nba_season_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_draft.md),
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
[`espn_nba_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_odds_records.md),
[`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md),
[`espn_nba_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record_detail.md),
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
[`espn_nba_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_profile.md),
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
  espn_nba_player_stats_v3(athlete_id = "1966", season = 2024)
#> $`Regular Season Averages`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 23 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [18]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [18]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [18]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [18]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [18]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [18]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [18]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [18]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [18]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [18]> F       
#> # ℹ 13 more rows
#> 
#> $`Regular Season Totals`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 23 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [15]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [15]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [15]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [15]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [15]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [15]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [15]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [15]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [15]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [15]> F       
#> # ℹ 13 more rows
#> 
#> $`Regular Season Misc Totals`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 23 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [10]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [10]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [10]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [10]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [10]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [10]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [10]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [10]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [10]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [10]> F       
#> # ℹ 13 more rows
#> 
#> $General
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 0 × 0
#> 
#> $Offensive
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 0 × 0
#> 
#> $Defensive
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 0 × 0
#> 
#> $Rebounding
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 0 × 0
#> 
#> $Shooting
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 0 × 0
#> 
#> $Misc
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:24:07 UTC
#> # A tibble: 0 × 0
#> 
# }
```
