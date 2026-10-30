# lkl.R -- the LKL `lkl_*()` family: Lietuvos krepsinio lyga (Lithuania) on lkl.lt.
#
# R mirror of sdv-py sportsdataverse/basketball/lkl (e3d232e): same names, arguments and columns.
# Runtime and parsers: R/lkl_utils.R. Generated from sdv-py's endpoint YAML, parser docstrings and
# manual_column_descriptions.yaml; edit the sdv-py sources first.

#' @title
#' **LKL Game Info**
#' @description
#' Game header from the game page: status, tip-off, venue, attendance, officials and both teams.
#'
#' Endpoint: `GET https://lkl.lt/rungtynes/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row. `start_date` / `start_time` are the Lithuanian local date and `HH:MM` (the
#' page carries no offset; the zone is Europe/Vilnius by the site's own wording). `referees` is the page's name list as
#' one string. `coach` / `assistant_coach` are the team's CURRENT staff on an old game; team name and slug are
#' historical. The page carries no officials' contact or birth data; any such key would be dropped by the runtime.
#' Videos, logos and the UI config props are dropped. An empty or unrecognised input gives a zero-row tibble with the
#' documented columns.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | game_status | character | Game state label in Lithuanian: 'Pasibaige' = finished, the only value served (the runtime refuses an unfinished game). |
#'   | start_date | Date | Game date (Europe/Vilnius), parsed from the page header 'YYYY m. `<month>` D d., HH:MM'. |
#'   | start_time | character | Tip-off 'HH:MM' local time (Europe/Vilnius by the site's wording; the page carries no offset). |
#'   | arena | character | Arena name as printed on the game page header. |
#'   | attendance | character | Attendance text as printed ('1097 ziurovai' = 1097 spectators). |
#'   | attendance_count | integer | Attendance as an integer, parsed from the attendance text; null when the page has none. |
#'   | referees | character | Referee names, comma-separated, crew chief first; 'Nepaskelbta' = not announced (old games). Names only: the site publishes no official's contact or birth data. |
#'   | has_actions | logical | True when the game has play-by-play events (2024-25 onward); false on older games. |
#'   | is_streaming | logical | True while a live stream is on; false on finished games. |
#'   | home_team_id | integer | Home team id (key space: lkl.lt clubs, stable across seasons and renamings; joins the team_id of every other frame). Not the Genius team id. |
#'   | home_team | character | Home team name as of that game (historical: 'Lietuvos Rytas' in 2007-08). |
#'   | home_short_name | character | Home three-letter team code ('RYT'); can be the club's current code on old games. |
#'   | home_slug | character | Home team slug (key space: lkl.lt clubs; the `{slug}` of lkl.lt/komandos/`{slug}`); joins the team slugs of lkl_results and lkl_standings. |
#'   | home_winner | logical | True when the home team won the game. |
#'   | home_coach | character | Home head coach's full name as stored for the team: on old games the CURRENT coach, not the historical one. |
#'   | home_assistant_coach | character | Home assistant coach's full name (same caveat as the head coach: current staff on old games). |
#'   | away_team_id | integer | Away team id (key space: lkl.lt clubs, stable across seasons and renamings; joins the team_id of every other frame). Not the Genius team id. |
#'   | away_team | character | Away team name as of that game (historical: 'Lietuvos Rytas' in 2007-08). |
#'   | away_short_name | character | Away three-letter team code ('RYT'); can be the club's current code on old games. |
#'   | away_slug | character | Away team slug (key space: lkl.lt clubs; the `{slug}` of lkl.lt/komandos/`{slug}`); joins the team slugs of lkl_results and lkl_standings. |
#'   | away_winner | logical | True when the away team won the game. |
#'   | away_coach | character | Away head coach's full name as stored for the team: on old games the CURRENT coach, not the historical one. |
#'   | away_assistant_coach | character | Away assistant coach's full name (same caveat as the head coach: current staff on old games). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_game_info(game_id = 11446))
#' }
lkl_game_info <- function(game_id) {
  .lkl_wrap("game_info", game_id, type = "LKL Game Info", call = rlang::current_env())
}

#' @title
#' **LKL Game Players**
#' @description
#' Game roster from the game page: every player on either team sheet with the lkl.lt player id and slug.
#'
#' Endpoint: `GET https://lkl.lt/rungtynes/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per rostered player. `player_id` (lkl.lt persons, stable across seasons) and
#' `slug` are the two keys: this frame is the slug -> id map for the box score, leaders and play-by-play, which carry
#' the slug only. `jersey` is a string. An empty or unrecognised input gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Joins the shot chart's player_id; the box score, leaders and play-by-play carry the slug, which this frame maps. |
#'   | player | character | Full player name as the game page prints it. |
#'   | jersey | character | Shirt number as a string (so '00' and '0' stay distinct). |
#'   | slug | character | Player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`). Join key to the player_slug of the box score, leaders and play-by-play. |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_game_players(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_game_players <- function(game_id) {
  .lkl_wrap("game_players", game_id, type = "LKL Game Players", call = rlang::current_env())
}

