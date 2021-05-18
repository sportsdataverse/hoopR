#' Get KenPom Ratings
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#'
#' @keywords Ratings
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select filter mutate arrange bind_rows
#' @importFrom tidyr everything
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_pomeroy_ratings(min_year = 2020, max_year = 2020)
#' }

kp_pomeroy_ratings <- function(min_year, max_year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(max_year>=2002, msg="Data only goes back to 2002")

  years <- min_year:max_year

  for(year in years) {


    ### Pull Data
    url <- paste0("https://kenpom.com/index.php?y=", year)
    page <- rvest::session_jump_to(browser, url)
    header_cols <- c("Rk", "Team", "Conf", "W-L",
                     "AdjEM", "AdjO", "AdjO.Rk", "AdjD", "AdjD.Rk",
                     "AdjT", "AdjT.Rk", "Luck", "Luck.Rk",
                     "SOS.AdjEM", "SOS.AdjEM.Rk", "SOS.OppO", "SOS.OppO.Rk",
                     "SOS.OppD", "SOS.OppD.Rk", "NCSOS.AdjEM", "NCSOS.AdjEM.Rk")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements("#ratings-table"))[[1]] %>%
      rvest::html_table()

    colnames(x) <- header_cols
    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$SOS.OppO)))
    )

    x <- dplyr::mutate(x,
                       "NCAA_Seed" = NA_integer_,
                       "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year) %>%
      as.data.frame()

    x <- x %>%
      dplyr::mutate_at(
        c("Rk","AdjEM","AdjO","AdjO.Rk","AdjD","AdjD.Rk","AdjT","AdjT.Rk",
          "Luck","Luck.Rk","SOS.AdjEM","SOS.AdjEM.Rk","SOS.OppO","SOS.OppO.Rk",
          "SOS.OppD","SOS.OppD.Rk","NCSOS.AdjEM","NCSOS.AdjEM.Rk"), as.numeric) %>%
      dplyr::select(.data$Year, tidyr::everything())

    ### Store Data
    if(year == min_year) {
      kenpom <- x
    }else {
      kenpom <- dplyr::bind_rows(kenpom, x)
    }
  }
  kenpom <- kenpom %>%
    dplyr::arrange(-.data$Year, .data$Rk) %>%
    janitor::clean_names()
  return(kenpom)
}


#' Get KenPom Efficiency and Tempo Summary
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#'
#' @keywords Efficiency
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate mutate_at bind_rows
#' @importFrom stringr str_remove str_remove str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'  kp_efficiency(min_year = 2020, max_year = 2020)
#' }

