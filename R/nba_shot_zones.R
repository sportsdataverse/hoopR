# ---------------------------------------------------------------------------
# NBA shot-zone classification
#
# R port of sportsdataverse-py sportsdataverse/nba/nba_shot_zones.py::add_shot_zones.
# Classifies every field-goal attempt in a hoopR V3 PBP frame into one of five
# NBA shot zones, mirroring the pbpstats-core convention used by sdv-py.
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# .add_shot_zones — internal classifier
# ---------------------------------------------------------------------------

#' @importFrom dplyr mutate case_when
#' @noRd
.add_shot_zones <- function(pbp) {
  # Never-raise on empty input
  if (nrow(pbp) == 0L) {
    pbp$shot_zone <- character(0L)
    return(pbp)
  }

  pbp <- dplyr::mutate(
    pbp,
    shot_zone = dplyr::case_when(
      # Rule 1: non-FG rows → NA
      !(.data$event_type %in% c("1", "2")) ~ NA_character_,
      # Rule 2: corner 3 — abs(x) >= 220 AND y <= 87.5
      .data$shot_value == 3L & abs(.data$x_legacy) >= 220 & .data$y_legacy <= 87.5 ~ "corner_3",
      # Rule 3: any other 3-pointer
      .data$shot_value == 3L ~ "above_the_break_3",
      # Rule 4: restricted area — distance < 4 ft
      .data$shot_distance < 4 ~ "restricted_area",
      # Rule 5: paint (non-RA) — distance < 8 ft AND close to the lane
      .data$shot_distance < 8 & abs(.data$x_legacy) <= 80 ~ "in_the_paint_non_ra",
      # Rule 6: everything else
      TRUE ~ "mid_range"
    )
  )

  pbp
}


# ---------------------------------------------------------------------------
# nba_shot_zones — public API
# ---------------------------------------------------------------------------

#' **Fetch NBA Play-by-Play and Classify Field-Goal Attempts by Shot Zone**
#' @name nba_shot_zones
NULL
#' @title
#' **Fetch NBA Play-by-Play and Classify Field-Goal Attempts by Shot Zone**
#' @rdname nba_shot_zones
#' @author Saiem Gilani
#' @param game_id A length-1 character string — the ten-character NBA Stats
#'   game identifier (e.g. \code{"0022200001"} for the first game of the
#'   2022-23 regular season).
#' @param ... Reserved for future keyword arguments (currently ignored).
#' @return Returns a \code{data.frame} containing the full V3 play-by-play for
#'   \code{game_id} with an appended \code{shot_zone} column:
#'
#'    |col_name            |types     |description                                                                                                 |
#'    |:-------------------|:---------|:-----------------------------------------------------------------------------------------------------------|
#'    |event_type          |character |Play event type code. \code{"1"} = MadeShot, \code{"2"} = MissedShot, \code{"3"} = FreeThrow, etc.         |
#'    |shot_value          |integer   |Point value of the shot attempt (2 or 3); 0 for non-FGA events.                                            |
#'    |x_legacy            |numeric   |Horizontal court coordinate (legacy units). Negative = left side of the court.                              |
#'    |y_legacy            |numeric   |Vertical court coordinate (legacy units). Values near 0 = baseline.                                         |
#'    |shot_distance       |numeric   |Distance from the basket in feet.                                                                           |
#'    |shot_zone           |character |Shot-zone classification. One of \code{"corner_3"}, \code{"above_the_break_3"}, \code{"restricted_area"}, \code{"in_the_paint_non_ra"}, \code{"mid_range"}. \code{NA} on non-field-goal rows.|
#'
#'   All other columns from the V3 PBP schema (\code{nba_pbp()}) are also
#'   present.  Returns a 0-row frame when the game cannot be fetched (never-raise).
#'
#'   **Shot zone definitions (pbpstats-core aligned):**
#'   \itemize{
#'     \item \code{"corner_3"} — three-point attempt with
#'       \code{abs(x_legacy) >= 220} and \code{y_legacy <= 87.5}
#'       (baseline corner area).
#'     \item \code{"above_the_break_3"} — all other three-point attempts.
#'     \item \code{"restricted_area"} — two-point attempt within 4 ft of the basket.
#'     \item \code{"in_the_paint_non_ra"} — two-point attempt 4–8 ft from
#'       the basket and within 80 legacy units of the paint center
#'       (\code{abs(x_legacy) <= 80}).
#'     \item \code{"mid_range"} — all remaining two-point attempts.
#'   }
#' @keywords NBA Lineup Functions
#' @family NBA Lineup Functions
#' @export
#' @details
#' ```r
#'  df <- nba_shot_zones(game_id = "0022200001")
#'  print(table(df$shot_zone, useNA = "ifany"))
#' ```
#' @examples
#' \donttest{
#'   try({
#'     df <- nba_shot_zones(game_id = "0022200001")
#'     print(df[!is.na(df$shot_zone), c("shot_distance", "shot_zone")])
#'   })
#' }
nba_shot_zones <- function(game_id, ...) {
  pbp <- nba_pbp(game_id = game_id, on_court = FALSE, version = "v3")
  .add_shot_zones(pbp)
}
