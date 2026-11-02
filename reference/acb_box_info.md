# **Get ACB Box Info**

Coaches and game facts per team: head coach, assistants, arena,
attendance, referees.

One row per team. `arena`, `attendance` and `referees` (joined with
`'; '`) describe the game and repeat on both rows; `assistant_coaches`
is joined with `'; '`.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_box_info(match_id)
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
are always these, in this order (sportsdataverse-py `acb_box_info`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
| team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| head_coach | character | Head coach's name. |
| assistant_coaches | character | Assistant coaches' names joined with '; '. |
| arena | character | Arena where the game was played; repeats on both team rows. |
| attendance | integer | Announced attendance; repeats on both team rows. |
| referees | character | Referees' names joined with '; '; repeats on both team rows. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

Other ACB Functions:
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
  try(acb_box_info(match_id = 105401))
#> ── ACB Box Info from api2.acb.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:49:45 UTC
#> # A tibble: 2 × 13
#>   match_id edition_id season team_side team_id club_id team            team_abbr
#>      <int>      <int>  <int> <chr>       <int>   <int> <chr>           <chr>    
#> 1   105401         91   2027 home         4467       2 Barça           BAR      
#> 2   105401         91   2027 away         4472      13 Valencia Basket VBC      
#> # ℹ 5 more variables: head_coach <chr>, assistant_coaches <chr>, arena <chr>,
#> #   attendance <int>, referees <chr>
# }
```
