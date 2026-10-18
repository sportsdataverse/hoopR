# **Get VTB Infobasket Team Stats Players**

Season totals of every player of every team of a season.

Endpoint: `GET https://org.infobasket.su/Comp/GetTeamStats/{season}`

## Usage

``` r
vtb_infobasket_team_stats_players(season, tag = "vtb")
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

A `hoopR_data` tibble: Season totals of every player of every team of a
season. The columns are always these, in this order (sdv-py
`vtb_infobasket_team_stats_players`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| person_id | integer | Infobasket person id (PersonID): one person (player, coach or official) across clubs and seasons. Joins to /Widget/PlayerPage/{personId} (players) and /Widget/CoachPage/{personId} (coaches). |
| player_number | integer | Shirt number as an integer (0 when the player has none or wears 00). |
| display_number | character | Shirt number as displayed ('0', '7'); a coach's is the coach order (1 = head coach). |
| is_active | logical | True while the person is on the current roster. |
| active_status | character | Roster status text ('Accepted'), empty otherwise. |
| points | integer | Points. The wire's null is 0 here (null counts are filled). |
| shot1 | integer | Free throws attempted. The wire's null is 0 here (null counts are filled). |
| goal1 | integer | Free throws made. The wire's null is 0 here (null counts are filled). |
| shot2 | integer | 2-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal2 | integer | 2-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot3 | integer | 3-point field goals attempted. The wire's null is 0 here (null counts are filled). |
| goal3 | integer | 3-point field goals made. The wire's null is 0 here (null counts are filled). |
| shot23 | integer | Field goals (2 + 3 points) attempted. The wire's null is 0 here (null counts are filled). |
| goal23 | integer | Field goals (2 + 3 points) made. The wire's null is 0 here (null counts are filled). |
| shot1_percent | double | Free-throw percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot2_percent | double | 2-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot3_percent | double | 3-point percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| shot23_percent | double | Field-goal percentage (0-100); parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| assist | integer | Assists. The wire's null is 0 here (null counts are filled). |
| blocks | integer | Blocked shots. The wire's null is 0 here (null counts are filled). |
| def_rebound | integer | Defensive rebounds. The wire's null is 0 here (null counts are filled). |
| off_rebound | integer | Offensive rebounds. The wire's null is 0 here (null counts are filled). |
| rebound | integer | Total rebounds. The wire's null is 0 here (null counts are filled). |
| steal | integer | Steals. The wire's null is 0 here (null counts are filled). |
| turnover | integer | Turnovers. The wire's null is 0 here (null counts are filled). |
| foul | integer | Personal fouls committed. The wire's null is 0 here (null counts are filled). |
| opponent_foul | integer | Fouls drawn. The wire's null is 0 here (null counts are filled). |
| plus_minus | integer | Plus-minus: point differential while on the court. Null where the host sends none. |
| kpi | integer | Efficiency index (KPI, the platform's 'KPI'); formula unverified. |
| avg_points | double | Per-game average of: points; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_assist | double | Per-game average of: assists; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_blocks | double | Per-game average of: blocked shots; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_def_rebound | double | Per-game average of: defensive rebounds; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_off_rebound | double | Per-game average of: offensive rebounds; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_rebound | double | Per-game average of: total rebounds; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_steal | double | Per-game average of: steals; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_turnover | double | Per-game average of: turnovers; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_foul | double | Per-game average of: personal fouls committed; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_opponent_foul | double | Per-game average of: fouls drawn; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_plus_minus | double | Per-game average of: plus-minus: point differential while on the court; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| avg_kpi | double | Per-game average of: efficiency index (kpi, the platform's 'kpi'); formula unverified; parsed to a number (the wire sends a comma-decimal string, null when there were no attempts). |
| seconds | integer | Playing time in seconds. |
| played_time | character | Playing time as 'minutes:seconds' (team rows sum the five players: '200:00' = 40 minutes x 5). |
| avg_played_time | character | Average playing time per game as 'minutes:seconds'. |
| in_game_count | integer | Games actually played (on the court). |
| game_count | integer | Games in the totals (the whole competition, all stages, for the season-level CompID). |
| start_count | integer | Games the person started. |
| person_last_name_ru | character | Last name, Russian. |
| person_last_name_en | character | Last name, English. |
| person_first_name_ru | character | First name, Russian. |
| person_first_name_en | character | First name, English. |
| person_full_name_ru | character | Full name, 'Last First', Russian. |
| person_full_name_en | character | Full name, 'Last First', English. |
| person_gender | integer | Person gender: 1 on every sampled (male) person. |
| birth_date | character | Birth date (ISO 8601 date) of a player: public bio, kept; coaches' and officials' birth data is never output. |
| height | integer | Height in centimetres. |
| weight | integer | Weight in kilograms. |
| player_position | integer | Player position code from the host (1 point guard, 2 shooting guard, 3 small forward ... 5 center; see position_id for the named position). |

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
[`vtb_infobasket_team_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_games.md),
[`vtb_infobasket_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_player_stats.md),
[`vtb_infobasket_team_preview()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_preview.md),
[`vtb_infobasket_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_season_stats.md),
[`vtb_infobasket_team_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_seasons.md),
[`vtb_infobasket_team_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats.md),
[`vtb_infobasket_team_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_coaches.md),
[`vtb_league_leagues()`](https://hoopR.sportsdataverse.org/reference/vtb_league_leagues.md),
[`vtb_league_matches()`](https://hoopR.sportsdataverse.org/reference/vtb_league_matches.md),
[`vtb_league_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_league_seasons.md)

## Examples

``` r
# \donttest{
  try(vtb_infobasket_team_stats_players(season = 2026))
#> ── VTB Infobasket Team Stats Players from org.infobasket.su ────────────────────
#> ℹ Data updated: 2026-10-18 17:44:30 UTC
#> # A tibble: 194 × 60
#>    season team_id person_id player_number display_number is_active active_status
#>     <int>   <int>     <int>         <int> <chr>          <lgl>     <chr>        
#>  1   2026     682    311124             0 0              TRUE      ""           
#>  2   2026     682     51620             1 1              TRUE      ""           
#>  3   2026     682    393046             3 3              TRUE      ""           
#>  4   2026     682     53079             4 4              TRUE      ""           
#>  5   2026     682     43443             6 6              TRUE      ""           
#>  6   2026     682    491383             8 8              TRUE      ""           
#>  7   2026     682     26883             9 9              TRUE      ""           
#>  8   2026     682     33188            12 12             TRUE      ""           
#>  9   2026     682    370815            14 14             TRUE      ""           
#> 10   2026     682    258077            24 24             TRUE      ""           
#> # ℹ 184 more rows
#> # ℹ 53 more variables: points <int>, shot1 <int>, goal1 <int>, shot2 <int>,
#> #   goal2 <int>, shot3 <int>, goal3 <int>, shot23 <int>, goal23 <int>,
#> #   shot1_percent <dbl>, shot2_percent <dbl>, shot3_percent <dbl>,
#> #   shot23_percent <dbl>, assist <int>, blocks <int>, def_rebound <int>,
#> #   off_rebound <int>, rebound <int>, steal <int>, turnover <int>, foul <int>,
#> #   opponent_foul <int>, plus_minus <int>, kpi <int>, avg_points <dbl>, …
# }
```
