#' Get Team Efficiency History
#'
#' @param browser User login session
#' @param team Team filter to select.
#'
#' @keywords Team History
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @importFrom utils "URLencode"
#' @export
#'
#' @examples
#' \dontrun{
#'   get_team_history(browser, team = 'Florida St.', year= 2020)
#' }

get_team_history <- function(browser, team){

  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/history.php?",
                "t=",team)

  page <- jump_to(browser, url)

  header_cols<- c('Year','Team.Rk','Coach',	'Conf','W-L',	'AdjT', 'AdjO',	'AdjD',
                  'eFGpct.Off',	'TOpct.Off',	'ORpct.Off','FTR.Off',
                  'FG2pct.Off',	'FG3pct.Off',	'FTpct.Off',	'FG3Apct.Off',
                  'Apct.Off',	'APL.Off',
                  'eFGpct.Def', 'TOpct.Def',	'ORpct.Def',	'FTR.Def',
                  'FG2pct.Def',	'FG3pct.Def',
                  'Blkpct.Def',	'FG3Apct.Def',	'Apct.Def',
                  'AP.Def',	'Foul2Particpct')

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#player-table') %>%
    .data$.[[1]]

  ## removing national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")
  xml_remove(tmrank)

  x <- x %>%
    html_table(fill=FALSE) %>%
    as.data.frame() %>%
    .data$.[-1,]


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$AdjT))) %>%
    mutate(Team = team_name)
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Coaching Resume
#'
#' @param browser User login session
#' @param coach Coach filter to select.
#'
#' @keywords Coach History
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @importFrom utils "URLencode"
#' @export
#'
#' @examples
#' \dontrun{
#'   get_coach_history(browser, coach = 'Leonard Hamilton')
#' }

