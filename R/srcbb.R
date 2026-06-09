# ---------------------------------------------------------------------------
# Sports-Reference men's college basketball (sports-reference.com/cbb)
# ---------------------------------------------------------------------------
#
# sports-reference.com/cbb is the college-basketball arm of Sports Reference and
# shares the same two scraping quirks Basketball-Reference does (comment-hidden
# tables; columns keyed by each cell's `data-stat` attribute). The `srcbb_*()`
# wrappers therefore reuse the shared `.bref_table()` / `.bref_type_convert()`
# parser, pointed at the cbb host. No account or API key is required;
# Sports-Reference rate-limits aggressive scraping (~20 requests/minute).

.srcbb_base_url <- "https://www.sports-reference.com"

#' Internal: GET a sports-reference.com/cbb page and return the body text
#' @param path Page path beginning with `/` (e.g. `"/cbb/seasons/2024-school-stats.html"`).
#' @return The response body as a character string.
#' @keywords internal
.srcbb_text <- function(path) {
  resp <- .retry_request(
    paste0(.srcbb_base_url, path),
    headers = c("User-Agent" = .bref_user_agent)
  )
  .resp_text(resp)
}

#' @title
#' **Sports-Reference Men's College Basketball School Stats**
#' @description
#' **Get men's college basketball season school (team) statistics from
#' [Sports-Reference](https://www.sports-reference.com/cbb/).**
#'
#' One row per school for a season. No account or API key is required.
#' Sports-Reference rate-limits aggressive scraping (~20 requests/minute) --
#' space repeated calls with `Sys.sleep()`.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024` for 2023-24). Defaults to `most_recent_mbb_season()`.
#' @param table (*character*): Which stats table -- one of `"basic"` (default),
#'   `"advanced"` or `"opponent"`.
#' @return A `hoopR_data` tibble with one row per school, carrying `season` and
#'   `table` columns. Columns vary by `table`; the `"basic"` table includes
#'   `school`, `g`, `wins`, `losses`, `srs`, `sos`, `pts`, `opp_pts`, shooting
#'   splits, rebounds, assists, steals, blocks, turnovers and fouls.
#' @keywords Sports-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Sports-Reference College Basketball Functions
#' @export
#' @examples
#' \donttest{
#'   try(srcbb_school_stats(season = 2024, table = "basic"))
#' }
srcbb_school_stats <- function(season = most_recent_mbb_season(), table = "basic") {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      spec <- switch(
        table,
        "basic"    = list(path = sprintf("/cbb/seasons/%s-school-stats.html", season),
                          id = "basic_school_stats"),
        "advanced" = list(path = sprintf("/cbb/seasons/%s-advanced-school-stats.html", season),
                          id = "adv_school_stats"),
        "opponent" = list(path = sprintf("/cbb/seasons/%s-opponent-stats.html", season),
                          id = "basic_opp_stats"),
        stop("`table` must be one of 'basic', 'advanced', 'opponent'", call. = FALSE)
      )
      html <- .srcbb_text(spec$path)
      d <- .bref_table(html, spec$id)
      if (nrow(d) == 0) stop("Sports-Reference school-stats table not found", call. = FALSE)
      # drop Sports-Reference blank "DUMMY" spacer columns (they collide as dups)
      d <- d[, !is.na(colnames(d)) & !colnames(d) %in% c("DUMMY", ""), drop = FALSE]
      d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]
      d <- .bref_type_convert(d)
      d <- janitor::clean_names(dplyr::as_tibble(d))
      if ("school_name" %in% names(d) && !"school" %in% names(d)) {
        names(d)[names(d) == "school_name"] <- "school"
      }
      if ("school" %in% names(d)) {
        d <- d[!is.na(d[["school"]]) & d[["school"]] != "School", , drop = FALSE]
      }
      d[["season"]] <- as.integer(season)
      d[["table"]] <- table
      df <- make_hoopR_data(d, "Men's college basketball school stats from sports-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No sports-reference school stats for {season} ({table})!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching sports-reference school stats for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **Sports-Reference Men's College Basketball AP Poll**
#' @description
#' **Get the men's college basketball AP poll history for a season from
#' [Sports-Reference](https://www.sports-reference.com/cbb/).**
#'
#' One row per ranked school with its week-by-week AP poll position (preseason
#' through final). No account or API key is required.
#' @param season (*integer* required): Season, 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per ranked school (`school`,
#'   `conf`, and week-by-week poll columns), carrying a `season` column.
#' @keywords Sports-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Sports-Reference College Basketball Functions
#' @export
#' @examples
#' \donttest{
#'   try(srcbb_rankings(season = 2024))
#' }
srcbb_rankings <- function(season = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .srcbb_text(sprintf("/cbb/seasons/men/%s-polls.html", season))
      d <- .bref_table(html, "ap-polls")
      if (nrow(d) == 0) stop("Sports-Reference AP poll table not found", call. = FALSE)
      d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]
      d <- .bref_type_convert(d)
      d <- janitor::clean_names(dplyr::as_tibble(d))
      d[["season"]] <- as.integer(season)
      df <- make_hoopR_data(d, "Men's college basketball AP poll from sports-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No sports-reference AP poll for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching sports-reference AP poll for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
