# **Get ACB Play-by-Play**

Play-by-play of a game (2016-17 onward): every shot, rebound, foul,
turnover, substitution and time-out.

One row per event. `play_type` is the API's event code and `play_name`
its bundle name (`acb_codes.PLAY_TYPES`; a code outside the table, such
as the minute marker 600, has no name); `turnover_type` decodes
`play_tag`. The clock counts DOWN: `minute` / `second` are the time left
in the period and `clock_seconds` the same in seconds. `order` is not
unique (the starting five share one); `play_index` is the 1-based
position in the feed. `is_home` is true for the home team's events (the
feed's `local`). `run_*` columns are the acting player's running box
score AFTER the event. Games before 2016-17 answer no events (the
wrapper raises `hoopR_no_data`).

Endpoint:
`GET https://api2.acb.com/api/matchdata/PlayByPlay/play-by-play`

## Usage

``` r
acb_pbp(match_id)
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
are always these, in this order (sportsdataverse-py `acb_pbp`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| play_index | integer | 1-based position of the event in the feed (the feed's order key is not unique). |
| order | integer | Event order key, ascending through the game (10, 301, 401, ...); not contiguous and not unique (the starting five share one). |
| quarter | integer | Period of the event: 1-4 quarters, 5+ overtimes. |
| minute | integer | Game clock left in the period, minutes part (10 at tip-off; overtimes are 5 minutes). |
| second | integer | Game clock left in the period, seconds part. |
| clock_seconds | integer | Game clock REMAINING in the period as whole seconds (minute x 60 + second; the clock counts down from 600, overtimes from 300). |
| play_type | integer | Event code (acb_codes.PLAY_TYPES decodes it; 599 = starting lineup, one row per starter at 10:00). |
| play_name | character | Bundle name of play_type (acb_codes.PLAY_TYPES, e.g. TWO_POINTER_MADE); null for a code outside the enum such as the minute marker 600. |
| play_tag | integer | Turnover detail code on turnovers (acb_codes.PLAY_TAGS); null otherwise. |
| turnover_type | character | Name of the turnover detail play_tag (acb_codes.PLAY_TAGS, e.g. BAD_PASS); null when there is no tag or the tag is unmapped. |
| is_home | logical | True when the event belongs to the home team (the API's local); false for the away team and for neutral events. |
| score_home | integer | Home score after the event. |
| score_away | integer | Away score after the event. |
| license_type | integer | Licence class of the player (202 on every player event); meaning unverified; null on team and clock events. |
| player_id | integer | ACB licence number of the player; null on team and clock events. |
| player_name | character | Player display name; null on team and clock events. |
| shirt_number | character | Shirt number as a string; null on starting-lineup rows and on team events. |
| run_points | integer | The acting player's running points AFTER this event (cumulative in the game). |
| run_free_throws_made | integer | The acting player's running free throws made AFTER this event (cumulative in the game). |
| run_free_throws_attempted | integer | The acting player's running free throws attempted AFTER this event (cumulative in the game). |
| run_two_pointers_made | integer | The acting player's running two pointers made AFTER this event (cumulative in the game). |
| run_two_pointers_attempted | integer | The acting player's running two pointers attempted AFTER this event (cumulative in the game). |
| run_three_pointers_made | integer | The acting player's running three pointers made AFTER this event (cumulative in the game). |
| run_three_pointers_attempted | integer | The acting player's running three pointers attempted AFTER this event (cumulative in the game). |
| run_assists | integer | The acting player's running assists AFTER this event (cumulative in the game). |
| run_off_rebounds | integer | The acting player's running off rebounds AFTER this event (cumulative in the game). |
| run_def_rebounds | integer | The acting player's running def rebounds AFTER this event (cumulative in the game). |
| run_total_rebounds | integer | The acting player's running total rebounds AFTER this event (cumulative in the game). |
| run_steals | integer | The acting player's running steals AFTER this event (cumulative in the game). |
| run_turnovers | integer | The acting player's running turnovers AFTER this event (cumulative in the game). |
| run_blocks | integer | The acting player's running blocks AFTER this event (cumulative in the game). |
| run_personal_fouls | integer | The acting player's running personal fouls AFTER this event (cumulative in the game). |
| run_fouls_drawn | integer | The acting player's running fouls drawn AFTER this event (cumulative in the game). |
| series_wins | integer | Home team's series wins, on the END_OF_GAME event of a 2016-17 playoff game only. |
| series_losses | integer | Home team's series losses, on the same event. |

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
[`acb_shots()`](https://hoopR.sportsdataverse.org/reference/acb_shots.md),
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
  try(acb_pbp(match_id = 105401))
#> ── ACB Play-by-Play from api2.acb.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:37:38 UTC
#> # A tibble: 735 × 38
#>    match_id edition_id season play_index order quarter minute second
#>       <int>      <int>  <int>      <int> <int>   <int>  <int>  <int>
#>  1   105401         91   2027          1    10       1     10      0
#>  2   105401         91   2027          2    10       1     10      0
#>  3   105401         91   2027          3    10       1     10      0
#>  4   105401         91   2027          4    10       1     10      0
#>  5   105401         91   2027          5    10       1     10      0
#>  6   105401         91   2027          6    10       1     10      0
#>  7   105401         91   2027          7    10       1     10      0
#>  8   105401         91   2027          8    10       1     10      0
#>  9   105401         91   2027          9    10       1     10      0
#> 10   105401         91   2027         10    10       1     10      0
#> # ℹ 725 more rows
#> # ℹ 30 more variables: clock_seconds <int>, play_type <int>, play_name <chr>,
#> #   play_tag <int>, turnover_type <chr>, is_home <lgl>, score_home <int>,
#> #   score_away <int>, license_type <int>, player_id <int>, player_name <chr>,
#> #   shirt_number <chr>, run_points <int>, run_free_throws_made <int>,
#> #   run_free_throws_attempted <int>, run_two_pointers_made <int>,
#> #   run_two_pointers_attempted <int>, run_three_pointers_made <int>, …
# }
```
