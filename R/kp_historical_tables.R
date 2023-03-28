#' **Get KenPom's team efficiency history**
#'
#'
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
#'   \item{\code{Off.eFG.Pct}}{double.}
#'   \item{\code{Off.TO.Pct}}{double.}
#'   \item{\code{Off.OR.Pct}}{double.}
#'   \item{\code{Off.FTRate}}{double.}
#'   \item{\code{Off.FG_2.Pct}}{double.}
#'   \item{\code{Off.FG_3.Pct}}{double.}
#'   \item{\code{Off.FT.Pct}}{double.}
#'   \item{\code{Off.FG_3A.Pct}}{double.}
#'   \item{\code{Off.A.Pct}}{double.}
#'   \item{\code{Off.APL}}{double.}
#'   \item{\code{Def.eFG.Pct}}{double.}
#'   \item{\code{Def.TO.Pct}}{double.}
#'   \item{\code{Def.OR.Pct}}{double.}
#'   \item{\code{Def.FTRate}}{double.}
#'   \item{\code{Def.FG_2.Pct}}{double.}
#'   \item{\code{Def.FG_3.Pct}}{double.}
#'   \item{\code{Def.Blk.Pct}}{double.}
#'   \item{\code{Def.FG_3A.Pct}}{double.}
#'   \item{\code{Def.A.Pct}}{double.}
#'   \item{\code{Def.AP}}{double.}
#'   \item{\code{Foul2Partic.Pct}}{double.}
#' }
#'
#' @keywords Team History
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate select mutate_at rename bind_cols bind_rows
#' @importFrom tidyr everything
#' @importFrom stringr str_remove str_replace str_extract regex
#' @import rvest
#' @export
#'
#' @examples
#'   \donttest{
#'     try(kp_team_history(team = 'Florida St.'))
#'   }
#'

