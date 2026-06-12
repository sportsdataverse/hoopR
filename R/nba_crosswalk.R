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