kp_efficiency <- function(min_year, max_year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(min_year>=2002, msg="Data only goes back to 2002")

  years <- min_year:max_year

  for(year in years) {

    ### Pull Data
    url <- paste0("https://kenpom.com/summary.php?y=", year)
    page <- rvest::session_jump_to(browser, url)
    if(year<2010){

      header_cols <- c("Team", "Conf", "AdjT", "AdjT.Rk","RawT", "RawT.Rk",
                       "AdjO", "AdjO.Rk", "RawO", "RawO.Rk",
                       "AdjD", "AdjD.Rk", "RawD", "RawD.Rk")
      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("#ratings-table"))[[1]] %>%
        rvest::html_table()

      x <- x[,1:14]
      colnames(x) <- header_cols
      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$AdjO)))
      )
      x <- x %>%
        dplyr::mutate(
          AvgPossLengthOff = 0.0,
          AvgPossLengthOff.Rk = 0,
          AvgPossLengthDef = 0.0,
          AvgPossLengthDef.Rk = 0)



      x <- x[,c("Team", "Conf", "AdjT", "AdjT.Rk","RawT", "RawT.Rk",
                "AvgPossLengthOff","AvgPossLengthOff.Rk",
                "AvgPossLengthDef","AvgPossLengthDef.Rk",
                "AdjO", "AdjO.Rk", "RawO", "RawO.Rk",
                "AdjD", "AdjD.Rk", "RawD", "RawD.Rk")]

      x <- dplyr::mutate(x,
                         "NCAA_Seed" = NA_integer_,
                         "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                         "Team" = sapply(.data$Team, function(arg) {
                           stringr::str_trim(str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                         "Year" = year) %>%
        dplyr::mutate_at(
          c("AdjT", "AdjT.Rk","RawT", "RawT.Rk",
            "AvgPossLengthOff","AvgPossLengthOff.Rk",
            "AvgPossLengthDef","AvgPossLengthDef.Rk",
            "AdjO", "AdjO.Rk", "RawO", "RawO.Rk",
            "AdjD", "AdjD.Rk", "RawD", "RawD.Rk", "Year"),
          as.numeric) %>%
        as.data.frame()

    }else{

      header_cols <- c("Team", "Conf", "AdjT", "AdjT.Rk","RawT", "RawT.Rk",
                       "AvgPossLengthOff","AvgPossLengthOff.Rk",
                       "AvgPossLengthDef","AvgPossLengthDef.Rk",
                       "AdjO", "AdjO.Rk", "RawO", "RawO.Rk",
                       "AdjD", "AdjD.Rk", "RawD", "RawD.Rk")
      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("#ratings-table"))[[1]] %>%
        rvest::html_table()


      x <- x[,1:18]

      colnames(x) <- header_cols
      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$AdjO)))
      )


      x <- dplyr::mutate(x,
                         "NCAA_Seed" = NA_integer_,
                         "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                         "Team" = sapply(.data$Team, function(arg) {
                           stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                         "Year" = year) %>%
        dplyr::mutate_at(
          c("AdjT", "AdjT.Rk","RawT", "RawT.Rk",
            "AvgPossLengthOff","AvgPossLengthOff.Rk",
            "AvgPossLengthDef","AvgPossLengthDef.Rk",
            "AdjO", "AdjO.Rk", "RawO", "RawO.Rk",
            "AdjD", "AdjD.Rk", "RawD", "RawD.Rk", "Year"),
          as.numeric) %>%
        as.data.frame()
    }

    ### Store Data
    if(year == min_year) {
      kenpom <- x
    }else {
      kenpom <- dplyr::bind_rows(kenpom, x)
    }
  }
  kenpom <- kenpom %>%
    dplyr::arrange(-.data$Year, .data$AdjT.Rk) %>%
    janitor::clean_names()
  return(kenpom)
}

#' Get Four Factors Data
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#'
#' @keywords Four Factors
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select mutate filter bind_rows
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'  kp_fourfactors(min_year = 2020, max_year = 2020)
#' }

kp_fourfactors <- function(min_year, max_year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(min_year>=2002, msg="Data only goes back to 2002")

  years <- min_year:max_year

  for(year in years) {


    ### Pull Data
    url <- paste0("https://kenpom.com/stats.php?",
                  "y=", year)
    page <- rvest::session_jump_to(browser, url)
    header_cols <- c("Team", "Conf", "AdjT", "AdjT.Rk",
                     "AdjO", "AdjO.Rk", "Off.eFG.Pct", "Off.eFG.Pct.Rk",
                     "Off.TO.Pct", "Off.TO.Pct.Rk", "Off.OR.Pct", "Off.OR.Pct.Rk",
                     "Off.FTRate", "Off.FTRate.Rk",
                     "AdjD", "AdjD.Rk", "Def.eFG.Pct", "Def.eFG.Pct.Rk",
                     "Def.TO.Pct", "Def.TO.Pct.Rk", "Def.OR.Pct", "Def.OR.Pct.Rk",
                     "Def.FTRate", "Def.FTRate.Rk")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#ratings-table'))[[1]] %>%
      rvest::html_table()
    x <- x[,1:24]

    colnames(x) <- header_cols

    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$AdjO)))
    )

    x <- dplyr::mutate(x,
                       "NCAA_Seed" = NA_integer_,
                       "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year) %>%
    dplyr::mutate_at(
      c("AdjT", "AdjT.Rk", "AdjO", "AdjO.Rk", "Off.eFG.Pct", "Off.eFG.Pct.Rk",
        "Off.TO.Pct", "Off.TO.Pct.Rk", "Off.OR.Pct", "Off.OR.Pct.Rk",
        "Off.FTRate", "Off.FTRate.Rk",
        "AdjD", "AdjD.Rk", "Def.eFG.Pct", "Def.eFG.Pct.Rk",
        "Def.TO.Pct", "Def.TO.Pct.Rk", "Def.OR.Pct", "Def.OR.Pct.Rk",
        "Def.FTRate", "Def.FTRate.Rk", "Year"), as.numeric) %>%
      as.data.frame()

    ### Store Data
    if(year == min_year) {
      kenpom <- x
    }else {
      kenpom <- dplyr::bind_rows(kenpom, x)
    }
  }
  kenpom <- kenpom %>%
    dplyr::arrange(-.data$Year,.data$AdjO.Rk) %>%
    janitor::clean_names()
  return(kenpom)
}

