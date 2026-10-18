# **Get ACB Player Stats**

A player's season statistics, one row per team and edition.

One row per team-edition the player played: `total_*` counts, `avg_*`
averages and `per40_*` per-40 rates as in `acb_team_stats`.
`edition_year` is the label (`'2026-2027'`).

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/player-stats`

## Usage

``` r
acb_player_stats(player_id, competition_id = NULL, season = NULL)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year used as an UPPER bound: the rows keep
  the seasons up to this one (2026 drops the 2026-27 row). Omitted = all
  seasons. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sdv-py `acb_player_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ACB licence number asked for (the body names the player only in the totals block). |
| team_id | integer | Season-team entry the row covers (the API's teamEditionId). |
| competition_id | integer | Competition of the row. |
| edition_id | integer | Season id of the row (START year - 1935). |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| edition_year | character | Season label as sent ('2026-2027'). |
| club_id | integer | Stable club id of the team. |
| team | character | Team name that season. |
| team_abbr | character | Team abbreviation that season. |
| total_num_games | integer | Season total of games played. |
| total_time_played | integer | Season total of time on court in seconds. |
| total_starter | integer | Season total of games started. |
| total_points | integer | Season total of points. |
| total_max_points | integer | Season total of most points in a single game. |
| total_three_pointers_made | integer | Season total of three-point field goals made. |
| total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
| total_three_pointers_percentage | numeric | Season total of three-point percentage (0-100). |
| total_two_pointers_made | integer | Season total of two-point field goals made. |
| total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
| total_two_pointers_percentage | numeric | Season total of two-point percentage (0-100). |
| total_free_throws_made | integer | Season total of free throws made. |
| total_free_throws_attempted | integer | Season total of free throws attempted. |
| total_free_throws_percentage | numeric | Season total of free-throw percentage (0-100). |
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
| avg_num_games | numeric | Per-game average of games played. |
| avg_time_played | numeric | Per-game average of time on court in seconds. |
| avg_starter | numeric | Per-game average of games started. |
| avg_points | numeric | Per-game average of points. |
| avg_max_points | numeric | Per-game average of most points in a single game. |
| avg_three_pointers_made | numeric | Per-game average of three-point field goals made. |
| avg_three_pointers_attempted | numeric | Per-game average of three-point field goals attempted. |
| avg_three_pointers_percentage | numeric | Per-game average of three-point percentage (0-100). |
| avg_two_pointers_made | numeric | Per-game average of two-point field goals made. |
| avg_two_pointers_attempted | numeric | Per-game average of two-point field goals attempted. |
| avg_two_pointers_percentage | numeric | Per-game average of two-point percentage (0-100). |
| avg_free_throws_made | numeric | Per-game average of free throws made. |
| avg_free_throws_attempted | numeric | Per-game average of free throws attempted. |
| avg_free_throws_percentage | numeric | Per-game average of free-throw percentage (0-100). |
| avg_rebounds | numeric | Per-game average of total rebounds. |
| avg_offensive_rebounds | numeric | Per-game average of offensive rebounds. |
| avg_defensive_rebounds | numeric | Per-game average of defensive rebounds. |
| avg_assists | numeric | Per-game average of assists. |
| avg_steals | numeric | Per-game average of steals. |
| avg_turnovers | numeric | Per-game average of turnovers. |
| avg_blocks | numeric | Per-game average of blocks made. |
| avg_shots_rejected | numeric | Per-game average of own shots blocked. |
| avg_dunks | numeric | Per-game average of dunks. |
| avg_personal_fouls | numeric | Per-game average of personal fouls committed. |
| avg_fouls_received | numeric | Per-game average of fouls drawn. |
| avg_rating | numeric | Per-game average of ACB rating (valoracion). |
| avg_plus_minus | numeric | Per-game average of plus/minus. |
| avg_wins | numeric | Per-game average of team wins in the counted games (meaning unverified). |
| avg_losses | numeric | Per-game average of team losses in the counted games (meaning unverified). |
| per40_num_games | numeric | Per-40-minute rate of games played. |
| per40_time_played | numeric | Always null: the per-40 block carries no time played. |
| per40_starter | numeric | Per-40-minute rate of games started. |
| per40_points | numeric | Per-40-minute rate of points. |
| per40_max_points | numeric | Per-40-minute rate of most points in a single game. |
| per40_three_pointers_made | numeric | Per-40-minute rate of three-point field goals made. |
| per40_three_pointers_attempted | numeric | Per-40-minute rate of three-point field goals attempted. |
| per40_three_pointers_percentage | numeric | Per-40-minute rate of three-point percentage (0-100). |
| per40_two_pointers_made | numeric | Per-40-minute rate of two-point field goals made. |
| per40_two_pointers_attempted | numeric | Per-40-minute rate of two-point field goals attempted. |
| per40_two_pointers_percentage | numeric | Per-40-minute rate of two-point percentage (0-100). |
| per40_free_throws_made | numeric | Per-40-minute rate of free throws made. |
| per40_free_throws_attempted | numeric | Per-40-minute rate of free throws attempted. |
| per40_free_throws_percentage | numeric | Per-40-minute rate of free-throw percentage (0-100). |
| per40_rebounds | numeric | Per-40-minute rate of total rebounds. |
| per40_offensive_rebounds | numeric | Per-40-minute rate of offensive rebounds. |
| per40_defensive_rebounds | numeric | Per-40-minute rate of defensive rebounds. |
| per40_assists | numeric | Per-40-minute rate of assists. |
| per40_steals | numeric | Per-40-minute rate of steals. |
| per40_turnovers | numeric | Per-40-minute rate of turnovers. |
| per40_blocks | numeric | Per-40-minute rate of blocks made. |
| per40_shots_rejected | numeric | Per-40-minute rate of own shots blocked. |
| per40_dunks | numeric | Per-40-minute rate of dunks. |
| per40_personal_fouls | numeric | Per-40-minute rate of personal fouls committed. |
| per40_fouls_received | numeric | Per-40-minute rate of fouls drawn. |
| per40_rating | numeric | Per-40-minute rate of ACB rating (valoracion). |
| per40_plus_minus | numeric | Per-40-minute rate of plus/minus. |
| per40_wins | numeric | Per-40-minute rate of team wins in the counted games (meaning unverified). |
| per40_losses | numeric | Per-40-minute rate of team losses in the counted games (meaning unverified). |

## Details

- Legal notice (sdv-internal-refs/acb/README.md, aviso legal of acb.com
  read 2026-10-12): ACEB, S.A.U. claims intellectual property in the
  site's databases (the EU sui generis database right) among its other
  content. It authorises viewing and private copies for personal or
  journalistic use with the source credited, and requires prior express
  consent for distribution, reproduction or public communication. These
  wrappers fetch on the user's behalf; a published data release or a
  hosted mirror needs the owner's decision first. robots.txt allows the
  paths.

- Unofficial and unsupported: api2.acb.com is the .NET API behind
  acb.com and live.acb.com, not a documented public API. It needs the
  header `X-APIKEY`, a public key shipped in acb.com's bundle: the
  runtime sends the documented value (`$ACB_API_KEY` overrides it),
  re-reads the live bundle once on a 401, and never prints the key.

- Seasons: the API keys a season by `editionId` = season START year -
  1935 (91 = 2026-27, 48 = 1983-84, the first). The wrappers take
  `season`, the END year (2027 = 2026-27), and the runtime sends
  `editionId = season - 1936`. A route that omits `season` serves the
  current edition. `team_id` is a season-team entry (new every season);
  `club_id` is the stable club.

- Coverage: box scores from 1983-84 (old seasons carry only the
  whole-game period, quarter 0); play-by-play and shots from 2016-17
  (earlier games answer empty lists, which raise `hoopR_no_data`). Shot
  coordinates come in two systems, split by match id: millimetres from
  the attacked basket from 2020-21 (`coord_system` mm), a 0-100
  full-court percent grid before (grid). A game that is not finished
  (`matchFinished` false) raises `hoopR_asset_fetch` for the routes that
  report it.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404 / 204, a route whose rows are empty: an
  unknown id, a game outside a playoff series, play-by-play or shots
  before 2016-17, a club with no games that season), `hoopR_bad_request`
  (a missing, unknown or non-integer argument or a season before 1984,
  raised before any request; HTTP 400 / 422) and `hoopR_asset_fetch` (a
  key the API still rejects after one re-read of the bundle, any other
  non-200 after three attempts, a non-JSON or `problem+json` body, an
  error envelope or empty stub, a body for another season, round, club,
  player or match, a game that is not finished). Wrappers raise; they
  never warn and return empty.

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
  try(acb_player_stats(player_id = 20209407))
#> ── ACB Player Stats from api2.acb.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:23:29 UTC
#> # A tibble: 13 × 96
#>    player_id team_id competition_id edition_id season edition_year club_id team 
#>        <int>   <int>          <int>      <int>  <int> <chr>          <int> <chr>
#>  1  20209407    4476              1         91   2027 2026-2027          9 Real…
#>  2  20209407    4388              1         90   2026 2025-2026          9 Real…
#>  3  20209407    4345              1         89   2025 2024-2025          9 Real…
#>  4  20209407    4239              1         88   2024 2023-2024          9 Real…
#>  5  20209407    4149              1         87   2023 2022-2023          9 Real…
#>  6  20209407    3674              1         86   2022 2021-2022          9 Real…
#>  7  20209407    3387              1         85   2021 2020-2021          9 Real…
#>  8  20209407    3301              1         84   2020 2019-2020          9 Real…
#>  9  20209407    3212              1         83   2019 2018-2019          9 Real…
#> 10  20209407    3148              1         82   2018 2017-2018          9 Real…
#> 11  20209407    2980              1         79   2015 2014-2015          5 Herb…
#> 12  20209407    2940              1         78   2014 2013-2014          5 Herb…
#> 13  20209407    2870              1         77   2013 2012-2013          5 Gran…
#> # ℹ 88 more variables: team_abbr <chr>, total_num_games <int>,
#> #   total_time_played <int>, total_starter <int>, total_points <int>,
#> #   total_max_points <int>, total_three_pointers_made <int>,
#> #   total_three_pointers_attempted <int>,
#> #   total_three_pointers_percentage <dbl>, total_two_pointers_made <int>,
#> #   total_two_pointers_attempted <int>, total_two_pointers_percentage <dbl>,
#> #   total_free_throws_made <int>, total_free_throws_attempted <int>, …
# }
```