kp_team_history <- function(team){

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      # Check teams parameter in teams list names
      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort( "Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == as.integer(format(Sys.Date(), "%Y")),]
      team_name = teams_links$team.link.ref[teams_links$Team == team]

      ### Pull Data
      url <- paste0("https://kenpom.com/history.php?",
                    "t=",team_name)

      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols <- c('Year','Team.Rk','Coach',	'Conf','WL',	'AdjT', 'AdjO',	'AdjD',
                      'Off.eFG.Pct',	'Off.TO.Pct',	'Off.OR.Pct','Off.FTRate',
                      'Off.FG_2.Pct',	'Off.FG_3.Pct',	'Off.FT.Pct',	'Off.FG_3A.Pct',
                      'Off.A.Pct',	'Off.APL',
                      'Def.eFG.Pct', 'Def.TO.Pct',	'Def.OR.Pct',	'Def.FTRate',
                      'Def.FG_2.Pct',	'Def.FG_3.Pct',
                      'Def.Blk.Pct',	'Def.FG_3A.Pct',	'Def.A.Pct',
                      'Def.APL',	'Foul2Partic.Pct')

      x <- (page %>%
             xml2::read_html() %>%
             rvest::html_elements(css = '#player-table'))[[1]]

      ## removing national rankings for easier manipulation
      ## TODO: Add these rankings back as columns
      conf <- (page %>%
                 xml2::read_html() %>%
                 rvest::html_elements(css = '#player-table'))[[1]]

      conf_record <- (page %>%
                        xml2::read_html() %>%
                        rvest::html_elements("td:nth-child(5) > span"))
      conf_record <- dplyr::bind_rows(lapply(rvest::html_text(conf_record),
                                             function(x){
                                               data.frame(x)
                                             }))
      conf_record <- conf_record %>%
        dplyr::rename("WL.Conf" = "x")
      tmrank <- conf %>%
        rvest::html_elements(".tmrank")

      # xml2::xml_remove(tmrank)

      conf <- conf %>% rvest::html_table()

      colnames(conf) <- header_cols

      x <- x %>% rvest::html_table()

      colnames(x) <- header_cols

      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$AdjT))) %>%
          dplyr::mutate_at(c('Year','Team.Rk','AdjT', 'AdjO',	'AdjD',
                             'Off.eFG.Pct',	'Off.TO.Pct',	'Off.OR.Pct','Off.FTRate',
                             'Off.FG_2.Pct',	'Off.FG_3.Pct',	'Off.FT.Pct',	'Off.FG_3A.Pct',
                             'Off.A.Pct',	'Off.APL',
                             'Def.eFG.Pct', 'Def.TO.Pct',	'Def.OR.Pct',	'Def.FTRate',
                             'Def.FG_2.Pct',	'Def.FG_3.Pct',
                             'Def.Blk.Pct',	'Def.FG_3A.Pct',	'Def.A.Pct',
                             'Def.APL',	'Foul2Partic.Pct'
                             # 'Off.eFG.Pct.Rk',	'Off.TO.Pct.Rk',	'Off.OR.Pct.Rk','Off.FTRate.Rk',
                             # 'Off.FG_2.Pct.Rk',	'Off.FG_3.Pct.Rk',	'Off.FT.Pct.Rk',	'Off.FG_3A.Pct.Rk',
                             # 'Off.A.Pct.Rk',	'Off.APL.Rk',
                             # 'Def.eFG.Pct.Rk', 'Def.TO.Pct.Rk',	'Def.OR.Pct.Rk',	'Def.FTRate.Rk',
                             # 'Def.FG_2.Pct.Rk',	'Def.FG_3.Pct.Rk',
                             # 'Def.Blk.Pct.Rk',	'Def.FG_3A.Pct.Rk',	'Def.A.Pct.Rk',
                             # 'Def.APL.Rk',	'Foul2Partic.Pct.Rk'
          ), as.numeric)
      )
      suppressWarnings(
        conf <- conf %>% dplyr::filter(!is.na(as.numeric(.data$AdjT)))
      )
      x <- x %>% dplyr::select(-"WL")
      x <- dplyr::bind_cols(x, WL = conf$WL, WL.Conf = conf_record$WL.Conf)
      x <- x %>%
        dplyr::filter(!is.na(.data$Year)) %>%
        dplyr::mutate(
          AdjT.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$AdjT, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          AdjO.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$AdjO, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          AdjD.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$AdjD, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.eFG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.eFG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.TO.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.TO.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.OR.Pct.Rk = stringr::str_replace(stringr::str_extract(.data$Off.OR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', ""),
          Off.FTRate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FTRate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FG_2.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FG_2.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FG_3.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FG_3.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FT.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FT.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FG_3A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FG_3A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.APL.Rk =  as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.APL, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.eFG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.eFG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.TO.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.TO.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.OR.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.OR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FTRate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FTRate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FG_2.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FG_2.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FG_3.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FG_3.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.Blk.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.Blk.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FG_3A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FG_3A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.APL.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.APL, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Foul2Partic.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Foul2Partic.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),

          AdjT = substr(sprintf("%.*f",2, as.numeric(.data$AdjT)), 1,
                        nchar(sprintf("%.*f",2, as.numeric(.data$AdjT))) - 1),
          AdjO = substr(sprintf("%.*f",2, as.numeric(.data$AdjO)), 1,
                        nchar(sprintf("%.*f",2, as.numeric(.data$AdjO))) - 1),
          AdjD = substr(sprintf("%.*f",2, as.numeric(.data$AdjD)), 1,
                        nchar(sprintf("%.*f",2, as.numeric(.data$AdjD))) - 1),
          Off.eFG.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.eFG.Pct)), 1,
                               nchar(sprintf("%.*f",2, as.numeric(.data$Off.eFG.Pct))) - 1),
          Off.TO.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.TO.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.TO.Pct))) - 1),
          Off.OR.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.OR.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.OR.Pct))) - 1),

          Off.FTRate = substr(sprintf("%.*f",2, as.numeric(.data$Off.FTRate)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.FTRate))) - 1),
          Off.FG_2.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FG_2.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Off.FG_2.Pct))) - 1),
          Off.FG_3.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FG_3.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Off.FG_3.Pct))) - 1),
          Off.FT.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FT.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.FT.Pct))) - 1),
          Off.FG_3A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FG_3A.Pct)), 1,
                                 nchar(sprintf("%.*f",2, as.numeric(.data$Off.FG_3A.Pct))) - 1),
          Off.A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.A.Pct)), 1,
                             nchar(sprintf("%.*f",2, as.numeric(.data$Off.A.Pct))) - 1),
          Off.APL = substr(sprintf("%.*f",2, as.numeric(.data$Off.APL)), 1,
                           nchar(sprintf("%.*f",2, as.numeric(.data$Off.APL))) - 1),

          Def.eFG.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.eFG.Pct)), 1,
                               nchar(sprintf("%.*f",2, as.numeric(.data$Def.eFG.Pct))) - 1),
          Def.TO.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.TO.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Def.TO.Pct))) - 1),
          Def.OR.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.OR.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Def.OR.Pct))) - 1),
          Def.FTRate = substr(sprintf("%.*f",2, as.numeric(.data$Def.FTRate)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Def.FTRate))) - 1),
          Def.FG_2.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.FG_2.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Def.FG_2.Pct))) - 1),
          Def.FG_3.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.FG_3.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Def.FG_3.Pct))) - 1),
          Def.Blk.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.Blk.Pct)), 1,
                               nchar(sprintf("%.*f",2, as.numeric(.data$Def.Blk.Pct))) - 1),

          Def.FG_3A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.FG_3A.Pct)), 1,
                                 nchar(sprintf("%.*f",2, as.numeric(.data$Def.FG_3A.Pct))) - 1),
          Def.A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.A.Pct)), 1,
                             nchar(sprintf("%.*f",2, as.numeric(.data$Def.A.Pct))) - 1),
          Def.APL = substr(sprintf("%.*f",2, as.numeric(.data$Def.APL)), 1,
                           nchar(sprintf("%.*f",2, as.numeric(.data$Def.APL))) - 1),
          Foul2Partic.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Foul2Partic.Pct)), 1,
                                   nchar(sprintf("%.*f",2, as.numeric(.data$Foul2Partic.Pct))) - 1),

          Team.Finish = stringr::str_extract(.data$Coach, stringr::regex("R1|R2|S16|E8|F4|2nd|CH",ignore_case = FALSE)),
          Coach = stringr::str_replace(.data$Coach, stringr::regex("R1|R2|S16|E8|F4|2nd|CH",ignore_case = FALSE),""),
          NCAA_Seed = NA_integer_)
      x <- dplyr::mutate(x,
                         "NCAA_Seed" = sapply(.data$Coach, function(arg) { as.numeric(gsub("[^0-9]", "", arg)) }),
                         "Coach" = sapply(.data$Coach, function(arg) {
                           stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\*+','')) }))
      x <- x %>%
        dplyr::mutate(Team = team_name) %>%
        dplyr::select(
          "Year",
          "Team.Rk",
          "Team",
          tidyr::everything())
      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team history data for {team} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's coaching resume data**
#'
#'
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
#'   \item{\code{Off.eFG.Pct}}{double.}
#'   \item{\code{Off.TO.Pct}}{double.}
#'   \item{\code{Off.OR.Pct}}{double.}
#'   \item{\code{Off.FTRate}}{double.}
#'   \item{\code{Off.FG_2.Pct}}{double.}
#'   \item{\code{Off.FG_3.Pct}}{double.}
#'   \item{\code{Off.FT.Pct}}{double.}
#'   \item{\code{Off.FG_3A.Pct}}{double.}
#'   \item{\code{Off.A.Pct}}{double.}
#'   \item{\code{Off.APL}}{double.}
#'   \item{\code{Def.eFG.Pct}}{double.}
#'   \item{\code{Def.TO.Pct}}{double.}
#'   \item{\code{Def.OR.Pct}}{double.}
#'   \item{\code{Def.FTRate}}{double.}
#'   \item{\code{Def.FG_2.Pct}}{double.}
#'   \item{\code{Def.FG_3.Pct}}{double.}
#'   \item{\code{Def.Blk.Pct}}{double.}
#'   \item{\code{Def.FG_3A.Pct}}{double.}
#'   \item{\code{Def.A.Pct}}{double.}
#'   \item{\code{Def.AP}}{double.}
#'   \item{\code{Foul2Partic.Pct}}{double.}
#' }
#'
#' @keywords Coach History
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate select mutate_at
#' @importFrom tidyr everything
#' @import rvest
#' @export
#'
#' @examples
#'   \donttest{
#'    try(kp_coach_history(coach = 'Leonard Hamilton'))
#'   }
#'
#'

kp_coach_history <- function(coach){
  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      coach_name <- gsub(" ","\\+",coach)

      ### Pull Data
      url <- paste0("https://kenpom.com/history.php?",
                    "c=",coach_name)

      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols<- c('Year','Team.Rk','Team',	'Conf','WL',	'AdjT', 'AdjO',	'AdjD',
                      'Off.eFG.Pct',	'Off.TO.Pct',	'Off.OR.Pct','Off.FTRate',
                      'Off.FG_2.Pct',	'Off.FG_3.Pct',	'Off.FT.Pct',	'Off.FG_3A.Pct',
                      'Off.A.Pct',	'Off.APL',
                      'Def.eFG.Pct', 'Def.TO.Pct',	'Def.OR.Pct',	'Def.FTRate',
                      'Def.FG_2.Pct',	'Def.FG_3.Pct',
                      'Def.Blk.Pct',	'Def.FG_3A.Pct',	'Def.A.Pct',
                      'Def.APL',	'Foul2Partic.Pct')

      x<- (page %>%
             xml2::read_html() %>%
             rvest::html_elements(css='#player-table'))[[1]]

      ## removing national rankings for easier manipulation
      ## TODO: Add these rankings back as columns
      conf <- (page %>%
                 xml2::read_html() %>%
                 rvest::html_elements(css='#player-table'))[[1]]

      conf_record <- (page %>%
                        xml2::read_html() %>%
                        rvest::html_elements("td:nth-child(5) > span"))
      conf_record_wl <- dplyr::bind_rows(lapply(rvest::html_text(conf_record),
                                             function(x){
                                               data.frame(x, stringsAsFactors=FALSE)
                                             }))
      conf_record_wl <- conf_record_wl %>%
        dplyr::rename("WL.Conf" = "x")
      tmrank <- conf %>%
        rvest::html_elements(".tmrank")
      xml2::xml_remove(conf_record)
      conf <- conf %>%
        rvest::html_table()

      colnames(conf) <- header_cols

      x <- x %>%
        rvest::html_table()

      colnames(x) <- header_cols

      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$AdjT))) %>%
          dplyr::mutate_at(c('Year','Team.Rk','AdjT', 'AdjO',	'AdjD',
                             'Off.eFG.Pct',	'Off.TO.Pct',	'Off.OR.Pct','Off.FTRate',
                             'Off.FG_2.Pct',	'Off.FG_3.Pct',	'Off.FT.Pct',	'Off.FG_3A.Pct',
                             'Off.A.Pct',	'Off.APL',
                             'Def.eFG.Pct', 'Def.TO.Pct',	'Def.OR.Pct',	'Def.FTRate',
                             'Def.FG_2.Pct',	'Def.FG_3.Pct',
                             'Def.Blk.Pct',	'Def.FG_3A.Pct',	'Def.A.Pct',
                             'Def.APL',	'Foul2Partic.Pct'
                             # 'Off.eFG.Pct.Rk',	'Off.TO.Pct.Rk',	'Off.OR.Pct.Rk','Off.FTRate.Rk',
                             # 'Off.FG_2.Pct.Rk',	'Off.FG_3.Pct.Rk',	'Off.FT.Pct.Rk',	'Off.FG_3A.Pct.Rk',
                             # 'Off.A.Pct.Rk',	'Off.APL.Rk',
                             # 'Def.eFG.Pct.Rk', 'Def.TO.Pct.Rk',	'Def.OR.Pct.Rk',	'Def.FTRate.Rk',
                             # 'Def.FG_2.Pct.Rk',	'Def.FG_3.Pct.Rk',
                             # 'Def.Blk.Pct.Rk',	'Def.FG_3A.Pct.Rk',	'Def.A.Pct.Rk',
                             # 'Def.APL.Rk',	'Foul2Partic.Pct.Rk'
          ), as.numeric)
      )
      suppressWarnings(
        conf <- conf %>% dplyr::filter(!is.na(as.numeric(.data$AdjT)))
      )

      x <- dplyr::bind_cols(x %>% dplyr::select(-"WL"), WL = conf$WL,  WL.Conf = conf_record_wl$WL.Conf)
      x <- x %>%
        dplyr::filter(!is.na(.data$Year)) %>%
        dplyr::mutate(
          AdjT.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$AdjT, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          AdjO.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$AdjO, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          AdjD.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$AdjD, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.eFG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.eFG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.TO.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.TO.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.OR.Pct.Rk = stringr::str_replace(stringr::str_extract(.data$Off.OR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', ""),
          Off.FTRate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FTRate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FG_2.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FG_2.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FG_3.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FG_3.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FT.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FT.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.FG_3A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.FG_3A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Off.APL.Rk =  as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.APL, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.eFG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.eFG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.TO.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.TO.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.OR.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.OR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FTRate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FTRate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FG_2.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FG_2.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FG_3.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FG_3.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.Blk.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.Blk.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.FG_3A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.FG_3A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.A.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.A.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Def.APL.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Def.APL, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
          Foul2Partic.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Foul2Partic.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),

          AdjT = substr(sprintf("%.*f",2, as.numeric(.data$AdjT)), 1,
                        nchar(sprintf("%.*f",2, as.numeric(.data$AdjT))) - 1),
          AdjO = substr(sprintf("%.*f",2, as.numeric(.data$AdjO)), 1,
                        nchar(sprintf("%.*f",2, as.numeric(.data$AdjO))) - 1),
          AdjD = substr(sprintf("%.*f",2, as.numeric(.data$AdjD)), 1,
                        nchar(sprintf("%.*f",2, as.numeric(.data$AdjD))) - 1),
          Off.eFG.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.eFG.Pct)), 1,
                               nchar(sprintf("%.*f",2, as.numeric(.data$Off.eFG.Pct))) - 1),
          Off.TO.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.TO.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.TO.Pct))) - 1),
          Off.OR.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.OR.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.OR.Pct))) - 1),

          Off.FTRate = substr(sprintf("%.*f",2, as.numeric(.data$Off.FTRate)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.FTRate))) - 1),
          Off.FG_2.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FG_2.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Off.FG_2.Pct))) - 1),
          Off.FG_3.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FG_3.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Off.FG_3.Pct))) - 1),
          Off.FT.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FT.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Off.FT.Pct))) - 1),
          Off.FG_3A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.FG_3A.Pct)), 1,
                                 nchar(sprintf("%.*f",2, as.numeric(.data$Off.FG_3A.Pct))) - 1),
          Off.A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Off.A.Pct)), 1,
                             nchar(sprintf("%.*f",2, as.numeric(.data$Off.A.Pct))) - 1),
          Off.APL = substr(sprintf("%.*f",2, as.numeric(.data$Off.APL)), 1,
                           nchar(sprintf("%.*f",2, as.numeric(.data$Off.APL))) - 1),

          Def.eFG.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.eFG.Pct)), 1,
                               nchar(sprintf("%.*f",2, as.numeric(.data$Def.eFG.Pct))) - 1),
          Def.TO.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.TO.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Def.TO.Pct))) - 1),
          Def.OR.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.OR.Pct)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Def.OR.Pct))) - 1),
          Def.FTRate = substr(sprintf("%.*f",2, as.numeric(.data$Def.FTRate)), 1,
                              nchar(sprintf("%.*f",2, as.numeric(.data$Def.FTRate))) - 1),
          Def.FG_2.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.FG_2.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Def.FG_2.Pct))) - 1),
          Def.FG_3.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.FG_3.Pct)), 1,
                                nchar(sprintf("%.*f",2, as.numeric(.data$Def.FG_3.Pct))) - 1),
          Def.Blk.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.Blk.Pct)), 1,
                               nchar(sprintf("%.*f",2, as.numeric(.data$Def.Blk.Pct))) - 1),

          Def.FG_3A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.FG_3A.Pct)), 1,
                                 nchar(sprintf("%.*f",2, as.numeric(.data$Def.FG_3A.Pct))) - 1),
          Def.A.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Def.A.Pct)), 1,
                             nchar(sprintf("%.*f",2, as.numeric(.data$Def.A.Pct))) - 1),
          Def.APL = substr(sprintf("%.*f",2, as.numeric(.data$Def.APL)), 1,
                           nchar(sprintf("%.*f",2, as.numeric(.data$Def.APL))) - 1),
          Foul2Partic.Pct = substr(sprintf("%.*f",2, as.numeric(.data$Foul2Partic.Pct)), 1,
                                   nchar(sprintf("%.*f",2, as.numeric(.data$Foul2Partic.Pct))) - 1),

          Team.Finish = stringr::str_extract(.data$Team, stringr::regex("R1|R2|S16|E8|F4|2nd|CH",ignore_case = FALSE)),
          Team = stringr::str_replace(.data$Team, stringr::regex("R1|R2|S16|E8|F4|2nd|CH",ignore_case = FALSE),""),
          NCAA_Seed = NA_integer_)
      suppressWarnings(
        x <- x %>%
          dplyr::filter(!is.na(as.numeric(.data$AdjT))) %>%
          dplyr::mutate_at(c('Off.eFG.Pct.Rk',	'Off.TO.Pct.Rk',	'Off.OR.Pct.Rk','Off.FTRate.Rk',
                             'Off.FG_2.Pct.Rk',	'Off.FG_3.Pct.Rk',	'Off.FT.Pct.Rk',	'Off.FG_3A.Pct.Rk',
                             'Off.A.Pct.Rk',	'Off.APL.Rk',
                             'Def.eFG.Pct.Rk', 'Def.TO.Pct.Rk',	'Def.OR.Pct.Rk',	'Def.FTRate.Rk',
                             'Def.FG_2.Pct.Rk',	'Def.FG_3.Pct.Rk',
                             'Def.Blk.Pct.Rk',	'Def.FG_3A.Pct.Rk',	'Def.A.Pct.Rk',
                             'Def.APL.Rk',	'Foul2Partic.Pct.Rk'
          ), as.numeric)
      )
      x <- dplyr::mutate(x,
                         "NCAA_Seed" = as.numeric(gsub("[^0-9]", "", .data$Team)),
                         "Team" = stringr::str_trim(stringr::str_replace(stringr::str_remove(.data$Team,'\\d+| \\*| \\*+'),'\\*+','')))

      x <- x %>%
        dplyr::mutate(Coach = coach) %>%
        dplyr::select(
          "Year",
          "Team.Rk",
          "Team",
          "Coach",
          tidyr::everything())
      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()


    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no coach history data for {coach} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's program ratings**
