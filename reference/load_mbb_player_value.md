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
| boban_filtered_skill | numeric | BOBAN Kalman-filtered skill estimate at the end of the player's observed multi-season RAPM panel, i.e. his current-form rating after aging drift and possession-weighted observation noise. |
| boban_projected_rating | numeric | One-season-ahead BOBAN forecast, the filtered skill plus the empirical aging-curve drift at the player's last observed age; both season_type rows of a player-season carry the same value because the projection is not playoff-specific. |
| boban_projected_sd | numeric | Standard deviation of the one-season-ahead BOBAN forecast, the square root of the filtered state variance plus the Kalman process variance; it sits at roughly 10.19 for a player with only one season in the panel, whose diffuse prior variance was never updated. |
| o_rapm_n | integer | Possessions o_rapm is measured over: off_poss, his offensive possessions. o_rapm_rank and o_rapm_pct are set only when it reaches 1,700, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| d_rapm_n | integer | Possessions d_rapm is measured over: def_poss, his defensive possessions. d_rapm_rank and d_rapm_pct are set only when it reaches 1,600, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| rapm_n | integer | Possessions rapm is measured over: off_poss + def_poss, his possessions at both ends. rapm_rank and rapm_pct are set only when it reaches 3,200, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| o_adj_rapm_n | integer | Possessions o_adj_rapm is measured over: off_poss, his offensive possessions. o_adj_rapm_rank and o_adj_rapm_pct are set only when it reaches 1,700, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| d_adj_rapm_n | integer | Possessions d_adj_rapm is measured over: def_poss, his defensive possessions. d_adj_rapm_rank and d_adj_rapm_pct are set only when it reaches 1,600, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| adj_rapm_n | integer | Possessions adj_rapm is measured over: off_poss + def_poss, his possessions at both ends. adj_rapm_rank and adj_rapm_pct are set only when it reaches 3,200, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| ospm_n | integer | Possessions ospm is measured over: off_poss, his offensive possessions. ospm_rank and ospm_pct are set only when it reaches 1,700, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| dspm_n | integer | Possessions dspm is measured over: def_poss, his defensive possessions. dspm_rank and dspm_pct are set only when it reaches 1,600, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| spm_n | integer | Possessions spm is measured over: off_poss + def_poss, his possessions at both ends. spm_rank and spm_pct are set only when it reaches 3,200, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| obpm_n | integer | Possessions obpm is measured over: off_poss, his offensive possessions. obpm_rank and obpm_pct are set only when it reaches 1,700, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| dbpm_n | integer | Possessions dbpm is measured over: def_poss, his defensive possessions. dbpm_rank and dbpm_pct are set only when it reaches 1,600, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| bpm_n | integer | Possessions bpm is measured over: off_poss + def_poss, his possessions at both ends. bpm_rank and bpm_pct are set only when it reaches 3,200, the NBA sample at which a player's on-court rating of the same side is half signal; a regularized or box rating is less noisy, so the gate is conservative. |
| war_n | integer | Possessions behind war: off_poss + def_poss. war is a count, not a rate, so its rank has no sample gate. |
| boban_filtered_skill_n | integer | Possessions behind boban_filtered_skill: off_poss + def_poss, this season's possessions at both ends. The boban filtered skill is a multi-season Kalman estimate with no single-side sample, so it takes the net on-court gate, the closest existing one: boban_filtered_skill_rank and boban_filtered_skill_pct are set only when this reaches 3,200. Conservative, since the filter also carries earlier seasons. |
| boban_projected_rating_n | integer | Possessions behind boban_projected_rating: off_poss + def_poss, this season's possessions at both ends. The boban next-season projection is a multi-season Kalman estimate with no single-side sample, so it takes the net on-court gate, the closest existing one: boban_projected_rating_rank and boban_projected_rating_pct are set only when this reaches 3,200. Conservative, since the filter also carries earlier seasons. |
| boban_projected_sd_n | integer | Possessions behind boban_projected_sd: off_poss + def_poss, this season's possessions at both ends. The boban projection's standard deviation is a multi-season Kalman estimate with no single-side sample, so it takes the net on-court gate, the closest existing one: boban_projected_sd_rank and boban_projected_sd_pct are set only when this reaches 3,200. Conservative, since the filter also carries earlier seasons. |
| o_rapm_rank | numeric | Rank of o_rapm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when o_rapm_n is under 1,700, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| d_rapm_rank | numeric | Rank of d_rapm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when d_rapm_n is under 1,600, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| rapm_rank | numeric | Rank of rapm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when rapm_n is under 3,200, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| o_adj_rapm_rank | numeric | Rank of o_adj_rapm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when o_adj_rapm_n is under 1,700, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| d_adj_rapm_rank | numeric | Rank of d_adj_rapm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when d_adj_rapm_n is under 1,600, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| adj_rapm_rank | numeric | Rank of adj_rapm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when adj_rapm_n is under 3,200, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| ospm_rank | numeric | Rank of ospm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when ospm_n is under 1,700, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| dspm_rank | numeric | Rank of dspm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when dspm_n is under 1,600, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| spm_rank | numeric | Rank of spm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when spm_n is under 3,200, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| obpm_rank | numeric | Rank of obpm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when obpm_n is under 1,700, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| dbpm_rank | numeric | Rank of dbpm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when dbpm_n is under 1,600, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| bpm_rank | numeric | Rank of bpm among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when bpm_n is under 3,200, and NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. Regular-season gates: a playoff run rarely reaches one. |
| war_rank | numeric | Rank of war among the season and season type's ranked players, 1 = best (higher is better), ties averaged; ungated (every player with a finite war qualifies), NA when its season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value in the group is equal. |
| boban_filtered_skill_rank | numeric | Rank of boban_filtered_skill among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when boban_filtered_skill_n is under 3,200, when season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value is equal. |
| boban_projected_rating_rank | numeric | Rank of boban_projected_rating among the season and season type's ranked players, 1 = best (higher is better), ties averaged; NA when boban_projected_rating_n is under 3,200, when season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value is equal. |
| boban_projected_sd_rank | numeric | Rank of boban_projected_sd among the season and season type's ranked players, ASCENDING: 1 = the smallest sd, the most certain projection; ties averaged; NA when boban_projected_sd_n is under 3,200, when season or season_type is NA, in a group of fewer than 10 ranked players, or when every ranked value is equal. |
| o_rapm_pct | numeric | Percentile of o_rapm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| d_rapm_pct | numeric | Percentile of d_rapm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| rapm_pct | numeric | Percentile of rapm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| o_adj_rapm_pct | numeric | Percentile of o_adj_rapm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| d_adj_rapm_pct | numeric | Percentile of d_adj_rapm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| adj_rapm_pct | numeric | Percentile of adj_rapm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| ospm_pct | numeric | Percentile of ospm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| dspm_pct | numeric | Percentile of dspm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| spm_pct | numeric | Percentile of spm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| obpm_pct | numeric | Percentile of obpm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| dbpm_pct | numeric | Percentile of dbpm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| bpm_pct | numeric | Percentile of bpm_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| war_pct | numeric | Percentile of war_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| boban_filtered_skill_pct | numeric | Percentile of boban_filtered_skill_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| boban_projected_rating_pct | numeric | Percentile of boban_projected_rating_rank, 100 \* (n + 1 - rank) / (n + 1) over the n ranked players of the season and season type; NA where the rank is. |
| boban_projected_sd_pct | numeric | Percentile of boban_projected_sd_rank, 100 \* (n + 1 - rank) / (n + 1): high means a more certain projection (a smaller sd), not a larger one; NA where the rank is. |
| o_box_prior | numeric | The offensive prior the rating shrank toward (per 100). |
| d_box_prior | numeric | The defensive prior the rating shrank toward (per 100, positive = good defense). |
| box_prior | numeric | o_box_prior + d_box_prior. |
| o_reml_rapm | numeric | Offensive season impact per 100: the posterior mean of RAPM shrunk toward the prior. |
| d_reml_rapm | numeric | Defensive season impact per 100 (positive = good defense). |
| reml_rapm | numeric | o_reml_rapm + d_reml_rapm. |

