# **Load hoopR NBA Stats draft combine tables**

Five loaders for the five tables of the `nba_stats_draft_combine`
release, one file per table per season:
`load_nba_stats_draft_combine_stats()` (`draftcombinestats`, the
one-row-per-prospect summary of every measurement),
`load_nba_stats_draft_combine_anthro()` (`draftcombineplayeranthro`,
body measurements), `load_nba_stats_draft_combine_drills()`
(`draftcombinedrillresults`, vertical leaps, agility and sprint),
`load_nba_stats_draft_combine_spot_shooting()`
(`draftcombinespotshooting`, made/attempted from five floor spots at 15
feet, the college three and the NBA three) and
`load_nba_stats_draft_combine_nonstationary_shooting()`
(`draftcombinenonstationaryshooting`, off-the-dribble and on-the-move
shooting).

The combine is held in May before the draft, so the season's START year
is the combine year: `seasons = 2024` reads the 2024 combine (the
`..._2025` asset). Columns a year's combine did not measure are all
`NA`.

## Usage

``` r
load_nba_stats_draft_combine_stats(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_draft_combine_anthro(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_draft_combine_drills(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_draft_combine_spot_shooting(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_draft_combine_nonstationary_shooting(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_draft_combine` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_draft_combine>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year, i.e. the year
  of the combine. Published coverage starts at 2000. Pass
  `seasons = TRUE` for every published season.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per prospect
