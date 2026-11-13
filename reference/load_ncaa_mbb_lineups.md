# **Load cleaned NCAA men's college basketball play-by-play from the data repo**

Loads season-level NCAA men's college basketball play-by-play. One row
per event, with reconstructed 5-man lineups, possession numbering, shot
context (transition/paint/second-chance), and an ESPN game-id crosswalk.
Produced by the sportsdataverse-py `ncaa_mbb` engine (stats.ncaa.org
play-by-play parsed, cleaned, and enriched); backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_pbp` release
tag as csv.gz/parquet/rds.

Loads shot-chart events for NCAA men's college basketball – one row per
field goal attempt, with court coordinates, distance, shot zone, and
made/missed result. Coordinates are only available from the 2019 season
onward (stats.ncaa.org did not publish shot-location data before then),
so `seasons` has a 2019 floor even though most sibling NCAA MBB datasets
start at 2010. Produced by the sportsdataverse-py `ncaa_mbb` engine;
backed by the `ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_shots` release tag as csv.gz/parquet/rds.

Loads reconstructed 5-man lineup stints for NCAA men's college
basketball – one row per contiguous stretch a specific 5-player lineup
was on court for a team, with on/off scoring, shooting, and rebounding
splits plus the matching opponent (`opp_*`) splits. Produced by the
sportsdataverse-py `ncaa_mbb` engine's lineup reconstructor; backed by
the `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_lineups`
release tag as csv.gz/parquet/rds.

Loads reconstructed 10-man matchup stints (the home 5-man lineup crossed
with the away 5-man lineup) for NCAA men's college basketball – one row
per contiguous stretch both lineups were on court together, with the
score at stint start/end and both team's lineup rosters. Produced by the
sportsdataverse-py `ncaa_mbb` engine's lineup reconstructor; backed by
the `ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_matchup_stints` release tag as csv.gz/parquet/rds.

Loads possession-level data for NCAA men's college basketball – one row
per offensive possession, with the on-court 5-man lineups for both
teams, points scored, assist/transition/garbage-time flags, and the
possession's first and last event types. Produced by the
sportsdataverse-py `ncaa_mbb` engine's possession detector; backed by
the `ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_possessions` release tag as csv.gz/parquet/rds.

Loads within-team regularized adjusted plus-minus (RAPM) ratings for
NCAA men's college basketball – one row per player-team-season, fit
against teammate lineup variation within that team's own possessions
(not a cross-team national RAPM). Produced by the sportsdataverse-py
`ncaa_mbb` engine's RAPM model on top of the reconstructed
lineup/possession data; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_rapm_within_team` release tag as
csv.gz/parquet/rds. The default season falls back to the newest
published one, with a message, until its file is published.

Loads league-wide regularized adjusted plus-minus (RAPM) ratings for
NCAA men's college basketball – one row per player-season, fit against
lineup variation across all Division I stints for that season (not a
within-team RAPM). Produced by the sportsdataverse-py `ncaa_mbb`
engine's league-wide stint-ridge RAPM solver (Torvik-gated to Division I
teams) on top of the reconstructed lineup/possession data; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_rapm` release
tag as csv.gz/parquet/rds.

Loads advanced per-player, per-game box scores for NCAA men's college
basketball – one row per player-game, with shooting splits by zone
(rim/mid/3), transition and half-court splits, assisted-vs-unassisted
splits, and shot-zone efficiency rates. A superset of the traditional
box score (points/rebounds/assists/steals/blocks/turnovers/fouls are
included alongside the advanced splits). Produced by the
sportsdataverse-py `ncaa_mbb` engine; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_player_box`
release tag as csv.gz/parquet/rds.

Loads advanced per-team, per-game box scores for NCAA men's college
basketball – one row per team-game, with offensive/defensive ratings,
shot-zone rates and efficiency (rim/mid/3), rebounding/assist/turnover
rates, and the matching opponent (`d_*`) splits. Produced by the
sportsdataverse-py `ncaa_mbb` engine; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_team_box`
release tag as csv.gz/parquet/rds.

Loads a lightweight season roster for NCAA men's college basketball –
one row per player-team-season with a games-played count. For the fuller
roster (jersey, class, position, height, hometown, high school), use
`load_ncaa_mbb_team_rosters()`. Produced by the sportsdataverse-py
`ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_rosters` release tag as csv.gz/parquet/rds.

Loads the full season roster for NCAA men's college basketball – one row
per player-team-season with jersey number, class year, position, height,
hometown, high school, and games played/started. Produced by the
sportsdataverse-py `ncaa_mbb` engine; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_team_rosters`
release tag as csv.gz/parquet/rds.