#' Get Team Points Distribution
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#'
#' @keywords Points
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate filter bind_rows
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_pointdist(min_year = 2020, max_year = 2020)
#' }

kp_pointdist <- function(min_year, max_year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(min_year>=2002, msg="Data only goes back to 2002")

  years <- min_year:max_year

  for(year in years) {


    ### Pull Data
    url <- paste0("https://kenpom.com/pointdist.php?",
                  "y=", year)

    page <- rvest::session_jump_to(browser, url)
    header_cols <- c("Team", "Conf",
                     "Off.FT.Pct", "Off.FT.Pct.Rk",
                     "Off.FG_2.Pct", "Off.FG_2.Pct.Rk",
                     "Off.FG_3.Pct", "Off.FG_3.Pct.Rk",
                     "Def.FT.Pct", "Def.FT.Pct.Rk",
                     "Def.FG_2.Pct", "Def.FG_2.Pct.Rk",
                     "Def.FG_3.Pct", "Def.FG_3.Pct.Rk")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#ratings-table'))[[1]] %>%
      rvest::html_table()

    x <- x[,1:14]

    colnames(x) <- header_cols

    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$Off.FT.Pct)))
    )

    x <- dplyr::mutate(x,
                       "NCAA_Seed" = NA_integer_,
                       "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year) %>%
      dplyr:: mutate_at(
        c("Off.FT.Pct", "Off.FT.Pct.Rk",
          "Off.FG_2.Pct", "Off.FG_2.Pct.Rk",
          "Off.FG_3.Pct", "Off.FG_3.Pct.Rk",
          "Def.FT.Pct", "Def.FT.Pct.Rk",
          "Def.FG_2.Pct", "Def.FG_2.Pct.Rk",
          "Def.FG_3.Pct", "Def.FG_3.Pct.Rk","Year"), as.numeric) %>%
      as.data.frame()

    ### Store Data
    if(year == min_year) {
      kenpom <- x
    }else {
      kenpom <- dplyr::bind_rows(kenpom, x)
    }
  }
  kenpom <- kenpom %>%
    janitor::clean_names()
  return(kenpom)
}

#' Get Heights, Experience, Bench and Continuity Data
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#'
#' @keywords Roster
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate bind_rows
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'  kp_height(min_year = 2020, max_year = 2020)
#' }

