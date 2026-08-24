#' @title
#' **Basketball-Reference Standings**
#' @description
#' **Get end-of-season conference standings from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' No API key is required. Basketball-Reference rate-limits aggressive scraping
#' (~20 requests/minute) -- space repeated calls with `Sys.sleep()`.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       conference \tab character \tab Conference (\code{E} or \code{W}). \cr
#'       team \tab character \tab Team name (with playoff-seed marker stripped). \cr
#'       wins \tab integer \tab Wins. \cr
#'       losses \tab integer \tab Losses. \cr
#'       win_loss_pct \tab numeric \tab Win-loss percentage. \cr
#'       gb \tab character \tab Games behind the conference leader. \cr
#'       pts_per_g \tab numeric \tab Points scored per game. \cr
#'       opp_pts_per_g \tab numeric \tab Opponent points per game. \cr
#'       srs \tab numeric \tab Simple Rating System (point margin + SOS). \cr
#'       playoffs \tab logical \tab \code{TRUE} if the team made the playoffs (\code{*} marker). \cr
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
#'   try(bref_standings(season = 2024))
#' }
bref_standings <- function(season = most_recent_nba_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/leagues/NBA_", season, "_standings.html"))
      one <- function(id, conf) {
        d <- .bref_table(html, id)
        if (nrow(d) == 0) return(NULL)
        d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]
        d[["conference"]] <- conf
        d
      }
      df <- dplyr::bind_rows(one("confs_standings_E", "E"), one("confs_standings_W", "W"))
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c("team" = "team_name")))
      # the trailing '*' marks playoff teams -- surface it as a flag, clean the name
      if ("team" %in% colnames(df)) {
        df[["playoffs"]] <- grepl("\\*", df[["team"]])
        df[["team"]] <- trimws(gsub("\\*", "", df[["team"]]))
      }
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Standings from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no standings available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF standings for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
