# **Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Stats**

**Get ESPN Women's College Basketball Athlete Gamelog**

**Get ESPN Women's College Basketball Athlete Splits**

**Get ESPN Women's College Basketball Athlete Eventlog**

**Get ESPN Women's College Basketball Athlete Statisticslog**

## Usage

``` r
espn_mbb_player_overview(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_stats_v3(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_gamelog(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_splits(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_eventlog(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_statisticslog(
  athlete_id,
  season = most_recent_mbb_season(),
  ...
)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A named list of data frames: `Statistics`, `NextGame`, `Last5Games`,
`Headlines`, `FantasyOutlook`.

**Statistics**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

**NextGame**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**Last5Games**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

**Headlines**

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| headline    | character | News headline.                    |
| description | character | Long-form description text.       |
| published   | character | Publication timestamp (ISO 8601). |

**FantasyOutlook**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

A named list of per-category tibbles. Default category names are
`General`, `Offensive`, `Defensive`, `Rebounding`, `Shooting`, `Misc`.
Actual names are driven by the ESPN response; additional categories may
appear. Each tibble has columns depending on the category returned by
ESPN.

A single tibble with one row per game. Column names reflect the stat
labels returned by ESPN and will vary by season and player.

A single long-format tibble. When data are present, columns include at
minimum `category` and `split_name`, plus per-stat columns driven by
ESPN labels.

A single tibble. Per-event `statistics.$ref` URLs from the ESPN core-v2
API are returned as the character column `statistics_ref` and are NOT
resolved. Similarly, `event_ref`, `competition_ref`, and `team_ref` are
returned as character columns.

Columns as documented in the shared
[espn_mbb_player_eventlog_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_schema.md)
table.

A single tibble. When resolved, each row corresponds to one statistical
entry in the core-v2 statistics log, with `event_ref` and
`statistics_ref` character columns pointing to resolvable ESPN
endpoints.

|                |           |                                          |
|----------------|-----------|------------------------------------------|
| col_name       | types     | description                              |
| event_ref      | character | Reference link to the originating event. |
| statistics_ref | character |                                          |

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
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
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
  espn_mbb_player_overview(athlete_id = "4593919", season = 2025)
#> $Statistics
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Statistics from ESPN.com ──────
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $NextGame
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview NextGame from ESPN.com ────────
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 1 × 4
#>   id    date  name  short_name
#>   <chr> <chr> <chr> <chr>     
#> 1 NA    NA    NA    NA        
#> 
#> $Last5Games
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Last5Games from ESPN.com ──────
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $Headlines
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Headlines from ESPN.com ───────
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 13 × 5
#>    headline                                   description published byline type 
#>    <chr>                                      <chr>       <chr>     <chr>  <chr>
#>  1 Ex-Mizzou star Mitchell picks Kentucky af… Former Mis… 2026-08-… Myron… Head…
#>  2 College basketball eligibility: What to k… College ba… 2026-08-… Myron… Story
#>  3 Iowa State's Toure has surgery, expected … Iowa State… 2026-08-… NA     Head…
#>  4 Court halts order, denies extra year of e… In a legal… 2026-08-… Dan M… Head…
#>  5 Kohler, eligible for fifth year after inj… Former Mic… 2026-08-… Myron… Head…
#>  6 Jury rules New York Times defamed Alabama… An Alabama… 2026-08-… NA     Head…
#>  7 Greg Sankey, in filing, speaks out agains… SEC commis… 2026-08-… Dan M… Head…
#>  8 NCAA lands new deal to promote championsh… The NCAA a… 2026-08-… NA     Head…
#>  9 NBA draft: Early players to watch from th… After a su… 2026-08-… Jerem… Story
#> 10 North Carolina, NC State to hold 2nd game… With a red… 2026-08-… NA     Head…
#> 11 Mark Ingram out as UAB athletic director … Mark Ingra… 2026-08-… NA     Head…
#> 12 NCAA Bracketology: Predicting the 2027 me… The Blue D… 2026-08-… Joe L… Etic…
#> 13 UConn hiring Charlie Stevens from Spurs a… UConn has … 2026-08-… Myron… Head…
#> 
#> $FantasyOutlook
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview FantasyOutlook from ESPN.com ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_mbb_player_stats_v3(athlete_id = "4593919", season = 2025)
#> $`Season Averages`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [18]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [18]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [18]> G       
#> 
#> $`Season Totals`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [15]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [15]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [15]> G       
#> 
#> $`Season Misc Totals`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [11]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [11]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [11]> G       
#> 
#> $General
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $Offensive
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $Defensive
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $Rebounding
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $Shooting
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
#> $Misc
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_mbb_player_gamelog(athlete_id = "4593919", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_player_splits(athlete_id = "4593919", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Splits from ESPN.com ──── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 1 × 2
#>   name  display_name
#>   <chr> <chr>       
#> 1 split split       
# }
# \donttest{
  espn_mbb_player_eventlog(athlete_id = "4593919", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_player_statisticslog(athlete_id = "4593919", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Statisticslog from ESPN.com ────────────
#> ℹ Data updated: 2026-08-25 00:22:43 UTC
#> # A tibble: 3 × 2
#>   season$`$ref`                                                       statistics
#>   <chr>                                                               <list>    
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
#> 2 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
#> 3 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
# }
```
