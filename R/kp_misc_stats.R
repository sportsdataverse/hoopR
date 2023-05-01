#' **Get Division-I statistical trends**
#'
#'
#' @return A data frame with the following columns:
#'
#'    |col_name     |types   |
#'    |:------------|:-------|
#'    |season       |numeric |
#'    |efficiency   |numeric |
#'    |tempo        |numeric |
#'    |e_fg_pct     |numeric |
#'    |to_pct       |numeric |
#'    |or_pct       |numeric |
#'    |ft_rate      |numeric |
#'    |fg_2_pct     |numeric |
#'    |fg_3_pct     |numeric |
#'    |fg_3a_pct    |numeric |
#'    |ft_pct       |numeric |
#'    |a_pct        |numeric |
#'    |blk_pct      |numeric |
#'    |stl_pct      |numeric |
#'    |non_stl_pct  |numeric |
#'    |avg_hgt      |numeric |
#'    |continuity   |numeric |
#'    |home_win_pct |numeric |
#'    |ppg          |numeric |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate_at
#' @import rvest
#' @export
#' @keywords Trends
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_trends())
#' }

kp_trends <- function(){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      ### Pull Data
      url <- "https://kenpom.com/trends.php"
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("Season","Efficiency","Tempo","eFG.Pct","TO.Pct",
                       "OR.Pct","FTRate","FG_2.Pct","FG_3.Pct","FG_3A.Pct",'FT.Pct',
                       "A.Pct","Blk.Pct","Stl.Pct","NonStl.Pct","Avg.Hgt",
                       "Continuity","HomeWin.Pct","PPG")

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols
      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$eFG.Pct)))
      )
      ### Store Data
      kenpom <- x %>%
        dplyr::mutate_at(c("Season","Efficiency","Tempo","eFG.Pct","TO.Pct",
                           "OR.Pct","FTRate","FG_2.Pct","FG_3.Pct","FG_3A.Pct",'FT.Pct',
                           "A.Pct","Blk.Pct","Stl.Pct","NonStl.Pct","Avg.Hgt",
                           "Continuity","HomeWin.Pct","PPG"), as.numeric) %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no trends data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get officials rankings**
#'
#' @param year Year of data to pull
#'
#' @return A data frame with the following columns:
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |rk            |integer   |
#'    |official_name |character |
#'    |ref_rating    |numeric   |
#'    |gms           |numeric   |
#'    |last_game     |character |
#'    |last_game_1   |character |
#'    |year          |numeric   |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate mutate_at
#' @import rvest
#' @export
#' @keywords Refs
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_officials(year = 2021))
#' }

kp_officials <- function(year = most_recent_mbb_season()){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2016)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2016")
      }


      ### Pull Data
      url <- paste0("https://kenpom.com/officials.php?y=",year)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("Rk","OfficialName","RefRating","Gms","Last.Game",
                       "Last.Game.1","Last.Game.2")

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols
      x <- x %>%
        dplyr::select(-"Last.Game.2") %>%
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
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no officials data for {year} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get referee game log**
#' @param referee Referee ID
#' @param year Year of data to pull
#'
#' @return A data frame with the following columns:
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |game_number  |integer   |
#'    |date         |character |
#'    |time_et      |character |
#'    |game         |character |
#'    |location     |character |
#'    |venue        |character |
#'    |conference   |character |
#'    |thrill_score |numeric   |
#'    |referee_name |character |
#'    |ref_rank     |numeric   |
#'    |year         |numeric   |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate mutate_at
#' @import rvest
#' @export
#' @keywords Refs
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_referee(referee = 714363, year = 2021))
#' }

kp_referee <- function(referee, year){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2016)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2016")
      }


      ### Pull Data
      url <- paste0("https://kenpom.com/referee.php?",
                    "r=",referee,
                    "&y=",year)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("GameNumber","Date","Time (ET)","Game","Location",
                       "Venue","Conference", "ThrillScore")

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols
      rk <- page %>%
        xml2::read_html() %>%
        rvest::html_element(".rank") %>%
        rvest::html_text()
      name <- page %>%
        xml2::read_html() %>%
        rvest::html_element("h5") %>%
        rvest::html_text()
      x$RefereeName <- stringr::str_remove(name,"\\d+ ")
      x$RefRank <- as.numeric(rk)
      x <- dplyr::mutate(x,
                         "Year" = year)

      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no referee data for {referee} in {year} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get Home Court Advantage Estimates**