Loads season schedules/results for NCAA men's college basketball – one
row per game with home/away teams and final scores. Produced by the
sportsdataverse-py `ncaa_mbb` engine; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_schedule`
release tag as csv.gz/parquet/rds.

Loads the season-level stats.ncaa.org team-id / conference crosswalk for
NCAA men's college basketball – one row per team-season. Useful for
joining `ncaa_team_id` columns on the other `ncaa_mbb_*` datasets back
to a team name and conference. Produced by the sportsdataverse-py
`ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_team_ids` release tag as csv.gz/parquet/rds.

## Usage

``` r
load_ncaa_mbb_pbp(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_shots(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_lineups(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_matchup_stints(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_possessions(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_rapm_within_team(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_rapm(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_player_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_team_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_rosters(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_team_rosters(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_schedule(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_team_ids(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `ncaa_mbb_pbp` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_pbp>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_shots` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_shots>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_lineups` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_lineups>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_matchup_stints` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_matchup_stints>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_possessions` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_possessions>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_rapm_within_team` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_rapm_within_team>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_rapm` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_rapm>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_player_box` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_player_box>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_team_box` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_team_box>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_rosters` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_rosters>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_team_rosters` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_team_rosters>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_schedule` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_schedule>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

The `ncaa_mbb_team_ids` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/ncaa_mbb_team_ids>,
published by <https://github.com/sportsdataverse/ncaa-mbb-hoops-data>.

## Arguments

- seasons:

  A vector of 4-digit season-ending years for NCAA men's college
  basketball (e.g. `2024` for the 2023-24 season). Published coverage
  runs 2010 through the most recent season, with no gaps. Pass
  `seasons = TRUE` for every published season. (Min: 2010)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_pbp")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per shot attempt. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_shots")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per lineup stint. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_lineups")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per matchup stint. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_matchup_stints")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per possession. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_possessions")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per player-team-season. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_rapm_within_team")`) and
in the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per player-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_rapm")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per player-game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_player_box")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team-game. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_team_box")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per player-team-season. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_rosters")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per player-team-season. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_team_rosters")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "load_ncaa_mbb_team_ids")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

League-wide regularized adjusted plus-minus – a single ridge fit over
all Division I stints per season, distinct from
`load_ncaa_mbb_rapm_within_team()`'s within-team fit. Published coverage
runs seasons 2011 through 2026. The default season falls back to the
newest published one, with a message, until its file is published.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  # One season is a ~80 MB download.
  try(load_ncaa_mbb_pbp(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 361,352 × 87
#>    game_date  home       away     period clock game_time game_seconds home_score
#>    <chr>      <chr>      <chr>     <int> <chr> <chr>            <int>      <int>
#>  1 11/07/2026 Lindenwood East-We…      1 19:58 00:02                2          0
#>  2 11/07/2026 Lindenwood East-We…      1 19:58 00:02                2          0
#>  3 11/07/2026 Lindenwood East-We…      1 19:46 00:14               14          0
#>  4 11/07/2026 Lindenwood East-We…      1 19:46 00:14               14          0
#>  5 11/07/2026 Lindenwood East-We…      1 19:46 00:14               14          0
#>  6 11/07/2026 Lindenwood East-We…      1 19:46 00:14               14          0
#>  7 11/07/2026 Lindenwood East-We…      1 19:46 00:14               14          1
#>  8 11/07/2026 Lindenwood East-We…      1 19:31 00:29               29          1
#>  9 11/07/2026 Lindenwood East-We…      1 19:31 00:29               29          1
#> 10 11/07/2026 Lindenwood East-We…      1 19:31 00:29               29          1
#> # ℹ 361,342 more rows
#> # ℹ 79 more variables: away_score <int>, event_team <chr>,
#> #   event_description <chr>, player_1 <chr>, player_2 <chr>, event_type <chr>,
#> #   event_result <chr>, shot_value <int>, event_length <int>, poss_num <int>,
#> #   poss_team <chr>, poss_length <int>, is_transition <lgl>, home_1 <chr>,
#> #   home_2 <chr>, home_3 <chr>, home_4 <chr>, home_5 <chr>, away_1 <chr>,
#> #   away_2 <chr>, away_3 <chr>, away_4 <chr>, away_5 <chr>, status <chr>, …
# }
# \donttest{
  # One season is a ~10 MB download.
  try(load_ncaa_mbb_shots(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 83,679 × 19
#>    season team_id     shooter_id shot_x shot_y dist_ft shot_zone shot_type made 
#>     <int> <chr>       <chr>       <dbl>  <dbl>   <dbl> <chr>     <chr>     <lgl>
#>  1   2027 East-West … ChHammonds   -4   20.4     20.8  mid       unknown   TRUE 
#>  2   2027 Lindenwood  MaArchie      4    4.4      5.95 paint     unknown   TRUE 
#>  3   2027 Lindenwood  MaDiouf      -1    4.4      4.51 paint     unknown   FALSE
#>  4   2027 Lindenwood  MaDiouf      -2    2.52     3.22 rim       unknown   TRUE 
#>  5   2027 East-West … CaHarris      4.5  8.16     9.32 paint     unknown   FALSE
#>  6   2027 East-West … DaGriffin    12   23.2     26.1  abovebre… unknown   FALSE
#>  7   2027 Lindenwood  MaDiouf      -2.5  2.52     3.55 rim       unknown   TRUE 
#>  8   2027 East-West … ChHammonds  -19.5 17.6     26.2  abovebre… unknown   TRUE 
#>  9   2027 Lindenwood  MaDiouf       2.5  4.4      5.06 paint     unknown   TRUE 
#> 10   2027 East-West … ChHammonds   22.5 -0.300   22.5  corner3   unknown   FALSE
#> # ℹ 83,669 more rows
#> # ℹ 10 more variables: point_value <int>, period <int>, sec_left <dbl>,
#> #   source <chr>, contest_id <chr>, ncaa_team_id <chr>, espn_team_id <int>,
#> #   shooter_player_id <chr>, shooter_clean_name <chr>, espn_game_id <int>
# }
# \donttest{
  # One season is a ~20 MB download.
  try(load_ncaa_mbb_lineups(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 33,181 × 77
#>    lineup_key   date  location_type team  team_year opponent lineup_id start_min
#>    <chr>        <chr> <chr>         <chr>     <int> <chr>    <chr>         <dbl>
#>  1 c9c6073aef5… 2026… Home          Lind…      2026 East-We… DoClay_M…     0    
#>  2 c9c6073aef5… 2026… Home          Lind…      2026 East-We… DoClay_M…     0.483
#>  3 e68f84014cd… 2026… Home          Lind…      2026 East-We… DeRollin…     5.13 
#>  4 50063539c84… 2026… Home          Lind…      2026 East-We… DeRollin…     8.28 
#>  5 93beea462b2… 2026… Home          Lind…      2026 East-We… DoClay_M…     9.2  
#>  6 6397e30d24a… 2026… Home          Lind…      2026 East-We… DeRollin…    11.3  
#>  7 8f54cd25ef3… 2026… Home          Lind…      2026 East-We… DeRollin…    11.9  
#>  8 b1e6192a27c… 2026… Home          Lind…      2026 East-We… DeRollin…    14.4  
#>  9 56c1bbf0645… 2026… Home          Lind…      2026 East-We… DoClay_K…    14.9  
#> 10 e2b4c3cb2ef… 2026… Home          Lind…      2026 East-We… DoClay_M…    17.4  
#> # ℹ 33,171 more rows
#> # ℹ 69 more variables: end_min <dbl>, duration_mins <dbl>, player_1 <chr>,
#> #   player_2 <chr>, player_3 <chr>, player_4 <chr>, player_5 <chr>,
#> #   players_in <chr>, players_out <chr>, start_scored <int>,
#> #   start_allowed <int>, end_scored <int>, end_allowed <int>, start_diff <int>,
#> #   end_diff <int>, player_count_error <???>, poss <int>, pts <int>,
#> #   plus_minus <int>, fga <int>, fgm <int>, rima <int>, rimm <int>, …
# }
# \donttest{
  # One season is a ~12 MB download.
  try(load_ncaa_mbb_matchup_stints(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 24,549 × 33
#>    contest_id season game_date  home   away  game_stint_num period start_seconds
#>    <chr>       <int> <chr>      <chr>  <chr>          <int>  <int>         <int>
#>  1 6607173      2027 11/07/2026 Linde… East…              1      1             2
#>  2 6607173      2027 11/07/2026 Linde… East…              2      1            34
#>  3 6607173      2027 11/07/2026 Linde… East…              3      1           325
#>  4 6607173      2027 11/07/2026 Linde… East…              4      1           507
#>  5 6607173      2027 11/07/2026 Linde… East…              5      1           563
#>  6 6607173      2027 11/07/2026 Linde… East…              6      1           696
#>  7 6607173      2027 11/07/2026 Linde… East…              7      1           744
#>  8 6607173      2027 11/07/2026 Linde… East…              8      1           777
#>  9 6607173      2027 11/07/2026 Linde… East…              9      1           878
#> 10 6607173      2027 11/07/2026 Linde… East…             10      1           908
#> # ℹ 24,539 more rows
#> # ℹ 25 more variables: end_seconds <int>, duration_seconds <int>,
#> #   matchup_key <chr>, home_lineup_key <chr>, away_lineup_key <chr>,
#> #   home_lineup <chr>, away_lineup <chr>, end_home_score <int>,
#> #   end_away_score <int>, n_events <int>, n_possessions <int>,
#> #   start_home_score <int>, start_away_score <int>, home_pts <int>,
#> #   away_pts <int>, home_1 <chr>, home_2 <chr>, home_3 <chr>, home_4 <chr>, …
# }
# \donttest{
  # One season is a ~17 MB download.
  try(load_ncaa_mbb_possessions(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 100,798 × 56
#>    game_date  home   away  period poss_num poss_team home_1 home_2 home_3 home_4
#>    <chr>      <chr>  <chr>  <int>    <int> <chr>     <chr>  <chr>  <chr>  <chr> 
#>  1 11/07/2026 Linde… East…      1        1 Lindenwo… MAKHA… MALEK… MATAR… SHAMI…
#>  2 11/07/2026 Linde… East…      1        2 East-Wes… MAKHA… MALEK… MATAR… SHAMI…
#>  3 11/07/2026 Linde… East…      1        3 Lindenwo… DOM.C… MAKHA… MALEK… MATAR…
#>  4 11/07/2026 Linde… East…      1        4 East-Wes… DOM.C… MAKHA… MALEK… MATAR…
#>  5 11/07/2026 Linde… East…      1        5 Lindenwo… DOM.C… MAKHA… MALEK… MATAR…
#>  6 11/07/2026 Linde… East…      1        6 East-Wes… DOM.C… MAKHA… MALEK… MATAR…
#>  7 11/07/2026 Linde… East…      1        7 Lindenwo… DOM.C… MAKHA… MALEK… MATAR…
#>  8 11/07/2026 Linde… East…      1        8 East-Wes… DOM.C… MAKHA… MALEK… MATAR…
#>  9 11/07/2026 Linde… East…      1        9 Lindenwo… DOM.C… MAKHA… MALEK… MATAR…
#> 10 11/07/2026 Linde… East…      1       10 East-Wes… DOM.C… MAKHA… MALEK… MATAR…
#> # ℹ 100,788 more rows
#> # ℹ 46 more variables: home_5 <chr>, away_1 <chr>, away_2 <chr>, away_3 <chr>,
#> #   away_4 <chr>, away_5 <chr>, home_score <int>, away_score <int>, pts <int>,
#> #   is_assisted <int>, is_transition <int>, is_garbage_time <int>,
#> #   start_event_type <chr>, first_shot_time <int>, first_shot_type <chr>,
#> #   last_event_time <int>, last_event_type <chr>, contest_id <chr>,
#> #   home_ncaa_team_id <chr>, home_espn_team_id <int>, …
# }
# \donttest{
  try(load_ncaa_mbb_rapm_within_team(seasons = most_recent_mbb_season()))
#> Warning: Failed to read
#> <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_2027.rds>
#> after 1 attempt.
#> ! The result is incomplete: it is missing this file.
#> ✖ cannot open the connection to
#>   'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_2027.rds';
#>   cannot open URL
#>   'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_2027.rds':
#>   HTTP status was '404 Not Found'
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_rapm(seasons = most_recent_mbb_season()))
#> Warning: Failed to read
#> <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm/ncaa_mbb_rapm_2027.rds>
#> after 1 attempt.
#> ! The result is incomplete: it is missing this file.
#> ✖ cannot open the connection to
#>   'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm/ncaa_mbb_rapm_2027.rds';
#>   cannot open URL
#>   'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm/ncaa_mbb_rapm_2027.rds':
#>   HTTP status was '404 Not Found'
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  # One season is a ~10 MB download.
  try(load_ncaa_mbb_player_box(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 16,159 × 125
#>    game_date home  away  team  player  mins o_poss   pts   orb   drb   ast   stl
#>    <chr>     <chr> <chr> <chr> <chr>  <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 11/07/20… Lind… East… East… ALLEN…  6.5      12     2     0     0     1     2
#>  2 11/07/20… Lind… East… East… AMARE…  5.43     11     0     0     0     0     0
#>  3 11/07/20… Lind… East… East… ANDRE… 12.6      21     0     1     0     1     0
#>  4 11/07/20… Lind… East… East… CALEB… 25.0      45     6     0     0     3     0
#>  5 11/07/20… Lind… East… East… CAMER… 11.0      21     0     1     2     0     0
#>  6 11/07/20… Lind… East… East… CHRIS… 39.8      73    25     0     3     0     2
#>  7 11/07/20… Lind… East… East… DAYSH… 15.5      29     3     2     0     0     0
#>  8 11/07/20… Lind… East… East… DIANT…  8.48     16     0     0     0     0     0
#>  9 11/07/20… Lind… East… East… GEORG… 29.7      55     6     1     1     1     0
#> 10 11/07/20… Lind… East… East… GODWI…  9.87     18     0     0     2     0     0
#> # ℹ 16,149 more rows
#> # ℹ 113 more variables: blk <dbl>, tov <dbl>, pf <dbl>, ts_pct <dbl>,
#> #   efg_pct <dbl>, fgm <dbl>, fga <dbl>, fg_pct <dbl>, tpm <dbl>, tpa <dbl>,
#> #   tp_pct <dbl>, ftm <dbl>, fta <dbl>, ft_pct <dbl>, rimm <dbl>, rima <dbl>,
#> #   rim_pct <dbl>, midm <dbl>, mida <dbl>, mid_pct <dbl>, pbackm <dbl>,
#> #   pbacka <dbl>, pback_pct <dbl>, blk_rim <dbl>, blk_mid <dbl>,
#> #   blk_three <dbl>, pct_fga_trans <dbl>, pct_tpa_trans <dbl>, …
# }
# \donttest{
  try(load_ncaa_mbb_team_box(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 1,378 × 81
#>    home   away  team   mins o_mins d_mins o_poss d_poss  ortg  drtg netrtg   pts
#>    <chr>  <chr> <chr> <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl> <dbl>  <dbl> <dbl>
#>  1 Linde… East… East…  39.4   25.4   13.9     73     72  60.3 160.   -99.4    44
#>  2 Linde… East… Lind…  39.4   13.9   25.4     72     73 160.   60.3   99.4   115
#>  3 TCU    Lind… Lind…  39.6   21.0   18.7     75     77  78.7 127.   -48.6    59
#>  4 TCU    Lind… TCU    39.6   18.7   21.0     77     75 127.   78.7   48.6    98
#>  5 Nebra… Lind… Lind…  39.5   20.3   19.2     79     78  75.9 121.   -44.6    60
#>  6 Nebra… Lind… Nebr…  39.5   19.2   20.3     78     79 121.   75.9   44.6    94
#>  7 Linde… Cent… Cent…  39.2   24.5   14.8     77     77  59.7 156.   -96.1    46
#>  8 Linde… Cent… Lind…  39.2   14.8   24.5     77     77 156.   59.7   96.1   120
#>  9 Calif… Nort… Cali…  39.5   22.2   17.3     76     76  82.9  93.4  -10.5    63
#> 10 Calif… Nort… Nort…  39.5   17.3   22.2     76     76  93.4  82.9   10.5    71
#> # ℹ 1,368 more rows
#> # ℹ 69 more variables: d_pts <dbl>, fga <dbl>, d_fga <dbl>, fgm <dbl>,
#> #   d_fgm <dbl>, tpa <dbl>, d_tpa <dbl>, tpm <dbl>, d_tpm <dbl>, fta <dbl>,
#> #   d_fta <dbl>, ftm <dbl>, d_ftm <dbl>, rima <dbl>, d_rima <dbl>, rimm <dbl>,
#> #   d_rimm <dbl>, orb <dbl>, d_orb <dbl>, drb <dbl>, d_drb <dbl>, blk <dbl>,
#> #   d_blk <dbl>, to <dbl>, d_to <dbl>, ast <dbl>, d_ast <dbl>, e_poss <dbl>,
#> #   fg_pct <dbl>, d_fg_pct <dbl>, tpp <dbl>, d_tpp <dbl>, ftp <dbl>, …
# }
# \donttest{
  try(load_ncaa_mbb_rosters(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 7,201 × 4
#>    season team               player                  games
#>     <int> <chr>              <chr>                   <int>
#>  1   2027 A&M-Corpus Christi BEAU.BILLINGSLEY            3
#>  2   2027 A&M-Corpus Christi BINAEL.BASIL                3
#>  3   2027 A&M-Corpus Christi BRYSON.WHEATFALL            3
#>  4   2027 A&M-Corpus Christi CJ.WORSHAM                  3
#>  5   2027 A&M-Corpus Christi DAMARION.WINSTON            3
#>  6   2027 A&M-Corpus Christi DAN.MUKUNA                  3
#>  7   2027 A&M-Corpus Christi DANIEL.MICHELINIJACKSON     3
#>  8   2027 A&M-Corpus Christi DESMOND.KENT                3
#>  9   2027 A&M-Corpus Christi ISAIAH.LEWIS                3
#> 10   2027 A&M-Corpus Christi JACORI.JONES                1
#> # ℹ 7,191 more rows
# }
# \donttest{
  try(load_ncaa_mbb_team_rosters(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 5,587 × 16
#>    season team_id team   player_id player clean_name name  jersey class position
#>     <int> <chr>   <chr>  <chr>     <chr>  <chr>      <chr> <chr>  <chr> <chr>   
#>  1   2027 627267  A&M-C… 11590498  BEAU.… Beau Bill… Beau… 5      Fr.   G       
#>  2   2027 627267  A&M-C… 11590515  BINAE… Binael Ba… Bina… 22     Jr.   F       
#>  3   2027 627267  A&M-C… 11472830  BRYSO… Bryson Wh… Brys… 4      So.   G       
#>  4   2027 627267  A&M-C… 11590534  CJ.WO… CJ Worsham CJ W… 42     Jr.   F       
#>  5   2027 627267  A&M-C… 11478109  CEDRI… Cedric Ho… Cedr… 14     So.   G       
#>  6   2027 627267  A&M-C… 11590494  DAMAR… Damarion … Dama… 2      Jr.   G       
#>  7   2027 627267  A&M-C… 11590496  DAN.M… Dan Mukuna Dan … 3      Sr.   F       
#>  8   2027 627267  A&M-C… 11479265  DANIE… Daniel Mi… Dani… 10     Sr.   G       
#>  9   2027 627267  A&M-C… 11590536  DESMO… Desmond K… Desm… 12     Jr.   G       
#> 10   2027 627267  A&M-C… 11640102  ISAIA… Isaiah Le… Isai… 9      Sr.   G       
#> # ℹ 5,577 more rows
#> # ℹ 6 more variables: height <chr>, ht_inches <int>, hometown <chr>,
#> #   high_school <chr>, gp <chr>, gs <chr>
# }
# \donttest{
  try(load_ncaa_mbb_schedule(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 689 × 7
#>    contest_id game_date  home               away    home_score away_score season
#>    <chr>      <chr>      <chr>              <chr>        <int>      <int>  <int>
#>  1 6607173    11/07/2026 Lindenwood         East-W…        115         44   2027
#>  2 6607592    11/02/2026 TCU                Linden…         98         59   2027
#>  3 6607593    11/11/2026 Nebraska           Linden…         94         60   2027
#>  4 6607633    11/05/2026 Lindenwood         Centra…        120         46   2027
#>  5 6608198    11/03/2026 California Baptist North …         63         71   2027
#>  6 6608199    11/06/2026 Oregon St.         Califo…         96         68   2027
#>  7 6608200    11/11/2026 California Baptist Chicag…         62         81   2027
#>  8 6612138    11/02/2026 Georgetown         Loyola…         80         58   2027
#>  9 6612140    11/06/2026 Mount St. Mary's   Loyola…         68         57   2027
#> 10 6612147    11/12/2026 Towson             Loyola…         90         60   2027
#> # ℹ 679 more rows
# }
# \donttest{
  try(load_ncaa_mbb_team_ids(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 365 × 4
#>    team               conference id     season
#>    <chr>              <chr>      <chr>   <int>
#>  1 A&M-Corpus Christi Southland  627267   2027
#>  2 Abilene Christian  WAC        627272   2027
#>  3 Air Force          MWC        627332   2027
#>  4 Akron              MAC        627413   2027
#>  5 Alabama            SEC        627275   2027
#>  6 Alabama A&M        SWAC       627273   2027
#>  7 Alabama St.        SWAC       627274   2027
#>  8 Alcorn             SWAC       627277   2027
#>  9 American           Patriot    627278   2027
#> 10 App State          Sun Belt   627279   2027
#> # ℹ 355 more rows
# }
```
