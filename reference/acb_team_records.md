# **Get ACB Team Records**

A club's single-game records (best performance per statistic).

One row per statistic (`stat`): `value` is the record, with the game
(`game_id`, `game_date`), the player and both teams of that game.
Records go back to 1983-84; `game_id` is a match id of the legacy
sequence.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-records`

## Usage

``` r
acb_team_records(club_id)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sdv-py `acb_team_records`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| club_id | integer | Stable club id asked for. |
| stat | character | Record category in snake_case (rating, points, rebounds, assists, steals, ...). |
| value | numeric | The record value (a count; Float64 so every category fits). |
| game_id | integer | Match id of the record game (legacy sequence for old games). |
| game_date | POSIXct | Date of the record game (UTC midnight). |
| player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |
| local_team_id | integer | Home season-team entry of the record game. |
| local_club_id | integer | Home stable club id of the record game. |
| local_team | character | Home team name in the record game. |
| local_team_abbr | character | Home team abbreviation in the record game. |
| visitor_team_id | integer | Away season-team entry of the record game. |
| visitor_club_id | integer | Away stable club id of the record game. |
| visitor_team | character | Away team name in the record game. |
| visitor_team_abbr | character | Away team abbreviation in the record game. |

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
[`acb_team_stats()`](https://hoopR.sportsdataverse.org/reference/acb_team_stats.md),
[`acb_team_totals()`](https://hoopR.sportsdataverse.org/reference/acb_team_totals.md),
[`acb_teams()`](https://hoopR.sportsdataverse.org/reference/acb_teams.md)

## Examples

``` r
# \donttest{
  try(acb_team_records(club_id = 2))
#> ── ACB Team Records from api2.acb.com ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:33:19 UTC
#> # A tibble: 15 × 19
#>    club_id stat          value game_id game_date           player_id player_name
#>      <int> <chr>         <dbl>   <int> <dttm>                  <int> <chr>      
#>  1       2 rating           46    5573 1988-01-30 00:00:00  20200740 Steve Trum…
#>  2       2 points           54    4606 1984-02-18 00:00:00  20200741 Epi        
#>  3       2 rebounds         19    5092 1986-02-22 00:00:00  20200740 Steve Trum…
#>  4       2 assists          14   18227 2018-12-16 00:00:00  20204097 Thomas Heu…
#>  5       2 steals            8    5525 1987-12-06 00:00:00  20200739 Nacho Solo…
#>  6       2 blocks           12   12701 2007-01-07 00:00:00  20200648 Fran Vázqu…
#>  7       2 three_pointer    12   15578 2014-03-08 00:00:00  20210662 Jacob Pull…
#>  8       2 two_pointer      24    4606 1984-02-18 00:00:00  20200741 Epi        
#>  9       2 free_throws      20   12280 2005-11-05 00:00:00  20200515 Juan Carlo…
#> 10       2 defensive_re…    15  102920 2021-09-22 00:00:00  20202101 Nikola Mir…
#> 11       2 offensive_re…    10    8729 1995-03-24 00:00:00  20201030 Darryl Mid…
#> 12       2 received_fou…    13   12280 2005-11-05 00:00:00  20200515 Juan Carlo…
#> 13       2 committed_fo…     5  105392 2026-10-04 00:00:00  30005355 Umoja Gibs…
#> 14       2 dunks             6   15848 2014-06-10 00:00:00  20209874 Joey Dorsey
#> 15       2 turnovers        13   10659 2000-12-16 00:00:00  20200511 Saras Jasi…
#> # ℹ 12 more variables: first_name <chr>, last_name <chr>, shirt_number <chr>,
#> #   game_role <chr>, local_team_id <int>, local_club_id <int>,
#> #   local_team <chr>, local_team_abbr <chr>, visitor_team_id <int>,
#> #   visitor_club_id <int>, visitor_team <chr>, visitor_team_abbr <chr>
# }
```