kp_height <- function(min_year,max_year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(min_year>=2007, msg="Data only goes back to 2007")
  years <- min_year:max_year

  for(year in years) {

    ### Pull Data
    url <- paste0("https://kenpom.com/height.php?",
                  "y=", year)

    page <- rvest::session_jump_to(browser, url)
    if(year<2008){
      header_cols <- c("Team", "Conf",
                       "Avg.Hgt", "Avg.Hgt.Rk",
                       "Eff.Hgt", "Eff.Hgt.Rk",
                       "C.Hgt", "C.Hgt.Rk",
                       "PF.Hgt", "PF.Hgt.Rk",
                       "SF.Hgt", "SF.Hgt.Rk",
                       "SG.Hgt", "SG.Hgt.Rk",
                       "PG.Hgt", "PG.Hgt.Rk",
                       "Experience", "Experience.Rk",
                       "Bench", "Bench.Rk")

      x <- (page %>%
        xml2::read_html() %>%
        rvest::html_elements(css='#ratings-table'))[[1]] %>%
        rvest::html_table()
      x <- x[,1:20]
      colnames(x) <- header_cols
      x <- x %>%
        dplyr::mutate(
          Continuity = 0.0,
          Continuity.Rk = 0)
      x <- dplyr::mutate(x,
                         "NCAA_Seed" = NA_integer_,
                         "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                         "Team" = sapply(.data$Team, function(arg) {
                           stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                         "Year" = year) %>%
        dplyr:: mutate_at(
          c("Avg.Hgt", "Avg.Hgt.Rk",
            "Eff.Hgt", "Eff.Hgt.Rk",
            "C.Hgt", "C.Hgt.Rk",
            "PF.Hgt", "PF.Hgt.Rk",
            "SF.Hgt", "SF.Hgt.Rk",
            "SG.Hgt", "SG.Hgt.Rk",
            "PG.Hgt", "PG.Hgt.Rk",
            "Experience", "Experience.Rk",
            "Bench", "Bench.Rk","Continuity","Continuity.Rk"), as.numeric) %>%
        as.data.frame()
    }else{
      header_cols <- c("Team", "Conf",
                       "Avg.Hgt", "Avg.Hgt.Rk",
                       "Eff.Hgt", "Eff.Hgt.Rk",
                       "C.Hgt", "C.Hgt.Rk",
                       "PF.Hgt", "PF.Hgt.Rk",
                       "SF.Hgt", "SF.Hgt.Rk",
                       "SG.Hgt", "SG.Hgt.Rk",
                       "PG.Hgt", "PG.Hgt.Rk",
                       "Experience", "Experience.Rk",
                       "Bench", "Bench.Rk",
                       "Continuity", "Continuity.Rk")

      x <- (page %>%
        xml2::read_html() %>%
        rvest::html_elements(css='#ratings-table'))[[1]] %>%
        rvest::html_table()

      x <- x[,1:22]
      colnames(x) <- header_cols
    }

    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$Avg.Hgt)))
    )


    x <- dplyr::mutate(x,
                       "NCAA_Seed" = NA_integer_,
                       "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year) %>%
      dplyr:: mutate_at(
        c("Avg.Hgt", "Avg.Hgt.Rk",
          "Eff.Hgt", "Eff.Hgt.Rk",
          "C.Hgt", "C.Hgt.Rk",
          "PF.Hgt", "PF.Hgt.Rk",
          "SF.Hgt", "SF.Hgt.Rk",
          "SG.Hgt", "SG.Hgt.Rk",
          "PG.Hgt", "PG.Hgt.Rk",
          "Experience", "Experience.Rk",
          "Bench", "Bench.Rk","Continuity","Continuity.Rk"), as.numeric) %>%
      as.data.frame()

    ### Store Data
    if(year == min_year) {
      kenpom <- x
    }else {
      kenpom <- dplyr::bind_rows(kenpom, x)
    }
  }
  kenpom <- kenpom %>%
    janitor::clean_names()
  return(kenpom)
}

#' Get 2-Foul Participation Stats
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#'
#' @keywords Foul Trouble
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate filter bind_rows
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_foul_trouble(min_year = 2020, max_year = 2020)
#' }

kp_foul_trouble <- function(min_year, max_year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(min_year>=2010, msg="Data only goes back to 2010")

  years <- min_year:max_year

  for(year in years) {

    ### Pull Data
    url <- paste0("https://kenpom.com/foul_trouble.php?",
                  "y=", year)

    page <- rvest::session_jump_to(browser, url)

    header_cols <- c("Team", "Conf", "TwoFoulParticpation.Pct",
                     "TwoFoulParticpation.Pct.Rk",	"Adj2FP", "Adj2FP.Rk",
                     "TwoFoulTotalTime","TwoFoulTotalTime.Rk",
                     "TwoFoulTimeOn","TwoFoulTimeOn.Rk",
                     "Bench.Pct","Bench.Pct.Rk")
    x <- (page %>%
            xml2::read_html() %>%
            rvest::html_elements(css='#ratings-table'))[[1]] %>%
      rvest::html_table()

    x <- x[,1:12]

    colnames(x) <- header_cols

    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$TwoFoulParticpation.Pct)))
    )

    x <- dplyr::mutate(x,
                       "NCAA_Seed" = NA_integer_,
                       "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year) %>%
      dplyr:: mutate_at(
        c("TwoFoulParticpation.Pct",
          "TwoFoulParticpation.Pct.Rk",	"Adj2FP", "Adj2FP.Rk",
          "Bench.Pct","Bench.Pct.Rk"), as.numeric) %>%
      as.data.frame()

    ### Store Data
    if(year == min_year) {
      kenpom <- x
    }else {
      kenpom <- dplyr::bind_rows(kenpom, x)
    }
  }
  kenpom <- kenpom %>%
    janitor::clean_names()
  return(kenpom)
}


