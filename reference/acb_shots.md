# **Get ACB Shots**

Every field-goal and free-throw attempt of a game (2016-17 onward) with
its court position.

One row per attempt. Two coordinate systems share `pos_x` / `pos_y`,
told apart by `coord_system`: `mm` (match ids from 2020-21) is
millimetres from the centre of the attacked basket, every shot mirrored
to one basket, `pos_x` towards midcourt and `pos_y` across the court
(negative = the shooter's left); `x_basket_m` / `y_basket_m` are those
in metres. `grid` (up to 2019-20) is a 0-100 percent grid over the full
court, NOT mirrored (teams switch ends at half time), and has no
basket-relative metres (null). Free throws are (0, 0) with a null
`zone`; legacy zones are unreliable. The inference of units and origin
is the refs' (arc and sideline fit), not documented by ACB.
`player_name` comes from the game's shooter list.

Endpoint:
`GET https://api2.acb.com/api/matchdata/MatchShots/match-shots`

## Usage

``` r
acb_shots(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| shot_id | integer | Event id of the attempt within one match; joins nothing outside this body. |
| pos_x | integer | Court x as sent. mm system: millimetres from the attacked basket towards midcourt (never negative; 0 for free throws and dunks); grid system: 0-100 percent of the court length, not mirrored. |
| pos_y | integer | Court y as sent. mm system: millimetres across the court (sidelines at -7500 and +7500, negative = the shooter's left); grid system: 0-100 percent of the width (which sideline is 0 is unverified). Free throws are (0, 0). |
| coord_system | character | Shot coordinate system, told by the match id: mm = millimetres from the attacked basket (match ids from 2020-21), grid = 0-100 percent of the full court (up to 2019-20). Null when the match id is unknown. |
| x_basket_m | double | Shot x in metres from the centre of the attacked basket towards midcourt, when coord_system is mm and the attempt is a field goal; null otherwise. Units and origin are inferred by the refs (arc and sideline fit), not documented by ACB. |
| y_basket_m | double | Shot y in metres across the court from the basket line, negative = the shooter's left, when coord_system is mm and the attempt is a field goal; null otherwise (inferred by the refs, not documented by ACB). |
| quarter | integer | Period of the attempt: 1-4 quarters, 5+ overtimes. |
| minute | integer | Game clock left in the period, minutes |
| second | integer | Game clock left in the period, seconds part |
| clock_seconds | integer | Game clock REMAINING in the period as whole seconds (minute x 60 + second; the clock counts down from 600, overtimes from 300). |
| play_type | integer | Event code (92 free throw made, 93 two made, 94 three made, 96 free throw missed, 97 two missed, 98 three missed, 100 dunk, 533 dunk missed). |
| play_name | character | Bundle name of play_type (acb_codes.PLAY_TYPES, e.g. TWO_POINTER_MADE); null for a code outside the enum such as the minute marker 600. |
| is_home | logical | True when the shooter's team is the home team (the API's local). |
| score_home | integer | Home score after the attempt. |
| score_away | integer | Away score after the attempt. |
| player_id | integer | ACB licence number of the shooter. |
| player_name | character | Shooter's short name from the game's shooter list (e.g. 'T. Martin'). |
| shirt_number | character | Shooter's shirt number as a string, from the game's shooter list. |
| zone | character | Shot zone (acb_codes.SHOT_ZONES: restricted_area, paint, mid_range\_*, corner_three\_*, wing_three\_\*, top_three); null on free throws; legacy zones (up to 2019-20) are unreliable. |
| made | logical | True when the shot went in; null on some free throws. |
| points | integer | Points the attempt scored (2 or 3 on made field goals); null on free throws and misses. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

Other ACB Functions:
[`acb_box_info()`](https://hoopR.sportsdataverse.org/reference/acb_box_info.md),
[`acb_bracket()`](https://hoopR.sportsdataverse.org/reference/acb_bracket.md),
[`acb_bracket_games()`](https://hoopR.sportsdataverse.org/reference/acb_bracket_games.md),
[`acb_calendar()`](https://hoopR.sportsdataverse.org/reference/acb_calendar.md),
[`acb_career_stints()`](https://hoopR.sportsdataverse.org/reference/acb_career_stints.md),
[`acb_career_trophies()`](https://hoopR.sportsdataverse.org/reference/acb_career_trophies.md),
[`acb_club_data()`](https://hoopR.sportsdataverse.org/reference/acb_club_data.md),
[`acb_competition_current()`](https://hoopR.sportsdataverse.org/reference/acb_competition_current.md),
[`acb_competition_editions()`](https://hoopR.sportsdataverse.org/reference/acb_competition_editions.md),
[`acb_competition_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_competition_rounds.md),
[`acb_competition_weeks()`](https://hoopR.sportsdataverse.org/reference/acb_competition_weeks.md),
[`acb_current_roster()`](https://hoopR.sportsdataverse.org/reference/acb_current_roster.md),
[`acb_lead_stats()`](https://hoopR.sportsdataverse.org/reference/acb_lead_stats.md),
[`acb_lead_tracker()`](https://hoopR.sportsdataverse.org/reference/acb_lead_tracker.md),
[`acb_league_zones()`](https://hoopR.sportsdataverse.org/reference/acb_league_zones.md),
[`acb_lineup()`](https://hoopR.sportsdataverse.org/reference/acb_lineup.md),
[`acb_match_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_match_advanced_stats.md),
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md),
[`acb_match_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_match_leaders.md),
[`acb_matchlist()`](https://hoopR.sportsdataverse.org/reference/acb_matchlist.md),
[`acb_next_matches()`](https://hoopR.sportsdataverse.org/reference/acb_next_matches.md),
[`acb_pbp()`](https://hoopR.sportsdataverse.org/reference/acb_pbp.md),
[`acb_period_scores()`](https://hoopR.sportsdataverse.org/reference/acb_period_scores.md),
[`acb_player_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_advanced_stats.md),
[`acb_player_box()`](https://hoopR.sportsdataverse.org/reference/acb_player_box.md),
[`acb_player_data()`](https://hoopR.sportsdataverse.org/reference/acb_player_data.md),
[`acb_player_matches()`](https://hoopR.sportsdataverse.org/reference/acb_player_matches.md),
[`acb_player_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_stats.md),
[`acb_player_totals()`](https://hoopR.sportsdataverse.org/reference/acb_player_totals.md),
[`acb_quickfacts()`](https://hoopR.sportsdataverse.org/reference/acb_quickfacts.md),
[`acb_round_matches()`](https://hoopR.sportsdataverse.org/reference/acb_round_matches.md),
[`acb_search()`](https://hoopR.sportsdataverse.org/reference/acb_search.md),
[`acb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_season_leaders.md),
[`acb_serie()`](https://hoopR.sportsdataverse.org/reference/acb_serie.md),
[`acb_standings()`](https://hoopR.sportsdataverse.org/reference/acb_standings.md),
[`acb_standings_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_standings_rounds.md),
[`acb_team_box()`](https://hoopR.sportsdataverse.org/reference/acb_team_box.md),
[`acb_team_comparison()`](https://hoopR.sportsdataverse.org/reference/acb_team_comparison.md),
[`acb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_team_leaders.md),
[`acb_team_matches()`](https://hoopR.sportsdataverse.org/reference/acb_team_matches.md),
[`acb_team_records()`](https://hoopR.sportsdataverse.org/reference/acb_team_records.md),
[`acb_team_stats()`](https://hoopR.sportsdataverse.org/reference/acb_team_stats.md),
[`acb_team_totals()`](https://hoopR.sportsdataverse.org/reference/acb_team_totals.md),
[`acb_teams()`](https://hoopR.sportsdataverse.org/reference/acb_teams.md)

## Examples

``` r
# \donttest{
  try(acb_shots(match_id = 105401))
#> ── ACB Shots from api2.acb.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:26:41 UTC
#> # A tibble: 188 × 24
#>    match_id edition_id season shot_id pos_x pos_y coord_system x_basket_m
#>       <int>      <int>  <int>   <int> <int> <int> <chr>             <dbl>
#>  1   105401         91   2027     901  1426  -673 mm                1.43 
#>  2   105401         91   2027    1001   484   698 mm                0.484
#>  3   105401         91   2027    1701  1452  -806 mm                1.45 
#>  4   105401         91   2027    1801  3308   -27 mm                3.31 
#>  5   105401         91   2027    1901  1183   565 mm                1.18 
#>  6   105401         91   2027    2001   538  -592 mm                0.538
#>  7   105401         91   2027    2101  1291   915 mm                1.29 
#>  8   105401         91   2027    2201  2125  -646 mm                2.12 
#>  9   105401         91   2027    2701  4815   -53 mm                4.82 
#> 10   105401         91   2027    2901  8150 -4302 mm                8.15 
#> # ℹ 178 more rows
#> # ℹ 16 more variables: y_basket_m <dbl>, quarter <int>, minute <int>,
#> #   second <int>, clock_seconds <int>, play_type <int>, play_name <chr>,
#> #   is_home <lgl>, score_home <int>, score_away <int>, player_id <int>,
#> #   player_name <chr>, shirt_number <chr>, zone <chr>, made <lgl>, points <int>
# }
```
