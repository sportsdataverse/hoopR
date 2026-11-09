#' @title
#' **RealGM NBA Standings**
#' @description
#' **Get the current NBA standings (both conferences) from
#' RealGM (basketball.realgm.com).**
#'
#' One row per team with record, win pct, games back, streak, last-ten, scoring
#' margin and home/away/division/conference splits. The Eastern and Western
#' conference tables are stacked and labelled by a `conference` column.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @eval .returns_rd("realgm_standings", inline = FALSE, unit = "team")
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble bind_rows
#' @concept RealGM Functions
#' @seealso [family_realgm] lists every function in this family.
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_standings())
#' }
realgm_standings <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      tables <- .realgm_tables(.realgm_doc("/nba/standings"))
      conf <- Filter(
        function(t) all(c("team", "w", "l", "pct") %in% colnames(t)) && nrow(t) >= 10,
        tables
      )
      if (length(conf) == 0) stop("RealGM standings tables not found", call. = FALSE)
      labels <- c("Eastern", "Western")
      parts <- lapply(seq_along(conf), function(i) {
        d <- conf[[i]]
        d$conference <- labels[min(i, length(labels))]
        d
      })
      df <- .realgm_finish(dplyr::bind_rows(parts),
                           "NBA standings from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM standings data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM standings", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Teams Index**
#' @description
#' **Get the NBA team index, with division and conference, from
#' RealGM (basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @eval .returns_rd("realgm_teams", inline = FALSE, unit = "team")
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble bind_rows
#' @concept RealGM Functions
#' @seealso [family_realgm] lists every function in this family.
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_teams())
#' }
realgm_teams <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      tables <- .realgm_tables(.realgm_doc("/nba/teams"), min_rows = 3)
      div_conf <- c(atlantic = "Eastern", central = "Eastern", southeast = "Eastern",
                    northwest = "Western", pacific = "Western", southwest = "Western")
      parts <- list()
      for (t in tables) {
        cn <- colnames(t)[1]
        if (!grepl("_division$", cn)) next
        division <- sub("_division$", "", cn)
        if (!division %in% names(div_conf)) next
        team <- t[[2]]
        team <- team[!is.na(team) & nzchar(trimws(team))]
        if (!length(team)) next
        parts[[length(parts) + 1]] <- data.frame(
          team = team,
          division = paste0(toupper(substr(division, 1, 1)), substr(division, 2, nchar(division))),
          conference = unname(div_conf[division]),
          stringsAsFactors = FALSE
        )
      }
      if (!length(parts)) stop("RealGM teams tables not found", call. = FALSE)
      df <- .realgm_finish(dplyr::bind_rows(parts),
                           "NBA teams index from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM teams data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM teams", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
