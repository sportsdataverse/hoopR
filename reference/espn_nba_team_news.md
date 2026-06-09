# **Get ESPN NBA Team News**

**Get ESPN NBA Team News**

**Get ESPN NBA Team News**

## Usage

``` r
espn_nba_team_news(team_id, limit = 25)
```

## Arguments

- team_id:

  character or integer. ESPN team ID (e.g. `17` for Las Vegas Aces).

- limit:

  integer. Maximum number of articles to return. Default `25`.

## Value

Returns a tibble of team news articles.

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| id          | character | Id.                               |
| type        | character | Record type / category.           |
| headline    | character | News headline.                    |
| description | character | Long-form description text.       |
| published   | character | Publication timestamp (ISO 8601). |
| premium     | logical   |                                   |
| byline      | character | News article byline / author.     |
| link_web    | character | Web link / URL.                   |
| league_id   | character | League identifier ('10' = WNBA).  |

## Details

Retrieve ESPN NBA news for a specific team. Uses
`getOption("hoopR.proxy")` or `http_proxy`/`https_proxy` environment
variables for proxy configuration (per-call proxy override is not
supported for ESPN wrappers).

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
[`espn_nba_player_stats_v3()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats_v3.md),
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
  espn_nba_team_news(team_id = "13", limit = 5)
#> ── ESPN NBA Team News (team_id=13) from ESPN.com ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:37:15 UTC
#> # A tibble: 5 × 9
#>        id type  headline description published premium byline link_web league_id
#>     <int> <chr> <chr>    <chr>       <chr>     <lgl>   <chr>  <chr>    <chr>    
#> 1  4.90e7 Media Windy t… Windy to M… 2026-06-… FALSE   NA     https:/… 46       
#> 2  4.90e7 Story Grading… The Knicks… 2026-06-… FALSE   Zach … https:/… 46       
#> 3  4.85e7 Story Derek J… Celebritie… 2026-06-… FALSE   ESPN … https:/… 46       
#> 4  4.90e7 Media LeBron … LeBron fir… 2026-06-… FALSE   NA     https:/… 46       
#> 5  4.90e7 Head… Westhea… Paul Westh… 2026-06-… FALSE   NA     https:/… 46       
# }
```
