# **Get ACB Competition Rounds**

The rounds of every competition edition: the round ids to crawl.

One row per edition and round: the global `round_id` (the key of the
round routes), `round_number` within the phase and the sub-phase.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_rounds(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sdv-py `acb_competition_rounds`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| edition_id | integer | Season id the round belongs to (START year - 1935). |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
| round_number | integer | Round number within the phase |
| subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
| subphase_number | integer | Sub-phase number; null in the regular season |

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
  try(acb_competition_rounds())
#> Error in acb_competition_rounds() : 
#>   api2.acb.com/api/matchdata/Menu/competition-data: the answer holds no
#> rows (competitions is empty).
# }
```
