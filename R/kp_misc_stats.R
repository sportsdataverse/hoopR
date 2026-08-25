#' **Get Division-I statistical trends**
#'
#'
#' @rdname kp_arenas
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab numeric \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       efficiency \tab numeric \tab Efficiency. \cr
#'       tempo \tab numeric \tab Tempo. \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       to_pct \tab numeric \tab To percentage (0-1 decimal). \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       fg_3a_pct \tab numeric \tab Field goals 3a percentage (0-1 decimal). \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       a_pct \tab numeric \tab A percentage (0-1 decimal). \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       non_stl_pct \tab numeric \tab Non steals percentage (0-1 decimal). \cr
#'       avg_hgt \tab numeric \tab Avg hgt. \cr
#'       continuity \tab numeric \tab Continuity. \cr
#'       home_win_pct \tab numeric \tab Home win percentage (0-1 decimal). \cr
#'       ppg \tab numeric \tab Points per game. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname kp_arenas
#' @param year Year of data to pull
#'
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       rk \tab integer \tab Rk. \cr
#'       official_name \tab character \tab Official name. \cr
#'       ref_rating \tab numeric \tab Ref rating. \cr
#'       gms \tab numeric \tab Gms. \cr
#'       last_game \tab character \tab Last game date or score string. \cr
#'       last_game_1 \tab character \tab Last game 1. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname kp_arenas
#' @param referee Referee ID
#' @param year Year of data to pull
#'
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_number \tab integer \tab Game number. \cr
#'       date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       time_et \tab character \tab Time et. \cr
#'       game \tab character \tab Game. \cr
#'       location \tab character \tab Location. \cr
#'       venue \tab character \tab Venue name. \cr
#'       conference \tab character \tab Conference. \cr
#'       thrill_score \tab numeric \tab Thrill score. \cr
#'       referee_name \tab character \tab Referee name. \cr
#'       ref_rank \tab numeric \tab League/season rank for ref. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname kp_arenas
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       conf \tab character \tab character. \cr
#'       hca \tab numeric \tab Hca. \cr
#'       hca_rk \tab numeric \tab Hca rk. \cr
#'       pf \tab numeric \tab Personal fouls. \cr
#'       pf_rk \tab numeric \tab Pf rk. \cr
#'       pts \tab numeric \tab Points scored. \cr
#'       pts_rk \tab numeric \tab Pts rk. \cr
#'       nst \tab numeric \tab Nst. \cr
#'       nst_rk \tab numeric \tab Nst rk. \cr
#'       blk \tab numeric \tab Blocks. \cr
#'       blk_rk \tab numeric \tab Blk rk. \cr
#'       elev \tab numeric \tab Elev. \cr
#'       elev_rk \tab numeric \tab Elev rk. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       rk \tab numeric \tab Rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       conf \tab character \tab character. \cr
#'       arena \tab character \tab Arena. \cr
#'       alternate \tab character \tab Alternate. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname kp_arenas
#' @param year Year of data to pull
#' @param attr Game Attribute, valid values include: \cr
#' 'Excitement', 'Tension','Dominance','MinWp','FanMatch',\cr
#' 'Upsets','Busts','Comeback','Window'
#'
#' @return Returns a tibble with game attributes
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       rk \tab integer \tab Rk. \cr
#'       data \tab character \tab Data. \cr
#'       game \tab character \tab Game. \cr
#'       location \tab character \tab Location. \cr
#'       conf \tab character \tab character. \cr
#'       excitement \tab numeric \tab Excitement. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname kp_arenas
#' @param date Date of games to pull (YYYY-MM-DD)
#'
#' @return A data frame with the following columns:
#'
#'  \if{html}{\tabular{lll}{
#'     col_name \tab types \tab description \cr
#'     prediction \tab character \tab Prediction. \cr
#'     time_et \tab character \tab Time et. \cr
#'     location \tab character \tab Location. \cr
#'     thrill_score \tab numeric \tab Thrill score. \cr
#'     comeback \tab numeric \tab Comeback. \cr
#'     excitement \tab numeric \tab Excitement. \cr
#'     road_rk \tab numeric \tab Road rk. \cr
#'     road_team \tab character \tab Road team. \cr
#'     home_rk \tab numeric \tab Home team's rk. \cr
#'     home_team \tab character \tab Home team's team. \cr
#'     win_rk \tab numeric \tab Win rk. \cr
#'     win_team \tab character \tab Win team. \cr
#'     win_score \tab numeric \tab Win score. \cr
#'     loss_rk \tab numeric \tab Loss rk. \cr
#'     loss_team \tab character \tab Loss team. \cr
#'     loss_score \tab numeric \tab Loss score. \cr
#'     poss \tab numeric \tab Poss. \cr
#'     mvp \tab character \tab Mvp. \cr
#'     event \tab character \tab Event. \cr
#'     date \tab character \tab Date in YYYY-MM-DD format. \cr
#'  }}
#'  \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
