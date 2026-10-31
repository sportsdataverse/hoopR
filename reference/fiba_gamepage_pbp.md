# **FIBA GAMEPAGE: pbp**

Play-by-play of one FIBA game: every action with period, clock, running
score, actor and shot x/y.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_pbp(game_id, comp, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) FIBA game id (global): gameId of a gdap schedule
  row, e.g. 100720 = the World Cup 2023 final.

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). The
  game must belong to it. Find it with fiba_gdap_editions or
  fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list (the game-page objects `game`, `playByPlay`,
  `gameDetails`, `playersTeamA`, `playersTeamB`).

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64), global across competitions: gdapGameId, the `<gameId>` of a game-page URL. |
| competition_id | integer | FIBA competition id (Int64) of the game's edition; the comp argument. |
| statistic_system | character | Live-stats system of the game: OVR (World Cup, Olympics) or FLS (club competitions, most qualifiers); they differ in the play-by-play action ids, order and text. |
| period | character | Period name: Q1..Q4, then OT1, OT2... |
| period_number | integer | 1-based position of the period in the game. |
| action_id | character | Action id (String): '`<n>`:`<seq>`' in OVR games (3:0015), a sequence number in FLS games; unique within the game. |
| order | integer | Sort key within the period (OVR: 1, 2, ...; FLS: 1000, 2000, ...); null on some period events. |
| clock | character | Game clock: time REMAINING in the period, 'm:ss', counting down from 10:00 (5:00 in overtime). |
| clock_seconds | integer | Seconds remaining in the period, derived from clock. |
| wall_time_ms | double | Wall-clock time of the action, Unix epoch milliseconds. (Int64 in sdv-py; numeric here, the values exceed R's 32-bit integer range) |
| score_a | integer | Team A score after the action. |
| score_b | integer | Team B score after the action. |
| action_code | character | Action code: P2 two-point shot, P3 three-point shot, FT free throw, REB rebound, TREB team rebound, ASS assist, ST steal, BS block, TO turnover, TTO team turnover, FOUL foul, RFOUL foul drawn, SUBST substitution, TIMO timeout, plus period events (STARTG, STARTP, ENDP, ENDG). |
| action_family | character | Action family: shot, subst, timeout, periods, and 'unknwown' (FIBA's spelling) for every other action. |
| description | character | English action text ('3pt jump shot missed', 'defensive rebound'); null on most OVR actions. |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| player_id | integer | FIBA person id (Int64), global across competitions and roles: the page's P\_`<id>`, play-by-play pId, roster personId and fiba_gdap_roster.player_id. |
| player2_id | integer | FIBA person id (Int64) of the second player on a substitution; null when the game does not record it (the refs note FLS only, but the Paris 2024 final, an OVR game, carries it and the FLS games sampled leave it null). |
| sub_direction | character | Substitution direction: IN or OUT; null on other actions. |
| made | logical | True when the shot went in (two-pointers, three-pointers and free throws only; null otherwise). |
| points_attempted | integer | Points the attempt was worth (2, 3 or 1), made or not; null on other actions. |
| shot_type | character | Shot type derived from action_code: 2PT, 3PT or FT; null on other actions. |
| shot_x | integer | Shot x, integer pixels on a half-court image across the court width (observed 0-278, basket near x = 139). Present only on shots; free throws are 0. Which sideline is x = 0 and the scale are UNVERIFIED. |
| shot_y | integer | Shot y, integer pixels from the baseline (y = 0) towards midcourt (observed 0-224, basket near y = 25); both teams' shots are drawn on one basket. Free throws are 0. Scale UNVERIFIED. |
| has_location | logical | True when shot_x / shot_y locate the shot (two- and three-pointers); False for free throws (always 0, 0); null on other actions. |

## Details

FIBA's terms restrict this source. The GDAP developer-portal terms limit
API use to 'Authorized Users' (federations, organisers, FIBA partners)
and say any broader use 'is not authorised'; the fiba.basketball terms
say no portion of the site may be duplicated, redistributed or
manipulated. The package owner reviewed both clauses on 2026-10-12,
accepted them and approved the full intake, published data releases
included. Users who are not themselves authorised by FIBA should check
the terms before using the wrappers.

The GDAP subscription key is public (fiba.basketball ships it in every
page); the runtime reads it from the live page at run time and never
logs it. Officials' contact details and coaches' and officials' dates of
birth are dropped from every body.

Id key spaces: competition_id is one per edition (2023 World Cup =
208182) and game_id is global across competitions (the `<gameId>` of a
game-page URL). team_id is per team per competition (Germany is 279569
at the 2023 World Cup and 281545 at Paris 2024), while organisation_id
is the stable federation or club (64 = Germany, every year); the game
page's T\_`<id>` and the play-by-play oId are organisation ids, not team
ids.

The wrapper takes the game id and its competition (comp) and builds the
real page URL from GDAP (the competition's marketing name gives the
history slug, its schedule gives the two team codes; a competition with
an event page is tried at its event URL when the archive URL answers the
not-found shell, and the Champions League host last).

Box scores start about 2006; play-by-play with shot x/y about 2012 (OVR
events) and 2017-18 (FLS club competitions). A game with no box score
raises `hoopR_no_data`; a game still live raises `hoopR_asset_fetch`.
The page request sends a browser User-Agent (sdv-py answers
fiba.basketball's HTTP 403 to plain clients with Chrome TLS; libcurl
with a browser User-Agent was served on 2026-10-18). Shot x/y are image
pixels with an unverified scale.

Errors are classed conditions (all inherit `hoopR_error`):
`hoopR_no_data` when FIBA has nothing (HTTP 404, or GDAP answers
[`{}`](https://rdrr.io/r/base/Paren.html) / `[]` for an unknown id, a
game page with no box score, a listed game whose teams are not drawn
yet); `hoopR_bad_request` for HTTP 400 / 422 or a malformed id, season
or date; `hoopR_asset_fetch` for any other failed fetch or an answer
that is not about the request (an error envelope, HTTP 401 after a key
refresh, HTTP 500, a body for another game, competition, team, player,
federation, family or season, a game of another competition than `comp`,
the HTTP 200 not-found shell of a wrong game page, a live game). Seasons
are FIBA's own key, which equals the sdv key: the END year for club
competitions, the event year for national-team events, the target
tournament year for qualifiers.

## See also

Other FIBA Functions:
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md),
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md),
[`fiba_gamepage_lineup()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_lineup.md),
[`fiba_gamepage_period_scores()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_period_scores.md),
[`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md),
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md),
[`fiba_gdap_competition()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_competition.md),
[`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md),
[`fiba_gdap_federation_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_games.md),
[`fiba_gdap_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_ranking.md),
[`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md),
[`fiba_gdap_game()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game.md),
[`fiba_gdap_game_officials()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_officials.md),
[`fiba_gdap_game_periods()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_periods.md),
[`fiba_gdap_games_between()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_games_between.md),
[`fiba_gdap_gateway_competition_ids()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_competition_ids.md),
[`fiba_gdap_gateway_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_federation_ranking.md),
[`fiba_gdap_medal_count()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_medal_count.md),
[`fiba_gdap_national_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_national_teams.md),
[`fiba_gdap_nominations()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_nominations.md),
[`fiba_gdap_player_game_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_game_stats.md),
[`fiba_gdap_player_info()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_info.md),
[`fiba_gdap_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_stats.md),
[`fiba_gdap_ranking_zones()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_ranking_zones.md),
[`fiba_gdap_roster()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster.md),
[`fiba_gdap_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_coaches.md),
[`fiba_gdap_roster_latest()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_latest.md),
[`fiba_gdap_round_gamedays()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_gamedays.md),
[`fiba_gdap_round_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_standings.md),
[`fiba_gdap_rounds()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_rounds.md),
[`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md),
[`fiba_gdap_team_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_games.md),
[`fiba_gdap_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_player_stats.md),
[`fiba_gdap_team_staff()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_staff.md),
[`fiba_gdap_team_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_stats.md),
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md)