A `hoopR_data` tibble with one row per player-team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_id | character | stats.ncaa.org player identifier. |
| player | character | Player display name (title-cased). |
| season | integer | Season identifier (4-digit season-ending year). |
| team_id | character | Unique team identifier. |
| min | numeric | Minutes played. |
| box_obpm | numeric | Box-score offensive box plus-minus. |
| box_dbpm | numeric | Box-score defensive box plus-minus. |
| box_bpm | numeric | Box-score net box plus-minus (box_obpm + box_dbpm). |
| qualified | logical | TRUE when the player logged at least 300 minutes for the team that season; filter on it before ranking or comparing box_bpm values. |

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
| adj_o_blend | numeric | adj_o blended with the team's prior-season rating over the first prior_games games. |
| adj_d_blend | numeric | adj_d blended with the team's prior-season rating over the first prior_games games. |
| adj_em_blend | numeric | adj_o_blend - adj_d_blend. |
| rank_blend | integer | Rank of adj_em_blend within the season (1 = best). |
| prior_games | numeric | Games' worth of weight the prior-season rating carries in the blend. |

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
#> # A tibble: 481 × 82
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
#> # ℹ 471 more rows
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
#> # A tibble: 8,563 × 9
#>    player_id player     season team_id   min box_obpm box_dbpm box_bpm qualified
#>    <chr>     <chr>       <int> <chr>   <dbl>    <dbl>    <dbl>   <dbl> <lgl>    
#>  1 5176150   Jake Davis   2027 356         6     28.0   -5.40     22.6 FALSE    
#>  2 5460912   Emarquis …   2027 256        14     19.2    1.92     21.2 FALSE    
#>  3 5459892   Joe Baldw…   2027 2908       12     22.6   -1.80     20.8 FALSE    
#>  4 5460041   Trey Will…   2027 172         9     17.9    2.79     20.7 FALSE    
#>  5 5351302   Ajak Nyuon   2027 9          22     27.7   -7.09     20.6 FALSE    
#>  6 5210396   Moustapha…   2027 2079       11     20.5   -0.871    19.7 FALSE    
#>  7 5144478   Jermel Th…   2027 139         6     18.7    0.724    19.4 FALSE    
#>  8 5313085   Timofei R…   2027 221         2     19.0   -0.164    18.8 FALSE    
#>  9 5458209   Deng Many…   2027 45         12     27.4   -8.72     18.7 FALSE    
#> 10 5461244   Michael M…   2027 349         9     21.2   -3.24     18.0 FALSE    
#> # ℹ 8,553 more rows
# }
# \donttest{
  try(load_mbb_ratings(seasons = most_recent_mbb_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 613 × 16
#>    season team_id adj_o adj_d adj_em adj_tempo raw_o raw_d games  rank adj_em_z
#>     <int> <chr>   <dbl> <dbl>  <dbl>     <dbl> <dbl> <dbl> <int> <int>    <dbl>
#>  1   2027 356      148.  89.5   58.4      77.3  141.  91.3     7     1     2.11
#>  2   2027 248      135.  80.3   55.0      70.0  129.  96.5     6     2     2.02
#>  3   2027 238      127.  79.6   47.2      71.2  126.  88.3     7     3     1.80
#>  4   2027 26       131.  84.0   47.1      70.1  131.  83.5     6     4     1.80
#>  5   2027 2250     137.  92.1   44.9      69.9  127.  99.4     5     5     1.73
#>  6   2027 2305     131.  87.2   43.8      74.9  122.  96.4     7     6     1.70
#>  7   2027 30       129.  86.1   43.1      72.3  125.  86.2     7     7     1.68
#>  8   2027 12       135.  92.4   42.4      72.3  123. 105.      8     8     1.66
#>  9   2027 328      134.  91.6   42.2      73.6  139.  92.5     6     9     1.66
#> 10   2027 142      133.  91.2   41.4      70.3  130.  89.5     7    10     1.64
#> # ℹ 603 more rows
#> # ℹ 5 more variables: adj_o_blend <dbl>, adj_d_blend <dbl>, adj_em_blend <dbl>,
#> #   rank_blend <int>, prior_games <dbl>
# }
```
