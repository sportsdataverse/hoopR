# **Get ESPN NBA Event Odds**

Returns the live game situation for one NBA event: timeouts remaining,
team fouls, fouls to give, bonus state, and a `$ref` to the last play.
During a live game this reflects current state; after the game ends the
values are frozen.

Returns pre-game predictor statistics for one NBA event in long format:
one row per (team × statistic). Typical stats include matchup quality,
predicted score, win probability, and team strength metrics. Returns
empty for events without predictor data (often the case for
already-played games).

Returns the per-team power-index `$ref` URLs for one NBA event. Coverage
is sparse — many events return zero items.

## Usage

``` r
espn_nba_game_odds(event_id, ...)

espn_nba_game_officials(event_id, ...)

espn_nba_game_broadcasts(event_id, ...)

espn_nba_game_situation(event_id, ...)

espn_nba_game_predictor(event_id, ...)

espn_nba_game_powerindex(event_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per odds provider.

Columns as documented in the shared
[espn_mbb_game_odds_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds_schema.md)
table.

A tibble with one row per official assigned to the game.

Columns as documented in the shared
[espn_mbb_game_officials_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_officials_schema.md)
table.

A tibble with one row per broadcast outlet for the game.

Columns as documented in the shared
[espn_mbb_game_broadcasts_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_broadcasts_schema.md)
table.

A single-row tibble with timeouts + fouls for both teams.

A long tibble with rows for both home and away teams.

A tibble with one row per team-game power-index entry.

## Details

**Get ESPN NBA Event Predictor (Pre-game)**

**Get ESPN NBA Event Power Index Index**

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
  espn_nba_game_odds(event_id = "401283399")
#> ── ESPN NBA Event Odds (event_id=401283399) from ESPN.com ─────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:45 UTC
#> # A tibble: 16 × 12
#>    event_id  provider_id provider_name details over_under spread home_money_line
#>    <chr>     <chr>       <chr>         <chr>        <dbl>  <dbl>           <int>
#>  1 401283399 50          BetfairSport… MEM -7…       227    -7.5              NA
#>  2 401283399 38          Caesars       MEM -7        227    -7                NA
#>  3 401283399 44          Caesars (New… MEM -10        NA   -10                NA
#>  4 401283399 31          Caesars Spor… MEM -7        227    -7                NA
#>  5 401283399 45          Caesars Spor… MEM -7        227    -7                NA
#>  6 401283399 46          Caesars Spor… NA            236.   NA                NA
#>  7 401283399 43          Caesars Spor… MEM -7        227    -7                NA
#>  8 401283399 47          MGM           MEM -6…       228.   -6.5              NA
#>  9 401283399 48          PointsBet     MEM -7        226.   -7                NA
#> 10 401283399 41          SugarHouse    MEM -7…       226.   -7.5              NA
#> 11 401283399 36          Unibet        MEM -7…       226.   -7.5              NA
#> 12 401283399 25          Westgate      MEM -7        227    -7                NA
#> 13 401283399 1001        accuscore     MEM -7        227    -7                NA
#> 14 401283399 1004        consensus     MEM -7        227    -7                NA
#> 15 401283399 1003        numberfire    MEM -7        228    -7                NA
#> 16 401283399 1002        teamrankings  MEM -7        228    -7                NA
#> # ℹ 5 more variables: away_money_line <int>, home_team_odds_open <dbl>,
#> #   home_team_odds_close <dbl>, away_team_odds_open <dbl>,
#> #   away_team_odds_close <dbl>
# }
# \donttest{
  espn_nba_game_officials(event_id = "401283399")
#> ── ESPN NBA Event Officials (event_id=401283399) from ESPN.com ── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:45 UTC
#> # A tibble: 3 × 8
#>   event_id  official_id full_name   display_name position_id position_name
#>   <chr>     <chr>       <chr>       <chr>        <chr>       <chr>        
#> 1 401283399 6856        Eric Lewis  Eric Lewis   40          Referee      
#> 2 401283399 2612372     Jacyn Goble Jacyn Goble  40          Referee      
#> 3 401283399 4394825     Evan Scott  Evan Scott   40          Referee      
#> # ℹ 2 more variables: position_type <chr>, order <int>
# }
# \donttest{
  espn_nba_game_broadcasts(event_id = "401283399")
#> ── ESPN NBA Event Broadcasts (event_id=401283399) from ESPN.com ────────────────
#> ℹ Data updated: 2026-08-25 01:41:45 UTC
#> # A tibble: 0 × 10
#> # ℹ 10 variables: event_id <chr>, broadcast_id <chr>, type_id <chr>,
#> #   type_short_name <chr>, type_long_name <chr>, market_id <chr>,
#> #   market_type <chr>, names <chr>, lang <chr>, region <chr>
# }
# \donttest{
  espn_nba_game_situation(event_id = 401283399)
#> ── ESPN NBA Event Situation ───────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:45 UTC
#> # A tibble: 1 × 15
#>   league event_id  home_timeouts_current home_timeouts_remaining
#>   <chr>  <chr>                     <int>                   <int>
#> 1 nba    401283399                     3                       0
#> # ℹ 11 more variables: away_timeouts_current <int>,
#> #   away_timeouts_remaining <int>, home_team_fouls <int>,
#> #   home_team_fouls_current <int>, home_fouls_to_give <int>,
#> #   home_bonus_state <chr>, away_team_fouls <int>,
#> #   away_team_fouls_current <int>, away_fouls_to_give <int>,
#> #   away_bonus_state <chr>, last_play_ref <chr>
# }
# \donttest{
  espn_nba_game_predictor(event_id = 401283399)
#> ── ESPN NBA Event Predictor ───────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:45 UTC
#> # A tibble: 6 × 13
#>   league event_id  name         short_name last_modified side  team_id stat_name
#>   <chr>  <chr>     <chr>        <chr>      <chr>         <chr> <chr>   <chr>    
#> 1 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      gameProj…
#> 2 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      matchupQ…
#> 3 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      teamChan…
#> 4 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      teamPred…
#> 5 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      teamExpe…
#> 6 nba    401283399 Oklahoma Ci… OKC @ MEM  2021-07-21T1… away  25      oppExpec…
#> # ℹ 5 more variables: stat_display <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_game_powerindex(event_id = 401283399)
#> ── ESPN NBA Event Power Index ─────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:46 UTC
#> # A tibble: 2 × 4
#>   league event_id  team_id ref                                                  
#>   <chr>  <chr>     <chr>   <chr>                                                
#> 1 nba    401283399 25      http://sports.core.api.espn.com/v2/sports/basketball…
#> 2 nba    401283399 29      http://sports.core.api.espn.com/v2/sports/basketball…
# }
```
