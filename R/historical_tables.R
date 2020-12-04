#' Get Team Efficiency History
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @return A data frame with 30 columns:
#' \describe{
#'   \item{\code{Year}}{double.}
#'   \item{\code{Team.Rk}}{double.}
#'   \item{\code{Team}}{character.}
#'   \item{\code{Coach}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{W-L}}{character.}
#'   \item{\code{AdjT}}{double.}
#'   \item{\code{AdjO}}{double.}
#'   \item{\code{AdjD}}{double.}
#'   \item{\code{eFGpct.Off}}{double.}
#'   \item{\code{TOpct.Off}}{double.}
#'   \item{\code{ORpct.Off}}{double.}
#'   \item{\code{FTR.Off}}{double.}
#'   \item{\code{FG2pct.Off}}{double.}
#'   \item{\code{FG3pct.Off}}{double.}
#'   \item{\code{FTpct.Off}}{double.}
#'   \item{\code{FG3Apct.Off}}{double.}
#'   \item{\code{Apct.Off}}{double.}
#'   \item{\code{APL.Off}}{double.}
#'   \item{\code{eFGpct.Def}}{double.}
#'   \item{\code{TOpct.Def}}{double.}
#'   \item{\code{ORpct.Def}}{double.}
#'   \item{\code{FTR.Def}}{double.}
#'   \item{\code{FG2pct.Def}}{double.}
#'   \item{\code{FG3pct.Def}}{double.}
#'   \item{\code{Blkpct.Def}}{double.}
#'   \item{\code{FG3Apct.Def}}{double.}
#'   \item{\code{Apct.Def}}{double.}
#'   \item{\code{AP.Def}}{double.}
#'   \item{\code{Foul2Particpct}}{double.}
#' }
#'
#' @keywords Team History
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html xml_remove
#' @importFrom dplyr filter mutate select mutate_at
#' @importFrom tidyr everything
#' @importFrom stringr str_remove
#' @export
#'
#' @examples
#'   \dontrun{
#'     get_team_history(browser, team = 'Florida St.')
#'   }
#'

get_team_history <- function(browser, team){


  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
              msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/history.php?",
                "t=",team_name)

  page <- rvest::jump_to(browser, url)

  header_cols<- c('Year','Team.Rk','Coach',	'Conf','W-L',	'AdjT', 'AdjO',	'AdjD',
                  'eFGpct.Off',	'TOpct.Off',	'ORpct.Off','FTR.Off',
                  'FG2pct.Off',	'FG3pct.Off',	'FTpct.Off',	'FG3Apct.Off',
                  'Apct.Off',	'APL.Off',
                  'eFGpct.Def', 'TOpct.Def',	'ORpct.Def',	'FTR.Def',
                  'FG2pct.Def',	'FG3pct.Def',
                  'Blkpct.Def',	'FG3Apct.Def',	'Apct.Def',
                  'AP.Def',	'Foul2Particpct')

  x<- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#player-table'))[[1]]

  ## removing national rankings for easier manipulation
  ## TODO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")
  xml2::xml_remove(tmrank)

  x <- x %>%
    rvest::html_table(fill=TRUE)


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$AdjT))) %>%
      dplyr::mutate_at(c('Year','Team.Rk','AdjT', 'AdjO',	'AdjD',
                         'eFGpct.Off',	'TOpct.Off',	'ORpct.Off','FTR.Off',
                         'FG2pct.Off',	'FG3pct.Off',	'FTpct.Off',	'FG3Apct.Off',
                         'Apct.Off',	'APL.Off',
                         'eFGpct.Def', 'TOpct.Def',	'ORpct.Def',	'FTR.Def',
                         'FG2pct.Def',	'FG3pct.Def',
                         'Blkpct.Def',	'FG3Apct.Def',	'Apct.Def',
                         'AP.Def',	'Foul2Particpct'), as.numeric)
  )
  x <- x %>%
    dplyr::mutate(Team = team_name) %>%
    dplyr::select(.data$Year, .data$Team.Rk,.data$Team,tidyr::everything())
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Coaching Resume
#'
#' @param browser User login session
#' @param coach Coach filter to select.
#'
#' @return A data frame with 30 columns:
#' \describe{
#'   \item{\code{Year}}{double.}
#'   \item{\code{Team.Rk}}{double.}
#'   \item{\code{Team}}{character.}
#'   \item{\code{Coach}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{W-L}}{character.}
#'   \item{\code{AdjT}}{double.}
#'   \item{\code{AdjO}}{double.}
#'   \item{\code{AdjD}}{double.}
#'   \item{\code{eFGpct.Off}}{double.}
#'   \item{\code{TOpct.Off}}{double.}
#'   \item{\code{ORpct.Off}}{double.}
#'   \item{\code{FTR.Off}}{double.}
#'   \item{\code{FG2pct.Off}}{double.}
#'   \item{\code{FG3pct.Off}}{double.}
#'   \item{\code{FTpct.Off}}{double.}
#'   \item{\code{FG3Apct.Off}}{double.}
#'   \item{\code{Apct.Off}}{double.}
#'   \item{\code{APL.Off}}{double.}
#'   \item{\code{eFGpct.Def}}{double.}
#'   \item{\code{TOpct.Def}}{double.}
#'   \item{\code{ORpct.Def}}{double.}
#'   \item{\code{FTR.Def}}{double.}
#'   \item{\code{FG2pct.Def}}{double.}
#'   \item{\code{FG3pct.Def}}{double.}
#'   \item{\code{Blkpct.Def}}{double.}
#'   \item{\code{FG3Apct.Def}}{double.}
#'   \item{\code{Apct.Def}}{double.}
#'   \item{\code{AP.Def}}{double.}
#'   \item{\code{Foul2Particpct}}{double.}
#' }
#'
#' @keywords Coach History
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html xml_remove
#' @importFrom dplyr filter mutate select mutate_at
#' @importFrom tidyr everything
#' @export
#'
#' @examples
#'   \dontrun{
#'    get_coach_history(browser, coach = 'Leonard Hamilton')
#'   }
#'
#'

