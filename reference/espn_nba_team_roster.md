# **Get ESPN NBA Team Roster**

**Get ESPN NBA Team Roster**

**Get ESPN NBA Team Roster**

## Usage

``` r
espn_nba_team_roster(team_id, season = most_recent_nba_season(), ...)
```

## Arguments

- team_id:

  ESPN team identifier (character or numeric).

- season:

  Season year (numeric). Defaults to the most recent NBA season.

- ...:

  Additional arguments; currently unused.

## Value

A single tibble with one row per athlete.

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | character | Unique athlete identifier (ESPN). |
| full_name | character | Player's full name. |
| jersey | character | Jersey number worn by the player. |
| position_abbrev | character |  |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| height | character | Player height (string e.g. '6-2' or inches). |
| weight | character | Player weight in pounds. |
| age | character | Player age (in years). |
| birth_date | character | Date of birth (YYYY-MM-DD). |
| birth_place | character | Place of birth. |
| headshot | character | Headshot image URL. |
| link_web | character | Web link / URL. |
| status | character | Status label. |
| team_id | character | Unique team identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |

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
[`espn_nba_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_info.md),
[`espn_nba_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_seasons.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md),
[`espn_nba_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_leaders.md),
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md),
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
  espn_nba_team_roster(team_id = "17", season = 2025)
#> ── ESPN NBA Team Roster from ESPN.com ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:24:28 UTC
#> # A tibble: 19 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 4397018    Ochai Ag… 30     G               Guard         "6' 5… 215 l… 26   
#>  2 4278067    Nic Clax… 33     C               Center        "6' 1… 215 l… 27   
#>  3 4712896    Noah Clo… 21     F               Forward       "6' 1… 210 l… 21   
#>  4 5175643    Egor Dem… 8      G               Guard         "6' 8… 200 l… 20   
#>  5 4432887    Tyson Et… 10     G               Guard         "6' 0… 200 l… 26   
#>  6 5174655    Chaney J… 31     F               Forward       "6' 8… 225 l… 23   
#>  7 4432821    E.J. Lid… 9      F               Forward       "6' 6… 240 l… 25   
#>  8 3907823    Terance … 14     G               Guard         "6' 6… 215 l… 29   
#>  9 4687718    Josh Min… 00     F               Forward       "6' 8… 205 l… 23   
#> 10 4278104    Michael … 17     F               Forward       "6' 1… 218 l… 27   
#> 11 5037873    Drake Po… 4      G               Guard         "6' 5… 195 l… 20   
#> 12 5242502    Ben Saraf 77     G               Guard         "6' 6… 200 l… 20   
#> 13 3934620    Trevon S… 13     F               Forward       "6' 8… 225 l… 29   
#> 14 4432194    Day'Ron … 20     C               Center        "6' 1… 265 l… 24   
#> 15 4397784    Malachi … 18     G               Guard         "6' 4… 205 l… 26   
#> 16 5279130    Nolan Tr… 88     G               Guard         "6' 3… 185 l… 19   
#> 17 4433137    Ziaire W… 1      F               Forward       "6' 9… 185 l… 24   
#> 18 4431714    Jalen Wi… 22     F               Forward       "6' 6… 220 l… 25   
#> 19 5107173    Danny Wo… 2      F               Forward       "6' 1… 250 l… 22   
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>
# }
```
