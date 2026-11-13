# **Load hoopR NBA team crosswalk**

Loads a pre-built per-season NBA team crosswalk that maps ESPN team
identifiers to NBA.com identifiers and canonical abbreviations. The
files are versioned `.rds` snapshots stored in the `nba_crosswalk`
release of the sportsdataverse-data repository.

Loads a pre-built per-season NBA schedule crosswalk that links ESPN game
identifiers to NBA.com game identifiers. The files are versioned `.rds`
snapshots stored in the `nba_crosswalk` release of the
sportsdataverse-data repository.

Loads a pre-built per-season NBA player crosswalk that maps ESPN athlete
identifiers to NBA.com player identifiers. The files are versioned
`.rds` snapshots stored in the `nba_crosswalk` release of the
sportsdataverse-data repository.

Loads a pre-built per-season MBB team crosswalk that maps ESPN team
identifiers to Fox Sports (Bifrost), Bart Torvik, and KenPom identifiers
and canonical abbreviations. The files are versioned `.rds` snapshots
stored in the `mbb_crosswalk` release of the sportsdataverse-data
repository.

Loads a pre-built per-season MBB schedule crosswalk that links ESPN game
identifiers to Bart Torvik game identifiers. The files are versioned
`.rds` snapshots stored in the `mbb_crosswalk` release of the
sportsdataverse-data repository.

Loads a pre-built per-season MBB player crosswalk that maps ESPN athlete
identifiers to Fox Sports (Bifrost) player identifiers. The files are
versioned `.rds` snapshots stored in the `mbb_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_nba_team_crosswalk(seasons = most_recent_nba_season())

load_nba_schedule_crosswalk(seasons = most_recent_nba_season())

load_nba_player_crosswalk(seasons = most_recent_nba_season())

load_mbb_team_crosswalk(seasons = most_recent_mbb_season())

load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())

load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
```

## Source

The `nba_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_crosswalk>.

The `nba_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_crosswalk>.

The `nba_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_crosswalk>.

The `mbb_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.

The `mbb_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.

The `mbb_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.

## Arguments

