# **Get ESPN NBA team names and IDs**

**Get ESPN NBA team names and IDs**

## Usage

``` r
espn_nba_teams()
```

## Value

A teams data frame

|                 |           |                                            |
|-----------------|-----------|--------------------------------------------|
| col_name        | types     | description                                |
| team_id         | integer   | Unique team identifier.                    |
| abbreviation    | character | Short abbreviation.                        |
| display_name    | character | Display name.                              |
| short_name      | character | Short display name.                        |
| mascot          | character | Team mascot.                               |
| nickname        | character | Team or athlete nickname.                  |
| team            | character | Team-side label or team identifier.        |
| color           | character | Primary color (hex without leading '#').   |
| alternate_color | character | Alternate color (hex without leading '#'). |
| logo            | character | Team or league logo URL.                   |
| logo_dark       | character | Logo dark.                                 |
| logos_href_3    | character | Logos href 3.                              |
| logos_href_4    | character | Logos href 4.                              |

## See also

Other ESPN NBA Functions:
[`espn_nba_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_awards.md),
[`espn_nba_athlete_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_career_stats.md),
[`espn_nba_athlete_contract()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_contract.md),
[`espn_nba_athlete_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_contracts.md),
[`espn_nba_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_eventlog.md),
[`espn_nba_athlete_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_eventlog_v2.md),
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
[`espn_nba_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_broadcasts.md),
[`espn_nba_event_competitor_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_leaders.md),
[`espn_nba_event_competitor_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_linescores.md),
[`espn_nba_event_competitor_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_records.md),
[`espn_nba_event_competitor_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_roster.md),
[`espn_nba_event_competitor_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_roster_entry.md),
[`espn_nba_event_competitor_score()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_score.md),
[`espn_nba_event_competitor_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_competitor_statistics.md),
[`espn_nba_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_odds.md),
[`espn_nba_event_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_official_detail.md),
[`espn_nba_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_officials.md),
[`espn_nba_event_play()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_play.md),
[`espn_nba_event_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_play_personnel.md),
[`espn_nba_event_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_player_box.md),
[`espn_nba_event_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_powerindex.md),
[`espn_nba_event_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_predictor.md),
[`espn_nba_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_probabilities.md),
[`espn_nba_event_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_propbets.md),
[`espn_nba_event_situation()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_situation.md),
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
try(espn_nba_teams())
#> ── ESPN NBA Teams Information from ESPN.com ───────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-22 06:55:26 UTC
#> # A tibble: 30 × 25
#>    abbreviation alternate_color color display_name team_id team  logo  logo_dark
#>    <chr>        <chr>           <chr> <chr>          <int> <chr> <chr> <chr>    
#>  1 ATL          fdb927          c810… Atlanta Haw…       1 Atla… http… https://…
#>  2 BOS          ffffff          0083… Boston Celt…       2 Bost… http… https://…
#>  3 BKN          ffffff          0000… Brooklyn Ne…      17 Broo… http… https://…
#>  4 CHA          1d1060          008c… Charlotte H…      30 Char… http… https://…
#>  5 CHI          000000          ce11… Chicago Bul…       4 Chic… http… https://…
#>  6 CLE          bc945c          8600… Cleveland C…       5 Clev… http… https://…
#>  7 DAL          bbc4ca          0064… Dallas Mave…       6 Dall… http… https://…
#>  8 DEN          fec524          0e22… Denver Nugg…       7 Denv… http… https://…
#>  9 DET          c8102e          1d42… Detroit Pis…       8 Detr… http… https://…
#> 10 GS           1d428a          fdb9… Golden Stat…       9 Gold… http… https://…
#> # ℹ 20 more rows
#> # ℹ 17 more variables: logos_href_3 <chr>, logos_href_4 <chr>,
#> #   logos_href_5 <chr>, logos_href_6 <chr>, logos_href_7 <chr>,
#> #   logos_href_8 <chr>, logos_href_9 <chr>, logos_href_10 <chr>,
#> #   logos_href_11 <chr>, logos_href_12 <chr>, logos_href_13 <chr>,
#> #   logos_href_14 <chr>, logos_href_15 <chr>, logos_href_16 <chr>,
#> #   mascot <chr>, nickname <chr>, short_name <chr>
# }
```