get_coach_history <- function(browser, coach){
  coach_name <- gsub(" ","\\+",coach)

  ### Pull Data
  url <- paste0("https://kenpom.com/history.php?",
                "c=",coach_name)

  page <- rvest::jump_to(browser, url)

  header_cols<- c('Year','Team.Rk','Team',	'Conf','W-L',	'AdjT', 'AdjO',	'AdjD',
                  'eFGpct.Off',	'TOpct.Off',	'ORpct.Off','FTR.Off',
                  'FG2pct.Off',	'FG3pct.Off',	'FTpct.Off',	'FG3Apct.Off',
                  'Apct.Off',	'APL.Off',
                  'eFGpct.Def', 'TOpct.Def',	'ORpct.Def',	'FTR.Def',
                  'FG2pct.Def',	'FG3pct.Def',
                  'Blkpct.Def',	'FG3Apct.Def',	'Apct.Def',
                  'AP.Def',	'Foul2Particpct')

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#player-table'))[[1]]

  ## removing national rankings for easier manipulation
  ## TODO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")
  xml2::xml_remove(tmrank)

  x <- x %>%
    rvest::html_table()

  colnames(x) <- header_cols

  coach_name <- gsub("\\+"," ",coach)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$AdjT))) %>%
      dplyr::mutate_at(c('Year','Team.Rk','AdjT', 'AdjO',	'AdjD',
                         'eFGpct.Off',	'TOpct.Off',	'ORpct.Off','FTR.Off',
                         'FG2pct.Off',	'FG3pct.Off',	'FTpct.Off',	'FG3Apct.Off',
                         'Apct.Off',	'APL.Off',
                         'eFGpct.Def', 'TOpct.Def',	'ORpct.Def',	'FTR.Def',
                         'FG2pct.Def',	'FG3pct.Def',
                         'Blkpct.Def',	'FG3Apct.Def',	'Apct.Def',
                         'AP.Def',	'Foul2Particpct'), as.numeric)
  )
  x <- x %>%
    dplyr::mutate(Coach = coach_name) %>%
    dplyr::select(.data$Year, .data$Team.Rk,.data$Team, .data$Coach,tidyr::everything())
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Program Ratings
#'
#' @param browser User login session
#'
#' @return A data frame with 17 columns:
#' \describe{
#'   \item{\code{Rk}}{double.}
#'   \item{\code{Team}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{Rtg}}{double.}
#'   \item{\code{Best.Rk}}{double.}
#'   \item{\code{Best.Yr}}{double.}
#'   \item{\code{Worst.Rk}}{double.}
#'   \item{\code{Worst.Yr}}{double.}
#'   \item{\code{KP.Median}}{double.}
#'   \item{\code{Top10}}{double.}
#'   \item{\code{Top25}}{double.}
#'   \item{\code{Top50}}{double.}
#'   \item{\code{CH}}{double.}
#'   \item{\code{F4}}{double.}
#'   \item{\code{S16}}{double.}
#'   \item{\code{R1}}{double.}
#'   \item{\code{Chg}}{double.}
#' }
#'
#' @keywords Program Ratings
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes
#' @importFrom xml2 read_html xml_remove
#' @importFrom dplyr filter
#' @export
#' @examples
#' \dontrun{
#'   get_program_ratings(browser)
#' }