#' @title
#' **LKL Player Box**
#' @description
#' Per-player box score of a finished game: minutes, points, shooting splits, rebounds, assists and plus/minus.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per player on the team sheet (9-17 a side), starters first as the site lists
#' them. Every box cell is unwrapped from its `{value[, percentage]}` object; shooting cells `"made/attempted"` become
#' `*_made` / `*_attempted` integers and the one-decimal percentage string a 0-100 float. `player` is the short name
#' `I. Surname`; `player_slug` is the key the site uses, and `player_id` is resolved through the game roster the
#' runtime stamps (null on a body without the stamp). `seconds_played` is the `mm:ss` minutes in seconds. Team total
#' rows are in `lkl_team_box`. A body without players gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
#'   | player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
#'   | player | character | Player name as the site prints it in this route (the box score short form 'I. Surname', other routes the full name). |
#'   | jersey | character | Cell: Shirt number, a STRING ('77'); page column # (Marskineliu numeris). |
#'   | is_starter | logical | True for the five starters. |
#'   | is_captain | logical | True for the team captain. |
#'   | is_active | logical | False in every sample, finished games included; by name the player is on court right now (live games), unverified. |
#'   | seconds_played | integer | Time on court in seconds (the page's 'mm:ss' minutes: 32:54 = 1974). |
#'   | points | integer | Cell: Points (TSK, Taskai). |
#'   | fg_made | integer | Field goals made, 2PT + 3PT (the 'made' half of the 'made/attempted' cell). |
#'   | fg_attempted | integer | Field goals attempted, 2PT + 3PT. |
#'   | fg_pct | double | Field-goal percentage, 0-100 (the site's one-decimal string; 0 when there were no attempts). |
#'   | fg2_made | integer | Two-point field goals made. |
#'   | fg2_attempted | integer | Two-point field goals attempted. |
#'   | fg2_pct | double | Two-point percentage, 0-100 (one-decimal string on the site; 0 when there were no attempts). |
#'   | fg3_made | integer | Three-point field goals made. |
#'   | fg3_attempted | integer | Three-point field goals attempted. |
#'   | fg3_pct | double | Three-point percentage, 0-100 (one-decimal string on the site; 0 when there were no attempts). |
#'   | ft_made | integer | Free throws made. |
#'   | ft_attempted | integer | Free throws attempted. |
#'   | ft_pct | double | Free-throw percentage, 0-100 (one-decimal string on the site; 0 when there were no attempts). |
#'   | total_rebounds | integer | Cell: Total rebounds (AK, Atkovoti kamuoliai). |
#'   | offensive_rebounds | integer | Cell: Offensive rebounds (AKP, Atkovoti kamuoliai puolime). |
#'   | defensive_rebounds | integer | Cell: Defensive rebounds (AKG, Atkovoti kamuoliai gynyboje). |
#'   | assists | integer | Cell: Assists (RP, Rezultatyvus perdavimai). |
#'   | steals | integer | Cell: Steals (PK, Perimti kamuoliai). |
#'   | turnovers | integer | Cell: Turnovers (KL, Klaidos). |
#'   | blocks | integer | Cell: Blocks made (BL, Blokai). |
#'   | blocks_received | integer | Cell: Shots of this player/team that were blocked (GB, Gauti blokai). |
#'   | fouls | integer | Cell: Personal fouls committed (AP, Asmenines prazangos). |
#'   | fouls_on | integer | Cell: Fouls drawn (IP, Isprovokuotos prazangos). |
#'   | plus_minus | integer | Cell: Plus/minus while on court (+/- rodiklis). |
#'   | efficiency | integer | Cell: Efficiency rating (EF, Efektyvumas; see gameStatistics efficiency). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_player_box(game_id = 11446))
#' }
lkl_player_box <- function(game_id) {
  .lkl_wrap("player_box", game_id, type = "LKL Player Box", call = rlang::current_env())
}