get_coach_history <- function(browser, coach){
  coach_name <- gsub(" ","\\+",coach)
  ### Pull Data
  url <- paste0("https://kenpom.com/history.php?",
                "c=",coach_name)

  page <- jump_to(browser, url)

  header_cols<- c('Year','Team.Rk','Team',	'Conf','W-L',	'AdjT', 'AdjO',	'AdjD',
                  'eFGpct.Off',	'TOpct.Off',	'ORpct.Off','FTR.Off',
                  'FG2pct.Off',	'FG3pct.Off',	'FTpct.Off',	'FG3Apct.Off',
                  'Apct.Off',	'APL.Off',
                  'eFGpct.Def', 'TOpct.Def',	'ORpct.Def',	'FTR.Def',
                  'FG2pct.Def',	'FG3pct.Def',
                  'Blkpct.Def',	'FG3Apct.Def',	'Apct.Def',
                  'AP.Def',	'Foul2Particpct')

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#player-table') %>%
    .data$.[[1]]

  ## removing national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")
  xml_remove(tmrank)

  x <- x %>%
    html_table(fill=FALSE) %>%
    as.data.frame() %>%
    .data$.[-1,]


  colnames(x) <- header_cols

  coach_name <- gsub("\\+"," ",coach)

  x <- x %>%
    filter(!is.na(as.numeric(.data$AdjT))) %>%
    mutate(Coach = coach_name)
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Program Ratings
#'
#' @param browser User login session
#'
#' @keywords Program Ratings
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @importFrom utils "URLencode"
#' @export
#' @examples
#' \dontrun{
#'   get_program_ratings(browser)
#' }

get_program_ratings <- function(browser){

  ### Pull Data
  url <- "https://kenpom.com/programs.php?"

  page <- jump_to(browser, url)

  header_cols<- c('Rk',	'Team',	'Conf','Rtg',
                  'Best.Rk','Best.Yr',
                  'Worst.Rk','Worst.Yr', 'KP.Median',
                  'Top10',	'Top25',	'Top50',	'CH',
                  'F4',	'S16',	'R1',	'Chg')

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#ratings-table')  %>%
    .data$.[[1]]
  ## removing national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")

  xml_remove(tmrank)

  x <- x %>%
    html_table(fill=FALSE) %>%
    as.data.frame()


  colnames(x) <- header_cols

  x <- x %>%
    filter(!is.na(as.numeric(.data$Rtg)))
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
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @importFrom utils "URLencode"
#' @export
#'
#' @examples
#' \dontrun{
#'   get_records_team(browser, team = 'Florida St.')
#' }

get_records_team <- function(browser, team, conference_only = FALSE){
  team_name <- gsub(" ","\\+",team)
  if(conference_only){
    url <- paste0("https://kenpom.com/records.php?",
                  "team=", team_name,
                  "&conf_only")
  }else{
    url <- paste0("https://kenpom.com/records.php?",
                  "team=", team_name)
  }
  page <- jump_to(browser, url)

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





    x <- page %>%
      xml2::read_html() %>%
      rvest::html_nodes(css='.stattable') %>%
      .data$.[[i]] %>%
      html_table(fill=TRUE) %>%
      as.data.frame()

    colnames(x) <- header_cols

    team_name <- gsub("\\+"," ",team)
    if(i%%2!= 0){
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
      mutate(
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
#' @keywords Ratings Archive
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @import stringr
#' @import stringi
#' @export
#'
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

  ### Pull Data
  url <- paste0("https://kenpom.com/archive.php?d=", date)
  page <- jump_to(browser, url)


  x <- page %>%
    xml2::read_html() %>%
    rvest::html_nodes("table") %>%
    .data$.[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols

  x <- x %>%
    filter(!is.na(as.numeric(.data$AdjEM.Rk)))

  x <- mutate(x,
              "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
              "Team" = sapply(.data$Team, function(arg) { gsub("\\s[0-9]+", "", arg) }))


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
#' you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that.
#' No filter applied by default.\cr
#'
#' @keywords Conference Stats
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @import stringr
#' @import stringi
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

  ### Pull Data
  url <- paste0("https://kenpom.com/conf.php?",
                "c=", conf,
                "&y=", year)

  page <- jump_to(browser, url)

  y <- list()
  for(i in 1:7){

    x <- page %>%
      xml2::read_html() %>%
      rvest::html_nodes('table') %>%
      .data$.[[i]] %>%
      rvest::html_table(fill=TRUE) %>%
      as.data.frame()

    if(i == 1){
      x<-x[1:(length(x)-2)]
      colnames(x) <- header_cols
    }else if(i == 2){
      colnames(x) <- header_cols2
    }else if(i == 3){
      colnames(x) <- header_cols3
    }else if(i == 4){
      colnames(x) <- header_cols4
    }else if(i == 5){
      colnames(x) <- header_cols5
    }else if(i == 6){
      colnames(x) <- header_cols6
    }else if(i == 7){
      colnames(x) <- header_cols7
      w<-x[1:3]
      v<-x[4:6]
      colnames(v)<-colnames(w)
      x<-rbind(w,v)
    }

    x <- mutate(x,
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
#' @keywords Conference Comparison
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @import stringr
#' @import stringi
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

  ### Pull Data
  url <- paste0("https://kenpom.com/confstats.php?y=", year)
  page <- jump_to(browser, url)

  x <- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css="#confrank-table") %>%
    .data$.[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(x) <- header_cols

  x <- x %>%
    filter(!is.na(as.numeric(.data$Eff)))

  x <- mutate(x,
              "Year" = year)

  kenpom <- x

  return(kenpom)
}

#' Get Conference Historical Ratings
#'
#' @param browser User login session
#' @param conf Used to limit to players in a specific conference. Allowed values are: 'A10', 'ACC', 'AE', 'AMER', \cr
#' 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', \cr
#' 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', \cr
#' 'SUM', 'SWAC', 'WAC', 'WCC'. \cr
#' If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', \cr
#' you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that.
#' No filter applied by default.\cr
#'
#' @keywords Conference History
#' @importFrom assertthat "assert_that"
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @import stringr
#' @import stringi
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


  ### Pull Data
  url <- paste0("https://kenpom.com/confhistory.php?",
                "c=", conf)
  page <- jump_to(browser, url)

  x <- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css="#player-table")

  ## removing national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  tmrank <- x %>%
    rvest::html_nodes(".tmrank")
  xml_remove(tmrank)
  x <- x %>%
    rvest::html_table(fill=TRUE) %>%
    as.data.frame()

  colnames(x) <- header_cols

  kenpom <- x

  return(kenpom)
}

