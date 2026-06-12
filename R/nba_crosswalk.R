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