#' @title
#' **LKL Team Box**
#' @description
#' Team game totals of both teams: shooting, rebounds, assists, turnovers, fouls, paint, bench and fast-break points.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. Two rows (home first). The body keys the totals by team id with no side marker, so
#' `team_side` comes from the game page the runtime stamps (null on a body without the stamp). Percentages are 0-100
#' floats (the site sends two-decimal strings); `time_leading` is seconds (the site sends a string).
#' `points_off_turnovers`, `fast_break_points`, `second_chance_points` and `points_in_paint` are 0 before 2024-25 (not
#' tracked). Per-period points are in `lkl_period_scores`. A body without `gameStatistics` gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
#'   | points | integer | Team points: the final score (the capture banks finished games only). |
#'   | seconds_played | integer | Summed playing time of all the team's players in seconds (12000 = 5 x 40:00; 13500 with one overtime). |
#'   | field_goals_made_total | integer | Field goals made, 2PT + 3PT. |
#'   | field_goals_attempted_total | integer | Field goals attempted, 2PT + 3PT. |
#'   | field_goals_made_2pt | integer | Two-point field goals made. |
#'   | field_goals_attempted_2pt | integer | Two-point field goals attempted. |
#'   | field_goals_made_3pt | integer | Three-point field goals made. |
#'   | field_goals_attempted_3pt | integer | Three-point field goals attempted. |
#'   | free_throws_made | integer | Free throws made by the team in the game (count). |
#'   | free_throws_attempted | integer | Free throws attempted by the team in the game (count). |
#'   | offensive_rebounds | integer | Team offensive rebounds in the game (count). |
#'   | defensive_rebounds | integer | Team defensive rebounds in the game (count). |
#'   | total_rebounds | integer | Team rebounds, offensive + defensive (count). |
#'   | assists | integer | Team assists in the game (count). |
#'   | steals | integer | Team steals in the game (count). |
#'   | blocks | integer | Blocks made by the team in the game (count). |
#'   | blocks_received | integer | Shots of this team that were blocked. |
#'   | turnovers | integer | Team turnovers in the game (count). |
#'   | fouls | integer | Fouls committed. |
#'   | fouls_on | integer | Fouls drawn (fouls committed on this team). |
#'   | efficiency | integer | Team efficiency rating (Efektyvumas), a PIR-style index (points + rebounds + assists + steals + blocks + fouls drawn - missed shots - turnovers - shots blocked - fouls). The exact formula is unverified: game 11590 home gives 121 where that formula gives 122. |
#'   | points_off_turnovers | integer | Points off the opponent's turnovers; 0 on the 2007-08 sample (not tracked then). |
#'   | fast_break_points | integer | Fast-break points; 0 on the 2007-08 sample. |
#'   | second_chance_points | integer | Second-chance points (after an offensive rebound); 0 on the 2007-08 sample. |
#'   | points_in_paint | integer | Points in the paint; 0 on the 2007-08 sample. |
#'   | bench_points | integer | Points by players who did not start. |
#'   | biggest_lead | integer | This team's biggest lead in points (0 when it never led). |
#'   | biggest_scoring_run | integer | This team's longest unanswered scoring run, in points. |
#'   | lead_changes | integer | Lead changes in the game (the same value on both rows). |
#'   | tie_results | integer | Times the score was tied (the same value on both rows). |
#'   | time_leading | integer | Seconds this team led during the game (the site sends it as a string; 1892 = 31:32). |
#'   | field_goals_percentage | double | Field-goal percentage, 0-100 float (the site sends a two-decimal string). |
#'   | field_goals_2pt_percentage | double | Two-point percentage, 0-100 float (the site sends a two-decimal string). |
#'   | field_goals_3pt_percentage | double | Three-point percentage, 0-100 float (the site sends a two-decimal string). |
#'   | free_throws_percentage | double | Free-throw percentage, 0-100 float (the site sends a two-decimal string). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_team_box(game_id = 11446))
#' }
lkl_team_box <- function(game_id) {
  .lkl_wrap("team_box", game_id, type = "LKL Team Box", call = rlang::current_env())
}

#' @title
#' **LKL Period Scores**
#' @description
#' Points each team scored in each period of a game, overtime included.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per team and period (home first, periods ascending). `points` is the points
#' scored IN the period, not cumulative. `period` 1-4 is regulation (`period_type` `regular`); 5 is the first overtime,
#' 6 the second (`overtime`). A body without period scores gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
#'   | period | integer | Period number: 1-4 regulation, 5 the first overtime, 6 the second. |
#'   | period_type | character | regular for periods 1-4, overtime from period 5. |
#'   | points | integer | Points the team scored IN this period (not cumulative); keyed by period in the site's quarter_scores. |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_period_scores(game_id = 11446))
#' }
lkl_period_scores <- function(game_id) {
  .lkl_wrap("period_scores", game_id, type = "LKL Period Scores", call = rlang::current_env())
}

