#' @title
#' **Bart Torvik T-Rank Ratings**
#' @description
#' **Get year-end / current T-Rank team ratings and adjusted efficiencies from
#' [barttorvik.com](https://barttorvik.com).**
#'
#' Pulls the full T-Rank team table for a season (the `{year}_team_results.csv`
#' file). No API key is required. Data is available from 2008 to present.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024` for the 2023-24 season). Defaults to `most_recent_mbb_season()`.
#' @eval .returns_rd("torvik_ratings", inline = FALSE, unit = "team")
#' @keywords Torvik
#' @importFrom data.table fread
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble mutate
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_ratings(year = 2024))
#' }
torvik_ratings <- function(year = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      txt <- .torvik_text(paste0("/", year, "_team_results.csv"))
      # Older files quote one header ("Fun Rk, adjt"). fread resolves it but
      # warns, and the warning handler below would discard the whole season.
      df <- withCallingHandlers(
        data.table::fread(text = txt, showProgress = FALSE),
        warning = function(w) {
          if (grepl("improper quoting", conditionMessage(w), fixed = TRUE)) invokeRestart("muffleWarning")
        }
      )
      df <- dplyr::as_tibble(janitor::clean_names(as.data.frame(df)))
      df[["year"]] <- as.integer(year)
      df <- make_hoopR_data(df, "Bart Torvik T-Rank ratings from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no T-Rank ratings available for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching T-Rank ratings for {year}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