#' Get Team Stats
#'
#' @param min_year First year of data to pull
#' @param max_year Last year of data to pull
#' @param defense Choose whether to pull offense(default) with FALSE or defense with TRUE
#'
#' @keywords Team
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate bind_rows
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'  kp_teamstats(min_year = 2019, max_year = 2020, defense = FALSE)
#' }

kp_teamstats <- function(min_year, max_year, defense = FALSE){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(min_year>=2002, msg="Data only goes back to 2002")

  years <- min_year:max_year

  for(year in years) {

      ### Pull Data
      url <- paste0("https://kenpom.com/teamstats.php?",
                    "y=", year, "&od=o")

      page <- rvest::session_jump_to(browser, url)

      header_cols <- c("Team", "Conf",
                       "Off.FG_3.Pct", "Off.FG_3.Pct.Rk",
                       "Off.FG_2.Pct", "Off.FG_2.Pct.Rk",
                       "Off.FT.Pct", "Off.FT.Pct.Rk",
                       "Off.Blk.Pct", "Off.Blk.Pct.Rk",
                       "Off.Stl.Pct", "Off.Stl.Pct.Rk",
                       "Off.NonStl.Pct", "Off.NonStl.Pct.Rk",
                       "Off.A.Pct", "Off.A.Pct.Rk",
                       "Off.FG_3A.Pct", "Off.FG_3A.Pct.Rk",
                       "AdjO","AdjO.Rk")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#ratings-table'))[[1]] %>%
      rvest::html_table()

    x <- x[,1:20]

    colnames(x) <- header_cols

    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$Off.FG_3.Pct)))
    )

    x <- dplyr::mutate(x,
                       "NCAA_Seed" = NA_integer_,
                       "NCAA_Seed" = sapply(.data$Team, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year) %>%
      dplyr::mutate_at(
        c("Off.FG_3.Pct", "Off.FG_3.Pct.Rk",
          "Off.FG_2.Pct", "Off.FG_2.Pct.Rk",
          "Off.FT.Pct", "Off.FT.Pct.Rk",
          "Off.Blk.Pct", 'Off.Blk.Pct.Rk',
          "Off.Stl.Pct", "Off.Stl.Pct.Rk",
          "Off.NonStl.Pct", "Off.NonStl.Pct.Rk",
          "Off.A.Pct", "Off.A.Pct.Rk",
          "Off.FG_3A.Pct", "Off.FG_3A.Pct.Rk", "AdjO", "AdjO.Rk", "Year"), as.numeric) %>%
      as.data.frame()
    ### Pull Data
    url <- paste0("https://kenpom.com/teamstats.php?",
                  "y=", year, "&od=d")

    page <- rvest::session_jump_to(browser, url)
    d_header_cols <- c("Team", "Conf",
                     "Def.FG_3.Pct", "Def.FG_3.Pct.Rk",
                     "Def.FG_2.Pct", "Def.FG_2.Pct.Rk",
                     "Def.FT.Pct", "Def.FT.Pct.Rk",
                     "Def.Blk.Pct", 'Def.Blk.Pct.Rk',
                     "Def.Stl.Pct", "Def.Stl.Pct.Rk",
                     "Def.NonStl.Pct", "Def.NonStl.Pct.Rk",
                     "Def.A.Pct", "Def.A.Pct.Rk",
                     "Def.FG_3A.Pct", "Def.FG_3A.Pct.Rk",
                     "AdjD","AdjD.Rk")

    y <- (page %>%
            xml2::read_html() %>%
            rvest::html_elements(css='#ratings-table'))[[1]] %>%
      rvest::html_table()

    y <- y[,1:20]

    colnames(y) <- d_header_cols

    suppressWarnings(
      y <- y %>%
        dplyr::filter(!is.na(as.numeric(.data$Def.FG_3.Pct)))
    )

    y <- y %>%
      dplyr::mutate_at(
        c("Def.FG_3.Pct", "Def.FG_3.Pct.Rk",
          "Def.FG_2.Pct", "Def.FG_2.Pct.Rk",
          "Def.FT.Pct", "Def.FT.Pct.Rk",
          "Def.Blk.Pct", 'Def.Blk.Pct.Rk',
          "Def.Stl.Pct", "Def.Stl.Pct.Rk",
          "Def.NonStl.Pct", "Def.NonStl.Pct.Rk",
          "Def.A.Pct", "Def.A.Pct.Rk",
          "Def.FG_3A.Pct", "Def.FG_3A.Pct.Rk",
          "AdjD", "AdjD.Rk"), as.numeric) %>%
      as.data.frame()

    y <- y %>% dplyr::select(-.data$Team, -.data$Conf)
    z <- dplyr::bind_cols(x, y)

    ### Store Data
    if(year == min_year) {
      kenpom <- z
    }else {
      kenpom <- dplyr::bind_rows(kenpom, z)
    }
  }
  kenpom <- kenpom %>%
    janitor::clean_names()
  return(kenpom)
}