- seasons:

  A vector of 4-digit seasons, or `TRUE` for every published season.
  Accepted seasons are the ones the release publishes: 2002 onward for
  the NBA crosswalks and `load_mbb_team_crosswalk()`, 2008 onward for
  `load_mbb_schedule_crosswalk()`, 2025 onward for
  `load_mbb_player_crosswalk()`; the upper bound is
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)
  /
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).
  When `seasons` is left at its default and that season's file is not
  published yet, the loader reads the newest published season instead,
  with a message. An explicit request for that not-yet-published season
  is kept as asked: the read warns and returns an empty frame. A season
  outside the published range, or in a known gap, is an error. ESPN ids
  (`espn_game_id`, `espn_athlete_id`, `espn_team_id`) are returned as
  integer, matching the ESPN box score, schedule and roster loaders. So
  are the NBA Stats ids of the NBA crosswalks (`nba_team_id`,
  `nba_home_team_id`, `nba_away_team_id`, `nba_player_id`), matching the
  `load_nba_stats_*()` loaders; `nba_game_id` keeps its leading zeros as
  character (`"0022300001"`). The live builders
  ([`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)
  and friends) still return the NBA Stats ids as character.

## Value

Returns a tibble of class `hoopR_data` with one row per NBA team per
season. Columns include at minimum `season`, `espn_team_id`, and
`nba_team_id`.

Returns a tibble of class `hoopR_data` with one row per NBA game per
season. Columns include at minimum `season`, `espn_game_id`, and
`nba_game_id`.

Returns a tibble of class `hoopR_data` with one row per NBA player per
season. Columns include at minimum `season`, `espn_athlete_id`, and
`nba_player_id`.

Returns a tibble of class `hoopR_data` with one row per MBB team per
season. Columns include at minimum `season` and `espn_team_id`.

Returns a tibble of class `hoopR_data` with one row per MBB game per
season. Columns include at minimum `season` and `espn_game_id`.

Returns a tibble of class `hoopR_data` with one row per MBB player per
season. Columns include at minimum `season` and `espn_athlete_id`.

## See also

Other NBA Crosswalk Functions:
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

Other MBB Crosswalk Functions:
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_nba_team_crosswalk(seasons = most_recent_nba_season())
#> ── NBA team crosswalk (ESPN / NBA Stats / Fox) ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-06 16:30:16 UTC
#> # A tibble: 30 × 21
#>    season espn_team_id espn_abbreviation espn_display_name     espn_short_name
#>     <int>        <int> <chr>             <chr>                 <chr>          
#>  1   2027            1 ATL               Atlanta Hawks         Hawks          
#>  2   2027            2 BOS               Boston Celtics        Celtics        
#>  3   2027            3 NO                New Orleans Pelicans  Pelicans       
#>  4   2027            4 CHI               Chicago Bulls         Bulls          
#>  5   2027            5 CLE               Cleveland Cavaliers   Cavaliers      
#>  6   2027            6 DAL               Dallas Mavericks      Mavericks      
#>  7   2027            7 DEN               Denver Nuggets        Nuggets        
#>  8   2027            8 DET               Detroit Pistons       Pistons        
#>  9   2027            9 GS                Golden State Warriors Warriors       
#> 10   2027           10 HOU               Houston Rockets       Rockets        
#> # ℹ 20 more rows
#> # ℹ 16 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   nba_team_id <int>, nba_team_abbreviation <chr>, nba_team_name <chr>,
#> #   nba_team_city <chr>, nba_team_slug <chr>, nba_conference <chr>,
#> #   nba_division <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   yahoo_team_id <chr>, yahoo_team_abbreviation <chr>, yahoo_team_name <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 16:30:47 UTC
#> # A tibble: 1,207 × 16
#>    season season_type game_date  home_espn_team_id away_espn_team_id
#>     <int> <chr>       <date>                 <int>             <int>
#>  1   2027 NA          2027-04-11                 6                29
#>  2   2027 NA          2027-04-11                16                10
#>  3   2027 NA          2027-04-11                24                22
#>  4   2027 NA          2027-04-11                 7                25
#>  5   2027 NA          2027-04-11                 9                26
#>  6   2027 NA          2027-04-11                12                23
#>  7   2027 NA          2027-04-11                13                21
#>  8   2027 NA          2027-04-11                 2                15
#>  9   2027 NA          2027-04-11                17                28
#> 10   2027 NA          2027-04-11                 5                 1
#> # ℹ 1,197 more rows
#> # ℹ 11 more variables: espn_game_id <int>, nba_game_id <chr>,
#> #   nba_game_code <chr>, nba_home_team_id <int>, nba_away_team_id <int>,
#> #   fox_game_id <chr>, fox_home_team_id <chr>, fox_away_team_id <chr>,
#> #   yahoo_game_id <chr>, match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_nba_player_crosswalk(seasons = most_recent_nba_season())
#> ── NBA player crosswalk (ESPN / NBA Stats / Fox) ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 16:31:16 UTC
#> # A tibble: 490 × 21
#>    season espn_team_id team_abbreviation player_name         espn_athlete_id
#>     <int>        <int> <chr>             <chr>                         <int>
#>  1   2027            1 ATL               aaron wiggins               4397183
#>  2   2027            1 ATL               asa newell                  4873201
#>  3   2027            1 ATL               cj mccollum                 2490149
#>  4   2027            1 ATL               corey kispert               4280151
#>  5   2027            1 ATL               dorian finney smith         2578185
#>  6   2027            1 ATL               dyson daniels               4869342
#>  7   2027            1 ATL               jalen johnson               4701230
#>  8   2027            1 ATL               jalen wilson                4431714
#>  9   2027            1 ATL               jock landale                3146557
#> 10   2027            1 ATL               kingston flemings           5149077
#> # ℹ 480 more rows
#> # ℹ 16 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, nba_player_id <int>, nba_player_name <chr>,
#> #   nba_jersey_num <chr>, nba_position <chr>, fox_athlete_id <chr>,
#> #   fox_player <chr>, fox_jersey <chr>, fox_position_group <chr>,
#> #   yahoo_player_id <chr>, yahoo_player_name <chr>, match_method <chr>,
#> #   match_confidence <dbl>, match_keys <chr>
# }
# \donttest{
load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB team crosswalk (ESPN / Fox / Torvik / KenPom) ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-08 11:44:47 UTC
#> # A tibble: 365 × 27
#>    season espn_team_id espn_abbreviation espn_display_name       espn_short_name
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2027         2000 ACU               Abilene Christian Wild… Abilene Chrstn 
#>  2   2027         2005 AF                Air Force Falcons       Air Force      
#>  3   2027         2006 AKR               Akron Zips              Akron          
#>  4   2027         2010 AAMU              Alabama A&M Bulldogs    Alabama A&M    
#>  5   2027          333 ALA               Alabama Crimson Tide    Alabama        
#>  6   2027         2011 ALST              Alabama State Hornets   Alabama St     
#>  7   2027         2016 ALCN              Alcorn State Braves     Alcorn St      
#>  8   2027           44 AMER              American University Ea… American       
#>  9   2027         2026 APP               App State Mountaineers  App State      
#> 10   2027            9 ASU               Arizona State Sun Devi… Arizona St     
#> # ℹ 355 more rows
#> # ℹ 22 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   espn_conference <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   fox_section <chr>, bart_team <chr>, bart_conf <chr>, kp_team <chr>,
#> #   kp_conf <chr>, ncaa_team <chr>, espn_pbp_name <chr>,
#> #   warren_nolan_team <chr>, team_247 <chr>, sref_slug <chr>, sref_team <chr>,
#> #   yahoo_team_id <chr>, yahoo_team_name <chr>, fox_match_confidence <dbl>, …
# }
# \donttest{
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:04:19 UTC
#> # A tibble: 6,121 × 14
#>    season game_date  home_espn_team_id away_espn_team_id espn_game_id bart_muid 
#>     <int> <date>                 <int>             <int>        <int> <chr>     
#>  1   2027 2026-11-01               222                87    401920982 Notre Dam…
#>  2   2027 2026-11-01              2272              2335    401920409 NA        
#>  3   2027 2026-11-02                57              2390    401906769 FloridaMi…
#>  4   2027 2026-11-02               150               349    401909562 ArmyDuke1…
#>  5   2027 2026-11-02               356               161    401913525 Fairleigh…
#>  6   2027 2026-11-02                41              2241    401911390 Gardner W…
#>  7   2027 2026-11-02                26                12    401909738 ArizonaUC…
#>  8   2027 2026-11-02               127              2514    401924856 Quinnipia…
#>  9   2027 2026-11-02               251              2130    401906863 Chicago S…
#> 10   2027 2026-11-02               248              2325    401925811 La SalleH…
#> # ℹ 6,111 more rows
#> # ℹ 8 more variables: bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>,
#> #   kp_game_id <chr>, fox_game_id <chr>, yahoo_game_id <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB player crosswalk (ESPN / Fox) ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:16:43 UTC
#> # A tibble: 5,568 × 18
#>    season espn_team_id team_abbreviation player_name        espn_athlete_id
#>     <int>        <int> <chr>             <chr>                        <int>
#>  1   2027         2000 ACU               evan boisdur               5313910
#>  2   2027         2000 ACU               noah bolanga               5245765
#>  3   2027         2000 ACU               isaac dye                  5314820
#>  4   2027         2000 ACU               drew haffner               5461594
#>  5   2027         2000 ACU               cade hornecker             5107885
#>  6   2027         2000 ACU               xabi lopez                 5461597
#>  7   2027         2000 ACU               willan marie anais         5461596
#>  8   2027         2000 ACU               isaiah neyhart             5314819
#>  9   2027         2000 ACU               timeo pons                 5315586
#> 10   2027         2000 ACU               yaniel rivera              5177702
#> # ℹ 5,558 more rows
#> # ℹ 13 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, fox_athlete_id <chr>, fox_player <chr>,
#> #   fox_jersey <chr>, fox_position_group <chr>, yahoo_player_id <chr>,
#> #   yahoo_player_name <chr>, kp_player_id <chr>, match_method <chr>,
#> #   match_confidence <dbl>, match_keys <chr>
# }
```