(`load_nba_stats_draft_combine_stats()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | END year of the season the draft class enters (2025 = the May 2024 combine for the 2024 draft) – one more than the `seasons` argument. |
| player_id | integer | stats.nba.com player identifier (PERSON_ID). |
| first_name | character | Participant's first name. |
| last_name | character | Participant's last name. |
| player_name | character | Participant's full name. |
| position | character | Position listed by the combine (e.g. 'PG', 'SF-PF'). |
| height_wo_shoes | numeric | Height without shoes, in inches. |
| height_wo_shoes_ft_in | character | Height without shoes as feet-and-inches text (e.g. "6' 5.75”"). |
| height_w_shoes | numeric | Height in shoes, in inches; NA in recent combines, which stopped measuring it. |
| height_w_shoes_ft_in | character | Height in shoes as feet-and-inches text; NA when not measured. |
| weight | character | Weight in pounds, as text (e.g. '227.80'). |
| wingspan | numeric | Wingspan, in inches. |
| wingspan_ft_in | character | Wingspan as feet-and-inches text. |
| standing_reach | numeric | Standing reach, in inches. |
| standing_reach_ft_in | character | Standing reach as feet-and-inches text. |
| body_fat_pct | numeric | Body-fat percentage; NA in combines that did not publish it. |
| hand_length | numeric | Hand length, in inches. |
| hand_width | numeric | Hand width (span), in inches. |
| standing_vertical_leap | numeric | No-step vertical leap, in inches. |
| max_vertical_leap | numeric | Running (max) vertical leap, in inches. |
| lane_agility_time | numeric | Lane agility drill time, in seconds. |
| modified_lane_agility_time | numeric | Modified (shuttle) lane agility drill time, in seconds. |
| three_quarter_sprint | numeric | Three-quarter-court sprint time, in seconds. |
| bench_press | integer | Repetitions of the 185 lb bench press; NA where not tested. |
| spot_fifteen_corner_left | character | Spot-up shooting from the left corner at 15-foot range, as 'made-attempted' text. |
| spot_fifteen_break_left | character | Spot-up shooting from the left break (wing) at 15-foot range, as 'made-attempted' text. |
| spot_fifteen_top_key | character | Spot-up shooting from the top of the key at 15-foot range, as 'made-attempted' text. |
| spot_fifteen_break_right | character | Spot-up shooting from the right break (wing) at 15-foot range, as 'made-attempted' text. |
| spot_fifteen_corner_right | character | Spot-up shooting from the right corner at 15-foot range, as 'made-attempted' text. |
| spot_college_corner_left | character | Spot-up shooting from the left corner at college three-point range, as 'made-attempted' text. |
| spot_college_break_left | character | Spot-up shooting from the left break (wing) at college three-point range, as 'made-attempted' text. |
| spot_college_top_key | character | Spot-up shooting from the top of the key at college three-point range, as 'made-attempted' text. |
| spot_college_break_right | character | Spot-up shooting from the right break (wing) at college three-point range, as 'made-attempted' text. |
| spot_college_corner_right | character | Spot-up shooting from the right corner at college three-point range, as 'made-attempted' text. |
| spot_nba_corner_left | character | Spot-up shooting from the left corner at NBA three-point range, as 'made-attempted' text. |
| spot_nba_break_left | character | Spot-up shooting from the left break (wing) at NBA three-point range, as 'made-attempted' text. |
| spot_nba_top_key | character | Spot-up shooting from the top of the key at NBA three-point range, as 'made-attempted' text. |
| spot_nba_break_right | character | Spot-up shooting from the right break (wing) at NBA three-point range, as 'made-attempted' text. |
| spot_nba_corner_right | character | Spot-up shooting from the right corner at NBA three-point range, as 'made-attempted' text. |
| off_drib_fifteen_break_left | character | Off-the-dribble shooting from the left break (wing) at 15-foot range, as 'made-attempted' text. |
| off_drib_fifteen_top_key | character | Off-the-dribble shooting from the top of the key at 15-foot range, as 'made-attempted' text. |
| off_drib_fifteen_break_right | character | Off-the-dribble shooting from the right break (wing) at 15-foot range, as 'made-attempted' text. |
| off_drib_college_break_left | character | Off-the-dribble shooting from the left break (wing) at college three-point range, as 'made-attempted' text. |
| off_drib_college_top_key | character | Off-the-dribble shooting from the top of the key at college three-point range, as 'made-attempted' text. |
| off_drib_college_break_right | character | Off-the-dribble shooting from the right break (wing) at college three-point range, as 'made-attempted' text. |
| on_move_fifteen | character | On-the-move shooting at 15-foot range, as 'made-attempted' text. |
| on_move_college | character | On-the-move shooting at college three-point range, as 'made-attempted' text. |

A `hoopR_data` tibble with one row per prospect
(`load_nba_stats_draft_combine_anthro()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| temp_player_id | integer | Combine participant id; equals `player_id` in every row checked. |
| player_id | integer | stats.nba.com player identifier (PERSON_ID). |
| first_name | character | Participant's first name. |
| last_name | character | Participant's last name. |
| player_name | character | Participant's full name. |
| position | character | Position listed by the combine (e.g. 'PG', 'SF-PF'). |
| height_wo_shoes | numeric | Height without shoes, in inches. |
| height_wo_shoes_ft_in | character | Height without shoes as feet-and-inches text (e.g. "6' 5.75”"). |
| height_w_shoes | numeric | Height in shoes, in inches; NA in recent combines, which stopped measuring it. |
| height_w_shoes_ft_in | character | Height in shoes as feet-and-inches text; NA when not measured. |
| weight | character | Weight in pounds, as text (e.g. '227.80'). |
| wingspan | numeric | Wingspan, in inches. |
| wingspan_ft_in | character | Wingspan as feet-and-inches text. |
| standing_reach | numeric | Standing reach, in inches. |
| standing_reach_ft_in | character | Standing reach as feet-and-inches text. |
| body_fat_pct | numeric | Body-fat percentage; NA in combines that did not publish it. |
| hand_length | numeric | Hand length, in inches. |
| hand_width | numeric | Hand width (span), in inches. |
| season | integer | END year of the season the draft class enters (2025 = the May 2024 combine for the 2024 draft) – one more than the `seasons` argument. |

A `hoopR_data` tibble with one row per prospect
(`load_nba_stats_draft_combine_drills()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| temp_player_id | integer | Combine participant id; equals `player_id` in every row checked. |
| player_id | integer | stats.nba.com player identifier (PERSON_ID). |
| first_name | character | Participant's first name. |
| last_name | character | Participant's last name. |
| player_name | character | Participant's full name. |
| position | character | Position listed by the combine (e.g. 'PG', 'SF-PF'). |
| standing_vertical_leap | numeric | No-step vertical leap, in inches. |
| max_vertical_leap | numeric | Running (max) vertical leap, in inches. |
| lane_agility_time | numeric | Lane agility drill time, in seconds. |
| modified_lane_agility_time | numeric | Modified (shuttle) lane agility drill time, in seconds. |
| three_quarter_sprint | numeric | Three-quarter-court sprint time, in seconds. |
| bench_press | integer | Repetitions of the 185 lb bench press; NA where not tested. |
| season | integer | END year of the season the draft class enters (2025 = the May 2024 combine for the 2024 draft) – one more than the `seasons` argument. |

A `hoopR_data` tibble with one row per prospect
(`load_nba_stats_draft_combine_spot_shooting()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| temp_player_id | integer | Combine participant id; equals `player_id` in every row checked. |
| player_id | integer | stats.nba.com player identifier (PERSON_ID). |
| first_name | character | Participant's first name. |
| last_name | character | Participant's last name. |
| player_name | character | Participant's full name. |
| position | character | Position listed by the combine (e.g. 'PG', 'SF-PF'). |
| fifteen_corner_left_made | integer | Shots made in the spot-up drill from the left corner at 15-foot range; NA if not run. |
| fifteen_corner_left_attempt | integer | Shots attempted in the spot-up drill from the left corner at 15-foot range; NA if not run. |
| fifteen_corner_left_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the left corner at 15-foot range; NA if not run. |
| fifteen_break_left_made | integer | Shots made in the spot-up drill from the left break (wing) at 15-foot range; NA if not run. |
| fifteen_break_left_attempt | integer | Shots attempted in the spot-up drill from the left break (wing) at 15-foot range; NA if not run. |
| fifteen_break_left_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the left break (wing) at 15-foot range; NA if not run. |
| fifteen_top_key_made | integer | Shots made in the spot-up drill from the top of the key at 15-foot range; NA if not run. |
| fifteen_top_key_attempt | integer | Shots attempted in the spot-up drill from the top of the key at 15-foot range; NA if not run. |
| fifteen_top_key_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the top of the key at 15-foot range; NA if not run. |
| fifteen_break_right_made | integer | Shots made in the spot-up drill from the right break (wing) at 15-foot range; NA if not run. |
| fifteen_break_right_attempt | integer | Shots attempted in the spot-up drill from the right break (wing) at 15-foot range; NA if not run. |
| fifteen_break_right_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the right break (wing) at 15-foot range; NA if not run. |
| fifteen_corner_right_made | integer | Shots made in the spot-up drill from the right corner at 15-foot range; NA if not run. |
| fifteen_corner_right_attempt | integer | Shots attempted in the spot-up drill from the right corner at 15-foot range; NA if not run. |
| fifteen_corner_right_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the right corner at 15-foot range; NA if not run. |
| college_corner_left_made | integer | Shots made in the spot-up drill from the left corner at college three-point range; NA if not run. |
| college_corner_left_attempt | integer | Shots attempted in the spot-up drill from the left corner at college three-point range; NA if not run. |
| college_corner_left_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the left corner at college three-point range; NA if not run. |
| college_break_left_made | integer | Shots made in the spot-up drill from the left break (wing) at college three-point range; NA if not run. |
| college_break_left_attempt | integer | Shots attempted in the spot-up drill from the left break (wing) at college three-point range; NA if not run. |
| college_break_left_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the left break (wing) at college three-point range; NA if not run. |
| college_top_key_made | integer | Shots made in the spot-up drill from the top of the key at college three-point range; NA if not run. |
| college_top_key_attempt | integer | Shots attempted in the spot-up drill from the top of the key at college three-point range; NA if not run. |
| college_top_key_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the top of the key at college three-point range; NA if not run. |
| college_break_right_made | integer | Shots made in the spot-up drill from the right break (wing) at college three-point range; NA if not run. |
| college_break_right_attempt | integer | Shots attempted in the spot-up drill from the right break (wing) at college three-point range; NA if not run. |
| college_break_right_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the right break (wing) at college three-point range; NA if not run. |
| college_corner_right_made | integer | Shots made in the spot-up drill from the right corner at college three-point range; NA if not run. |
| college_corner_right_attempt | integer | Shots attempted in the spot-up drill from the right corner at college three-point range; NA if not run. |
| college_corner_right_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the right corner at college three-point range; NA if not run. |
| nba_corner_left_made | integer | Shots made in the spot-up drill from the left corner at NBA three-point range; NA if not run. |
| nba_corner_left_attempt | integer | Shots attempted in the spot-up drill from the left corner at NBA three-point range; NA if not run. |
| nba_corner_left_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the left corner at NBA three-point range; NA if not run. |
| nba_break_left_made | integer | Shots made in the spot-up drill from the left break (wing) at NBA three-point range; NA if not run. |
| nba_break_left_attempt | integer | Shots attempted in the spot-up drill from the left break (wing) at NBA three-point range; NA if not run. |
| nba_break_left_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the left break (wing) at NBA three-point range; NA if not run. |
| nba_top_key_made | integer | Shots made in the spot-up drill from the top of the key at NBA three-point range; NA if not run. |
| nba_top_key_attempt | integer | Shots attempted in the spot-up drill from the top of the key at NBA three-point range; NA if not run. |
| nba_top_key_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the top of the key at NBA three-point range; NA if not run. |
| nba_break_right_made | integer | Shots made in the spot-up drill from the right break (wing) at NBA three-point range; NA if not run. |
| nba_break_right_attempt | integer | Shots attempted in the spot-up drill from the right break (wing) at NBA three-point range; NA if not run. |
| nba_break_right_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the right break (wing) at NBA three-point range; NA if not run. |
| nba_corner_right_made | integer | Shots made in the spot-up drill from the right corner at NBA three-point range; NA if not run. |
| nba_corner_right_attempt | integer | Shots attempted in the spot-up drill from the right corner at NBA three-point range; NA if not run. |
| nba_corner_right_pct | numeric | Shooting percentage (0-1) in the spot-up drill from the right corner at NBA three-point range; NA if not run. |
| season | integer | END year of the season the draft class enters (2025 = the May 2024 combine for the 2024 draft) – one more than the `seasons` argument. |

A `hoopR_data` tibble with one row per prospect
(`load_nba_stats_draft_combine_nonstationary_shooting()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| temp_player_id | integer | Combine participant id; equals `player_id` in every row checked. |
| player_id | integer | stats.nba.com player identifier (PERSON_ID). |
| first_name | character | Participant's first name. |
| last_name | character | Participant's last name. |
| player_name | character | Participant's full name. |
| position | character | Position listed by the combine (e.g. 'PG', 'SF-PF'). |
| off_drib_fifteen_break_left_made | integer | Shots made in the off-the-dribble drill from the left break (wing) at 15-foot range; NA if not run. |
| off_drib_fifteen_break_left_attempt | integer | Shots attempted in the off-the-dribble drill from the left break (wing) at 15-foot range; NA if not run. |
| off_drib_fifteen_break_left_pct | numeric | Shooting percentage (0-1) in the off-the-dribble drill from the left break (wing) at 15-foot range; NA if not run. |
| off_drib_fifteen_top_key_made | integer | Shots made in the off-the-dribble drill from the top of the key at 15-foot range; NA if not run. |
| off_drib_fifteen_top_key_attempt | integer | Shots attempted in the off-the-dribble drill from the top of the key at 15-foot range; NA if not run. |
| off_drib_fifteen_top_key_pct | numeric | Shooting percentage (0-1) in the off-the-dribble drill from the top of the key at 15-foot range; NA if not run. |
| off_drib_fifteen_break_right_made | integer | Shots made in the off-the-dribble drill from the right break (wing) at 15-foot range; NA if not run. |
| off_drib_fifteen_break_right_attempt | integer | Shots attempted in the off-the-dribble drill from the right break (wing) at 15-foot range; NA if not run. |
| off_drib_fifteen_break_right_pct | numeric | Shooting percentage (0-1) in the off-the-dribble drill from the right break (wing) at 15-foot range; NA if not run. |
| off_drib_college_break_left_made | integer | Shots made in the off-the-dribble drill from the left break (wing) at college three-point range; NA if not run. |
| off_drib_college_break_left_attempt | integer | Shots attempted in the off-the-dribble drill from the left break (wing) at college three-point range; NA if not run. |
| off_drib_college_break_left_pct | numeric | Shooting percentage (0-1) in the off-the-dribble drill from the left break (wing) at college three-point range; NA if not run. |
| off_drib_college_top_key_made | integer | Shots made in the off-the-dribble drill from the top of the key at college three-point range; NA if not run. |
| off_drib_college_top_key_attempt | integer | Shots attempted in the off-the-dribble drill from the top of the key at college three-point range; NA if not run. |
| off_drib_college_top_key_pct | numeric | Shooting percentage (0-1) in the off-the-dribble drill from the top of the key at college three-point range; NA if not run. |
| off_drib_college_break_right_made | integer | Shots made in the off-the-dribble drill from the right break (wing) at college three-point range; NA if not run. |
| off_drib_college_break_right_attempt | integer | Shots attempted in the off-the-dribble drill from the right break (wing) at college three-point range; NA if not run. |
| off_drib_college_break_right_pct | numeric | Shooting percentage (0-1) in the off-the-dribble drill from the right break (wing) at college three-point range; NA if not run. |
| on_move_fifteen_made | integer | Shots made in the on-the-move drill at 15-foot range; NA if not run. |
| on_move_fifteen_attempt | integer | Shots attempted in the on-the-move drill at 15-foot range; NA if not run. |
| on_move_fifteen_pct | numeric | Shooting percentage (0-1) in the on-the-move drill at 15-foot range; NA if not run. |
| on_move_college_made | integer | Shots made in the on-the-move drill at college three-point range; NA if not run. |
| on_move_college_attempt | integer | Shots attempted in the on-the-move drill at college three-point range; NA if not run. |
| on_move_college_pct | numeric | Shooting percentage (0-1) in the on-the-move drill at college three-point range; NA if not run. |
| season | integer | END year of the season the draft class enters (2025 = the May 2024 combine for the 2024 draft) – one more than the `seasons` argument. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>, the draft
results in
[`load_nba_stats_draft()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
and the Python twins
`sportsdataverse.nba.load_nba_stats_draft_combine_*()`.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md),
[`load_nba_stats_hustle`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_hustle.md),
[`load_nba_stats_injury_report()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_injury_report.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md),
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_draft_combine_stats(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 78 × 47
#>    season player_id first_name last_name player_name    position height_wo_shoes
#>     <int>     <int> <chr>      <chr>     <chr>          <chr>              <dbl>
#>  1   2027   1643587 Matthew    Able      Matthew Able   SG                  75.8
#>  2   2027   1643411 Darius     Acuff Jr. Darius Acuff … PG                  74  
#>  3   2027   1643533 Amari      Allen     Amari Allen    SF                  77.2
#>  4   2027   1643417 Nathaniel  Ament     Nathaniel Ame… PF                  81.5
#>  5   2027   1643515 Christian  Anderson  Christian And… PG                  73  
#>  6   2027   1643591 Tobe       Awaka     Tobe Awaka     C                   80  
#>  7   2027   1643540 Flory      Bidunga   Flory Bidunga  C                   79.8
#>  8   2027   1643548 Tyler      Bilodeau  Tyler Bilodeau PF                  79.2
#>  9   2027   1643612 John       Blackwell John Blackwell SG                  75.2
#> 10   2027   1643409 Cameron    Boozer    Cameron Boozer PF                  80.2
#> # ℹ 68 more rows
#> # ℹ 40 more variables: height_wo_shoes_ft_in <chr>, height_w_shoes <lgl>,
#> #   height_w_shoes_ft_in <lgl>, weight <chr>, wingspan <dbl>,
#> #   wingspan_ft_in <chr>, standing_reach <dbl>, standing_reach_ft_in <chr>,
#> #   body_fat_pct <lgl>, hand_length <dbl>, hand_width <dbl>,
#> #   standing_vertical_leap <dbl>, max_vertical_leap <dbl>,
#> #   lane_agility_time <dbl>, modified_lane_agility_time <dbl>, …
# }
```
