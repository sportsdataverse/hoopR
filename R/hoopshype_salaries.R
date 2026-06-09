#' @title
#' **HoopsHype Player Salaries**
#' @description
#' **Get NBA player salaries from [HoopsHype](https://hoopshype.com).**
#'
#' Returns the player salary table from HoopsHype's salaries page (current season
#' plus the projected future-season salaries HoopsHype lists). No API key is
#' required. Dollar figures are returned as numeric.
#'
#' **Note:** HoopsHype is a Next.js app that renders only its ~20 top-paid
#' players into static HTML; the full league list (≈670 contracts) is served by a
#' cursor-paginated GraphQL API that runs client-side and is not reachable
#' without executing the page's JavaScript. This function therefore returns
#' HoopsHype's highest-salary rows. For the full league use
#' `espn_nba_player_contracts()` (ESPN); for team-level cap totals use
#' [spotrac_team_cap()].
#' @return A `hoopR_data` tibble with one row per player. The first numeric
#'   column is the current-season salary; subsequent `x{year}_{year}` columns are
#'   future-season salaries as listed by HoopsHype:
#'
#'    |col_name |types     |description                                           |
#'    |:--------|:---------|:-----------------------------------------------------|
#'    |rank     |integer   |Salary rank.                                          |
#'    |player   |character |Player name.                                          |
#'    |salary   |numeric   |Current-season salary (USD).                          |
#'
#'   Future-season salary columns (e.g. `x2025_26`, `x2026_27`) are returned as
#'   numeric when present.
#'
#' @keywords Salaries
#' @importFrom rvest html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of
#' @family Salary & Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(hoopshype_salaries())
#' }
hoopshype_salaries <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      doc <- .ext_html("https://hoopshype.com/salaries/players/")
      tbs <- rvest::html_table(doc)
      # pick the first table that has a player column and real rows
      cand <- NULL
      for (t in tbs) {
        tc <- janitor::clean_names(t)
        if ("player" %in% colnames(tc) && nrow(tc) > 0) { cand <- tc; break }
      }
      if (is.null(cand)) stop("player salary table not found", call. = FALSE)

      df <- cand
      # drop a leading empty/unnamed first column if present
      if (colnames(df)[1] %in% c("x", "x_1")) names(df)[1] <- "rank"
      # parse currency columns to numeric
      dollar <- vapply(df, function(col) is.character(col) && any(grepl("\\$", col)), logical(1))
      for (j in which(dollar)) df[[j]] <- .parse_currency(df[[j]])
      # name the first salary column 'salary'
      sal_cols <- which(vapply(df, is.numeric, logical(1)) & colnames(df) != "rank")
      if (length(sal_cols)) names(df)[sal_cols[1]] <- "salary"

      df <- dplyr::as_tibble(df)
      df <- make_hoopR_data(df, "Player salaries from hoopshype.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No HoopsHype salary data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching HoopsHype salaries", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