#'
#'
#' @return A data frame with the following columns:
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |team     |character |
#'    |conf     |character |
#'    |hca      |numeric   |
#'    |hca_rk   |numeric   |
#'    |pf       |numeric   |
#'    |pf_rk    |numeric   |
#'    |pts      |numeric   |
#'    |pts_rk   |numeric   |
#'    |nst      |numeric   |
#'    |nst_rk   |numeric   |
#'    |blk      |numeric   |
#'    |blk_rk   |numeric   |
#'    |elev     |numeric   |
#'    |elev_rk  |numeric   |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate_at
#' @import rvest
#' @export
#' @keywords HCA
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_hca())
#' }

kp_hca <- function(){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      url <- paste0("https://kenpom.com/hca.php")
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("Team",	"Conf",	"HCA","HCA.Rk",	"PF","PF.Rk",	"Pts","Pts.Rk",	"NST","NST.Rk",
                       "Blk","Blk.Rk",	"Elev","Elev.Rk")

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
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
                         as.numeric) %>%
        janitor::clean_names()
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no home court advantage data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(kenpom)
}


#' **Get Home Court Arenas**
#'
#' @param year Year of data to pull
#' @return A data frame with the following columns:
#'
#'    |col_name  |types     |
#'    |:---------|:---------|
#'    |rk        |numeric   |
#'    |team      |character |
#'    |conf      |character |
#'    |arena     |character |
#'    |alternate |character |
#'    |year      |numeric   |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate
#' @import rvest
#' @export
#' @keywords Arenas
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_arenas(year=2021))
#' }

kp_arenas <- function(year=most_recent_mbb_season()){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2010)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
      }

      url <- paste0("https://kenpom.com/arenas.php?y=",year)

      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("Rk","Team",	"Conf",	"Arena",
                       "Alternate")

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols

      x <- dplyr::mutate(x,
                         "Rk" = as.numeric(.data$Rk),
                         "Year" = as.numeric(year))
      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no arenas data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(kenpom)
}

#' **Get Game Attributes**
#'
#'
#' @param year Year of data to pull
#' @param attr Game Attribute, valid values include: \cr
#' 'Excitement', 'Tension','Dominance','MinWp','FanMatch',\cr
#' 'Upsets','Busts','Comeback','Window'
#'
#' @return Returns a tibble with game attributes
#'
#'    |col_name   |types     |
#'    |:----------|:---------|
#'    |rk         |integer   |
#'    |data       |character |
#'    |game       |character |
#'    |location   |character |
#'    |conf       |character |
#'    |excitement |numeric   |
#'    |year       |numeric   |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select mutate
#' @import rvest
#' @export
#' @keywords Game
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_game_attrs(year = 2021, attr = "Excitement"))
#' }

kp_game_attrs <- function(
    year = most_recent_mbb_season(),
    attr = "Excitement") {
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2010)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
      }
      url <- paste0("https://kenpom.com/game_attrs.php?",
                    "y=", year,
                    "&s=", attr)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("Rk","Data","Game",
                       "col","Location","Conf",
                       attr)

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
        rvest::html_table()


      colnames(x) <- header_cols

      x <- dplyr::mutate(x,
                         "Year" = year) %>%
        as.data.frame()
      ### Store Data
      kenpom <- x %>%
        dplyr::select(-"col") %>%
        janitor::clean_names()
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no game attributes data for {attr} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(kenpom)
}


