#' **Get KenPom's team efficiency history**
#'
#'
#' @param team Team filter to select.
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       team_rk \tab numeric \tab Team rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       coach \tab character \tab Coach. \cr
#'       conf \tab character \tab character. \cr
#'       adj_t \tab numeric \tab Adj t. \cr
#'       adj_o \tab numeric \tab Adj o. \cr
#'       adj_d \tab numeric \tab Adj d. \cr
#'       off_e_fg_pct \tab numeric \tab Off e field goals percentage (0-1 decimal). \cr
#'       off_to_pct \tab numeric \tab Off to percentage (0-1 decimal). \cr
#'       off_or_pct \tab numeric \tab Off or percentage (0-1 decimal). \cr
#'       off_ft_rate \tab numeric \tab Off ft rate. \cr
#'       off_fg_2_pct \tab numeric \tab Off field goals 2 percentage (0-1 decimal). \cr
#'       off_fg_3_pct \tab numeric \tab Off field goals 3 percentage (0-1 decimal). \cr
#'       off_ft_pct \tab numeric \tab Off free throws percentage (0-1 decimal). \cr
#'       off_fg_3a_pct \tab numeric \tab Off field goals 3a percentage (0-1 decimal). \cr
#'       off_a_pct \tab numeric \tab Off a percentage (0-1 decimal). \cr
#'       off_apl \tab numeric \tab Off apl. \cr
#'       def_e_fg_pct \tab numeric \tab Def e field goals percentage (0-1 decimal). \cr
#'       def_to_pct \tab numeric \tab Def to percentage (0-1 decimal). \cr
#'       def_or_pct \tab numeric \tab Def or percentage (0-1 decimal). \cr
#'       def_ft_rate \tab numeric \tab Def ft rate. \cr
#'       def_fg_2_pct \tab numeric \tab Def field goals 2 percentage (0-1 decimal). \cr
#'       def_fg_3_pct \tab numeric \tab Def field goals 3 percentage (0-1 decimal). \cr
#'       def_blk_pct \tab numeric \tab Def blocks percentage (0-1 decimal). \cr
#'       def_fg_3a_pct \tab numeric \tab Def field goals 3a percentage (0-1 decimal). \cr
#'       def_a_pct \tab numeric \tab Def a percentage (0-1 decimal). \cr
#'       def_apl \tab numeric \tab Def apl. \cr
#'       foul2partic_pct \tab numeric \tab Foul2partic percentage (0-1 decimal). \cr
#'       wl \tab character \tab Wl. \cr
#'       wl_conf \tab character \tab Wl conf. \cr
#'       adj_t_rk \tab numeric \tab Adj t rk. \cr
#'       adj_o_rk \tab numeric \tab Adj o rk. \cr
#'       adj_d_rk \tab numeric \tab Adj d rk. \cr
#'       off_e_fg_pct_rk \tab numeric \tab Off e fg pct rk. \cr
#'       off_to_pct_rk \tab numeric \tab Off to pct rk. \cr
#'       off_or_pct_rk \tab numeric \tab Off or pct rk. \cr
#'       off_ft_rate_rk \tab numeric \tab Off ft rate rk. \cr
#'       off_fg_2_pct_rk \tab numeric \tab Off fg 2 pct rk. \cr
#'       off_fg_3_pct_rk \tab numeric \tab Off fg 3 pct rk. \cr
#'       off_ft_pct_rk \tab numeric \tab Off ft pct rk. \cr
#'       off_fg_3a_pct_rk \tab numeric \tab Off fg 3a pct rk. \cr
#'       off_a_pct_rk \tab numeric \tab Off a pct rk. \cr
#'       off_apl_rk \tab numeric \tab Off apl rk. \cr
#'       def_e_fg_pct_rk \tab numeric \tab Def e fg pct rk. \cr
#'       def_to_pct_rk \tab numeric \tab Def to pct rk. \cr
#'       def_or_pct_rk \tab numeric \tab Def or pct rk. \cr
#'       def_ft_rate_rk \tab numeric \tab Def ft rate rk. \cr
#'       def_fg_2_pct_rk \tab numeric \tab Def fg 2 pct rk. \cr
#'       def_fg_3_pct_rk \tab numeric \tab Def fg 3 pct rk. \cr
#'       def_blk_pct_rk \tab numeric \tab Def blk pct rk. \cr
#'       def_fg_3a_pct_rk \tab numeric \tab Def fg 3a pct rk. \cr
#'       def_a_pct_rk \tab numeric \tab Def a pct rk. \cr
#'       def_apl_rk \tab numeric \tab Def apl rk. \cr
#'       foul2partic_pct_rk \tab numeric \tab Foul2partic pct rk. \cr
#'       team_finish \tab character \tab Team finish. \cr
#'       ncaa_seed \tab numeric \tab Ncaa seed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords Team History
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate select mutate_at rename bind_cols bind_rows
#' @importFrom tidyr everything
#' @importFrom stringr str_remove str_replace str_extract regex
#' @import rvest
#' @export
#' @keywords Team History
#' @family KenPom Historical Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_team_history(team = 'Florida St.'))
#'   }
#'