#'
#'
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
#' @importFrom cli cli_abort
#' @importFrom dplyr filter
#' @import rvest
#' @export
#' @examples
#' \donttest{
#'   try(kp_program_ratings())
#' }

kp_program_ratings <- function(){

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()

      ### Pull Data
      url <- "https://kenpom.com/programs.php?"

      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      header_cols<- c('Rk',	'Team',	'Conf','Rtg',
                      'Best.Rk','Best.Yr',
                      'Worst.Rk','Worst.Yr', 'KP.Median',
                      'Top10',	'Top25',	'Top50',	'CH',
                      'F4',	'S16',	'R1',	'Chg')

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements(css='#ratings-table'))[[1]]

      x <- x %>%
        rvest::html_table() %>%
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
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no program ratings available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's ratings archive pages**
#'
#'
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
#' @importFrom dplyr filter mutate
#' @importFrom stringr str_remove str_remove str_trim
#' @import rvest
#' @export
#' @examples
#' \donttest{
#'   try(kp_pomeroy_archive_ratings(date='2018-11-22'))
#' }
kp_pomeroy_archive_ratings <- function(date){

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      header_cols <- c('AdjEM.Rk', 'Team', 'Conf', 'AdjEM',
                       'AdjO', 'AdjO.Rk', 'AdjD', 'AdjD.Rk', 'AdjT', 'AdjT.Rk',
                       'Final.Rk',	'Final.AdjEM', 'Final.AdjO', 'Final.AdjO.Rk',
                       'Final.AdjD', 'Final.AdjD.Rk',	'Final.AdjT', 'Final.AdjT.Rk',
                       'Rk.Chg',	'EM.Chg',	'AdjT.Chg')


      ### Pull Data
      url <- paste0("https://kenpom.com/archive.php?d=", date)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)

      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements("table"))[[1]] %>%
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


      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no kp_pomeroy_archive_ratings data for {date} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's conference-wide stats**
