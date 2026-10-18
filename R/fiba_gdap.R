# fiba_gdap.R -- the fiba_gdap_* wrappers (R mirror of sdv-py sportsdataverse/basketball/fiba_hub/fiba_gdap.py).
# Same names, arguments, defaults and snake_case columns as sdv-py; the transport, refusals and
# parsers live in R/fiba_gdap_runtime.R, R/fiba_gdap_parsers.R and R/fiba_gamepage_runtime.R.

# The @details of every fiba topic that shares the fiba_gdap_awards() notes (roxygen @eval .intl_details()).
.fiba_gdap_awards_details <- c(
  "FIBA's terms restrict this source. The GDAP developer-portal terms limit API use to 'Authorized Users'",
  "(federations, organisers, FIBA partners) and say any broader use 'is not authorised'; the fiba.basketball",
  "terms say no portion of the site may be duplicated, redistributed or manipulated. The package owner reviewed",
  "both clauses on 2026-10-12, accepted them and approved the full intake, published data releases included.",
  "Users who are not themselves authorised by FIBA should check the terms before using the wrappers.",
  "",
  "The GDAP subscription key is public (fiba.basketball ships it in every page); the runtime reads it from the",
  "live page at run time and never logs it. Officials' contact details and coaches' and officials' dates of",
  "birth are dropped from every body.",
  "",
  "Id key spaces: competition_id is one per edition (2023 World Cup = 208182) and game_id is global across",
  "competitions (the `<gameId>` of a game-page URL). team_id is per team per competition (Germany is 279569 at",
  "the 2023 World Cup and 281545 at Paris 2024), while organisation_id is the stable federation or club (64 =",
  "Germany, every year); the game page's T_`<id>` and the play-by-play oId are organisation ids, not team ids.",
  "",
  "Errors are classed conditions (all inherit `hoopR_error`): `hoopR_no_data` when FIBA has nothing (HTTP 404,",
  "or GDAP answers `{}` / `[]` for an unknown id); `hoopR_bad_request` for HTTP 400 / 422 or a malformed id,",
  "season or date; `hoopR_asset_fetch` for any other failed fetch or an answer that is not about the request (an",
  "error envelope, HTTP 401 after a key refresh, HTTP 500, a body for another game, competition, team, player,",
  "federation, family or season). Seasons are FIBA's own key, which equals the sdv key: the END year for club",
  "competitions, the event year for national-team events, the target tournament year for qualifiers."
)