get_program_ratings <- function(browser){
  # check for internet
  check_internet()
  ### Pull Data
  url <- "https://kenpom.com/programs.php?"

  page <- rvest::jump_to(browser, url)

  header_cols<- c('Rk',	'Team',	'Conf','Rtg',
                  'Best.Rk','Best.Yr',
                  'Worst.Rk','Worst.Yr', 'KP.Median',
                  'Top10',	'Top25',	'Top50',	'CH',
                  'F4',	'S16',	'R1',	'Chg')

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#ratings-table'))[[1]]
  ## removing national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")

  xml2::xml_remove(tmrank)

  x <- x %>%
    rvest::html_table(fill=FALSE) %>%
    as.data.frame()

  colnames(x) <- header_cols
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Rtg))) %>%
      dplyr::mutate_at(c('Rk', 'Rtg', 'Best.Rk','Best.Yr',
                         'Worst.Rk','Worst.Yr', 'KP.Median',
                         'Top10',	'Top25',	'Top50',	'CH',
                         'F4',	'S16',	'R1',	'Chg'), as.numeric)
  )
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Single-Game Records for Team
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param conference_only Filter records to only conference games, default: FALSE
#' @keywords Single-Game Team Records
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate
#' @examples
#' \dontrun{
#'   get_records_team(browser, team = 'Florida St.')
#' }

get_records_team <- function(browser, team, conference_only = FALSE){
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]


  if(conference_only){
    url <- paste0("https://kenpom.com/records.php?",
                  "team=", team_name,
                  "&conf_only")
  }else{
    url <- paste0("https://kenpom.com/records.php?",
                  "team=", team_name)
  }
  page <- rvest::jump_to(browser, url)

  y <- list()

  for(i in 1:42){
    Metric <- c('OE','OE','eFGpct','eFGpct',
                'TOpct','TOpct','ORpct','ORpct',
                'FTR','FTR','FG2pct','FG2pct',
                'FG3pct','FG3pct','FG3Apct','FG3Apct','FTpct','FTpct',
                'OE','OE','eFGpct','eFGpct',
                'TOpct','TOpct','ORpct','ORpct',
                'FTR','FTR','FG2pct','FG2pct',
                'FG3pct','FG3pct','FG3Apct','FG3Apct','FTpct','FTpct',
                'Pace','Pace','Pts','Pts','Pts','Pts')

    header_cols<- c('Rk','Date','Opponent','Location','Result',
                    'Regulation',
                    Metric[i])

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_nodes(css='#stattable'))[[i]] %>%
      rvest::html_table()

    colnames(x) <- header_cols

    team_name <- gsub("\\+"," ",team)
    x <- x %>%
      dplyr::mutate(Team = team_name,
                    Conference_Only = FALSE)
    if(i %% 2 != 0){
      replace_na_with_last <- function(x, p=is.na, d=0){
        c(d, x)[cummax(seq_along(x)*(!p(x)))+1]
      }
      x$Rk <- replace_na_with_last(x$Rk)
    }else{
      replace_na_with_first <- function(x, p=is.na, d=0){
        c(d, x)[cummax(seq_along(-1*x)*(!p(x)))+1]
      }
      x$Rk <- rev(replace_na_with_first(rev(x$Rk)))
    }
    if(conference_only){
      x <- x %>%
        dplyr::mutate(
          Team = team_name,
          Conference_Only = conference_only
        )
    }
    y <- c(y, list(x))
  }

  ### Store Data
  kenpom <- y

  return(kenpom)
}

