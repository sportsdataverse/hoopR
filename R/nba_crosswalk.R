# nba_crosswalk.R -- exported NBA cross-source crosswalk builders.
# Thin wrappers over the .bb_* engine in crosswalk_basketball.R.

#' @keywords internal
#' @importFrom dplyr transmute left_join mutate select if_else
.bb_assemble_team_crosswalk_nba <- function(espn, stats, fox, season) {
  espn2 <- dplyr::transmute(
    espn,
    espn_team_id = as.integer(.data$team_id),
    espn_abbreviation = as.character(.data$abbreviation),
    espn_display_name = as.character(.data$display_name),
    espn_short_name = as.character(.data$short_name),
    espn_location = as.character(.data$team),
    espn_mascot = as.character(.data$mascot),
    .team_key = .bb_normalize_team(.data$display_name))
  stats2 <- dplyr::transmute(
    stats,
    espn_team_id = as.integer(.data$espn_team_id),
    nba_team_id = as.character(.data$nba_team_id),
    nba_team_abbreviation = as.character(.data$nba_team_abbreviation),
    nba_team_name = as.character(.data$nba_team_name),
    nba_team_city = as.character(.data$nba_team_city),
    nba_team_slug = as.character(.data$nba_team_slug),
    nba_conference = as.character(.data$nba_conference),
    nba_division = as.character(.data$nba_division))
  if (is.null(fox) || !nrow(fox)) {
    fox2 <- data.frame(.team_key = character(), fox_team_id = character(),
                       fox_team_name = character(), stringsAsFactors = FALSE)
  } else {
    fox2 <- dplyr::transmute(
      fox, fox_team_id = as.character(.data$fox_team_id),
      fox_team_name = as.character(.data$fox_team_name),
      .team_key = .bb_normalize_team(.data$fox_team_name))
  }

  espn2 |>
    dplyr::left_join(stats2, by = "espn_team_id") |>
    dplyr::left_join(fox2, by = ".team_key") |>
    dplyr::mutate(
      season = as.integer(season),
      yahoo_team_id = NA_character_,
      yahoo_team_abbreviation = NA_character_,
      yahoo_team_name = NA_character_,
      match_method = dplyr::if_else(!is.na(.data$nba_team_id), "exact_name", "unmatched"),
      match_confidence = dplyr::if_else(!is.na(.data$nba_team_id), 1, NA_real_)) |>
    dplyr::select(
      "season", "espn_team_id", "espn_abbreviation", "espn_display_name",
      "espn_short_name", "espn_location", "espn_mascot",
      "nba_team_id", "nba_team_abbreviation", "nba_team_name", "nba_team_city",
      "nba_team_slug", "nba_conference", "nba_division",
      "fox_team_id", "fox_team_name",
      "yahoo_team_id", "yahoo_team_abbreviation", "yahoo_team_name",
      "match_method", "match_confidence")
}

#' **Get the NBA cross-source team crosswalk**
#' @name nba_team_crosswalk
NULL
#' @title
#' **Get the NBA cross-source team crosswalk**
#' @rdname nba_team_crosswalk
#' @author Saiem Gilani
#' @description
#' Build a wide, one-row-per-team crosswalk linking ESPN, NBA Stats, and Fox team
#' identities, keyed on `espn_team_id`. `nba_teams()` already supplies the
#' ESPN<->Stats linkage; this reshapes it and attaches Fox. Yahoo columns are NA
#' placeholders. NOTE: ESPN/Stats team endpoints are current-season snapshots, so
#' `season` is a stamp; historical relocations are not back-modeled live.
#' @param season NBA season per hoopR convention (default `most_recent_nba_season()`;
#'   e.g. 2025 for 2024-25).
#' @return A `hoopR_data` tibble, one row per team (ESPN / `nba_*` / Fox / Yahoo
#'   column groups + `match_method` / `match_confidence`).
#' @importFrom dplyr transmute
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#'   try(nba_team_crosswalk())
#' }
nba_team_crosswalk <- function(season = most_recent_nba_season()) {
  espn <- espn_nba_teams()
  nt <- nba_teams()
  stats <- dplyr::transmute(
    nt,
    espn_team_id = as.integer(.data$espn_team_id),
    nba_team_id = .data$team_id,
    nba_team_abbreviation = .data$team_abbreviation,
    nba_team_name = .data$team_name_full,
    nba_team_city = .data$team_city,
    nba_team_slug = .data$team_slug,
    nba_conference = .data$conference,
    nba_division = .data$division)
  fox <- tryCatch(fox_nba_teams(), error = function(e) NULL)
  .bb_assemble_team_crosswalk_nba(espn, stats, fox, season) |>
    make_hoopR_data("NBA team crosswalk (ESPN / NBA Stats / Fox)", Sys.time())
}