## Examples

``` r
# \donttest{
  try(fiba_gamepage_pbp(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_pbp from fiba.basketball ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:13:05 UTC
#> # A tibble: 497 × 26
#>    game_id competition_id statistic_system period period_number action_id order
#>      <int>          <int> <chr>            <chr>          <int> <chr>     <int>
#>  1  100720         208182 OVR              Q1                 1 0:0002       NA
#>  2  100720         208182 OVR              Q1                 1 3:0012        1
#>  3  100720         208182 OVR              Q1                 1 3:0012B       2
#>  4  100720         208182 OVR              Q1                 1 3:0013        3
#>  5  100720         208182 OVR              Q1                 1 3:0014        4
#>  6  100720         208182 OVR              Q1                 1 3:0015        5
#>  7  100720         208182 OVR              Q1                 1 3:0016        6
#>  8  100720         208182 OVR              Q1                 1 3:0017        7
#>  9  100720         208182 OVR              Q1                 1 3:0018        8
#> 10  100720         208182 OVR              Q1                 1 3:0019        9
#> # ℹ 487 more rows
#> # ℹ 19 more variables: clock <chr>, clock_seconds <int>, wall_time_ms <dbl>,
#> #   score_a <int>, score_b <int>, action_code <chr>, action_family <chr>,
#> #   description <chr>, organisation_id <int>, team_side <chr>, player_id <int>,
#> #   player2_id <int>, sub_direction <chr>, made <lgl>, points_attempted <int>,
#> #   shot_type <chr>, shot_x <int>, shot_y <int>, has_location <lgl>
# }
```
