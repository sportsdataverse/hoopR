# **Load hoopR MBB shot events**

Loads shot events parsed from ESPN men's college basketball play-by-play
feeds. One row per shot attempt (made or missed), with court coordinates
and shot metadata. Backed by the `hoopR-mbb-data` pipeline, publishing
parquet/rds artifacts to the `espn_mens_college_basketball_shots`
release tag. Published coverage runs 2003 and 2006 through the most
recent season – 2004 and 2005 are a documented gap (no shot-coordinate
assets were published for those two seasons).

## Usage

``` r
load_mbb_shots(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. 2004 and
  2005 are not published. (Min: 2003)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_mbb_db()`](https://hoopR.sportsdataverse.org/reference/update_mbb_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html).

- tablename:

  The name of the shots data table within the database.

## Value

Returns a tibble with one row per shot attempt.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year). |
| period_number | integer | Numeric period (1-2 halves). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| team_id | integer | Unique team identifier. |
| athlete_id_1 | integer | Primary athlete identifier (the shooter). |
| athlete_id_2 | integer | Secondary athlete identifier (e.g. assister / fouler). |
| type_id | integer | Type identifier (numeric). |
| type_text | character | Display text for the shot/play type. |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the shot (2 / 3 / 1). |
| coordinate_x | numeric | X coordinate on the court (half-court layout). |
| coordinate_y | numeric | Y coordinate on the court (half-court layout). |
| coordinate_x_raw | numeric | X coordinate as returned by the API before any adjustment. |
| coordinate_y_raw | numeric | Y coordinate as returned by the API before any adjustment. |
| athlete_name_1 | character | Display name of the primary athlete (the shooter). |
| athlete_name_2 | character | Display name of the secondary athlete, when present. |
| team_name | character | Full team display name. |
| team_mascot | character | Team mascot / nickname. |
| team_abbrev | character | Short team abbreviation. |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_shots()`](https://hoopR.sportsdataverse.org/reference/load_nba_shots.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_mbb_shots(seasons = most_recent_mbb_season())
#> ── ESPN MBB shots from hoopR data repository ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-12 06:56:32 UTC
#> # A tibble: 991,836 × 20
#>      game_id season period_number clock_display_value team_id athlete_id_1
#>        <int>  <int>         <int> <chr>                 <int>        <int>
#>  1 401856600   2026             1 19:34                    41      5105809
#>  2 401856600   2026             1 19:18                   130      4873153
#>  3 401856600   2026             1 19:01                   130      5174983
#>  4 401856600   2026             1 18:45                    41      5196916
#>  5 401856600   2026             1 18:23                   130      4873153
#>  6 401856600   2026             1 17:57                    41      5105809
#>  7 401856600   2026             1 17:36                   130      4869764
#>  8 401856600   2026             1 17:16                    41      5105809
#>  9 401856600   2026             1 16:55                   130      4869764
#> 10 401856600   2026             1 16:55                   130      4869764
#> # ℹ 991,826 more rows
#> # ℹ 14 more variables: athlete_id_2 <int>, type_id <int>, type_text <chr>,
#> #   scoring_play <lgl>, score_value <int>, coordinate_x <dbl>,
#> #   coordinate_y <dbl>, coordinate_x_raw <dbl>, coordinate_y_raw <dbl>,
#> #   athlete_name_1 <chr>, athlete_name_2 <chr>, team_name <chr>,
#> #   team_mascot <chr>, team_abbrev <chr>
# }
```