#' Get KenPom Ratings Archive
#'
#' @param browser User login session
#' @param date Date (YYYY-MM-DD)
#'
#' @return A data frame with 22 columns:
#' \describe{
#'   \item{\code{AdjEM.Rk}}{double.}
#'   \item{\code{Team}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{AdjEM}}{double.}
#'   \item{\code{AdjO}}{double.}
#'   \item{\code{AdjO.Rk}}{double.}
#'   \item{\code{AdjD}}{double.}
#'   \item{\code{AdjD.Rk}}{double.}
#'   \item{\code{AdjT}}{double.}
#'   \item{\code{AdjT.Rk}}{double.}
#'   \item{\code{Final.Rk}}{double.}
#'   \item{\code{Final.AdjEM}}{double.}
#'   \item{\code{Final.AdjO}}{double.}
#'   \item{\code{Final.AdjO.Rk}}{double.}
#'   \item{\code{Final.AdjD}}{double.}
#'   \item{\code{Final.AdjD.Rk}}{double.}
#'   \item{\code{Final.AdjT}}{double.}
#'   \item{\code{Final.AdjT.Rk}}{double.}
#'   \item{\code{Rk.Chg}}{double.}
#'   \item{\code{EM.Chg}}{double.}
#'   \item{\code{AdjT.Chg}}{double.}
#'   \item{\code{NCAA_Seed}}{double.}
#' }
#'
#' @keywords Ratings Archive
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate
#' @importFrom stringr str_remove str_remove str_trim
#' @export
#' @examples
#' \dontrun{
#'   get_pomeroy_archive_ratings(browser, date='2018-11-22')
#' }

get_pomeroy_archive_ratings <- function(browser, date){

  header_cols <- c('AdjEM.Rk', 'Team', 'Conf', 'AdjEM',
    'AdjO', 'AdjO.Rk', 'AdjD', 'AdjD.Rk', 'AdjT', 'AdjT.Rk',
    'Final.Rk',	'Final.AdjEM', 'Final.AdjO', 'Final.AdjO.Rk',
    'Final.AdjD', 'Final.AdjD.Rk',	'Final.AdjT', 'Final.AdjT.Rk',
    'Rk.Chg',	'EM.Chg',	'AdjT.Chg')
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/archive.php?d=", date)
  page <- rvest::jump_to(browser, url)


  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$AdjEM.Rk))) %>%
      dplyr::mutate_at(c('AdjEM.Rk','AdjEM',
                         'AdjO', 'AdjO.Rk', 'AdjD', 'AdjD.Rk', 'AdjT', 'AdjT.Rk',
                         'Final.Rk',	'Final.AdjEM', 'Final.AdjO', 'Final.AdjO.Rk',
                         'Final.AdjD', 'Final.AdjD.Rk',	'Final.AdjT', 'Final.AdjT.Rk',
                         'Rk.Chg',	'EM.Chg',	'AdjT.Chg'),as.numeric)
  )

  x <- dplyr::mutate(x,
                     "NCAA_Seed" = NA_integer_,
                     "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                     "Team" = sapply(.data$Team, function(arg) {
                       stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }))


  kenpom <- x

  return(kenpom)
}

