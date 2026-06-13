# **Get ESPN NBA's Standings**

**Get ESPN NBA's Standings**

## Usage

``` r
espn_nba_standings(year)
```

## Arguments

- year:

  Either numeric or character (YYYY)

## Value

A standings data frame

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team | character | Team-side label or team identifier. |
| avgpointsagainst | numeric | Avgpointsagainst. |
| avgpointsfor | numeric | Avgpointsfor. |
| clincher | numeric | Clincher. |
| differential | numeric | Differential. |
| divisionwinpercent | numeric | Divisionwinpercent. |
| gamesbehind | numeric | Gamesbehind. |
| leaguewinpercent | numeric | Leaguewinpercent. |
| losses | numeric | Total losses. |
| playoffseed | numeric | Playoffseed. |
| streak | numeric | Current streak (e.g. 'W3' for three-game win streak). |
| winpercent | numeric | Winpercent. |
| wins | numeric | Total wins. |
| leaguestandings | character | Leaguestandings. |
| home | character | Home. |
| road | character | Road. |
| vsdiv | character | Vsdiv. |
| vsconf | character | Vsconf. |
| lasttengames | character | Lasttengames. |

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

## Examples

``` r
# \donttest{
try(espn_nba_standings(year = 2021))
#> ── ESPN NBA Standings Information from ESPN.com ───────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:06:28 UTC
#> # A tibble: 30 × 25
#>    team_id team              avgpointsagainst avgpointsfor clincher differential
#>  *   <int> <chr>                        <dbl>        <dbl>    <dbl>        <dbl>
#>  1      26 Utah Jazz                     107.         116.        5         9.2 
#>  2      21 Phoenix Suns                  109.         115.        2         5.8 
#>  3      20 Philadelphia 76e…             108.         114.        3         5.5 
#>  4      17 Brooklyn Nets                 114.         119.        1         4.5 
#>  5       7 Denver Nuggets                110.         115.        1         5   
#>  6      12 LA Clippers                   108.         114.        1         6.2 
#>  7      15 Milwaukee Bucks               114.         120.        2         5.90
#>  8       6 Dallas Mavericks              110.         112.        2         2.2 
#>  9      13 Los Angeles Lake…             107.         110.        7         2.7 
#> 10      22 Portland Trail B…             114.         116.        1         1.8 
#> # ℹ 20 more rows
#> # ℹ 19 more variables: divisionwinpercent <dbl>, gamesbehind <dbl>,
#> #   leaguewinpercent <dbl>, losses <dbl>, playoffseed <dbl>,
#> #   pointdifferential <chr>, points <chr>, pointsagainst <chr>,
#> #   pointsfor <chr>, streak <dbl>, winpercent <dbl>, wins <dbl>,
#> #   gamesahead <chr>, leaguestandings <chr>, home <chr>, road <chr>,
#> #   vsdiv <chr>, vsconf <chr>, lasttengames <chr>
# }
```
