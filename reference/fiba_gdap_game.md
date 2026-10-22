# **FIBA GDAP: game**

One game's header: teams, score, venue, attendance and status codes (no
box score or play-by-play: see fiba_gamepage).

Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`

## Usage

``` r
fiba_gdap_game(game_id, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) Required. FIBA game id (global GDAP key space):
  gameId of a schedule row; the `<gameId>` of a game page URL

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
| round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
| technical_name | character | Technical game name '`<roundId>`-`<groupPairingCode>`-`<gameNumber>`'. |
| round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
| group_pairing_code | character | Group letter (group play) or pairing number (knockout bracket slot). |
| game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
| status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
| game_day | integer | Game day number within the round. |
| team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
| team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |
| team_a_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_a_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| team_a_code | character | Team code (national: FIBA country code; club: a club abbreviation such as OOST). |
| team_a_official_name | character | Official name of team A: the country for a national team, the club for a club team. |
| team_a_short_name | character | Short name of team A: the country code for a national team, the club's short name for a club. |
| team_b_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_b_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| team_b_code | character | Team code (national: FIBA country code; club: a club abbreviation such as NANT). |
| team_b_official_name | character | Official name of team B: the country for a national team, the club for a club team. |
| team_b_short_name | character | Short name of team B: the country code for a national team, the club's short name for a club. |
| team_a_score | integer | Final score of team A. |
| team_b_score | integer | Final score of team B. |
| team_a_aggregated_score | integer | Two-leg aggregate score of team A (0 when not a two-leg tie). |
| team_b_aggregated_score | integer | Two-leg aggregate score of team B (0 when not a two-leg tie). |
| host_city | character | City of the venue. |
| host_country | character | Country of the venue (name; a FIBA code in getgdapgameswithleaderdetailsbyteamid). |
| host_country_code | character | FIBA code of the venue's country. |
| venue_id | integer | Venue id (GDAP key space; 0 = unknown). |
| venue_name | character | Name of the arena the game is played in. |
| game_date_time | character | Tip-off in venue-local wall-clock time, ISO 8601 without offset (T00:00:00 when hasTimeGameDateTime is false). |
| game_date_time_utc | character | Tip-off in UTC, ISO 8601 without the Z. |
| has_time_game_date_time | logical | False when only the date is known (the time part is then 00:00:00). |
| iana_time_zone | character | IANA time zone of the venue. |
| utc_offset | double | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
| is_postponed | logical | True when the game was postponed. |
| is_played_behind_closed_doors | logical | True when played without spectators. |
| venue_capacity | integer | Venue capacity (0 = unknown). |
| spectators | integer | Attendance at the game, as recorded by FIBA. |
| is_live | logical | True while the game is being played. |
| current_period | character | Last period reached ('Q4', 'OT1'). |
| chrono | character | Game clock of the current period, 'mm:ss' ('00:00' when finished). |
| live_game_status | integer | Live state code: 999 on every finished game; 5 seen on a finished 2024 youth game; mapping unverified. |
| current_period_status | character | State of the current period: E = ended (the only value sampled). |
| game_statistic_status_code | character | Box-score validation status: VALID. |
| game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
| game_result_status_code | character | Result validation status: VALID. |
| game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
| window_id | integer | Qualifier window id; null otherwise. |
| window_code | character | Qualifier window code; null otherwise. |
| window_name | character | Qualifier window name; null otherwise. |

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

Errors are classed conditions (all inherit `hoopR_error`):
`hoopR_no_data` when FIBA has nothing (HTTP 404, or GDAP answers
[`{}`](https://rdrr.io/r/base/Paren.html) / `[]` for an unknown id);
`hoopR_bad_request` for HTTP 400 / 422 or a malformed id, season or
date; `hoopR_asset_fetch` for any other failed fetch or an answer that
is not about the request (an error envelope, HTTP 401 after a key
refresh, HTTP 500, a body for another game, competition, team, player,
federation, family or season). Seasons are FIBA's own key, which equals
the sdv key: the END year for club competitions, the event year for
national-team events, the target tournament year for qualifiers.

## See also

Other FIBA Functions:
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md),
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
  try(fiba_gdap_game(game_id = 100720))
#> ── FIBA gdap_game from fiba.basketball ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:37:38 UTC
#> # A tibble: 1 × 50
#>   game_id round_name technical_name round_type    group_pairing_code game_number
#>     <int> <chr>      <chr>          <chr>         <chr>              <chr>      
#> 1  100720 Final      25283-92-A     Non Group Ro… 92                 A          
#> # ℹ 44 more variables: status_code <chr>, game_day <int>, team_a_from <chr>,
#> #   team_b_from <chr>, team_a_team_id <int>, team_a_organisation_id <int>,
#> #   team_a_code <chr>, team_a_official_name <chr>, team_a_short_name <chr>,
#> #   team_b_team_id <int>, team_b_organisation_id <int>, team_b_code <chr>,
#> #   team_b_official_name <chr>, team_b_short_name <chr>, team_a_score <int>,
#> #   team_b_score <int>, team_a_aggregated_score <int>,
#> #   team_b_aggregated_score <int>, host_city <chr>, host_country <chr>, …
# }
```
