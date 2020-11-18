#' Get Division-I statistical trends
#'
#' @param browser User login session
#' @return A data frame with 19 columns:
#' \describe{
#'   \item{\code{Season}}{double.}
#'   \item{\code{Efficiency}}{double.}
#'   \item{\code{Tempo}}{double.}
#'   \item{\code{eFGpct}}{double.}
#'   \item{\code{TOpct}}{double.}
#'   \item{\code{ORpct}}{double.}
#'   \item{\code{FTRate}}{double.}
#'   \item{\code{FG2pct}}{double.}
#'   \item{\code{FG3pct}}{double.}
#'   \item{\code{FG3Apct}}{double.}
#'   \item{\code{FTpct}}{double.}
#'   \item{\code{Apct}}{double.}
#'   \item{\code{Blkpct}}{double.}
#'   \item{\code{Stlpct}}{double.}
#'   \item{\code{NonStlpct}}{double.}
#'   \item{\code{AvgHgt}}{double.}
#'   \item{\code{Continuity}}{double.}
#'   \item{\code{HomeWinpct}}{double.}
#'   \item{\code{PPG}}{double.}
#' }
#' @keywords Trends
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate_at
#' @export
#'
#' @examples
#' \dontrun{
#'  get_trends(browser)
#' }

get_trends <- function(browser){
  # check for internet
  check_internet()
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
  kenpom <- x %>%
    dplyr::mutate_at(c("Season","Efficiency","Tempo","eFGpct","TOpct",
                       "ORpct","FTRate","FG2pct","FG3pct","FG3Apct",'FTpct',
                       "Apct","Blkpct","Stlpct","NonStlpct","AvgHgt",
                       "Continuity","HomeWinpct","PPG"), as.numeric)

  return(kenpom)
}

#' Get officials rankings
#'
#' @param year Year of data to pull
#' @param browser User login session
#' @return A data frame with 7 columns:
#' \describe{
#'   \item{\code{Rk}}{integer.}
#'   \item{\code{OfficialName}}{character.}
#'   \item{\code{RefRating}}{double.}
#'   \item{\code{Gms}}{double.}
#'   \item{\code{Last.Game}}{character.}
#'   \item{\code{Last.Game.1}}{character.}
#'   \item{\code{Year}}{double.}
#' }
#' @keywords Refs
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom dplyr select filter mutate mutate_at
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @export
#'
#' @examples
#' \dontrun{
#'   get_officials(browser, year= 2020)
#' }

get_officials <- function(browser, year= 2020){
  assertthat::assert_that(year>=2016, msg="Data only goes back to 2016")
  # check for internet
  check_internet()
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
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$RefRating)))
  )
  x <- dplyr::mutate(x,
                     "Year" = year)
  suppressWarnings(
  x <- x %>%
    dplyr::mutate_at(c("Year","RefRating","Gms"), as.numeric) %>%
    as.data.frame()
  )
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Home Court Advantage Estimates
#'
#' @param browser User login session
#' @return A data frame with 14 columns:
#' \describe{
#'   \item{\code{Team}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{HCA}}{double.}
#'   \item{\code{HCA.Rk}}{double.}
#'   \item{\code{PF}}{double.}
#'   \item{\code{PF.Rk}}{double.}
#'   \item{\code{Pts}}{double.}
#'   \item{\code{Pts.Rk}}{double.}
#'   \item{\code{NST}}{double.}
#'   \item{\code{NST.Rk}}{double.}
#'   \item{\code{Blk}}{double.}
#'   \item{\code{Blk.Rk}}{double.}
#'   \item{\code{Elev}}{double.}
#'   \item{\code{Elev.Rk}}{double.}
#' }
#' @keywords HCA
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate_at
#' @export
#'
#' @examples
#' \dontrun{
#'  get_hca(browser)
#' }

get_hca <- function(browser){
  # check for internet
  check_internet()
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
  kenpom <- x %>%
    dplyr::mutate_at(c("HCA","HCA.Rk",	"PF","PF.Rk",	"Pts","Pts.Rk",
                       "NST","NST.Rk", "Blk","Blk.Rk",	"Elev","Elev.Rk"),
                     as.numeric)

  return(kenpom)
}


#' Get Home Court Arenas
#' @param browser User login session
#' @param year Year of data to pull
#' @return A data frame with 6 columns:
#' \describe{
#'   \item{\code{Rk}}{double.}
#'   \item{\code{Team}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{Arena}}{character.}
#'   \item{\code{Alternate}}{character.}
#'   \item{\code{Year}}{double.}
#' }
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

  assertthat::assert_that(year>=2010, msg="Data only goes back to 2010")

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
                     "Rk" = as.numeric(.data$Rk),
                     "Year" = as.numeric(year))
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
    rvest::html_table(fill=TRUE)


  colnames(x) <- header_cols

  x <- dplyr::mutate(x,
                     "Year" = year)%>%
    as.data.frame()
  ### Store Data
  kenpom <- x %>% dplyr::select(-.data$col)

  return(kenpom)
}


#' Get FanMatch by date
#'
#' @param browser User_login session
#' @param date Date of games to pull (YYYY-MM-DD)
#'
#' @return A data frame 16 columns:
#' \describe{
#'   \item{\code{Prediction}}{character.}
#'   \item{\code{Time(ET)}}{character.}
#'   \item{\code{Location}}{character.}
#'   \item{\code{ThrillScore}}{double.}
#'   \item{\code{Comeback}}{double.}
#'   \item{\code{Excitement}}{double.}
#'   \item{\code{WinRk}}{character.}
#'   \item{\code{WinTeam}}{character.}
#'   \item{\code{WinScore}}{double.}
#'   \item{\code{LossRk}}{character.}
#'   \item{\code{LossTeam}}{character.}
#'   \item{\code{LossScore}}{double.}
#'   \item{\code{Poss}}{double.}
#'   \item{\code{MVP}}{character.}
#'   \item{\code{Event}}{character.}
#'   \item{\code{Date}}{character.}
#' }
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
      rvest::html_nodes("#fanmatch-table"))[[1]] %>%
      rvest::html_table(fill=TRUE)

  colnames(x) <- header_cols
  suppressWarnings(
  x <- x %>%
    tidyr::separate(.data$Game,
                    into = c("Winner","col"),
                    sep = ",",
                    extra = "merge"))

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
  x <- x  %>%
    dplyr::select(-.data$col,-.data$Winner,-.data$Loser,
                  .data$WinRk, .data$WinTeam, .data$WinScore,
                  .data$LossRk, .data$LossTeam, .data$LossScore,
                  .data$Poss, .data$Prediction, .data$ThrillScore,
                  .data$Comeback, .data$Excitement, .data$MVP,
                  .data$Location, "Time(ET)", .data$Event, .data$Date)
  suppressWarnings(
  kenpom <- x %>%
    dplyr::mutate_at(c("WinScore","LossScore","Poss","ThrillScore","Comeback",
                       "Excitement"), as.numeric))

  return(kenpom)
}