#' Get Conference-wide Stats
#'
#' @param browser User login session
#' @param year Year (YYYY)
#' @param conf Used to limit to players in a specific conference. Allowed values are: 'A10', 'ACC', 'AE', 'AMER', \cr
#' 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', \cr
#' 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', \cr
#' 'SUM', 'SWAC', 'WAC', 'WCC'. \cr
#' If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', \cr
#' you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that.\cr
#' No filter applied by default.
#'
#' @return A list of 7 dataframes accessible via \code{[[1]]},\code{[[2]]},...,,\code{[[7]]}\cr
#'   First data frame, accessible via \code{[[1]]}\cr
#'   A data frame with 15 columns:
#' \describe{
#'   \item{\code{Team}}{character.}
#'   \item{\code{Overall}}{character.}
#'   \item{\code{Conf}}{character.}
#'   \item{\code{AdjEM}}{double.}
#'   \item{\code{AdjEM.Rk}}{double.}
#'   \item{\code{AdjO}}{double.}
#'   \item{\code{AdjO.Rk}}{double.}
#'   \item{\code{AdjD}}{double.}
#'   \item{\code{AdjD.Rk}}{double.}
#'   \item{\code{AdjT}}{double.}
#'   \item{\code{AdjT.Rk}}{double.}
#'   \item{\code{ConfSOS}}{double.}
#'   \item{\code{ConfSOS.Rk}}{double.}
#'   \item{\code{NextGame}}{character.}
#'   \item{\code{Year}}{character.}
#' }
#' Second data frame, accessible via \code{[[2]]}\cr
#'   A data frame with 20 columns:
#' \describe{
#'   \item{\code{Team}}{character.}
#'   \item{\code{OE}}{double.}
#'   \item{\code{OE.Rk}}{double.}
#'   \item{\code{eFGpct}}{double.}
#'   \item{\code{eFGpct.Rk}}{double.}
#'   \item{\code{TOpct}}{double.}
#'   \item{\code{TOpct.Rk}}{double.}
#'   \item{\code{ORpct}}{double.}
#'   \item{\code{ORpct.Rk}}{double.}
#'   \item{\code{FTR}}{double.}
#'   \item{\code{FTR.Rk}}{double.}
#'   \item{\code{FG2pct}}{double.}
#'   \item{\code{FG2pct.Rk}}{double.}
#'   \item{\code{FG3pct}}{double.}
#'   \item{\code{FG3pct.Rk}}{double.}
#'   \item{\code{FTpct}}{double.}
#'   \item{\code{FTpct.Rk}}{double.}
#'   \item{\code{Tempo}}{double.}
#'   \item{\code{Tempo.Rk}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#' Third data frame, accessible via \code{[[3]]}\cr
#'   A data frame with 20 columns:
#' \describe{
#'   \item{\code{Team}}{character.}
#'   \item{\code{DE}}{double.}
#'   \item{\code{DE.Rk}}{double.}
#'   \item{\code{eFGpct}}{double.}
#'   \item{\code{eFGpct.Rk}}{double.}
#'   \item{\code{TOpct}}{double.}
#'   \item{\code{TOpct.Rk}}{double.}
#'   \item{\code{ORpct}}{double.}
#'   \item{\code{ORpct.Rk}}{double.}
#'   \item{\code{FTR}}{double.}
#'   \item{\code{FTR.Rk}}{double.}
#'   \item{\code{FG2pct}}{double.}
#'   \item{\code{FG2pct.Rk}}{double.}
#'   \item{\code{FG3pct}}{double.}
#'   \item{\code{FG3pct.Rk}}{double.}
#'   \item{\code{Blkpct}}{double.}
#'   \item{\code{Blkpct.Rk}}{double.}
#'   \item{\code{Stlpct}}{double.}
#'   \item{\code{Stlpct.Rk}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#'   Fourth data frame, accessible via \code{[[4]]}\cr
#'   A data frame with 3 columns:
#' \describe{
#'   \item{\code{Rk}}{integer.}
#'   \item{\code{Player}}{character.}
#'   \item{\code{Year}}{character.}
#' }
#'   Fifth data frame, accessible via \code{[[5]]}\cr
#'   A data frame with 4 columns:
#' \describe{
#'   \item{\code{Stat}}{character.}
#'   \item{\code{Value}}{double.}
#'   \item{\code{Rk}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#'   Sixth data frame, accessible via \code{[[6]]}\cr
#'   A data frame with 5 columns:
#' \describe{
#'   \item{\code{Stat}}{character.}
#'   \item{\code{Count}}{character.}
#'   \item{\code{Value}}{double.}
#'   \item{\code{Rk}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#'   Seventh data frame, accessible via \code{[[7]]}\cr
#'   A data frame 4 columns:
#' \describe{
#'   \item{\code{Rk}}{double.}
#'   \item{\code{Conference}}{character.}
#'   \item{\code{Rating}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#' @keywords Conference Stats
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate
#' @export
#' @examples
#' \dontrun{
#'     get_conf(browser, year='2020',conf='ACC')
#' }

