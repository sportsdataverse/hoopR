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
#> # A tibble: 463 × 82
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
#> # ℹ 453 more rows
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
#> # A tibble: 7,063 × 9
#>    player_id player     season team_id   min box_obpm box_dbpm box_bpm qualified
#>    <chr>     <chr>       <int> <chr>   <dbl>    <dbl>    <dbl>   <dbl> <lgl>    
#>  1 5176150   Jake Davis   2027 356         6     28.0   -5.40     22.6 FALSE    
#>  2 5459892   Joe Baldw…   2027 2908        9     26.1   -4.97     21.1 FALSE    
#>  3 5460041   Trey Will…   2027 172         8     18.2    2.51     20.7 FALSE    
#>  4 5247524   Mous Diop    2027 2079       11     22.1   -1.91     20.2 FALSE    
#>  5 5351302   Ajak Nyuon   2027 9           9     24.4   -4.86     19.6 FALSE    
#>  6 5144478   Jermel Th…   2027 139         6     18.7    0.724    19.4 FALSE    
#>  7 5459995   Kellum Br…   2027 350         5     19.7   -0.678    19.0 FALSE    
#>  8 5196935   Amari Reed   2027 2617       22     22.5   -4.14     18.4 FALSE    
#>  9 5462473   Stefan Hi…   2027 2710        7     18.3   -0.286    18.0 FALSE    
#> 10 5242812   Jerquariu…   2027 68         41     24.6   -6.87     17.7 FALSE    
#> # ℹ 7,053 more rows
# }
# \donttest{
  try(load_mbb_ratings(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 527 × 11
#>    season team_id adj_o adj_d adj_em adj_tempo raw_o raw_d games  rank adj_em_z
#>     <int> <chr>   <dbl> <dbl>  <dbl>     <dbl> <dbl> <dbl> <int> <int>    <dbl>
#>  1   2027 127      138.  72.0   66.2      73.2  123.  89.5     3     1     2.03
#>  2   2027 245      140.  76.1   64.0      71.9  126.  81.6     3     2     1.97
#>  3   2027 139      151.  87.7   63.8      73.9  135.  95.2     3     3     1.97
#>  4   2027 238      125.  62.2   62.4      73.0  132.  86.4     3     4     1.93
#>  5   2027 142      135.  72.6   62.2      71.0  142.  95.1     3     5     1.93
#>  6   2027 344      142.  81.8   60.4      64.8  135.  87.9     3     6     1.88
#>  7   2027 251      139.  80.4   58.9      73.7  141.  80.5     3     7     1.84
#>  8   2027 150      137.  78.3   58.6      71.5  122.  82.6     3     8     1.83
#>  9   2027 145      132.  73.9   58.1      72.1  131.  78.2     3     9     1.82
#> 10   2027 97       137.  78.6   57.9      71.7  137.  90.6     2    10     1.81
#> # ℹ 517 more rows
# }
```
