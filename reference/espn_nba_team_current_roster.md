# **Get ESPN NBA current team roster**

**Get ESPN NBA current team roster**

## Usage

``` r
espn_nba_team_current_roster(team_id)
```

## Arguments

- team_id:

  Either numeric or character (YYYY)

## Value

A teams data frame

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(espn_nba_team_current_roster(team_id = 18))
#> ── ESPN NBA Team Current Roster Information from ESPN.com ─────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-16 14:12:26 UTC
#> # A tibble: 18 × 104
#>    team_id team_uid       team_slug    team_location team_name team_abbreviation
#>      <int> <chr>          <chr>        <chr>         <chr>     <chr>            
#>  1      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  2      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  3      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  4      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  5      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  6      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  7      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  8      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#>  9      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 10      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 11      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 12      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 13      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 14      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 15      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 16      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 17      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> 18      18 s:40~l:46~t:18 new-york-kn… New York      Knicks    NY               
#> # ℹ 98 more variables: team_display_name <chr>, team_short_name <chr>,
#> #   team_color <chr>, team_alternate_color <chr>, team_is_active <lgl>,
#> #   franchise..ref <chr>, franchise.id <chr>, franchise.uid <chr>,
#> #   franchise.slug <chr>, franchise.location <chr>, franchise.name <chr>,
#> #   franchise.abbreviation <chr>, franchise.displayName <chr>,
#> #   franchise.shortDisplayName <chr>, franchise.color <chr>,
#> #   franchise.isActive <lgl>, franchise.venue..ref <chr>, …
# }
```