#' @title **FIBA GDAP: awards**
#' @description
#' Awards of a competition (MVP, All-Star Five...).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionawardsbyid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param discipline_format (character, optional) Optional; the site passes its discipline format. 5x5 answers
#'   the same as omitting it (verified on awards and rosters)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_awards(comp = 208182)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_end_date | character | Last day of the competition, YYYY-MM-DD. |
#' | award_date | character | Date awarded, YYYY-MM-DD. |
#' | competition_season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
#' | competition_official_name | character | Official name of the competition edition the award was given in. |
#' | award_name | character | Award name (All-Star 5, MVP...). |
#' | award_code | character | Award code (ALLSTAR, MVP...). |
#' | award_level_id | integer | Id of the object the award is attached to: the competitionId when awardLevel is Competition. |
#' | award_level | character | Level the award is given at: Competition. |
#' | award_label | character | Extra label; null in every sample. |
#' | player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | player_first_name | character | Awarded player's first name. |
#' | player_last_name | character | Awarded player's last name. |
#' | player_date_of_birth | character | Awarded player's date of birth, YYYY-MM-DD. |
#' | player_nationality | character | Awarded player's nationality, FIBA code. |
#' | teams | character | Teams the awarded player played for in the competition. Stored as a JSON string. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_awards <- function(comp, discipline_format = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("awards", "getgdapcompetitionawardsbyid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call),
    disciplineFormat = discipline_format
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: competition**
#' @description
#' One competition (edition): season, dates, hosts, zone, category and competition family.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getGdapCompetitionById`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | hosts | character | Host countries with their cities. Stored as a JSON string. |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
#' | season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
#' | official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
#' | start | character | First day, YYYY-MM-DD. |
#' | end | character | Last day, YYYY-MM-DD. |
#' | status | character | Competition status: In Progress, Completed, Closed. |
#' | age_category | character | Age category (Senior, Under 16...). |
#' | gender | character | Men or Women: the gender of the competition. |
#' | fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
#' | zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
#' | zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
#' | zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
#' | zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
#' | zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
#' | zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
#' | competition_type | character | National Teams or Clubs. |
#' | competition_category_is_league | logical | True for league-format club competitions. |
#' | competition_category_age_type | character | Age type code: S senior, U16. |
#' | competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
#' | competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
#' | official_flag_item_code | character | Official-status code: O = official. |
#' | official_flag_item_name | character | Official-status label. |
#' | official | character | Official-status label. |
#' | discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
#' | competition_marketing_name_competition_marketing_name_id | integer | Competition family id (201 = World Cup, 112 = BCL tier 1, 211 = EuroLeague Women); the `<histId>` of /en/history/ pages. |
#' | competition_marketing_name_marketing_name | character | Competition family name; slugified it is the `<histSlug>` of /en/history/ pages. |
#' | competition_marketing_name_code | character | Family code; null in every sample. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_competition(comp = 208182))
#' }
fiba_gdap_competition <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("competition", "getGdapCompetitionById", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: editions**
#' @description
#' Every edition of a competition family between two seasons.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionsbyseasonsandcompetitionmarketingname`
#' @param family_id (integer, required) Required. Competition family id
#'   (competitionMarketingName.competitionMarketingNameId): 201 = World Cup, 320 = men's Olympics, 306 = Women's
#'   World Cup, 112 = BCL tier 1, 211 = EuroLeague Women.
#' @param season (integer, optional) Season key: the END year for club competitions (BCL 2024-25 = 2025), the
#'   event year for national-team events (World Cup 2023 = 2023); qualifiers carry the TARGET tournament year
#'   (World Cup 2027 qualifiers played in 2025 = 2027). Sent unchanged. First season, inclusive; omitted = no
#'   lower bound.
#' @param to_season (integer, optional) Last season, inclusive (same key as season). Omitted with season given =
#'   the same season.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | hosts | character | Host countries with their cities. Stored as a JSON string. |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
#' | season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
#' | official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
#' | start | character | First day, YYYY-MM-DD. |
#' | end | character | Last day, YYYY-MM-DD. |
#' | status | character | Competition status: In Progress, Completed, Closed. |
#' | age_category | character | Age category (Senior, Under 16...). |
#' | gender | character | Men or Women: the gender of the competition. |
#' | fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
#' | zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
#' | zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
#' | zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
#' | zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
#' | zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
#' | zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
#' | competition_type | character | National Teams or Clubs. |
#' | competition_category_is_league | logical | True for league-format club competitions. |
#' | competition_category_age_type | character | Age type code: S senior, U16. |
#' | competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
#' | competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
#' | official_flag_item_code | character | Official-status code: O = official. |
#' | official_flag_item_name | character | Official-status label. |
#' | official | character | Official-status label. |
#' | discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
#' | competition_marketing_name_competition_marketing_name_id | integer | Competition family id (201 = World Cup, 112 = BCL tier 1, 211 = EuroLeague Women); the `<histId>` of /en/history/ pages. |
#' | competition_marketing_name_marketing_name | character | Competition family name; slugified it is the `<histSlug>` of /en/history/ pages. |
#' | competition_marketing_name_code | character | Family code; null in every sample. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_editions(family_id = 201, season = 2023))
#' }
fiba_gdap_editions <- function(family_id, season = NULL, to_season = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("editions", "getgdapcompetitionsbyseasonsandcompetitionmarketingname", list(
    competitionMarketingNameId = .fiba_int_id(family_id, "family_id", call = call),
    fromSeason = .fiba_season(season, "season", call = call),
    toSeason = .fiba_season(to_season, "to_season", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: federation games**
#' @description
#' A federation's recent and upcoming national-team games.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapfederationgamesbyfederationid`
#' @param federation_id (integer, required) Required. Federation organisationId, stable across competitions (64
#'   = Germany; teamA.organisationId)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_federation_games(federation_id = 64)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
#' | game_name | character | Technical game name '`<roundId>`-`<groupPairingCode>`-`<gameNumber>`'. |
#' | game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
#' | status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
#' | team_a_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_a_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_a_code | character | Team code (national: FIBA country code; club: a club abbreviation such as OOST). |
#' | team_a_official_name | character | Official name of team A: the country for a national team, the club for a club team. |
#' | team_a_short_name | character | Short name of team A: the country code for a national team, the club's short name for a club. |
#' | team_b_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_b_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_b_code | character | Team code (national: FIBA country code; club: a club abbreviation such as NANT). |
#' | team_b_official_name | character | Official name of team B: the country for a national team, the club for a club team. |
#' | team_b_short_name | character | Short name of team B: the country code for a national team, the club's short name for a club. |
#' | team_a_score | integer | Final score of team A. |
#' | team_b_score | integer | Final score of team B. |
#' | is_live | logical | True while the game is being played. |
#' | current_period | character | Last period reached ('Q4', 'OT1'). |
#' | chrono | character | Game clock of the current period, 'mm:ss' ('00:00' when finished). |
#' | live_game_status | integer | Live state code: 999 on every finished game; 5 seen on a finished 2024 youth game; mapping unverified. |
#' | current_period_status | character | State of the current period: E = ended (the only value sampled). |
#' | host_city | character | City of the venue. |
#' | host_country | character | Country of the venue (name; a FIBA code in getgdapgameswithleaderdetailsbyteamid). |
#' | host_country_code | character | FIBA code of the venue's country. |
#' | venue_id | integer | Venue id (GDAP key space; 0 = unknown). |
#' | venue_name | character | Name of the arena the game is played in. |
#' | game_date_time | character | Tip-off in venue-local wall-clock time, ISO 8601 without offset (T00:00:00 when hasTimeGameDateTime is false). |
#' | game_date_time_utc | character | Tip-off in UTC, ISO 8601 without the Z. |
#' | has_time_game_date_time | logical | False when only the date is known (the time part is then 00:00:00). |
#' | iana_time_zone | character | IANA time zone of the venue. |
#' | utc_offset | double | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
#' | is_postponed | logical | True when the game was postponed. |
#' | is_played_behind_closed_doors | logical | True when played without spectators. |
#' | venue_capacity | integer | Venue capacity (0 = unknown). |
#' | spectators | integer | Attendance at the game, as recorded by FIBA. |
#' | statistic_system | character | Live-stats system that scored the game: OVR (FIBA's Olympic/World Cup system), FLS (FIBA LiveStats), null before about 2006. |
#' | group_id | character | Group id (GDAP key space). |
#' | group_pairing_code | character | Group letter (group play) or pairing number (knockout bracket slot). |
#' | round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
#' | round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
#' | round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | round_round_number | integer | Round number within the competition (1-based). |
#' | round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
#' | round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
#' | round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
#' | round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
#' | round_start_date | character | Round start, local date-time. |
#' | round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
#' | round_round_kind | character | Standard Round or Qualifiers. |
#' | round_round_order | integer | Display order of the round. |
#' | competition_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
#' | competition_season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
#' | competition_official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
#' | competition_start | character | First day, YYYY-MM-DD. |
#' | competition_end | character | Last day, YYYY-MM-DD. |
#' | competition_status | character | Competition status: In Progress, Completed, Closed. |
#' | competition_age_category | character | Age category (Senior, Under 16...). |
#' | competition_gender | character | Men or Women: the gender of the competition. |
#' | competition_fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
#' | competition_zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
#' | competition_zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
#' | competition_zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
#' | competition_zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
#' | competition_zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
#' | competition_zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
#' | competition_competition_type | character | National Teams or Clubs. |
#' | competition_competition_category_is_league | logical | True for league-format club competitions. |
#' | competition_competition_category_age_type | character | Age type code: S senior, U16. |
#' | competition_competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
#' | competition_competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
#' | competition_official_flag_item_code | character | Official-status code: O = official. |
#' | competition_official_flag_item_name | character | Official-status label. |
#' | competition_official | character | Official-status label. |
#' | competition_discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
#' | competition_competition_marketing_name | character | Competition family, shared by every edition; always null in the samples, values unverified. |
#' | game_statistic_status_code | character | Box-score validation status: VALID. |
#' | game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
#' | game_result_status_code | character | Result validation status: VALID. |
#' | game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
#' | window_code | character | Qualifier window code; null otherwise. |
#' | window_name | character | Qualifier window name; null otherwise. |
#' | team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
#' | team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_federation_games <- function(federation_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("federation_games", "getgdapfederationgamesbyfederationid", list(
    gdapFederationId = .fiba_int_id(federation_id, "federation_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: federation ranking**
#' @description
#' FIBA world ranking of national teams.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapfederationsranking`
#' @param category (character, default `"men"`) Ranking category: men or women (the site also knows boys/girls)
#' @param zone_id (integer, default `1L`) Ranking zone id from getgdaprankingzones (1 = World, 2 = Africa, 3 =
#'   Americas, 4 = Asia, 5 = Europe)
#' @param as_of_date (character, optional) Ranking as of this date, ISO 8601: the latest ranking published on or
#'   before it (2026-03-10 answers the 2026-03-03 ranking). Omitted = the latest ranking
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_federation_ranking(category = "men", zone_id = 1, as_of_date = "2025-09-15")')
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | as_of_date | character | Date of the ranking returned: the latest ranking published on or before the requested date. |
#' | zone_ranking_code | character | Ranking zone code (WORLD, AFRICA...). |
#' | zone_ranking_official_name | character | Ranking zone official name. |
#' | world_rank | integer | Position in the FIBA world ranking (1 = best). |
#' | country_name | character | Country name in English. |
#' | zone_rank | integer | Rank within the zone. |
#' | ioc_code | character | IOC country code. |
#' | fiba_code | character | FIBA three-letter country code (GER, USA; historic URS, YUG). |
#' | current_points | double | Ranking points (one decimal). |
#' | world_rank_variation | integer | Change in world rank since the previous release (positive = up). |
#' | comments | character | Ranking note; null in every sample. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_federation_ranking <- function(category = "men", zone_id = 1L, as_of_date = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("federation_ranking", "getgdapfederationsranking", list(
    gdapCategory = category,
    zoneRankingId = .fiba_int_id(zone_id, "zone_id", call = call),
    asOfDate = as_of_date
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: final standings**
#' @description
#' Final ranking of a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionfinalstandingbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | FIBA competition id (Int64) the final ranking belongs to; the comp argument. |
#' | final_rank | integer | Final rank in the competition. |
#' | team_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_team_code | character | Team abbreviation (FIBA country code or club abbreviation). |
#' | team_short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
#' | team_profile | character | Team profile; null in this route. |
#' | team_status_code | character | Team entry status; always null in the samples, values unverified. |
#' | team_status_name | character | Team entry status label; always null in the samples, values unverified. |
#' | team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_final_standings(comp = 208182))
#' }
fiba_gdap_final_standings <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("final_standings", "getgdapcompetitionfinalstandingbycompetitionid", list(
    profile = "true",
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: game**
#' @description
#' One game's header: teams, score, venue, attendance and status codes (no box score or play-by-play: see
#' fiba_gamepage).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`
#' @param game_id (integer, required) Required. FIBA game id (global GDAP key space): gameId of a schedule row;
#'   the `<gameId>` of a game page URL
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
#' | round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | technical_name | character | Technical game name '`<roundId>`-`<groupPairingCode>`-`<gameNumber>`'. |
#' | round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
#' | group_pairing_code | character | Group letter (group play) or pairing number (knockout bracket slot). |
#' | game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
#' | status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
#' | game_day | integer | Game day number within the round. |
#' | team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
#' | team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |
#' | team_a_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_a_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_a_code | character | Team code (national: FIBA country code; club: a club abbreviation such as OOST). |
#' | team_a_official_name | character | Official name of team A: the country for a national team, the club for a club team. |
#' | team_a_short_name | character | Short name of team A: the country code for a national team, the club's short name for a club. |
#' | team_b_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_b_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_b_code | character | Team code (national: FIBA country code; club: a club abbreviation such as NANT). |
#' | team_b_official_name | character | Official name of team B: the country for a national team, the club for a club team. |
#' | team_b_short_name | character | Short name of team B: the country code for a national team, the club's short name for a club. |
#' | team_a_score | integer | Final score of team A. |
#' | team_b_score | integer | Final score of team B. |
#' | team_a_aggregated_score | integer | Two-leg aggregate score of team A (0 when not a two-leg tie). |
#' | team_b_aggregated_score | integer | Two-leg aggregate score of team B (0 when not a two-leg tie). |
#' | host_city | character | City of the venue. |
#' | host_country | character | Country of the venue (name; a FIBA code in getgdapgameswithleaderdetailsbyteamid). |
#' | host_country_code | character | FIBA code of the venue's country. |
#' | venue_id | integer | Venue id (GDAP key space; 0 = unknown). |
#' | venue_name | character | Name of the arena the game is played in. |
#' | game_date_time | character | Tip-off in venue-local wall-clock time, ISO 8601 without offset (T00:00:00 when hasTimeGameDateTime is false). |
#' | game_date_time_utc | character | Tip-off in UTC, ISO 8601 without the Z. |
#' | has_time_game_date_time | logical | False when only the date is known (the time part is then 00:00:00). |
#' | iana_time_zone | character | IANA time zone of the venue. |
#' | utc_offset | double | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
#' | is_postponed | logical | True when the game was postponed. |
#' | is_played_behind_closed_doors | logical | True when played without spectators. |
#' | venue_capacity | integer | Venue capacity (0 = unknown). |
#' | spectators | integer | Attendance at the game, as recorded by FIBA. |
#' | is_live | logical | True while the game is being played. |
#' | current_period | character | Last period reached ('Q4', 'OT1'). |
#' | chrono | character | Game clock of the current period, 'mm:ss' ('00:00' when finished). |
#' | live_game_status | integer | Live state code: 999 on every finished game; 5 seen on a finished 2024 youth game; mapping unverified. |
#' | current_period_status | character | State of the current period: E = ended (the only value sampled). |
#' | game_statistic_status_code | character | Box-score validation status: VALID. |
#' | game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
#' | game_result_status_code | character | Result validation status: VALID. |
#' | game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
#' | window_id | integer | Qualifier window id; null otherwise. |
#' | window_code | character | Qualifier window code; null otherwise. |
#' | window_name | character | Qualifier window name; null otherwise. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_game(game_id = 100720))
#' }
fiba_gdap_game <- function(game_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("game", "getgdapgamebyid", list(
    gdapGameId = .fiba_int_id(game_id, "game_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: game officials**
#' @description
#' Officials nominated to one game (referees, table officials, commissioner).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`
#' @param game_id (integer, required) Required. FIBA game id (global GDAP key space): gameId of a schedule row;
#'   the `<gameId>` of a game page URL
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_game_officials(game_id = 100720)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id (Int64) of the game the official was nominated to. |
#' | person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
#' | role_code | character | Role code (REF, FIBATDEL...). |
#' | role_name | character | Role name on the game (Crew chief, Umpire, Commissioner, Assistant scorer...). |
#' | role_order | character | Order within the role; a numeric string or null. |
#' | default_nationality | character | FIBA code of the official's main nationality. |
#' | license_nationality | character | FIBA code of the federation that licenses the official. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_game_officials <- function(game_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("game_officials", "getgdapgamebyid", list(
    gdapGameId = .fiba_int_id(game_id, "game_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: game periods**
#' @description
#' Period scores of one game.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`
#' @param game_id (integer, required) Required. FIBA game id (global GDAP key space): gameId of a schedule row;
#'   the `<gameId>` of a game page URL
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id (Int64) of the game the period belongs to. |
#' | name | character | Period name ('Q1'...'OT1'). |
#' | number | integer | Period number (1-based). |
#' | team_a_score | integer | Team A points in the period. |
#' | team_b_score | integer | Team B points in the period. |
#' | team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
#' | team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_game_periods(game_id = 100720))
#' }
fiba_gdap_game_periods <- function(game_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("game_periods", "getgdapgamebyid", list(
    gdapGameId = .fiba_int_id(game_id, "game_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: games between**
#' @description
#' Games of EVERY FIBA competition in a local-time window (how competitions and games are discovered).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamesbetweentwodates`
#' @param date_from (character, required) Required. Window start as YYYY-MM-DD, compared with the venue-local
#'   gameDateTime (not UTC).
#' @param date_to (character, required) Required. Window end as YYYY-MM-DD, EXCLUSIVE (date_from = date_to
#'   returns nothing).
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_games_between(date_from = "2023-09-08", date_to = "2023-09-11")')
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
#' | game_name | character | Technical game name '`<roundId>`-`<groupPairingCode>`-`<gameNumber>`'. |
#' | game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
#' | status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
#' | team_a_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_a_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_a_code | character | Team code (national: FIBA country code; club: a club abbreviation such as OOST). |
#' | team_a_official_name | character | Official name of team A: the country for a national team, the club for a club team. |
#' | team_a_short_name | character | Short name of team A: the country code for a national team, the club's short name for a club. |
#' | team_b_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_b_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_b_code | character | Team code (national: FIBA country code; club: a club abbreviation such as NANT). |
#' | team_b_official_name | character | Official name of team B: the country for a national team, the club for a club team. |
#' | team_b_short_name | character | Short name of team B: the country code for a national team, the club's short name for a club. |
#' | team_a_score | integer | Final score of team A. |
#' | team_b_score | integer | Final score of team B. |
#' | is_live | logical | True while the game is being played. |
#' | current_period | character | Last period reached ('Q4', 'OT1'). |
#' | chrono | character | Game clock of the current period, 'mm:ss' ('00:00' when finished). |
#' | live_game_status | integer | Live state code: 999 on every finished game; 5 seen on a finished 2024 youth game; mapping unverified. |
#' | current_period_status | character | State of the current period: E = ended (the only value sampled). |
#' | host_city | character | City of the venue. |
#' | host_country | character | Country of the venue (name; a FIBA code in getgdapgameswithleaderdetailsbyteamid). |
#' | host_country_code | character | FIBA code of the venue's country. |
#' | venue_id | integer | Venue id (GDAP key space; 0 = unknown). |
#' | venue_name | character | Name of the arena the game is played in. |
#' | game_date_time | character | Tip-off in venue-local wall-clock time, ISO 8601 without offset (T00:00:00 when hasTimeGameDateTime is false). |
#' | game_date_time_utc | character | Tip-off in UTC, ISO 8601 without the Z. |
#' | has_time_game_date_time | logical | False when only the date is known (the time part is then 00:00:00). |
#' | iana_time_zone | character | IANA time zone of the venue. |
#' | utc_offset | double | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
#' | is_postponed | logical | True when the game was postponed. |
#' | is_played_behind_closed_doors | logical | True when played without spectators. |
#' | venue_capacity | integer | Venue capacity (0 = unknown). |
#' | spectators | integer | Attendance at the game, as recorded by FIBA. |
#' | statistic_system | character | Live-stats system that scored the game: OVR (FIBA's Olympic/World Cup system), FLS (FIBA LiveStats), null before about 2006. |
#' | group_id | character | Group id (GDAP key space). |
#' | group_pairing_code | character | Group letter (group play) or pairing number (knockout bracket slot). |
#' | round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
#' | round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
#' | round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | round_round_number | integer | Round number within the competition (1-based). |
#' | round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
#' | round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
#' | round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
#' | round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
#' | round_start_date | character | Round start, local date-time. |
#' | round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
#' | round_round_kind | character | Standard Round or Qualifiers. |
#' | round_round_order | integer | Display order of the round. |
#' | competition_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
#' | competition_season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
#' | competition_official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
#' | competition_start | character | First day, YYYY-MM-DD. |
#' | competition_end | character | Last day, YYYY-MM-DD. |
#' | competition_status | character | Competition status: In Progress, Completed, Closed. |
#' | competition_age_category | character | Age category (Senior, Under 16...). |
#' | competition_gender | character | Men or Women: the gender of the competition. |
#' | competition_fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
#' | competition_zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
#' | competition_zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
#' | competition_zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
#' | competition_zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
#' | competition_zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
#' | competition_zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
#' | competition_competition_type | character | National Teams or Clubs. |
#' | competition_competition_category_is_league | logical | True for league-format club competitions. |
#' | competition_competition_category_age_type | character | Age type code: S senior, U16. |
#' | competition_competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
#' | competition_competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
#' | competition_official_flag_item_code | character | Official-status code: O = official. |
#' | competition_official_flag_item_name | character | Official-status label. |
#' | competition_official | character | Official-status label. |
#' | competition_discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
#' | competition_competition_marketing_name | character | Competition family, shared by every edition; always null in the samples, values unverified. |
#' | game_statistic_status_code | character | Box-score validation status: VALID. |
#' | game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
#' | game_result_status_code | character | Result validation status: VALID. |
#' | game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
#' | window_code | character | Qualifier window code; null otherwise. |
#' | window_name | character | Qualifier window name; null otherwise. |
#' | team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
#' | team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_games_between <- function(date_from, date_to, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("games_between", "getgdapgamesbetweentwodates", list(
    dateFrom = .fiba_window_date(date_from, "date_from", call = call),
    dateTo = .fiba_window_date(date_to, "date_to", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: gateway competition ids**
#' @description
#' Ids of the competitions that run in a date window.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getcustomgateway`
#' @param start_date (character, required) Required. Window start as YYYY-MM-DD.
#' @param end_date (character, required) Required. Window end as YYYY-MM-DD.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_gateway_competition_ids(start_date = "2025-01-14", end_date = "2025-01-16")')
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | FIBA competition id (Int64, GDAP key space) of a competition that runs in the window. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_gateway_competition_ids <- function(start_date, end_date, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("gateway_competition_ids", "getcustomgateway", list(
    fibaFunction = "competitionIdsBetweenTwoDates",
    startDate = .fiba_window_date(start_date, "start_date", call = call),
    endDate = .fiba_window_date(end_date, "end_date", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: gateway federation ranking**
#' @description
#' FIBA world ranking from the server-side gateway (same items as fiba_gdap_federation_ranking).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getcustomgateway`
#' @param gender (character, default `"men"`) federationRanking: men or women (= gdapCategory)
#' @param zone_id (integer, default `1L`) federationRanking: ranking zone id (= zoneRankingId)
#' @param as_of_date (character, optional) Ranking as of this date, ISO 8601: the latest ranking published on or
#'   before it (2026-03-10 answers the 2026-03-03 ranking). Omitted = the latest ranking
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_gateway_federation_ranking(gender = "men", zone_id = 1, as_of_date = "2025-09-15")')
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | as_of_date | character | Date of the ranking returned: the latest ranking published on or before the requested date. |
#' | zone_ranking_code | character | Ranking zone code (WORLD, AFRICA...). |
#' | zone_ranking_official_name | character | Ranking zone official name. |
#' | world_rank | integer | Position in the FIBA world ranking (1 = best). |
#' | country_name | character | Country name in English. |
#' | zone_rank | integer | Rank within the zone. |
#' | ioc_code | character | IOC country code. |
#' | fiba_code | character | FIBA three-letter country code (GER, USA; historic URS, YUG). |
#' | current_points | double | Ranking points (one decimal). |
#' | world_rank_variation | integer | Change in world rank since the previous release (positive = up). |
#' | comments | character | Ranking note; null in every sample. |
#' | organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | organisation_status_code | character | Organisation status: ACT active. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_gateway_federation_ranking <- function(gender = "men", zone_id = 1L, as_of_date = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("gateway_federation_ranking", "getcustomgateway", list(
    fibaFunction = "federationRanking",
    gender = gender,
    zoneId = .fiba_int_id(zone_id, "zone_id", call = call),
    asOfDate = as_of_date
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: medal count**
#' @description
#' All-time medal table of a competition family.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapmedalcount`
#' @param family_id (integer, required) Required. Competition family id
#'   (competitionMarketingName.competitionMarketingNameId): 201 = World Cup, 320 = men's Olympics, 306 = Women's
#'   World Cup, 112 = BCL tier 1, 211 = EuroLeague Women.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_medal_count(family_id = 201)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_name | character | Team name (country or club). |
#' | organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | fiba_code | character | FIBA three-letter country code (GER, USA; historic URS, YUG). |
#' | team_zone_code | character | Zone code of the team (E Europe, NAM Americas north...). |
#' | rank | integer | Rank (1 = first). |
#' | total_first_rank | integer | Gold medals (first places). |
#' | total_second_rank | integer | Number of silver medals the federation has won in the competition family. |
#' | total_third_rank | integer | Number of bronze medals the federation has won in the competition family. |
#' | total_participations | integer | Editions played. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_medal_count <- function(family_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("medal_count", "getgdapmedalcount", list(
    competitionMarketingNameId = .fiba_int_id(family_id, "family_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: national teams**
#' @description
#' Every national federation FIBA lists.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapnationalteams`
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_national_teams()")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | national_federation_id | integer | Federation organisation id (organisationId key space: 64 = Germany). |
#' | display_name | character | English display name of the federation (the country), as the FIBA site shows it. |
#' | official_name | character | Federation's official name. |
#' | country_id | integer | FIBA country id (country table key space; not an organisationId). |
#' | country_name | character | Country name in English. |
#' | country_fiba_code | character | FIBA code of the federation's country. |
#' | zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
#' | zone_name | character | FIBA zone (Europe, Africa...). |
#' | organisation_status_code | character | Organisation status: ACT active. |
#' | membership_status_code | character | FIBA membership status: ACT active. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_national_teams <- function(return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("national_teams", "getgdapnationalteams", list(), return_parsed, call = rlang::current_env())
}

#' @title **FIBA GDAP: nominations**
#' @description
#' Officials nominated for a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionnominationsbyid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param level (character, default `"competition"`) competition = officials nominated for the whole competition
#'   (the only value the site sends)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_nominations(comp = 208182)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_level | character | Level the nomination is attached to: Competition. |
#' | competition_level_id | integer | Id of the object the nomination is attached to: the competitionId when competitionLevel is Competition. |
#' | competition_role | character | Role label at competition level; null in every sample. |
#' | role | character | Role: Referee, FIBA Table Officials, FIBA Certified Statisticians, FIBA Technical Delegate, FIBA Referee Instructor. |
#' | role_code | character | Role code (REF, FIBATDEL...). |
#' | game_assignment_role | character | Role on a game assignment; null at competition level. |
#' | game_assignment_role_code | character | Code of gameAssignmentRole; null at competition level. |
#' | game_assignment_role_order | character | Order of gameAssignmentRole; null at competition level. |
#' | person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
#' | nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
#' | license_nationality | character | FIBA code of the federation that licenses the official. |
#' | affiliated_national_federation_country_code | character | FIBA code of the federation the official is affiliated to. |
#' | affiliated_national_federation_country_name | character | Country of the federation the official is affiliated to. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_nominations <- function(comp, level = "competition", return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("nominations", "getgdapcompetitionnominationsbyid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call),
    level = level
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: player game stats**
#' @description
#' A player's game log (full box lines) at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapplayergamestatisticsbyplayerid`
#' @param player_id (integer, required) Required. FIBA person id (global): personId of a roster row, pId in
#'   play-by-play, P_`<id>` in the game-page box
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | FIBA person id (Int64), global; the player_id argument. |
#' | competition_id | integer | FIBA competition id (Int64) the game log belongs to; the comp argument. |
#' | game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
#' | game_day | integer | Game day number within the round. |
#' | round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
#' | round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
#' | round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_name | character | Player's team name. |
#' | team_code | character | Player's team code. |
#' | team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | versus_team_id | integer | Opponent's competition team id (see teamId). |
#' | versus_team_name | character | Opponent's name. |
#' | versus_team_code | character | Opponent's code. |
#' | versus_team_organisation_id | integer | Opponent's organisation id (see organisationId). |
#' | play_duration_in_seconds | integer | Playing time in seconds in the game. |
#' | points | integer | Points in the game. |
#' | field_goals_made | integer | Field goals made in the game. |
#' | field_goals_attempted | integer | Field goals attempted in the game. |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (in the game; full float precision in averages). |
#' | two_points_made | integer | Two-point field goals made in the game. |
#' | two_points_attempted | integer | Two-point field goals attempted in the game. |
#' | two_points_percentage | double | Two-point field-goal percentage, 0-100 (in the game; full float precision in averages). |
#' | three_points_made | integer | Three-point field goals made in the game. |
#' | three_points_attempted | integer | Three-point field goals attempted in the game. |
#' | three_points_percentage | double | Three-point field-goal percentage, 0-100 (in the game; full float precision in averages). |
#' | free_throws_made | integer | Free throws made in the game. |
#' | free_throws_attempted | integer | Free throws attempted in the game. |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (in the game; full float precision in averages). |
#' | offensive_rebounds | integer | Offensive rebounds in the game. |
#' | defensive_rebounds | integer | Defensive rebounds in the game. |
#' | rebounds | integer | Rebounds in the game. |
#' | assists | integer | Assists in the game. |
#' | personal_fouls | integer | Personal fouls in the game. |
#' | turnovers | integer | Turnovers in the game. |
#' | steals | integer | Steals in the game. |
#' | blocked_shots | integer | Blocked shots in the game. |
#' | plus_minus | integer | Plus/minus (point differential while on court) in the game. |
#' | efficiency | integer | Efficiency (FIBA EFF) in the game. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_player_game_stats(player_id = 211501, comp = 208182))
#' }
fiba_gdap_player_game_stats <- function(player_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("player_game_stats", "getgdapplayergamestatisticsbyplayerid", list(
    gdapPlayerId = .fiba_int_id(player_id, "player_id", call = call),
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: player info**
#' @description
#' A player's bio and per-game averages with ranks at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapplayerinfobycompetitionid`
#' @param player_id (integer, required) Required. FIBA person id (global): personId of a roster row, pId in
#'   play-by-play, P_`<id>` in the game-page box
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_player_info(player_id = 211501, comp = 208182)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | height_cm | integer | Height in centimetres. |
#' | height_ft_in | character | Height, feet and inches string. |
#' | club_name | character | Club at the time of the competition. |
#' | club_code | character | Club abbreviation; always null in the samples, values unverified. |
#' | is_player_free_agent | logical | True when the player had no club. |
#' | points_per_game | double | The player's average points per game played. |
#' | rank_points_per_game | double | Rank in the competition by points per game (1 = highest). |
#' | rebounds_per_game | double | The player's average rebounds per game played. |
#' | rank_rebounds_per_game | double | Rank in the competition by rebounds per game (1 = highest). |
#' | assists_per_game | double | The player's average assists per game played. |
#' | rank_assists_per_game | double | Rank in the competition by assists per game (1 = highest). |
#' | points_per_game_per_competition_category | double | Average points per game across the competition category, the comparison baseline (unverified). |
#' | rebounds_per_game_per_competition_category | double | Average rebounds per game across the competition category, the comparison baseline (unverified). |
#' | assists_per_game_per_competition_category | double | Average assists per game across the competition category, the comparison baseline (unverified). |
#' | birth_date | character | Date of birth, YYYY-MM-DD. |
#' | nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
#' | social_media_website | character | Website URL; always null in the samples, values unverified. |
#' | social_media_twitter | character | X/Twitter handle; always null in the samples, values unverified. |
#' | social_media_facebook | character | Facebook handle or URL; always null in the samples, values unverified. |
#' | social_media_instagram | character | Instagram handle; always null in the samples, values unverified. |
#' | social_media_youtube | character | YouTube handle; always null in the samples, values unverified. |
#' | social_networks | character | Social-network handles. Stored as a JSON string. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_player_info <- function(player_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("player_info", "getgdapplayerinfobycompetitionid", list(
    gdapPlayerId = .fiba_int_id(player_id, "player_id", call = call),
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: player stats**
#' @description
#' A player's per-game averages, totals and highs at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapplayercompetitionstatisticsbyplayerid`
#' @param player_id (integer, required) Required. FIBA person id (global): personId of a roster row, pId in
#'   play-by-play, P_`<id>` in the game-page box
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | points_per_game | double | The player's average points per game played. |
#' | rebounds_per_game | double | The player's average rebounds per game played. |
#' | rebounds_offensive_per_game | double | The player's average offensive rebounds per game played. |
#' | rebounds_defensive_per_game | double | The player's average defensive rebounds per game played. |
#' | assists_per_game | double | The player's average assists per game played. |
#' | blocks_per_game | double | The player's average blocked shots per game played. |
#' | turnovers_per_game | double | The player's average turnovers per game played. |
#' | fouls_per_game | double | The player's average personal fouls per game played. |
#' | plus_minus_per_game | double | The player's average plus/minus (point differential while on court) per game played. |
#' | efficiency_per_game | double | The player's average efficiency (FIBA EFF) per game played. |
#' | play_time_in_seconds_per_game | double | The player's average playing time in seconds per game played. |
#' | field_goals_made_per_game | double | The player's average field goals made per game played. |
#' | field_goals_attempted_per_game | double | The player's average field goals attempted per game played. |
#' | two_points_made_per_game | double | The player's average two-point field goals made per game played. |
#' | two_points_attempted_per_game | double | The player's average two-point field goals attempted per game played. |
#' | three_points_made_per_game | double | The player's average three-point field goals made per game played. |
#' | three_points_attempted_per_game | double | The player's average three-point field goals attempted per game played. |
#' | free_throws_made_per_game | double | The player's average free throws made per game played. |
#' | free_throws_attempted_per_game | double | The player's average free throws attempted per game played. |
#' | points_from_turnovers_per_game | double | The player's average points from turnovers per game played. |
#' | fast_break_points_per_game | double | The player's average fast-break points per game played. |
#' | second_chance_points_per_game | double | The player's average second-chance points per game played. |
#' | points_in_the_paint_per_game | double | The player's average points in the paint per game played. |
#' | steals_per_game | double | The player's average steals per game played. |
#' | total_games_played | integer | The player's total games played over the games played. |
#' | total_games_won | integer | The player's total games won over the games played. |
#' | total_games_lost | integer | The player's total games lost over the games played. |
#' | total_rebounds | integer | The player's total rebounds over the games played. |
#' | total_rebounds_offensive | integer | The player's total offensive rebounds over the games played. |
#' | total_rebounds_defensive | integer | The player's total defensive rebounds over the games played. |
#' | total_blocks | integer | The player's total blocked shots over the games played. |
#' | total_turnovers | integer | The player's total turnovers over the games played. |
#' | total_fouls | integer | The player's total personal fouls over the games played. |
#' | total_assists | integer | The player's total assists over the games played. |
#' | total_plus_minus | integer | The player's total plus/minus (point differential while on court) over the games played. |
#' | total_efficiency | integer | The player's total efficiency (FIBA EFF) over the games played. |
#' | total_play_time_in_seconds | integer | The player's total playing time in seconds over the games played. |
#' | total_points | integer | The player's total points over the games played. |
#' | total_field_goals_made | integer | The player's total field goals made over the games played. |
#' | total_field_goals_attempted | integer | The player's total field goals attempted over the games played. |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_two_points_made | integer | The player's total two-point field goals made over the games played. |
#' | total_two_points_attempted | integer | The player's total two-point field goals attempted over the games played. |
#' | two_points_percentage | double | Two-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_three_points_made | integer | The player's total three-point field goals made over the games played. |
#' | total_three_points_attempted | integer | The player's total three-point field goals attempted over the games played. |
#' | three_points_percentage | double | Three-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_free_throws_made | integer | The player's total free throws made over the games played. |
#' | total_free_throws_attempted | integer | The player's total free throws attempted over the games played. |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_double_doubles | integer | The player's total double-doubles over the games played. |
#' | total_triple_doubles | integer | The player's total triple-doubles over the games played. |
#' | total_quadruple_doubles | integer | The player's total quadruple-doubles over the games played. |
#' | total_quintuple_doubles | integer | The player's total quintuple-doubles over the games played. |
#' | total_points_from_turnovers | integer | The player's total points from turnovers over the games played. |
#' | total_fast_break_points | integer | The player's total fast-break points over the games played. |
#' | total_second_chance_points | integer | The player's total second-chance points over the games played. |
#' | total_points_in_the_paint | integer | The player's total points in the paint over the games played. |
#' | total_steals | integer | The player's total steals over the games played. |
#' | rank_points_per_game | double | Rank in the competition by points per game (1 = highest). |
#' | rank_rebounds_per_game | double | Rank in the competition by rebounds per game (1 = highest). |
#' | rank_assists_per_game | double | Rank in the competition by assists per game (1 = highest). |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_player_stats(player_id = 211501, comp = 208182))
#' }
fiba_gdap_player_stats <- function(player_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("player_stats", "getgdapplayercompetitionstatisticsbyplayerid", list(
    gdapPlayerId = .fiba_int_id(player_id, "player_id", call = call),
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: ranking zones**
#' @description
#' FIBA world-ranking zones.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdaprankingzones`
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_ranking_zones()")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | zone_ranking_id | integer | Ranking zone id (getgdaprankingzones key space: 1 = World ... 5 = Europe). |
#' | code | character | Ranking zone code (W, AF, AM, AS, EU). |
#' | official_name | character | Official name of the ranking zone (World, FIBA Europe, FIBA Americas...). |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_ranking_zones <- function(return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("ranking_zones", "getgdaprankingzones", list(), return_parsed, call = rlang::current_env())
}

#' @title **FIBA GDAP: roster**
#' @description
#' A team's roster at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param discipline_format (character, optional) Optional; the site passes its discipline format. 5x5 answers
#'   the same as omitting it (verified on awards and rosters)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_code | character | Team code (FIBA country code or club abbreviation). |
#' | team_name | character | Team name (the country for a national team, the club for a club team). |
#' | organisation_id | integer | Stable federation or club id (Int64), the same in every competition and season (64 = Germany). |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
#' | date_of_birth | character | Date of birth, YYYY-MM-DD. |
#' | uniform_number | character | Jersey number (a string). |
#' | uniform_name | character | Name printed on the jersey. |
#' | position | character | Playing position (roster: Point Guard...; game page: PG, SG, SF, PF, C). |
#' | height_in_cm | integer | Player height in centimetres. |
#' | height_in_feet_inches | character | Height, feet and inches string (6'7"). |
#' | nationality | character | FIBA code of the main nationality. |
#' | is_on_final_roster | logical | True when on the final (12-player) roster. |
#' | games_played | integer | Games played in the competition. |
#' | club_id | integer | Organisation id of the player's club (organisationId key space). |
#' | club_name | character | Club at the time of the competition. |
#' | country_fiba_code | character | FIBA code of the country the person represents. |
#' | club_country_fiba_code | character | FIBA code of the club's country. |
#' | is_captain | logical | True for the team captain. |
#' | is_player_free_agent | logical | True when the player had no club. |
#' | final_roster_member_status_code | character | Roster entry status: VALID, PARTIAL (incomplete registration). |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_roster(team_id = 279569))
#' }
fiba_gdap_roster <- function(team_id, discipline_format = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("roster", "getgdapcompetitionteamrosterbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call),
    disciplineFormat = discipline_format
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: roster coaches**
#' @description
#' A team's coaches on its roster at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param discipline_format (character, optional) Optional; the site passes its discipline format. 5x5 answers
#'   the same as omitting it (verified on awards and rosters)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_roster_coaches(team_id = 279569)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_code | character | Team code (FIBA country code or club abbreviation). |
#' | team_name | character | Team name (the country for a national team, the club for a club team). |
#' | organisation_id | integer | Stable federation or club id (Int64), the same in every competition and season (64 = Germany). |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
#' | function | character | Role: Head Coach, Coach, Assistant Coach. |
#' | is_head_coach | integer | 1 for the head coach, 0 otherwise (an integer flag, not a boolean). |
#' | is_assistant_coach | integer | 1 for an assistant coach, else null (integer flag). |
#' | is_accompanying_coach | logical | Accompanying-coach flag; always null in the samples, values unverified. |
#' | coach_display_order | integer | Display order; null when unset. |
#' | is_on_final_roster | logical | True when on the final (12-player) roster. |
#' | nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
#' | coach_license_organisation_name | character | Federation that issued the coaching licence. |
#' | coach_license_country_code | character | FIBA code of the licensing federation's country. |
#' | final_roster_member_status_code | character | Roster entry status: VALID, PARTIAL (incomplete registration). |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_roster_coaches <- function(team_id, discipline_format = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("roster_coaches", "getgdapcompetitionteamrosterbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call),
    disciplineFormat = discipline_format
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: roster latest**
#' @description
#' A team's latest roster (same shape as the roster).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamlatestrosterbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_roster_latest(team_id = 282183)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_code | character | Team code (FIBA country code or club abbreviation). |
#' | team_name | character | Team name (the country for a national team, the club for a club team). |
#' | organisation_id | integer | Stable federation or club id (Int64), the same in every competition and season (64 = Germany). |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
#' | date_of_birth | character | Date of birth, YYYY-MM-DD. |
#' | uniform_number | character | Jersey number (a string). |
#' | uniform_name | character | Name printed on the jersey. |
#' | position | character | Playing position (roster: Point Guard...; game page: PG, SG, SF, PF, C). |
#' | height_in_cm | integer | Player height in centimetres. |
#' | height_in_feet_inches | character | Height, feet and inches string (6'7"). |
#' | nationality | character | FIBA code of the main nationality. |
#' | is_on_final_roster | logical | True when on the final (12-player) roster. |
#' | games_played | integer | Games played in the competition. |
#' | club_id | integer | Organisation id of the player's club (organisationId key space). |
#' | club_name | character | Club at the time of the competition. |
#' | country_fiba_code | character | FIBA code of the country the person represents. |
#' | club_country_fiba_code | character | FIBA code of the club's country. |
#' | is_captain | logical | True for the team captain. |
#' | is_player_free_agent | logical | True when the player had no club. |
#' | final_roster_member_status_code | character | Roster entry status: VALID, PARTIAL (incomplete registration). |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_roster_latest <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("roster_latest", "getgdapcompetitionteamlatestrosterbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: round gamedays**
#' @description
#' Rounds of a competition with their game days.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionroundgamedaysbyid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_round_gamedays(comp = 208182)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | FIBA competition id (Int64) the rounds belong to; the comp argument. |
#' | round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
#' | round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
#' | round_parent_round_id | integer | roundId of the round this one belongs to; null for a top-level round. |
#' | round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
#' | round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
#' | round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | round_round_number | integer | Round number within the competition (1-based). |
#' | round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
#' | round_round_type_code | character | Round type code: G group, NG non-group (knockout), S super round. |
#' | round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
#' | round_start_date | character | Round start, local date-time. |
#' | round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
#' | round_has_teams_assigned | logical | True once the round's teams are known. |
#' | round_round_kind | character | Standard Round or Qualifiers. |
#' | round_standing_header_code | character | Code of the standings table the round feeds. |
#' | round_standing_header_name | character | Name of the standings table the round feeds. |
#' | round_qualified_team_information | character | Qualification note of the round; null in every sample. |
#' | round_round_order | integer | Display order of the round. |
#' | gamedays | character | Game days of the round as a JSON string; empty (null) for the competitions sampled. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_round_gamedays <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("round_gamedays", "getgdapcompetitionroundgamedaysbyid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: round standings**
#' @description
#' Group standings of every round of a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | round_id | integer | Round id (Int64) the group belongs to. |
#' | round_name | character | Round name (Preliminary Round, Final Round...). |
#' | round_code | character | Round code (a short code such as G or F). |
#' | group_name | character | Group name within the round (A, B...). |
#' | group_status_code | character | Group status code (COMPL when the group is complete). |
#' | rank | integer | Rank in the group. |
#' | team_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_code | character | Team code (FIBA country code or club abbreviation). |
#' | team_official_name | character | Official team name (the country for a national team, the club for a club team). |
#' | team_short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
#' | games_played | integer | Games played in the group. |
#' | games_lost | integer | Losses in the group. |
#' | games_won | integer | Wins in the group. |
#' | points | integer | Standing points (2 per win, 1 per loss). |
#' | points_against | integer | Points conceded. |
#' | points_for | integer | Points the team scored in the group's games. |
#' | starting_position | integer | Seed / draw position in the group. |
#' | final_position | integer | Final position in the group. |
#' | plus_minus | integer | Point differential (pointsFor - pointsAgainst). |
#' | penalty_points | integer | Standing points deducted. |
#' | draw_points | integer | Points for a draw (0); null when not applicable. |
#' | group_game_results | character | This team's games in the group. Stored as a JSON string. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_round_standings(comp = 208182))
#' }
fiba_gdap_round_standings <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("round_standings", "getgdaproundsbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: rounds**
#' @description
#' Rounds of a competition (group stage, knockout rounds).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
#' | game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
#' | parent_round_id | integer | roundId of the round this one belongs to; null for a top-level round. |
#' | round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
#' | round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
#' | round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | round_number | integer | Round number within the competition (1-based). |
#' | round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
#' | round_type_code | character | Round type code: G group, NG non-group (knockout), S super round. |
#' | round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
#' | start_date | character | Round start, local date-time. |
#' | end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
#' | has_teams_assigned | logical | True once the round's teams are known. |
#' | round_kind | character | Standard Round or Qualifiers. |
#' | standing_header_code | character | Code of the standings table the round feeds. |
#' | standing_header_name | character | Name of the standings table the round feeds. |
#' | qualified_team_information | character | Qualification note of the round; null in every sample. |
#' | round_order | integer | Display order of the round. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_rounds(comp = 208182))
#' }
fiba_gdap_rounds <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("rounds", "getgdaproundsbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: schedule**
#' @description
#' Schedule and results of one competition (edition): one row per game.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamesbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
#' | game_name | character | Technical game name '`<roundId>`-`<groupPairingCode>`-`<gameNumber>`'. |
#' | game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
#' | status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
#' | team_a_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_a_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_a_code | character | Team code (national: FIBA country code; club: a club abbreviation such as OOST). |
#' | team_a_official_name | character | Official name of team A: the country for a national team, the club for a club team. |
#' | team_a_short_name | character | Short name of team A: the country code for a national team, the club's short name for a club. |
#' | team_b_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_b_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_b_code | character | Team code (national: FIBA country code; club: a club abbreviation such as NANT). |
#' | team_b_official_name | character | Official name of team B: the country for a national team, the club for a club team. |
#' | team_b_short_name | character | Short name of team B: the country code for a national team, the club's short name for a club. |
#' | team_a_score | integer | Final score of team A. |
#' | team_b_score | integer | Final score of team B. |
#' | is_live | logical | True while the game is being played. |
#' | current_period | character | Last period reached ('Q4', 'OT1'). |
#' | chrono | character | Game clock of the current period, 'mm:ss' ('00:00' when finished). |
#' | live_game_status | integer | Live state code: 999 on every finished game; 5 seen on a finished 2024 youth game; mapping unverified. |
#' | current_period_status | character | State of the current period: E = ended (the only value sampled). |
#' | host_city | character | City of the venue. |
#' | host_country | character | Country of the venue (name; a FIBA code in getgdapgameswithleaderdetailsbyteamid). |
#' | host_country_code | character | FIBA code of the venue's country. |
#' | venue_id | integer | Venue id (GDAP key space; 0 = unknown). |
#' | venue_name | character | Name of the arena the game is played in. |
#' | game_date_time | character | Tip-off in venue-local wall-clock time, ISO 8601 without offset (T00:00:00 when hasTimeGameDateTime is false). |
#' | game_date_time_utc | character | Tip-off in UTC, ISO 8601 without the Z. |
#' | has_time_game_date_time | logical | False when only the date is known (the time part is then 00:00:00). |
#' | iana_time_zone | character | IANA time zone of the venue. |
#' | utc_offset | double | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
#' | is_postponed | logical | True when the game was postponed. |
#' | is_played_behind_closed_doors | logical | True when played without spectators. |
#' | venue_capacity | integer | Venue capacity (0 = unknown). |
#' | spectators | integer | Attendance at the game, as recorded by FIBA. |
#' | statistic_system | character | Live-stats system that scored the game: OVR (FIBA's Olympic/World Cup system), FLS (FIBA LiveStats), null before about 2006. |
#' | group_id | character | Group id (GDAP key space). |
#' | group_pairing_code | character | Group letter (group play) or pairing number (knockout bracket slot). |
#' | round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
#' | round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
#' | round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | round_round_number | integer | Round number within the competition (1-based). |
#' | round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
#' | round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
#' | round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
#' | round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
#' | round_start_date | character | Round start, local date-time. |
#' | round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
#' | round_round_kind | character | Standard Round or Qualifiers. |
#' | round_round_order | integer | Display order of the round. |
#' | competition_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | competition_competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
#' | competition_season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the sdv season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029), whose sdv mapping is an open Phase B decision. |
#' | competition_official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
#' | competition_start | character | First day, YYYY-MM-DD. |
#' | competition_end | character | Last day, YYYY-MM-DD. |
#' | competition_status | character | Competition status: In Progress, Completed, Closed. |
#' | competition_age_category | character | Age category (Senior, Under 16...). |
#' | competition_gender | character | Men or Women: the gender of the competition. |
#' | competition_fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
#' | competition_zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
#' | competition_zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
#' | competition_zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
#' | competition_zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
#' | competition_zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
#' | competition_zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
#' | competition_competition_type | character | National Teams or Clubs. |
#' | competition_competition_category_is_league | logical | True for league-format club competitions. |
#' | competition_competition_category_age_type | character | Age type code: S senior, U16. |
#' | competition_competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
#' | competition_competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
#' | competition_official_flag_item_code | character | Official-status code: O = official. |
#' | competition_official_flag_item_name | character | Official-status label. |
#' | competition_official | character | Official-status label. |
#' | competition_discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
#' | competition_competition_marketing_name_competition_marketing_name_id | integer | Competition family id (201 = World Cup, 112 = BCL tier 1, 211 = EuroLeague Women); the `<histId>` of /en/history/ pages. |
#' | competition_competition_marketing_name_marketing_name | character | Competition family name; slugified it is the `<histSlug>` of /en/history/ pages. |
#' | competition_competition_marketing_name_code | character | Family code; null in every sample. |
#' | game_statistic_status_code | character | Box-score validation status: VALID. |
#' | game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
#' | game_result_status_code | character | Result validation status: VALID. |
#' | game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
#' | window_code | character | Qualifier window code; null otherwise. |
#' | window_name | character | Qualifier window name; null otherwise. |
#' | team_a_from | character | How team A qualified for this slot ('Winner of Game 87', '1st of group C'); null in group play. |
#' | team_b_from | character | How team B qualified for this slot ('Winner of Game 88', '2nd of group A'); null in group play. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_schedule(comp = 208182))
#' }
fiba_gdap_schedule <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("schedule", "getgdapgamesbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team games**
#' @description
#' A team's games with each team's leaders.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgameswithleaderdetailsbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
#' | round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
#' | game_number | character | Game number within the round or pairing (a string: '1', 'A'). |
#' | status | character | Game status label (Validated). |
#' | status_code | character | Game status code: VALID (validated result), CLOS (closed, pre-2000 rows). |
#' | game_day | integer | Game day number within the round. |
#' | team_a_from | character | How team A qualified for this slot; null in group play. |
#' | team_b_from | character | How team B qualified for this slot; null in group play. |
#' | team_a_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_a_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_a_code | character | Team code (national: FIBA country code; club: a club abbreviation such as OOST). |
#' | team_a_official_name | character | Official name of team A: the country for a national team, the club for a club team. |
#' | team_a_short_name | character | Short name of team A: the country code for a national team, the club's short name for a club. |
#' | team_b_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_b_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | team_b_code | character | Team code (national: FIBA country code; club: a club abbreviation such as NANT). |
#' | team_b_official_name | character | Official name of team B: the country for a national team, the club for a club team. |
#' | team_b_short_name | character | Short name of team B: the country code for a national team, the club's short name for a club. |
#' | team_a_score | integer | Team A points in the period. |
#' | team_b_score | integer | Team B points in the period. |
#' | host_city | character | City of the venue. |
#' | host_country | character | Country of the venue (name; a FIBA code in getgdapgameswithleaderdetailsbyteamid). |
#' | host_country_code | character | FIBA code of the venue's country; always null in the samples, values unverified. |
#' | venue_id | integer | Venue id (GDAP key space; 0 = unknown). |
#' | venue_name | character | Name of the arena the game is played in. |
#' | game_date_time | character | Tip-off in venue-local wall-clock time, ISO 8601 without offset (T00:00:00 when hasTimeGameDateTime is false). |
#' | game_date_time_utc | character | Tip-off in UTC, ISO 8601 without the Z. |
#' | has_time_game_date_time | logical | False when only the date is known (the time part is then 00:00:00). |
#' | iana_time_zone | character | IANA time zone of the venue. |
#' | utc_offset | double | Venue UTC offset at tip-off, in hours (Float64: a half-hour zone such as India +5.5 or Adelaide +9.5 is a fraction; whole hours in every sample). |
#' | buy_tickets_url | character | Ticket link; always '' in the samples. |
#' | watch_url | character | Stream link; always '' in the samples. |
#' | is_postponed | logical | True when the game was postponed. |
#' | is_played_behind_closed_doors | logical | True when played without spectators. |
#' | venue_capacity | integer | Venue capacity (0 = unknown). |
#' | spectators | integer | Attendance at the game, as recorded by FIBA. |
#' | is_live | logical | True while the game is being played. |
#' | leaders_team_a_points_leader_player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | leaders_team_a_points_leader_first_name | character | Given name(s) as registered with FIBA. |
#' | leaders_team_a_points_leader_last_name | character | Last name (officials: upper case). |
#' | leaders_team_a_points_leader_statistics_value | integer | Leader's value for the statistic. |
#' | leaders_team_a_points_leader_nationality | character | FIBA code of the main nationality. |
#' | leaders_team_a_points_leader_rank | integer | Rank (1 = first). |
#' | leaders_team_a_rebounds_leader_player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | leaders_team_a_rebounds_leader_first_name | character | Given name(s) as registered with FIBA. |
#' | leaders_team_a_rebounds_leader_last_name | character | Last name (officials: upper case). |
#' | leaders_team_a_rebounds_leader_statistics_value | integer | Leader's value for the statistic. |
#' | leaders_team_a_rebounds_leader_nationality | character | FIBA code of the main nationality. |
#' | leaders_team_a_rebounds_leader_rank | integer | Rank (1 = first). |
#' | leaders_team_a_assists_leader_player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | leaders_team_a_assists_leader_first_name | character | Given name(s) as registered with FIBA. |
#' | leaders_team_a_assists_leader_last_name | character | Last name (officials: upper case). |
#' | leaders_team_a_assists_leader_statistics_value | integer | Leader's value for the statistic. |
#' | leaders_team_a_assists_leader_nationality | character | FIBA code of the main nationality. |
#' | leaders_team_a_assists_leader_rank | integer | Rank (1 = first). |
#' | leaders_team_b_points_leader_player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | leaders_team_b_points_leader_first_name | character | Given name(s) as registered with FIBA. |
#' | leaders_team_b_points_leader_last_name | character | Last name (officials: upper case). |
#' | leaders_team_b_points_leader_statistics_value | integer | Leader's value for the statistic. |
#' | leaders_team_b_points_leader_nationality | character | FIBA code of the main nationality. |
#' | leaders_team_b_points_leader_rank | integer | Rank (1 = first). |
#' | leaders_team_b_rebounds_leader_player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | leaders_team_b_rebounds_leader_first_name | character | Given name(s) as registered with FIBA. |
#' | leaders_team_b_rebounds_leader_last_name | character | Last name (officials: upper case). |
#' | leaders_team_b_rebounds_leader_statistics_value | integer | Leader's value for the statistic. |
#' | leaders_team_b_rebounds_leader_nationality | character | FIBA code of the main nationality. |
#' | leaders_team_b_rebounds_leader_rank | integer | Rank (1 = first). |
#' | leaders_team_b_assists_leader_player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | leaders_team_b_assists_leader_first_name | character | Given name(s) as registered with FIBA. |
#' | leaders_team_b_assists_leader_last_name | character | Last name (officials: upper case). |
#' | leaders_team_b_assists_leader_statistics_value | integer | Leader's value for the statistic. |
#' | leaders_team_b_assists_leader_nationality | character | FIBA code of the main nationality. |
#' | leaders_team_b_assists_leader_rank | integer | Rank (1 = first). |
#' | periods | character | Score by period. Stored as a JSON string. |
#' | game_statistic_status_code | character | Box-score validation status: VALID. |
#' | game_play_by_play_status_code | character | Play-by-play availability flag: VALID or EMPTY. UNRELIABLE: World Cup 2014 and EuroBasket 2017 say EMPTY but their game pages carry full play-by-play; always check the page. |
#' | game_result_status_code | character | Result validation status: VALID. |
#' | game_result_additional_information | character | Free-text result note (forfeit, overtime remark); null when none. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_team_games(team_id = 279569))
#' }
fiba_gdap_team_games <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_games", "getgdapgameswithleaderdetailsbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team player stats**
#' @description
#' Per-game averages of every player of a team at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamstatisticsbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_team_player_stats(team_id = 279569)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | FIBA competition id (Int64) the averages belong to. |
#' | player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | uniform_number | character | Jersey number (a string). |
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | points_per_game | double | The player's average points per game played. |
#' | rebounds_per_game | double | The player's average rebounds per game played. |
#' | rebounds_offensive_per_game | double | The player's average offensive rebounds per game played. |
#' | rebounds_defensive_per_game | double | The player's average defensive rebounds per game played. |
#' | assists_per_game | double | The player's average assists per game played. |
#' | blocks_per_game | double | The player's average blocked shots per game played. |
#' | turnovers_per_game | double | The player's average turnovers per game played. |
#' | fouls_per_game | double | The player's average personal fouls per game played. |
#' | plus_minus_per_game | double | The player's average plus/minus (point differential while on court) per game played. |
#' | efficiency_per_game | double | The player's average efficiency (FIBA EFF) per game played. |
#' | play_time_in_seconds_per_game | double | The player's average playing time in seconds per game played. |
#' | field_goals_made_per_game | double | The player's average field goals made per game played. |
#' | field_goals_attempted_per_game | double | The player's average field goals attempted per game played. |
#' | two_points_made_per_game | double | The player's average two-point field goals made per game played. |
#' | two_points_attempted_per_game | double | The player's average two-point field goals attempted per game played. |
#' | three_points_made_per_game | double | The player's average three-point field goals made per game played. |
#' | three_points_attempted_per_game | double | The player's average three-point field goals attempted per game played. |
#' | free_throws_made_per_game | double | The player's average free throws made per game played. |
#' | free_throws_attempted_per_game | double | The player's average free throws attempted per game played. |
#' | points_from_turnovers_per_game | double | The player's average points from turnovers per game played. |
#' | fast_break_points_per_game | double | The player's average fast-break points per game played. |
#' | second_chance_points_per_game | double | The player's average second-chance points per game played. |
#' | points_in_the_paint_per_game | double | The player's average points in the paint per game played. |
#' | steals_per_game | double | The player's average steals per game played. |
#' | total_games_played | integer | The player's total games played over the games played. |
#' | total_games_won | integer | The player's total games won over the games played. |
#' | total_games_lost | integer | The player's total games lost over the games played. |
#' | total_rebounds | integer | The player's total rebounds over the games played. |
#' | total_rebounds_offensive | integer | The player's total offensive rebounds over the games played. |
#' | total_rebounds_defensive | integer | The player's total defensive rebounds over the games played. |
#' | total_blocks | integer | The player's total blocked shots over the games played. |
#' | total_turnovers | integer | The player's total turnovers over the games played. |
#' | total_fouls | integer | The player's total personal fouls over the games played. |
#' | total_assists | integer | The player's total assists over the games played. |
#' | total_plus_minus | integer | The player's total plus/minus (point differential while on court) over the games played. |
#' | total_efficiency | integer | The player's total efficiency (FIBA EFF) over the games played. |
#' | total_play_time_in_seconds | integer | The player's total playing time in seconds over the games played. |
#' | total_points | integer | The player's total points over the games played. |
#' | total_field_goals_made | integer | The player's total field goals made over the games played. |
#' | total_field_goals_attempted | integer | The player's total field goals attempted over the games played. |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_two_points_made | integer | The player's total two-point field goals made over the games played. |
#' | total_two_points_attempted | integer | The player's total two-point field goals attempted over the games played. |
#' | two_points_percentage | double | Two-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_three_points_made | integer | The player's total three-point field goals made over the games played. |
#' | total_three_points_attempted | integer | The player's total three-point field goals attempted over the games played. |
#' | three_points_percentage | double | Three-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_free_throws_made | integer | The player's total free throws made over the games played. |
#' | total_free_throws_attempted | integer | The player's total free throws attempted over the games played. |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_double_doubles | integer | The player's total double-doubles over the games played. |
#' | total_triple_doubles | integer | The player's total triple-doubles over the games played. |
#' | total_quadruple_doubles | integer | The player's total quadruple-doubles over the games played. |
#' | total_quintuple_doubles | integer | The player's total quintuple-doubles over the games played. |
#' | total_points_from_turnovers | integer | The player's total points from turnovers over the games played. |
#' | total_fast_break_points | integer | The player's total fast-break points over the games played. |
#' | total_second_chance_points | integer | The player's total second-chance points over the games played. |
#' | total_points_in_the_paint | integer | The player's total points in the paint over the games played. |
#' | total_steals | integer | The player's total steals over the games played. |
#' | rank | integer | Rank (1 = first). |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_team_player_stats <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_player_stats", "getgdapcompetitionteamstatisticsbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team staff**
#' @description
#' Coaches of every team of a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapteamstaffbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_team_staff(comp = 208182)")
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | FIBA team id (Int64), one per team per competition; the team the coach is registered with. |
#' | team_name | character | Team name the coach is registered with. |
#' | team_code | character | Team code (GER, USA...) the coach is registered with. |
#' | person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P_`<id>` = gdapPlayerId. |
#' | first_name | character | Given name(s) as registered with FIBA. |
#' | last_name | character | Last name (officials: upper case). |
#' | gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
#' | function | character | Role: Head Coach, Coach, Assistant Coach. |
#' | is_head_coach | integer | 1 for the head coach, 0 otherwise (an integer flag, not a boolean). |
#' | is_assistant_coach | integer | 1 for an assistant coach, else null (integer flag). |
#' | is_accompanying_coach | logical | Accompanying-coach flag; always null in the samples, values unverified. |
#' | coach_display_order | integer | Display order; null when unset. |
#' | is_on_final_roster | logical | True when on the final (12-player) roster. |
#' | nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
#' | coach_license_organisation_name | character | Federation that issued the coaching licence. |
#' | coach_license_country_code | character | FIBA code of the licensing federation's country. |
#' | final_roster_member_status_code | character | Roster entry status; always null in the samples, values unverified. |
#'
#' @family FIBA Functions
#' @export
fiba_gdap_team_staff <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_staff", "getgdapteamstaffbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team stats**
#' @description
#' A team's per-game averages and totals at a competition, with the bench totals.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamstatisticsbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | points_per_game | double | The team's average points per game played. |
#' | rebounds_per_game | double | The bench players' average rebounds per game played. |
#' | rebounds_offensive_per_game | double | The bench players' average offensive rebounds per game played. |
#' | rebounds_defensive_per_game | double | The bench players' average defensive rebounds per game played. |
#' | assists_per_game | double | The team's average assists per game played. |
#' | blocks_per_game | double | The team's average blocked shots per game played. |
#' | turnovers_per_game | double | The bench players' average turnovers per game played. |
#' | fouls_per_game | double | The bench players' average personal fouls per game played. |
#' | plus_minus_per_game | double | The team's average plus/minus (point differential while on court) per game played. |
#' | efficiency_per_game | double | The team's average efficiency (FIBA EFF) per game played. |
#' | play_time_in_seconds_per_game | double | The team's average playing time in seconds per game played. |
#' | field_goals_made_per_game | double | The team's average field goals made per game played. |
#' | field_goals_attempted_per_game | double | The team's average field goals attempted per game played. |
#' | two_points_made_per_game | double | The team's average two-point field goals made per game played. |
#' | two_points_attempted_per_game | double | The team's average two-point field goals attempted per game played. |
#' | three_points_made_per_game | double | The team's average three-point field goals made per game played. |
#' | three_points_attempted_per_game | double | The team's average three-point field goals attempted per game played. |
#' | free_throws_made_per_game | double | The team's average free throws made per game played. |
#' | free_throws_attempted_per_game | double | The team's average free throws attempted per game played. |
#' | points_from_turnovers_per_game | double | The team's average points from turnovers per game played. |
#' | fast_break_points_per_game | double | The team's average fast-break points per game played. |
#' | second_chance_points_per_game | double | The team's average second-chance points per game played. |
#' | points_in_the_paint_per_game | double | The team's average points in the paint per game played. |
#' | from_bench_points_per_game | double | The team's average points by bench players per game played. |
#' | steals_per_game | double | The team's average steals per game played. |
#' | total_games_played | integer | The bench players' total games played over the games played. |
#' | total_games_won | integer | The team's total games won over the games played. |
#' | total_games_lost | integer | The team's total games lost over the games played. |
#' | total_rebounds | integer | The bench players' total rebounds over the games played. |
#' | total_rebounds_offensive | integer | The bench players' total offensive rebounds over the games played. |
#' | total_rebounds_defensive | integer | The bench players' total defensive rebounds over the games played. |
#' | total_blocks | integer | The team's total blocked shots over the games played. |
#' | total_turnovers | integer | The bench players' total turnovers over the games played. |
#' | total_fouls | integer | The bench players' total personal fouls over the games played. |
#' | total_assists | integer | The team's total assists over the games played. |
#' | total_plus_minus | integer | The team's total plus/minus (point differential while on court) over the games played. |
#' | total_efficiency | integer | The team's total efficiency (FIBA EFF) over the games played. |
#' | total_play_time_in_seconds | integer | The team's total playing time in seconds over the games played. |
#' | total_points | integer | The team's total points over the games played. |
#' | total_field_goals_made | integer | The team's total field goals made over the games played. |
#' | total_field_goals_attempted | integer | The team's total field goals attempted over the games played. |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_two_points_made | integer | The team's total two-point field goals made over the games played. |
#' | total_two_points_attempted | integer | The team's total two-point field goals attempted over the games played. |
#' | two_points_percentage | double | Two-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_three_points_made | integer | The team's total three-point field goals made over the games played. |
#' | total_three_points_attempted | integer | The team's total three-point field goals attempted over the games played. |
#' | three_points_percentage | double | Three-point field-goal percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_free_throws_made | integer | The team's total free throws made over the games played. |
#' | total_free_throws_attempted | integer | The team's total free throws attempted over the games played. |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (over the competition; full float precision in averages). |
#' | total_double_doubles | integer | The team's total double-doubles over the games played. |
#' | total_triple_doubles | integer | The team's total triple-doubles over the games played. |
#' | total_quadruple_doubles | integer | The team's total quadruple-doubles over the games played. |
#' | total_quintuple_doubles | integer | The team's total quintuple-doubles over the games played. |
#' | total_points_from_turnovers | integer | The team's total points from turnovers over the games played. |
#' | total_fast_break_points | integer | The team's total fast-break points over the games played. |
#' | total_second_chance_points | integer | The team's total second-chance points over the games played. |
#' | total_points_in_the_paint | integer | The team's total points in the paint over the games played. |
#' | total_from_bench_points | integer | The team's total points by bench players over the games played. |
#' | total_steals | integer | The team's total steals over the games played. |
#' | biggest_lead | integer | Team's biggest lead in any game of the competition, points. |
#' | bench_total_games_played | integer | The bench players' total games played over the games played. |
#' | bench_rebounds_per_game | double | The bench players' average rebounds per game played. |
#' | bench_rebounds_offensive_per_game | double | The bench players' average offensive rebounds per game played. |
#' | bench_rebounds_defensive_per_game | double | The bench players' average defensive rebounds per game played. |
#' | bench_turnovers_per_game | double | The bench players' average turnovers per game played. |
#' | bench_fouls_per_game | double | The bench players' average personal fouls per game played. |
#' | bench_total_rebounds | integer | The bench players' total rebounds over the games played. |
#' | bench_total_rebounds_offensive | integer | The bench players' total offensive rebounds over the games played. |
#' | bench_total_rebounds_defensive | integer | The bench players' total defensive rebounds over the games played. |
#' | bench_total_turnovers | integer | The bench players' total turnovers over the games played. |
#' | bench_total_fouls | integer | The bench players' total personal fouls over the games played. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_team_stats(team_id = 279569))
#' }
fiba_gdap_team_stats <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_stats", "getgdapcompetitionteamstatisticsbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: teams**
#' @description
#' Teams of a competition with their profile (final ranking, per-game averages).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamsbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @return A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`) with the following columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | team_code | character | Team abbreviation (FIBA country code or club abbreviation). |
#' | short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
#' | profile_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
#' | profile_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#' | profile_name | character | Team name as registered for the competition. |
#' | profile_code | character | Team code (FIBA country code or club abbreviation). |
#' | profile_country_name | character | Country of the team, in English. |
#' | profile_country_code | character | Country FIBA code. |
#' | profile_gender | character | Men or Women: the gender of the team's competition. |
#' | profile_facebook | character | Facebook handle or URL; always null in the samples, values unverified. |
#' | profile_twitter | character | X/Twitter handle; always null in the samples, values unverified. |
#' | profile_instagram | character | Instagram handle; always null in the samples, values unverified. |
#' | profile_website | character | The team's website address. |
#' | profile_you_tube | character | YouTube handle; always null in the samples, values unverified. |
#' | profile_final_ranking | integer | Final rank in the competition. |
#' | profile_points_per_game | double | The team's average points per game played. |
#' | profile_rebounds_per_game | double | The team's average rebounds per game played. |
#' | profile_assists_per_game | double | The team's average assists per game played. |
#' | profile_rank_points_per_game | double | Rank in the competition by points per game (1 = highest). |
#' | profile_rank_rebounds_per_game | double | Rank in the competition by rebounds per game (1 = highest). |
#' | profile_rank_assists_per_game | double | Rank in the competition by assists per game (1 = highest). |
#' | profile_total_games_won | integer | The team's total games won over the games played. |
#' | profile_total_games_lost | integer | The team's total games lost over the games played. |
#' | profile_social_networks | character | Social-network handles. Stored as a JSON string. |
#' | profile_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
#' | status_code | character | Team entry status: APPR approved. |
#' | status_name | character | Team entry status label (Approved). |
#' | organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T_`<id>`. |
#'
#' @family FIBA Functions
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_teams(comp = 208182))
#' }
fiba_gdap_teams <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("teams", "getgdapcompetitionteamsbycompetitionid", list(
    profile = "true",
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