#' Get Player Stats Leaders by Metric
#'
#' @param metric Used to get leaders for different metrics. Available values are: \cr
#' 'ORtg', 'Min', 'eFG', 'Poss', Shots', 'OR', 'DR', 'TO', 'ARate', 'Blk', \cr
#' 'FTRate', 'Stl', 'TS', 'FC40', 'FD40', '2P', '3P', 'FT'. \cr
#' Default is 'eFG'. 'ORtg' returns a list of four dataframes, as there are four tables: \cr
#' players that used more than 28 percent of possessions, more than 24 percent of possessions, more than 20 percent of possessions, and with no possession restriction.
#' @param conf Used to limit to players in a specific conference. Allowed values are: 'A10', 'ACC', 'AE', 'AMER', \cr
#' 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', \cr
#' 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', \cr
#' 'SUM', 'SWAC', 'WAC', 'WCC'. \cr
#' If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', \cr
#' you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that.\cr
#' No filter applied by default.
#' @param conf_only Used to define whether stats should reflect conference games only.\cr
#' Only available if specific conference is defined. Only available for season after 2013, FALSE by default.
#' @param year Year of data to pull (earliest year of data available: 2004)
#'
#' @keywords Player
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate
#' @importFrom stringr str_remove str_replace str_trim
#' @export
#'
#' @examples
#' \dontrun{
#'  kp_playerstats(metric = 'eFG', conf_only = FALSE, year=2020)
#' }

kp_playerstats <- function(metric = 'eFG', conf = NULL, conf_only = FALSE, year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  m_list <- c('ORtg', 'Min', 'eFG', 'Poss', 'Shots', 'OR', 'DR', 'TO', 'ARate', 'Blk', 'FTRate', 'Stl',
                    'TS', 'FC40', 'FD40', '2P', '3P', 'FT')

  url_ext <- c('ORtg','PctMin', 'eFG', 'PctPoss','PctShots', 'ORPct', 'DRPct','TORate', 'ARate', 'PctBlocks', 'FTRate',
               'PctStls', 'TS',  'FCper40', 'FDper40', 'FG2Pct', 'FG3Pct', 'FTPct')

  metrics_data <- data.frame(m_list, url_ext)

  conf_list <- c('A10', 'ACC', 'AE', 'AMER', 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW',
                 'CAA', 'CUSA', 'HORZ', 'IND', 'IVY', 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC',
                 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', 'SUM', 'SWAC', 'WAC', 'WCC')

  metric_url <- metrics_data$url_ext[m_list == metric]

  assertthat::assert_that(year >= 2004, msg="Data only goes back to 2004")


  if(metric=="ORtg"){

    ### Pull Data
    url <- paste0("https://kenpom.com/playerstats.php?",
                  "y=", year,
                  "&s=", metric_url,
                  "&f=", conf,
                  "&c=", conf_only)

    page <- rvest::session_jump_to(browser, url)

    header_cols <- c("Rk","Player","Team", metric,
                     "Hgt","Wgt","Yr")
    y <- list()
    for(i in 1:4){

      groups <- c("At least 28% of possessions used", "At least 24% of possessions used",
                  "At least 20% of possessions used", "All players")

      x <- (page %>%
        xml2::read_html() %>%
        rvest::html_elements("table"))[[i]] %>%
        rvest::html_table()

      x <- x[,1:7]
      colnames(x) <- header_cols
      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$Wgt)))
      )

      x <- dplyr::mutate(x,
                         "Team" = sapply(.data$Team, function(arg) {
                           stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                         "Year" = year,
                         "Group" = groups[i]) %>%
        as.data.frame() %>%
        janitor::clean_names()
      y <- c(y,list(x))
    }
    ### Store Data

    kenpom <- y
  }else{

    ### Pull Data
    url <- paste0("https://kenpom.com/playerstats.php?",
                  "y=", year,
                  "&s=", metric_url,
                  "&f=", conf,
                  "&c=", conf_only)

    page <- rvest::session_jump_to(browser, url)

    header_cols <- c("Rk","Player","Team", metric,
                     "Hgt","Wgt","Yr")


    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#ratings-table'))[[1]] %>%
      rvest::html_table()

    x <- x[,1:7]
    colnames(x) <- header_cols
    suppressWarnings(
      x <- x %>%
        dplyr::filter(!is.na(as.numeric(.data$Wgt)))
    )
    x <- dplyr::mutate(x,
                       "Team" = sapply(.data$Team, function(arg) {
                         stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }),
                       "Year" = year)%>%
      as.data.frame()

    ### Store Data

    kenpom <- x %>%
      janitor::clean_names()
  }
  return(kenpom)
}

