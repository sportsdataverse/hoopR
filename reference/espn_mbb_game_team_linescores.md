# **Get ESPN MBB Event Competitor Linescores (Per-Quarter)**

Returns the per-quarter scoring breakdown for one team in one NBA event.
One row per period (regulation quarters + any overtime periods).

Returns the per-team statistical leaders for one MBB event in long
format: one row per (category x athlete rank). Categories typically
include points, rebounds, assists, and rating.

Returns the game-day roster index for one team in one MBB event. Each
row carries the athlete id and the core-v2 `$ref` URL — use the ref to
dereference athlete-game splits or biographical data.

Returns full team-game statistics for one team in one MBB event in long
format: one row per (category x stat). Covers offensive, defensive, and
general categories with both raw values and display strings.

Returns team records as of the given MBB event: overall, home, away,
conference, and division breakdowns where available. One row per record
type.

Returns a one-row tibble with one team's final score for one MBB event:
numeric `value`, display string, `winner` flag, and source metadata.
Quick-lookup wrapper — use `espn_mbb_game_team_linescores()` for
per-period detail.

## Usage

``` r
espn_mbb_game_team_linescores(event_id, team_id, ...)

espn_mbb_game_team_leaders(event_id, team_id, ...)

espn_mbb_game_team_roster(event_id, team_id, ...)

espn_mbb_game_team_statistics(event_id, team_id, ...)

espn_mbb_game_team_records(event_id, team_id, ...)

espn_mbb_game_team_score(event_id, team_id, ...)
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

Other ESPN MBB Functions:
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
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
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
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_game_team_linescores(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Linescores ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:08 UTC
#> # A tibble: 4 × 7
#>   league                  event_id  team_id period value display_value source   
#>   <chr>                   <chr>     <chr>    <int> <dbl> <chr>         <chr>    
#> 1 mens-college-basketball 401256760 52           1    45 45            1        
#> 2 mens-college-basketball 401256760 52           1    45 45            Basic/Ma…
#> 3 mens-college-basketball 401256760 52           2    38 38            1        
#> 4 mens-college-basketball 401256760 52           2    38 38            Basic/Ma…
# }
# \donttest{
  espn_mbb_game_team_leaders(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Leaders ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:08 UTC
#> # A tibble: 46 × 11
#>    league  event_id team_id category_name category_display category_abbrev  rank
#>    <chr>   <chr>    <chr>   <chr>         <chr>            <chr>           <int>
#>  1 mens-c… 4012567… 52      points        Points           Pts                 1
#>  2 mens-c… 4012567… 52      points        Points           Pts                 2
#>  3 mens-c… 4012567… 52      points        Points           Pts                 3
#>  4 mens-c… 4012567… 52      points        Points           Pts                 4
#>  5 mens-c… 4012567… 52      points        Points           Pts                 5
#>  6 mens-c… 4012567… 52      points        Points           Pts                 6
#>  7 mens-c… 4012567… 52      points        Points           Pts                 7
#>  8 mens-c… 4012567… 52      points        Points           Pts                 8
#>  9 mens-c… 4012567… 52      points        Points           Pts                 9
#> 10 mens-c… 4012567… 52      points        Points           Pts                10
#> # ℹ 36 more rows
#> # ℹ 4 more variables: athlete_id <chr>, display_value <chr>, value <dbl>,
#> #   athlete_ref <chr>
# }
# \donttest{
  espn_mbb_game_team_roster(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Roster ─────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:08 UTC
#> # A tibble: 0 × 5
#> # ℹ 5 variables: league <chr>, event_id <chr>, team_id <chr>, athlete_id <chr>,
#> #   ref <chr>
# }
# \donttest{
  espn_mbb_game_team_statistics(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Statistics ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:08 UTC
#> # A tibble: 71 × 10
#>    league  event_id team_id category_name category_display stat_name stat_abbrev
#>    <chr>   <chr>    <chr>   <chr>         <chr>            <chr>     <chr>      
#>  1 mens-c… 4012567… 52      defensive     Defensive        blocks    BLK        
#>  2 mens-c… 4012567… 52      defensive     Defensive        defensiv… DR         
#>  3 mens-c… 4012567… 52      defensive     Defensive        steals    STL        
#>  4 mens-c… 4012567… 52      defensive     Defensive        turnover… PTS OFF TO 
#>  5 mens-c… 4012567… 52      defensive     Defensive        avgDefen… DR         
#>  6 mens-c… 4012567… 52      defensive     Defensive        avgBlocks BLK        
#>  7 mens-c… 4012567… 52      defensive     Defensive        avgSteals STL        
#>  8 mens-c… 4012567… 52      general       General          largestL… LL         
#>  9 mens-c… 4012567… 52      general       General          disquali… DQ         
#> 10 mens-c… 4012567… 52      general       General          flagrant… FLAG       
#> # ℹ 61 more rows
#> # ℹ 3 more variables: stat_display <chr>, value <dbl>, display_value <chr>
# }
# \donttest{
  espn_mbb_game_team_records(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Records ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:08 UTC
#> # A tibble: 4 × 11
#>   league              event_id team_id record_id name  abbreviation display_name
#>   <chr>               <chr>    <chr>   <chr>     <chr> <chr>        <chr>       
#> 1 mens-college-baske… 4012567… 52      1         over… Game         Record Year…
#> 2 mens-college-baske… 4012567… 52      9002      Home  NA           Home        
#> 3 mens-college-baske… 4012567… 52      9003      Road  NA           Road        
#> 4 mens-college-baske… 4012567… 52      9009      vs. … NA           CONF        
#> # ℹ 4 more variables: short_display_name <chr>, type <chr>, summary <chr>,
#> #   value <dbl>
# }
# \donttest{
  espn_mbb_game_team_score(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Competitor Score ────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:08 UTC
#> # A tibble: 1 × 8
#>   league                  event_id  team_id value display_value winner source_id
#>   <chr>                   <chr>     <chr>   <dbl> <chr>         <lgl>  <chr>    
#> 1 mens-college-basketball 401256760 52         83 83            TRUE   1        
#> # ℹ 1 more variable: source_description <chr>
# }
```
