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
if (FALSE) { # interactive()
# \donttest{
  # One season is a ~80 MB download.
  try(load_ncaa_mbb_pbp(seasons = most_recent_mbb_season()))
# }
}
if (FALSE) { # interactive()
# \donttest{
  # One season is a ~10 MB download.
  try(load_ncaa_mbb_shots(seasons = most_recent_mbb_season()))
# }
}
if (FALSE) { # interactive()
# \donttest{
  # One season is a ~20 MB download.
  try(load_ncaa_mbb_lineups(seasons = most_recent_mbb_season()))
# }
}
if (FALSE) { # interactive()
# \donttest{
  # One season is a ~12 MB download.
  try(load_ncaa_mbb_matchup_stints(seasons = most_recent_mbb_season()))
# }
}
if (FALSE) { # interactive()
# \donttest{
  # One season is a ~17 MB download.
  try(load_ncaa_mbb_possessions(seasons = most_recent_mbb_season()))
# }
}
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
if (FALSE) { # interactive()
# \donttest{
  # One season is a ~10 MB download.
  try(load_ncaa_mbb_player_box(seasons = most_recent_mbb_season()))
# }
}
# \donttest{
  try(load_ncaa_mbb_team_box(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 736 × 81
#>    home   away  team   mins o_mins d_mins o_poss d_poss  ortg  drtg netrtg   pts
#>    <chr>  <chr> <chr> <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl> <dbl>  <dbl> <dbl>
#>  1 Linde… East… East…  39.4   25.4   13.9     73     72  60.3 160.   -99.4    44
#>  2 Linde… East… Lind…  39.4   13.9   25.4     72     73 160.   60.3   99.4   115
#>  3 TCU    Lind… Lind…  39.6   21.0   18.7     75     77  78.7 127.   -48.6    59
#>  4 TCU    Lind… TCU    39.6   18.7   21.0     77     75 127.   78.7   48.6    98
#>  5 Linde… Cent… Cent…  39.2   24.5   14.8     77     77  59.7 156.   -96.1    46
#>  6 Linde… Cent… Lind…  39.2   14.8   24.5     77     77 156.   59.7   96.1   120
#>  7 Calif… Nort… Cali…  39.5   22.2   17.3     76     76  82.9  93.4  -10.5    63
#>  8 Calif… Nort… Nort…  39.5   17.3   22.2     76     76  93.4  82.9   10.5    71
#>  9 Orego… Cali… Cali…  39.8   22.2   17.6     66     67 103.  143.   -40.3    68
#> 10 Orego… Cali… Oreg…  39.8   17.6   22.2     67     66 143.  103.    40.3    96
#> # ℹ 726 more rows
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
#> # A tibble: 5,825 × 4
#>    season team               player                  games
#>     <int> <chr>              <chr>                   <int>
#>  1   2027 A&M-Corpus Christi BEAU.BILLINGSLEY            2
#>  2   2027 A&M-Corpus Christi BINAEL.BASIL                2
#>  3   2027 A&M-Corpus Christi BRYSON.WHEATFALL            2
#>  4   2027 A&M-Corpus Christi CJ.WORSHAM                  2
#>  5   2027 A&M-Corpus Christi DAMARION.WINSTON            2
#>  6   2027 A&M-Corpus Christi DAN.MUKUNA                  2
#>  7   2027 A&M-Corpus Christi DANIEL.MICHELINIJACKSON     2
#>  8   2027 A&M-Corpus Christi DESMOND.KENT                2
#>  9   2027 A&M-Corpus Christi ISAIAH.LEWIS                2
#> 10   2027 A&M-Corpus Christi JORDAN.MIZELL               2
#> # ℹ 5,815 more rows
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
#> # A tibble: 368 × 7
#>    contest_id game_date  home               away    home_score away_score season
#>    <chr>      <chr>      <chr>              <chr>        <int>      <int>  <int>
#>  1 6607173    11/07/2026 Lindenwood         East-W…        115         44   2027
#>  2 6607592    11/02/2026 TCU                Linden…         98         59   2027
#>  3 6607633    11/05/2026 Lindenwood         Centra…        120         46   2027
#>  4 6608198    11/03/2026 California Baptist North …         63         71   2027
#>  5 6608199    11/06/2026 Oregon St.         Califo…         96         68   2027
#>  6 6612138    11/02/2026 Georgetown         Loyola…         80         58   2027
#>  7 6612140    11/06/2026 Mount St. Mary's   Loyola…         68         57   2027
#>  8 6613745    11/03/2026 Virginia Tech      Coppin…         88         54   2027
#>  9 6613746    11/06/2026 George Mason       Coppin…         68         51   2027
#> 10 6615603    11/08/2026 NJIT               Saint …         54         52   2027
#> # ℹ 358 more rows
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