get_conf <- function(browser, year, conf){

  header_cols <- c('Team',	'Overall',	'Conf','AdjEM','AdjEM.Rk',
                   'AdjO','AdjO.Rk',	'AdjD','AdjD.Rk',	'AdjT','AdjT.Rk',
                   'ConfSOS','ConfSOS.Rk','NextGame')
  header_cols2<- c('Team',	'OE','OE.Rk','eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
                   'ORpct','ORpct.Rk','FTR', 'FTR.Rk',	'FG2pct', 'FG2pct.Rk',
                   'FG3pct', 'FG3pct.Rk', 'FTpct','FTpct.Rk','Tempo','Tempo.Rk')
  header_cols3<- c('Team',	'DE','DE.Rk','eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
                   'ORpct','ORpct.Rk','FTR', 'FTR.Rk',	'FG2pct', 'FG2pct.Rk',
                   'FG3pct', 'FG3pct.Rk', 'Blkpct','Blkpct.Rk','Stlpct','Stlpct.Rk')
  header_cols4<- c('Rk','Player')
  header_cols5<- c('Stat','Value','Rk')
  header_cols6<- c('Stat','Count','Value','Rk')
  header_cols7<- c('Rk','Conference','Rating','Rk2','Conference2','Rating2')

  # check for internet
  check_internet()
  # Check conf parameter in teams_list$Conf names
  assertthat::assert_that(conf %in% kenpomR::teams_links$Conf,
                          msg = "Incorrect conference name as compared to the website, see kenpomR::teams_links for conference name parameter specifications.")
  conf_name = unique(kenpomR::teams_links$conf.link.ref[kenpomR::teams_links$Conf == conf])

  ### Pull Data
  url <- paste0("https://kenpom.com/conf.php?",
                "c=", conf_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)

  y <- list()
  for(i in 1:7){

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_nodes('table'))[[i]] %>%
      rvest::html_table(fill=TRUE) %>%
      as.data.frame()

    if(i == 1){
      x<-x[1:(length(x)-2)]
      colnames(x) <- header_cols
      suppressWarnings(
        x <- x %>%
          mutate_at(c('AdjEM','AdjEM.Rk',
                      'AdjO','AdjO.Rk',	'AdjD','AdjD.Rk',	'AdjT','AdjT.Rk',
                      'ConfSOS','ConfSOS.Rk'),as.numeric)
      )
    }else if(i == 2){
      colnames(x) <- header_cols2
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(
            c('OE','OE.Rk','eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
              'ORpct','ORpct.Rk','FTR', 'FTR.Rk',	'FG2pct', 'FG2pct.Rk',
              'FG3pct', 'FG3pct.Rk', 'FTpct','FTpct.Rk','Tempo','Tempo.Rk'),
            as.numeric
          )
      )
    }else if(i == 3){
      colnames(x) <- header_cols3
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(
            c('DE','DE.Rk','eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
              'ORpct','ORpct.Rk','FTR', 'FTR.Rk',	'FG2pct', 'FG2pct.Rk',
              'FG3pct', 'FG3pct.Rk', 'Blkpct','Blkpct.Rk','Stlpct','Stlpct.Rk'),
            as.numeric)
      )

    }else if(i == 4){
      colnames(x) <- header_cols4
    }else if(i == 5){
      colnames(x) <- header_cols5
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(c('Value','Rk'),as.numeric)
      )
    }else if(i == 6){
      colnames(x) <- header_cols6
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(c('Value','Rk'),as.numeric)
      )
    }else if(i == 7){
      colnames(x) <- header_cols7
      w <- x[1:3]
      v <- x[4:6]
      colnames(v) <- colnames(w)
      x <- rbind(w,v)
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(c('Rk','Rating'), as.numeric)
      )
    }

    x <- dplyr::mutate(x,
                       "Year" = year)

    y <- c(y, list(x))
  }

  kenpom <- y

  return(kenpom)
}


