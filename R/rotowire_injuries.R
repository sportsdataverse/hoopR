# ---------------------------------------------------------------------------
# RotoWire NBA injuries (JSON table endpoint)
# ---------------------------------------------------------------------------
#
# RotoWorld (rotoworld.com) was a long-standing NBA injuries source, but NBC
# shut it down. RotoWire (rotowire.com -- a separate, live company) is the modern
# equivalent. Its injury page renders client-side from a JSON endpoint
# (`/basketball/tables/injury-report.php`), so we read that JSON directly rather
# than scraping the rendered grid. Player / team / injury / status are openly
# available; the projected return date (`rDate`) is gated to subscribers and
# comes back as "Subscribers Only", which we map to NA.

.rotowire_user_agent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

#' @title
#' **RotoWire NBA Injury Report**
#' @description
#' **Get the current NBA injury report from
#' [RotoWire](https://www.rotowire.com/basketball/news.php?view=injuries).**
#'
#' One row per injured player with team, position, the injury, the current
#' designation (Out / Doubtful / Questionable / GTD / Day-To-Day) and a link to
#' the player's RotoWire page. The projected return date is RotoWire
#' subscriber-only content and is returned as `NA` for non-subscribers.
#'
#' This is the live replacement for the defunct RotoWorld injuries feed. See also
#' [bref_injuries()] for the Basketball-Reference injury report.
#' @return A `hoopR_data` tibble with one row per injured player:
#'
#'    |col_name    |types     |description                                      |
#'    |:-----------|:---------|:------------------------------------------------|
#'    |player_id   |character |RotoWire player id.                              |
#'    |player      |character |Player name.                                     |
#'    |first_name  |character |First name.                                      |
#'    |last_name   |character |Last name.                                       |
#'    |team        |character |Team abbreviation.                               |
#'    |position    |character |Position.                                        |
#'    |injury      |character |Injury (body part / description).                |
#'    |status      |character |Injury designation (Out, GTD, Questionable, ...).|
#'    |return_date |character |Projected return (`NA` unless a subscriber).     |
#'    |url         |character |RotoWire player page URL.                        |
#'
#' @keywords RotoWire
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @family Injury Functions
#' @export
#' @examples
#' \donttest{
#'   try(rotowire_injuries())
#' }
rotowire_injuries <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      resp <- .retry_request(
        "https://www.rotowire.com/basketball/tables/injury-report.php?team=ALL&pos=ALL",
        headers = c(
          "User-Agent" = .rotowire_user_agent,
          "Accept"     = "application/json, text/plain, */*",
          "Referer"    = "https://www.rotowire.com/basketball/news.php?view=injuries"
        )
      )
      raw <- jsonlite::fromJSON(.resp_text(resp))
      if (!is.data.frame(raw) || nrow(raw) == 0) stop("No RotoWire injury data returned", call. = FALSE)

      get <- function(nm) if (nm %in% names(raw)) raw[[nm]] else rep(NA_character_, nrow(raw))
      strip_html <- function(x) {
        x <- gsub("<[^>]*>", "", x %||% NA_character_)
        x <- trimws(x)
        x[x == "" | grepl("subscribers only", x, ignore.case = TRUE)] <- NA_character_
        x
      }
      out <- dplyr::tibble(
        player_id   = as.character(get("ID")),
        player      = get("player"),
        first_name  = get("firstname"),
        last_name   = get("lastname"),
        team        = get("team"),
        position    = get("position"),
        injury      = get("injury"),
        status      = get("status"),
        return_date = strip_html(get("rDate")),
        url         = ifelse(is.na(get("URL")), NA_character_,
                             paste0("https://www.rotowire.com", get("URL")))
      )
      df <- make_hoopR_data(out, "NBA injury report from rotowire.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No RotoWire injury data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RotoWire injuries", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
