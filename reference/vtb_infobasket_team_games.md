# **Get VTB Infobasket Team Games**

A club's games in one season (the calendar's row shape).

Endpoint: `GET https://org.infobasket.su/Widget/TeamGames/{team_id}`

## Usage

``` r
vtb_infobasket_team_games(team_id, season, tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached). Required.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: A club's games in one season (the calendar's row
shape). The columns are always these, in this order (sdv-py
`vtb_infobasket_team_games`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| comp_id | integer | Season-level Infobasket CompID of the season (50714 = 2025-26): the id every season-keyed route takes. |
| game_id | integer | Infobasket game id (GameID); equals the v2 API `matchId`. Joins to /Widget/GetOnline/{gameId} and /Widget/GamePage/{gameId}. |
| game_number | character | Game number within the competition, e.g. 'RS-002' (RS = regular season); playoff games use the series code. |
| game_date | character | Game date as an ISO 8601 date (YYYY-MM-DD); the wire sends DD.MM.YYYY. |
| has_time | logical | True when a tip-off time is set. |
| game_time | character | Tip-off local time, 'HH:MM'. |
| game_time_msk | character | Tip-off time in Moscow time ('HH:MM' on calendar rows, 'HH.MM' in GetOnline). |
| game_date_time | character | Tip-off instant as an ISO 8601 string in Moscow time with its +03:00 offset (the wire sends a .NET /Date(ms)/ value). |
| game_date_time_moscow | character | Tip-off instant as an ISO 8601 string in Moscow time with its +03:00 offset (the wire's second .NET date; equal to game_date_time in every sample). |
| game_status | integer | Game status: 0 planned, 1 completed, 2 live (the site's widget code). Samples are completed games. |
| team_a_id | integer | Team A (home) TeamID. Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. |
| team_b_id | integer | Team B (away) TeamID. Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. |
| short_team_name_aru | character | Team short name of team A (home), Russian. |
| short_team_name_bru | character | Team short name of team B (away), Russian. |
| team_name_aru | character | Team name with city in brackets of team A (home), Russian. |
| team_name_bru | character | Team name with city in brackets of team B (away), Russian. |
| comp_team_name_aru | character | Team name as registered in the competition of team A (home), Russian. |
| comp_team_name_bru | character | Team name as registered in the competition of team B (away), Russian. |
| region_team_name_aru | character | Team's city or region of team A (home), Russian. |
| region_team_name_bru | character | Team's city or region of team B (away), Russian. |
| short_team_name_aen | character | Team short name of team A (home), English. |
| short_team_name_ben | character | Team short name of team B (away), English. |
| team_name_aen | character | Team name with city in brackets of team A (home), English. |
| team_name_ben | character | Team name with city in brackets of team B (away), English. |
| comp_team_name_aen | character | Team name as registered in the competition of team A (home), English. |
| comp_team_name_ben | character | Team name as registered in the competition of team B (away), English. |
| region_team_name_aen | character | Team's city or region of team A (home), English. |
| region_team_name_ben | character | Team's city or region of team B (away), English. |
| score_a | integer | Final score of team A (home). |
| score_b | integer | Final score of team B (away). |
| tv_ru | character | TV channels, in Russian. |
| tv_en | character | TV channels, in English. |
| region_ru | character | City or region of the game's venue in Russian. |
| region_en | character | City or region of the game's venue in English. |
| arena_en | character | Arena name, English. |
| arena_ru | character | Arena, Russian ('SK' = sports complex). |
| arena_id | integer | Infobasket arena id; equals the v2 API `venueId` (11687 = SK Basket-Hall, Krasnodar). |
| game_attendance | integer | Spectators at the game (null when not recorded). |
| comp_name_ru | character | Stage name, Russian ('Regulyarnyy chempionat' = 'Regular Season', 'Gruppa A' = 'Group A'). |
| comp_name_en | character | Stage name (e.g. 'Regular Season'), English. |
| league_name_ru | character | League name, Russian ('Edinaya liga VTB' / 'Chempionat Edinoy ligi VTB' = 'VTB United League' / 'VTB United League Championship'). |
| league_name_en | character | League name, English. |
| league_short_name_ru | character | League short name, Russian ('VTB' = 'VTB'). |
| league_short_name_en | character | League short name, English. |
| gender | integer | Competition gender: 0 on every VTB sample (men). Other values unverified. |

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
  try(vtb_infobasket_team_games(season = 2026, team_id = 2650))
#> ── VTB Infobasket Team Games from org.infobasket.su ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:50:54 UTC
#> # A tibble: 53 × 47
#>    team_id season comp_id game_id game_number game_date  has_time game_time
#>      <int>  <int>   <int>   <int> <chr>       <chr>      <lgl>    <chr>    
#>  1    2650   2026   50714  921391 RS-002      2025-09-28 TRUE     14:00    
#>  2    2650   2026   50714  921395 RS-006      2025-10-02 TRUE     20:00    
#>  3    2650   2026   50714  921399 RS-010      2025-10-05 TRUE     14:00    
#>  4    2650   2026   50714  921407 RS-018      2025-10-12 TRUE     14:00    
#>  5    2650   2026   50714  921415 RS-026      2025-10-19 TRUE     14:30    
#>  6    2650   2026   50714  921420 RS-032      2025-10-25 TRUE     16:00    
#>  7    2650   2026   50714  921428 RS-039      2025-10-29 TRUE     19:00    
#>  8    2650   2026   50714  921429 RS-040      2025-11-01 TRUE     19:30    
#>  9    2650   2026   50714  921437 RS-049      2025-11-09 TRUE     14:00    
#> 10    2650   2026   50714  921443 RS-053      2025-11-12 TRUE     20:00    
#> # ℹ 43 more rows
#> # ℹ 39 more variables: game_time_msk <chr>, game_date_time <chr>,
#> #   game_date_time_moscow <chr>, game_status <int>, team_a_id <int>,
#> #   team_b_id <int>, short_team_name_aru <chr>, short_team_name_bru <chr>,
#> #   team_name_aru <chr>, team_name_bru <chr>, comp_team_name_aru <chr>,
#> #   comp_team_name_bru <chr>, region_team_name_aru <chr>,
#> #   region_team_name_bru <chr>, short_team_name_aen <chr>, …
# }
```