#' @keywords internal
#' @importFrom dplyr transmute full_join mutate select case_when if_else
.bb_assemble_schedule_crosswalk_nba <- function(espn_games, stats_games, team_xwalk, season) {
  e2s <- function(id) team_xwalk$espn_team_id[match(as.character(id), as.character(team_xwalk$nba_team_id))]

  espn2 <- dplyr::transmute(
    espn_games, game_date = .data$game_date,
    home_espn_team_id = as.integer(.data$espn_home_team_id),
    away_espn_team_id = as.integer(.data$espn_away_team_id),
    espn_game_id = as.character(.data$espn_game_id))
  stats2 <- dplyr::transmute(
    stats_games, game_date = .data$game_date,
    season_type = as.character(.data$season_type),
    home_espn_team_id = as.integer(e2s(.data$nba_home_team_id)),
    away_espn_team_id = as.integer(e2s(.data$nba_away_team_id)),
    nba_game_id = as.character(.data$nba_game_id),
    nba_game_code = as.character(.data$nba_game_code),
    nba_home_team_id = as.character(.data$nba_home_team_id),
    nba_away_team_id = as.character(.data$nba_away_team_id))

  key <- c("game_date", "home_espn_team_id", "away_espn_team_id")
  dplyr::full_join(espn2, stats2, by = key) |>
    dplyr::mutate(
      season = as.integer(season),
      fox_game_id = NA_character_, fox_home_team_id = NA_character_,
      fox_away_team_id = NA_character_, yahoo_game_id = NA_character_,
      match_method = dplyr::case_when(
        !is.na(.data$espn_game_id) & !is.na(.data$nba_game_id) ~ "both",
        !is.na(.data$espn_game_id) ~ "espn_only",
        TRUE ~ "stats_only"),
      match_confidence = dplyr::if_else(.data$match_method == "both", 1, NA_real_)) |>
    dplyr::select(
      "season", "season_type", "game_date",
      "home_espn_team_id", "away_espn_team_id",
      "espn_game_id", "nba_game_id", "nba_game_code",
      "nba_home_team_id", "nba_away_team_id",
      "fox_game_id", "fox_home_team_id", "fox_away_team_id",
      "yahoo_game_id", "match_method", "match_confidence")
}

#' **Get the NBA cross-source schedule crosswalk**
#' @name nba_schedule_crosswalk
NULL
#' @title
#' **Get the NBA cross-source schedule crosswalk**
#' @rdname nba_schedule_crosswalk
#' @author Saiem Gilani
#' @description
#' Build a wide, one-row-per-game crosswalk linking ESPN and NBA Stats game ids
#' (NA Fox/Yahoo placeholders). Dates from both sources are reduced to the local
#' Eastern-Time game date before joining. Note: the NBA Stats CDN serves the
#' current season only, so the live builder is effectively current-season;
#' historical coverage comes from cached release artifacts.
#' @param season NBA season per hoopR convention (default `most_recent_nba_season()`).
#' @return A `hoopR_data` tibble, one row per game.
#' @importFrom dplyr transmute bind_rows
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#'   try(nba_schedule_crosswalk())
#' }
nba_schedule_crosswalk <- function(season = most_recent_nba_season()) {
  team_xwalk <- nba_team_crosswalk(season = season)

  stats <- nba_schedule(season = year_to_season(season - 1))
  st <- if ("season_type_description" %in% names(stats)) {
    stats$season_type_description
  } else if ("week_name" %in% names(stats)) {
    stats$week_name
  } else {
    NA_character_
  }
  stats_games <- dplyr::transmute(
    stats,
    nba_game_id = .data$game_id, nba_game_code = .data$game_code,
    game_date = .bb_to_eastern(.data$game_date_time_utc),
    nba_home_team_id = .data$home_team_id, nba_away_team_id = .data$away_team_id,
    season_type = st)

  dates <- sort(unique(stats_games$game_date))
  espn_list <- lapply(dates, function(d) {
    sb <- tryCatch(espn_nba_scoreboard(season = as.integer(format(d, "%Y%m%d"))),
                   error = function(e) NULL)
    if (is.null(sb) || !nrow(sb)) return(NULL)
    dplyr::transmute(
      sb, espn_game_id = .data$game_id,
      game_date = .bb_to_eastern(.data$game_date_time),
      espn_home_team_id = .data$home_team_id, espn_away_team_id = .data$away_team_id)
  })
  espn_games <- dplyr::bind_rows(espn_list)

  .bb_assemble_schedule_crosswalk_nba(espn_games, stats_games, team_xwalk, season) |>
    make_hoopR_data("NBA schedule crosswalk (ESPN / NBA Stats)", Sys.time())
}

