# **Get VTB Infobasket Game Page**

Thin header of a finished game (use vtb_infobasket_game for teams, box
score and plays).

Endpoint: `GET https://org.infobasket.su/Widget/GamePage/{game_id}`

## Usage

``` r
vtb_infobasket_game_page(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble: Thin header of a finished game (use
vtb_infobasket_game for teams, box score and plays). The columns are
always these, in this order (sdv-py `vtb_infobasket_game_page`); an
empty valid answer raises `hoopR_no_data`, a valid body with no rows for
this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_name_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| comp_name_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_name_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_name_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_short_name_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_short_name_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| gender | integer | Competition gender: 0 on every VTB sample (men). Other values unverified. |
| comp_id | integer | Always 0 on this thin header; use vtb_infobasket_game for the stage. |
| league_id | integer | Season-level competition id of the game (50714 = VTB 2025-26); 0 in GamePage. |
| game_id | integer | Infobasket game id (GameID); equals the v2 API `matchId`. Joins to /Widget/GetOnline/{gameId} and /Widget/GamePage/{gameId}. The scope check compares it with the request. |
| game_date | character | Game date as an ISO 8601 string in Moscow time (+03:00), midnight. |
| game_time | character | Tip-off as an ISO 8601 string in Moscow time (+03:00). |
| game_date_time | character | Tip-off as an ISO 8601 string in Moscow time (+03:00). |
| game_number | character | Game number within the competition, e.g. 'RS-002' (RS = regular season); playoff games use the series code. |
| game_region | integer | Region (city) id of the game. |
| game_arena | integer | Arena id of the game. Infobasket arena id; equals the v2 API `venueId` (11687 = SK Basket-Hall, Krasnodar). |
| game_rules | integer | Rules code (1 in the samples; unverified). |
| game_forfeit | integer | 1 when the game was forfeited, else 0. |
| game_attendance | integer | Spectators at the game (null when not recorded). |
| game_status | integer | Game status: 0 planned, 1 completed, 2 live (the site's widget code). Samples are completed games. |
| game_stats_status | integer | Stats status of the game; 0 in the samples. |
| game_time_moscow_string | character | Tip-off time in Moscow time, 'HH:MM'. |
| region_name_ru | character | City or region in Russian. |
| region_name_en | character | City or region in English. |
| arena_name_ru | character | Arena name in Russian. |
| arena_name_en | character | Arena name in English. |
| arena_full_name_ru | character | Arena full name in Russian. |
| arena_full_name_en | character | Arena full name in English. |

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

## Examples

``` r
# \donttest{
  try(vtb_infobasket_game_page(game_id = 921391))
#> ── VTB Infobasket Game Page from org.infobasket.su ───────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:04:43 UTC
#> # A tibble: 1 × 28
#>   comp_name_ru comp_name_en league_name_ru league_name_en league_short_name_ru
#>   <chr>        <chr>        <chr>          <chr>          <chr>               
#> 1 NA           NA           NA             NA             NA                  
#> # ℹ 23 more variables: league_short_name_en <chr>, gender <int>, comp_id <int>,
#> #   league_id <int>, game_id <int>, game_date <chr>, game_time <chr>,
#> #   game_date_time <chr>, game_number <chr>, game_region <int>,
#> #   game_arena <int>, game_rules <int>, game_forfeit <int>,
#> #   game_attendance <int>, game_status <int>, game_stats_status <int>,
#> #   game_time_moscow_string <chr>, region_name_ru <chr>, region_name_en <chr>,
#> #   arena_name_ru <chr>, arena_name_en <chr>, arena_full_name_ru <chr>, …
# }
```
