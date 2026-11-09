# **Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Stats**

**Get ESPN Women's College Basketball Athlete Gamelog**

**Get ESPN Women's College Basketball Athlete Splits**

**Get ESPN Women's College Basketball Athlete Eventlog**

**Get ESPN Women's College Basketball Athlete Statisticslog**

**Get ESPN NBA Athlete Overview**

**Get ESPN NBA Athlete Overview**

**Get ESPN NBA Athlete Stats**

**Get ESPN NBA Athlete Gamelog**

**Get ESPN NBA Athlete Splits**

**Get ESPN NBA Athlete Eventlog**

**Get ESPN NBA Athlete Statisticslog**

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

espn_nba_player_overview(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_stats_v3(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_gamelog(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_splits(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_eventlog(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_statisticslog(
  athlete_id,
  season = most_recent_nba_season(),
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

A named list of `hoopR_data` tibbles: `Statistics`, `NextGame`,
`Last5Games`, `Headlines`, `FantasyOutlook`.

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

A `hoopR_data` tibble with one row per event appearance.

|                 |           |                                          |
|-----------------|-----------|------------------------------------------|
| col_name        | types     | description                              |
| event_ref       | character | Reference link to the originating event. |
| competition_ref | character |                                          |
| team_ref        | character |                                          |
| statistics_ref  | character |                                          |

Per-event `statistics.$ref` URLs from the ESPN core-v2 API are returned
as the character column `statistics_ref` and are NOT resolved.
Similarly, `event_ref`, `competition_ref`, and `team_ref` are returned
as character columns.

A `hoopR_data` tibble with one row per statistics entry.

|                |           |                                          |
|----------------|-----------|------------------------------------------|
| col_name       | types     | description                              |
| event_ref      | character | Reference link to the originating event. |
| statistics_ref | character |                                          |

When resolved, each row corresponds to one statistical entry in the
core-v2 statistics log, with `event_ref` and `statistics_ref` character
columns pointing to resolvable ESPN endpoints.

A named list of `hoopR_data` tibbles: `Statistics`, `NextGame`,
`Last5Games`, `Headlines`, `FantasyOutlook`.

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

A `hoopR_data` tibble with one row per event appearance.

|                 |           |                                          |
|-----------------|-----------|------------------------------------------|
| col_name        | types     | description                              |
| event_ref       | character | Reference link to the originating event. |
| competition_ref | character |                                          |
| team_ref        | character |                                          |
| statistics_ref  | character |                                          |

Per-event `statistics.$ref` URLs from the ESPN core-v2 API are returned
as the character column `statistics_ref` and are NOT resolved.
Similarly, `event_ref`, `competition_ref`, and `team_ref` are returned
as character columns.

A `hoopR_data` tibble with one row per statistics entry.

|                |           |                                          |
|----------------|-----------|------------------------------------------|
| col_name       | types     | description                              |
| event_ref      | character | Reference link to the originating event. |
| statistics_ref | character |                                          |

When resolved, each row corresponds to one statistical entry in the
core-v2 statistics log, with `event_ref` and `statistics_ref` character
columns pointing to resolvable ESPN endpoints.

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_player_overview(athlete_id = "4593919", season = 2025)
#> $Statistics
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Statistics from ESPN.com ──────
#> ℹ Data updated: 2026-11-09 21:12:23 UTC
#> # A tibble: 0 × 0
#> 
#> $NextGame
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview NextGame from ESPN.com ────────
#> ℹ Data updated: 2026-11-09 21:12:23 UTC
#> # A tibble: 1 × 4
#>   id    date  name  short_name
#>   <chr> <chr> <chr> <chr>     
#> 1 NA    NA    NA    NA        
#> 
#> $Last5Games
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Last5Games from ESPN.com ──────
#> ℹ Data updated: 2026-11-09 21:12:23 UTC
#> # A tibble: 0 × 0
#> 
#> $Headlines
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Headlines from ESPN.com ───────
#> ℹ Data updated: 2026-11-09 21:12:23 UTC
#> # A tibble: 13 × 5
#>    headline                                   description published byline type 
#>    <chr>                                      <chr>       <chr>     <chr>  <chr>
#>  1 Kansas' Melvin Council Jr. suffers broken… Kansas gua… 2026-11-… Jeff … Head…
#>  2 Breaking down the men's 2026-27 AP week 1… Stats, rec… 2026-11-… ESPN   Story
#>  3 UCLA hops into top 10 of men's AP Top 25 … UCLA jumpe… 2026-11-… NA     Head…
#>  4 FSU hires alum Jeff Purinton as athletic … Florida St… 2026-11-… Andre… Head…
#>  5 UConn's Demary, Mullins exact revenge aga… UConn's Si… 2026-11-… Jeff … Head…
#>  6 NCAA secures win in struggle over five-ye… Federal ap… 2026-11-… NA     Head…
#>  7 Sources: SEC considering luxury tax for e… The SEC is… 2026-11-… Mark … Head…
#>  8 RJ Godfrey sues Arizona Board of Regents … RJ Godfrey… 2026-11-… NA     Head…
#>  9 Central Michigan's Andy Bronkema on leave… Central Mi… 2026-11-… NA     Head…
#> 10 Saint Louis star Robbie Avila granted inj… Saint Loui… 2026-11-… NA     Head…
#> 11 Early top-10 men's basketball recruiting … The highes… 2026-11-… Paul … Story
#> 12 How Boynton calmed a storm that threatene… Repeating … 2026-11-… Jeff … Story
#> 13 The Bilas Index: The best men's basketbal… It's that … 2026-11-… Jay B… Story
#> 
#> $FantasyOutlook
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview FantasyOutlook from ESPN.com ──
#> ℹ Data updated: 2026-11-09 21:12:23 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_mbb_player_stats_v3(athlete_id = "4593919", season = 2025)
#> $`Season Averages`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [18]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [18]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [18]> G       
#> 
#> $`Season Totals`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [15]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [15]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [15]> G       
#> 
#> $`Season Misc Totals`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [11]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [11]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [11]> G       
#> 
#> $General
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Offensive
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Defensive
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Rebounding
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Shooting
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Misc
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_mbb_player_gamelog(athlete_id = "4593919", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_player_splits(athlete_id = "4593919", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Splits from ESPN.com ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
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
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 3 × 2
#>   season$`$ref`                                                       statistics
#>   <chr>                                                               <list>    
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
#> 2 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
#> 3 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
# }
# \donttest{
  espn_nba_player_overview(athlete_id = "1966", season = 2024)
#> $Statistics
#> ── ESPN NBA Athlete Overview Statistics from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $NextGame
#> ── ESPN NBA Athlete Overview NextGame from ESPN.com ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 1 × 4
#>   id    date  name  short_name
#>   <chr> <chr> <chr> <chr>     
#> 1 NA    NA    NA    NA        
#> 
#> $Last5Games
#> ── ESPN NBA Athlete Overview Last5Games from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Headlines
#> ── ESPN NBA Athlete Overview Headlines from ESPN.com ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 13 × 5
#>    headline                                   description published byline type 
#>    <chr>                                      <chr>       <chr>     <chr>  <chr>
#>  1 Which NBA father-son duos have the most p… In 2024, B… 2026-11-… Keith… Story
#>  2 LeBron James gets up for the beautiful du… LeBron Jam… 2026-11-… NA     Media
#>  3 Man arrested on stalking charges at LeBro… A man was … 2026-11-… Dave … Head…
#>  4 In Cleveland return, LeBron James struggl… Returning … 2026-11-… Kris … Head…
#>  5 Cavs win big at home over the 76ers        Cavs win b… 2026-11-… NA     Media
#>  6 LeBron James vs. Cleveland: Top performan… James hold… 2026-11-… Antho… Story
#>  7 Inside LeBron's first game in Philly -- m… Nearly 25 … 2026-11-… Dave … Story
#>  8 Windhorst & MacMahon: What league insider… Brian Wind… 2026-11-… Brian… Story
#>  9 LeBron James' reps send cease-and-desist … LeBron Jam… 2026-11-… NA     Head…
#> 10 Stephen A.: 76ers will win it all if Embi… Stephen A.… 2026-11-… NA     Media
#> 11 LeBron James: 'Too early to be talking Fi… LeBron Jam… 2026-11-… Kris … Head…
#> 12 LeBron scores NBA record 16,000th field g… LeBron sco… 2026-11-… NA     Media
#> 13 Shams to McAfee: Luka Doncic has been a t… Shams to M… 2026-11-… NA     Media
#> 
#> $FantasyOutlook
#> ── ESPN NBA Athlete Overview FantasyOutlook from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 1 × 1
#>   outlook
#>   <chr>  
#> 1 NA     
#> 
# }
# \donttest{
  espn_nba_player_stats_v3(athlete_id = "1966", season = 2024)
#> $`Regular Season Averages`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 24 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [18]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [18]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [18]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [18]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [18]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [18]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [18]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [18]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [18]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [18]> F       
#> # ℹ 14 more rows
#> 
#> $`Regular Season Totals`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 24 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [15]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [15]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [15]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [15]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [15]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [15]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [15]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [15]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [15]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [15]> F       
#> # ℹ 14 more rows
#> 
#> $`Regular Season Misc Totals`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 24 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [10]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [10]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [10]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [10]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [10]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [10]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [10]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [10]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [10]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [10]> F       
#> # ℹ 14 more rows
#> 
#> $General
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Offensive
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Defensive
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Rebounding
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Shooting
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
#> $Misc
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:24 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_nba_player_gamelog(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Gamelog from ESPN.com ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:25 UTC
#> # A tibble: 82 × 25
#>    id        at_vs game_date     score home_team_id away_team_id home_team_score
#>    <chr>     <chr> <chr>         <chr> <chr>        <chr>        <chr>          
#>  1 401655085 @     2024-04-30T0… 108-… 7            13           108            
#>  2 401655084 vs    2024-04-28T0… 119-… 13           7            119            
#>  3 401655083 vs    2024-04-26T0… 112-… 13           7            105            
#>  4 401655082 @     2024-04-23T0… 101-… 7            13           101            
#>  5 401654758 @     2024-04-21T0… 114-… 7            13           114            
#>  6 401654655 @     2024-04-16T2… 110-… 3            13           106            
#>  7 401585823 @     2024-04-14T1… 124-… 3            13           108            
#>  8 401585805 @     2024-04-13T0… 123-… 29           13           120            
#>  9 401585783 vs    2024-04-10T0… 134-… 13           9            120            
#> 10 401585755 vs    2024-04-06T1… 116-… 13           5            116            
#> # ℹ 72 more rows
#> # ℹ 18 more variables: away_team_score <chr>, game_result <chr>,
#> #   league_name <chr>, league_abbreviation <chr>, league_short_name <chr>,
#> #   event_note <chr>, team_id <chr>, team_uid <chr>, team_abbreviation <chr>,
#> #   team_logo <chr>, team_is_all_star <chr>, opponent_id <chr>,
#> #   opponent_uid <chr>, opponent_display_name <chr>,
#> #   opponent_abbreviation <chr>, opponent_logo <chr>, …
# }
# \donttest{
  espn_nba_player_splits(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Splits from ESPN.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:25 UTC
#> # A tibble: 6 × 3
#>   name       display_name splits       
#>   <chr>      <chr>        <list>       
#> 1 split      split        <df [6 × 3]> 
#> 2 byMonth    Month        <df [9 × 3]> 
#> 3 byResult   Result       <df [2 × 3]> 
#> 4 byPosition Position     <df [1 × 3]> 
#> 5 byDay      Day          <df [7 × 3]> 
#> 6 byOpponent Opponent     <df [28 × 3]>
# }
# \donttest{
  espn_nba_player_eventlog(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Eventlog from ESPN.com ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:25 UTC
#> # A tibble: 25 × 6
#>    event_ref              competition_ref team_ref statistics_ref team_id played
#>    <chr>                  <chr>           <chr>    <chr>          <chr>   <lgl> 
#>  1 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  2 http://sports.core.ap… http://sports.… NA       NA             13      FALSE 
#>  3 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  4 http://sports.core.ap… http://sports.… NA       NA             13      FALSE 
#>  5 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  6 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  7 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  8 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  9 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#> 10 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#> # ℹ 15 more rows
# }
# \donttest{
  espn_nba_player_statisticslog(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Statisticslog from ESPN.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:25 UTC
#> # A tibble: 24 × 2
#>    season$`$ref`                                                      statistics
#>    <chr>                                                              <list>    
#>  1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  2 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  3 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  4 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  5 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  6 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  7 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  8 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  9 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#> 10 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#> # ℹ 14 more rows
# }
```
