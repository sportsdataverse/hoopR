# **Get BBL / DBBL Games**

Games of a season (the whole season in one page): teams, score by
period, officials, venue and top scorer.

Endpoint: `GET https://api.basketball-bundesliga.de/games` (DBBL: the
same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_games(
  league = "bbl",
  season = NULL,
  competition = NULL,
  game_type = NULL,
  team_id = NULL,
  page_size = 500
)
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- season:

  (default `NULL`) Season END year (2026 = 2025-26, the sdv key). Sent
  to the API as its START-year seasonId (season - 1). Omitted = the
  season in progress.

- competition:

  (default `NULL`) Competition filter: BBL, BBL_CUP (Pokal), ALLSTAR,
  CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host.
  Omitted = all. The other host's competition answers an empty page.

- game_type:

  (default `NULL`) Finished, scheduled or all games. Omitted = all.

- team_id:

  (default `NULL`) Only the games of this team, home or guest (the club
  id equals the season-team id).

- page_size:

  (default `500`) Rows per page. The wrapper reads page 1 and refuses a
  result that needs more pages, so keep it large enough for the whole
  result (500 covers a season).

## Value

A `hoopR_data` tibble: Games of a season (the whole season in one page):
teams, score by period, officials, venue and top scorer. An empty valid
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `scb_games`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| game_id | character | Game id, a string; unique within a league only (BBL and DBBL overlap), and not chronological. |
| competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
| stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
| status | character | Game status: PRE (scheduled), LIVE, POST (ended, not yet official), OFFICIAL (final). |
| scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
| match_day | integer | Round number within the stage (Spieltag). |
| is_tbd | logical | Date or time not yet fixed. |
| is_hidden | logical | True when the API hides the game (0/1 on /games, a boolean on the header). |
| home_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| home_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| home_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
| home_tlc | character | Three-letter club code. |
| home_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
| home_rank | integer | The team's current table position. |
| home_streak | character | Current streak: W or L; empty when none. |
| home_streak_count | integer | Length of the current streak. |
| home_last10_victories | integer | Wins in the last 10 games. |
| home_last10_losses | integer | Losses in the last 10 games. |
| home_total_games | integer | Games the home team has played so far (the API sends it as a string). |
| guest_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
| guest_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| guest_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
| guest_tlc | character | Three-letter club code. |
| guest_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
| guest_rank | integer | The team's current table position. |
| guest_streak | character | Current streak: W or L; empty when none. |
| guest_streak_count | integer | Length of the current streak. |
| guest_last10_victories | integer | Wins in the last 10 games. |
| guest_last10_losses | integer | Losses in the last 10 games. |
| guest_total_games | integer | Games the guest team has played so far (the API sends it as a string). |
| home_score | integer | Home team final score. |
| guest_score | integer | Guest team final score. |
| latest_period | integer | Number of the last period played (4 = Q4, 5 = OT1, ...); the API sends `Q4` on /games and 4 on /games/recent. Null before the game. |
| spectators | integer | Attendance; 0 when not recorded. |
| home_q1_score | integer | Home team points in quarter 1; 0 when quarter scores were not recorded. |
| home_q2_score | integer | Home team points in quarter 2; 0 when quarter scores were not recorded. |
| home_q3_score | integer | Home team points in quarter 3; 0 when quarter scores were not recorded. |
| home_q4_score | integer | Home team points in quarter 4; 0 when quarter scores were not recorded. |
| home_ot1_score | integer | Home team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
| home_ot2_score | integer | Home team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
| home_ot3_score | integer | Home team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
| home_ot4_score | integer | Home team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
| home_ot5_score | integer | Home team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
| home_ot6_score | integer | Home team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
| home_ot7_score | integer | Home team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
| home_ot8_score | integer | Home team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
| home_ot9_score | integer | Home team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
| guest_q1_score | integer | Guest team points in quarter 1; 0 when quarter scores were not recorded. |
| guest_q2_score | integer | Guest team points in quarter 2; 0 when quarter scores were not recorded. |
| guest_q3_score | integer | Guest team points in quarter 3; 0 when quarter scores were not recorded. |
| guest_q4_score | integer | Guest team points in quarter 4; 0 when quarter scores were not recorded. |
| guest_ot1_score | integer | Guest team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
| guest_ot2_score | integer | Guest team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
| guest_ot3_score | integer | Guest team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
| guest_ot4_score | integer | Guest team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
| guest_ot5_score | integer | Guest team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
| guest_ot6_score | integer | Guest team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
| guest_ot7_score | integer | Guest team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
| guest_ot8_score | integer | Guest team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
| guest_ot9_score | integer | Guest team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
| referee1_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
| referee1_first_name | character | Official's given name. |
| referee1_last_name | character | Official's family name. |
| referee2_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
| referee2_first_name | character | Official's given name. |
| referee2_last_name | character | Official's family name. |
| referee3_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
| referee3_first_name | character | Official's given name. |
| referee3_last_name | character | Official's family name. |
| commissioner_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
| commissioner_first_name | character | Official's given name. |
| commissioner_last_name | character | Official's family name. |
| venue_id | character | Arena id, stable across seasons (Uber Arena = 2 in both 2025-26 and 2026-27); a different key space from /teams `seasonVenues.id`, and no captured route is keyed by it. A string in /games and `/games/{gameId}`, an integer in /games/recent. |
| venue_name | character | Name of the arena the game is played in; `venue_id` is its stable arena id. |
| venue_address | character | Postal address, German. |
| venue_capacity | integer | Arena capacity, spectators. |
| venue_is_main | logical | The club's main arena. |
| tv_channel | character | TV channel(s) showing the game, comma-joined (a list on some routes, an empty string when none). |
| tv_type | character | TV coverage type; empty or null in every sample. |
| is_free_tv | logical | Shown on free-to-air TV. |
| live_stream_url | character | Live-stream link (DBBL games link YouTube); empty when none. |
| top_score | integer | Points of the game's top scorer; null before the game. |
| top_scorer_season_player_id | character | Season-player id. BBL: a string equal to `id`. DBBL: an INTEGER that matches `/seasons/{seasonId}` `seasonPlayerId` (5 of 5 rows checked, 2026-27). Joins to `/season-players/{seasonPlayerId}`. |
| top_scorer_real_player_id | character | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| top_scorer_first_name | character | Player's given name. |
| top_scorer_last_name | character | Player's family name. |

## Details

- Unofficial use of a public source: these wrappers read the front-end
  API of the German Bundesliga sites (easycredit-bbl.de,
  toyota-dbbl.de), run by SCB; payloads are not redistributed as release
  assets.

- Legal notice: the BBL Impressum forbids storing BBL content
  (`Inhalte`) in an information system without BBL's written permission.
  That is a copyright term, not a robots rule (the API host has no
  robots.txt). The owner reviewed it and accepted the intake (2026-10-12
  ruling); keep requests slow (the runtime waits at least 1 s per host)
  and raise any published data release with the owner. The DBBL host is
  the same operator and API; its site notice was not separately
  reviewed.

- Both hosts need two headers: a constant `x-api-key` and an
  `x-api-secret` that rotates. The runtime derives the secret on first
  use from the key embedded in an easycredit-bbl.de page (reversed, `:`
  turned into `-`) and never logs or returns it. The derivation was
  reverse-engineered from observed requests and responses and has not
  been checked against the site's own front-end code; if the site
  changes how it signs requests, every call fails with
  `hoopR_asset_fetch`.

- Id key spaces: seasonId is the START year (2025 = 2025-26), so a
  wrapper's END-year `season` is sent as `season - 1`. Teams are keyed
  by teamId (seasonTeamId equals it in every sample). seasonPlayerId is
  per player per season and per club (a player traded mid-season has
  two); realPlayerId is the person. playerId is ambiguous (the
  seasonPlayerId in box scores, records and /season-players; the person
  in /transfers). Game ids are strings.

- Errors are classed conditions: `hoopR_no_data` (404, 204, a 400 "not a
  valid" id, no rows, a box score of a game not yet started),
  `hoopR_bad_request` (a bad argument, another 400 / 422) and
  `hoopR_asset_fetch` (a refused secret after one re-derive, any other
  non-2xx, an HTML / non-JSON / error-shaped body, a truncated page, a
  body for another game, season, club or league, a box score still in
  play), all inheriting `hoopR_error`. Wrappers raise; they never return
  an empty frame.

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
[`scb_game_teams()`](https://hoopR.sportsdataverse.org/reference/scb_game_teams.md),
[`scb_games_recent()`](https://hoopR.sportsdataverse.org/reference/scb_games_recent.md),
[`scb_player_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_player_statistics.md),
[`scb_playoff_games()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_games.md),
[`scb_playoff_series()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_series.md),
[`scb_records_per_game()`](https://hoopR.sportsdataverse.org/reference/scb_records_per_game.md),
[`scb_records_season_averages()`](https://hoopR.sportsdataverse.org/reference/scb_records_season_averages.md),
[`scb_referees()`](https://hoopR.sportsdataverse.org/reference/scb_referees.md),
[`scb_season_player()`](https://hoopR.sportsdataverse.org/reference/scb_season_player.md),
[`scb_season_players()`](https://hoopR.sportsdataverse.org/reference/scb_season_players.md),
[`scb_season_teams()`](https://hoopR.sportsdataverse.org/reference/scb_season_teams.md),
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md),
[`scb_standings()`](https://hoopR.sportsdataverse.org/reference/scb_standings.md),
[`scb_team()`](https://hoopR.sportsdataverse.org/reference/scb_team.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)

## Examples

``` r
# \donttest{
  try(scb_games())
#> ── BBL/DBBL Games from the SCB API ───────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:01:44 UTC
#> # A tibble: 321 × 89
#>    league season season_id game_id competition stage       status scheduled_time
#>    <chr>   <int>     <int> <chr>   <chr>       <chr>       <chr>  <chr>         
#>  1 bbl      2027      2026 2006720 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-10T16…
#>  2 bbl      2027      2026 2006724 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-10T18…
#>  3 bbl      2027      2026 2006728 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-11T18…
#>  4 bbl      2027      2026 2006722 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-12T16…
#>  5 bbl      2027      2026 2006721 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-12T18…
#>  6 bbl      2027      2026 2006723 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-13T13…
#>  7 bbl      2027      2026 2006727 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-13T14…
#>  8 bbl      2027      2026 2006725 BBL_CUP     FIRST_ROUND OFFIC… 2026-09-13T16…
#>  9 bbl      2027      2026 2006920 BBL         MAIN_ROUND  OFFIC… 2026-09-18T18…
#> 10 bbl      2027      2026 2006923 BBL         MAIN_ROUND  OFFIC… 2026-09-19T16…
#> # ℹ 311 more rows
#> # ℹ 81 more variables: match_day <int>, is_tbd <lgl>, is_hidden <lgl>,
#> #   home_team_id <chr>, home_season_team_id <chr>, home_team_name <chr>,
#> #   home_tlc <chr>, home_is_foreign <lgl>, home_rank <int>, home_streak <chr>,
#> #   home_streak_count <int>, home_last10_victories <int>,
#> #   home_last10_losses <int>, home_total_games <int>, guest_team_id <chr>,
#> #   guest_season_team_id <chr>, guest_team_name <chr>, guest_tlc <chr>, …
# }
```
