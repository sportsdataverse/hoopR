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

## Source

The `nba_player_impact` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_player_impact>.

The `mbb_player_value` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_player_value>.

The `mbb_ratings` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_ratings>.

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

## See also

Other Model Dataset loader functions:
[`load_nba_current_impact()`](https://hoopR.sportsdataverse.org/reference/load_nba_current_impact.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_nba_player_impact(seasons = most_recent_nba_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 474 × 82
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
#> # ℹ 464 more rows
#> # ℹ 75 more variables: season_type <chr>, o_rapm <dbl>, d_rapm <dbl>,
#> #   rapm <dbl>, off_poss <int>, def_poss <int>, o_adj_rapm <dbl>,
#> #   d_adj_rapm <dbl>, adj_rapm <dbl>, ospm <dbl>, dspm <dbl>, spm <dbl>,
#> #   min <dbl>, gp <int>, obpm <dbl>, dbpm <dbl>, bpm <dbl>, war <dbl>,
#> #   boban_filtered_skill <dbl>, boban_projected_rating <dbl>,
#> #   boban_projected_sd <dbl>, o_rapm_n <int>, d_rapm_n <int>, rapm_n <int>, …
# }
# \donttest{
  try(load_mbb_player_value(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 8,126 × 9
#>    player_id player     season team_id   min box_obpm box_dbpm box_bpm qualified
#>    <chr>     <chr>       <int> <chr>   <dbl>    <dbl>    <dbl>   <dbl> <lgl>    
#>  1 5176150   Jake Davis   2027 356         6     28.0   -5.40     22.6 FALSE    
#>  2 5459892   Joe Baldw…   2027 2908       10     25.2   -3.93     21.3 FALSE    
#>  3 5460912   Emarquis …   2027 256        12     19.7    1.45     21.1 FALSE    
#>  4 5460041   Trey Will…   2027 172         9     17.9    2.79     20.7 FALSE    
#>  5 5210396   Moustapha…   2027 2079       11     20.2   -0.619    19.6 FALSE    
#>  6 5144478   Jermel Th…   2027 139         6     18.7    0.724    19.4 FALSE    
#>  7 5313085   Timofei R…   2027 221         2     19.0   -0.164    18.8 FALSE    
#>  8 5458209   Deng Many…   2027 45         12     27.4   -8.72     18.7 FALSE    
#>  9 5351302   Ajak Nyuon   2027 9          19     25.1   -7.05     18.1 FALSE    
#> 10 5461244   Michael M…   2027 349         9     21.2   -3.24     18.0 FALSE    
#> # ℹ 8,116 more rows
# }
# \donttest{
  try(load_mbb_ratings(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 569 × 16
#>    season team_id adj_o adj_d adj_em adj_tempo raw_o raw_d games  rank adj_em_z
#>     <int> <chr>   <dbl> <dbl>  <dbl>     <dbl> <dbl> <dbl> <int> <int>    <dbl>
#>  1   2027 356      145.  84.2   61.2      77.6  137.  85.3     5     1     2.10
#>  2   2027 248      137.  80.9   55.8      70.4  129.  96.5     6     2     1.95
#>  3   2027 142      138.  85.7   52.0      72.0  131.  94.0     4     3     1.84
#>  4   2027 238      132.  80.0   51.7      69.5  131.  78.0     4     4     1.83
#>  5   2027 2641     116.  65.1   50.6      68.0  116.  72.4     5     5     1.80
#>  6   2027 41       127.  76.9   50.0      69.6  126.  77.4     3     6     1.78
#>  7   2027 2305     129.  80.2   48.5      76.2  122.  92.4     5     7     1.74
#>  8   2027 30       134.  86.6   47.0      71.5  130.  84.6     6     8     1.70
#>  9   2027 26       128.  81.9   46.5      67.2  128.  81.8     5     9     1.68
#> 10   2027 269      124.  77.9   46.2      67.0  123.  85.1     5    10     1.68
#> # ℹ 559 more rows
#> # ℹ 5 more variables: adj_o_blend <dbl>, adj_d_blend <dbl>, adj_em_blend <dbl>,
#> #   rank_blend <int>, prior_games <dbl>
# }
```
