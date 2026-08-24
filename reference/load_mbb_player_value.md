# **Load NBA player-impact ratings (RAPM / SPM / BPM / DARKO) from the data repo**

Loads season-level NBA player-impact ratings – one row per
player-team-season, combining regularized adjusted plus-minus (RAPM),
statistical plus-minus (SPM), box plus-minus (BPM), wins above
replacement (WAR), and a DARKO-style skill/projection pair. Produced by
the sdv-py NBA/WNBA possession-engine model program; published to the
`nba_player_impact` release tag as csv/parquet/rds.

Loads season-level NCAA men's college basketball player-value ratings –
one row per player-team-season, with a box-score-derived
offensive/defensive/net box plus-minus (BPM). Coverage starts at 2006
(the earliest season with published box-score inputs of sufficient
quality for the model); this tag is parquet-only, with no csv/rds
sibling assets. Produced by the sdv-py NCAA MBB model program; published
to the `mbb_player_value` release tag.

Loads season-level NCAA men's college basketball team ratings – one row
per team-season, with adjusted (opponent-strength-normalized)
offensive/defensive efficiency, adjusted tempo, raw efficiency, and a
national rank. A KenPom-style adjusted-efficiency-margin rating. This
tag is parquet-only, with no csv/rds sibling assets. Produced by the
sdv-py NCAA MBB model program; published to the `mbb_ratings` release
tag.

## Usage