#' Get Conference Comparison Stats
#'
#' @param browser User login session
#' @param year Year (YYYY)
#'
#' @return A data frame with 35 columns:
#' \describe{
#'   \item{\code{Conf}}{character.}
#'   \item{\code{Eff}}{double.}
#'   \item{\code{Eff.Rk}}{double.}
#'   \item{\code{Tempo}}{double.}
#'   \item{\code{Tempo.Rk}}{double.}
#'   \item{\code{eFGpct}}{double.}
#'   \item{\code{eFGpct.Rk}}{double.}
#'   \item{\code{TOpct}}{double.}
#'   \item{\code{TOpct.Rk}}{double.}
#'   \item{\code{ORpct}}{double.}
#'   \item{\code{ORpct.Rk}}{double.}
#'   \item{\code{FTR}}{double.}
#'   \item{\code{FTR.Rk}}{double.}
#'   \item{\code{Blkpct}}{double.}
#'   \item{\code{Blkpct.Rk}}{double.}
#'   \item{\code{Stlpct}}{double.}
#'   \item{\code{Stlpct.Rk}}{double.}
#'   \item{\code{FG2pct}}{double.}
#'   \item{\code{FG2pct.Rk}}{double.}
#'   \item{\code{FG3pct}}{double.}
#'   \item{\code{FG3pct.Rk}}{double.}
#'   \item{\code{FTpct}}{double.}
#'   \item{\code{FTpct.Rk}}{double.}
#'   \item{\code{FG3Apct}}{double.}
#'   \item{\code{FG3Apct.Rk}}{double.}
#'   \item{\code{Apct}}{double.}
#'   \item{\code{Apct.Rk}}{double.}
#'   \item{\code{HomeWL}}{character.}
#'   \item{\code{HomeWLpct}}{double.}
#'   \item{\code{HomeWL.Rk}}{double.}
#'   \item{\code{Close}}{double.}
#'   \item{\code{Close.Rk}}{double.}
#'   \item{\code{Blowouts}}{double.}
#'   \item{\code{Blowouts.Rk}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#'
#' @keywords Conference Comparison
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate filter mutate_at
#' @export
#'
#' @examples
#' \dontrun{
#'   get_confstats(browser, year='2020')
#' }

get_confstats <- function(browser, year){

  header_cols <- c('Conf', 'Eff','Eff.Rk','Tempo','Tempo.Rk','eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
                   'ORpct','ORpct.Rk','FTR',	'FTR.Rk', 'Blkpct', 'Blkpct.Rk', 'Stlpct', 'Stlpct.Rk',
                   'FG2pct', 'FG2pct.Rk',	'FG3pct', 'FG3pct.Rk',	'FTpct', 'FTpct.Rk',
                   'FG3Apct', 'FG3Apct.Rk', 'Apct', 'Apct.Rk',
                   'HomeW-L','HomeW-Lpct', 'HomeW-L.Rk',	'Close', 'Close.Rk', 'Blowouts', 'Blowouts.Rk')
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/confstats.php?y=", year)
  page <- rvest::jump_to(browser, url)

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css="#confrank-table"))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Eff)))
  )

  x <- dplyr::mutate(x,
                     "Year" = year)
  suppressWarnings(
    x <- x %>%
      dplyr::mutate_at(c('Eff','Eff.Rk','Tempo','Tempo.Rk','eFGpct',
                         'eFGpct.Rk','TOpct','TOpct.Rk',
                         'ORpct','ORpct.Rk','FTR',	'FTR.Rk',
                         'Blkpct', 'Blkpct.Rk', 'Stlpct', 'Stlpct.Rk',
                         'FG2pct', 'FG2pct.Rk',	'FG3pct', 'FG3pct.Rk',
                         'FTpct', 'FTpct.Rk', 'FG3Apct', 'FG3Apct.Rk',
                         'Apct', 'Apct.Rk', 'HomeW-Lpct', 'HomeW-L.Rk',
                         'Close', 'Close.Rk', 'Blowouts', 'Blowouts.Rk'),
                       as.numeric)
  )
  kenpom <- x

  return(kenpom)
}

