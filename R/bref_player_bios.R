#' @title
#' **Basketball-Reference Player Bios / Index**
#' @description
#' **Get the Basketball-Reference player index for a starting letter, with bios,
#' from [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' Returns every player whose last name begins with `letter`, with career span,
#' position, listed height/weight, birth date, college(s) and the player's
#' Basketball-Reference id slug (the key used by [bref_player_game_log()] and the
#' other player-level `bref_*()` functions). This doubles as a Basketball-Reference
#' **player dictionary**. No API key is required. Basketball-Reference rate-limits
#' aggressive scraping (~20 requests/minute) -- space repeated calls with
#' `Sys.sleep()`.
#' @param letter (*character* required): Single letter `a`-`z` (last-name
#'   initial). Defaults to `"a"`.
#' @return A `hoopR_data` tibble with one row per player:
#'
#'    |col_name   |types     |description                                       |
#'    |:----------|:---------|:-------------------------------------------------|
#'    |player     |character |Player name.                                      |
#'    |player_id  |character |Basketball-Reference id slug (e.g. `jamesle01`).  |
#'    |year_min   |integer   |First season played.                              |
#'    |year_max   |integer   |Last season played.                               |
#'    |pos        |character |Position(s).                                      |
#'    |height     |character |Listed height (e.g. `6-9`).                       |
#'    |weight     |integer   |Listed weight (lbs).                              |
#'    |birth_date |character |Birth date.                                       |
#'    |colleges   |character |College(s).                                       |
#'    |letter     |character |Last-name initial (echoes the `letter` argument). |
#'
#' @keywords Basketball-Reference
#' @importFrom rvest read_html html_elements html_attr
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_player_bios(letter = "a"))
#' }
bref_player_bios <- function(letter = "a") {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      letter <- tolower(substr(letter, 1, 1))
      if (!grepl("^[a-z]$", letter)) stop("`letter` must be a single letter a-z", call. = FALSE)
      html <- .bref_text(paste0("/players/", letter, "/"))
      d <- .bref_table(html, "players")
      if (nrow(d) == 0) stop("Basketball-Reference player table not found", call. = FALSE)
      d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]

      # pull the BREF id slug from each row's player link
      doc <- rvest::read_html(gsub("-->", "", gsub("<!--", "", html, fixed = TRUE), fixed = TRUE))
      hrefs <- rvest::html_attr(
        rvest::html_elements(doc, "table#players th[data-stat='player'] a"), "href")
      ids <- sub("\\.html$", "", basename(hrefs))
      if (length(ids) == nrow(d)) {
        d[["player_id"]] <- ids
        d <- d[, c("player", "player_id", setdiff(colnames(d), c("player", "player_id"))), drop = FALSE]
      }

      d <- .bref_type_convert(d)
      d <- janitor::clean_names(dplyr::as_tibble(d))
      d[["letter"]] <- letter
      df <- make_hoopR_data(d, "Player bios from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No Basketball-Reference player bios for letter {letter}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF player bios for {letter}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