#' Get KPoY Leaders Tables
#'
#' @param year Year of data to pull (earliest year of data available: 2011)
#'
#' @keywords Leaders
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select filter mutate
#' @importFrom tidyr separate
#' @importFrom stringr str_extract str_match
#' @importFrom stringi stri_extract_first_regex stri_extract_last_regex
#' @export
#'
#' @examples
#' \dontrun{
#'  kp_kpoy(year=2020)
#' }
#'
kp_kpoy <- function(year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  assertthat::assert_that(year >= 2011, msg="Data only goes back to 2011")


  ### Pull Data
  url <- paste0("https://kenpom.com/kpoy.php?",
                "y=", year)

  page <- rvest::session_jump_to(browser, url)

  y <- list()
  for(i in 1:2){

    groups <- c("kPoY Rating", "Game MVP Leaders")

    x <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#kpoy-table'))[[i]] %>%
      rvest::html_table() %>%
      as.data.frame()

    if(i == 1){
      header_cols <- c("Rk","Player","kpoyRating")}
    else{
      header_cols <- c("Rk","Player","GameMVPs")
    }


    colnames(x) <- header_cols

    x <- x %>%
      tidyr::separate(.data$Player,
                      into = c("Player","col"),
                      sep = ",",
                      extra = "merge")

    x <- x %>%
      dplyr::mutate(
        Team = stringr::str_extract(
          stringr::str_extract(.data$col,'[^\\d-\\d{1,}]+'),".+"),
        Hgt = stringr::str_extract(
          stringi::stri_extract_first_regex(.data$col, '[^,]+'),"\\d{1,}-\\d{1,}+"),
        Wgt =
          stringr::str_extract(.data$col,'\\d{3}'),
        Exp = stringr::str_extract(.data$col, "Fr|So|Jr|Sr|r-Fr|r-So|r-Jr|r-Sr"),
        HomeTown = stringr::str_extract(
          stringi::stri_extract_last_regex(.data$col, '[^\u00b7]+'),".*")
      )
    suppressWarnings(
      if(i == 1){x <- x %>% dplyr::mutate_at(c("kpoyRating","Wgt"), as.numeric)
      }else{x <- x %>% dplyr::mutate_at(c("GameMVPs","Wgt"), as.numeric)}
    )
    x <- dplyr::mutate(x,
                       "Year" = year,
                       "Group" = groups[i]) %>%
      as.data.frame()
    x <- x %>%
      dplyr::select(-.data$col)

    if(i == 2) {
      replace_na_with_last <- function(x, p = is.na, d = 0){c(d, x)[cummax(seq_along(x)*(!p(x))) + 1]}
      x$Rk <- replace_na_with_last(x$Rk)
    }
    x <- x %>%
      janitor::clean_names()
    y <- c(y,list(x))
  }
  ### Store Data

  kenpom <- y

  return(kenpom)
}