#' Get Conference Historical Ratings
#'
#' @param browser User login session
#' @param conf Used to limit to players in a specific conference. Allowed values are: 'A10', 'ACC', 'AE', 'AMER', \cr
#' 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH',\cr
#' 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', \cr
#' 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', \cr
#' 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', \cr
#' 'SUM', 'SWAC', 'WAC', 'WCC'. \cr
#' If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', \cr
#' you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that.\cr
#' No filter applied by default.
#'
#' @return A data frame with 23 columns:
#' \describe{
#'   \item{\code{Year}}{integer.}
#'   \item{\code{Rank}}{character.}
#'   \item{\code{Tempo}}{double.}
#'   \item{\code{Efficiency}}{double.}
#'   \item{\code{eFGpct}}{double.}
#'   \item{\code{TOpct}}{double.}
#'   \item{\code{ORpct}}{double.}
#'   \item{\code{FTR}}{double.}
#'   \item{\code{FG2pct}}{double.}
#'   \item{\code{FG3pct}}{double.}
#'   \item{\code{FTpct}}{double.}
#'   \item{\code{FG3Apct}}{double.}
#'   \item{\code{Apct}}{double.}
#'   \item{\code{Blkpct}}{double.}
#'   \item{\code{Stlpct}}{double.}
#'   \item{\code{HomeRecord}}{character.}
#'   \item{\code{Bids}}{character.}
#'   \item{\code{S16}}{character.}
#'   \item{\code{F4}}{character.}
#'   \item{\code{CH}}{character.}
#'   \item{\code{RegSeasonChamp}}{character.}
#'   \item{\code{TourneyChamp}}{character.}
#'   \item{\code{BestTeam}}{character.}
#' }
#' @keywords Conference History
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html xml_remove
#' @importFrom dplyr mutate_at
#' @export
#'
#' @examples
#' \dontrun{
#'     get_confhistory(browser, conf='ACC', year=2020)
#' }

get_confhistory <- function(browser, conf){

  header_cols <- c('Year',	'Rank',	'Tempo',	'Efficiency',
                   'eFGpct',	'TOpct',	'ORpct','FTR',	'FG2pct',	'FG3pct',
                   'FTpct',	'FG3Apct', 'Apct', 'Blkpct',	'Stlpct',
                   'HomeRecord', 'Bids',	'S16',	'F4',	'CH',
                   'RegSeasonChamp', 'TourneyChamp',	'BestTeam')

  # check for internet
  check_internet()
  # Check conf parameter in teams_list$Conf names
  assertthat::assert_that(conf %in% kenpomR::teams_links$Conf,
                          msg = "Incorrect conference name as compared to the website, see kenpomR::teams_links for conference name parameter specifications.")
  conf_name = unique(kenpomR::teams_links$conf.link.ref[kenpomR::teams_links$Conf == conf])

  ### Pull Data
  url <- paste0("https://kenpom.com/confhistory.php?",
                "c=", conf_name)
  page <- rvest::jump_to(browser, url)

  x <- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css="#player-table")

  ## removing national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")
  xml2::xml_remove(tmrank)

  x <- x %>%
    rvest::html_table(fill=TRUE) %>%
    as.data.frame()

  colnames(x) <- header_cols
  suppressWarnings(
    x <- x %>%
      dplyr::mutate_at(c('Tempo',	'Efficiency',
                         'eFGpct',	'TOpct',	'ORpct','FTR',	'FG2pct',	'FG3pct',
                         'FTpct',	'FG3Apct', 'Apct', 'Blkpct',	'Stlpct'),
                       as.numeric)
  )
  kenpom <- x
  return(kenpom)
}