#'
#'
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
#'   \item{\code{eFG.Pct}}{double.}
#'   \item{\code{eFG.Pct.Rk}}{double.}
#'   \item{\code{TO.Pct}}{double.}
#'   \item{\code{TO.Pct.Rk}}{double.}
#'   \item{\code{OR.Pct}}{double.}
#'   \item{\code{OR.Pct.Rk}}{double.}
#'   \item{\code{FTR}}{double.}
#'   \item{\code{FTR.Rk}}{double.}
#'   \item{\code{FG2.Pct}}{double.}
#'   \item{\code{FG2.Pct.Rk}}{double.}
#'   \item{\code{FG3.Pct}}{double.}
#'   \item{\code{FG3.Pct.Rk}}{double.}
#'   \item{\code{FT.Pct}}{double.}
#'   \item{\code{FT.Pct.Rk}}{double.}
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
#'   \item{\code{eFG.Pct}}{double.}
#'   \item{\code{eFG.Pct.Rk}}{double.}
#'   \item{\code{TO.Pct}}{double.}
#'   \item{\code{TO.Pct.Rk}}{double.}
#'   \item{\code{OR.Pct}}{double.}
#'   \item{\code{OR.Pct.Rk}}{double.}
#'   \item{\code{FTR}}{double.}
#'   \item{\code{FTR.Rk}}{double.}
#'   \item{\code{FG2.Pct}}{double.}
#'   \item{\code{FG2.Pct.Rk}}{double.}
#'   \item{\code{FG3.Pct}}{double.}
#'   \item{\code{FG3.Pct.Rk}}{double.}
#'   \item{\code{Blk.Pct}}{double.}
#'   \item{\code{Blk.Pct.Rk}}{double.}
#'   \item{\code{Stl.Pct}}{double.}
#'   \item{\code{Stl.Pct.Rk}}{double.}
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
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate
#' @import rvest
#' @export
#' @examples
#' \donttest{
#'     try(kp_conf(year = 2020, conf = 'ACC'))
#' }

