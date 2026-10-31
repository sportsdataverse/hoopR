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

  A vector of 4-digit seasons, or `TRUE` for every published season.
  Accepted seasons are the ones the release publishes: 2002 onward for
  the NBA crosswalks and `load_mbb_team_crosswalk()`, 2008 onward for
  `load_mbb_schedule_crosswalk()`, 2025 onward for
  `load_mbb_player_crosswalk()`; the upper bound is
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)
  /
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).
  ESPN ids (`espn_game_id`, `espn_athlete_id`, `espn_team_id`) are
  returned as integer, matching the ESPN box score, schedule and roster
  loaders.

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
#> ℹ Data updated: 2026-10-31 15:30:15 UTC
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
#> #   nba_team_id <chr>, nba_team_abbreviation <chr>, nba_team_name <chr>,
#> #   nba_team_city <chr>, nba_team_slug <chr>, nba_conference <chr>,
#> #   nba_division <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   yahoo_team_id <chr>, yahoo_team_abbreviation <chr>, yahoo_team_name <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
#> ── NBA schedule crosswalk (ESPN / NBA Stats) ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 15:30:38 UTC
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
#> #   nba_game_code <chr>, nba_home_team_id <chr>, nba_away_team_id <chr>,
#> #   fox_game_id <chr>, fox_home_team_id <chr>, fox_away_team_id <chr>,
#> #   yahoo_game_id <chr>, match_method <chr>, match_confidence <dbl>
# }
# \donttest{
load_nba_player_crosswalk(seasons = most_recent_nba_season())
#> ── NBA player crosswalk (ESPN / NBA Stats / Fox) ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 15:30:56 UTC
#> # A tibble: 460 × 21
#>    season espn_team_id team_abbreviation player_name         espn_athlete_id
#>     <int>        <int> <chr>             <chr>                         <int>
#>  1   2027            1 ATL               aaron wiggins               4397183
#>  2   2027            1 ATL               asa newell                  4873201
#>  3   2027            1 ATL               cj mccollum                 2490149
#>  4   2027            1 ATL               corey kispert               4280151
#>  5   2027            1 ATL               dorian finney smith         2578185
#>  6   2027            1 ATL               dyson daniels               4869342
#>  7   2027            1 ATL               jalen johnson               4701230
#>  8   2027            1 ATL               jock landale                3146557
#>  9   2027            1 ATL               kingston flemings           5149077
#> 10   2027            1 ATL               luguentz dort               4397020
#> # ℹ 450 more rows
#> # ℹ 16 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, nba_player_id <chr>, nba_player_name <chr>,
#> #   nba_jersey_num <chr>, nba_position <chr>, fox_athlete_id <chr>,
#> #   fox_player <chr>, fox_jersey <chr>, fox_position_group <chr>,
#> #   yahoo_player_id <chr>, yahoo_player_name <chr>, match_method <chr>,
#> #   match_confidence <dbl>, match_keys <chr>
# }
# \donttest{
load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_team_crosswalk_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_team_crosswalk_2027.rds>
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_schedule_crosswalk_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_schedule_crosswalk_2027.rds>
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_player_crosswalk_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/mbb_crosswalk/mbb_player_crosswalk_2027.rds>
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 0 × 0
# }
```