#' @title
#' **LKL Summary**
#' @description
#' Summary tab: the head-to-head comparison of both teams (shooting, rebounds, assists, bench points...).
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/summary/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per comparison line (up to 14), home and away side by side. `label` is the
#' site's Lithuanian text and `stat` its English code (null for a label this package does not know). Shooting lines
#' have a `"made/attempted"` `*_value` string and a `*_percentage` (0-100 float, the site's `"46.7%"`); counting lines
#' have an integer-valued string and no percentage. `*_graph_length` is the bar length for the chart and `*_winning`
#' marks the side that leads the line. `group` is null here (the flat list has no groups; `lkl_game_stats` labels
#' them). The summary also repeats `gameStatistics` (use `lkl_team_box`), four leader categories (use `lkl_leaders`)
#' and a broadcasts HTML string, which is not parsed. A body without a comparison gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | group | character | Always null here: the flat comparison list has no groups (lkl_game_stats labels them). |
#'   | stat | character | English code for the site's Lithuanian label (field_goals, two_pointers, three_pointers, free_throws, rebounds, assists, steals, blocks, turnovers, fouls, points, ...); null for a label this package does not know. |
#'   | label | character | Row label in LITHUANIAN: 'Metimai is zaidimo' = field goals, 'Dvitaskiai metimai' = 2PT, 'Tritaskiai metimai' = 3PT, 'Baudu metimai' = free throws, 'Atkovoti kamuoliai' = rebounds, 'Atkovoti kamuoliai gynyboje' = defensive rebounds, 'Atkovoti kamuoliai puolime' = offensive rebounds, 'Rezultatyvus perdavimai' = assists, 'Perimti kamuoliai' = steals, 'Blokai' = blocks, 'Klaidos' = turnovers, 'Prazangos' = fouls, 'Taskai' = points, 'Taskai po klaidu' = points off turnovers, 'Taskai greitose atakose' = fast-break points, 'Taskai antru bandymu' = second-chance points, 'Atsarginiu zaideju taskai' = bench points. |
#'   | home_value | character | Shooting rows: 'made/attempted' string ('25/35'); counting rows: integer. |
#'   | home_percentage | double | Shooting rows only (absent on counting rows): percentage with ONE decimal and a % sign ('71.4%'). |
#'   | home_graph_length | double | Bar length in percent: shooting rows = the percentage as a string ('71.4'); counting rows = this side's share of the two values, 0-100, a number (43 vs 37 -> 53.75). |
#'   | home_winning | logical | True when this side's bar is highlighted as the better one (both false on a tie). |
#'   | away_value | character | Shooting rows: 'made/attempted' string ('25/35'); counting rows: integer. |
#'   | away_percentage | double | Shooting rows only (absent on counting rows): percentage with ONE decimal and a % sign ('71.4%'). |
#'   | away_graph_length | double | Bar length in percent: shooting rows = the percentage as a string ('71.4'); counting rows = this side's share of the two values, 0-100, a number (43 vs 37 -> 53.75). |
#'   | away_winning | logical | True when this side's bar is highlighted as the better one (both false on a tie). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_summary(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_summary <- function(game_id) {
  .lkl_wrap("summary", game_id, type = "LKL Summary", call = rlang::current_env())
}

#' @title
#' **LKL Game Score**
#' @description
#' Score line of a game: both scores and the clock text.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/game-score/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row: the two scores and the clock text. The clock is NOT a state flag: an old
#' game keeps `'1 KELINYS - 10:00'` after the final, and a finished overtime game reads `'1 pratesimas - 00:00'`. A
#' body without scores gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | home_score | integer | Home team points on the score line. |
#'   | away_score | integer | Away team points on the score line. |
#'   | clock | character | Clock text, NOT a state flag: an old game keeps '1 KELINYS - 10:00' after the final; a finished overtime game reads '1 pratesimas - 00:00'. |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_game_score(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_game_score <- function(game_id) {
  .lkl_wrap("game_score", game_id, type = "LKL Game Score", call = rlang::current_env())
}

