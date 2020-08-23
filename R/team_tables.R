#' Get Team Schedule Results
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Schedule
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
#'   get_team_schedule(browser, team = 'Florida St.', year= 2020)
#' }

get_team_schedule <- function(browser, team, year= 2020){
  assert_that(year>=2002, msg="Data only goes back to 2002")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team,
                "&y=", year)

  page <- jump_to(browser, url)

  header_cols<- c("Date","Team.Rk","Opponent.Rk","Opponent","Result",
                  "Poss","OT","Location","Record","Conference")

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#schedule-table') %>%
    html_table(fill=TRUE)  %>%
    .data$.[[1]] %>%
    as.data.frame() %>%
    .data$.[,-11]

  ## TO-DO: Add the tiers of joy column back to data frame
  # y <- page %>%
  #   xml2::read_html() %>%
  #   rvest::html_nodes(css='#schedule-table') %>%
  #   .[[1]]
  #
  colnames(x) <- header_cols
  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$Team.Rk))) %>%
    mutate(Team = team_name,
           Year = year) %>%
    select(.data$Date, .data$Team.Rk, .data$Team, .data$Opponent.Rk, .data$Opponent,
           .data$Result, .data$Poss, .data$OT, .data$Location,
           .data$Record, .data$Conference, .data$Year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Game Plan for Team
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Game Plan
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
#'   get_gameplan(browser, team='Florida St.', year=2020)
#' }

get_gameplan <- function(browser, team, year=2020){
  assert_that(year>=2002, msg="Data only goes back to 2002")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/gameplan.php?",
                "team=", team_name,
                "&y=", year)

  page <- jump_to(browser, url)
  header_cols <- c(
    'Date','Opponent.Rk',	'Opponent','Result','Location','Pace',
    'Off.Eff', 'Off.Eff.Rk', 'Off.eFGpct',	'Off.TOpct',	'Off.ORpct', 'Off.FTR',
    'Off.FG2M-A', 'Off.FG2pct', 'Off.FG3M-A',	'Off.FG3pct',	'Off.FG3Apct',
    'Def.Eff', 'Def.Eff.Rk', 'Def.eFGpct',	'Def.TOpct',	'Def.ORpct', 'Def.FTR',
    'Def.FG2M-A',	'Def.FG2pct',	'Def.FG3M-A', 'Def.FG3pct',	'Def.FG3Apct'
  )


  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#schedule-table')  %>%
    .data$.[[1]] %>%
    html_table(fill=TRUE) %>%
    as.data.frame()


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$Off.Eff)))
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Opponent Tracker for Team
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @param defense TRUE/FALSE variable for whether to gather the defense data, default FALSE
#' @keywords Opponent Tracker
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
#'   get_opptracker(browser, team='Florida St.', year=2020)
#' }

get_opptracker <- function(browser, team, year = 2020, defense = FALSE){

  assert_that(year>=2002, msg="Data only goes back to 2002")

  team_name <- gsub(" ","\\+",team)

  if(!defense){
    def = 'd'
    header_cols<- c('Date','Team','Result','AdjDE','AdjDE.Rk',
                    'eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
                    'ORpct','ORpct.Rk','FTR','FTR.Rk',
                    'FG2pct','FG2pct.Rk','FG3pct','FG3pct.Rk',
                    'Blkpct','Blkpct.Rk','FG3Apct','FG3Apct.Rk',
                    'APL','APL.Rk')
  }else{
    def = 'o'
    header_cols<- c('Date','Team','Result','AdjOE','AdjOE.Rk',
                    'eFGpct','eFGpct.Rk','TOpct','TOpct.Rk',
                    'ORpct','ORpct.Rk','FTR','FTR.Rk',
                    'FG2pct','FG2pct.Rk','FG3pct','FG3pct.Rk',
                    'FTpct','FTpct.Rk','FG3Apct','FG3Apct.Rk',
                    'APL','APL.Rk')
  }
  ### Pull Data
  url <- paste0("https://kenpom.com/opptracker.php?",
                "team=", team_name,
                "&y=", year,
                "&t=", def)

  page <- jump_to(browser, url)



  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#conf-table') %>%
    .data$.[[1]] %>%
    html_table(fill=TRUE) %>%
    as.data.frame()

  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$eFGpct)))
  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Player Stats from Team Page
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Player Stats
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
#'   get_team_players(browser, team = 'Florida St.', year= 2020)
#' }

