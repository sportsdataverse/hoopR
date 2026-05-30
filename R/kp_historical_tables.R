#' **Get KenPom's team efficiency history**
#'
#'
#' @param team Team filter to select.
#' @return A data frame with the following columns:
#'
#'    |col_name           |types     |description                                  |
#'    |:------------------|:---------|:--------------------------------------------|
#'    |year               |numeric   |4-digit year.                                |
#'    |team_rk            |numeric   |Team rk.                                     |
#'    |team               |character |Team-side label or team identifier.          |
#'    |coach              |character |Coach.                                       |
#'    |conf               |character |character.                                   |
#'    |adj_t              |numeric   |Adj t.                                       |
#'    |adj_o              |numeric   |Adj o.                                       |
#'    |adj_d              |numeric   |Adj d.                                       |
#'    |off_e_fg_pct       |numeric   |Off e field goals percentage (0-1 decimal).  |
#'    |off_to_pct         |numeric   |Off to percentage (0-1 decimal).             |
#'    |off_or_pct         |numeric   |Off or percentage (0-1 decimal).             |
#'    |off_ft_rate        |numeric   |Off ft rate.                                 |
#'    |off_fg_2_pct       |numeric   |Off field goals 2 percentage (0-1 decimal).  |
#'    |off_fg_3_pct       |numeric   |Off field goals 3 percentage (0-1 decimal).  |
#'    |off_ft_pct         |numeric   |Off free throws percentage (0-1 decimal).    |
#'    |off_fg_3a_pct      |numeric   |Off field goals 3a percentage (0-1 decimal). |
#'    |off_a_pct          |numeric   |Off a percentage (0-1 decimal).              |
#'    |off_apl            |numeric   |Off apl.                                     |
#'    |def_e_fg_pct       |numeric   |Def e field goals percentage (0-1 decimal).  |
#'    |def_to_pct         |numeric   |Def to percentage (0-1 decimal).             |
#'    |def_or_pct         |numeric   |Def or percentage (0-1 decimal).             |
#'    |def_ft_rate        |numeric   |Def ft rate.                                 |
#'    |def_fg_2_pct       |numeric   |Def field goals 2 percentage (0-1 decimal).  |
#'    |def_fg_3_pct       |numeric   |Def field goals 3 percentage (0-1 decimal).  |
#'    |def_blk_pct        |numeric   |Def blocks percentage (0-1 decimal).         |
#'    |def_fg_3a_pct      |numeric   |Def field goals 3a percentage (0-1 decimal). |
#'    |def_a_pct          |numeric   |Def a percentage (0-1 decimal).              |
#'    |def_apl            |numeric   |Def apl.                                     |
#'    |foul2partic_pct    |numeric   |Foul2partic percentage (0-1 decimal).        |
#'    |wl                 |character |Wl.                                          |
#'    |wl_conf            |character |Wl conf.                                     |
#'    |adj_t_rk           |numeric   |Adj t rk.                                    |
#'    |adj_o_rk           |numeric   |Adj o rk.                                    |
#'    |adj_d_rk           |numeric   |Adj d rk.                                    |
#'    |off_e_fg_pct_rk    |numeric   |Off e fg pct rk.                             |
#'    |off_to_pct_rk      |numeric   |Off to pct rk.                               |
#'    |off_or_pct_rk      |numeric   |Off or pct rk.                               |
#'    |off_ft_rate_rk     |numeric   |Off ft rate rk.                              |
#'    |off_fg_2_pct_rk    |numeric   |Off fg 2 pct rk.                             |
#'    |off_fg_3_pct_rk    |numeric   |Off fg 3 pct rk.                             |
#'    |off_ft_pct_rk      |numeric   |Off ft pct rk.                               |
#'    |off_fg_3a_pct_rk   |numeric   |Off fg 3a pct rk.                            |
#'    |off_a_pct_rk       |numeric   |Off a pct rk.                                |
#'    |off_apl_rk         |numeric   |Off apl rk.                                  |
#'    |def_e_fg_pct_rk    |numeric   |Def e fg pct rk.                             |
#'    |def_to_pct_rk      |numeric   |Def to pct rk.                               |
#'    |def_or_pct_rk      |numeric   |Def or pct rk.                               |
#'    |def_ft_rate_rk     |numeric   |Def ft rate rk.                              |
#'    |def_fg_2_pct_rk    |numeric   |Def fg 2 pct rk.                             |
#'    |def_fg_3_pct_rk    |numeric   |Def fg 3 pct rk.                             |
#'    |def_blk_pct_rk     |numeric   |Def blk pct rk.                              |
#'    |def_fg_3a_pct_rk   |numeric   |Def fg 3a pct rk.                            |
#'    |def_a_pct_rk       |numeric   |Def a pct rk.                                |
#'    |def_apl_rk         |numeric   |Def apl rk.                                  |
#'    |foul2partic_pct_rk |numeric   |Foul2partic pct rk.                          |
#'    |team_finish        |character |Team finish.                                 |
#'    |ncaa_seed          |numeric   |Ncaa seed.                                   |
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
#'    |col_name           |types     |description                                  |
#'    |:------------------|:---------|:--------------------------------------------|
#'    |year               |numeric   |4-digit year.                                |
#'    |team_rk            |numeric   |Team rk.                                     |
#'    |team               |character |Team-side label or team identifier.          |
#'    |coach              |character |Coach.                                       |
#'    |conf               |character |character.                                   |
#'    |adj_t              |character |Adj t.                                       |
#'    |adj_o              |character |Adj o.                                       |
#'    |adj_d              |character |Adj d.                                       |
#'    |off_e_fg_pct       |character |Off e field goals percentage (0-1 decimal).  |
#'    |off_to_pct         |character |Off to percentage (0-1 decimal).             |
#'    |off_or_pct         |character |Off or percentage (0-1 decimal).             |
#'    |off_ft_rate        |character |Off ft rate.                                 |
#'    |off_fg_2_pct       |character |Off field goals 2 percentage (0-1 decimal).  |
#'    |off_fg_3_pct       |character |Off field goals 3 percentage (0-1 decimal).  |
#'    |off_ft_pct         |character |Off free throws percentage (0-1 decimal).    |
#'    |off_fg_3a_pct      |character |Off field goals 3a percentage (0-1 decimal). |
#'    |off_a_pct          |character |Off a percentage (0-1 decimal).              |
#'    |off_apl            |character |Off apl.                                     |
#'    |def_e_fg_pct       |character |Def e field goals percentage (0-1 decimal).  |
#'    |def_to_pct         |character |Def to percentage (0-1 decimal).             |
#'    |def_or_pct         |character |Def or percentage (0-1 decimal).             |
#'    |def_ft_rate        |character |Def ft rate.                                 |
#'    |def_fg_2_pct       |character |Def field goals 2 percentage (0-1 decimal).  |
#'    |def_fg_3_pct       |character |Def field goals 3 percentage (0-1 decimal).  |
#'    |def_blk_pct        |character |Def blocks percentage (0-1 decimal).         |
#'    |def_fg_3a_pct      |character |Def field goals 3a percentage (0-1 decimal). |
#'    |def_a_pct          |character |Def a percentage (0-1 decimal).              |
#'    |def_apl            |character |Def apl.                                     |
#'    |foul2partic_pct    |character |Foul2partic percentage (0-1 decimal).        |
#'    |wl                 |character |Wl.                                          |
#'    |wl_conf            |character |Wl conf.                                     |
#'    |adj_t_rk           |numeric   |Adj t rk.                                    |
#'    |adj_o_rk           |numeric   |Adj o rk.                                    |
#'    |adj_d_rk           |numeric   |Adj d rk.                                    |
#'    |off_e_fg_pct_rk    |numeric   |Off e fg pct rk.                             |
#'    |off_to_pct_rk      |numeric   |Off to pct rk.                               |
#'    |off_or_pct_rk      |numeric   |Off or pct rk.                               |
#'    |off_ft_rate_rk     |numeric   |Off ft rate rk.                              |
#'    |off_fg_2_pct_rk    |numeric   |Off fg 2 pct rk.                             |
#'    |off_fg_3_pct_rk    |numeric   |Off fg 3 pct rk.                             |
#'    |off_ft_pct_rk      |numeric   |Off ft pct rk.                               |
#'    |off_fg_3a_pct_rk   |numeric   |Off fg 3a pct rk.                            |
#'    |off_a_pct_rk       |numeric   |Off a pct rk.                                |
#'    |off_apl_rk         |numeric   |Off apl rk.                                  |
#'    |def_e_fg_pct_rk    |numeric   |Def e fg pct rk.                             |
#'    |def_to_pct_rk      |numeric   |Def to pct rk.                               |
#'    |def_or_pct_rk      |numeric   |Def or pct rk.                               |
#'    |def_ft_rate_rk     |numeric   |Def ft rate rk.                              |
#'    |def_fg_2_pct_rk    |numeric   |Def fg 2 pct rk.                             |
#'    |def_fg_3_pct_rk    |numeric   |Def fg 3 pct rk.                             |
#'    |def_blk_pct_rk     |numeric   |Def blk pct rk.                              |
#'    |def_fg_3a_pct_rk   |numeric   |Def fg 3a pct rk.                            |
#'    |def_a_pct_rk       |numeric   |Def a pct rk.                                |
#'    |def_apl_rk         |numeric   |Def apl rk.                                  |
#'    |foul2partic_pct_rk |numeric   |Foul2partic pct rk.                          |
#'    |team_finish        |character |Team finish.                                 |
#'    |ncaa_seed          |numeric   |Ncaa seed.                                   |
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
#'    |col_name  |types     |description                         |
#'    |:---------|:---------|:-----------------------------------|
#'    |rk        |numeric   |Rk.                                 |
#'    |team      |character |Team-side label or team identifier. |
#'    |conf      |character |character.                          |
#'    |rtg       |numeric   |Rtg.                                |
#'    |best_rk   |numeric   |Best rk.                            |
#'    |best_yr   |numeric   |Best yr.                            |
#'    |worst_rk  |numeric   |Worst rk.                           |
#'    |worst_yr  |numeric   |Worst yr.                           |
#'    |kp_median |numeric   |Kp median.                          |
#'    |top10     |numeric   |Top10.                              |
#'    |top25     |numeric   |Top25.                              |
#'    |top50     |numeric   |Top50.                              |
#'    |ch        |numeric   |Ch.                                 |
#'    |f4        |numeric   |F4.                                 |
#'    |s16       |numeric   |S16.                                |
#'    |r1        |numeric   |R1.                                 |
#'    |chg       |numeric   |Chg.                                |
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
#'    |col_name       |types     |description                         |
#'    |:--------------|:---------|:-----------------------------------|
#'    |adj_em_rk      |numeric   |Adj em rk.                          |
#'    |team           |character |Team-side label or team identifier. |
#'    |conf           |character |character.                          |
#'    |adj_em         |numeric   |Adj em.                             |
#'    |adj_o          |numeric   |Adj o.                              |
#'    |adj_o_rk       |numeric   |Adj o rk.                           |
#'    |adj_d          |numeric   |Adj d.                              |
#'    |adj_d_rk       |numeric   |Adj d rk.                           |
#'    |adj_t          |numeric   |Adj t.                              |
#'    |adj_t_rk       |numeric   |Adj t rk.                           |
#'    |final_rk       |numeric   |Final rk.                           |
#'    |final_adj_em   |numeric   |Final adj em.                       |
#'    |final_adj_o    |numeric   |Final adj o.                        |
#'    |final_adj_o_rk |numeric   |Final adj o rk.                     |
#'    |final_adj_d    |numeric   |Final adj d.                        |
#'    |final_adj_d_rk |numeric   |Final adj d rk.                     |
#'    |final_adj_t    |numeric   |Final adj t.                        |
#'    |final_adj_t_rk |numeric   |Final adj t rk.                     |
#'    |rk_chg         |numeric   |Rk chg.                             |
#'    |em_chg         |numeric   |Em chg.                             |
#'    |adj_t_chg      |numeric   |Adj t chg.                          |
#'    |ncaa_seed      |numeric   |Ncaa seed.                          |
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
#'    |col_name    |types     |description                         |
#'    |:-----------|:---------|:-----------------------------------|
#'    |team        |character |Team-side label or team identifier. |
#'    |overall     |character |Overall.                            |
#'    |conf        |character |character.                          |
#'    |adj_em      |numeric   |Adj em.                             |
#'    |adj_em_rk   |numeric   |Adj em rk.                          |
#'    |adj_o       |numeric   |Adj o.                              |
#'    |adj_o_rk    |numeric   |Adj o rk.                           |
#'    |adj_d       |numeric   |Adj d.                              |
#'    |adj_d_rk    |numeric   |Adj d rk.                           |
#'    |adj_t       |numeric   |Adj t.                              |
#'    |adj_t_rk    |numeric   |Adj t rk.                           |
#'    |conf_sos    |numeric   |Conf sos.                           |
#'    |conf_sos_rk |numeric   |Conf sos rk.                        |
#'    |next_game   |character |Next game date or opponent.         |
#'    |year        |numeric   |4-digit year.                       |
#'
#'    **ConferencePlayOffense**
#'
#'
#'    |col_name    |types     |description                             |
#'    |:-----------|:---------|:---------------------------------------|
#'    |team        |character |Team-side label or team identifier.     |
#'    |oe          |numeric   |Oe.                                     |
#'    |oe_rk       |numeric   |Oe rk.                                  |
#'    |e_fg_pct    |numeric   |E field goals percentage (0-1 decimal). |
#'    |e_fg_pct_rk |numeric   |E fg pct rk.                            |
#'    |to_pct      |numeric   |To percentage (0-1 decimal).            |
#'    |to_pct_rk   |numeric   |To pct rk.                              |
#'    |or_pct      |numeric   |Or percentage (0-1 decimal).            |
#'    |or_pct_rk   |numeric   |Or pct rk.                              |
#'    |ft_rate     |numeric   |Ft rate.                                |
#'    |ft_rate_rk  |numeric   |Ft rate rk.                             |
#'    |fg_2_pct    |numeric   |Field goals 2 percentage (0-1 decimal). |
#'    |fg_2_pct_rk |numeric   |Fg 2 pct rk.                            |
#'    |fg_3_pct    |numeric   |Field goals 3 percentage (0-1 decimal). |
#'    |fg_3_pct_rk |numeric   |Fg 3 pct rk.                            |
#'    |ft_pct      |numeric   |Free throw percentage (0-1).            |
#'    |ft_pct_rk   |numeric   |Ft pct rk.                              |
#'    |tempo       |numeric   |Tempo.                                  |
#'    |tempo_rk    |numeric   |Tempo rk.                               |
#'    |year        |numeric   |4-digit year.                           |
#'
#'    **ConferencePlayDefense**
#'
#'
#'    |col_name    |types     |description                             |
#'    |:-----------|:---------|:---------------------------------------|
#'    |team        |character |Team-side label or team identifier.     |
#'    |de          |numeric   |De.                                     |
#'    |de_rk       |numeric   |De rk.                                  |
#'    |e_fg_pct    |numeric   |E field goals percentage (0-1 decimal). |
#'    |e_fg_pct_rk |numeric   |E fg pct rk.                            |
#'    |to_pct      |numeric   |To percentage (0-1 decimal).            |
#'    |to_pct_rk   |numeric   |To pct rk.                              |
#'    |or_pct      |numeric   |Or percentage (0-1 decimal).            |
#'    |or_pct_rk   |numeric   |Or pct rk.                              |
#'    |ft_rate     |numeric   |Ft rate.                                |
#'    |ft_rate_rk  |numeric   |Ft rate rk.                             |
#'    |fg_2_pct    |numeric   |Field goals 2 percentage (0-1 decimal). |
#'    |fg_2_pct_rk |numeric   |Fg 2 pct rk.                            |
#'    |fg_3_pct    |numeric   |Field goals 3 percentage (0-1 decimal). |
#'    |fg_3_pct_rk |numeric   |Fg 3 pct rk.                            |
#'    |blk_pct     |numeric   |Blocks percentage (0-1 decimal).        |
#'    |blk_pct_rk  |numeric   |Blk pct rk.                             |
#'    |stl_pct     |numeric   |Steals percentage (0-1 decimal).        |
#'    |stl_pct_rk  |numeric   |Stl pct rk.                             |
#'    |year        |numeric   |4-digit year.                           |
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
#'    |col_name     |types     |description                                |
#'    |:------------|:---------|:------------------------------------------|
#'    |conf         |character |character.                                 |
#'    |eff          |numeric   |Eff.                                       |
#'    |eff_rk       |numeric   |Eff rk.                                    |
#'    |tempo        |numeric   |Tempo.                                     |
#'    |tempo_rk     |numeric   |Tempo rk.                                  |
#'    |e_fg_pct     |numeric   |E field goals percentage (0-1 decimal).    |
#'    |e_fg_pct_rk  |numeric   |E fg pct rk.                               |
#'    |to_pct       |numeric   |To percentage (0-1 decimal).               |
#'    |to_pct_rk    |numeric   |To pct rk.                                 |
#'    |or_pct       |numeric   |Or percentage (0-1 decimal).               |
#'    |or_pct_rk    |numeric   |Or pct rk.                                 |
#'    |ft_rate      |numeric   |Ft rate.                                   |
#'    |ft_rate_rk   |numeric   |Ft rate rk.                                |
#'    |blk_pct      |numeric   |Blocks percentage (0-1 decimal).           |
#'    |blk_pct_rk   |numeric   |Blk pct rk.                                |
#'    |stl_pct      |numeric   |Steals percentage (0-1 decimal).           |
#'    |stl_pct_rk   |numeric   |Stl pct rk.                                |
#'    |fg_2_pct     |numeric   |Field goals 2 percentage (0-1 decimal).    |
#'    |fg_2_pct_rk  |numeric   |Fg 2 pct rk.                               |
#'    |fg_3_pct     |numeric   |Field goals 3 percentage (0-1 decimal).    |
#'    |fg_3_pct_rk  |numeric   |Fg 3 pct rk.                               |
#'    |ft_pct       |numeric   |Free throw percentage (0-1).               |
#'    |ft_pct_rk    |numeric   |Ft pct rk.                                 |
#'    |fg_3a_pct    |numeric   |Field goals 3a percentage (0-1 decimal).   |
#'    |fg_3a_pct_rk |numeric   |Fg 3a pct rk.                              |
#'    |a_pct        |numeric   |A percentage (0-1 decimal).                |
#'    |a_pct_rk     |numeric   |A pct rk.                                  |
#'    |home_w_l     |character |Home team's wins losses.                   |
#'    |home_w_l_pct |numeric   |Home wins losses percentage (0-1 decimal). |
#'    |home_w_l_rk  |numeric   |Home team's wins losses rk.                |
#'    |close        |numeric   |Close.                                     |
#'    |close_rk     |numeric   |Close rk.                                  |
#'    |blowouts     |numeric   |Blowouts.                                  |
#'    |blowouts_rk  |numeric   |Blowouts rk.                               |
#'    |year         |numeric   |4-digit year.                              |
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
#'    |col_name         |types     |description                              |
#'    |:----------------|:---------|:----------------------------------------|
#'    |year             |integer   |4-digit year.                            |
#'    |rank             |character |Rank.                                    |
#'    |tempo            |numeric   |Tempo.                                   |
#'    |efficiency       |numeric   |Efficiency.                              |
#'    |e_fg_pct         |numeric   |E field goals percentage (0-1 decimal).  |
#'    |to_pct           |numeric   |To percentage (0-1 decimal).             |
#'    |or_pct           |numeric   |Or percentage (0-1 decimal).             |
#'    |ft_rate          |numeric   |Ft rate.                                 |
#'    |fg_2_pct         |numeric   |Field goals 2 percentage (0-1 decimal).  |
#'    |fg_3_pct         |numeric   |Field goals 3 percentage (0-1 decimal).  |
#'    |ft_pct           |numeric   |Free throw percentage (0-1).             |
#'    |fg_3a_pct        |numeric   |Field goals 3a percentage (0-1 decimal). |
#'    |a_pct            |numeric   |A percentage (0-1 decimal).              |
#'    |blk_pct          |numeric   |Blocks percentage (0-1 decimal).         |
#'    |stl_pct          |numeric   |Steals percentage (0-1 decimal).         |
#'    |home_record      |character |Home win-loss record.                    |
#'    |bids             |character |Bids.                                    |
#'    |s16              |character |S16.                                     |
#'    |f4               |character |F4.                                      |
#'    |ch               |character |Ch.                                      |
#'    |reg_season_champ |character |Reg season champ.                        |
#'    |tourney_champ    |character |Tourney champ.                           |
#'    |best_team        |character |Best team.                               |
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
