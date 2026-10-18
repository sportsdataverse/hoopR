# **FIBA competition: Men's Olympic Basketball Tournament**

Per-competition aliases of the FIBA wrappers for Men's Olympic
Basketball Tournament (GDAP competition family 320), named as in sdv-py.
Season rule: event year (Paris 2024 = 2024).

## Usage

``` r
fiba_oly_editions(season = NULL, to_season = NULL, return_parsed = TRUE)

fiba_oly_schedule(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_standings(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_teams(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_player_box(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_team_box(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_pbp(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_shots(game_id, season = NULL, comp = NULL, return_parsed = TRUE)
```

## Arguments

- game_id:

  FIBA game id (`game_id` in the schedule).

- season:

  Edition season key (event year (Paris 2024 = 2024)). Omitted = the
  newest edition that has started; a game function needs `season` or
  `comp`. For `fiba_oly_editions()`: the first season (inclusive),
  omitted = every edition.

- to_season:

  Last season, inclusive (`fiba_oly_editions()` only).

- comp:

  FIBA competition id (one per edition); skips the edition lookup and is
  needed when a season lists several editions. Checked to be an edition
  of this competition (one cached getGdapCompetitionById request).

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with the columns of the base wrapper (the raw JSON
list when `return_parsed = FALSE`), one table per function:

### `fiba_oly_editions()`

The columns of
[`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| hosts | character | Host countries with their cities. Stored as a JSON string. |
| competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
| season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
| official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
| start | character | First day, YYYY-MM-DD. |
| end | character | Last day, YYYY-MM-DD. |
| status | character | Competition status: In Progress, Completed, Closed. |
| age_category | character | Age category (Senior, Under 16...). |
| gender | character | Men or Women: the gender of the competition. |
| fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
| zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
| zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
| zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
| zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
| zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
| zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
| competition_type | character | National Teams or Clubs. |
| competition_category_is_league | logical | True for league-format club competitions. |
| competition_category_age_type | character | Age type code: S senior, U16. |
| competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
| competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
| official_flag_item_code | character | Official-status code: O = official. |
| official_flag_item_name | character | Official-status label. |
| official | character | Official-status label. |
| discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
| competition_marketing_name_competition_marketing_name_id | integer | Competition family id (201 = World Cup, 112 = BCL tier 1, 211 = EuroLeague Women); the `<histId>` of /en/history/ pages. |
| competition_marketing_name_marketing_name | character | Competition family name; slugified it is the `<histSlug>` of /en/history/ pages. |
| competition_marketing_name_code | character | Family code; null in every sample. |

### `fiba_oly_schedule()`

The columns of
[`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md):

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
| utc_offset | numeric | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
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
| competition_season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
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

### `fiba_oly_standings()`

