# **FIBA GAMEPAGE: box players**

Player box score of one FIBA game.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_box_players(game_id, comp, return_parsed = TRUE)
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
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| player_id | integer | FIBA person id (Int64), global across competitions and roles: the page's P\_`<id>`, play-by-play pId, roster personId and fiba_gdap_roster.player_id. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name as registered with FIBA. |
| jersey | character | Jersey number as a string. |
| position | character | Playing position code from the lineup card (PG, SG, SF, PF, C). |
| is_captain | logical | True for the team captain. |
| is_starter | logical | True for the starting five. |
| has_played | logical | True when the player got on the court. |
| minutes | character | Minutes played as an 'm:ss' string ('0:0' = did not play). |
| seconds_played | integer | Seconds played, derived from minutes. |
| points | integer | Points scored in the game. |
| fg_made | integer | Field goals made (2 + 3 points). |
| fg_attempted | integer | Field goals attempted (2 + 3 points). |
| fg_pct | double | Field-goal percentage, 0-100. |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| fg2_pct | double | Two-point field-goal percentage, 0-100. |
| fg3_made | integer | Three-point field goals made. |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg3_pct | double | Three-point field-goal percentage, 0-100. |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| ft_pct | double | Free-throw percentage, 0-100. |
| reb_offensive | integer | Offensive rebounds. |
| reb_defensive | integer | Defensive rebounds. |
| reb_total | integer | Total rebounds (a team row includes the team rebounds team_reb_total). |
| assists | integer | Assists credited in the game. |
| steals | integer | Steals credited in the game. |
| blocks | integer | Blocked shots (blocks made). |
| blocks_received | integer | Own shots blocked by the opponent (blocks received). |
| turnovers | integer | Turnovers (a team row includes the team turnovers team_turnovers). |
| fouls | integer | Personal fouls (a team row includes the team fouls team_fouls). |
| fouls_drawn | integer | Fouls drawn in the game. |
| paint_fg_made | integer | Field goals made in the paint (team points_in_paint = 2 x paint_fg_made on every sampled game). |
| paint_fg_attempted | integer | Field goals attempted in the paint. |
| paint_fg_pct | double | Field-goal percentage in the paint, 0-100. |
| efficiency | integer | Efficiency (FIBA EFF: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers). |
| plus_minus | integer | Plus/minus: the team's point differential while the player was on the court. |
| cb | logical | Boolean flag, false on every sampled player; meaning unverified. |

## Details

FIBA's terms restrict this source. The GDAP developer-portal terms limit
API use to 'Authorized Users' (federations, organisers, FIBA partners)
and say any broader use 'is not authorised'; the fiba.basketball terms
say no portion of the site may be duplicated, redistributed or
manipulated. Users who are not themselves authorised by FIBA should
check the terms before using the wrappers.

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
The page request sends a browser User-Agent (sportsdataverse-py answers
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
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md),
[`fiba_gamepage_lineup()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_lineup.md),
[`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md),
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
  try(fiba_gamepage_box_players(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_box_players from fiba.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:30:02 UTC
#> # A tibble: 24 × 43
#>    game_id competition_id team_side organisation_id player_id first_name
#>      <int>          <int> <chr>               <int>     <int> <chr>     
#>  1  100720         208182 A                      64    204689 David     
#>  2  100720         208182 A                      64    196287 Andreas   
#>  3  100720         208182 A                      64    198299 Johannes  
#>  4  100720         208182 A                      64    269000 Justus    
#>  5  100720         208182 A                      64    189145 Dennis    
#>  6  100720         208182 A                      64    210175 Moritz    
#>  7  100720         208182 A                      64    181996 Daniel    
#>  8  100720         208182 A                      64    227403 Franz     
#>  9  100720         208182 A                      64    188677 Johannes  
#> 10  100720         208182 A                      64    155956 Niels     
#> # ℹ 14 more rows
#> # ℹ 37 more variables: last_name <chr>, jersey <chr>, position <chr>,
#> #   is_captain <lgl>, is_starter <lgl>, has_played <lgl>, minutes <chr>,
#> #   seconds_played <int>, points <int>, fg_made <int>, fg_attempted <int>,
#> #   fg_pct <dbl>, fg2_made <int>, fg2_attempted <int>, fg2_pct <dbl>,
#> #   fg3_made <int>, fg3_attempted <int>, fg3_pct <dbl>, ft_made <int>,
#> #   ft_attempted <int>, ft_pct <dbl>, reb_offensive <int>, …
# }
```
