# **Get ACB Team Stats**

A club's player season statistics for an edition: totals, averages and
per-40 side by side.

One row per player. `total_*` are season counts (`Int64`;
`total_time_played` is seconds, `*_percentage` are Float64), `avg_*`
per-game averages and `per40_*` per-40-minute rates (Float64).
`num_games` is games played and `starter` games started.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-stats`

## Usage

``` r
acb_team_stats(club_id, competition_id = NULL, season = NULL)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_team_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| club_id | integer | Stable club id of the club asked for (2 = Barca). |
| team_id | integer | Season-team entry id of the selected edition. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |
| total_num_games | integer | Season total of games played. |
| total_time_played | integer | Season total of time on court in seconds. |
| total_starter | integer | Season total of games started. |
| total_points | integer | Season total of points. |
| total_max_points | integer | Season total of most points in a single game. |
| total_three_pointers_made | integer | Season total of three-point field goals made. |
| total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
| total_three_pointers_percentage | double | Season total of three-point percentage (0-100). |
| total_two_pointers_made | integer | Season total of two-point field goals made. |
| total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
| total_two_pointers_percentage | double | Season total of two-point percentage (0-100). |
| total_free_throws_made | integer | Season total of free throws made. |
| total_free_throws_attempted | integer | Season total of free throws attempted. |
| total_free_throws_percentage | double | Season total of free-throw percentage (0-100). |
| total_rebounds | integer | Season total of total rebounds. |
| total_offensive_rebounds | integer | Season total of offensive rebounds. |
| total_defensive_rebounds | integer | Season total of defensive rebounds. |
| total_assists | integer | Season total of assists. |
| total_steals | integer | Season total of steals. |
| total_turnovers | integer | Season total of turnovers. |
| total_blocks | integer | Season total of blocks made. |
| total_shots_rejected | integer | Season total of own shots blocked. |
| total_dunks | integer | Season total of dunks. |
| total_personal_fouls | integer | Season total of personal fouls committed. |
| total_fouls_received | integer | Season total of fouls drawn. |
| total_rating | integer | Season total of ACB rating (valoracion). |
| total_plus_minus | integer | Season total of plus/minus. |
| total_wins | integer | Season total of team wins in the counted games (meaning unverified). |
| total_losses | integer | Season total of team losses in the counted games (meaning unverified). |
| avg_num_games | double | Per-game average of games played. |
| avg_time_played | double | Per-game average of time on court in seconds. |
| avg_starter | double | Per-game average of games started. |
| avg_points | double | Per-game average of points. |
| avg_max_points | double | Per-game average of most points in a single game. |
| avg_three_pointers_made | double | Per-game average of three-point field goals made. |
| avg_three_pointers_attempted | double | Per-game average of three-point field goals attempted. |
| avg_three_pointers_percentage | double | Per-game average of three-point percentage (0-100). |
| avg_two_pointers_made | double | Per-game average of two-point field goals made. |
| avg_two_pointers_attempted | double | Per-game average of two-point field goals attempted. |
| avg_two_pointers_percentage | double | Per-game average of two-point percentage (0-100). |
| avg_free_throws_made | double | Per-game average of free throws made. |
| avg_free_throws_attempted | double | Per-game average of free throws attempted. |
| avg_free_throws_percentage | double | Per-game average of free-throw percentage (0-100). |
| avg_rebounds | double | Per-game average of total rebounds. |
| avg_offensive_rebounds | double | Per-game average of offensive rebounds. |
| avg_defensive_rebounds | double | Per-game average of defensive rebounds. |
| avg_assists | double | Per-game average of assists. |
| avg_steals | double | Per-game average of steals. |
| avg_turnovers | double | Per-game average of turnovers. |
| avg_blocks | double | Per-game average of blocks made. |
| avg_shots_rejected | double | Per-game average of own shots blocked. |
| avg_dunks | double | Per-game average of dunks. |
| avg_personal_fouls | double | Per-game average of personal fouls committed. |
| avg_fouls_received | double | Per-game average of fouls drawn. |
| avg_rating | double | Per-game average of ACB rating (valoracion). |
| avg_plus_minus | double | Per-game average of plus/minus. |
| avg_wins | double | Per-game average of team wins in the counted games (meaning unverified). |
| avg_losses | double | Per-game average of team losses in the counted games (meaning unverified). |
| per40_num_games | double | Per-40-minute rate of games played. |
| per40_time_played | double | Always null: the per-40 block carries no time played. |
| per40_starter | double | Per-40-minute rate of games started. |
| per40_points | double | Per-40-minute rate of points. |
| per40_max_points | double | Per-40-minute rate of most points in a single game. |
| per40_three_pointers_made | double | Per-40-minute rate of three-point field goals made. |
| per40_three_pointers_attempted | double | Per-40-minute rate of three-point field goals attempted. |
| per40_three_pointers_percentage | double | Per-40-minute rate of three-point percentage (0-100). |
| per40_two_pointers_made | double | Per-40-minute rate of two-point field goals made. |
| per40_two_pointers_attempted | double | Per-40-minute rate of two-point field goals attempted. |
| per40_two_pointers_percentage | double | Per-40-minute rate of two-point percentage (0-100). |
| per40_free_throws_made | double | Per-40-minute rate of free throws made. |
| per40_free_throws_attempted | double | Per-40-minute rate of free throws attempted. |
| per40_free_throws_percentage | double | Per-40-minute rate of free-throw percentage (0-100). |
| per40_rebounds | double | Per-40-minute rate of total rebounds. |
| per40_offensive_rebounds | double | Per-40-minute rate of offensive rebounds. |
| per40_defensive_rebounds | double | Per-40-minute rate of defensive rebounds. |
| per40_assists | double | Per-40-minute rate of assists. |
| per40_steals | double | Per-40-minute rate of steals. |
| per40_turnovers | double | Per-40-minute rate of turnovers. |
| per40_blocks | double | Per-40-minute rate of blocks made. |
| per40_shots_rejected | double | Per-40-minute rate of own shots blocked. |
| per40_dunks | double | Per-40-minute rate of dunks. |
| per40_personal_fouls | double | Per-40-minute rate of personal fouls committed. |
| per40_fouls_received | double | Per-40-minute rate of fouls drawn. |
| per40_rating | double | Per-40-minute rate of ACB rating (valoracion). |
| per40_plus_minus | double | Per-40-minute rate of plus/minus. |
| per40_wins | double | Per-40-minute rate of team wins in the counted games (meaning unverified). |
| per40_losses | double | Per-40-minute rate of team losses in the counted games (meaning unverified). |

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
[`acb_team_box()`](https://hoopR.sportsdataverse.org/reference/acb_team_box.md),
[`acb_team_comparison()`](https://hoopR.sportsdataverse.org/reference/acb_team_comparison.md),
[`acb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_team_leaders.md),
[`acb_team_matches()`](https://hoopR.sportsdataverse.org/reference/acb_team_matches.md),
[`acb_team_records()`](https://hoopR.sportsdataverse.org/reference/acb_team_records.md),
[`acb_team_totals()`](https://hoopR.sportsdataverse.org/reference/acb_team_totals.md),
[`acb_teams()`](https://hoopR.sportsdataverse.org/reference/acb_teams.md)

## Examples

``` r
# \donttest{
  try(acb_team_stats(club_id = 2, season = 2027))
#> ── ACB Team Stats from api2.acb.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:44:52 UTC
#> # A tibble: 15 × 97
#>    club_id team_id edition_id season player_id player_name  first_name last_name
#>      <int>   <int>      <int>  <int>     <int> <chr>        <chr>      <chr>    
#>  1       2    4467         91   2027  30005357 Olivier Nka… Olivier    Nkamhoua 
#>  2       2    4467         91   2027  30003361 Kevin Punter Kevin      Punter   
#>  3       2    4467         91   2027  30005377 Tosan Evbuo… Torisesan  Evbuomwan
#>  4       2    4467         91   2027  30005356 Josh Nebo    Joshua     Nebo     
#>  5       2    4467         91   2027  30004602 A. Kone      Abdrahama… Kone     
#>  6       2    4467         91   2027  20212243 Olek Balcer… Aleksander Balcerow…
#>  7       2    4467         91   2027  30005378 Tyrese Mart… Tyrese     Martin   
#>  8       2    4467         91   2027  30001332 Agustín Ubal Agustín    Ubal     
#>  9       2    4467         91   2027  20212265 Joel Parra   Joel       Parra    
#> 10       2    4467         91   2027  30003340 Justin Robi… Justin     Robinson 
#> 11       2    4467         91   2027  30005355 Umoja Gibson Umoja      Gibson   
#> 12       2    4467         91   2027  30000093 Juan Núñez   Juan       Núñez    
#> 13       2    4467         91   2027  30005361 Stanley Umu… Stanley    Umude    
#> 14       2    4467         91   2027  20209919 Darío Brizu… Darío      Brizuela 
#> 15       2    4467         91   2027  30005476 Justin Mina… Justin     Minaya   
#> # ℹ 89 more variables: shirt_number <chr>, game_role <chr>,
#> #   total_num_games <int>, total_time_played <int>, total_starter <int>,
#> #   total_points <int>, total_max_points <int>,
#> #   total_three_pointers_made <int>, total_three_pointers_attempted <int>,
#> #   total_three_pointers_percentage <dbl>, total_two_pointers_made <int>,
#> #   total_two_pointers_attempted <int>, total_two_pointers_percentage <dbl>,
#> #   total_free_throws_made <int>, total_free_throws_attempted <int>, …
# }
```
