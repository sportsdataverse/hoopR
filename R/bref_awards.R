#' @title
#' **Basketball-Reference Awards Voting**
#' @description
#' **Get end-of-season award voting from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' Returns the voting results for the major end-of-season awards (MVP, Rookie of
#' the Year, Defensive Player of the Year, Sixth Man, Most Improved, Clutch
#' Player, Coach of the Year) in one tidy tibble, one row per candidate per
#' award. No API key is required. Basketball-Reference rate-limits aggressive
#' scraping (~20 requests/minute) -- space repeated calls with `Sys.sleep()`.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @return A `hoopR_data` tibble with one row per award candidate:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       award \tab character \tab Award slug (\code{mvp}, \code{roy}, \code{dpoy}, \code{smoy}, \code{mip}, \code{clutch_poy}, \code{coy}). \cr
#'       rank \tab integer \tab Finish in the voting. \cr
#'       player \tab character \tab Player (or coach) name. \cr
#'       age \tab integer \tab Age. \cr
#'       team \tab character \tab Team abbreviation. \cr
#'       votes_first \tab numeric \tab First-place votes. \cr
#'       points_won \tab numeric \tab Voting points won. \cr
#'       points_max \tab numeric \tab Maximum possible voting points. \cr
#'       award_share \tab numeric \tab Share of the maximum voting points. \cr
#'       season \tab integer \tab Season (echoes the \code{season} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of bind_rows
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_awards(season = 2024))
#' }
bref_awards <- function(season = most_recent_nba_season()) {
  .args <- .capture_args()

  awards <- c("mvp", "roy", "dpoy", "smoy", "mip", "clutch_poy", "coy")
  voting_cols <- c("rank", "player", "name_display", "age", "team_id", "votes_first",
                   "points_won", "points_max", "award_share")

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/awards/awards_", season, ".html"))
      parse_one <- function(id) {
        d <- .bref_table(html, id)
        if (nrow(d) == 0) return(NULL)
        d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]
        d <- d[, intersect(voting_cols, colnames(d)), drop = FALSE]
        d[["award"]] <- id
        d
      }
      df <- dplyr::bind_rows(lapply(awards, parse_one))
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c("player" = "name_display", "team" = "team_id")))
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Award voting from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no award voting available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF award voting for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
