#' Get Team Schedule Results
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Schedule
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate select
#' @export
#'
#' @examples
#' \dontrun{
#'   get_team_schedule(browser, team = 'Florida St.', year= 2020)
#' }

get_team_schedule <- function(browser, team, year= 2020){
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)

  header_cols<- c("Date","Team.Rk","Opponent.Rk","Opponent","Result",
                  "Poss","OT","Location","Record","Conference")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#schedule-table') %>%
    rvest::html_table(fill=TRUE))[[1]] %>%
    as.data.frame()
  x <- x[,1:(length(x)-1)]

  ## TODO: Add the tiers of joy column back to data frame

  colnames(x) <- header_cols
  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Team.Rk)))
  )
  x <- x %>%
    dplyr::mutate(Team = team_name,
                  Year = year) %>%
    dplyr::select(.data$Date, .data$Team.Rk, .data$Team, .data$Opponent.Rk, .data$Opponent,
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
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter
#' @export
#' @examples
#' \dontrun{
#'   get_gameplan(browser, team='Florida St.', year=2020)
#' }

get_gameplan <- function(browser, team, year=2020){
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/gameplan.php?",
                "team=", team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)
  header_cols <- c(
    'Date','Opponent.Rk',	'Opponent','Result','Location','Pace',
    'Off.Eff', 'Off.Eff.Rk', 'Off.eFGpct',	'Off.TOpct',	'Off.ORpct', 'Off.FTR',
    'Off.FG2M-A', 'Off.FG2pct', 'Off.FG3M-A',	'Off.FG3pct',	'Off.FG3Apct',
    'Def.Eff', 'Def.Eff.Rk', 'Def.eFGpct',	'Def.TOpct',	'Def.ORpct', 'Def.FTR',
    'Def.FG2M-A',	'Def.FG2pct',	'Def.FG3M-A', 'Def.FG3pct',	'Def.FG3Apct'
  )


  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#schedule-table'))[[1]] %>%
    rvest::html_table(fill=TRUE) %>%
    as.data.frame()

  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Off.Eff)))
  )

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
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter
#' @export
#'
#' @examples
#' \dontrun{
#'   get_opptracker(browser, team='Florida St.', year=2020)
#' }

get_opptracker <- function(browser, team, year = 2020, defense = FALSE){
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]

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
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/opptracker.php?",
                "team=", team_name,
                "&y=", year,
                "&t=", def)

  page <- rvest::jump_to(browser, url)



  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#conf-table'))[[1]] %>%
    rvest::html_table(fill=TRUE) %>%
    as.data.frame()

  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$eFGpct)))
  )

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
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html xml_remove
#' @importFrom dplyr select mutate filter case_when
#' @importFrom tidyr everything
#' @export
#'
#' @examples
#'   \dontrun{
#'     get_team_players(browser, team = 'Florida St.', year= 2020)
#'   }
#'

get_team_players <- function(browser, team, year= 2020){
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)

  header_cols<- c("Number", "Player", "Ht", "Wt", "Yr", "G", "S",
                  "Minpct", "ORtg", "Posspct","Shotspct",
                  "eFGpct", "TSpct", "ORpct", "DRpct",
                  "ARate", "TORate", "Blkpct","Stlpct","FCper40","FDper40",
                  "FTRate", "FTM-A", "FTpct",
                  "2PM-A", "FG2pct", "3PM-A", "FG3pct")

  x<- (page %>%
         xml2::read_html() %>%
         rvest::html_nodes(css='#player-table'))[[1]]

  ## removing Player national rankings for easier manipulation
  ## TODO: Add these rankings back as columns
  plrank <- x %>%
    rvest::html_nodes(".plrank")

  xml2::xml_remove(plrank)

  x <- x %>%
    rvest::html_table(fill=FALSE) %>%
    as.data.frame()


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Wt)))
  )

  x <- x %>%
    dplyr::mutate(Team = team_name,
                  Year = year,
                  Role = dplyr::case_when(.data$Minpct < 10.0 ~ "Benchwarmer",
                                          .data$Posspct < 12.0 ~ "Nearly Invisible",
                                          .data$Posspct >= 12.0 & .data$Posspct < 16.0 ~ "Limited Role",
                                          .data$Posspct >= 16.0 & .data$Posspct < 20.0 ~ "Role Player",
                                          .data$Posspct >= 20.0 & .data$Posspct < 24.0 ~ "Significant Contributor",
                                          .data$Posspct >= 24.0 & .data$Posspct < 28.0 ~ "Major Contributor",
                                          .data$Posspct >= 28.0 ~ "Go-to Guys")) %>%
    dplyr::select(.data$Role, tidyr::everything())

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
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate filter
#' @export
#'
#' @examples
#'   \dontrun{
#'     get_minutes_matrix(browser, team = 'Florida St.', year = 2020)
#'   }
#'
#'

get_minutes_matrix <- function(browser, team, year = 2020){
  assertthat::assert_that(year >= 2014, msg="Data only goes back to 2014")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/player-expanded.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)

  header_cols<- c("Date","Opponent.Rk","Opponent","Result")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#minutes-table'))[[1]] %>%
    rvest::html_table(fill=FALSE) %>%
    as.data.frame()



  colnames(x)[1:4] <- header_cols

  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Opponent.Rk)))
  )

  x <- x %>%
    dplyr::mutate(Team = team_name,
                  Year = year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}


