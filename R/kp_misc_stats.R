#' **Get Division-I statistical trends**
#'
#'
#' @return A data frame with the following columns:
#'
#'    |col_name     |types   |description                                           |
#'    |:------------|:-------|:-----------------------------------------------------|
#'    |season       |numeric |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |efficiency   |numeric |Efficiency.                                           |
#'    |tempo        |numeric |Tempo.                                                |
#'    |e_fg_pct     |numeric |E field goals percentage (0-1 decimal).               |
#'    |to_pct       |numeric |To percentage (0-1 decimal).                          |
#'    |or_pct       |numeric |Or percentage (0-1 decimal).                          |
#'    |ft_rate      |numeric |Ft rate.                                              |
#'    |fg_2_pct     |numeric |Field goals 2 percentage (0-1 decimal).               |
#'    |fg_3_pct     |numeric |Field goals 3 percentage (0-1 decimal).               |
#'    |fg_3a_pct    |numeric |Field goals 3a percentage (0-1 decimal).              |
#'    |ft_pct       |numeric |Free throw percentage (0-1).                          |
#'    |a_pct        |numeric |A percentage (0-1 decimal).                           |
#'    |blk_pct      |numeric |Blocks percentage (0-1 decimal).                      |
#'    |stl_pct      |numeric |Steals percentage (0-1 decimal).                      |
#'    |non_stl_pct  |numeric |Non steals percentage (0-1 decimal).                  |
#'    |avg_hgt      |numeric |Avg hgt.                                              |
#'    |continuity   |numeric |Continuity.                                           |
#'    |home_win_pct |numeric |Home win percentage (0-1 decimal).                    |
#'    |ppg          |numeric |Points per game.                                      |
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
#' try(kp_trends())
#' }
kp_trends <- function() {
  .args <- .capture_args()
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      ### Pull Data
      url <- "https://kenpom.com/trends.php"
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "Season", "Efficiency", "Tempo", "eFG.Pct", "TO.Pct",
        "OR.Pct", "FTRate", "FG_2.Pct", "FG_3.Pct", "FG_3A.Pct", "FT.Pct",
        "A.Pct", "Blk.Pct", "Stl.Pct", "NonStl.Pct", "Avg.Hgt",
        "Continuity", "HomeWin.Pct", "PPG"
      )

      x <- (page %>%
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
        dplyr::mutate_at(c(
          "Season", "Efficiency", "Tempo", "eFG.Pct", "TO.Pct",
          "OR.Pct", "FTRate", "FG_2.Pct", "FG_3.Pct", "FG_3A.Pct", "FT.Pct",
          "A.Pct", "Blk.Pct", "Stl.Pct", "NonStl.Pct", "Avg.Hgt",
          "Continuity", "HomeWin.Pct", "PPG"
        ), as.numeric) %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no trends data available!",
      args = .args
    ),
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
#'    |col_name      |types     |description                     |
#'    |:-------------|:---------|:-------------------------------|
#'    |rk            |integer   |Rk.                             |
#'    |official_name |character |Official name.                  |
#'    |ref_rating    |numeric   |Ref rating.                     |
#'    |gms           |numeric   |Gms.                            |
#'    |last_game     |character |Last game date or score string. |
#'    |last_game_1   |character |Last game 1.                    |
#'    |year          |numeric   |4-digit year.                   |
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
#' try(kp_officials(year = 2021))
#' }
kp_officials <- function(year = most_recent_mbb_season()) {
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2016)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2016")
      }


      ### Pull Data
      url <- paste0("https://kenpom.com/officials.php?y=", year)
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "Rk", "OfficialName", "RefRating", "Gms", "Last.Game",
        "Last.Game.1", "Last.Game.2"
      )

      x <- (page %>%
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
        "Year" = year
      )
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(c("Year", "RefRating", "Gms"), as.numeric) %>%
          as.data.frame()
      )
      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no officials data for {year} available!",
      args = .args
    ),
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
#'    |col_name     |types     |description                 |
#'    |:------------|:---------|:---------------------------|
#'    |game_number  |integer   |Game number.                |
#'    |date         |character |Date in YYYY-MM-DD format.  |
#'    |time_et      |character |Time et.                    |
#'    |game         |character |Game.                       |
#'    |location     |character |Location.                   |
#'    |venue        |character |Venue name.                 |
#'    |conference   |character |Conference.                 |
#'    |thrill_score |numeric   |Thrill score.               |
#'    |referee_name |character |Referee name.               |
#'    |ref_rank     |numeric   |League/season rank for ref. |
#'    |year         |numeric   |4-digit year.               |
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
#' try(kp_referee(referee = 714363, year = 2021))
#' }
kp_referee <- function(referee, year) {
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2016)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2016")
      }


      ### Pull Data
      url <- paste0(
        "https://kenpom.com/referee.php?",
        "r=", referee,
        "&y=", year
      )
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "GameNumber", "Date", "Time (ET)", "Game", "Location",
        "Venue", "Conference", "ThrillScore"
      )

      x <- (page %>%
        rvest::html_elements("table"))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols
      rk <- page %>%
        rvest::html_element(".rank") %>%
        rvest::html_text()
      name <- page %>%
        rvest::html_element("h5") %>%
        rvest::html_text()
      x$RefereeName <- stringr::str_remove(name, "\\d+ ")
      x$RefRank <- as.numeric(rk)
      x <- dplyr::mutate(x,
        "Year" = year
      )

      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no referee data for {referee} in {year} available!",
      args = .args
    ),
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
#'    |col_name |types     |description                         |
#'    |:--------|:---------|:-----------------------------------|
#'    |team     |character |Team-side label or team identifier. |
#'    |conf     |character |character.                          |
#'    |hca      |numeric   |Hca.                                |
#'    |hca_rk   |numeric   |Hca rk.                             |
#'    |pf       |numeric   |Personal fouls.                     |
#'    |pf_rk    |numeric   |Pf rk.                              |
#'    |pts      |numeric   |Points scored.                      |
#'    |pts_rk   |numeric   |Pts rk.                             |
#'    |nst      |numeric   |Nst.                                |
#'    |nst_rk   |numeric   |Nst rk.                             |
#'    |blk      |numeric   |Blocks.                             |
#'    |blk_rk   |numeric   |Blk rk.                             |
#'    |elev     |numeric   |Elev.                               |
#'    |elev_rk  |numeric   |Elev rk.                            |
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
#' try(kp_hca())
#' }
kp_hca <- function() {
  .args <- .capture_args()
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      url <- paste0("https://kenpom.com/hca.php")
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "Team", "Conf", "HCA", "HCA.Rk", "PF", "PF.Rk", "Pts", "Pts.Rk", "NST", "NST.Rk",
        "Blk", "Blk.Rk", "Elev", "Elev.Rk"
      )

      x <- (page %>%
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
        dplyr::mutate_at(
          c(
            "HCA", "HCA.Rk", "PF", "PF.Rk", "Pts", "Pts.Rk",
            "NST", "NST.Rk", "Blk", "Blk.Rk", "Elev", "Elev.Rk"
          ),
          as.numeric
        ) %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no home court advantage data available!",
      args = .args
    ),
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
#'    |col_name  |types     |description                         |
#'    |:---------|:---------|:-----------------------------------|
#'    |rk        |numeric   |Rk.                                 |
#'    |team      |character |Team-side label or team identifier. |
#'    |conf      |character |character.                          |
#'    |arena     |character |Arena.                              |
#'    |alternate |character |Alternate.                          |
#'    |year      |numeric   |4-digit year.                       |
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
#' try(kp_arenas(year = 2021))
#' }
kp_arenas <- function(year = most_recent_mbb_season()) {
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2010)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
      }

      url <- paste0("https://kenpom.com/arenas.php?y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "Rk", "Team", "Conf", "Arena",
        "Alternate"
      )

      x <- (page %>%
        rvest::html_elements("table"))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols

      x <- dplyr::mutate(x,
        "Rk" = as.numeric(.data$Rk),
        "Year" = as.numeric(year)
      )
      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no arenas data available!",
      args = .args
    ),
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
#'    |col_name   |types     |description   |
#'    |:----------|:---------|:-------------|
#'    |rk         |integer   |Rk.           |
#'    |data       |character |Data.         |
#'    |game       |character |Game.         |
#'    |location   |character |Location.     |
#'    |conf       |character |character.    |
#'    |excitement |numeric   |Excitement.   |
#'    |year       |numeric   |4-digit year. |
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
#' try(kp_game_attrs(year = 2021, attr = "Excitement"))
#' }
kp_game_attrs <- function(
    year = most_recent_mbb_season(),
    attr = "Excitement") {
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2010)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
      }
      url <- paste0(
        "https://kenpom.com/game_attrs.php?",
        "y=", year,
        "&s=", attr
      )
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "Rk", "Data", "Game",
        "col", "Location", "Conf",
        attr
      )

      x <- (page %>%
        rvest::html_elements("table"))[[1]] %>%
        rvest::html_table()


      colnames(x) <- header_cols

      x <- dplyr::mutate(x,
        "Year" = year
      ) %>%
        as.data.frame()
      ### Store Data
      kenpom <- x %>%
        dplyr::select(-"col") %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no game attributes data for {attr} available!",
      args = .args
    ),
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
#'  |col_name     |types     |description                |
#'  |:------------|:---------|:--------------------------|
#'  |prediction   |character |Prediction.                |
#'  |time_et      |character |Time et.                   |
#'  |location     |character |Location.                  |
#'  |thrill_score |numeric   |Thrill score.              |
#'  |comeback     |numeric   |Comeback.                  |
#'  |excitement   |numeric   |Excitement.                |
#'  |road_rk      |numeric   |Road rk.                   |
#'  |road_team    |character |Road team.                 |
#'  |home_rk      |numeric   |Home team's rk.            |
#'  |home_team    |character |Home team's team.          |
#'  |win_rk       |numeric   |Win rk.                    |
#'  |win_team     |character |Win team.                  |
#'  |win_score    |numeric   |Win score.                 |
#'  |loss_rk      |numeric   |Loss rk.                   |
#'  |loss_team    |character |Loss team.                 |
#'  |loss_score   |numeric   |Loss score.                |
#'  |poss         |numeric   |Poss.                      |
#'  |mvp          |character |Mvp.                       |
#'  |event        |character |Event.                     |
#'  |date         |character |Date in YYYY-MM-DD format. |
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
#' try(kp_fanmatch(date = "2022-02-22"))
#' }
kp_fanmatch <- function(date) {
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination, set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      url <- paste0(
        "https://kenpom.com/fanmatch.php?",
        "d=", date
      )
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c(
        "Game", "Prediction", "Time(ET)",
        "Location", "ThrillScore", "Comeback", "Excitement"
      )

      x <- (page %>%
        rvest::html_elements("#fanmatch-table"))[[1]] %>%
        rvest::html_table()

      colnames(x) <- header_cols
      x <- x %>%
        dplyr::mutate(
          road_rk = stringr::str_extract(stringr::str_remove(
            stringr::str_extract(.data$Game, ".+(?<= at)|.+(?<= vs.)"),
            " at| vs."
          ), "\\d+"),
          road_team = stringr::str_remove(stringr::str_extract(
            stringr::str_extract(.data$Game, ".+(?<= at)|.+(?<= vs.)"),
            ".+(?= at)|.+(?= vs.)"
          ), "\\d+ "),
          home_rk = stringr::str_extract(stringr::str_remove(
            stringr::str_extract(.data$Game, "( at ).+|( vs. ).+"),
            " at | vs. "
          ), "\\d+"),
          home_team = stringr::str_remove(
            stringr::str_remove(
              stringr::str_extract(
                stringr::str_extract(.data$Game, "( at ).+|( vs. ).+"),
                "( at ).+|( vs. ).+"
              ),
              " \\d+ | at | vs. "
            ),
            "\\d+ "
          )
        )
      suppressWarnings(
        x <- x %>%
          tidyr::separate("Game",
            into = c("Winner", "col"),
            sep = ",",
            extra = "merge"
          )
      )

      x <- x %>%
        dplyr::mutate(
          WinRk = stringr::str_trim(stringr::str_extract(
            stringr::str_extract(.data$Winner, "[\\w]+"), "\\d{1,3}+"
          )),
          WinTeam = stringr::str_trim(stringr::str_remove(stringr::str_extract(
            stringr::str_extract(.data$Winner, "[^\\d]+"), ".+"
          ), " at ")),
          WinScore = stringr::str_trim(stringr::str_extract(
            stringi::stri_extract_last_regex(.data$Winner, "[\\d]+"), "\\d{1,3}+"
          )),
          Loser = stringr::str_extract(
            stringr::str_extract(.data$col, "[^\\[]+"), ".+"
          ),
          LossRk = stringr::str_trim(stringr::str_extract(
            stringr::str_extract(.data$Loser, "[\\w]+"), "\\d{1,3}+"
          )),
          LossTeam =
            stringr::str_trim(stringr::str_match(.data$Loser, "\\d{1,3}\\s(.*?)\\s\\d{1,3}")[, 2]),
          LossScore = stringr::str_extract(
            stringi::stri_extract_last_regex(.data$Loser, "[\\d]+"), "\\d{1,3}+"
          ),
          Poss = stringr::str_match(.data$col, "\\[(.*?)\\]")[, 2],
          MVP = stringr::str_match(.data$col, "MVP\\:(.*)")[, 2],
          Event = stringr::str_match(.data$col, "\\](.*)")[, 2]
        )

      x <- dplyr::mutate(x,
        "Date" = date
      )
      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$ThrillScore)))
      )
      ### Store Data
      x <- x %>%
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
          "Date"
        )
      suppressWarnings(
        kenpom <- x %>%
          dplyr::mutate_at(c(
            "road_rk", "home_rk", "WinRk", "WinScore", "LossRk", "LossScore", "Poss", "ThrillScore", "Comeback",
            "Excitement"
          ), as.numeric) %>%
          janitor::clean_names()
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no Fan Match data for {date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )

  return(kenpom)
}