kp_conf <- function(year, conf){

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      header_cols <- c('Team',	'Overall',	'Conf','AdjEM','AdjEM.Rk',
                       'AdjO','AdjO.Rk',	'AdjD','AdjD.Rk',	'AdjT','AdjT.Rk',
                       'ConfSOS','ConfSOS.Rk','NextGame')
      header_cols2<- c('Team',	'OE','OE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                       'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                       'FG_3.Pct', 'FG_3.Pct.Rk', 'FT.Pct','FT.Pct.Rk','Tempo','Tempo.Rk')
      header_cols3<- c('Team',	'DE','DE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                       'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                       'FG_3.Pct', 'FG_3.Pct.Rk', 'Blk.Pct','Blk.Pct.Rk','Stl.Pct','Stl.Pct.Rk')
      header_cols4<- c('Rk','Player')
      header_cols5<- c('Stat','Value','Rk')
      header_cols6<- c('Stat','Count','Value','Rk')
      header_cols7<- c('Rk','Conference','Rating','Rk2','Conference2','Rating2')



      # Check conf parameter in teams_list$Conf names
      if(!(conf %in% hoopR::teams_links$Conf)){
        cli::cli_abort("Incorrect conference name as compared to the website, see hoopR::teams_links for conference name parameter specifications.")
      }

      conf_name = unique(hoopR::teams_links$conf.link.ref[hoopR::teams_links$Conf == conf])

      ### Pull Data
      url <- paste0("https://kenpom.com/conf.php?",
                    "c=", conf_name,
                    "&y=", year)

      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      y <- list()
      for(i in 1:7){

        x <- (page %>%
                xml2::read_html() %>%
                rvest::html_elements('table'))[[i]] %>%
          rvest::html_table() %>%
          as.data.frame()

        if(i == 1){
          x<-x[1:(length(x)-2)]
          if(length(colnames(x)) == length(header_cols)){
            colnames(x) <- header_cols
          }else{
            colnames(x) <- header_cols[-length(header_cols)]
          }
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
                c('OE','OE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                  'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                  'FG_3.Pct', 'FG_3.Pct.Rk', 'FT.Pct','FT.Pct.Rk','Tempo','Tempo.Rk'),
                as.numeric
              )
          )
        }else if(i == 3){
          colnames(x) <- header_cols3
          suppressWarnings(
            x <- x %>%
              dplyr::mutate_at(
                c('DE','DE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                  'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                  'FG_3.Pct', 'FG_3.Pct.Rk', 'Blk.Pct','Blk.Pct.Rk','Stl.Pct','Stl.Pct.Rk'),
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
        x <- x %>%
          janitor::clean_names()
        y <- c(y, list(x))
      }

      kenpom <- y

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no conference data for {year} {conf} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}


#' **Get KenPom's conference comparison stats**
#'
#'
#' @param year Year (YYYY)
#'
#' @return A data frame with 35 columns:
#' \itemize{
#'   \item{\code{Conf}}{character.}
#'   \item{\code{Eff}}{double.}
#'   \item{\code{Eff.Rk}}{double.}
#'   \item{\code{Tempo}}{double.}
#'   \item{\code{Tempo.Rk}}{double.}
#'   \item{\code{eFG.Pct}}{double.}
#'   \item{\code{eFG.Pct.Rk}}{double.}
#'   \item{\code{TO.Pct}}{double.}
#'   \item{\code{TO.Pct.Rk}}{double.}
#'   \item{\code{OR.Pct}}{double.}
#'   \item{\code{OR.Pct.Rk}}{double.}
#'   \item{\code{FTRate}}{double.}
#'   \item{\code{FTRate.Rk}}{double.}
#'   \item{\code{Blk.Pct}}{double.}
#'   \item{\code{Blk.Pct.Rk}}{double.}
#'   \item{\code{Stl.Pct}}{double.}
#'   \item{\code{Stl.Pct.Rk}}{double.}
#'   \item{\code{FG_2.Pct}}{double.}
#'   \item{\code{FG_2.Pct.Rk}}{double.}
#'   \item{\code{FG_3.Pct}}{double.}
#'   \item{\code{FG_3.Pct.Rk}}{double.}
#'   \item{\code{FT.Pct}}{double.}
#'   \item{\code{FT.Pct.Rk}}{double.}
#'   \item{\code{FG_3A.Pct}}{double.}
#'   \item{\code{FG_3A.Pct.Rk}}{double.}
#'   \item{\code{A.Pct}}{double.}
#'   \item{\code{A.Pct.Rk}}{double.}
#'   \item{\code{HomeWL}}{character.}
#'   \item{\code{HomeWL.Pct}}{double.}
#'   \item{\code{HomeWL.Rk}}{double.}
#'   \item{\code{Close}}{double.}
#'   \item{\code{Close.Rk}}{double.}
#'   \item{\code{Blowouts}}{double.}
#'   \item{\code{Blowouts.Rk}}{double.}
#'   \item{\code{Year}}{character.}
#' }
#'
#' @keywords Conference Comparison
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate filter mutate_at
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(kp_confstats(year=most_recent_mbb_season()))
#' }

kp_confstats <- function(year = most_recent_mbb_season()){

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      header_cols <- c('Conf', 'Eff','Eff.Rk','Tempo','Tempo.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                       'OR.Pct','OR.Pct.Rk','FTRate',	'FTRate.Rk', 'Blk.Pct', 'Blk.Pct.Rk', 'Stl.Pct', 'Stl.Pct.Rk',
                       'FG_2.Pct', 'FG_2.Pct.Rk',	'FG_3.Pct', 'FG_3.Pct.Rk',	'FT.Pct', 'FT.Pct.Rk',
                       'FG_3A.Pct', 'FG_3A.Pct.Rk', 'A.Pct', 'A.Pct.Rk',
                       'HomeW-L','HomeW-L.Pct', 'HomeW-L.Rk',	'Close', 'Close.Rk', 'Blowouts', 'Blowouts.Rk')


      ### Pull Data
      url <- paste0("https://kenpom.com/confstats.php?y=", year)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      x <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements(css="#confrank-table"))[[1]] %>%
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
          dplyr::mutate_at(c('Eff','Eff.Rk','Tempo','Tempo.Rk','eFG.Pct',
                             'eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                             'OR.Pct','OR.Pct.Rk','FTRate',	'FTRate.Rk',
                             'Blk.Pct', 'Blk.Pct.Rk', 'Stl.Pct', 'Stl.Pct.Rk',
                             'FG_2.Pct', 'FG_2.Pct.Rk',	'FG_3.Pct', 'FG_3.Pct.Rk',
                             'FT.Pct', 'FT.Pct.Rk', 'FG_3A.Pct', 'FG_3A.Pct.Rk',
                             'A.Pct', 'A.Pct.Rk', 'HomeW-L.Pct', 'HomeW-L.Rk',
                             'Close', 'Close.Rk', 'Blowouts', 'Blowouts.Rk'),
                           as.numeric)
      )
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no conference stats data for {year} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's historical conference ratings**
#'
#'
#' @param conf Used to limit to players in a specific conference.
#'
#' Allowed values are:
#' 'A10', 'ACC', 'AE', 'AMER',
#' 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH',
#' 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY',
#' 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC',
#' 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND',
#' 'SUM', 'SWAC', 'WAC', 'WCC'.
#'
#' If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018',
#' you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that.
#' No filter applied by default.
#'
#' @return A data frame with 23 columns:
#'   - `Year`- *integer*
#'   - `Rank`- *character*
#'   - `Tempo`- *double*
#'   - `Efficiency`- *double*
#'   - `eFG.Pct`- *double*
#'   - `TO.Pct`- *double*
#'   - `OR.Pct`- *double*
#'   - `FTR`- *double*
#'   - `FG2.Pct`- *double*
#'   - `FG3.Pct`- *double*
#'   - `FT.Pct`- *double*
#'   - `FG3A.Pct`- *double*
#'   - `A.Pct`- *double*
#'   - `Blk.Pct`- *double*
#'   - `Stl.Pct`- *double*
#'   - `HomeRecord`- *character*
#'   - `Bids`- *character*
#'   - `S16`- *character*
#'   - `F4`- *character*
#'   - `CH`- *character*
#'   - `RegSeasonChamp`- *character*
#'   - `TourneyChamp`- *character*
#'   - `BestTeam`- *character*
#'
#' @keywords Conference History
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate_at
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'  try(kp_confhistory(conf = 'ACC'))
#' }

