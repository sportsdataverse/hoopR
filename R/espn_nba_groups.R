# espn_nba_groups.R
# espn_nba_conferences() -- mirrors espn_mbb_conferences() using the NBA
# scoreboard-conferences endpoint.

#' **Get ESPN NBA Conferences**
#' @name espn_nba_conferences
NULL
#' @title
#' **Get ESPN NBA Conferences**
#' @rdname espn_nba_conferences
#' @author Saiem Gilani
#' @return A `hoopR_data` tibble with one row per conference:
#'
#'    Columns as documented in the shared [espn_mbb_conferences_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr select filter mutate rename
#' @import rvest
#' @export
#' @keywords NBA Conferences
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   try(espn_nba_conferences())
#' }
espn_nba_conferences <- function() {
  .args <- .capture_args()
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  conferences <- .empty_hoopR_data(
    "ESPN NBA Conferences Information from ESPN.com",
    cols = c(
      "group_id", "conference_short_name", "conference_uid",
      "conference_name", "conference_logo", "parent_group_id",
      "conference_id"
    )
  )

  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://site.api.espn.com/apis/site/v2/sports/basketball/nba",
        "/scoreboard/conferences?seasontype=2"
      )

      res <- .retry_request(play_base_url)

      check_status(res)

      resp <- res %>%
        .resp_text()

      conferences <- jsonlite::fromJSON(resp)[["conferences"]] %>%
        dplyr::select(-dplyr::any_of("subGroups")) %>%
        janitor::clean_names() %>%
        dplyr::filter(!(.data$group_id %in% c(0, 50))) %>%
        dplyr::mutate(
          group_id        = as.integer(.data$group_id),
          conference_id   = .data$group_id,
          parent_group_id = as.integer(.data$parent_group_id)
        ) %>%
        dplyr::rename(dplyr::any_of(c(
          "conference_short_name" = "short_name",
          "conference_uid"        = "uid",
          "conference_name"       = "name",
          "conference_logo"       = "logo"
        ))) %>%
        make_hoopR_data(
          "ESPN NBA Conferences Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no conferences info available!",
      args = .args
    ),
    warning = function(w) .report_api_warning(w, args = .args),
    finally = {}
  )
  return(conferences)
}
