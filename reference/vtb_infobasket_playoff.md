# **Get VTB Infobasket Playoff**

Playoff bracket of a playoff stage, one row per series.

Endpoint: `GET https://org.infobasket.su/Widget/PlayOff/{comp_id}`

## Usage

``` r
vtb_infobasket_playoff(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble: Playoff bracket of a playoff stage, one row per
series. The columns are always these, in this order (sdv-py
`vtb_infobasket_playoff`); an empty valid answer raises `hoopR_no_data`,
a valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_id | integer | Stage CompID the request asked for (50720 = the 2025-26 regular season): a stage below the season, not an END year. |
| tree | integer | Bracket tree number (1 = the main bracket). |
| round | integer | Round as the number of series in it (4 = quarter-finals, 2 = semi-finals, 1 = final). |
| is_current_round | logical | True for the round in progress. |
| sort | integer | Series order within the round. |
| round_name_ru | character | Round name, Russian. |
| round_name_en | character | Round name, English. |
| score1 | integer | Series wins of side 1. |
| score2 | integer | Series wins of side 2. |
| is_final | logical | True for a final (decided) result. |
| winner | integer | Series winner: 1 side 1, 2 side 2. |
| team1_id | integer | Infobasket TeamID of team 1. |
| team1_short_name_ru | character | The team 1 of the series's short name in Russian (as the competition names it). |
| team1_short_name_en | character | The team 1 of the series's short name in English (as the competition names it). |
| team1_name_ru | character | The team 1 of the series's name in Russian (as the competition names it). |
| team1_name_en | character | The team 1 of the series's name in English (as the competition names it). |
| team1_region_name_ru | character | The team 1 of the series's region or city in Russian (as the competition names it). |
| team1_region_name_en | character | The team 1 of the series's region or city in English (as the competition names it). |
| team2_id | integer | Infobasket TeamID of team 2. |
| team2_short_name_ru | character | The team 2 of the series's short name in Russian (as the competition names it). |
| team2_short_name_en | character | The team 2 of the series's short name in English (as the competition names it). |
| team2_name_ru | character | The team 2 of the series's name in Russian (as the competition names it). |
| team2_name_en | character | The team 2 of the series's name in English (as the competition names it). |
| team2_region_name_ru | character | The team 2 of the series's region or city in Russian (as the competition names it). |
| team2_region_name_en | character | The team 2 of the series's region or city in English (as the competition names it). |

## Details

- Owner flag (sdv-internal-refs/vtb/README.md): the VTB United League is
  run from Russia and several clubs are owned or sponsored by sanctioned
  state companies (the KHL precedent); Infobasket is the Russian
  basketball federation's stats platform. Fetching on your own machine
  is fine. The owner has approved published data releases (2026-10-17),
  though none is scheduled yet. No accounts or payments are involved.

- Unofficial and unsupported: both hosts are keyless public JSON
  backends of vtb-league.com. No terms of use are published; robots.txt
  is a 404 on api.vtb-league.com and org.infobasket.su (no rules;
  vtb-league.com disallows only /wp/wp-admin/). The runtime waits at
  least 1 s before every request, retries included, and honours
  Retry-After on 429 / 503. No key, cookie or proxy is used
  (live-verified direct from the droplet 2026-10-12).

- Seasons are END years (2026 = 2025-26) on both backends. Infobasket
  keys everything by competition id: vtb_infobasket_seasons maps the END
  year to the season-level CompID, and the season-keyed wrappers do that
  mapping for you. CompID means three things: a season (50714), a stage
  below it (50720 regular season, 54281 playoff; stage-level wrappers
  take the stage id from vtb_infobasket_comp_issue) and, in the player
  season stats, an END year.

- Ids: the v2 matchId is the Infobasket GameID, the v2 teamId the
  Infobasket TeamID and the v2 venueId the Infobasket ArenaId. team_id
  is the key on every team route; comp_team_id (a registration in one
  stage) and the club-record id of the team page are other key spaces.
  person_id is one person across clubs and seasons.

- Errors are HTTP 200: an unknown id answers {MessageType, Message}, an
  unknown game the string 'BadRequest'; both are `hoopR_asset_fetch` (a
  failed fetch), never an empty frame. A body for another game, person,
  team, competition or season than the one asked for is
  `hoopR_asset_fetch` too, as is a game that is not final (box score,
  plays and header need GameStatus 1) and a partial GetTeamStats page.
  An empty list is `hoopR_no_data`.

- Coverage: calendars and box scores from 2009-10; play-by-play and shot
  x/y from 2022-23 only (earlier games give an empty pbp frame),
  officials in the line-ups from 2022-23. Shot x/y are decimetres from
  the basket centre (orientation unverified). Counting statistics are
  null instead of 0 on the wire (the parsers fill 0), percentages and
  averages are comma-decimal strings (the parsers return floats), the
  paint statistics are broken and dropped, and dates come in three
  encodings (the parsers return ISO strings; .NET instants as Moscow
  time with its +03:00 offset).

- Personal data: the runtime removes licence numbers, contact and
  operator-account fields for everyone and the birth dates, birth years
  and ages of coaches, referees and other officials from every body.
  Players' public bio (birth date, height, weight, nationality) is kept.

- Other tags (vtbyouth, wbc, wpremier, rfb) answer through the tag
  argument; only vtb was captured. The team routes key on the END-year
  season (sdv-py also lets a caller pass a stage CompID through params;
  the R wrappers do not).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or the host has nothing for the request: an
  empty list, a v2 season with no rows, a season without team totals),
  `hoopR_bad_request` (a malformed id or league slug, a lang other than
  en or ru, or a season the competition tag does not have) and
  `hoopR_asset_fetch` (any other non-2xx, an empty or non-JSON body, an
  error envelope or string, a game that is not final or a stub, a
  partial or possibly truncated page, or a body for another game,
  person, team, competition, league or season). HTTP 500 is retried
  (neither host answers 500 for an unknown id). Wrappers raise; they
  never warn and return empty.

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_box_score.md),
[`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md),
[`vtb_infobasket_coach()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_coach.md),
[`vtb_infobasket_comp_issue()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_comp_issue.md),
[`vtb_infobasket_cross_table()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_cross_table.md),
[`vtb_infobasket_game()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game.md),
[`vtb_infobasket_game_page()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_page.md),
[`vtb_infobasket_game_staff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_staff.md),
[`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md),
[`vtb_infobasket_player()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player.md),
[`vtb_infobasket_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_career_stats.md),
[`vtb_infobasket_player_game_log()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_game_log.md),
[`vtb_infobasket_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_season_stats.md),
[`vtb_infobasket_playoff_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff_games.md),
[`vtb_infobasket_roster()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster.md),
[`vtb_infobasket_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster_coaches.md),
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md),
[`vtb_infobasket_standings()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_standings.md),
[`vtb_infobasket_team()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team.md),
[`vtb_infobasket_team_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_box_score.md),
[`vtb_infobasket_team_coach_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_coach_stats.md),
[`vtb_infobasket_team_comps()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_comps.md),
[`vtb_infobasket_team_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_games.md),
[`vtb_infobasket_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_player_stats.md),
[`vtb_infobasket_team_preview()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_preview.md),
[`vtb_infobasket_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_season_stats.md),
[`vtb_infobasket_team_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_seasons.md),
[`vtb_infobasket_team_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats.md),
[`vtb_infobasket_team_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_coaches.md),
[`vtb_infobasket_team_stats_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_players.md),
[`vtb_league_leagues()`](https://hoopR.sportsdataverse.org/reference/vtb_league_leagues.md),
[`vtb_league_matches()`](https://hoopR.sportsdataverse.org/reference/vtb_league_matches.md),
[`vtb_league_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_league_seasons.md)

