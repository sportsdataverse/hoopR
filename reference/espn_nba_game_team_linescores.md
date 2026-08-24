# **Get ESPN NBA Event Competitor Linescores (Per-Quarter)**

Returns the per-quarter scoring breakdown for one team in one NBA event.
One row per period (regulation quarters + any overtime periods).

Returns the per-team statistical leaders for one NBA event in long
format: one row per (category x athlete rank). Categories typically
include points, rebounds, assists, and rating.

Returns the game-day roster index for one team in one NBA event. Each
row carries the athlete id and the core-v2 `$ref` URL — use the ref to
dereference athlete-game splits or biographical data.

Returns full team-game statistics for one team in one NBA event in long
format: one row per (category x stat). Covers offensive, defensive, and
general categories with both raw values and display strings.

Returns team records as of the given NBA event: overall, home, away,
conference, and division breakdowns where available. One row per record
type.

Returns a one-row tibble with one team's final score for one NBA event:
numeric `value`, display string, `winner` flag, and source metadata.
Quick-lookup wrapper — use `espn_nba_game_team_linescores()` for
per-period detail.

## Usage

``` r
espn_nba_game_team_linescores(event_id, team_id, ...)

espn_nba_game_team_leaders(event_id, team_id, ...)

espn_nba_game_team_roster(event_id, team_id, ...)

espn_nba_game_team_statistics(event_id, team_id, ...)

espn_nba_game_team_records(event_id, team_id, ...)

espn_nba_game_team_score(event_id, team_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- team_id:

  ESPN team identifier.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per period.

A long tibble with one row per (category x rank).

A tibble with one row per active athlete.

A long tibble with one row per (category x stat).

A tibble with one row per record type.

A single-row tibble.

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
[`espn_nba_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group.md),
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
  espn_nba_game_team_linescores(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Linescores ─────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:12 UTC
#> # A tibble: 8 × 7
#>   league event_id  team_id period value display_value source      
#>   <chr>  <chr>     <chr>    <int> <dbl> <chr>         <chr>       
#> 1 nba    401283399 29           1    30 30            1           
#> 2 nba    401283399 29           1    30 30            Basic/Manual
#> 3 nba    401283399 29           2    27 27            1           
#> 4 nba    401283399 29           2    27 27            Basic/Manual
#> 5 nba    401283399 29           3    29 29            1           
#> 6 nba    401283399 29           3    29 29            Basic/Manual
#> 7 nba    401283399 29           4    36 36            1           
#> 8 nba    401283399 29           4    36 36            Basic/Manual
# }
# \donttest{
  espn_nba_game_team_leaders(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Leaders ────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:12 UTC
#> # A tibble: 48 × 11
#>    league event_id  team_id category_name category_display category_abbrev  rank
#>    <chr>  <chr>     <chr>   <chr>         <chr>            <chr>           <int>
#>  1 nba    401283399 29      points        Points           Pts                 1
#>  2 nba    401283399 29      points        Points           Pts                 2
#>  3 nba    401283399 29      points        Points           Pts                 3
#>  4 nba    401283399 29      points        Points           Pts                 4
#>  5 nba    401283399 29      points        Points           Pts                 5
#>  6 nba    401283399 29      points        Points           Pts                 6
#>  7 nba    401283399 29      points        Points           Pts                 7
#>  8 nba    401283399 29      points        Points           Pts                 8
#>  9 nba    401283399 29      points        Points           Pts                 9
#> 10 nba    401283399 29      assists       Assists          Ast                 1
#> # ℹ 38 more rows
#> # ℹ 4 more variables: athlete_id <chr>, display_value <chr>, value <dbl>,
#> #   athlete_ref <chr>
# }
# \donttest{
  espn_nba_game_team_roster(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Roster ─────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:12 UTC
#> # A tibble: 0 × 5
#> # ℹ 5 variables: league <chr>, event_id <chr>, team_id <chr>, athlete_id <chr>,
#> #   ref <chr>
# }
# \donttest{
  espn_nba_game_team_statistics(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Statistics ─────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:12 UTC
#> # A tibble: 98 × 10
#>    league event_id  team_id category_name category_display stat_name stat_abbrev
#>    <chr>  <chr>     <chr>   <chr>         <chr>            <chr>     <chr>      
#>  1 nba    401283399 29      defensive     Defensive        blocks    BLK        
#>  2 nba    401283399 29      defensive     Defensive        defensiv… DR         
#>  3 nba    401283399 29      defensive     Defensive        steals    STL        
#>  4 nba    401283399 29      defensive     Defensive        turnover… Points Con…
#>  5 nba    401283399 29      defensive     Defensive        avgDefen… DR         
#>  6 nba    401283399 29      defensive     Defensive        avgBlocks BLK        
#>  7 nba    401283399 29      defensive     Defensive        avgSteals STL        
#>  8 nba    401283399 29      defensive     Defensive        avg48Def… DR         
#>  9 nba    401283399 29      defensive     Defensive        avg48Blo… BLK        
#> 10 nba    401283399 29      defensive     Defensive        avg48Ste… STL        
#> # ℹ 88 more rows
#> # ℹ 3 more variables: stat_display <chr>, value <dbl>, display_value <chr>
# }
# \donttest{
  espn_nba_game_team_records(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Records ────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:13 UTC
#> # A tibble: 5 × 11
#>   league event_id  team_id record_id name      abbreviation display_name       
#>   <chr>  <chr>     <chr>   <chr>     <chr>     <chr>        <chr>              
#> 1 nba    401283399 29      900       overall   Game         Record Year To Date
#> 2 nba    401283399 29      33        Home      NA           Home               
#> 3 nba    401283399 29      34        Road      NA           Road               
#> 4 nba    401283399 29      60        vs. Div.  NA           DIV                
#> 5 nba    401283399 29      61        vs. Conf. NA           CONF               
#> # ℹ 4 more variables: short_display_name <chr>, type <chr>, summary <chr>,
#> #   value <dbl>
# }
# \donttest{
  espn_nba_game_team_score(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Event Competitor Score ────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:40:13 UTC
#> # A tibble: 1 × 8
#>   league event_id  team_id value display_value winner source_id
#>   <chr>  <chr>     <chr>   <dbl> <chr>         <lgl>  <chr>    
#> 1 nba    401283399 29        122 122           TRUE   1        
#> # ℹ 1 more variable: source_description <chr>
# }
```
