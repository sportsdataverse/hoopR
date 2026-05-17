# **Get ESPN NBA Season Info**

**Get ESPN NBA Season Info**

**Get ESPN NBA Season Info**

## Usage

``` r
espn_nba_season_info(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent NBA
  season.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A named list of `hoopR_data` tibbles: `Info`, `Types`, `Athletes`,
`Coaches`, `Teams`, `Awards`. `$ref` URL components are returned as
character columns and are NOT auto-resolved – use targeted endpoint
functions for details.

**Info**

|              |           |                            |
|--------------|-----------|----------------------------|
| col_name     | types     | description                |
| year         | integer   | 4-digit year.              |
| start_date   | character | Start date (YYYY-MM-DD).   |
| end_date     | character | End date (YYYY-MM-DD).     |
| display_name | character | Display name.              |
| type_id      | character | Type identifier (numeric). |
| type_name    | character |                            |

**Types / Athletes / Coaches / Teams / Awards**

|          |           |                 |
|----------|-----------|-----------------|
| col_name | types     | description     |
| count    | integer   | Count of count. |
| ref      | character |                 |

## See also

Other ESPN NBA Functions:
[`espn_nba_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_awards.md),
[`espn_nba_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_eventlog.md),
[`espn_nba_athlete_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_gamelog.md),
[`espn_nba_athlete_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_info.md),
[`espn_nba_athlete_overview()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_overview.md),
[`espn_nba_athlete_splits()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_splits.md),
[`espn_nba_athlete_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_statisticslog.md),
[`espn_nba_athlete_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athlete_stats.md),
[`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md),
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md),
[`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md),
[`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md),
[`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_broadcasts.md),
[`espn_nba_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_odds.md),
[`espn_nba_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_officials.md),
[`espn_nba_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_nba_event_probabilities.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md),
[`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md),
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_seasons.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_leaders.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md),
[`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md),
[`espn_nba_venues()`](https://hoopR.sportsdataverse.org/reference/espn_nba_venues.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_nba_season_info(season = 2025)
#> $Info
#> ── ESPN NBA Season Info from ESPN.com ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:25 UTC
#> # A tibble: 1 × 6
#>    year start_date        end_date          display_name type_id type_name     
#>   <int> <chr>             <chr>             <chr>        <chr>   <chr>         
#> 1  2025 2024-09-24T07:00Z 2025-06-27T06:59Z 2024-25      2       Regular Season
#> 
#> $Types
#> ── ESPN NBA Season Types from ESPN.com ────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:25 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1     5 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/season…
#> 
#> $Athletes
#> ── ESPN NBA Season Athletes from ESPN.com ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:25 UTC
#> # A tibble: 0 × 0
#> 
#> $Coaches
#> ── ESPN NBA Season Coaches from ESPN.com ──────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:25 UTC
#> # A tibble: 0 × 0
#> 
#> $Teams
#> ── ESPN NBA Season Teams from ESPN.com ────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:25 UTC
#> # A tibble: 0 × 0
#> 
#> $Awards
#> ── ESPN NBA Season Awards from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:25 UTC
#> # A tibble: 1 × 2
#>   count ref                                                                     
#>   <int> <chr>                                                                   
#> 1    NA http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/season…
#> 
# }
```
