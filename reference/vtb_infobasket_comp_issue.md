# **Get VTB Infobasket Comp Issue**

Stage tree of a season (regular season, playoff, series): the stage ids
the standings wrappers take.

Endpoint: `GET https://org.infobasket.su/Widget/CompIssue/{season}`

## Usage

``` r
vtb_infobasket_comp_issue(season, tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached).

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: Stage tree of a season (regular season, playoff,
series): the stage ids the standings wrappers take. The columns are
always these, in this order (sdv-py `vtb_infobasket_comp_issue`); an
empty valid answer raises `hoopR_no_data`, a valid body with no rows for
this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| season_comp_id | integer | Season-level Infobasket CompID of the season (50714 = 2025-26): the id every season-keyed route takes. |
| level | integer | Depth in the stage tree: 1 = a stage of the season, 2 = a series or group below it. |
| comp_id | integer | Stage CompID (the id vtb_infobasket_standings, \_cross_table and \_playoff take). |
| parent_comp_id | integer | CompID of the parent stage (0 at the top). |
| comp_type | integer | Stage type code: 0 season, regular season or group; 10 playoff container; 5 and 7 playoff series; -5 seen in season lists. Meanings inferred from the stage names, unverified. |
| comp_sort | integer | Sort order among sibling stages. |
| comp_round | integer | Playoff round as the number of series in it (4 = quarter-finals, 2 = semi-finals, 1 = final); 0 outside the playoff. |
| comp_short_name_ru | character | Stage name, Russian. |
| comp_short_name_en | character | Stage name, English. |
| comp_abc_name_ru | character | Stage abbreviation ('1/4-1' = quarter-final 1), Russian. |
| comp_abc_name_en | character | Stage abbreviation ('1/4-1' = quarter-final 1), English. |
| comp_gender | integer | Competition gender: 0 on every sample (men). |
| comp_state | integer | Stage state code: 0 or 2 seen (2 on finished stages, but some finished stages show 0); unverified. |
| is_public | logical | True when the site shows the stage. |
| note_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| note_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |

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

     vtb_infobasket_comp_issue(season = 2026)

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_box_score.md),
[`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md),
[`vtb_infobasket_coach()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_coach.md),
[`vtb_infobasket_cross_table()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_cross_table.md),
[`vtb_infobasket_game()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game.md),
[`vtb_infobasket_game_page()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_page.md),
[`vtb_infobasket_game_staff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_staff.md),
[`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md),
[`vtb_infobasket_player()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player.md),
[`vtb_infobasket_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_career_stats.md),
[`vtb_infobasket_player_game_log()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_game_log.md),
[`vtb_infobasket_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_season_stats.md),
[`vtb_infobasket_playoff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff.md),
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