The columns of
[`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | FIBA competition id (Int64) the final ranking belongs to; the comp argument. |
| final_rank | integer | Final rank in the competition. |
| team_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_team_code | character | Team abbreviation (FIBA country code or club abbreviation). |
| team_short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
| team_profile | character | Team profile; null in this route. |
| team_status_code | character | Team entry status; always null in the samples, values unverified. |
| team_status_name | character | Team entry status label; always null in the samples, values unverified. |
| team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |

### `fiba_oly_teams()`

The columns of
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_code | character | Team abbreviation (FIBA country code or club abbreviation). |
| short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
| profile_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| profile_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| profile_name | character | Team name as registered for the competition. |
| profile_code | character | Team code (FIBA country code or club abbreviation). |
| profile_country_name | character | Country of the team, in English. |
| profile_country_code | character | Country FIBA code. |
| profile_gender | character | Men or Women: the gender of the team's competition. |
| profile_facebook | character | Facebook handle or URL; always null in the samples, values unverified. |
| profile_twitter | character | X/Twitter handle; always null in the samples, values unverified. |
| profile_instagram | character | Instagram handle; always null in the samples, values unverified. |
| profile_website | character | The team's website address. |
| profile_you_tube | character | YouTube handle; always null in the samples, values unverified. |
| profile_final_ranking | integer | Final rank in the competition. |
| profile_points_per_game | numeric | The team's average points per game played. |
| profile_rebounds_per_game | numeric | The team's average rebounds per game played. |
| profile_assists_per_game | numeric | The team's average assists per game played. |
| profile_rank_points_per_game | numeric | Rank in the competition by points per game (1 = highest). |
| profile_rank_rebounds_per_game | numeric | Rank in the competition by rebounds per game (1 = highest). |
| profile_rank_assists_per_game | numeric | Rank in the competition by assists per game (1 = highest). |
| profile_total_games_won | integer | The team's total games won over the games played. |
| profile_total_games_lost | integer | The team's total games lost over the games played. |
| profile_social_networks | character | Social-network handles. Stored as a JSON string. |
| profile_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| status_code | character | Team entry status: APPR approved. |
| status_name | character | Team entry status label (Approved). |
| organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |

### `fiba_oly_player_box()`

The columns of
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md):

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
| fg_pct | numeric | Field-goal percentage, 0-100. |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| fg2_pct | numeric | Two-point field-goal percentage, 0-100. |
| fg3_made | integer | Three-point field goals made. |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg3_pct | numeric | Three-point field-goal percentage, 0-100. |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| ft_pct | numeric | Free-throw percentage, 0-100. |
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
| paint_fg_pct | numeric | Field-goal percentage in the paint, 0-100. |
| efficiency | integer | Efficiency (FIBA EFF: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers). |
| plus_minus | integer | Plus/minus: the team's point differential while the player was on the court. |
| cb | logical | Boolean flag, false on every sampled player; meaning unverified. |

### `fiba_oly_team_box()`

The columns of
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64), global across competitions: gdapGameId, the `<gameId>` of a game-page URL. |
| competition_id | integer | FIBA competition id (Int64) of the game's edition; the comp argument. |
| statistic_system | character | Live-stats system of the game: OVR (World Cup, Olympics) or FLS (club competitions, most qualifiers); they differ in the play-by-play action ids, order and text. |
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| score | integer | Team final score. |
| points | integer | Points scored in the game. |
| fg_made | integer | Field goals made (2 + 3 points). |
| fg_attempted | integer | Field goals attempted (2 + 3 points). |
| fg_pct | numeric | Field-goal percentage, 0-100. |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| fg2_pct | numeric | Two-point field-goal percentage, 0-100. |
| fg3_made | integer | Three-point field goals made. |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg3_pct | numeric | Three-point field-goal percentage, 0-100. |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| ft_pct | numeric | Free-throw percentage, 0-100. |
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
| paint_fg_pct | numeric | Field-goal percentage in the paint, 0-100. |
| efficiency | integer | Efficiency (FIBA EFF: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers). |
| biggest_lead | integer | Biggest lead, points. |
| biggest_lead_score | character | Score when the biggest lead was reached, 'A-B' string (spacing varies; empty when the team never led). |
| biggest_run | integer | Biggest scoring run, points. |
| biggest_run_score | character | Score of the biggest scoring run, 'x-y' string; exact meaning unverified. |
| fast_break_points | integer | Fast-break points. |
| points_off_turnovers | integer | Points scored after turnovers. |
| bench_points | integer | Points from the bench (the sum of the non-starters' points). |
| points_in_paint | integer | Points in the paint (2 x paint_fg_made). |
| second_chance_points | integer | Second-chance points. |
| a_act | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_ACT). |
| a_foul | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_FOUL). |
| a_tod | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_TOD). |
| a_tot | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_TOT). |
| team_reb_offensive | integer | Team offensive rebounds, credited to no player. |
| team_reb_defensive | integer | Team defensive rebounds, credited to no player. |
| team_reb_total | integer | Team rebounds (total rebounds minus the players' sum). |
| team_fouls | integer | Team (bench/coach) fouls (personal fouls minus the players' sum). |
| team_turnovers | integer | Team turnovers (turnovers minus the players' sum). |
| team_bench_points_flag | integer | Bench points in FLS games (equal to bench_points); 0 in OVR games (FIBA stat code T_PFB). |
| time_led | character | Time the team led, 'mm:ss' string. |
| lead_changes | integer | Lead changes in the game (game-level; repeats on both team rows). |
| times_tied | integer | Times the score was tied (game-level; repeats on both team rows). |
| duration | character | Game duration as an 'h:mm' string (game-level; repeats on both team rows). |
| attendance | integer | Attendance (game-level; repeats on both team rows). |

### `fiba_oly_pbp()`

The columns of
[`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md):

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
| wall_time_ms | numeric | Wall-clock time of the action, Unix epoch milliseconds. (Int64 in sdv-py; numeric here, the values exceed R's 32-bit integer range) |
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

### `fiba_oly_shots()`

The columns of
[`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md):

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
| action_code | character | Action code: P2 two-point shot, P3 three-point shot, FT free throw, REB rebound, TREB team rebound, ASS assist, ST steal, BS block, TO turnover, TTO team turnover, FOUL foul, RFOUL foul drawn, SUBST substitution, TIMO timeout, plus period events (STARTG, STARTP, ENDP, ENDG). |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| player_id | integer | FIBA person id (Int64), global across competitions and roles: the page's P\_`<id>`, play-by-play pId, roster personId and fiba_gdap_roster.player_id. |
| shot_type | character | Shot type derived from action_code: 2PT, 3PT or FT; null on other actions. |
| points_attempted | integer | Points the attempt was worth (2, 3 or 1), made or not; null on other actions. |
| made | logical | True when the shot went in (two-pointers, three-pointers and free throws only; null otherwise). |
| shot_x | integer | Shot x, integer pixels on a half-court image across the court width (observed 0-278, basket near x = 139). Present only on shots; free throws are 0. Which sideline is x = 0 and the scale are UNVERIFIED. |
| shot_y | integer | Shot y, integer pixels from the baseline (y = 0) towards midcourt (observed 0-224, basket near y = 25); both teams' shots are drawn on one basket. Free throws are 0. Scale UNVERIFIED. |
| has_location | logical | True when shot_x / shot_y locate the shot (two- and three-pointers); False for free throws (always 0, 0); null on other actions. |

## Details

FIBA's terms restrict this source: the GDAP developer-portal terms limit
API use to 'Authorized Users' and the fiba.basketball terms say no
portion of the site may be duplicated, redistributed or manipulated. The
package owner reviewed both clauses on 2026-10-12, accepted them and
approved the full intake, published data releases included. Users who
are not themselves authorised by FIBA should check the terms before
using the wrappers. See
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md)
for the shared notes.

A `comp` of another competition family, or one GDAP gives no family, is
`hoopR_asset_fetch`; a season with no edition is `hoopR_no_data`; a
season listing several editions, or a game function called with neither
`season` nor `comp`, is `hoopR_bad_request`.

## See also

Other FIBA Competition Functions:
[`fiba_afrobasket_competition`](https://hoopR.sportsdataverse.org/reference/fiba_afrobasket_competition.md),
[`fiba_americup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_americup_competition.md),
[`fiba_asiacup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_asiacup_competition.md),
[`fiba_bcl_competition`](https://hoopR.sportsdataverse.org/reference/fiba_bcl_competition.md),
[`fiba_bcla_competition`](https://hoopR.sportsdataverse.org/reference/fiba_bcla_competition.md),
[`fiba_eurobasket_competition`](https://hoopR.sportsdataverse.org/reference/fiba_eurobasket_competition.md),
[`fiba_icup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_icup_competition.md),
[`fiba_wc_competition`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md)

## Examples

``` r
# \donttest{
  try(fiba_oly_editions(season = 2024))
#> ── FIBA gdap_editions from fiba.basketball ───────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:39:31 UTC
#> # A tibble: 1 × 29
#>   hosts  competition_id competition_code season official_name start end   status
#>   <chr>           <int> <chr>             <int> <chr>         <chr> <chr> <chr> 
#> 1 "[{\"…         208722 WOLYM              2024 Paris 2024 M… 2024… 2024… Compl…
#> # ℹ 21 more variables: age_category <chr>, gender <chr>, fiba_zone <chr>,
#> #   zone_information_zone_id <int>, zone_information_zone_official_name <chr>,
#> #   zone_information_zone_code <chr>, zone_information_top_zone_id <int>,
#> #   zone_information_top_zone_official_name <chr>,
#> #   zone_information_top_zone_code <chr>, competition_type <chr>,
#> #   competition_category_is_league <lgl>, competition_category_age_type <chr>,
#> #   competition_category_code <chr>, competition_category_name <chr>, …
  try(fiba_oly_schedule(season = 2024))
#> ── FIBA gdap_schedule from fiba.basketball ───────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:39:34 UTC
#> # A tibble: 26 × 86
#>    game_id game_name game_number status_code team_a_team_id
#>      <int> <chr>     <chr>       <chr>                <int>
#>  1  117642 28136-A-1 1           VALID               281542
#>  2  117644 28136-A-2 2           VALID               282018
#>  3  117643 28136-A-3 3           VALID               281543
#>  4  117641 28136-A-4 4           VALID               282021
#>  5  117639 28136-A-5 5           VALID               281542
#>  6  117640 28136-A-6 6           VALID               281543
#>  7  117647 28136-B-1 1           VALID               281544
#>  8  117649 28136-B-2 2           VALID               281545
#>  9  117648 28136-B-3 3           VALID               281546
#> 10  117646 28136-B-4 4           VALID               282020
#> # ℹ 16 more rows
#> # ℹ 81 more variables: team_a_organisation_id <int>, team_a_code <chr>,
#> #   team_a_official_name <chr>, team_a_short_name <chr>, team_b_team_id <int>,
#> #   team_b_organisation_id <int>, team_b_code <chr>,
#> #   team_b_official_name <chr>, team_b_short_name <chr>, team_a_score <int>,
#> #   team_b_score <int>, is_live <lgl>, current_period <chr>, chrono <chr>,
#> #   live_game_status <int>, current_period_status <chr>, host_city <chr>, …
# }
```