#' @title
#' **LKL Game Stats**
#' @description
#' Statistics tab: the head-to-head comparison of both teams, one row per statistic.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/game-stats/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per line of `comparison.all`, with the same columns as `lkl_summary`. `group`
#' marks the lines the tab also shows in its `shooting` (2PT, 3PT, free throws) and `main` (rebounds, assists, steals)
#' bar groups; it is null for the rest. A 2007-08 game has only a few lines and a flat lead chart (no event data then).
#' A body without a comparison gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | group | character | Bar group the tab also shows the line in: shooting (2PT, 3PT, free throws) or main (rebounds, assists, steals); null for lines only in the full list. |
#'   | stat | character | English code for the site's Lithuanian label (field_goals, two_pointers, three_pointers, free_throws, rebounds, assists, steals, blocks, turnovers, fouls, points, ...); null for a label this package does not know. |
#'   | label | character | Row label in LITHUANIAN: 'Metimai is zaidimo' = field goals, 'Dvitaskiai metimai' = 2PT, 'Tritaskiai metimai' = 3PT, 'Baudu metimai' = free throws, 'Atkovoti kamuoliai' = rebounds, 'Atkovoti kamuoliai gynyboje' = defensive rebounds, 'Atkovoti kamuoliai puolime' = offensive rebounds, 'Rezultatyvus perdavimai' = assists, 'Perimti kamuoliai' = steals, 'Blokai' = blocks, 'Klaidos' = turnovers, 'Prazangos' = fouls, 'Taskai' = points, 'Taskai po klaidu' = points off turnovers, 'Taskai greitose atakose' = fast-break points, 'Taskai antru bandymu' = second-chance points, 'Atsarginiu zaideju taskai' = bench points. |
#'   | home_value | character | Shooting rows: 'made/attempted' string ('25/35'); counting rows: integer. |
#'   | home_percentage | double | Shooting rows only (absent on counting rows): percentage with ONE decimal and a % sign ('71.4%'). |
#'   | home_graph_length | double | Bar length in percent: shooting rows = the percentage as a string ('71.4'); counting rows = this side's share of the two values, 0-100, a number (43 vs 37 -> 53.75). |
#'   | home_winning | logical | True when this side's bar is highlighted as the better one (both false on a tie). |
#'   | away_value | character | Shooting rows: 'made/attempted' string ('25/35'); counting rows: integer. |
#'   | away_percentage | double | Shooting rows only (absent on counting rows): percentage with ONE decimal and a % sign ('71.4%'). |
#'   | away_graph_length | double | Bar length in percent: shooting rows = the percentage as a string ('71.4'); counting rows = this side's share of the two values, 0-100, a number (43 vs 37 -> 53.75). |
#'   | away_winning | logical | True when this side's bar is highlighted as the better one (both false on a tie). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_game_stats(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_game_stats <- function(game_id) {
  .lkl_wrap("game_stats", game_id, type = "LKL Game Stats", call = rlang::current_env())
}

#' @title
#' **LKL Lead Chart**
#' @description
#' Lead chart of a game: the score margin at each chart point of each period.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/game-stats/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per chart point, periods ascending and points in clock order. `diff` is home
#' minus away (signed); `score_home` / `score_away` are the cumulative scores (the site sends strings); `clock` is the
#' clock REMAINING as the site's `mm:ss:00` text (a trailing `:00`; `10:00:00` is the period start); `column_height` is
#' the bar height (`abs(diff) / maxDiff x 50`). A 2007-08 game has a flat chart (no event data then). A body without
#' `leads` gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | period | integer | Period number: 1-4 regulation, 5 the first overtime, 6 the second. |
#'   | diff | integer | Home minus away score at that chart point (signed integer). |
#'   | clock | character | Clock REMAINING in the period as the site's 'mm:ss:00' text (a trailing ':00'): '10:00:00' is the period start. |
#'   | score_home | integer | Home cumulative score at that point (the site sends a string). |
#'   | score_away | integer | Away cumulative score at that point (the site sends a string). |
#'   | column_height | double | Bar height for the site's chart: abs(diff) / maxDiff x 50 (percent of the chart). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_lead_chart(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_lead_chart <- function(game_id) {
  .lkl_wrap("lead_chart", game_id, type = "LKL Lead Chart", call = rlang::current_env())
}

#' @title
#' **LKL Leaders**
#' @description
#' Leaders tab: each team's top players in points, rebounds, assists, efficiency, steals and blocks.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/leaders/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per team, category and ranked player. `category` is points, total_rebounds,
#' assists, efficiency, steals or blocks; `category_label` the site's Lithuanian label. `rank` 1 is the category leader
#' and 2 and up are the runners-up, in the order the site lists them (up to 4 a side). `player_slug` is the site's key
#' and `player_id` is resolved through the game roster the runtime stamps (null on a body without the stamp). A body
#' without leaders gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | category | character | Leader category: points, total_rebounds, assists, efficiency, steals or blocks. |
#'   | category_label | character | Category label in Lithuanian ('Pelnomi taskai' = points scored, 'Naudingumas' = efficiency rating). |
#'   | team_side | character | Side of the game the row belongs to: home or away (the game page's teams_info side; the box score, leaders and plays say home / away, and gameStatistics is keyed by team id so the runtime supplies the side). |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | rank | integer | Place in the team's category list: 1 = the category leader, 2 and up = the runners-up in the order the site lists them (up to 4). |
#'   | player | character | Player name as the site prints it in this route (the box score short form 'I. Surname', other routes the full name). |
#'   | player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
#'   | player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
#'   | value | integer | The player's count in the row's category. |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_leaders(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_leaders <- function(game_id) {
  .lkl_wrap("leaders", game_id, type = "LKL Leaders", call = rlang::current_env())
}

