# **Get ESPN NBA Athlete Info**

**Get ESPN NBA Athlete Info**

**Get ESPN NBA Athlete Info**

## Usage

``` r
espn_nba_player_info(athlete_id, ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A named list of data frames: `Bio`, `Team`, `Position`, `Status`,
`College`, `Draft`.

**Bio**

Columns as documented in the shared
[espn_mbb_player_info_bio_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info_bio_schema.md)
table.

**Team**

|              |           |                     |
|--------------|-----------|---------------------|
| col_name     | types     | description         |
| id           | character | Id.                 |
| abbreviation | character | Short abbreviation. |
| display_name | character | Display name.       |

**Position**

|              |           |                     |
|--------------|-----------|---------------------|
| col_name     | types     | description         |
| id           | character | Id.                 |
| name         | character | Display name.       |
| abbreviation | character | Short abbreviation. |

**Status**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| id       | character | Id.                     |
| name     | character | Display name.           |
| type     | character | Record type / category. |

**College**

|          |           |               |
|----------|-----------|---------------|
| col_name | types     | description   |
| id       | character | Id.           |
| name     | character | Display name. |
| mascot   | character | Team mascot.  |

**Draft**

|           |           |                             |
|-----------|-----------|-----------------------------|
| col_name  | types     | description                 |
| year      | character | 4-digit year.               |
| round     | character | Tournament / playoff round. |
| selection | character |                             |

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
  espn_nba_player_info(athlete_id = "1966")
#> $Bio
#> ── ESPN NBA Athlete Bio from ESPN.com ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:50 UTC
#> # A tibble: 1 × 21
#>   id    uid         guid  first_name last_name full_name display_name short_name
#>   <chr> <chr>       <chr> <chr>      <chr>     <chr>     <chr>        <chr>     
#> 1 1966  s:40~l:46~… 1f65… LeBron     James     LeBron J… LeBron James L. James  
#> # ℹ 13 more variables: weight <dbl>, display_weight <chr>, height <dbl>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>, debut_year <int>,
#> #   jersey <chr>, active <lgl>, headshot_href <chr>, birth_city <chr>,
#> #   birth_state <chr>, birth_country <chr>
#> 
#> $Team
#> ── ESPN NBA Athlete Team from ESPN.com ────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:50 UTC
#> # A tibble: 1 × 1
#>   x_ref                                                                         
#>   <chr>                                                                         
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/2026…
#> 
#> $Position
#> ── ESPN NBA Athlete Position from ESPN.com ────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:50 UTC
#> # A tibble: 1 × 5
#>   id    name    display_name abbreviation leaf 
#>   <chr> <chr>   <chr>        <chr>        <lgl>
#> 1 7     Forward Forward      F            FALSE
#> 
#> $Status
#> ── ESPN NBA Athlete Status from ESPN.com ──────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:50 UTC
#> # A tibble: 1 × 4
#>   id    name   type   abbreviation
#>   <chr> <chr>  <chr>  <chr>       
#> 1 1     Active active Active      
#> 
#> $College
#> ── ESPN NBA Athlete College from ESPN.com ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:50 UTC
#> # A tibble: 0 × 0
#> 
#> $Draft
#> ── ESPN NBA Athlete Draft from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:41:51 UTC
#> # A tibble: 1 × 4
#>   year  round selection display_text               
#>   <chr> <chr> <chr>     <chr>                      
#> 1 2003  1     1         Year: 2003 Round: 1 Pick: 1
#> 
# }
```
