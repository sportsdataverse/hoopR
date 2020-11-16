#' Get Division-I statistical trends
#'
#' @param browser User login session
#' @keywords Trends
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter
#' @export
#'
#' @examples
#' \dontrun{
#'  get_trends(browser)
#' }

get_trends <- function(browser){
    ### Pull Data
    url <- "https://kenpom.com/trends.php"
    page <- rvest::jump_to(browser, url)
    header_cols <- c("Season","Efficiency","Tempo","eFGpct","TOpct",
                     "ORpct","FTRate","FG2pct","FG3pct","FG3Apct",'FTpct',
                     "Apct","Blkpct","Stlpct","NonStlpct","AvgHgt",
                     "Continuity","HomeWinpct","PPG")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_nodes("table"))[[1]] %>%
      rvest::html_table() %>%
      as.data.frame()

    colnames(x) <- header_cols
    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$eFGpct)))
    )
    ### Store Data
    kenpom <- x

  return(kenpom)
}

#' Get officials rankings
#'
#' @param year Year of data to pull
#' @param browser User login session
#' @keywords Refs
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom dplyr select filter mutate
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @export
#'
#' @examples
#' \dontrun{
#'   get_officials(browser, year= 2020)
#' }

get_officials <- function(browser, year= 2020){
  assert_that(year>=2016, msg="Data only goes back to 2016")
  ### Pull Data
  url <- paste0("https://kenpom.com/officials.php?y=",year)
  page <- rvest::jump_to(browser, url)
  header_cols <- c("Rk","OfficialName","RefRating","Gms","Last.Game",
                   "Last.Game.1","Last.Game.2")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols
  x <- x %>%
    dplyr::select(-.data$Last.Game.2) %>%
    dplyr::filter(!is.na(as.numeric(.data$RefRating)))
  x <- dplyr::mutate(x,
                     "Year" = year)
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Home Court Advantage Estimates
#'
#' @param browser User login session
#' @keywords HCA
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter
#' @export
#'
#' @examples
#' \dontrun{
#'  get_hca(browser)
#' }

get_hca <- function(browser){

  url <- paste0("https://kenpom.com/hca.php")
  page <- rvest::jump_to(browser, url)
  header_cols <- c("Team",	"Conf",	"HCA","HCA.Rk",	"PF","PF.Rk",	"Pts","Pts.Rk",	"NST","NST.Rk",
                   "Blk","Blk.Rk",	"Elev","Elev.Rk")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$HCA)))
  )
  ### Store Data
  kenpom <- x

  return(kenpom)
}


#' Get Home Court Arenas
#' @param browser User login session
#' @param year Year of data to pull
#' @keywords Arenas
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate
#' @export
#'
#' @examples
#' \dontrun{
#'  get_arenas(browser, year=2020)
#' }

get_arenas <- function(browser, year=2020){

  assert_that(year>=2010, msg="Data only goes back to 2010")

  url <- paste0("https://kenpom.com/arenas.php?y=",year)

  page <- rvest::jump_to(browser, url)

  header_cols <- c("Rk","Team",	"Conf",	"Arena",
                   "Alternate")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols

  x <- dplyr::mutate(x,
                     "Year" = year)
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Game Attributes
#'
#' @param browser User login session
#' @param year Year of data to pull
#' @param attr Game Attribute, valid values include: \cr
#' 'Excitement', 'Tension','Dominance','MinWp','FanMatch',\cr
#' 'Upsets','Busts','Comeback','Window'
#' @keywords Game
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select mutate
#' @export
#'
#' @examples
#' \dontrun{
#'   get_game_attrs(browser,year=2020, attr = "Excitement")
#' }

get_game_attrs <- function(browser, year=2020, attr = "Excitement"){
  assertthat::assert_that(year>=2010, msg="Data only goes back to 2010")
  url <- paste0("https://kenpom.com/game_attrs.php?",
                "y=", year,
                "&s=", attr)
  page <- rvest::jump_to(browser, url)
  header_cols <- c("Rk","Data","Game",
                   "col","Location","Conf",
                   attr)

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()


  colnames(x) <- header_cols

  x <- dplyr::mutate(x,
                     "Year" = year)
  ### Store Data
  kenpom <- x %>% dplyr::select(-.data$col)

  return(kenpom)
}


#' Get FanMatch by date
#'
#' @param browser User_login session
#' @param date Date of games to pull (YYYY-MM-DD)
#'
#' @keywords FanMatch
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select filter mutate
#' @importFrom tidyr separate
#' @importFrom stringr str_extract str_match
#' @importFrom stringi stri_extract_last_regex
#' @export
#'
#' @examples
#' \dontrun{
#'   get_fanmatch(browser, date="2020-03-10")
#' }

get_fanmatch <- function(browser, date="2020-02-12"){

  url <- paste0("https://kenpom.com/fanmatch.php?",
                "d=", date)
  page <- rvest::jump_to(browser, url)
  header_cols <- c("Game","Prediction","Time(ET)",
                   "Location","ThrillScore","Comeback","Excitement")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols
  x <- x %>%
    tidyr::separate(.data$Game,
                    into = c("Winner","col"),
                    sep = ",",
                    extra = "merge")

  x <- x %>%
    dplyr::mutate(
      WinRk = stringr::str_extract(
        stringr::str_extract(.data$Winner,"[\\w]+"),"\\d{1,3}+"),
      WinTeam = stringr::str_extract(
        stringr::str_extract(.data$Winner,'[^\\d]+'),".+"),
      WinScore = stringr::str_extract(
        stringi::stri_extract_last_regex(.data$Winner,'[\\d]+'),"\\d{1,3}+"),
      Loser = stringr::str_extract(
        stringr::str_extract(.data$col,'[^\\[]+'),".+"),
      LossRk = stringr::str_extract(
        stringr::str_extract(.data$Loser,"[\\w]+"),"\\d{1,3}+"),
      LossTeam =
        stringr::str_match(.data$Loser,'\\d{1,3}\\s(.*?)\\s\\d{1,3}')[,2],
      LossScore = stringr::str_extract(
        stringi::stri_extract_last_regex(.data$Loser,'[\\d]+'),"\\d{1,3}+"),
      Poss = stringr::str_match(.data$col,'\\[(.*?)\\]')[,2],
      MVP = stringr::str_match(.data$col,'MVP\\:(.*)')[,2],
      Event = stringr::str_match(.data$col,'\\](.*)')[,2]
    )

  x <- dplyr::mutate(x,
                     "Date" = date)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Poss)))
  )
  ### Store Data
  kenpom <- x %>%
    dplyr::select(-.data$col,-.data$Winner,-.data$Loser,
                  .data$WinRk, .data$WinTeam, .data$WinScore,
                  .data$LossRk, .data$LossTeam, .data$LossScore,
                  .data$Poss, .data$Prediction, .data$ThrillScore,
                  .data$Comback, .data$Excitement, .data$MVP,
                  .data$Location, .data$"Time(ET)", .data$Event, .data$Date)

  return(kenpom)
}
