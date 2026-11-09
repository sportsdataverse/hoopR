# **Load NBA player-impact ratings (RAPM / SPM / BPM / DARKO) from the data repo**

Loads season-level NBA player-impact ratings – one row per
player-team-season, combining regularized adjusted plus-minus (RAPM),
statistical plus-minus (SPM), box plus-minus (BPM), wins above
replacement (WAR), and a DARKO-style skill/projection pair. Produced by
the sportsdataverse-py NBA/WNBA possession-engine model program;
published to the `nba_player_impact` release tag as csv/parquet/rds.

Loads season-level NCAA men's college basketball player-value ratings –
one row per player-team-season, with a box-score-derived
offensive/defensive/net box plus-minus (BPM). Coverage starts at 2006
(the earliest season with published box-score inputs of sufficient
quality for the model); this tag is parquet-only, with no csv/rds
sibling assets. Produced by the sportsdataverse-py NCAA MBB model
program; published to the `mbb_player_value` release tag.

Loads season-level NCAA men's college basketball team ratings – one row
per team-season, with adjusted (opponent-strength-normalized)
offensive/defensive efficiency, adjusted tempo, raw efficiency, and a
national rank. A KenPom-style adjusted-efficiency-margin rating. This
tag is parquet-only, with no csv/rds sibling assets. Produced by the
sportsdataverse-py NCAA MBB model program; published to the
`mbb_ratings` release tag.

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

A `hoopR_data` tibble with one row per player-team-season.

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

A `hoopR_data` tibble with one row per player-team-season.

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

A `hoopR_data` tibble with one row per team-season.

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
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 458 × 28
#>    player_id player_name       team_id team_abbreviation team_name  teams season
#>        <int> <chr>               <int> <chr>             <chr>      <chr>  <int>
#>  1      2544 LeBron James   1610612755 PHI               Philadelp… PHI     2027
#>  2    201142 Kevin Durant   1610612745 HOU               Houston R… HOU     2027
#>  3    201143 Al Horford     1610612744 GSW               Golden St… GSW     2027
#>  4    201144 Mike Conley    1610612738 BOS               Boston Ce… BOS     2027
#>  5    201572 Brook Lopez    1610612746 LAC               LA Clippe… LAC     2027
#>  6    201599 DeAndre Jordan 1610612740 NOP               New Orlea… NOP     2027
#>  7    201935 James Harden   1610612739 CLE               Cleveland… CLE     2027
#>  8    201939 Stephen Curry  1610612744 GSW               Golden St… GSW     2027
#>  9    201942 DeMar DeRozan  1610612743 DEN               Denver Nu… DEN     2027
#> 10    201950 Jrue Holiday   1610612757 POR               Portland … POR     2027
#> # ℹ 448 more rows
#> # ℹ 21 more variables: season_type <chr>, o_rapm <dbl>, d_rapm <dbl>,
#> #   rapm <dbl>, off_poss <int>, def_poss <int>, o_adj_rapm <dbl>,
#> #   d_adj_rapm <dbl>, adj_rapm <dbl>, ospm <dbl>, dspm <dbl>, spm <dbl>,
#> #   min <dbl>, gp <int>, obpm <dbl>, dbpm <dbl>, bpm <dbl>, war <dbl>,
#> #   boban_filtered_skill <dbl>, boban_projected_rating <dbl>,
#> #   boban_projected_sd <dbl>
# }
# \donttest{
  try(load_mbb_player_value(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 6,266 × 9
#>    player_id player     season team_id   min box_obpm box_dbpm box_bpm qualified
#>    <chr>     <chr>       <int> <chr>   <dbl>    <dbl>    <dbl>   <dbl> <lgl>    
#>  1 5176150   Jake Davis   2027 356         6     28.0   -5.40     22.6 FALSE    
#>  2 5176222   Domas Kau…   2027 2344       15     19.0    3.07     22.0 FALSE    
#>  3 5247524   Mous Diop    2027 2079       11     22.1   -1.91     20.2 FALSE    
#>  4 5459995   Kellum Br…   2027 350         4     21.8   -2.04     19.8 FALSE    
#>  5 5242812   Jerquariu…   2027 68         20     25.4   -5.96     19.5 FALSE    
#>  6 5465507   Maddox Pa…   2027 294        13     13.6    5.36     18.9 FALSE    
#>  7 5196935   Amari Reed   2027 2617       22     22.5   -4.14     18.4 FALSE    
#>  8 5459646   Diggy Col…   2027 2032        4     20.0   -1.77     18.2 FALSE    
#>  9 5455079   Kedrick C…   2027 2529       45     18.6   -0.498    18.1 FALSE    
#> 10 4873219   Jacob Cof…   2027 30          9     12.3    5.55     17.8 FALSE    
#> # ℹ 6,256 more rows
# }
# \donttest{
  try(load_mbb_ratings(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 485 × 11
#>    season team_id adj_o adj_d adj_em adj_tempo raw_o raw_d games  rank adj_em_z
#>     <int> <chr>   <dbl> <dbl>  <dbl>     <dbl> <dbl> <dbl> <int> <int>    <dbl>
#>  1   2027 252      164.  75.3   88.9      68.9  147. 110.      2     1     2.41
#>  2   2027 356      145.  56.0   88.8      82.5  145.  70.6     2     2     2.40
#>  3   2027 150      141.  57.1   84.0      70.7  132.  68.9     2     3     2.28
#>  4   2027 2617     141.  62.6   78.5      73.9  141.  62.6     2     4     2.14
#>  5   2027 2181     141.  66.9   73.8      71.8  141.  66.9     1     5     2.02
#>  6   2027 167      131.  57.0   73.7      71.8  138.  89.4     2     6     2.02
#>  7   2027 328      135.  62.4   72.4      70.3  128.  79.6     2     7     1.98
#>  8   2027 2440     140.  70.7   69.4      65.2  130.  74.1     1     8     1.90
#>  9   2027 164      144.  74.7   69.1      66.1  125.  83.4     1     9     1.90
#> 10   2027 127      144.  76.5   67.9      73.8  130.  83.5     2    10     1.87
#> # ℹ 475 more rows
# }
```
