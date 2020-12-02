#' Get Game Box Score
#'
#' @param game_id Game id of game to pull
#' @param year Year of game to pull
#' @param browser User login session
#' @keywords Ratings
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select filter mutate arrange bind_rows
#' @importFrom tidyr everything
#' @importFrom stringr str_remove
#' @export
#'
#' @examples
#' \dontrun{
#'   get_box_tables(browser, game_id = 1238, year = 2020)
#' }

get_box_tables <- function(browser, game_id, year){

  assertthat::assert_that(max_year>=2013, msg="Data only goes back to 2013")



  # check for internet
  check_internet()

  cat("Getting", year,"\n")
  ### Pull Data
  url <- paste0("https://kenpom.com/box.php?",
                "g=",game_id,
                "&y=",year)

  page <- rvest::jump_to(browser, url)
  header_cols <- c("Rk", "Team", "Conf", "W-L",
                   "AdjEM", "AdjO", "AdjO.Rk", "AdjD", "AdjD.Rk",
                   "AdjT", "AdjT.Rk", "Luck", "Luck.Rk",
                   "SOS.AdjEM", "SOS.AdjEM.Rk", "SOS.OppO", "SOS.OppO.Rk",
                   "SOS.OppD", "SOS.OppD.Rk", "NCSOS.AdjEM", "NCSOS.AdjEM.Rk")

  x <- (page %>%
          xml2::read_html() %>%
          rvest::html_nodes("#ratings-table"))[[1]] %>%
    rvest::html_table(fill=TRUE)

  colnames(x) <- header_cols
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$SOS.OppO)))
  )

  x <- dplyr::mutate(x,
                     "NCAA_Seed" = NA_integer_,
                     "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                     "Team" = sapply(.data$Team, function(arg) { stringr::str_remove(arg,"\\d+|\\*") }),
                     "Year" = year) %>%
    as.data.frame()

  x <- x %>%
    dplyr::mutate_at(
      c("Rk","AdjEM","AdjO","AdjO.Rk","AdjD","AdjD.Rk","AdjT","AdjT.Rk",
        "Luck","Luck.Rk","SOS.AdjEM","SOS.AdjEM.Rk","SOS.OppO","SOS.OppO.Rk",
        "SOS.OppD","SOS.OppD.Rk","NCSOS.AdjEM","NCSOS.AdjEM.Rk"), as.numeric) %>%
    dplyr::select(.data$Year, tidyr::everything())

  ### Store Data
  kenpom <- x

  kenpom <- kenpom %>%
    dplyr::arrange(-.data$Year, .data$Rk)
  return(kenpom)
}