#' Get Team Player Stats
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Player Stats
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html xml_remove
#' @importFrom dplyr filter mutate select
#' @importFrom tidyr everything
#' @export
#'
#' @examples
#'   \dontrun{
#'     get_team_player_stats(browser, team = 'Florida St.', year = 2020)
#'   }
get_team_player_stats <- function(browser, team, year = 2020){
  assertthat::assert_that(year>=2014, msg="Data only goes back to 2014")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/player-expanded.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)


  y <- list()
  for(i in 1:2){
    header_cols<- c("Number","Player","Ht","Wt", "Yr","G","Minpct","ORtg","Posspct","Shotspct","eFGpct",
                    "TSpct","ORpct", "DRpct","ARate","TORate","Blkpct","Stlpct","FCper40","FDper40","FTRate",
                    "FTM-A",  "FTpct", "2PM-A", "FG2pct", "3PM-A", "FG3pct")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_nodes(css='#player-table'))[[i]]

    ## removing Player national rankings for easier manipulation
    ## TODO: Add these rankings back as columns
    plrank <- x %>%
      rvest::html_nodes(".plrank")
    xml2::xml_remove(plrank)

    x <- x %>%
      rvest::html_table(fill=FALSE) %>%
      as.data.frame()


    colnames(x) <- header_cols

    team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Wt)))
  )
  x <- x %>%
    dplyr::mutate(Team = team_name,
                  Year = year,
                  Role = dplyr::case_when(.data$Minpct < 10.0 ~ "Benchwarmer",
                                          .data$Posspct < 12.0 ~ "Nearly Invisible",
                                          .data$Posspct >= 12.0 & .data$Posspct < 16.0 ~ "Limited Role",
                                          .data$Posspct >= 16.0 & .data$Posspct < 20.0 ~ "Role Player",
                                          .data$Posspct >= 20.0 & .data$Posspct < 24.0 ~ "Significant Contributor",
                                          .data$Posspct >= 24.0 & .data$Posspct < 28.0 ~ "Major Contributor",
                                          .data$Posspct >= 28.0 ~ "Go-to Guys")) %>%
    dplyr::select(.data$Role,tidyr::everything())

    y <- c(y, list(x))
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
#' @return A data frame with 12 columns:
#' \describe{
#'   \item{\code{PG}}{character. DESCRIPTION.}
#'   \item{\code{PG.Minpct}}{character. DESCRIPTION.}
#'   \item{\code{SG}}{character. DESCRIPTION.}
#'   \item{\code{SG.Minpct}}{character. DESCRIPTION.}
#'   \item{\code{SF}}{character. DESCRIPTION.}
#'   \item{\code{SF.Minpct}}{character. DESCRIPTION.}
#'   \item{\code{PF}}{character. DESCRIPTION.}
#'   \item{\code{PF.Minpct}}{character. DESCRIPTION.}
#'   \item{\code{C}}{character. DESCRIPTION.}
#'   \item{\code{C.Minpct}}{character. DESCRIPTION.}
#'   \item{\code{Team}}{character. DESCRIPTION.}
#'   \item{\code{Year}}{double. DESCRIPTION.}
#' }
#' @keywords Depth Chart
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select mutate
#' @export
#'
#' @examples
#'   \dontrun{
#'     get_team_depth_chart(browser, team = 'Florida St.', year= 2020)
#'   }
#'
#'

get_team_depth_chart <- function(browser, team, year= 2020){
  assertthat::assert_that(year>=2010, msg="Data only goes back to 2010")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)

  header_cols<- c("PG", "PG.Minpct", "SG", "SG.Minpct", "SF", "SF.Minpct",
                  "PF", "PF.Minpct", "C", "C.Minpct")

  x<- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#dc-table'))[[1]] %>%
    rvest::html_table(fill=FALSE) %>%
    as.data.frame()


  colnames(x) <- header_cols

  team_name <- gsub("\\+"," ",team)

  x <- x %>%
    dplyr::mutate(Team = team_name,
                  Year = year) %>%
    dplyr::select(.data$PG, .data$PG.Minpct, .data$SG, .data$SG.Minpct,
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
#' @return A data frame with 9 columns:
#' \describe{
#'   \item{\code{Rk}}{character. DESCRIPTION.}
#'   \item{\code{PG}}{character. DESCRIPTION.}
#'   \item{\code{SG}}{character. DESCRIPTION.}
#'   \item{\code{SF}}{character. DESCRIPTION.}
#'   \item{\code{PF}}{character. DESCRIPTION.}
#'   \item{\code{C}}{character. DESCRIPTION.}
#'   \item{\code{Minpct}}{character. DESCRIPTION.}
#'   \item{\code{Team}}{character. DESCRIPTION.}
#'   \item{\code{Year}}{double. DESCRIPTION.}
#' }
#' @keywords Depth Chart
#' @importFrom assertthat assert_that
#' @importFrom rvest jump_to html_nodes html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select mutate filter
#' @export
#'
#' @examples
#'   \dontrun{
#'     get_team_lineups(browser, team = 'Florida St.', year= 2020)
#'   }
#'

get_team_lineups <- function(browser, team, year= 2020){
  assertthat::assert_that(year>=2010, msg="Data only goes back to 2010")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team]
  # check for internet
  check_internet()
  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::jump_to(browser, url)

  header_cols<- c("Rk","PG", "SG", "SF",
                  "PF", "C", "Minpct")

  x<- (page %>%
    xml2::read_html() %>%
    rvest::html_nodes(css='#dc-table2'))[[1]] %>%
    rvest::html_table(fill=FALSE) %>%
    as.data.frame()

  colnames(x) <- header_cols
  team_name <- gsub("\\+"," ",team)
  suppressWarnings(
    x <- x %>%
      dplyr::filter(!is.na(as.numeric(.data$Minpct)))
  )

  x <- x %>%
    dplyr::mutate(Team = team_name,
                  Year = year) %>%
    dplyr::select(.data$Rk, .data$PG, .data$SG, .data$SF, .data$PF, .data$C,
                  .data$Minpct, .data$Team, .data$Year)

  ### Store Data
  kenpom <- x

  return(kenpom)
}



