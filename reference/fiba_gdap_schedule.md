# **FIBA GDAP: schedule**

Schedule and results of one competition (edition): one row per game.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapgamesbycompetitionid`

## Usage

``` r
fiba_gdap_schedule(comp, return_parsed = TRUE)
```

## Arguments

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

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
| game_name | character | Technical game name '`<roundId>`-`<groupPairingCode>`-`<gameNumber>`'. |
| game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
| status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
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
| is_live | logical | True while the game is being played. |
| current_period | character | Last period reached ('Q4', 'OT1'). |
| chrono | character | Game clock of the current period, 'mm:ss' ('00:00' when finished). |
| live_game_status | integer | Live state code: 999 on every finished game; 5 seen on a finished 2024 youth game; mapping unverified. |
| current_period_status | character | State of the current period: E = ended (the only value sampled). |
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
| statistic_system | character | Live-stats system that scored the game: OVR (FIBA's Olympic/World Cup system), FLS (FIBA LiveStats), null before about 2006. |
| group_id | character | Group id (GDAP key space). |
| group_pairing_code | character | Group letter (group play) or pairing number (knockout bracket slot). |
| round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
| round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
| round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
| round_round_number | integer | Round number within the competition (1-based). |
| round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
| round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
| round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
| round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
| round_start_date | character | Round start, local date-time. |
| round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
| round_round_kind | character | Standard Round or Qualifiers. |
| round_round_order | integer | Display order of the round. |
| competition_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| competition_competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
| competition_season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the package season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029). |
| competition_official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
| competition_start | character | First day, YYYY-MM-DD. |
| competition_end | character | Last day, YYYY-MM-DD. |
| competition_status | character | Competition status: In Progress, Completed, Closed. |
| competition_age_category | character | Age category (Senior, Under 16...). |
| competition_gender | character | Men or Women: the gender of the competition. |
| competition_fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
| competition_zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
| competition_zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
| competition_zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
| competition_zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
| competition_zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
| competition_zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
| competition_competition_type | character | National Teams or Clubs. |
| competition_competition_category_is_league | logical | True for league-format club competitions. |
| competition_competition_category_age_type | character | Age type code: S senior, U16. |
| competition_competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
| competition_competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
| competition_official_flag_item_code | character | Official-status code: O = official. |
| competition_official_flag_item_name | character | Official-status label. |
| competition_official | character | Official-status label. |
| competition_discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
| competition_competition_marketing_name_competition_marketing_name_id | integer | Competition family id (201 = World Cup, 112 = BCL tier 1, 211 = EuroLeague Women); the `<histId>` of /en/history/ pages. |
| competition_competition_marketing_name_marketing_name | character | Competition family name; slugified it is the `<histSlug>` of /en/history/ pages. |
| competition_competition_marketing_name_code | character | Family code; null in every sample. |
| game_statistic_status_code | character | Box-score validation status: VALID. |
| game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
| game_result_status_code | character | Result validation status: VALID. |
| game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
| window_code | character | Qualifier window code; null otherwise. |
| window_name | character | Qualifier window name; null otherwise. |
| team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
| team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

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
[`fiba_gdap_team_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_games.md),
[`fiba_gdap_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_player_stats.md),
[`fiba_gdap_team_staff()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_staff.md),
[`fiba_gdap_team_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_stats.md),
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md)

## Examples

``` r
# \donttest{
  try(fiba_gdap_schedule(comp = 208182))
#> ── FIBA gdap_schedule from fiba.basketball ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:30:17 UTC
#> # A tibble: 92 × 86
#>    game_id game_name game_number status_code team_a_team_id
#>      <int> <chr>     <chr>       <chr>                <int>
#>  1  100803 25284-M-1 1           VALID               279947
#>  2  100805 25284-M-2 2           VALID               279950
#>  3  100787 25284-M-3 3           VALID               279562
#>  4  100804 25284-M-4 4           VALID               279947
#>  5  100796 25284-N-1 1           VALID               279575
#>  6  100778 25284-N-2 2           VALID               279949
#>  7  100780 25284-N-3 3           VALID               279958
#>  8  100777 25284-N-4 4           VALID               279575
#>  9  100782 25284-O-1 1           VALID               279561
#> 10  100779 25284-O-2 2           VALID               279948
#> # ℹ 82 more rows
#> # ℹ 81 more variables: team_a_organisation_id <int>, team_a_code <chr>,
#> #   team_a_official_name <chr>, team_a_short_name <chr>, team_b_team_id <int>,
#> #   team_b_organisation_id <int>, team_b_code <chr>,
#> #   team_b_official_name <chr>, team_b_short_name <chr>, team_a_score <int>,
#> #   team_b_score <int>, is_live <lgl>, current_period <chr>, chrono <chr>,
#> #   live_game_status <int>, current_period_status <chr>, host_city <chr>, …
# }
```