kp_confhistory <- function(conf){

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      header_cols <- c('Year',	'Rank',	'Tempo',	'Efficiency',
                       'eFG.Pct',	'TO.Pct',	'OR.Pct','FTRate',	'FG_2.Pct',	'FG_3.Pct',
                       'FT.Pct',	'FG_3A.Pct', 'A.Pct', 'Blk.Pct',	'Stl.Pct',
                       'HomeRecord', 'Bids',	'S16',	'F4',	'CH',
                       'RegSeasonChamp', 'TourneyChamp',	'BestTeam')



      # Check conf parameter in teams_list$Conf names
      if(!(conf %in% hoopR::teams_links$Conf)){
        cli::cli_abort("Incorrect conference name as compared to the website, see hoopR::teams_links for conference name parameter specifications.")
      }
      conf_name = unique(hoopR::teams_links$conf.link.ref[hoopR::teams_links$Conf == conf])

      ### Pull Data
      url <- paste0("https://kenpom.com/confhistory.php?",
                    "c=", conf_name)
      page <- rvest::session_jump_to(browser, url)
      Sys.sleep(5)
      x <- page %>%
        xml2::read_html() %>%
        rvest::html_elements(css="#player-table")

      ## removing national rankings for easier manipulation
      ## TO-DO: Add these rankings back as columns
      tmrank <- x %>%
        rvest::html_elements(".tmrank")
      xml2::xml_remove(tmrank)

      x <- x %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(x) <- header_cols
      suppressWarnings(
        x <- x %>%
          dplyr::mutate_at(c('Tempo',	'Efficiency',
                             'eFG.Pct',	'TO.Pct',	'OR.Pct','FTRate',	'FG_2.Pct',	'FG_3.Pct',
                             'FT.Pct',	'FG_3A.Pct', 'A.Pct', 'Blk.Pct',	'Stl.Pct'),
                           as.numeric)
      )
      kenpom <- x %>%
        janitor::clean_names()
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no conference history data for {conf} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