#' @title
#' **LKL Play-by-Play**
#' @description
#' Play-by-play of a finished game (2024-25 onward), oldest first, with the running score and the lkl.lt player id.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/play-by-play/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per play, chronological (the site lists them newest first, per period).
#' `event_num` is a 1-based sequence the parser assigns. `period` of a regulation line is its quarter; the site gives
#' overtime lines as one merged list without a period, so the parser DERIVES the overtime number (the oldest overtime
#' is 5; each `period` / `end` line closes one): checked on a one-overtime game only, so a multi-overtime game's
#' numbering is unverified. `clock` is the time REMAINING (`mm:ss`) and `clock_seconds` the same in seconds. `type` /
#' `subtype` are English codes, `description` the site's Lithuanian phrase. `score_home` / `score_away` are the running
#' score AFTER the play on every line. Team, period and game lines have no player. `player_id` is resolved through the
#' game roster the runtime stamps. The site charts play-by-play from 2024-25 on. A body without plays gives a zero-row
#' tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | event_num | integer | Play sequence number the parser assigns, 1 = the first play of the game (the site lists plays newest first per period, with no id). |
#'   | period | integer | Period of the play. Regulation lines carry it in the site's body; overtime lines come as one merged list without it, so the parser derives it (oldest overtime = 5, each period-end line closes one): checked on a one-overtime game only, so multi-overtime numbering is unverified. |
#'   | period_type | character | regular for periods 1-4, overtime from period 5. |
#'   | clock | character | Game clock REMAINING in the period as 'mm:ss' (it counts down from 10:00, from 05:00 in overtime). |
#'   | clock_seconds | integer | The clock REMAINING as whole seconds (08:34 = 514), derived by the parser. |
#'   | team_side | character | Side of the acting team (the line's is_home flag): home or away. |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | player | character | Player name as the site prints it in this route (the box score short form 'I. Surname', other routes the full name). |
#'   | player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
#'   | player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
#'   | type | character | Event type (English code): 2pt, 3pt, freethrow, rebound, assist, steal, block, turnover, foul, foulon (foul drawn), substitution, timeout, jumpball, headcoachchallenge, period, game. |
#'   | subtype | character | Event subtype (English code; '' when none). 2pt/3pt: shot kind (jumpshot, layup, drivinglayup, reverselayup, dunk, alleyoop, alleyoopdunk, tipinlayup, tipindunk, hookshot, fadeaway, floatingjumpshot, pullupjumpshot, stepbackjumpshot, turnaroundjumpshot, eurostep). freethrow: 'NofM' = attempt N of M (1of1, 1of2, 2of2, 1of3, 2of3, 3of3). rebound: offensive / defensive. foul: personal, offensive, technical, benchTechnical. turnover: badpass, ballhandling, offensive, outofbounds, travel, backcourt (backcourt violation), 3sec, 24sec. substitution: in / out. timeout: full (team), officials. jumpball: startperiod, won, lost, heldball. headcoachchallenge: the challenged call (foul, outofbounds). period / game: start, end. |
#'   | description | character | Event text in Lithuanian, one fixed phrase per type and subtype ('3 tasku metimas pataikytas' = 3-point shot made). |
#'   | success | logical | Shots and free throws: true = made. Every other type: always true. |
#'   | is_points_info | logical | True on lines that changed the score (made shots and free throws). |
#'   | score_home | integer | Home points after the play (on every line, not only scoring lines). |
#'   | score_away | integer | Away points after the play (on every line, not only scoring lines). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_pbp(game_id = 11446))
#' }
lkl_pbp <- function(game_id) {
  .lkl_wrap("pbp", game_id, type = "LKL Play-by-Play", call = rlang::current_env())
}

