# **Load hoopR men's college basketball team box scores**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_mbb_team_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given men's college
  basketball seasons. (Min: 2003)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_mbb_db()`](https://hoopR.sportsdataverse.org/reference/update_mbb_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by

- tablename:

  The name of the play by play data table within the database

## Value

Returns a tibble

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | character | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| field_goals_made_field_goals_attempted | character | Field Goals Made-Attempted. |
| field_goal_pct | character | Field goal percentage (0-1). |
| three_point_field_goals_made_three_point_field_goals_attempted | character | 3-Point Field Goals Made-Attempted. |
| three_point_field_goal_pct | character | Three-point field goal percentage (0-1). |
| free_throws_made_free_throws_attempted | character | Free Throws Made-Attempted. |
| free_throw_pct | character | Free throw percentage (0-1). |
| total_rebounds | character | Total rebounds. |
| offensive_rebounds | character | Offensive rebounds. |
| defensive_rebounds | character | Defensive rebounds. |
| assists | character | Total assists. |
| steals | character | Total steals. |
| blocks | character | Total blocks. |
| turnovers | character | Total turnovers. |
| team_turnovers | character | Team turnovers (turnovers credited to the team rather than a player). |
| total_turnovers | character | Total turnovers (player + team). |
| technical_fouls | character | Total technical fouls. |
| total_technical_fouls | character | Total technical fouls (player + team). |
| flagrant_fouls | character | Total flagrant fouls. |
| fouls | character | Personal fouls. |
| largest_lead | character | Largest lead during the game. |
| home_away | character | Game venue label ('home' or 'away'). |
| opponent_id | integer | Unique identifier for opponent. |
| opponent_name | character | Opponent name. |
| opponent_mascot | character | Opponent mascot. |
| opponent_abbrev | character | Abbreviation for opponent. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_mbb_team_box(seasons = most_recent_mbb_season())
#> ── ESPN MBB Team Boxscores from hoopR data repository ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-24 02:45:03 UTC
#> # A tibble: 12,598 × 59
#>      game_id season season_type game_date  game_date_time      team_id team_uid 
#>        <int>  <int>       <int> <date>     <dttm>                <int> <chr>    
#>  1 401856600   2026           3 2026-04-06 2026-04-06 20:50:00      41 s:40~l:4…
#>  2 401856600   2026           3 2026-04-06 2026-04-06 20:50:00     130 s:40~l:4…
#>  3 401858363   2026           3 2026-04-05 2026-04-05 20:00:00     202 s:40~l:4…
#>  4 401858363   2026           3 2026-04-05 2026-04-05 20:00:00       2 s:40~l:4…
#>  5 401858385   2026           3 2026-04-05 2026-04-05 17:30:00     201 s:40~l:4…
#>  6 401858385   2026           3 2026-04-05 2026-04-05 17:30:00     277 s:40~l:4…
#>  7 401856599   2026           3 2026-04-04 2026-04-04 21:19:00     130 s:40~l:4…
#>  8 401856599   2026           3 2026-04-04 2026-04-04 21:19:00      12 s:40~l:4…
#>  9 401856598   2026           3 2026-04-04 2026-04-04 18:09:00     356 s:40~l:4…
#> 10 401856598   2026           3 2026-04-04 2026-04-04 18:09:00      41 s:40~l:4…
#> # ℹ 12,588 more rows
#> # ℹ 52 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>, …
# }
```