#' **Get FanMatch by date**
#'
#' @param date Date of games to pull (YYYY-MM-DD)
#'
#' @return A data frame with the following columns:
#'
#'  |col_name     |types     |
#'  |:------------|:---------|
#'  |prediction   |character |
#'  |time_et      |character |
#'  |location     |character |
#'  |thrill_score |numeric   |
#'  |comeback     |numeric   |
#'  |excitement   |numeric   |
#'  |road_rk      |numeric   |
#'  |road_team    |character |
#'  |home_rk      |numeric   |
#'  |home_team    |character |
#'  |win_rk       |numeric   |
#'  |win_team     |character |
#'  |win_score    |numeric   |
#'  |loss_rk      |numeric   |
#'  |loss_team    |character |
#'  |loss_score   |numeric   |
#'  |poss         |numeric   |
#'  |mvp          |character |
#'  |event        |character |
#'  |date         |character |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate
#' @importFrom tidyr separate
#' @import rvest
#' @import stringr
#' @export
#' @keywords FanMatch
#' @family KP Misc. Functions
#'
#' @examples
#' \donttest{
#'   try(kp_fanmatch(date="2022-02-22"))
#' }

kp_fanmatch <- function(date){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      url <- paste0("https://kenpom.com/fanmatch.php?",
                    "d=", date)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c("Game","Prediction","Time(ET)",
                       "Location","ThrillScore","Comeback","Excitement")

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("#fanmatch-table"))[[1]] %>%
        rvest::html_table()

      colnames(x) <- header_cols
      x <- x %>%
        dplyr::mutate(
          road_rk = stringr::str_extract(stringr::str_remove(
            stringr::str_extract(.data$Game,".+(?<= at)|.+(?<= vs.)"),
              " at| vs."
            ),"\\d+"
          ),
          road_team = stringr::str_remove(stringr::str_extract(
            stringr::str_extract(.data$Game,".+(?<= at)|.+(?<= vs.)"),
            ".+(?= at)|.+(?= vs.)"
          ),"\\d+ "),
          home_rk = stringr::str_extract(stringr::str_remove(
            stringr::str_extract(.data$Game,"( at ).+|( vs. ).+"),
            " at | vs. "
          ),"\\d+"
          ),
          home_team = stringr::str_remove(
            stringr::str_remove(
              stringr::str_extract(
                stringr::str_extract(.data$Game,"( at ).+|( vs. ).+"),
                "( at ).+|( vs. ).+"),
              " \\d+ | at | vs. "),
            "\\d+ ")
        )
      suppressWarnings(
        x <- x %>%
          tidyr::separate("Game",
                          into = c("Winner","col"),
                          sep = ",",
                          extra = "merge"))

      x <- x %>%
        dplyr::mutate(
          WinRk = stringr::str_trim(stringr::str_extract(
            stringr::str_extract(.data$Winner,"[\\w]+"),"\\d{1,3}+")),
          WinTeam = stringr::str_trim(stringr::str_remove(stringr::str_extract(
            stringr::str_extract(.data$Winner,'[^\\d]+'),".+")," at ")),
          WinScore = stringr::str_trim(stringr::str_extract(
            stringi::stri_extract_last_regex(.data$Winner,'[\\d]+'),"\\d{1,3}+")),
          Loser = stringr::str_extract(
            stringr::str_extract(.data$col,'[^\\[]+'),".+"),
          LossRk = stringr::str_trim(stringr::str_extract(
            stringr::str_extract(.data$Loser,"[\\w]+"),"\\d{1,3}+")),
          LossTeam =
            stringr::str_trim(stringr::str_match(.data$Loser,'\\d{1,3}\\s(.*?)\\s\\d{1,3}')[,2]),
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
          dplyr::filter(!is.na(as.numeric(.data$ThrillScore)))
      )
      ### Store Data
      x <- x  %>%
        dplyr::select(
          -"col",
          -"Winner",
          -"Loser",
          "road_rk",
          "road_team",
          "home_rk",
          "home_team",
          "WinRk",
          "WinTeam",
          "WinScore",
          "LossRk",
          "LossTeam",
          "LossScore",
          "Poss",
          "Prediction",
          "ThrillScore",
          "Comeback",
          "Excitement",
          "MVP",
          "Location",
          "Time(ET)",
          "Event",
          "Date")
      suppressWarnings(
        kenpom <- x %>%
          dplyr::mutate_at(c("road_rk","home_rk","WinRk","WinScore", "LossRk","LossScore","Poss","ThrillScore","Comeback",
                             "Excitement"), as.numeric) %>%
          janitor::clean_names()
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no Fan Match data for {date} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(kenpom)
}