## Examples

``` r
# \donttest{
  try(vtb_infobasket_playoff(comp_id = 54281))
#> ── VTB Infobasket Playoff from org.infobasket.su ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:44:20 UTC
#> # A tibble: 8 × 25
#>   comp_id  tree round is_current_round  sort round_name_ru  round_name_en score1
#>     <int> <int> <int> <lgl>            <int> <chr>          <chr>          <int>
#> 1   54281     1     4 FALSE                1 1/4 финала     1/4 finals         3
#> 2   54281     1     4 FALSE                2 1/4 финала     1/4 finals         3
#> 3   54281     1     4 FALSE                3 1/4 финала     1/4 finals         3
#> 4   54281     1     4 FALSE                4 1/4 финала     1/4 finals         3
#> 5   54281     1     2 FALSE                1 1/2 финала     1/2 finals         4
#> 6   54281     1     2 FALSE                2 1/2 финала     1/2 finals         4
#> 7   54281     1     1 TRUE                 1 Финал          Final              4
#> 8   54281     2     1 TRUE                 2 Финал за 3 ме… Final for 3        2
#> # ℹ 17 more variables: score2 <int>, is_final <lgl>, winner <int>,
#> #   team1_id <int>, team1_short_name_ru <chr>, team1_short_name_en <chr>,
#> #   team1_name_ru <chr>, team1_name_en <chr>, team1_region_name_ru <chr>,
#> #   team1_region_name_en <chr>, team2_id <int>, team2_short_name_ru <chr>,
#> #   team2_short_name_en <chr>, team2_name_ru <chr>, team2_name_en <chr>,
#> #   team2_region_name_ru <chr>, team2_region_name_en <chr>
# }
```