``` r
load_nba_player_impact(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_player_value(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_ratings(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit season-ending years for NCAA men's college
  basketball. Published coverage runs 2006 through the most recent
  season, with no gaps. Pass `seasons = TRUE` for every published
  season. (Min: 2006)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

Returns a `hoopR_data` tibble with one row per player-team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_id | integer | Unique NBA Stats player identifier. |
| player_name | character | Player display name. |
| team_id | integer | Unique team identifier. |
| team_abbreviation | character | Team abbreviation. |
| team_name | character | Full team display name. |
| teams | character | Team abbreviation(s) the player appeared for this season. |
| season | integer | Season identifier (4-digit year). |
| season_type | character | Season portion (e.g. 'Regular Season'). |
| o_rapm | numeric | Offensive regularized adjusted plus-minus. |
| d_rapm | numeric | Defensive regularized adjusted plus-minus. |
| rapm | numeric | Net regularized adjusted plus-minus (o_rapm + d_rapm). |
| off_poss | integer | Offensive possessions used in the RAPM fit. |
| def_poss | integer | Defensive possessions used in the RAPM fit. |
| o_adj_rapm | numeric | Offensive RAPM adjusted for minutes/possession stability. |
| d_adj_rapm | numeric | Defensive RAPM adjusted for minutes/possession stability. |
| adj_rapm | numeric | Net adjusted RAPM (o_adj_rapm + d_adj_rapm). |
| ospm | numeric | Offensive statistical plus-minus (box-score component). |
| dspm | numeric | Defensive statistical plus-minus (box-score component). |
| spm | numeric | Net statistical plus-minus. |
| min | numeric | Minutes played. |
| gp | integer | Games played. |
| obpm | numeric | Offensive box plus-minus. |
| dbpm | numeric | Defensive box plus-minus. |
| bpm | numeric | Net box plus-minus. |
| war | numeric | Wins above replacement. |
| darko_filtered_skill | numeric | DARKO-style filtered skill rating. |
| darko_projected_rating | numeric | DARKO-style forward-looking projected rating. |
| darko_projected_sd | numeric | Standard deviation of the DARKO-style projected rating. |

Returns a `hoopR_data` tibble with one row per player-team-season.

|           |           |                                                     |
|-----------|-----------|-----------------------------------------------------|
| col_name  | types     | description                                         |
| player_id | character | stats.ncaa.org player identifier.                   |
| player    | character | Player display name (title-cased).                  |
| season    | integer   | Season identifier (4-digit season-ending year).     |
| team_id   | character | Unique team identifier.                             |
| min       | numeric   | Minutes played.                                     |
| box_obpm  | numeric   | Box-score offensive box plus-minus.                 |
| box_dbpm  | numeric   | Box-score defensive box plus-minus.                 |
| box_bpm   | numeric   | Box-score net box plus-minus (box_obpm + box_dbpm). |

Returns a `hoopR_data` tibble with one row per team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit season-ending year). |
| team_id | character | Unique team identifier. |
| adj_o | numeric | Adjusted offensive efficiency (points per 100 possessions, opponent-adjusted). |
| adj_d | numeric | Adjusted defensive efficiency (points allowed per 100 possessions, opponent-adjusted). |
| adj_em | numeric | Adjusted efficiency margin (adj_o minus adj_d). |
| adj_tempo | numeric | Adjusted possessions per 40 minutes. |
| raw_o | numeric | Unadjusted (raw) offensive efficiency. |
| raw_d | numeric | Unadjusted (raw) defensive efficiency. |
| games | integer | Games played (season total). |
| rank | integer | National rank by adj_em. |
| adj_em_z | numeric | Z-score of adj_em relative to the season's team distribution. |

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_nba_player_impact(seasons = most_recent_nba_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 812 × 28
#>    player_id player_name        team_id team_abbreviation team_name teams season
#>        <int> <chr>                <int> <chr>             <chr>     <chr>  <int>
#>  1      2544 LeBron James        1.61e9 LAL               Los Ange… LAL     2026
#>  2    101108 Chris Paul          1.61e9 LAC               LA Clipp… LAC     2026
#>  3    200768 Kyle Lowry          1.61e9 PHI               Philadel… PHI     2026
#>  4    201142 Kevin Durant        1.61e9 HOU               Houston … HOU     2026
#>  5    201143 Al Horford          1.61e9 GSW               Golden S… GSW     2026
#>  6    201144 Mike Conley         1.61e9 MIN               Minnesot… MIN     2026
#>  7    201145 Jeff Green          1.61e9 HOU               Houston … HOU     2026
#>  8    201566 Russell Westbrook   1.61e9 SAC               Sacramen… SAC     2026
#>  9    201567 Kevin Love          1.61e9 UTA               Utah Jazz UTA     2026
#> 10    201569 Eric Gordon         1.61e9 PHI               Philadel… PHI     2026
#> # ℹ 802 more rows
#> # ℹ 21 more variables: season_type <chr>, o_rapm <dbl>, d_rapm <dbl>,
#> #   rapm <dbl>, off_poss <int>, def_poss <int>, o_adj_rapm <dbl>,
#> #   d_adj_rapm <dbl>, adj_rapm <dbl>, ospm <dbl>, dspm <dbl>, spm <dbl>,
#> #   min <dbl>, gp <int>, obpm <dbl>, dbpm <dbl>, bpm <dbl>, war <dbl>,
#> #   darko_filtered_skill <dbl>, darko_projected_rating <dbl>,
#> #   darko_projected_sd <dbl>
# }
# \donttest{
  try(load_mbb_player_value(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 9,990 × 8
#>    player_id player              season team_id   min box_obpm box_dbpm box_bpm
#>    <chr>     <chr>                <int> <chr>   <dbl>    <dbl>    <dbl>   <dbl>
#>  1 5312013   Evan Smith            2026 153         8     26.7    -5.55    21.1
#>  2 5317517   Kyler Penco           2026 2823        5     27.3    -6.88    20.5
#>  3 5173645   Jason Jakstys         2026 356        47     15.9     4.27    20.1
#>  4 5317261   Jacob Szep            2026 2018        3     23.4    -3.70    19.7
#>  5 5312970   Christian Dedivanaj   2026 189        12     16.1     3.06    19.2
#>  6 5319245   Ryder Block           2026 2913        7     20.1    -1.02    19.1
#>  7 5257670   Jawan Browder         2026 2207       10     13.7     4.57    18.2
#>  8 5184076   Ryan Kenney           2026 2591        2     22.6    -4.46    18.2
#>  9 5325921   Gavin Olson           2026 2600        2     20.0    -2.36    17.6
#> 10 5258977   Karrington Wallace    2026 420         9     21.7    -4.21    17.5
#> # ℹ 9,980 more rows
# }
# \donttest{
  try(load_mbb_ratings(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 727 × 11
#>    season team_id adj_o adj_d adj_em adj_tempo raw_o raw_d games  rank adj_em_z
#>     <int> <chr>   <dbl> <dbl>  <dbl>     <dbl> <dbl> <dbl> <int> <int>    <dbl>
#>  1   2026 130      133.  85.5   47.4      71.7  123.  98.5    40     1     2.15
#>  2   2026 150      132.  86.5   45.4      66.3  123.  96.3    38     2     2.09
#>  3   2026 12       130.  86.8   43.4      70.8  121.  97.9    39     3     2.03
#>  4   2026 356      134.  93.7   40.8      67.0  126. 104.     37     4     1.96
#>  5   2026 57       130.  89.2   40.4      70.6  122. 101.     35     5     1.95
#>  6   2026 248      127.  87.1   40.2      63.9  119.  96.9    37     6     1.94
#>  7   2026 66       128.  89.1   39.0      67.9  120.  97.1    37     7     1.91
#>  8   2026 2509     135.  96.9   37.8      65.3  126. 109.     39     8     1.87
#>  9   2026 41       126.  90.0   35.8      65.5  117.  99.5    40     9     1.81
#> 10   2026 2250     125.  89.1   35.6      69.7  121.  95.1    35    10     1.81
#> # ℹ 717 more rows
# }
```