#' @keywords internal
#' @importFrom dplyr transmute mutate left_join select
.bb_assemble_player_crosswalk_nba <- function(espn, stats, fox, season, min_confidence = 0.92) {
  espn2 <- dplyr::mutate(espn, .block = as.character(.data$espn_team_id),
                         .name_key = .bb_normalize_name(.data$espn_full_name))
  l <- dplyr::transmute(espn2, .block = .data$.block, .id = .data$espn_athlete_id,
                        .name_key = .data$.name_key, .jersey = as.character(.data$espn_jersey),
                        .dob = as.character(.data$espn_birth_date))
  if (nrow(stats)) {
    r <- dplyr::transmute(stats, .block = as.character(.data$espn_team_id),
                          .id = as.character(.data$nba_player_id),
                          .name_key = .bb_normalize_name(.data$nba_player_name),
                          .jersey = as.character(.data$nba_jersey_num),
                          .dob = as.character(.data$nba_birth_date))
    m_stats <- .bb_fuzzy_match(l, r, min_confidence = min_confidence)
  } else {
    m_stats <- data.frame(left_id = l$.id, right_id = NA_character_,
                          match_method = "unmatched", match_confidence = NA_real_,
                          stringsAsFactors = FALSE)
  }
  if (nrow(fox)) {
    rf <- dplyr::transmute(fox, .block = as.character(.data$espn_team_id),
                           .id = as.character(.data$fox_athlete_id),
                           .name_key = .bb_normalize_name(.data$fox_player),
                           .jersey = as.character(.data$fox_jersey))
    lf <- dplyr::transmute(espn2, .block = .data$.block, .id = .data$espn_athlete_id,
                           .name_key = .data$.name_key, .jersey = as.character(.data$espn_jersey))
    m_fox <- .bb_fuzzy_match(lf, rf, min_confidence = min_confidence)
  } else {
    m_fox <- data.frame(left_id = l$.id, right_id = NA_character_,
                        match_confidence = NA_real_, stringsAsFactors = FALSE)
  }

  out <- espn2 |>
    dplyr::transmute(
      season = as.integer(season),
      espn_team_id = as.integer(.data$espn_team_id),
      team_abbreviation = as.character(.data$team_abbreviation),
      player_name = .data$.name_key,
      espn_athlete_id = as.character(.data$espn_athlete_id),
      espn_full_name = as.character(.data$espn_full_name),
      espn_jersey = as.character(.data$espn_jersey),
      espn_position = as.character(.data$espn_position)) |>
    dplyr::left_join(
      dplyr::transmute(m_stats, espn_athlete_id = .data$left_id,
                       nba_player_id = .data$right_id, match_method = .data$match_method,
                       match_confidence = .data$match_confidence),
      by = "espn_athlete_id") |>
    dplyr::left_join(
      dplyr::transmute(stats, nba_player_id = as.character(.data$nba_player_id),
                       nba_player_name = .data$nba_player_name,
                       nba_jersey_num = as.character(.data$nba_jersey_num),
                       nba_position = .data$nba_position),
      by = "nba_player_id") |>
    dplyr::left_join(
      dplyr::transmute(m_fox, espn_athlete_id = .data$left_id, fox_athlete_id = .data$right_id),
      by = "espn_athlete_id")

  if (nrow(fox)) {
    out <- dplyr::left_join(out,
      dplyr::transmute(fox, fox_athlete_id = as.character(.data$fox_athlete_id),
                       fox_player = .data$fox_player, fox_jersey = as.character(.data$fox_jersey),
                       fox_position_group = .data$fox_position_group),
      by = "fox_athlete_id")
  } else {
    out$fox_player <- NA_character_; out$fox_jersey <- NA_character_
    out$fox_position_group <- NA_character_
  }

  out |>
    dplyr::mutate(yahoo_player_id = NA_character_, yahoo_player_name = NA_character_,
                  match_keys = NA_character_) |>
    dplyr::select(
      "season", "espn_team_id", "team_abbreviation", "player_name",
      "espn_athlete_id", "espn_full_name", "espn_jersey", "espn_position",
      "nba_player_id", "nba_player_name", "nba_jersey_num", "nba_position",
      "fox_athlete_id", "fox_player", "fox_jersey", "fox_position_group",
      "yahoo_player_id", "yahoo_player_name",
      "match_method", "match_confidence", "match_keys")
}

