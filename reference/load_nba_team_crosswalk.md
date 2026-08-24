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

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. (Min:
  2002; default:
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md))

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
#> ── NBA team crosswalk (ESPN / NBA Stats / Fox) ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-07-14 11:58:51 UTC
#> # A tibble: 30 × 21
#>    season espn_team_id espn_abbreviation espn_display_name     espn_short_name
#>     <int>        <int> <chr>             <chr>                 <chr>          
#>  1   2026            1 ATL               Atlanta Hawks         Hawks          
#>  2   2026            2 BOS               Boston Celtics        Celtics        
#>  3   2026           17 BKN               Brooklyn Nets         Nets           
#>  4   2026           30 CHA               Charlotte Hornets     Hornets        
#>  5   2026            4 CHI               Chicago Bulls         Bulls          
#>  6   2026            5 CLE               Cleveland Cavaliers   Cavaliers      
#>  7   2026            6 DAL               Dallas Mavericks      Mavericks      
#>  8   2026            7 DEN               Denver Nuggets        Nuggets        
#>  9   2026            8 DET               Detroit Pistons       Pistons        
#> 10   2026            9 GS                Golden State Warriors Warriors       
#> # ℹ 20 more rows
#> # ℹ 16 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   nba_team_id <chr>, nba_team_abbreviation <chr>, nba_team_name <chr>,
#> #   nba_team_city <chr>, nba_team_slug <chr>, nba_conference <chr>,
#> #   nba_division <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   yahoo_team_id <chr>, yahoo_team_abbreviation <chr>, yahoo_team_name <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:51:46 UTC
#> # A tibble: 1,416 × 16
#>    season season_type game_date  home_espn_team_id away_espn_team_id
#>     <int> <chr>       <date>                 <int>             <int>
#>  1   2026 Pre-Season  2025-10-02                18                20
#>  2   2026 NA          2025-10-03                 3            111124
#>  3   2026 Pre-Season  2025-10-03                13                21
#>  4   2026 Pre-Season  2025-10-04                20                18
#>  5   2026 NA          2025-10-04                17            131570
#>  6   2026 Pre-Season  2025-10-04                14                19
#>  7   2026 Pre-Season  2025-10-04                 7                16
#>  8   2026 NA          2025-10-04                 3            126120
#>  9   2026 Pre-Season  2025-10-05                30                25
#> 10   2026 Pre-Season  2025-10-05                 9                13
#> # ℹ 1,406 more rows
#> # ℹ 11 more variables: espn_game_id <chr>, nba_game_id <chr>,
#> #   nba_game_code <chr>, nba_home_team_id <chr>, nba_away_team_id <chr>,
#> #   fox_game_id <chr>, fox_home_team_id <chr>, fox_away_team_id <chr>,
#> #   yahoo_game_id <chr>, match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_nba_player_crosswalk(seasons = most_recent_nba_season())
#> ── NBA player crosswalk (ESPN / NBA Stats / Fox) ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-07-14 11:59:23 UTC
#> # A tibble: 544 × 21
#>    season espn_team_id team_abbreviation player_name             espn_athlete_id
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2026            1 ATL               nickeil alexander walk… 4278039        
#>  2   2026            1 ATL               devin carter            4433188        
#>  3   2026            1 ATL               dyson daniels           4869342        
#>  4   2026            1 ATL               rayj dennis             4431941        
#>  5   2026            1 ATL               zuby ejiofor            5106262        
#>  6   2026            1 ATL               kingston flemings       5149077        
#>  7   2026            1 ATL               keshon gilbert          4585618        
#>  8   2026            1 ATL               mouhamed gueye          4712863        
#>  9   2026            1 ATL               buddy hield             2990984        
#> 10   2026            1 ATL               jalen johnson           4701230        
#> # ℹ 534 more rows
#> # ℹ 16 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, nba_player_id <chr>, nba_player_name <chr>,
#> #   nba_jersey_num <chr>, nba_position <chr>, fox_athlete_id <chr>,
#> #   fox_player <chr>, fox_jersey <chr>, fox_position_group <chr>,
#> #   yahoo_player_id <chr>, yahoo_player_name <chr>, match_method <chr>,
#> #   match_confidence <dbl>, match_keys <chr>
# }
# \donttest{
load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB team crosswalk (ESPN / Fox / Torvik / KenPom) ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-12 07:28:33 UTC
#> # A tibble: 362 × 21
#>    season espn_team_id espn_abbreviation espn_display_name       espn_short_name
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2026         2000 ACU               Abilene Christian Wild… Abilene Chrstn 
#>  2   2026         2005 AF                Air Force Falcons       Air Force      
#>  3   2026         2006 AKR               Akron Zips              Akron          
#>  4   2026         2010 AAMU              Alabama A&M Bulldogs    Alabama A&M    
#>  5   2026          333 ALA               Alabama Crimson Tide    Alabama        
#>  6   2026         2011 ALST              Alabama State Hornets   Alabama St     
#>  7   2026         2016 ALCN              Alcorn State Braves     Alcorn St      
#>  8   2026           44 AMER              American University Ea… American       
#>  9   2026         2026 APP               App State Mountaineers  App State      
#> 10   2026            9 ASU               Arizona State Sun Devi… Arizona St     
#> # ℹ 352 more rows
#> # ℹ 16 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   espn_conference <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   fox_section <chr>, bart_team <chr>, bart_conf <chr>, kp_team <chr>,
#> #   kp_conf <chr>, yahoo_team_id <chr>, yahoo_team_name <chr>,
#> #   fox_match_confidence <dbl>, bart_match_confidence <dbl>,
#> #   kp_match_confidence <dbl>, match_method <chr>
# }
# \donttest{
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:55:41 UTC
#> # A tibble: 6,386 × 14
#>    season game_date  home_espn_team_id away_espn_team_id espn_game_id bart_muid 
#>     <int> <date>                 <int>             <int> <chr>        <chr>     
#>  1   2026 2025-11-03               248              2329 401824809    LehighHou…
#>  2   2026 2025-11-03                12                57 401826885    ArizonaFl…
#>  3   2026 2025-11-03                41              2441 401812785    New Haven…
#>  4   2026 2025-11-03              2599              2514 401820577    Quinnipia…
#>  5   2026 2025-11-03               130              2473 401826083    OaklandMi…
#>  6   2026 2025-11-03               252               222 401819834    BYUVillan…
#>  7   2026 2025-11-03                97              2569 401817239    South Car…
#>  8   2026 2025-11-03                26               331 401813756    Eastern W…
#>  9   2026 2025-11-03                 8              2582 401826784    SouthernA…
#> 10   2026 2025-11-03               333               155 401812260    North Dak…
#> # ℹ 6,376 more rows
#> # ℹ 8 more variables: bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>,
#> #   kp_game_id <chr>, fox_game_id <chr>, yahoo_game_id <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB player crosswalk (ESPN / Fox) ──────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-12 07:30:32 UTC
#> # A tibble: 5,442 × 17
#>    season espn_team_id team_abbreviation player_name      espn_athlete_id
#>     <int>        <int> <chr>             <chr>            <chr>          
#>  1   2026         2000 ACU               christian alston 5241312        
#>  2   2026         2000 ACU               isaiah carrillo  5314819        
#>  3   2026         2000 ACU               isaac dye        5314820        
#>  4   2026         2000 ACU               mashy hill       5177705        
#>  5   2026         2000 ACU               cade hornecker   5107885        
#>  6   2026         2000 ACU               bradyn hubbard   5241314        
#>  7   2026         2000 ACU               tylan lewis      5314817        
#>  8   2026         2000 ACU               cbo newton       5177575        
#>  9   2026         2000 ACU               yaniel rivera    5177702        
#> 10   2026         2000 ACU               joseph scott     5314818        
#> # ℹ 5,432 more rows
#> # ℹ 12 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, fox_athlete_id <chr>, fox_player <chr>,
#> #   fox_jersey <chr>, fox_position_group <chr>, yahoo_player_id <chr>,
#> #   yahoo_player_name <chr>, match_method <chr>, match_confidence <dbl>,
#> #   match_keys <chr>
# }
```
