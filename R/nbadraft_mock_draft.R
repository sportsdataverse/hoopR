#' @title
#' **NBADraft.net Mock Draft**
#' @description
#' **Get the latest mock draft from [NBADraft.net](https://www.nbadraft.net).**
#'
#' Returns the current consensus mock draft (both rounds), one row per pick. No
#' API key is required.
#' @param year (*integer* optional): Draft year (e.g. `2025`). Defaults to the
#'   site's current mock; older years use the `/{year}/` path when available.
#' @return A `hoopR_data` tibble with one row per mock-draft pick:
#'
#'    |col_name |types     |description                                           |
#'    |:--------|:---------|:-----------------------------------------------------|
#'    |round    |integer   |Draft round (1 or 2).                                 |
#'    |pick     |integer   |Pick number within the round.                         |
#'    |team     |character |Projected team (`*` traded-pick marker stripped).     |
#'    |player   |character |Projected player.                                     |
#'    |height   |character |Player height.                                        |
#'    |weight   |character |Player weight.                                        |
#'    |position |character |Player position.                                      |
#'    |school   |character |Player school / pre-draft team.                       |
#'    |class    |character |Player class / draft eligibility.                     |
#'
#' @keywords Salaries
#' @importFrom rvest html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble bind_rows rename any_of
#' @family Salary & Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(nbadraft_mock_draft())
#' }
nbadraft_mock_draft <- function(year = NULL) {
  .args <- .capture_args()

  url <- if (is.null(year)) {
    "https://www.nbadraft.net/nba-mock-drafts/"
  } else {
    paste0("https://www.nbadraft.net/nba-mock-drafts/", year, "/")
  }

  df <- data.frame()

  tryCatch(
    expr = {
      doc <- .ext_html(url)
      tbs <- rvest::html_elements(doc, "table")
      grab <- function(node, round) {
        t <- janitor::clean_names(rvest::html_table(node))
        if (nrow(t) == 0 || !"player" %in% colnames(t)) return(NULL)
        t[["round"]] <- round
        t
      }
      # tables 1 and 2 are rounds 1 and 2 (table 3, when present, repeats round 1)
      r1 <- if (length(tbs) >= 1) grab(tbs[[1]], 1L) else NULL
      r2 <- if (length(tbs) >= 2) grab(tbs[[2]], 2L) else NULL
      df <- dplyr::bind_rows(r1, r2)
      df <- dplyr::rename(df, dplyr::any_of(c(
        "pick" = "number", "height" = "h", "weight" = "w",
        "position" = "p", "class" = "c")))
      if ("team" %in% colnames(df)) df[["team"]] <- trimws(gsub("\\*", "", df[["team"]]))
      df <- dplyr::as_tibble(df)
      df <- make_hoopR_data(df, "Mock draft from nbadraft.net", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no mock draft available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching NBADraft.net mock draft", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