#' **Get the NBA cross-source player crosswalk**
#' @name nba_player_crosswalk
NULL
#' @title
#' **Get the NBA cross-source player crosswalk**
#' @rdname nba_player_crosswalk
#' @author Saiem Gilani
#' @description
#' Build a wide, one-row-per-player-per-team crosswalk linking ESPN, NBA Stats,
#' and Fox player identities. Matching is deterministic: normalized exact name
#' within a team block, then Jaro-Winkler fuzzy with jersey/DOB tiebreakers.
#' Yahoo columns are NA placeholders.
#' @param season NBA season per hoopR convention (default `most_recent_nba_season()`).
#' @param min_confidence Jaro-Winkler similarity floor for fuzzy matches (default 0.92).
#' @return A `hoopR_data` tibble, one row per player per team (ESPN-anchored).
#' @importFrom dplyr transmute
#' @importFrom purrr map list_rbind
#' @export
#' @family NBA Crosswalk Functions
#' @examples
#' \donttest{
#'   try(nba_player_crosswalk())
#' }
nba_player_crosswalk <- function(season = most_recent_nba_season(), min_confidence = 0.92) {
  team_xwalk <- nba_team_crosswalk(season = season)
  stats_season <- year_to_season(season - 1)

  fetch_team <- function(i) {
    espn_id <- team_xwalk$espn_team_id[i]
    nba_id  <- team_xwalk$nba_team_id[i]
    fox_id  <- team_xwalk$fox_team_id[i]
    abbr    <- team_xwalk$espn_abbreviation[i]

    er <- tryCatch(espn_nba_team_roster(team_id = espn_id, season = season),
                   error = function(e) NULL)
    if (is.null(er) || !nrow(er)) return(NULL)
    espn <- dplyr::transmute(er,
      espn_team_id = as.integer(espn_id), team_abbreviation = abbr,
      espn_athlete_id = as.character(.data$athlete_id), espn_full_name = .data$full_name,
      espn_jersey = .data$jersey, espn_position = .data$position_abbrev,
      espn_birth_date = .data$birth_date)

    sr <- if (!is.na(nba_id))
      tryCatch(nba_commonteamroster(season = stats_season, team_id = nba_id),
               error = function(e) NULL) else NULL
    sr_tbl <- if (is.list(sr) && !is.data.frame(sr) && "CommonTeamRoster" %in% names(sr)) sr[["CommonTeamRoster"]] else sr
    stats <- if (!is.null(sr_tbl) && nrow(sr_tbl)) dplyr::transmute(sr_tbl,
      espn_team_id = as.integer(espn_id), nba_player_id = as.character(.data$PLAYER_ID),
      nba_player_name = .data$PLAYER, nba_jersey_num = .data$NUM,
      nba_position = .data$POSITION, nba_birth_date = .data$BIRTH_DATE)
      else data.frame(espn_team_id = integer(), nba_player_id = character(),
        nba_player_name = character(), nba_jersey_num = character(),
        nba_position = character(), nba_birth_date = character(), stringsAsFactors = FALSE)

    fr <- if (!is.na(fox_id))
      tryCatch(fox_nba_team_roster(team_id = fox_id), error = function(e) NULL) else NULL
    fox <- if (!is.null(fr) && nrow(fr)) dplyr::transmute(fr,
      espn_team_id = as.integer(espn_id), fox_athlete_id = as.character(.data$athlete_id),
      fox_player = .data$player,
      fox_jersey = if ("jersey" %in% names(fr)) .data$jersey else NA_character_,
      fox_position_group = .data$position_group)
      else data.frame(espn_team_id = integer(), fox_athlete_id = character(),
        fox_player = character(), fox_jersey = character(),
        fox_position_group = character(), stringsAsFactors = FALSE)

    .bb_assemble_player_crosswalk_nba(espn, stats, fox, season, min_confidence)
  }

  purrr::map(seq_len(nrow(team_xwalk)), fetch_team) |>
    purrr::list_rbind() |>
    make_hoopR_data("NBA player crosswalk (ESPN / NBA Stats / Fox)", Sys.time())
}