get_team_players <- function(browser, team, year= 2020){
  assert_that(year>=2002, msg="Data only goes back to 2002")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team,
                "&y=", year)

  page <- jump_to(browser, url)

  header_cols<- c("Number", "Player", "Ht", "Wt", "Yr", "G", "S",
                  "Minpct", "ORtg", "Posspct","Shotspct",
                  "eFGpct", "TSpct", "ORpct", "DRpct",
                  "ARate", "TORate", "Blkpct","Stlpct","FCper40","FDper40",
                  "FTRate", "FTM-A", "FTpct",
                  "2PM-A", "FG2pct", "3PM-A", "FG3pct")

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#player-table')  %>%
    .data$.[[1]]

  ## removing Player national rankings for easier manipulation
  ## TO-DO: Add these rankings back as columns
  plrank <- x %>%
    rvest::html_nodes(".plrank")
  xml_remove(plrank)

  x <- x %>%
    html_table(fill=FALSE) %>%
    as.data.frame()


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$Wt))) %>%
    mutate(Team = team_name,
           Year = year,
           Role = case_when(.data$Minpct < 10.0 ~ "Benchwarmer",
                            .data$Posspct < 12.0 ~ "Nearly Invisible",
                            .data$Posspct >=12.0 & .data$Posspct < 16.0 ~ "Limited Role",
                            .data$Posspct >=16.0 & .data$Posspct < 20.0 ~ "Role Player",
                            .data$Posspct >=20.0 & .data$Posspct < 24.0 ~ "Significant Contributor",
                            .data$Posspct >=24.0 & .data$Posspct < 28.0 ~ "Major Contributor",
                            .data$Posspct >=28.0 ~ "Go-to Guys")) %>%
    select(.data$Role, .data$Number, .data$Player, .data$Ht, .data$Wt, .data$Yr, .data$G,
           .data$S, .data$Minpct, .data$ORtg, .data$Posspct, .data$Shotspct,
           .data$eFGpct, .data$TSpct, .data$ORpct, .data$DRpct,.data$ARate,
           .data$TORate, .data$Blkpct, .data$Stlpct, .data$FCper40, .data$FDper40,
           .data$FTRate, .data$"FTM-A",  .data$FTpct, .data$"2PM-A", .data$FG2pct,
           .data$"3PM-A", .data$FG3pct, .data$Team, .data$Year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Minutes Matrix from Expanded Player Page
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Minutes Matrix
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
#'   get_minutes_matrix(browser, team = 'Florida St.', year = 2020)
#' }

get_minutes_matrix <- function(browser, team, year = 2020){
  assert_that(year >= 2014, msg="Data only goes back to 2014")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/player-expanded.php?",
                "team=",team,
                "&y=", year)

  page <- jump_to(browser, url)

  header_cols<- c("Date","Opponent.Rk","Opponent","Result")

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#minutes-table')  %>%
    .data$.[[1]] %>%
    html_table(fill=FALSE) %>%
    as.data.frame()



  colnames(x)[1:4] <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$Opponent.Rk))) %>%
    mutate(Team = team_name,
           Year = year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}


#' Get Minutes Matrix from Expanded Player Page
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Minutes Matrix
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
#'   get_team_player_stats(browser, team = 'Florida St.', year = 2020)
#' }