#' @title
#' **LKL Shots**
#' @description
#' Every field-goal attempt of a finished game (2024-25 onward) with its court position (Genius LiveStats data).
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/shot-chart/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per attempt (free throws are not charted), periods ascending. The data is
#' Genius LiveStats'. `x` is the percent (0-100) of the court LENGTH from the left baseline of a horizontal full court
#' (baskets near 5 and 95) and `y` the percent of the WIDTH (baskets at 50); metres are `x / 100 x 28` and `y / 100 x
#' 15`, an inference. Which sideline is `y` 0 is unverified. `side` is the basket half (`LEFT` = x < 50) except
#' backcourt heaves, and teams switch baskets at half-time, so normalise to one basket before plotting. `area` is a
#' zone code, `left` / `right` from the shooter's view. The shooter is named by `player_id` (lkl.lt persons);
#' `player_slug` is the reverse lookup through the runtime's roster (null on a body without the stamp). The site charts
#' shots from 2024-25 on. A body without shots gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | shot_id | integer | Shot event id (key space: lkl.lt shot events, increasing over time); joins nothing else and is not the Genius action number. |
#'   | period | integer | Period number: 1-4 regulation, 5 the first overtime, 6 the second. |
#'   | period_type | character | regular for periods 1-4, overtime from period 5. |
#'   | team_side | character | Side of the shooter's team (the line's is_home flag): home or away. |
#'   | team_id | integer | lkl.lt team id (key space: lkl.lt clubs, STABLE across seasons and renamings: 6 = Rytas). Joins lkl_game_info home_team_id / away_team_id; not the Genius team id. Null on a frame parsed from a bare body. |
#'   | player_id | integer | lkl.lt player id (key space: lkl.lt persons, stable across seasons). Resolved from the player slug through the game roster the runtime stamps from the game page; null on a bare body or a slug the roster lacks. |
#'   | player_slug | character | lkl.lt player slug (key space: lkl.lt persons; the `{slug}` of lkl.lt/zaidejai/`{slug}`, stable across seasons). Join key to lkl_game_players.slug. |
#'   | type | character | 2pt or 3pt (free throws are not in the chart). |
#'   | made | logical | True when the shot was made, false when missed. |
#'   | x | double | Court x position: percent (0-100) of the LENGTH of a horizontal full court from the left baseline (baskets near 5 and 95). Teams switch baskets at half-time; metres (x / 100 x 28) are an inference. |
#'   | y | double | Court y position: percent (0-100) of the court WIDTH (baskets at 50). Metres (y / 100 x 15) are an inference; which sideline is y = 0 is unverified. |
#'   | side | character | Basket half the shot is at: LEFT (x < 50) or RIGHT, except backcourt heaves (area backcourt). |
#'   | area | character | Court zone code (e.g. inthepaint, underbasket, outsideleft); left and right are from the shooter's view, so zones are point-symmetric between the two baskets. |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_shots(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_shots <- function(game_id) {
  .lkl_wrap("shots", game_id, type = "LKL Shots", call = rlang::current_env())
}

#' @title
#' **LKL Results**
#' @description
#' Every played game of one LKL season (all pages of the site's results list, merged), newest first.
#'
#' Endpoint: `GET https://lkl.lt/loadResults`
#' @param season Required. Season END year (2026 = the 2025-26 season). The site keys a season by two opaque ids (a
#' results id and a standings id, neither a year); the runtime reads them from the site's season selects by the label
#' `YYYY-YYYY m. sezonas`. A year the selects do not list raises `hoopR_no_data`.
#' @return A `hoopR_data` tibble. One row per played game, in the site's order (newest first). `season_end_year` is the
#' END year of the season (2026 = 2025-26) and `season_id` the site's opaque results-season id (from 2016-17 it is the
#' Genius LiveStats competition id). Teams are given by slug, code and name only (no team id); map a slug to `team_id`
#' with `lkl_game_info`. `time` is the Lithuanian local tip-off `HH:MM`. `winner_highlighted` is the side whose score
#' the page shows in bold. Played games only; the unplayed schedule is not wrapped. A record without games gives a
#' zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season_id | integer | Results season id (key space: lkl.lt championships; LKL 2026-27 = 49436). From 2016-17 it is the Genius LiveStats competition id (leagueId 110). |
#'   | season_end_year | integer | Season END year (2026 = 2025-26), read from the season label 'YYYY-YYYY m. sezonas'. |
#'   | game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
#'   | date | Date | Game date from the site's Lithuanian day header; checked to fall in the season (Aug 1 - Jul 31). |
#'   | weekday | character | Weekday of the header, translated to English ('sestadienis' -> 'Saturday'). |
#'   | time | character | Tip-off 'HH:MM', Europe/Vilnius. |
#'   | arena | character | Arena name ('Arena dar nezinoma' = arena not yet known, on some 2007-08 games). |
#'   | city | character | City, from 'Arena , City'; null when the venue line has no city (2007-08 'Arena dar nezinoma'). |
#'   | home_slug | character | Home team: Team slug (key space: lkl.lt clubs; the `{slug}` of https://lkl.lt/komandos/`{slug}`; one per club, stable across renamings: 'rytas' for Lietuvos Rytas / Rytas). The results and standings rows carry only this; the game page teams_info gives slug + id. |
#'   | home_code | character | Home three-letter team code ('LIE'). |
#'   | home_name | character | Home team name as printed (the logo alt text; the CURRENT club name even on old games: 2007-08 'Rytas'). |
#'   | home_score | integer | Home team points in the game (the final score). |
#'   | away_slug | character | Away team: Team slug (key space: lkl.lt clubs; the `{slug}` of https://lkl.lt/komandos/`{slug}`; one per club, stable across renamings: 'rytas' for Lietuvos Rytas / Rytas). The results and standings rows carry only this; the game page teams_info gives slug + id. |
#'   | away_code | character | Away three-letter team code. |
#'   | away_name | character | Away team name as printed. |
#'   | away_score | integer | Away team points in the game (the final score). |
#'   | winner_highlighted | character | Which side's score the page sets in bold: home or away (the winner). |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_results(season = 2026))
#' }
lkl_results <- function(season) {
  .lkl_wrap("results", season, type = "LKL Results", call = rlang::current_env())
}

