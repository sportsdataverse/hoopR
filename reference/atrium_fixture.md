# **Atrium Fixture (game header)**

**One game's header: teams, score, venue, status, rules (periods,
overtime, shot clock) and captains.**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`

The rules (`number_of_periods`, `period_length` in minutes,
`overtime_length`, `shot_clock` in seconds, ...) come from the game's
profile. `*_captain_person_id` is the person id of each team's captain.

## Usage

``` r
atrium_fixture(website_id, fixture_id, locale = NULL)
```

## Arguments

- website_id:

  (*integer* required): Site config id: which league site's widget this
  is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador,
  22 Panama, 236 Austria, 326 Montenegro). Not a league id: one site
  serves several competitions.

- fixture_id:

  (*character* required): Game UUID (`fixture_id` in
  [`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md)),
  e.g. `"0dc631bd-c34c-11f1-8d16-4d5a21afb79d"`.

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble, one row for the game:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| competition_name | character | Name of the competition, in the site's language. |
| name | character | Fixture name; null on LNBP. |
| fixture_type | character | Kind of game as sent: REGULAR, PLAYOFF, ... (the set is open). |
| age_group | character | Age group of the competition, e.g. SENIOR. |
| status | character | Status code of the game, e.g. CONFIRMED (final), as sent. |
| status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
| start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
| start_time_local | character | Scheduled start in the venue's local time, as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; timezone gives the zone, which varies per row). |
| timezone | character | IANA time zone of the venue (e.g. Europe/Paris, Mexico/General) that start_time_local is in. |
| venue | character | Name of the arena where the game is played. |
| venue_id | character | Venue UUID; joins no other route. |
| attendance | integer | Spectators at the game; null when not reported. |
| external_id | character | The league's own match number (LNB: the lnb.fr number); null elsewhere. |
| updated | POSIXct | When the record was last updated, naive datetime (no offset; zone unverified). |
| live_data_available | logical | True when live data feeds are enabled for the game. |
| live_video_available | logical | True when a live video stream is attached. |
| discipline | character | Discipline label of the game; null in every body seen. |
| series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
| number_of_periods | integer | Regulation periods in the game (4). |
| period_length | integer | Length of a regulation period, in minutes. |
| overtime_allowed | logical | True when the game may go to overtime. |
| overtime_length | integer | Length of an overtime period, in minutes. |
| shot_clock | integer | Shot clock length, in seconds. |
| max_fouls_personal | integer | Personal fouls that disqualify a player. |
| fouls_before_bonus | integer | Team fouls in a period before the bonus applies. |
| maximum_players_on_court | integer | Players a team has on court at once. |
| maximum_roster_size | integer | Largest roster a team may enter for the game. |
| home_entity_id | character | Team UUID of the home team. |
| home_code | character | Short code of the home team (e.g. PAB). |
| home_name | character | Name of the home team. |
| home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
| home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
| away_entity_id | character | Team UUID of the away team. |
| away_code | character | Short code of the away team (e.g. PAB). |
| away_name | character | Name of the away team. |
| away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
| away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
| home_captain_person_id | character | Person UUID of the home team's captain; null when the body names none. |
| away_captain_person_id | character | Person UUID of the away team's captain; null when the body names none. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md).

## See also

Other Atrium Functions:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
[`atrium_fixtures_ribbon()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures_ribbon.md),
[`atrium_leaders()`](https://hoopR.sportsdataverse.org/reference/atrium_leaders.md),
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md),
[`atrium_player()`](https://hoopR.sportsdataverse.org/reference/atrium_player.md),
[`atrium_player_game_log()`](https://hoopR.sportsdataverse.org/reference/atrium_player_game_log.md),
[`atrium_player_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_player_seasons.md),
[`atrium_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_player_stats.md),
[`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md),
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md),
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md),
[`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md),
[`atrium_standings_summary()`](https://hoopR.sportsdataverse.org/reference/atrium_standings_summary.md),
[`atrium_team()`](https://hoopR.sportsdataverse.org/reference/atrium_team.md),
[`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md),
[`atrium_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_team_stats.md),
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md),
[`lmb_competition`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md),
[`lnb_competition`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md),
[`lnbp_competition`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md),
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md),
[`nbl1_competition`](https://hoopR.sportsdataverse.org/reference/nbl1_competition.md)

## Examples

``` r
# \donttest{
  try(atrium_fixture(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#> ── Atrium fixture from embed-api.eui.connect.sportradar.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:44:55 UTC
#> # A tibble: 1 × 42
#>   website_id fixture_id  season_id competition_name name  fixture_type age_group
#>        <int> <chr>       <chr>     <chr>            <chr> <chr>        <chr>    
#> 1         14 0dc631bd-c… cc7d79f3… LIGA CALIENTE.M… NA    PLAYOFF      SENIOR   
#> # ℹ 35 more variables: status <chr>, status_label <chr>, start_time_utc <dttm>,
#> #   start_time_local <chr>, timezone <chr>, venue <chr>, venue_id <chr>,
#> #   attendance <int>, external_id <chr>, updated <dttm>,
#> #   live_data_available <lgl>, live_video_available <lgl>, discipline <chr>,
#> #   series <chr>, number_of_periods <int>, period_length <int>,
#> #   overtime_allowed <lgl>, overtime_length <int>, shot_clock <int>,
#> #   max_fouls_personal <int>, fouls_before_bonus <int>, …
# }
```
