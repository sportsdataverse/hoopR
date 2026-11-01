# **Get ACB Team Box**

Team totals of a game per period: everything the team did, and the part
credited to the team itself.

Two rows per team and period: `scope` `total` is everything the team did
(its players plus the team's own events), `team` is the part credited to
the team itself rather than a player (team rebounds, team turnovers).
`quarter` 0 is the whole game.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_team_box(match_id)
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
are always these, in this order (sportsdataverse-py `acb_team_box`):

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
| quarter | integer | Period: 0 = the whole game, 1-4 the quarters, 5+ overtimes (games before about 2010 carry only 0). |
| scope | character | total = everything the team did (its players plus the team's own events); team = the part credited to the team itself rather than a player (team rebounds, team turnovers). |
| points | integer | Points, team total (players + team) |
| free_throws_made | integer | Free throws made, team total (players + team) |
| free_throws_attempted | integer | Free throws attempted, team total (players + team) |
| two_pointers_made | integer | Two-point field goals made, team total (players + team) |
| two_pointers_attempted | integer | Two-point field goals attempted, team total (players + team) |
| three_pointers_made | integer | Three-point field goals made, team total (players + team) |
| three_pointers_attempted | integer | Three-point field goals attempted, team total (players + team) |
| assists | integer | Assists, team total (players + team) |
| off_rebounds | integer | Offensive rebounds, team total (players + team) |
| def_rebounds | integer | Defensive rebounds, team total (players + team) |
| total_rebounds | integer | Total rebounds, team total (players + team) |
| steals | integer | Steals, team total (players + team) |
| turnovers | integer | Turnovers, team total (players + team) |
| blocks | integer | Shots blocked (by this player or team), team total (players + team) |
| received_blocks | integer | Own shots blocked by an opponent, team total (players + team) |
| dunks | integer | Dunks, team total (players + team) |
| personal_fouls | integer | Fouls committed, team total (players + team) |
| fouls_drawn | integer | Fouls received, team total (players + team) |
| plus_minus | integer | Point differential while on court (+/-), team total (players + team) |
| rating | integer | Valoracion: ACB's efficiency rating (PIR) = points + rebounds + assists + steals + blocks + fouls received - missed field goals - missed free throws - turnovers - shots blocked by an opponent - fouls committed, team total (players + team) |

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
[`acb_shots()`](https://hoopR.sportsdataverse.org/reference/acb_shots.md),
[`acb_standings()`](https://hoopR.sportsdataverse.org/reference/acb_standings.md),
[`acb_standings_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_standings_rounds.md),
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
  try(acb_team_box(match_id = 105401))
#> ── ACB Team Box from api2.acb.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:44:50 UTC
#> # A tibble: 20 × 30
#>    match_id edition_id season team_side team_id club_id team   team_abbr quarter
#>       <int>      <int>  <int> <chr>       <int>   <int> <chr>  <chr>       <int>
#>  1   105401         91   2027 home         4467       2 Barça  BAR             0
#>  2   105401         91   2027 home         4467       2 Barça  BAR             0
#>  3   105401         91   2027 home         4467       2 Barça  BAR             1
#>  4   105401         91   2027 home         4467       2 Barça  BAR             1
#>  5   105401         91   2027 home         4467       2 Barça  BAR             2
#>  6   105401         91   2027 home         4467       2 Barça  BAR             2
#>  7   105401         91   2027 home         4467       2 Barça  BAR             3
#>  8   105401         91   2027 home         4467       2 Barça  BAR             3
#>  9   105401         91   2027 home         4467       2 Barça  BAR             4
#> 10   105401         91   2027 home         4467       2 Barça  BAR             4
#> 11   105401         91   2027 away         4472      13 Valen… VBC             0
#> 12   105401         91   2027 away         4472      13 Valen… VBC             0
#> 13   105401         91   2027 away         4472      13 Valen… VBC             1
#> 14   105401         91   2027 away         4472      13 Valen… VBC             1
#> 15   105401         91   2027 away         4472      13 Valen… VBC             2
#> 16   105401         91   2027 away         4472      13 Valen… VBC             2
#> 17   105401         91   2027 away         4472      13 Valen… VBC             3
#> 18   105401         91   2027 away         4472      13 Valen… VBC             3
#> 19   105401         91   2027 away         4472      13 Valen… VBC             4
#> 20   105401         91   2027 away         4472      13 Valen… VBC             4
#> # ℹ 21 more variables: scope <chr>, points <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, two_pointers_made <int>,
#> #   two_pointers_attempted <int>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, assists <int>, off_rebounds <int>,
#> #   def_rebounds <int>, total_rebounds <int>, steals <int>, turnovers <int>,
#> #   blocks <int>, received_blocks <int>, dunks <int>, personal_fouls <int>,
#> #   fouls_drawn <int>, plus_minus <int>, rating <int>
# }
```