#' @title
#' **LKL Standings**
#' @description
#' League table of one LKL season: overall, home and away records, and the final ranking once it is set.
#'
#' Endpoint: `GET https://lkl.lt/loadStandings/{season}`
#' @param season Required. Season END year (2026 = the 2025-26 season). The site keys a season by two opaque ids (a
#' results id and a standings id, neither a year); the runtime reads them from the site's season selects by the label
#' `YYYY-YYYY m. sezonas`. A year the selects do not list raises `hoopR_no_data`.
#' @return A `hoopR_data` tibble. One row per team and table. `table` is `full` (overall: with `win_pct` and `streak`),
#' `home` and `away` (the same record split by venue) or `final` (the final ranking: position and team only, empty
#' until the season is over and for old seasons). `win_pct` is 0-100, null when the site shows `-` (2007-08). `streak`
#' is a signed integer as the site prints it; its sign convention is unverified. `points_for_avg` /
#' `points_against_avg` are per-game averages. `last5` is the last results as `W` / `L` letters in the order rendered
#' (oldest first, unverified). `season_id` is the site's standings-season id, a different key space from the results
#' id. Team slugs join `lkl_results`. A record without tables gives a zero-row tibble.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season_id | integer | STANDINGS season id (a separate small key space: 35 = 2026-27, 1 = 2016-17, 24 = 1993-94); NOT the results season id. |
#'   | season_end_year | integer | Season END year (2026 = 2025-26), read from the season label 'YYYY-YYYY m. sezonas'. |
#'   | table | character | Which table the row comes from: full (overall), home, away or final (the final ranking). |
#'   | position | integer | Rank in the table (Poz.); in the final table the final place. |
#'   | team_slug | character | Team slug (key space: lkl.lt clubs; the `{slug}` of https://lkl.lt/komandos/`{slug}`; one per club, stable across renamings: 'rytas' for Lietuvos Rytas / Rytas). The results and standings rows carry only this; the game page teams_info gives slug + id. |
#'   | team_name | character | Team name as printed for that season ('Lietuvos Rytas' in 2007-08). |
#'   | played | integer | Games played (Rng., rungtynes); null in the final table. |
#'   | won | integer | Wins (Per., pergales); null in the final table. |
#'   | lost | integer | Losses (Pr., pralaimejimai); null in the final table. |
#'   | win_pct | double | Win percentage 0-100 (Laim.%); null in the home, away and final tables and when the site prints '-' (2007-08). |
#'   | streak | integer | Current streak (Serija) as a signed integer: 27 = 27 wins in a row, -1 = one loss. Null outside the full table. |
#'   | points_for_avg | double | Points scored per game (first number of Tsk. vid.); null in the final table. |
#'   | points_against_avg | double | Points allowed per game (second number of Tsk. vid.); null in the final table. |
#'   | last5 | character | Last five results (Paskutines 5) as W / L letters in the order the page renders them, left to right; fewer than five early in a season; null in the final table. |
#'
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_standings(season = 2026))
#' }
lkl_standings <- function(season) {
  .lkl_wrap("standings", season, type = "LKL Standings", call = rlang::current_env())
}