get_team_player_stats <- function(browser, team, year = 2020){
  assert_that(year>=2014, msg="Data only goes back to 2014")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/player-expanded.php?",
                "team=",team,
                "&y=", year)

  page <- jump_to(browser, url)


  y <- list()
  for(i in 1:2){
    header_cols<- c("Number","Player","Ht","Wt", "Yr","G","Minpct","ORtg","Posspct","Shotspct","eFGpct",
                    "TSpct","ORpct", "DRpct","ARate","TORate","Blkpct","Stlpct","FCper40","FDper40","FTRate",
                    "FTM-A",  "FTpct", "2PM-A", "FG2pct", "3PM-A", "FG3pct")

    x<- page %>%
      xml2::read_html() %>%
      rvest::html_nodes(css='#player-table')  %>%
      .data$.[[i]]

    ## removing Player national rankings for easier manipulation
    ## TO-DO: Add these rankings back as columns
    plrank <- x %>%
      rvest::html_nodes(".plrank")
    xml_remove(plrank)

    x <- x %>%
      html_table(fill=FALSE) %>%
      as.data.frame()


    colnames(x) <- header_cols

    team_name <- gsub("\\+"," ",team)

    x <- x %>%
      filter(!is.na(as.numeric(.data$Wt))) %>%
      mutate(Team = team_name,
             Year = year,
             Role = case_when(.data$Minpct < 10.0 ~ "Benchwarmer",
                              .data$Posspct < 12.0 ~ "Nearly Invisible",
                              .data$Posspct >=12.0 & .data$Posspct < 16.0 ~ "Limited Role",
                              .data$Posspct >=16.0 & .data$Posspct < 20.0 ~ "Role Player",
                              .data$Posspct >=20.0 & .data$Posspct < 24.0 ~ "Significant Contributor",
                              .data$Posspct >=24.0 & .data$Posspct < 28.0 ~ "Major Contributor",
                              .data$Posspct >=28.0 ~ "Go-to Guys")) %>%
      select(.data$Role, .data$Number, .data$Player, .data$Ht, .data$Wt, .data$Yr,
             .data$G, .data$Minpct, .data$ORtg, .data$Posspct, .data$Shotspct,
             .data$eFGpct, .data$TSpct, .data$ORpct, .data$DRpct,.data$ARate,
             .data$TORate, .data$Blkpct, .data$Stlpct, .data$FCper40, .data$FDper40,
             .data$FTRate,.data$"FTM-A",  .data$FTpct, .data$"2PM-A", .data$FG2pct,
             .data$"3PM-A", .data$FG3pct, .data$Team, .data$Year)

    y <- c(y,list(x))
  }
  ### Store Data
  kenpom <- y

  return(kenpom)
}


#' Get Depth Chart Last 5 Games from Team Page
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Depth Chart
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
#'   get_team_depth_chart(browser, team = 'Florida St.', year= 2020)
#' }

get_team_depth_chart <- function(browser, team, year= 2020){
  assert_that(year>=2010, msg="Data only goes back to 2010")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team,
                "&y=", year)

  page <- jump_to(browser, url)

  header_cols<- c("PG", "PG.Minpct", "SG", "SG.Minpct", "SF", "SF.Minpct",
                  "PF", "PF.Minpct", "C", "C.Minpct")

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#dc-table')%>%
    .data$.[[1]] %>%
    html_table(fill=FALSE) %>%
    as.data.frame() %>%
    .data$.[-1,]


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%

    mutate(Team = team_name,
           Year = year) %>%
    select(.data$PG, .data$PG.Minpct, .data$SG,.data$SG.Minpct,
           .data$SF, .data$SF.Minpct, .data$PF, .data$PF.Minpct,
           .data$C, .data$C.Minpct, .data$Team, .data$Year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}

#' Get Lineups Last 5 Games from Team Page
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Depth Chart
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
#'   get_team_lineups(browser, team = 'Florida St.', year= 2020)
#' }

get_team_lineups <- function(browser, team, year= 2020){
  assert_that(year>=2010, msg="Data only goes back to 2010")
  team_name <- gsub(" ","\\+",team)
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team,
                "&y=", year)

  page <- jump_to(browser, url)

  header_cols<- c("Rk","PG", "SG", "SF",
                  "PF", "C", "Minpct")

  x<- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#dc-table2')  %>%
    .data$.[[1]] %>%
    html_table(fill=FALSE) %>%
    as.data.frame() %>%
    .data$.[-1,]


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    filter(!is.na(as.numeric(.data$Minpct))) %>%
    mutate(Team = team_name,
           Year = year) %>%
    select(.data$Rk, .data$PG, .data$SG, .data$SF, .data$PF, .data$C,
           .data$Minpct, .data$Team, .data$Year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}