kp_team_history <- function(team){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

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

      page <- .kp_get_page(browser, url)
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
              rvest::html_elements("table#player-table"))[[1]]

      ## removing national rankings for easier manipulation
      ## TODO: Add these rankings back as columns
      conf <- (page %>%
                 rvest::html_elements(css = '#player-table'))[[1]]

      conf_record <- (page %>%
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
          Off.OR.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Off.OR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
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
        dplyr::mutate(Team = team) %>%
        dplyr::select(
          "Year",
          "Team.Rk",
          "Team",
          tidyr::everything())



      suppressWarnings(
        x <- x %>%
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

      ### Store Data
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team history data for {team} available!",
      args = .args
    ),
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
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       team_rk \tab numeric \tab Team rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       coach \tab character \tab Coach. \cr
#'       conf \tab character \tab character. \cr
#'       adj_t \tab character \tab Adj t. \cr
#'       adj_o \tab character \tab Adj o. \cr
#'       adj_d \tab character \tab Adj d. \cr
#'       off_e_fg_pct \tab character \tab Off e field goals percentage (0-1 decimal). \cr
#'       off_to_pct \tab character \tab Off to percentage (0-1 decimal). \cr
#'       off_or_pct \tab character \tab Off or percentage (0-1 decimal). \cr
#'       off_ft_rate \tab character \tab Off ft rate. \cr
#'       off_fg_2_pct \tab character \tab Off field goals 2 percentage (0-1 decimal). \cr
#'       off_fg_3_pct \tab character \tab Off field goals 3 percentage (0-1 decimal). \cr
#'       off_ft_pct \tab character \tab Off free throws percentage (0-1 decimal). \cr
#'       off_fg_3a_pct \tab character \tab Off field goals 3a percentage (0-1 decimal). \cr
#'       off_a_pct \tab character \tab Off a percentage (0-1 decimal). \cr
#'       off_apl \tab character \tab Off apl. \cr
#'       def_e_fg_pct \tab character \tab Def e field goals percentage (0-1 decimal). \cr
#'       def_to_pct \tab character \tab Def to percentage (0-1 decimal). \cr
#'       def_or_pct \tab character \tab Def or percentage (0-1 decimal). \cr
#'       def_ft_rate \tab character \tab Def ft rate. \cr
#'       def_fg_2_pct \tab character \tab Def field goals 2 percentage (0-1 decimal). \cr
#'       def_fg_3_pct \tab character \tab Def field goals 3 percentage (0-1 decimal). \cr
#'       def_blk_pct \tab character \tab Def blocks percentage (0-1 decimal). \cr
#'       def_fg_3a_pct \tab character \tab Def field goals 3a percentage (0-1 decimal). \cr
#'       def_a_pct \tab character \tab Def a percentage (0-1 decimal). \cr
#'       def_apl \tab character \tab Def apl. \cr
#'       foul2partic_pct \tab character \tab Foul2partic percentage (0-1 decimal). \cr
#'       wl \tab character \tab Wl. \cr
#'       wl_conf \tab character \tab Wl conf. \cr
#'       adj_t_rk \tab numeric \tab Adj t rk. \cr
#'       adj_o_rk \tab numeric \tab Adj o rk. \cr
#'       adj_d_rk \tab numeric \tab Adj d rk. \cr
#'       off_e_fg_pct_rk \tab numeric \tab Off e fg pct rk. \cr
#'       off_to_pct_rk \tab numeric \tab Off to pct rk. \cr
#'       off_or_pct_rk \tab numeric \tab Off or pct rk. \cr
#'       off_ft_rate_rk \tab numeric \tab Off ft rate rk. \cr
#'       off_fg_2_pct_rk \tab numeric \tab Off fg 2 pct rk. \cr
#'       off_fg_3_pct_rk \tab numeric \tab Off fg 3 pct rk. \cr
#'       off_ft_pct_rk \tab numeric \tab Off ft pct rk. \cr
#'       off_fg_3a_pct_rk \tab numeric \tab Off fg 3a pct rk. \cr
#'       off_a_pct_rk \tab numeric \tab Off a pct rk. \cr
#'       off_apl_rk \tab numeric \tab Off apl rk. \cr
#'       def_e_fg_pct_rk \tab numeric \tab Def e fg pct rk. \cr
#'       def_to_pct_rk \tab numeric \tab Def to pct rk. \cr
#'       def_or_pct_rk \tab numeric \tab Def or pct rk. \cr
#'       def_ft_rate_rk \tab numeric \tab Def ft rate rk. \cr
#'       def_fg_2_pct_rk \tab numeric \tab Def fg 2 pct rk. \cr
#'       def_fg_3_pct_rk \tab numeric \tab Def fg 3 pct rk. \cr
#'       def_blk_pct_rk \tab numeric \tab Def blk pct rk. \cr
#'       def_fg_3a_pct_rk \tab numeric \tab Def fg 3a pct rk. \cr
#'       def_a_pct_rk \tab numeric \tab Def a pct rk. \cr
#'       def_apl_rk \tab numeric \tab Def apl rk. \cr
#'       foul2partic_pct_rk \tab numeric \tab Foul2partic pct rk. \cr
#'       team_finish \tab character \tab Team finish. \cr
#'       ncaa_seed \tab numeric \tab Ncaa seed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate select mutate_at
#' @importFrom tidyr everything
#' @import rvest
#' @export
#' @keywords Coach History
#' @family KenPom Historical Functions
#'
#' @examples
#'   \donttest{
#'    try(kp_coach_history(coach = 'Leonard Hamilton'))
#'   }
#'
#'

kp_coach_history <- function(coach){
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()
      coach_name <- gsub(" ","\\+",coach)

      ### Pull Data
      url <- paste0("https://kenpom.com/history.php?",
                    "c=",coach_name)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c('Year','Team.Rk','Team',	'Conf','WL',	'AdjT', 'AdjO',	'AdjD',
                       'Off.eFG.Pct',	'Off.TO.Pct',	'Off.OR.Pct','Off.FTRate',
                       'Off.FG_2.Pct',	'Off.FG_3.Pct',	'Off.FT.Pct',	'Off.FG_3A.Pct',
                       'Off.A.Pct',	'Off.APL',
                       'Def.eFG.Pct', 'Def.TO.Pct',	'Def.OR.Pct',	'Def.FTRate',
                       'Def.FG_2.Pct',	'Def.FG_3.Pct',
                       'Def.Blk.Pct',	'Def.FG_3A.Pct',	'Def.A.Pct',
                       'Def.APL',	'Foul2Partic.Pct')

      x <- (page %>%
             rvest::html_elements(css = '#player-table'))[[1]]

      ## removing national rankings for easier manipulation
      ## TODO: Add these rankings back as columns
      conf <- (page %>%
                 rvest::html_elements(css = '#player-table'))[[1]]

      conf_record <- (page %>%
                        rvest::html_elements("td:nth-child(5) > span"))
      conf_record_wl <- dplyr::bind_rows(lapply(rvest::html_text(conf_record),
                                                function(x){
                                                  data.frame(x, stringsAsFactors = FALSE)
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no coach history data for {coach} available!",
      args = .args
    ),
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
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       rk \tab numeric \tab Rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       conf \tab character \tab character. \cr
#'       rtg \tab numeric \tab Rtg. \cr
#'       best_rk \tab numeric \tab Best rk. \cr
#'       best_yr \tab numeric \tab Best yr. \cr
#'       worst_rk \tab numeric \tab Worst rk. \cr
#'       worst_yr \tab numeric \tab Worst yr. \cr
#'       kp_median \tab numeric \tab Kp median. \cr
#'       top10 \tab numeric \tab Top10. \cr
#'       top25 \tab numeric \tab Top25. \cr
#'       top50 \tab numeric \tab Top50. \cr
#'       ch \tab numeric \tab Ch. \cr
#'       f4 \tab numeric \tab F4. \cr
#'       s16 \tab numeric \tab S16. \cr
#'       r1 \tab numeric \tab R1. \cr
#'       chg \tab numeric \tab Chg. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter
#' @import rvest
#' @export
#' @keywords Program Ratings
#' @family KenPom Historical Functions
#' @examples
#' \donttest{
#'   try(kp_program_ratings())
#' }

kp_program_ratings <- function(){
  .args <- .capture_args()

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()

      ### Pull Data
      url <- "https://kenpom.com/programs.php?"

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c('Rk',	'Team',	'Conf','Rtg',
                      'Best.Rk','Best.Yr',
                      'Worst.Rk','Worst.Yr', 'KP.Median',
                      'Top10',	'Top25',	'Top50',	'CH',
                      'F4',	'S16',	'R1',	'Chg')

      x <- (page %>%
              rvest::html_elements(css = '#ratings-table'))[[1]]

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no program ratings available!",
      args = .args
    ),
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
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       adj_em_rk \tab numeric \tab Adj em rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       conf \tab character \tab character. \cr
#'       adj_em \tab numeric \tab Adj em. \cr
#'       adj_o \tab numeric \tab Adj o. \cr
#'       adj_o_rk \tab numeric \tab Adj o rk. \cr
#'       adj_d \tab numeric \tab Adj d. \cr
#'       adj_d_rk \tab numeric \tab Adj d rk. \cr
#'       adj_t \tab numeric \tab Adj t. \cr
#'       adj_t_rk \tab numeric \tab Adj t rk. \cr
#'       final_rk \tab numeric \tab Final rk. \cr
#'       final_adj_em \tab numeric \tab Final adj em. \cr
#'       final_adj_o \tab numeric \tab Final adj o. \cr
#'       final_adj_o_rk \tab numeric \tab Final adj o rk. \cr
#'       final_adj_d \tab numeric \tab Final adj d. \cr
#'       final_adj_d_rk \tab numeric \tab Final adj d rk. \cr
#'       final_adj_t \tab numeric \tab Final adj t. \cr
#'       final_adj_t_rk \tab numeric \tab Final adj t rk. \cr
#'       rk_chg \tab numeric \tab Rk chg. \cr
#'       em_chg \tab numeric \tab Em chg. \cr
#'       adj_t_chg \tab numeric \tab Adj t chg. \cr
#'       ncaa_seed \tab numeric \tab Ncaa seed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom dplyr filter mutate
#' @importFrom stringr str_remove str_remove str_trim
#' @import rvest
#' @export
#' @keywords Ratings Archive
#' @family KenPom Historical Functions
#' @examples
#' \donttest{
#'   try(kp_pomeroy_archive_ratings(date='2018-11-22'))
#' }
kp_pomeroy_archive_ratings <- function(date){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

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
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)

      x <- (page %>%
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no kp_pomeroy_archive_ratings data for {date} available!",
      args = .args
    ),
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
#' @return A list of named data frames:
#'
#'    **Standings**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       overall \tab character \tab Overall. \cr
#'       conf \tab character \tab character. \cr
#'       adj_em \tab numeric \tab Adj em. \cr
#'       adj_em_rk \tab numeric \tab Adj em rk. \cr
#'       adj_o \tab numeric \tab Adj o. \cr
#'       adj_o_rk \tab numeric \tab Adj o rk. \cr
#'       adj_d \tab numeric \tab Adj d. \cr
#'       adj_d_rk \tab numeric \tab Adj d rk. \cr
#'       adj_t \tab numeric \tab Adj t. \cr
#'       adj_t_rk \tab numeric \tab Adj t rk. \cr
#'       conf_sos \tab numeric \tab Conf sos. \cr
#'       conf_sos_rk \tab numeric \tab Conf sos rk. \cr
#'       next_game \tab character \tab Next game date or opponent. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **ConferencePlayOffense**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       oe \tab numeric \tab Oe. \cr
#'       oe_rk \tab numeric \tab Oe rk. \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       e_fg_pct_rk \tab numeric \tab E fg pct rk. \cr
#'       to_pct \tab numeric \tab To percentage (0-1 decimal). \cr
#'       to_pct_rk \tab numeric \tab To pct rk. \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       or_pct_rk \tab numeric \tab Or pct rk. \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       ft_rate_rk \tab numeric \tab Ft rate rk. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fg_2_pct_rk \tab numeric \tab Fg 2 pct rk. \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       fg_3_pct_rk \tab numeric \tab Fg 3 pct rk. \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       ft_pct_rk \tab numeric \tab Ft pct rk. \cr
#'       tempo \tab numeric \tab Tempo. \cr
#'       tempo_rk \tab numeric \tab Tempo rk. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **ConferencePlayDefense**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       de \tab numeric \tab De. \cr
#'       de_rk \tab numeric \tab De rk. \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       e_fg_pct_rk \tab numeric \tab E fg pct rk. \cr
#'       to_pct \tab numeric \tab To percentage (0-1 decimal). \cr
#'       to_pct_rk \tab numeric \tab To pct rk. \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       or_pct_rk \tab numeric \tab Or pct rk. \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       ft_rate_rk \tab numeric \tab Ft rate rk. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fg_2_pct_rk \tab numeric \tab Fg 2 pct rk. \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       fg_3_pct_rk \tab numeric \tab Fg 3 pct rk. \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       blk_pct_rk \tab numeric \tab Blk pct rk. \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       stl_pct_rk \tab numeric \tab Stl pct rk. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **AllKenPom**
#'
#'
#'    |col_name |types     |description   |
#'    |:--------|:---------|:-------------|
#'    |rk       |integer   |Rk.           |
#'    |player   |character |Player.       |
#'    |year     |numeric   |4-digit year. |
#'
#'    **ConferenceAggregateStats**
#'
#'
#'    |col_name |types     |description                    |
#'    |:--------|:---------|:------------------------------|
#'    |stat     |character |Stat.                          |
#'    |value    |numeric   |Numeric or string value field. |
#'    |rk       |numeric   |Rk.                            |
#'    |year     |numeric   |4-digit year.                  |
#'
#'    **WinningTrends**
#'
#'
#'    |col_name |types     |description                    |
#'    |:--------|:---------|:------------------------------|
#'    |stat     |character |Stat.                          |
#'    |count    |character |Count of count.                |
#'    |value    |numeric   |Numeric or string value field. |
#'    |rk       |numeric   |Rk.                            |
#'    |year     |numeric   |4-digit year.                  |
#'
#'    **ConferenceComparison**
#'
#'
#'    |col_name   |types     |description   |
#'    |:----------|:---------|:-------------|
#'    |rk         |numeric   |Rk.           |
#'    |conference |character |Conference.   |
#'    |rating     |numeric   |Rating.       |
#'    |year       |numeric   |4-digit year. |
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate
#' @import rvest
#' @export
#' @keywords Conference Stats
#' @family KenPom Historical Functions
#' @examples
#' \donttest{
#'     try(kp_conf(year = 2020, conf = 'ACC'))
#' }

kp_conf <- function(year, conf){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      header_cols <- c('Team',	'Overall',	'Conf','AdjEM','AdjEM.Rk',
                       'AdjO','AdjO.Rk',	'AdjD','AdjD.Rk',	'AdjT','AdjT.Rk',
                       'ConfSOS','ConfSOS.Rk','NextGame')
      header_cols2 <- c('Team',	'OE','OE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                        'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                        'FG_3.Pct', 'FG_3.Pct.Rk', 'FT.Pct','FT.Pct.Rk','Tempo','Tempo.Rk')
      header_cols3 <- c('Team',	'DE','DE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                        'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                        'FG_3.Pct', 'FG_3.Pct.Rk', 'Blk.Pct','Blk.Pct.Rk','Stl.Pct','Stl.Pct.Rk')
      header_cols4 <- c('Rk','Player')
      header_cols5 <- c('Stat','Value','Rk')
      header_cols6 <- c('Stat','Count','Value','Rk')
      header_cols7 <- c('Rk','Conference','Rating','Rk2','Conference2','Rating2')



      # Check conf parameter in teams_list$Conf names
      if (!(conf %in% hoopR::teams_links$Conf)) {
        cli::cli_abort("Incorrect conference name as compared to the website, see hoopR::teams_links for conference name parameter specifications.")
      }

      conf_name = unique(hoopR::teams_links$conf.link.ref[hoopR::teams_links$Conf == conf])

      ### Pull Data
      url <- paste0("https://kenpom.com/conf.php?",
                    "c=", conf_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      y <- list()
      for (i in 1:7) {

        x <- (page %>%
                rvest::html_elements('table'))[[i]] %>%
          rvest::html_table() %>%
          as.data.frame()

        if (i == 1) {
          x <- x[1:(length(x) - 2)]
          if (length(colnames(x)) == length(header_cols)) {
            colnames(x) <- header_cols
          } else {
            colnames(x) <- header_cols[-length(header_cols)]
          }
          suppressWarnings(
            x <- x %>%
              mutate_at(c('AdjEM', 'AdjEM.Rk',
                          'AdjO', 'AdjO.Rk', 'AdjD', 'AdjD.Rk',	'AdjT', 'AdjT.Rk',
                          'ConfSOS', 'ConfSOS.Rk'), as.numeric)
          )
        } else if (i == 2) {
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
        } else if (i == 3) {
          colnames(x) <- header_cols3
          suppressWarnings(
            x <- x %>%
              dplyr::mutate_at(
                c('DE','DE.Rk','eFG.Pct','eFG.Pct.Rk','TO.Pct','TO.Pct.Rk',
                  'OR.Pct','OR.Pct.Rk','FTRate', 'FTRate.Rk',	'FG_2.Pct', 'FG_2.Pct.Rk',
                  'FG_3.Pct', 'FG_3.Pct.Rk', 'Blk.Pct','Blk.Pct.Rk','Stl.Pct','Stl.Pct.Rk'),
                as.numeric)
          )

        } else if (i == 4) {
          colnames(x) <- header_cols4
        } else if (i == 5) {
          colnames(x) <- header_cols5
          suppressWarnings(
            x <- x %>%
              dplyr::mutate_at(c('Value','Rk'),as.numeric)
          )
        } else if (i == 6) {
          colnames(x) <- header_cols6
          suppressWarnings(
            x <- x %>%
              dplyr::mutate_at(c('Value','Rk'),as.numeric)
          )
        } else if (i == 7) {
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
      names(kenpom) <- c(
        "Standings",
        "ConferencePlayOffense",
        "ConferencePlayDefense",
        "AllKenPom",
        "ConferenceAggregateStats",
        "WinningTrends",
        "ConferenceComparison"
      )

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no conference data for {year} {conf} available!",
      args = .args
    ),
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
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       conf \tab character \tab character. \cr
#'       eff \tab numeric \tab Eff. \cr
#'       eff_rk \tab numeric \tab Eff rk. \cr
#'       tempo \tab numeric \tab Tempo. \cr
#'       tempo_rk \tab numeric \tab Tempo rk. \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       e_fg_pct_rk \tab numeric \tab E fg pct rk. \cr
#'       to_pct \tab numeric \tab To percentage (0-1 decimal). \cr
#'       to_pct_rk \tab numeric \tab To pct rk. \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       or_pct_rk \tab numeric \tab Or pct rk. \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       ft_rate_rk \tab numeric \tab Ft rate rk. \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       blk_pct_rk \tab numeric \tab Blk pct rk. \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       stl_pct_rk \tab numeric \tab Stl pct rk. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fg_2_pct_rk \tab numeric \tab Fg 2 pct rk. \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       fg_3_pct_rk \tab numeric \tab Fg 3 pct rk. \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       ft_pct_rk \tab numeric \tab Ft pct rk. \cr
#'       fg_3a_pct \tab numeric \tab Field goals 3a percentage (0-1 decimal). \cr
#'       fg_3a_pct_rk \tab numeric \tab Fg 3a pct rk. \cr
#'       a_pct \tab numeric \tab A percentage (0-1 decimal). \cr
#'       a_pct_rk \tab numeric \tab A pct rk. \cr
#'       home_w_l \tab character \tab Home team's wins losses. \cr
#'       home_w_l_pct \tab numeric \tab Home wins losses percentage (0-1 decimal). \cr
#'       home_w_l_rk \tab numeric \tab Home team's wins losses rk. \cr
#'       close \tab numeric \tab Close. \cr
#'       close_rk \tab numeric \tab Close rk. \cr
#'       blowouts \tab numeric \tab Blowouts. \cr
#'       blowouts_rk \tab numeric \tab Blowouts rk. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate filter mutate_at
#' @import rvest
#' @export
#' @keywords Conference Comparison
#' @family KenPom Historical Functions
#'
#' @examples
#' \donttest{
#'   try(kp_confstats(year=most_recent_mbb_season()))
#' }

kp_confstats <- function(year = most_recent_mbb_season()){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

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
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      x <- (page %>%
              rvest::html_elements(css = "#confrank-table"))[[1]] %>%
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no conference stats data for {year} available!",
      args = .args
    ),
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
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       year \tab integer \tab 4-digit year. \cr
#'       rank \tab character \tab Rank. \cr
#'       tempo \tab numeric \tab Tempo. \cr
#'       efficiency \tab numeric \tab Efficiency. \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       to_pct \tab numeric \tab To percentage (0-1 decimal). \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       fg_3a_pct \tab numeric \tab Field goals 3a percentage (0-1 decimal). \cr
#'       a_pct \tab numeric \tab A percentage (0-1 decimal). \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       home_record \tab character \tab Home win-loss record. \cr
#'       bids \tab character \tab Bids. \cr
#'       s16 \tab character \tab S16. \cr
#'       f4 \tab character \tab F4. \cr
#'       ch \tab character \tab Ch. \cr
#'       reg_season_champ \tab character \tab Reg season champ. \cr
#'       tourney_champ \tab character \tab Tourney champ. \cr
#'       best_team \tab character \tab Best team. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate_at
#' @import rvest
#' @export
#' @keywords Conference History
#' @family KenPom Historical Functions
#'
#' @examples
#' \donttest{
#'   try(kp_confhistory(conf = 'ACC'))
#' }

kp_confhistory <- function(conf){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

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
      if (!(conf %in% hoopR::teams_links$Conf)) {
        cli::cli_abort("Incorrect conference name as compared to the website, see hoopR::teams_links for conference name parameter specifications.")
      }
      conf_name = unique(hoopR::teams_links$conf.link.ref[hoopR::teams_links$Conf == conf])

      ### Pull Data
      url <- paste0("https://kenpom.com/confhistory.php?",
                    "c=", conf_name)
      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      x <- page %>%
        rvest::html_elements(css = "#player-table")

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no conference history data for {conf} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}
