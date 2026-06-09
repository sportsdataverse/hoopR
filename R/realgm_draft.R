#' @title
#' **RealGM NBA Draft Results**
#' @description
#' **Get the results of a past NBA draft from
#' [RealGM](https://basketball.realgm.com).**
#'
#' One row per selection (rounds 1 and 2, labelled by `round`) plus the listed
#' undrafted players (`round = NA`), including pre-draft team / international
#' club, age, years of service and nationality.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @param year Draft year (the calendar year the draft was held). Defaults to
#'   the most recently completed draft (`most_recent_nba_season() - 1`).
#' @return A `hoopR_data` tibble carrying `draft_year` and `round` columns:
#'
#'    |col_name       |types     |description                                 |
#'    |:--------------|:---------|:-------------------------------------------|
#'    |pick           |integer   |Overall pick number (`NA` for undrafted).   |
#'    |player         |character |Player name.                                |
#'    |team           |character |Drafting team abbreviation.                 |
#'    |draft_trades   |character |Draft-night trade note, if any.             |
#'    |pos            |character |Position.                                   |
#'    |ht             |character |Listed height.                              |
#'    |wt             |integer   |Listed weight (lbs).                        |
#'    |age            |numeric   |Age at draft.                               |
#'    |yos            |integer   |Years of service since.                     |
#'    |pre_draft_team |character |Pre-draft team / school / club.             |
#'    |class          |character |College class / draft eligibility note.     |
#'    |nationality    |character |Player nationality.                         |
#'    |round          |integer   |Draft round (`1`, `2`, or `NA` undrafted).  |
#'    |draft_year     |numeric   |Draft year (echoes `year`).                 |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble bind_rows
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_draft(year = 2020))
#' }
realgm_draft <- function(year = most_recent_nba_season() - 1L) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      tables <- .realgm_tables(.realgm_doc(sprintf("/nba/draft/past-drafts/%s", year)),
                               min_rows = 3)
      draft_tbls <- Filter(
        function(t) all(c("player", "pos", "ht") %in% colnames(t)),
        tables
      )
      if (!length(draft_tbls)) stop("RealGM draft tables not found", call. = FALSE)
      parts <- lapply(draft_tbls, function(t) {
        if ("pick" %in% colnames(t)) {
          picks <- suppressWarnings(as.numeric(t$pick))
          t$round <- ifelse(!is.na(picks) & picks > 30, 2L, 1L)
        } else {
          t$round <- NA_integer_
        }
        t
      })
      out <- dplyr::bind_rows(parts)
      out$draft_year <- as.numeric(year)
      df <- .realgm_finish(out, "NBA past draft from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM draft data for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM draft", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Draft Early Entrants**
#' @description
#' **Get the current NBA draft early-entrant and withdrawal list from
#' [RealGM](https://basketball.realgm.com).**
#'
#' Stacks RealGM's early-entry candidate tables (college and international
#' entrants and withdrawals) into one tibble.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per candidate (`player`, `pos`,
#'   `ht`, `wt`, `birth_date`, `college` / `pre_draft_team`, `class`,
#'   `draft_status`, `yos`, `nationality`).
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble bind_rows
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_early_entry())
#' }
realgm_early_entry <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      tables <- .realgm_tables(.realgm_doc("/nba/draft/early_entry/by_year"),
                               min_rows = 3)
      ee <- Filter(function(t) all(c("player", "pos") %in% colnames(t)), tables)
      if (!length(ee)) stop("RealGM early-entry tables not found", call. = FALSE)
      df <- .realgm_finish(dplyr::bind_rows(ee),
                           "NBA draft early entrants from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM early-entry data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM early entry", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
