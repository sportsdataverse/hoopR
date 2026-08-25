#' **Get team schedule results**
#'
#'
#' @param team Team filter to select.
#' @return Returns a tibble of team schedules
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_rk \tab numeric \tab Team rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       opponent_rk \tab numeric \tab Opponent rk. \cr
#'       opponent \tab character \tab Opponent. \cr
#'       result \tab character \tab Result. \cr
#'       poss \tab numeric \tab Poss. \cr
#'       ot \tab numeric \tab Ot. \cr
#'       pre_wp \tab numeric \tab Pre wp. \cr
#'       location \tab character \tab Location. \cr
#'       w \tab numeric \tab Wins. \cr
#'       l \tab numeric \tab Losses. \cr
#'       w_conference \tab numeric \tab W conference. \cr
#'       l_conference \tab numeric \tab L conference. \cr
#'       conference_game \tab logical \tab Conference game. \cr
#'       postseason \tab character \tab Postseason. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       day_date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       game_date \tab numeric \tab Game date (YYYY-MM-DD). \cr
#'       w_proj \tab numeric \tab W proj. \cr
#'       l_proj \tab numeric \tab L proj. \cr
#'       w_conference_proj \tab numeric \tab W conference proj. \cr
#'       l_conference_proj \tab numeric \tab L conference proj. \cr
#'       date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       game_id \tab numeric \tab Unique game identifier. \cr
#'       tiers_of_joy \tab character \tab Tiers of joy. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter mutate select
#' @importFrom stringr str_trim str_extract str_remove str_replace str_detect str_pad
#' @import rvest
#' @export
#' @keywords Team Schedule
#' @family KenPom Team Functions
#'
#' @examples
#' \donttest{
#'   try(kp_team_schedule(team = 'Florida St.', year = 2022))
#' }

kp_team_schedule <- function(team, year = 2022){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2001)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2001")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]


      ### Pull Data
      url <- paste0("https://kenpom.com/team.php?",
                    "team=",team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      if (year >= 2011) {
        sched_header_cols <- c("Day.Date","Team.Rk","Opponent.Rk","Opponent","Result",
                              "Poss","OT","Location","Record","Conference", "Postseason")
      } else {
        sched_header_cols <- c("Day.Date", "Opponent.Rk", "Opponent", "Result",
                              "Poss", "OT", "Location", "Record", "Conference", "Postseason")
      }

      sched <- (page %>%
                  rvest::html_elements(css = '#schedule-table') %>%
                  rvest::html_table()) %>%
        as.data.frame()

      ## Removing the tiers of joy column, will add back to data frame subsequently
      # sched <- sched[,1:(length(sched)-1)]
      #
      # Note: As a result of the tiers of joy column being an image (.gif) instead of text,
      # there is an extra unnamed column with no text. Antecedently, I was removing this column
      # and the resulting code below is in efforts to extract the GameId from the box/pregame link
      # and the fanmatch link date. Additionally, we add back a text-equivalent for tiers of joy.
      # I realized that since this extra column exists and the label column for
      # postseason events repeats across the entire data frame row, I could use that last repeat
      # as a label for regular vs conference tourney/postseason tourney games.
      # One small piece of good fortune in this otherwise mundane task.

      colnames(sched) <- sched_header_cols
      sched <- sched %>%
        dplyr::mutate(Postseason = ifelse(.data$Postseason == "", NA_character_, .data$Postseason)) %>%
        tidyr::fill("Postseason", .direction = c("down"))

      suppressWarnings(
        sched <- sched %>%
          dplyr::mutate(
            WL = stringr::str_replace(stringr::str_extract(.data$Result,'W|L'),",",""),
            Score = stringr::str_replace(stringr::str_extract(.data$Result,'\\d{1,3}-\\d{1,3}'),",","")) %>%
          tidyr::separate("Score", into = c("WinnerScore", "LoserScore"), sep = "-") %>%
          dplyr::mutate(
            TeamScore = dplyr::case_when(
              .data$WL == "W" & .data$Record != "" ~ as.numeric(.data$WinnerScore),
              .data$WL == "L" & .data$Record != "" ~ as.numeric(.data$LoserScore),
              .data$WL == "" ~ NA_real_),
            OpponentScore = dplyr::case_when(
              .data$WL == "L" & .data$Record != "" ~ as.numeric(.data$WinnerScore),
              .data$WL == "W" & .data$Record != "" ~ as.numeric(.data$LoserScore),
              .data$WL == "" ~ NA_real_)) %>%
          tidyr::separate("Record", into = c("W", "L"), sep = "-") %>%
          dplyr::filter(.data$Location %in% c("Home", "Away", "Neutral",
                                              "Semi-Home","Semi-Away")) %>%
          dplyr::select(
            -"WinnerScore",
            -"LoserScore") %>%
          dplyr::mutate_at(c("Opponent.Rk", "Poss","TeamScore","OpponentScore"), as.numeric)
      )
      suppressWarnings(
        if (year >= 2011){
          sched <- sched %>%
            dplyr::mutate_at(c("Team.Rk"), as.numeric)
        }
      )

      sched <- sched %>%
        dplyr::mutate(
          Team = team,
          Year = year,
          PreWP = ifelse(stringr::str_detect(.data$OT, '%'),
                         as.numeric(stringr::str_extract(.data$OT, '\\d+'))/100, NA_real_),
          OT = dplyr::case_when(
            .data$OT == "&nbsp" ~ 0,
            .data$OT == "OT" ~ 1,
            stringr::str_detect(.data$OT, "OT") ~ as.numeric(stringr::str_extract(.data$OT,'\\d')),
            TRUE ~ NA_real_),
          ConferenceGame = ifelse(.data$Conference != "", TRUE, FALSE))

      suppressWarnings(
        sched <- sched %>%
          tidyr::separate("Conference",
                          into = c("W.Conference","L.Conference"), sep = "-") %>%
          dplyr::mutate(
            W.Conference = ifelse((.data$W.Conference == "\u00d7") | (.data$W.Conference == ""), NA_real_, .data$W.Conference)
          )
      )
      if (year >= 2011) {
        sched <- sched %>%
          dplyr::select(
            "Team.Rk",
            "Team",
            "Opponent.Rk",
            "Opponent",
            "Result",
            "Poss",
            "OT",
            "PreWP",
            "Location",
            "W",
            "L",
            "W.Conference",
            "L.Conference",
            "ConferenceGame",
            "Postseason",
            "Year",
            "Day.Date")
      } else {
        sched <- sched %>%
          dplyr::select(
            "Team",
            "Opponent.Rk",
            "Opponent",
            "Result",
            "Poss",
            "OT",
            "PreWP",
            "Location",
            "W",
            "L",
            "W.Conference",
            "L.Conference",
            "ConferenceGame",
            "Postseason",
            "Year",
            "Day.Date")
      }

      suppressWarnings(
        sched <- sched %>%
          dplyr::filter(!is.na(.data$Day.Date)) %>%
          dplyr::mutate_at(c("Opponent.Rk","Poss","W", "L",
                             "W.Conference","L.Conference"), as.numeric)
      )

      sched <- sched %>%
        dplyr::mutate(
          Date.DD = stringr::str_pad(stringr::str_extract(.data$Day.Date, '\\d+'), 2, pad = "0"),
          Date.MO = NA_character_,
          Date.MO = dplyr::case_when(
            stringr::str_detect(.data$Day.Date, regex("Oct",ignore_case = TRUE)) ~ "10",
            stringr::str_detect(.data$Day.Date, regex("Nov",ignore_case = TRUE)) ~ "11",
            stringr::str_detect(.data$Day.Date, regex("Dec",ignore_case = TRUE)) ~ "12",
            stringr::str_detect(.data$Day.Date, regex("Jan",ignore_case = TRUE)) ~ stringr::str_pad(1, 2, pad = "0"),
            stringr::str_detect(.data$Day.Date, regex("Feb",ignore_case = TRUE)) ~ stringr::str_pad(2, 2, pad = "0"),
            stringr::str_detect(.data$Day.Date, regex("Mar",ignore_case = TRUE)) ~ stringr::str_pad(3, 2, pad = "0"),
            stringr::str_detect(.data$Day.Date, regex("Apr",ignore_case = TRUE)) ~ stringr::str_pad(4, 2, pad = "0")),
          Date.YR = dplyr::case_when(
            stringr::str_detect(.data$Day.Date, regex("Oct",ignore_case = TRUE)) ~ as.character(year - 1L),
            stringr::str_detect(.data$Day.Date, regex("Nov",ignore_case = TRUE)) ~ as.character(year - 1L),
            stringr::str_detect(.data$Day.Date, regex("Dec",ignore_case = TRUE)) ~ as.character(year - 1L),
            stringr::str_detect(.data$Day.Date, regex("Jan",ignore_case = TRUE)) ~ as.character(year),
            stringr::str_detect(.data$Day.Date, regex("Feb",ignore_case = TRUE)) ~ as.character(year),
            stringr::str_detect(.data$Day.Date, regex("Mar",ignore_case = TRUE)) ~ as.character(year),
            stringr::str_detect(.data$Day.Date, regex("Apr",ignore_case = TRUE)) ~ as.character(year)),
          GameDate = as.numeric(paste0(.data$Date.YR, .data$Date.MO, .data$Date.DD)),
          W.Proj = round(cummax(ifelse(is.na(.data$W), 0, .data$W)) +
                           cumsum(ifelse(is.na(.data$PreWP), 0, .data$PreWP))),
          L.Proj = round(cummax(ifelse(is.na(.data$L), 0, .data$L)) +
                           cumsum(ifelse(is.na(.data$PreWP), 0, 1 - .data$PreWP))),
          W.ConferenceProj = round(cummax(ifelse(is.na(.data$W.Conference), 0, .data$W.Conference)) +
                                     cumsum(ifelse(.data$ConferenceGame == TRUE & !is.na(.data$PreWP), .data$PreWP, 0))),
          L.ConferenceProj = round(cummax(ifelse(is.na(.data$L.Conference), 0, .data$L.Conference)) +
                                     cumsum(ifelse(.data$ConferenceGame == TRUE & !is.na(.data$PreWP), 1 - .data$PreWP, 0)))) %>%
        dplyr::select(
          -"Date.DD",
          -"Date.MO",
          -"Date.YR")

      extractor <- function(x){
        data.frame(
          ifelse(
            is.null(rvest::html_element(x, xpath = "a")),
            NA_real_,
            rvest::html_element(x, xpath = "a") %>%
              rvest::html_attr("href")), stringsAsFactors = FALSE)
      }

      img_extractor <- function(x){
        data.frame(
          ifelse(
            is.null(rvest::html_element(x, css = "a > img")),
            NA_character_,
            toupper(stringr::str_trim(
              stringr::str_replace(
                stringr::str_extract(rvest::html_element(x, css = "a > img") %>%
                                       xml2::xml_attr("src"), "a.gif|b.gif"),
                ".gif","")))),
          stringsAsFactors = FALSE)
      }

      if (year >= 2011) {
        w_links <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.w > td:not(.label):nth-child(1)")

        l_links <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.l > td:not(.label):nth-child(1)")

        un_links <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.un > td:not(.label):nth-child(1)")

        fm_links <- c(w_links,l_links,un_links)

        w_box <- page %>%
          rvest::html_elements(css = "#schedule-table") %>%
          rvest::html_elements("tr.w > td:not(.label):nth-child(5)")
        l_box <- page %>%
          rvest::html_elements(css = "#schedule-table") %>%
          rvest::html_elements("tr.l > td:not(.label):nth-child(5)")
        un_box <- page %>%
          rvest::html_elements(css = "#schedule-table") %>%
          rvest::html_elements("tr.un > td:not(.label):nth-child(5)")

        box_links <- c(w_box, l_box, un_box)

        w_tier <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.w > td:not(.label):nth-child(11)")

        l_tier <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.l > td:not(.label):nth-child(11)")

        un_tier <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.un > td:not(.label):nth-child(11)")

        tiers <- c(w_tier, l_tier, un_tier)

      } else {
        w_links <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.w > td:not(.label):nth-child(1)")

        l_links <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.l > td:not(.label):nth-child(1)")

        un_links <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.un > td:not(.label):nth-child(1)")

        fm_links <- c(w_links,l_links, un_links)

        w_box <- page %>%
          rvest::html_elements(css = "#schedule-table") %>%
          rvest::html_elements("tr.w > td:not(.label):nth-child(4)")

        l_box <- page %>%
          rvest::html_elements(css = "#schedule-table") %>%
          rvest::html_elements("tr.l > td:not(.label):nth-child(4)")

        un_box <- page %>%
          rvest::html_elements(css = "#schedule-table") %>%
          rvest::html_elements("tr.un > td:not(.label):nth-child(4)")

        box_links <- c(w_box, l_box, un_box)

        w_tier <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.w > td:not(.label):nth-child(10)")

        l_tier <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.l > td:not(.label):nth-child(10)")

        un_tier <- page %>%
          rvest::html_elements(css = '#schedule-table') %>%
          rvest::html_elements("tr.un > td:not(.label):nth-child(10)")

        tiers <- c(w_tier, l_tier, un_tier)
      }

      day = dplyr::bind_rows(lapply(fm_links,
                                    function(x){
                                      data.frame(rvest::html_text(x),
                                                 stringsAsFactors = FALSE)}))

      colnames(day) <- "Day.Date"
      fm_links <- dplyr::bind_rows(lapply(fm_links, extractor))
      names(fm_links)[1] <- "fanmatch.link"
      tiers <- dplyr::bind_rows(lapply(tiers, img_extractor))
      names(tiers)[1] <- "TiersOfJoy"

      box_links <- dplyr::bind_rows(lapply(box_links, extractor))
      names(box_links)[1] <- "pregame.box"

      sched_links <- dplyr::bind_cols(tiers, fm_links,box_links, day)

      sched_links <- sched_links %>%
        dplyr::mutate(
          Date = stringr::str_remove(stringr::str_extract(.data$fanmatch.link, "=(.+)"), "="),
          GameId = as.numeric(stringr::str_remove(stringr::str_remove(
            stringi::stri_extract_first_regex(.data$pregame.box, "=(.+)"), "="), "&(.+)"))) %>%
        dplyr::select(
          "Date",
          "GameId",
          "TiersOfJoy",
          "Day.Date")

      ### Add Date and GameId back back to data frame
      sched <- dplyr::left_join(sched, sched_links, by = "Day.Date")

      ### Store Data
      kenpom <- sched %>%
        dplyr::arrange(.data$GameDate) %>%
        dplyr::mutate(Postseason = ifelse(is.na(.data$Postseason), "Regular", .data$Postseason)) %>%
        janitor::clean_names()

    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.Date()} - No team schedule tables available for {team} - {year}",
      args = .args
    ),
    warning = function(w){
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's team game plan page**
#'
#'
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a named list of tibbles: gameplan, correlations, position_distributions
#'
#'    **gameplan**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       date \tab Date \tab Date in YYYY-MM-DD format. \cr
#'       opponent_rk \tab numeric \tab Opponent rk. \cr
#'       opponent \tab character \tab Opponent. \cr
#'       result \tab character \tab Result. \cr
#'       location \tab character \tab Location. \cr
#'       pace \tab numeric \tab Possessions per 48 minutes. \cr
#'       off_eff \tab numeric \tab Off eff. \cr
#'       off_eff_rk \tab numeric \tab Off eff rk. \cr
#'       off_e_fg_pct \tab numeric \tab Off e field goals percentage (0-1 decimal). \cr
#'       off_to_pct \tab numeric \tab Off to percentage (0-1 decimal). \cr
#'       off_or_pct \tab numeric \tab Off or percentage (0-1 decimal). \cr
#'       off_ftr \tab numeric \tab Off ftr. \cr
#'       off_fgm_2 \tab numeric \tab Off fgm 2. \cr
#'       off_fga_2 \tab numeric \tab Off fga 2. \cr
#'       off_fg_2_pct \tab numeric \tab Off field goals 2 percentage (0-1 decimal). \cr
#'       off_fgm_3 \tab numeric \tab Off fgm 3. \cr
#'       off_fga_3 \tab numeric \tab Off fga 3. \cr
#'       off_fg_3_pct \tab numeric \tab Off field goals 3 percentage (0-1 decimal). \cr
#'       off_fg_3a_pct \tab numeric \tab Off field goals 3a percentage (0-1 decimal). \cr
#'       def_eff \tab numeric \tab Def eff. \cr
#'       def_eff_rk \tab numeric \tab Def eff rk. \cr
#'       def_e_fg_pct \tab numeric \tab Def e field goals percentage (0-1 decimal). \cr
#'       def_to_pct \tab numeric \tab Def to percentage (0-1 decimal). \cr
#'       def_or_pct \tab numeric \tab Def or percentage (0-1 decimal). \cr
#'       def_ftr \tab numeric \tab Def ftr. \cr
#'       def_fgm_2 \tab numeric \tab Def fgm 2. \cr
#'       def_fga_2 \tab numeric \tab Def fga 2. \cr
#'       def_fg_2_pct \tab numeric \tab Def field goals 2 percentage (0-1 decimal). \cr
#'       def_fgm_3 \tab numeric \tab Def fgm 3. \cr
#'       def_fga_3 \tab numeric \tab Def fga 3. \cr
#'       def_fg_3_pct \tab numeric \tab Def field goals 3 percentage (0-1 decimal). \cr
#'       def_fg_3a_pct \tab numeric \tab Def field goals 3a percentage (0-1 decimal). \cr
#'       wl \tab character \tab Wl. \cr
#'       team_score \tab numeric \tab Team's score / final score. \cr
#'       opponent_score \tab numeric \tab Opponent score. \cr
#'       day_date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       game_date \tab numeric \tab Game date (YYYY-MM-DD). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **correlations**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       correlations_r_x_100 \tab character \tab Correlations r x 100. \cr
#'       pace \tab character \tab Possessions per 48 minutes. \cr
#'       off_e_fg_pct \tab character \tab Off e field goals percentage (0-1 decimal). \cr
#'       off_to_pct \tab character \tab Off to percentage (0-1 decimal). \cr
#'       off_or_pct \tab character \tab Off or percentage (0-1 decimal). \cr
#'       off_ftr \tab character \tab Off ftr. \cr
#'       def_e_fg_pct \tab character \tab Def e field goals percentage (0-1 decimal). \cr
#'       def_to_pct \tab character \tab Def to percentage (0-1 decimal). \cr
#'       def_or_pct \tab character \tab Def or percentage (0-1 decimal). \cr
#'       def_ftr \tab character \tab Def ftr. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **position_distributions**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       category \tab character \tab Category label. \cr
#'       c_pct \tab numeric \tab C percentage (0-1 decimal). \cr
#'       pf_pct \tab numeric \tab Personal fouls percentage (0-1 decimal). \cr
#'       sf_pct \tab numeric \tab Sf percentage (0-1 decimal). \cr
#'       sg_pct \tab numeric \tab Sg percentage (0-1 decimal). \cr
#'       pg_pct \tab numeric \tab Pg percentage (0-1 decimal). \cr
#'       c_pct_rk \tab numeric \tab C pct rk. \cr
#'       pf_pct_rk \tab numeric \tab Pf pct rk. \cr
#'       sf_pct_rk \tab numeric \tab Sf pct rk. \cr
#'       sg_pct_rk \tab numeric \tab Sg pct rk. \cr
#'       pg_pct_rk \tab numeric \tab Pg pct rk. \cr
#'       c_pct_d1_avg \tab numeric \tab C pct d1 avg. \cr
#'       pf_pct_d1_avg \tab numeric \tab Pf pct d1 avg. \cr
#'       sf_pct_d1_avg \tab numeric \tab Sf pct d1 avg. \cr
#'       sg_pct_d1_avg \tab numeric \tab Sg pct d1 avg. \cr
#'       pg_pct_d1_avg \tab numeric \tab Pg pct d1 avg. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter select rename mutate case_when mutate_at bind_rows
#' @importFrom tidyr separate everything
#' @importFrom stringr str_trim str_extract str_remove str_replace str_detect
#' @import rvest
#' @export
#' @keywords Game Plan
#' @family KenPom Team Functions
#' @examples
#' \donttest{
#'    try(kp_gameplan(team='Florida St.', year=2021))
#' }

kp_gameplan <- function(team, year=2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2001)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2001")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]


      ### Pull Data
      url <- paste0("https://kenpom.com/gameplan.php?",
                    "team=", team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c("Date","Opponent.Rk",	"Opponent","Result","Location","Pace",
                       "Off.Eff", "Off.Eff.Rk", "Off.eFG.Pct",	"Off.TO.Pct",	"Off.OR.Pct", "Off.FTR",
                       "Off.FGM_2-A", "Off.FG_2.Pct", "Off.FGM_3-A",	"Off.FG_3.Pct",	"Off.FG_3A.Pct",
                       "Def.Eff", "Def.Eff.Rk", "Def.eFG.Pct",	"Def.TO.Pct",	"Def.OR.Pct", "Def.FTR",
                       "Def.FGM_2-A",	"Def.FG_2.Pct",	"Def.FGM_3-A", "Def.FG_3.Pct",	"Def.FG_3A.Pct")


      gp <- (page %>%
               rvest::html_elements(css = '#schedule-table'))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(gp) <- header_cols

      gp <- gp %>%
        dplyr::filter(.data$Location != "")
      suppressWarnings(
        gp <- gp %>%
          dplyr::mutate(
            WL = stringr::str_replace(stringr::str_extract(.data$Result,'W|L'),",",""),
            Score = stringr::str_replace(stringr::str_extract(.data$Result,'\\d{1,3}-\\d{1,3}'),",","")) %>%
          tidyr::separate("Score", into = c("WinnerScore", "LoserScore"), sep = "-") %>%
          dplyr::mutate(
            TeamScore = dplyr::case_when(
              .data$WL == "W"  ~ as.numeric(.data$WinnerScore),
              .data$WL == "L"  ~ as.numeric(.data$LoserScore),
              .data$WL == "" ~ NA_real_),
            OpponentScore = dplyr::case_when(
              .data$WL == "L" ~ as.numeric(.data$WinnerScore),
              .data$WL == "W" ~ as.numeric(.data$LoserScore),
              .data$WL == "" ~ NA_real_),
            Date.DD = stringr::str_pad(stringr::str_extract(.data$Date,'\\d+'), 2, pad = "0"),
            Date.MO = NA_character_,
            Date.MO = dplyr::case_when(
              stringr::str_detect(.data$Date, regex("Oct", ignore_case = TRUE)) ~ "10",
              stringr::str_detect(.data$Date, regex("Nov", ignore_case = TRUE)) ~ "11",
              stringr::str_detect(.data$Date, regex("Dec", ignore_case = TRUE)) ~ "12",
              stringr::str_detect(.data$Date, regex("Jan", ignore_case = TRUE)) ~ stringr::str_pad(1, 2, pad="0"),
              stringr::str_detect(.data$Date, regex("Feb", ignore_case = TRUE)) ~ stringr::str_pad(2, 2, pad="0"),
              stringr::str_detect(.data$Date, regex("Mar", ignore_case = TRUE)) ~ stringr::str_pad(3, 2, pad="0"),
              stringr::str_detect(.data$Date, regex("Apr", ignore_case = TRUE)) ~ stringr::str_pad(4, 2, pad="0")
            ),
            Date.YR = dplyr::case_when(
              stringr::str_detect(.data$Date, regex("Oct", ignore_case = TRUE)) ~ as.character(year - 1L),
              stringr::str_detect(.data$Date, regex("Nov", ignore_case = TRUE)) ~ as.character(year - 1L),
              stringr::str_detect(.data$Date, regex("Dec", ignore_case = TRUE)) ~ as.character(year - 1L),
              stringr::str_detect(.data$Date, regex("Jan", ignore_case = TRUE)) ~ as.character(year),
              stringr::str_detect(.data$Date, regex("Feb", ignore_case = TRUE)) ~ as.character(year),
              stringr::str_detect(.data$Date, regex("Mar", ignore_case = TRUE)) ~ as.character(year),
              stringr::str_detect(.data$Date, regex("Apr", ignore_case = TRUE)) ~ as.character(year)
            ),
            Day.Date = .data$Date,
            Date = as.Date(paste(.data$Date.YR, .data$Date.MO, .data$Date.DD, sep = "-")),
            GameDate = as.numeric(paste0(.data$Date.YR, .data$Date.MO, .data$Date.DD))) %>%
          dplyr::select(
            -"Date.DD",
            -"Date.MO",
            -"Date.YR")
      )
      cor <- gp[(nrow(gp) - 2):nrow(gp),]
      cor <- cor %>%
        dplyr::select(
          "Location",
          "Pace",
          "Off.eFG.Pct",
          "Off.TO.Pct",
          "Off.OR.Pct",
          "Off.FTR",
          "Def.eFG.Pct",
          "Def.TO.Pct",
          "Def.OR.Pct",
          "Def.FTR") %>%
        dplyr::rename("Correlations (R x 100)" = "Location")
      cor <- cor[2:3,] %>%
        janitor::clean_names()
      suppressWarnings(
        gp <- gp %>%
          dplyr::filter(!is.na(as.numeric(.data$Off.Eff))) %>%
          tidyr::separate("Off.FGM_2-A", into = c("Off.FGM_2","Off.FGA_2")) %>%
          tidyr::separate("Off.FGM_3-A", into = c("Off.FGM_3","Off.FGA_3")) %>%
          tidyr::separate("Def.FGM_2-A", into = c("Def.FGM_2","Def.FGA_2")) %>%
          tidyr::separate("Def.FGM_3-A", into = c("Def.FGM_3","Def.FGA_3")) %>%
          dplyr::mutate_at(c("Opponent.Rk", "Pace", "Off.Eff", "Off.Eff.Rk",
                             "Off.eFG.Pct",	"Off.TO.Pct",	"Off.OR.Pct", "Off.FTR",
                             "Off.FGM_2", "Off.FGA_2", "Off.FG_2.Pct",
                             "Off.FGM_3", "Off.FGA_3","Off.FG_3.Pct",	"Off.FG_3A.Pct",
                             "Def.Eff", "Def.Eff.Rk", "Def.eFG.Pct",	"Def.TO.Pct",
                             "Def.OR.Pct", "Def.FTR", "Def.FGM_2", "Def.FGA_2",
                             "Def.FG_2.Pct",	"Def.FGM_3", "Def.FGA_3",
                             "Def.FG_3.Pct",	"Def.FG_3A.Pct", "TeamScore","OpponentScore"), as.numeric)
      )
      ### Store Data
      gp <- gp %>%
        dplyr::select(
          -"WinnerScore",
          -"LoserScore") %>%
        janitor::clean_names()

      z <- data.frame()
      y <- page %>%
        rvest::html_elements(css = '.dist-table')
      if (length(y) > 0) {
        for (i in 1:length(y)) {
          header_cols <- c("Team","C.Pct","PF.Pct","SF.Pct","SG.Pct","PG.Pct")
          d <- (page %>%
                  rvest::html_elements(css = '.dist-table'))[[i]] %>%
            rvest::html_table() %>%
            as.data.frame()
          category <- colnames(d)[1]
          colnames(d) <- header_cols

          d$Category <- category

          d$C.Pct.Rk <- NA_real_
          d$PF.Pct.Rk <- NA_real_
          d$SF.Pct.Rk <- NA_real_
          d$SG.Pct.Rk <- NA_real_
          d$PG.Pct.Rk <- NA_real_
          suppressWarnings(
            d <- d %>%
              dplyr::mutate(
                C.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$C.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
                PF.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$PF.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
                SF.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$SF.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
                SG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$SG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
                PG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$PG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
                C.Pct = as.numeric(substr(sprintf("%.*f", 4, as.numeric(.data$C.Pct)), 1,
                                          nchar(sprintf("%.*f", 4, as.numeric(.data$C.Pct))) - 3)),
                PF.Pct = as.numeric(substr(sprintf("%.*f", 4, as.numeric(.data$PF.Pct)), 1,
                                           nchar(sprintf("%.*f", 4, as.numeric(.data$PF.Pct))) - 3)),
                SF.Pct = as.numeric(substr(sprintf("%.*f", 4, as.numeric(.data$SF.Pct)), 1,
                                           nchar(sprintf("%.*f", 4, as.numeric(.data$SF.Pct))) - 3)),
                SG.Pct = as.numeric(substr(sprintf("%.*f", 4, as.numeric(.data$SG.Pct)), 1,
                                           nchar(sprintf("%.*f", 4, as.numeric(.data$SG.Pct))) - 3)),
                PG.Pct = as.numeric(substr(sprintf("%.*f", 4, as.numeric(.data$PG.Pct)), 1,
                                           nchar(sprintf("%.*f", 4, as.numeric(.data$PG.Pct))) - 3)))
          )
          d$C.Pct.D1.Avg = as.numeric(d[3, "C.Pct"])
          d$PF.Pct.D1.Avg = as.numeric(d[3, "PF.Pct"])
          d$SF.Pct.D1.Avg = as.numeric(d[3, "SF.Pct"])
          d$SG.Pct.D1.Avg = as.numeric(d[3, "SG.Pct"])
          d$PG.Pct.D1.Avg = as.numeric(d[3, "PG.Pct"])
          d <- d %>%
            dplyr::filter(!is.na(.data$C.Pct.Rk)) %>%
            dplyr::select(
              "Team",
              "Category",
              tidyr::everything())

          z <- dplyr::bind_rows(z, d)

        }
      }
      z <- z %>%
        janitor::clean_names()
      kenpom <- c(list(gp),list(cor),list(z))
      names(kenpom) <- c("gameplan", "correlations", "position_distributions")

    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.Date()} - No Game Plan Points distribution tables available for {team} - {year}",
      args = .args
    ),
    warning = function(w){
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom's team opponent tracker page**
#'
#'
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a tibble of team opponent tracker data
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       date \tab Date \tab Date in YYYY-MM-DD format. \cr
#'       game_date \tab numeric \tab Game date (YYYY-MM-DD). \cr
#'       day_date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       wl \tab character \tab Wl. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       team_score \tab numeric \tab Team's score / final score. \cr
#'       opponent \tab character \tab Opponent. \cr
#'       opponent_score \tab numeric \tab Opponent score. \cr
#'       result \tab character \tab Result. \cr
#'       adj_oe \tab numeric \tab Adj oe. \cr
#'       adj_oe_rk \tab integer \tab Adj oe rk. \cr
#'       off_e_fg_pct \tab numeric \tab Off e field goals percentage (0-1 decimal). \cr
#'       off_e_fg_pct_rk \tab integer \tab Off e fg pct rk. \cr
#'       off_to_pct \tab numeric \tab Off to percentage (0-1 decimal). \cr
#'       off_to_pct_rk \tab integer \tab Off to pct rk. \cr
#'       off_or_pct \tab numeric \tab Off or percentage (0-1 decimal). \cr
#'       off_or_pct_rk \tab integer \tab Off or pct rk. \cr
#'       off_ft_rate \tab numeric \tab Off ft rate. \cr
#'       off_ft_rate_rk \tab integer \tab Off ft rate rk. \cr
#'       off_fg_2_pct \tab numeric \tab Off field goals 2 percentage (0-1 decimal). \cr
#'       off_fg_2_pct_rk \tab integer \tab Off fg 2 pct rk. \cr
#'       off_fg_3_pct \tab numeric \tab Off field goals 3 percentage (0-1 decimal). \cr
#'       off_fg_3_pct_rk \tab integer \tab Off fg 3 pct rk. \cr
#'       off_blk_pct \tab numeric \tab Off blocks percentage (0-1 decimal). \cr
#'       off_blk_pct_rk \tab integer \tab Off blk pct rk. \cr
#'       off_fg_3a_pct \tab numeric \tab Off field goals 3a percentage (0-1 decimal). \cr
#'       off_fg_3a_pct_rk \tab integer \tab Off fg 3a pct rk. \cr
#'       off_apl \tab numeric \tab Off apl. \cr
#'       off_apl_rk \tab integer \tab Off apl rk. \cr
#'       adj_de \tab numeric \tab Adj de. \cr
#'       adj_de_rk \tab integer \tab Adj de rk. \cr
#'       def_e_fg_pct \tab numeric \tab Def e field goals percentage (0-1 decimal). \cr
#'       def_e_fg_pct_rk \tab integer \tab Def e fg pct rk. \cr
#'       def_to_pct \tab numeric \tab Def to percentage (0-1 decimal). \cr
#'       def_to_pct_rk \tab integer \tab Def to pct rk. \cr
#'       def_or_pct \tab numeric \tab Def or percentage (0-1 decimal). \cr
#'       def_or_pct_rk \tab integer \tab Def or pct rk. \cr
#'       def_ft_rate \tab numeric \tab Def ft rate. \cr
#'       def_ft_rate_rk \tab integer \tab Def ft rate rk. \cr
#'       def_fg_2_pct \tab numeric \tab Def field goals 2 percentage (0-1 decimal). \cr
#'       def_fg_2_pct_rk \tab integer \tab Def fg 2 pct rk. \cr
#'       def_fg_3_pct \tab numeric \tab Def field goals 3 percentage (0-1 decimal). \cr
#'       def_fg_3_pct_rk \tab integer \tab Def fg 3 pct rk. \cr
#'       def_blk_pct \tab numeric \tab Def blocks percentage (0-1 decimal). \cr
#'       def_blk_pct_rk \tab integer \tab Def blk pct rk. \cr
#'       def_fg_3a_pct \tab numeric \tab Def field goals 3a percentage (0-1 decimal). \cr
#'       def_fg_3a_pct_rk \tab integer \tab Def fg 3a pct rk. \cr
#'       def_apl \tab numeric \tab Def apl. \cr
#'       def_apl_rk \tab integer \tab Def apl rk. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr filter
#' @import rvest
#' @export
#' @keywords Opponent Tracker
#' @family KenPom Team Functions
#'
#' @examples
#' \donttest{
#'   try(kp_opptracker(team = 'Florida St.', year = 2021))
#' }

kp_opptracker <- function(team, year = 2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2001)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2001")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]




      ### Pull Data
      url <- paste0("https://kenpom.com/opptracker.php?",
                    "team=", team_name,
                    "&y=", year,
                    "&t=o")

      page_o <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c("Date","Opponent","Result","AdjOE","AdjOE.Rk",
                       "Off.eFG.Pct","Off.eFG.Pct.Rk","Off.TO.Pct","Off.TO.Pct.Rk",
                       "Off.OR.Pct","Off.OR.Pct.Rk","Off.FTRate","Off.FTRate.Rk",
                       "Off.FG_2.Pct","Off.FG_2.Pct.Rk","Off.FG_3.Pct","Off.FG_3.Pct.Rk",
                       "Off.Blk.Pct","Off.Blk.Pct.Rk","Off.FG_3A.Pct","Off.FG_3A.Pct.Rk")
      if (year >= 2010) {
        header_cols <- c(header_cols, "Off.APL","Off.APL.Rk")
      }

      opptracker_o <- (page_o %>%
                         rvest::html_elements(css = '#conf-table'))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(opptracker_o) <- header_cols


      suppressWarnings(
        opptracker_o <- opptracker_o %>%
          dplyr::filter(!is.na(as.numeric(.data$Off.eFG.Pct)))
      )
      suppressWarnings(
        opptracker_o <- opptracker_o %>%
          dplyr::mutate(
            Team = team,
            WL = stringr::str_replace(stringr::str_extract(.data$Result,'W|L'),",",""),
            Score = stringr::str_replace(stringr::str_extract(.data$Result,'\\d{1,3}-\\d{1,3}'),",","")) %>%
          tidyr::separate("Score", into = c("WinnerScore", "LoserScore"), sep = "-") %>%
          dplyr::mutate(
            TeamScore = dplyr::case_when(
              .data$WL == "W"  ~ as.numeric(.data$WinnerScore),
              .data$WL == "L"  ~ as.numeric(.data$LoserScore),
              .data$WL == "" ~ NA_real_),
            OpponentScore = dplyr::case_when(
              .data$WL == "L" ~ as.numeric(.data$WinnerScore),
              .data$WL == "W" ~ as.numeric(.data$LoserScore),
              .data$WL == "" ~ NA_real_),
            Date.DD = stringr::str_pad(stringr::str_extract(.data$Date,'\\d+'), 2, pad = "0"),
            Date.MO = NA_character_,
            Date.MO = dplyr::case_when(
              stringr::str_detect(.data$Date, regex("Oct", ignore_case = TRUE)) ~ "10",
              stringr::str_detect(.data$Date, regex("Nov", ignore_case = TRUE)) ~ "11",
              stringr::str_detect(.data$Date, regex("Dec", ignore_case = TRUE)) ~ "12",
              stringr::str_detect(.data$Date, regex("Jan", ignore_case = TRUE)) ~ stringr::str_pad(1, 2, pad="0"),
              stringr::str_detect(.data$Date, regex("Feb", ignore_case = TRUE)) ~ stringr::str_pad(2, 2, pad="0"),
              stringr::str_detect(.data$Date, regex("Mar", ignore_case = TRUE)) ~ stringr::str_pad(3, 2, pad="0"),
              stringr::str_detect(.data$Date, regex("Apr", ignore_case = TRUE)) ~ stringr::str_pad(4, 2, pad="0")
            ),
            Date.YR = dplyr::case_when(
              stringr::str_detect(.data$Date, regex("Oct",ignore_case = TRUE)) ~ as.character(year - 1L),
              stringr::str_detect(.data$Date, regex("Nov",ignore_case = TRUE)) ~ as.character(year - 1L),
              stringr::str_detect(.data$Date, regex("Dec",ignore_case = TRUE)) ~ as.character(year - 1L),
              stringr::str_detect(.data$Date, regex("Jan",ignore_case = TRUE)) ~ as.character(year),
              stringr::str_detect(.data$Date, regex("Feb",ignore_case = TRUE)) ~ as.character(year),
              stringr::str_detect(.data$Date, regex("Mar",ignore_case = TRUE)) ~ as.character(year),
              stringr::str_detect(.data$Date, regex("Apr",ignore_case = TRUE)) ~ as.character(year)
            ),
            Day.Date = .data$Date,
            Date = as.Date(paste(.data$Date.YR, .data$Date.MO, .data$Date.DD, sep = "-")),
            GameDate = as.numeric(paste0(.data$Date.YR, .data$Date.MO, .data$Date.DD))) %>%
          dplyr::select(
            -"Date.DD",
            -"Date.MO",
            -"Date.YR",
            -"WinnerScore",
            -"LoserScore")
      )

      header_cols <- c("Date","Opponent","Result","AdjDE","AdjDE.Rk",
                       "Def.eFG.Pct","Def.eFG.Pct.Rk","Def.TO.Pct","Def.TO.Pct.Rk",
                       "Def.OR.Pct","Def.OR.Pct.Rk","Def.FTRate","Def.FTRate.Rk",
                       "Def.FG_2.Pct","Def.FG_2.Pct.Rk","Def.FG_3.Pct","Def.FG_3.Pct.Rk",
                       "Def.Blk.Pct","Def.Blk.Pct.Rk","Def.FG_3A.Pct","Def.FG_3A.Pct.Rk")

      if (year >= 2010) {
        header_cols <- c(header_cols, "Def.APL","Def.APL.Rk")
      }

      ### Pull Data
      url <- paste0("https://kenpom.com/opptracker.php?",
                    "team=", team_name,
                    "&y=", year,
                    "&t=d")

      page_d <- .kp_get_page(browser, url)
      Sys.sleep(5)
      opptracker_d <- (page_d %>%
                         rvest::html_elements(css = '#conf-table'))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(opptracker_d) <- header_cols

      suppressWarnings(
        opptracker_d <- opptracker_d %>%
          dplyr::filter(!is.na(as.numeric(.data$Def.eFG.Pct)))
      )
      opptracker <- dplyr::bind_cols(opptracker_o, opptracker_d[,4:ncol(opptracker_d)])
      ### Store Data
      kenpom <- opptracker %>%
        dplyr::select(
          "Date",
          "GameDate",
          "Day.Date",
          "WL",
          "Team",
          "TeamScore",
          "Opponent",
          "OpponentScore",
          tidyr::everything()) %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - {team} - {year} Team opponent tracker data is missing",
      args = .args
    ),
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}

#' **Get KenPom's player stats from the team page**
#'
#'
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a tibble of team player data
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       role \tab character \tab Role. \cr
#'       number \tab numeric \tab Number. \cr
#'       player \tab character \tab Player. \cr
#'       ht \tab character \tab Ht. \cr
#'       wt \tab numeric \tab Wt. \cr
#'       yr \tab character \tab Yr. \cr
#'       g \tab numeric \tab Games played. \cr
#'       s \tab numeric \tab S. \cr
#'       min_pct \tab numeric \tab Min percentage (0-1 decimal). \cr
#'       o_rtg \tab numeric \tab O rtg. \cr
#'       poss_pct \tab numeric \tab Poss percentage (0-1 decimal). \cr
#'       shots_pct \tab numeric \tab Shots percentage (0-1 decimal). \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       ts_pct \tab numeric \tab True shooting percentage (0-1). \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       dr_pct \tab numeric \tab Dr percentage (0-1 decimal). \cr
#'       a_rate \tab numeric \tab A rate. \cr
#'       to_rate \tab numeric \tab To rate. \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       f_cper40 \tab numeric \tab F cper40. \cr
#'       f_dper40 \tab numeric \tab F dper40. \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       ftm \tab numeric \tab Free throws made. \cr
#'       fta \tab numeric \tab Free throw attempts. \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       fgm_2 \tab numeric \tab Fgm 2. \cr
#'       fga_2 \tab numeric \tab Fga 2. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fgm_3 \tab numeric \tab Fgm 3. \cr
#'       fga_3 \tab numeric \tab Fga 3. \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       min_pct_rk \tab numeric \tab Min pct rk. \cr
#'       o_rtg_rk \tab numeric \tab O rtg rk. \cr
#'       poss_pct_rk \tab numeric \tab Poss pct rk. \cr
#'       shots_pct_rk \tab numeric \tab Shots pct rk. \cr
#'       e_fg_pct_rk \tab numeric \tab E fg pct rk. \cr
#'       ts_pct_rk \tab numeric \tab Ts pct rk. \cr
#'       or_pct_rk \tab numeric \tab Or pct rk. \cr
#'       dr_pct_rk \tab numeric \tab Dr pct rk. \cr
#'       a_rate_rk \tab numeric \tab A rate rk. \cr
#'       to_rate_rk \tab numeric \tab To rate rk. \cr
#'       blk_pct_rk \tab numeric \tab Blk pct rk. \cr
#'       stl_pct_rk \tab numeric \tab Stl pct rk. \cr
#'       f_cper40_rk \tab numeric \tab F cper40 rk. \cr
#'       f_dper40_rk \tab numeric \tab F dper40 rk. \cr
#'       ft_rate_rk \tab numeric \tab Ft rate rk. \cr
#'       ft_pct_rk \tab numeric \tab Ft pct rk. \cr
#'       fg_2_pct_rk \tab numeric \tab Fg 2 pct rk. \cr
#'       fg_3_pct_rk \tab numeric \tab Fg 3 pct rk. \cr
#'       national_rank \tab character \tab League/season rank for national. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       player_id \tab numeric \tab Unique player identifier. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select mutate filter case_when mutate_at bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect
#' @importFrom tidyr everything separate
#' @import rvest
#' @export
#' @keywords Team Player Stats
#' @family KenPom Team Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_team_players(team = 'Florida St.', year = 2024))
#'   }
#'

kp_team_players <- function(team, year = 2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2002)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2002")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]


      ### Pull Data
      url <- paste0("https://kenpom.com/team.php?",
                    "team=",team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      player_links <- page %>%
        rvest::html_elements(css = '#player-table') %>%
        rvest::html_elements("td:nth-child(2) > a")


      pid <- dplyr::bind_rows(lapply(xml2::xml_attrs(player_links),
                                     function(x){
                                       if (!stringr::str_detect(x,"kpoy")) {
                                         data.frame(as.list(x), stringsAsFactors = FALSE)
                                       }
                                     }))

      pid <- pid %>%
        dplyr::mutate(PlayerId = stringr::str_remove(stringr::str_extract(.data$href,"=(.+)"),"=")) %>%
        dplyr::select("PlayerId")

      if (year >= 2014) { # "S" - starts only available from 2014 onwards
        players_header_cols <- c("Number", "Player", "Ht", "Wt", "Yr", "G", "S",
                                 "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                                 "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                                 "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                                 "FTRate", "FTM-A", "FT.Pct",
                                 "FGM_2-A", "FG_2.Pct", "FGM_3-A", "FG_3.Pct")
      } else {
        players_header_cols <- c("Number", "Player", "Ht", "Wt", "Yr", "G",
                                 "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                                 "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                                 "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                                 "FTRate", "FTM-A", "FT.Pct",
                                 "FGM_2-A", "FG_2.Pct", "FGM_3-A", "FG_3.Pct")
      }

      players <- (page %>%
                    rvest::html_elements(css = '#player-table'))[[1]]

      players <- players %>%
        rvest::html_table()

      colnames(players) <- players_header_cols

      suppressWarnings(
        players <- players %>%
          dplyr::filter(!is.na(as.numeric(.data$G)))
      )
      players$Min.Pct.Rk <- NA_real_
      players$ORtg.Rk <- NA_real_
      players$Poss.Pct.Rk <- NA_real_
      players$Shots.Pct.Rk <- NA_real_
      players$eFG.Pct.Rk <- NA_real_
      players$TS.Pct.Rk <- NA_real_
      players$OR.Pct.Rk <- NA_real_
      players$DR.Pct.Rk <- NA_real_
      players$ARate.Rk <- NA_real_
      players$TORate.Rk <- NA_real_
      players$Blk.Pct.Rk <- NA_real_
      players$Stl.Pct.Rk <- NA_real_
      players$FCper40.Rk <- NA_real_
      players$FDper40.Rk <- NA_real_
      players$FTRate.Rk <- NA_real_
      players$FT.Pct.Rk <- NA_real_
      players$FG_2.Pct.Rk <- NA_real_
      players$FG_3.Pct.Rk <- NA_real_

      players <- players %>%
        dplyr::mutate(
          Min.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Min.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          ORtg.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$ORtg,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          Poss.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Poss.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          Shots.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Shots.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          eFG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$eFG.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          TS.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$TS.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          OR.Pct.Rk = stringr::str_replace(stringr::str_extract(.data$OR.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',""),
          DR.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$DR.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          ARate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$ARate,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          TORate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$TORate,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          Blk.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Blk.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          Stl.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Stl.Pct,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          FCper40.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FCper40,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          FDper40.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FDper40,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          FTRate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FTRate,'\\d{1,3}\\.\\d(.+)'),'(.+)\\.\\d',"")),
          FT.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FT.Pct,'\\.\\d{3}(.+)'),'\\.\\d{3}',"")),
          FG_2.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FG_2.Pct,'\\.\\d{3}(.+)'),'\\.\\d{3}',"")),
          FG_3.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FG_3.Pct,'\\.\\d{3}(.+)'),'\\.\\d{3}',"")),
          NationalRank = stringr::str_extract(.data$Player, "National Rank"),

          Player = stringr::str_replace(.data$Player, "National Rank",""),

          Min.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Min.Pct)), 1,
                           nchar(sprintf("%.*f",4, as.numeric(.data$Min.Pct))) - 3),
          ORtg = substr(sprintf("%.*f",4, as.numeric(.data$ORtg)), 1,
                        nchar(sprintf("%.*f",4, as.numeric(.data$ORtg))) - 3),
          Poss.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Poss.Pct)), 1,
                            nchar(sprintf("%.*f",4, as.numeric(.data$Poss.Pct))) - 3),
          Shots.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Shots.Pct)), 1,
                             nchar(sprintf("%.*f",4, as.numeric(.data$Shots.Pct))) - 3),
          eFG.Pct = substr(sprintf("%.*f",4, as.numeric(.data$eFG.Pct)), 1,
                           nchar(sprintf("%.*f",4, as.numeric(.data$eFG.Pct))) - 3),
          TS.Pct = substr(sprintf("%.*f",4, as.numeric(.data$TS.Pct)), 1,
                          nchar(sprintf("%.*f",4, as.numeric(.data$TS.Pct))) - 3),
          OR.Pct = substr(sprintf("%.*f",4, as.numeric(.data$OR.Pct)), 1,
                          nchar(sprintf("%.*f",4, as.numeric(.data$OR.Pct))) - 3),
          DR.Pct = substr(sprintf("%.*f",4, as.numeric(.data$ARate)), 1,
                          nchar(sprintf("%.*f",4, as.numeric(.data$DR.Pct))) - 3),
          ARate = substr(sprintf("%.*f",4, as.numeric(.data$ARate)), 1,
                         nchar(sprintf("%.*f",4, as.numeric(.data$ARate))) - 3),
          TORate = substr(sprintf("%.*f",4, as.numeric(.data$TORate)), 1,
                          nchar(sprintf("%.*f",4, as.numeric(.data$TORate))) - 3),
          Blk.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Blk.Pct)), 1,
                           nchar(sprintf("%.*f",4, as.numeric(.data$Blk.Pct))) - 3),
          Stl.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Stl.Pct)), 1,
                           nchar(sprintf("%.*f",4, as.numeric(.data$Stl.Pct))) - 3),
          FCper40 = substr(sprintf("%.*f",4, as.numeric(.data$FCper40)), 1,
                           nchar(sprintf("%.*f",4, as.numeric(.data$FCper40))) - 3),
          FDper40 = substr(sprintf("%.*f",4, as.numeric(.data$FDper40)), 1,
                           nchar(sprintf("%.*f",4, as.numeric(.data$FDper40))) - 3),
          FTRate = substr(sprintf("%.*f",4, as.numeric(.data$FTRate)), 1,
                          nchar(sprintf("%.*f",4, as.numeric(.data$FTRate))) - 3),
          FT.Pct = substr(sprintf("%.*f",6, as.numeric(.data$FT.Pct)), 1,
                          nchar(sprintf("%.*f",6, as.numeric(.data$FT.Pct))) - 3),
          FG_2.Pct = substr(sprintf("%.*f",6, as.numeric(.data$FG_2.Pct)), 1,
                            nchar(sprintf("%.*f",6, as.numeric(.data$FG_2.Pct))) - 3),
          FG_3.Pct = substr(sprintf("%.*f",6, as.numeric(.data$FG_3.Pct)), 1,
                            nchar(sprintf("%.*f",6, as.numeric(.data$FG_3.Pct))) - 3))
      if (year >= 2014) {
        suppressWarnings(
          players <- players %>%
            tidyr::separate("FTM-A", into = c("FTM", "FTA"), sep = "-") %>%
            tidyr::separate("FGM_2-A", into = c("FGM_2", "FGA_2"), sep = "-") %>%
            tidyr::separate("FGM_3-A", into = c("FGM_3", "FGA_3"), sep = "-") %>%
            dplyr::mutate_at(c("Number", "Wt", "G", "S",
                               "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                               "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                               "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                               "FTRate", "FTM", "FTA", "FT.Pct",
                               "FGM_2", "FGA_2", "FG_2.Pct", "FGM_3", "FGA_3", "FG_3.Pct",
                               "Min.Pct.Rk", "ORtg.Rk", "Poss.Pct.Rk", "Shots.Pct.Rk",
                               "eFG.Pct.Rk", "TS.Pct.Rk", "OR.Pct.Rk", "DR.Pct.Rk",
                               "ARate.Rk", "TORate.Rk", "Blk.Pct.Rk","Stl.Pct.Rk", "FCper40.Rk", "FDper40.Rk",
                               "FTRate.Rk", "FT.Pct.Rk", "FG_2.Pct.Rk", "FG_3.Pct.Rk"), as.numeric)
        )
      } else {
        suppressWarnings(
          players <- players %>%
            tidyr::separate("FTM-A", into = c("FTM", "FTA"), sep = "-") %>%
            tidyr::separate("FGM_2-A", into = c("FGM_2", "FGA_2"), sep = "-") %>%
            tidyr::separate("FGM_3-A", into = c("FGM_3", "FGA_3"), sep = "-") %>%
            dplyr::mutate_at(c("Number", "Wt", "G",
                               "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                               "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                               "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                               "FTRate", "FTM", "FTA", "FT.Pct",
                               "FGM_2", "FGA_2", "FG_2.Pct", "FGM_3", "FGA_3", "FG_3.Pct",
                               "Min.Pct.Rk", "ORtg.Rk", "Poss.Pct.Rk", "Shots.Pct.Rk",
                               "eFG.Pct.Rk", "TS.Pct.Rk", "OR.Pct.Rk", "DR.Pct.Rk",
                               "ARate.Rk", "TORate.Rk", "Blk.Pct.Rk","Stl.Pct.Rk", "FCper40.Rk", "FDper40.Rk",
                               "FTRate.Rk", "FT.Pct.Rk", "FG_2.Pct.Rk", "FG_3.Pct.Rk"), as.numeric)
        )
      }

      players <- players %>%
        dplyr::mutate(Team = team,
                      Year = year,
                      Role = dplyr::case_when(.data$Min.Pct < 10.0 ~ "Benchwarmer",
                                              .data$Poss.Pct < 12.0 ~ "Nearly Invisible",
                                              .data$Poss.Pct >= 12.0 & .data$Poss.Pct < 16.0 ~ "Limited Role",
                                              .data$Poss.Pct >= 16.0 & .data$Poss.Pct < 20.0 ~ "Role Player",
                                              .data$Poss.Pct >= 20.0 & .data$Poss.Pct < 24.0 ~ "Significant Contributor",
                                              .data$Poss.Pct >= 24.0 & .data$Poss.Pct < 28.0 ~ "Major Contributor",
                                              .data$Poss.Pct >= 28.0 ~ "Go-to Guys")) %>%
        dplyr::select(
          "Role",
          tidyr::everything()) %>%
        dplyr::bind_cols(lapply(pid, as.numeric))

      ### Store Data
      kenpom <- players %>%
        janitor::clean_names()
    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - No Player Data available for {team} in {year}",
      args = .args
    ),
    warning = function(w){

    },
    finally = {

    }
  )


  return(kenpom)
}

#' **Get KenPom's player career stats from the player page**
#'
#'
#' @rdname kp_team_schedule
#' @param player_id Player Id filter to select.
#' @return Returns a named list of tibbles: player_stats, gamelog
#'
#'    **player_stats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       team_rk \tab numeric \tab Team rk. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       number \tab numeric \tab Number. \cr
#'       name \tab character \tab Display name. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       hgt \tab character \tab Hgt. \cr
#'       wgt \tab numeric \tab Wgt. \cr
#'       yr \tab character \tab Yr. \cr
#'       g \tab numeric \tab Games played. \cr
#'       min_pct \tab numeric \tab Min percentage (0-1 decimal). \cr
#'       o_rtg \tab numeric \tab O rtg. \cr
#'       poss_pct \tab numeric \tab Poss percentage (0-1 decimal). \cr
#'       shots_pct \tab numeric \tab Shots percentage (0-1 decimal). \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       ts_pct \tab numeric \tab True shooting percentage (0-1). \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       dr_pct \tab numeric \tab Dr percentage (0-1 decimal). \cr
#'       a_rate \tab numeric \tab A rate. \cr
#'       to_rate \tab numeric \tab To rate. \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       f_cper40 \tab numeric \tab F cper40. \cr
#'       f_dper40 \tab numeric \tab F dper40. \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       ftm \tab numeric \tab Free throws made. \cr
#'       fta \tab numeric \tab Free throw attempts. \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       fgm_2 \tab numeric \tab Fgm 2. \cr
#'       fga_2 \tab numeric \tab Fga 2. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fgm_3 \tab numeric \tab Fgm 3. \cr
#'       fga_3 \tab numeric \tab Fga 3. \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       group_rank \tab character \tab League/season rank for group. \cr
#'       team_finish \tab character \tab Team finish. \cr
#'       ncaa_seed \tab numeric \tab Ncaa seed. \cr
#'       hometown \tab character \tab Player hometown. \cr
#'       date_of_birth \tab character \tab Date of birth (YYYY-MM-DD). \cr
#'       age \tab character \tab Player age (in years). \cr
#'       comparisons \tab character \tab Comparisons. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **gamelog**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       name \tab character \tab Display name. \cr
#'       position \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       opponent_tier \tab logical \tab Opponent tier. \cr
#'       date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       opponent_rk \tab numeric \tab Opponent rk. \cr
#'       opponent \tab character \tab Opponent. \cr
#'       result \tab character \tab Result. \cr
#'       ot \tab character \tab Ot. \cr
#'       location \tab character \tab Location. \cr
#'       game_type \tab character \tab Game type. \cr
#'       mvp \tab character \tab Mvp. \cr
#'       start \tab character \tab Start. \cr
#'       minutes_played \tab numeric \tab Minutes played. \cr
#'       o_rtg \tab numeric \tab O rtg. \cr
#'       poss_pct \tab numeric \tab Poss percentage (0-1 decimal). \cr
#'       pts \tab numeric \tab Points scored. \cr
#'       fgm_2 \tab numeric \tab Fgm 2. \cr
#'       fga_2 \tab numeric \tab Fga 2. \cr
#'       fgm_3 \tab numeric \tab Fgm 3. \cr
#'       fga_3 \tab numeric \tab Fga 3. \cr
#'       ftm \tab numeric \tab Free throws made. \cr
#'       fta \tab numeric \tab Free throw attempts. \cr
#'       or \tab numeric \tab Or. \cr
#'       dr \tab numeric \tab Dr. \cr
#'       a \tab numeric \tab A. \cr
#'       to \tab numeric \tab To. \cr
#'       blk \tab numeric \tab Blocks. \cr
#'       stl \tab numeric \tab Steals. \cr
#'       pf \tab numeric \tab Personal fouls. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select mutate filter case_when mutate_at bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect
#' @importFrom tidyr everything separate
#' @import rvest
#' @export
#' @keywords Player Career Stats
#' @family KenPom Team Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_player_career(player_id = '41180'))
#'   }
#'
kp_player_career <- function(player_id){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      ### Pull Data
      url <- paste0("https://kenpom.com/player.php?",
                    "p=",player_id)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      #--- Player Info ----
      player_info <- (page %>%
                        rvest::html_elements(css = 'span.name')) %>%
        rvest::html_text() %>%
        as.data.frame()
      colnames(player_info) <- "Player"
      player_town <- (page %>%
                        rvest::html_elements(css = 'span.town')) %>%
        rvest::html_text() %>%
        as.data.frame()
      colnames(player_town) <- "Num"
      player_town <- player_town %>%
        tidyr::separate("Num", into = c("Number", "Town", "DateOfBirth"), sep = "\u00b7")
      player_info <- dplyr::bind_cols(player_info, player_town)

      #--- Player Career Average Stats ----
      players_header_cols <- c("Year","Team","Hgt","Wgt","Yr","G","Min.Pct","ORtg",
                               "Poss.Pct","Shots.Pct","eFG.Pct","TS.Pct","OR.Pct",
                               "DR.Pct","ARate","TORate","Blk.Pct",
                               "Stl.Pct","FCper40","FDper40","FTRate",
                               "FTM-A","FT.Pct","FG_2M-A","FG_2.Pct","FG_3M-A",
                               "FG_3.Pct")
      players <- (page %>%
                    rvest::html_elements(css = '#player-table'))[[1]] %>%
        rvest::html_table()

      colnames(players) <- players_header_cols

      players <- players %>%
        dplyr::mutate(
          Position = gsub('[0-9]','',.data$Year),
          Year = gsub('[^0-9]','',.data$Year),
          GroupRank = stringr::str_extract(.data$Team,"National Rank|Conference Rank"),
          Team = stringr::str_trim(stringr::str_replace(.data$Team,"National Rank|Conference Rank", "")),
          Team.Finish = stringr::str_extract(.data$Team, stringr::regex('R1|R2|S16|E8|F4|2nd|CH',ignore_case = FALSE)),
          Team = stringr::str_replace(.data$Team, stringr::regex(' R1| R2| S16| E8| F4| 2nd| CH',ignore_case = FALSE),""),
          Team.Rk = gsub("[^0-9]", "",stringr::str_extract(.data$Team, stringr::regex('\\d{1,3}')))
        )

      # separating the career totals so as to not fill those columns (they're empty in the table)
      players_career <- players[(nrow(players) - 2):nrow(players),]
      players <- players[1:(nrow(players) - 3),]
      # Now need to fill year to create a join column for the age and player comps columns
      players <- players %>%
        dplyr::mutate(Year = ifelse(.data$Year == "", NA_real_, .data$Year)) %>%
        tidyr::fill("Year", .direction = c("down"))

      player_age <- players %>%
        dplyr::filter(stringr::str_detect(.data$Team,'Age:')) %>%
        dplyr::select(
          "Year",
          "Team",
          "Min.Pct") %>%
        dplyr::rename(
          "Age" = "Team",
          "Comparisons" = "Min.Pct") %>%
        dplyr::mutate(
          Age = stringr::str_replace(.data$Age, "Age: ", ""),
          Comparisons = stringr::str_replace(.data$Comparisons, "Similar: ", "")
        )

      players <- players %>%
        dplyr::filter(!(stringr::str_detect(.data$Team,'Age:')),
                      !(stringr::str_detect(.data$Min.Pct,'Similar'))) %>%
        dplyr::mutate(
          NCAASeed = stringr::str_extract(.data$Team, stringr::regex(' \\d{1,2}')))

      players <- dplyr::mutate(players,
                               "Team" = sapply(.data$Team, function(arg) {
                                 stringr::str_trim(stringr::str_replace(stringr::str_remove(arg,'\\d+| \\*| \\*+'),'\\d+|\\*+','')) }))


      players <- players %>%
        dplyr::mutate(
          Hgt = ifelse(.data$Hgt == "", NA_character_, .data$Hgt),
          Yr = ifelse(.data$Yr == "", NA_character_, .data$Yr),
          Position = ifelse(.data$Position == "", NA_character_, .data$Position),
          Name = player_info$Player,
          Number = player_info$Number,
          Hometown = player_info$Town,
          DateOfBirth = player_info$DateOfBirth) %>%
        tidyr::fill("Hgt", .direction = c("down")) %>%
        tidyr::fill("Wgt", .direction = c("down")) %>%
        tidyr::fill("Yr", .direction = c("down")) %>%
        tidyr::fill("Position", .direction = c("down")) %>%
        tidyr::fill("Team.Rk", .direction = c("down")) %>%
        dplyr::group_by(.data$Year) %>%
        tidyr::fill("Team.Finish", .direction = c("down")) %>%
        tidyr::fill("NCAASeed", .direction = c("down")) %>%
        dplyr::ungroup() %>%
        dplyr::bind_rows(players_career) %>%
        dplyr::left_join(player_age, by = c("Year"))

      suppressWarnings(
        players <- players %>%
          tidyr::separate("FTM-A", into = c("FTM", "FTA")) %>%
          tidyr::separate("FG_2M-A", into = c("FGM_2", "FGA_2")) %>%
          tidyr::separate("FG_3M-A", into = c("FGM_3", "FGA_3")) %>%
          dplyr::mutate_at(c("Year", "Wgt", "G", "Min.Pct",
                             "ORtg", "Poss.Pct", "Shots.Pct", "eFG.Pct",
                             "TS.Pct", "OR.Pct", "DR.Pct", "ARate",
                             "TORate", "Blk.Pct", "Stl.Pct", "FCper40",
                             "FDper40", "FTRate","FTM", "FTA", "FT.Pct",
                             "FGM_2", "FGA_2", "FG_2.Pct",
                             "FGM_3", "FGA_3", "FG_3.Pct",
                             "Team.Rk", "NCAASeed", "Number"), as.numeric)
      )

      players_team_name <- players %>%
        dplyr::filter(!(stringr::str_detect(.data$Team ,"Tier A|Conference|Career"))) %>%
        dplyr::select(
          "Year",
          "Team",
          "Name",
          "Position")

      img_extractor <- function(x){
        data.frame(
          ifelse(
            is.null(rvest::html_element(x, css = "a > img")),
            NA_character_,
            toupper(stringr::str_trim(
              stringr::str_replace(
                stringr::str_extract(rvest::html_element(x, css = "a > img") %>%
                                       xml2::xml_attr("src"), "a.gif|b.gif"),
                ".gif","")))),
          stringsAsFactors = FALSE)
      }
      players <- players %>%
        dplyr::select(
          "Year",
          "Team.Rk",
          "Team",
          "Number",
          "Name",
          "Position",
          tidyr::everything()) %>%
        janitor::clean_names()
      s <- (page %>%
              rvest::html_elements(css = '#schedule-table'))
      schedule_games <- data.frame()
      for (i in 1:length(s)) {

        header <- (page %>%
                     rvest::html_elements(css = 'div.gamelogdiv > h3'))[[i]] %>%
          rvest::html_text()
        sched_header_cols <- c("Opponent.Tier", "Date", "Opponent.Rk", "Opponent",
                               "Result","OT", "Location", "GameType",
                               "MVP", "Start", "MinutesPlayed", "ORtg", "Poss.Pct",
                               "Pts", "FG_2M-A", "FG_3M-A", "FTM-A",
                               "OR", "DR", "A", "TO", "Blk", "Stl", "PF")

        sched <-  ((page %>%
                      rvest::html_elements(css = '#schedule-table'))[[i]] %>%
                     rvest::html_table())[,1:24]

        colnames(sched) <- sched_header_cols
        rownames(sched) <- NULL
        sched <- sched %>% dplyr::filter(.data$Date != "")
        sched$GameData <- header
        sched <- sched %>%
          dplyr::mutate(Year = as.numeric(stringr::str_replace(.data$GameData," Game Data",""))) %>%
          dplyr::select(-"GameData")
        sched <- sched %>%
          dplyr::left_join(players_team_name, by = "Year")

        suppressWarnings(
          sched <- sched %>%
            tidyr::separate("FTM-A", into = c("FTM", "FTA")) %>%
            tidyr::separate("FG_2M-A", into = c("FGM_2", "FGA_2")) %>%
            tidyr::separate("FG_3M-A", into = c("FGM_3", "FGA_3")) %>%
            dplyr::mutate_at(c("Opponent.Rk","MinutesPlayed","ORtg","Poss.Pct",
                               "Pts","OR","DR","A","TO",
                               "FTM", "FTA","FGM_2", "FGA_2",
                               "FGM_3", "FGA_3",
                               "Blk","Stl","PF"), as.numeric)
        )
        sched <- sched %>%
          dplyr::select(
            "Year",
            "Team",
            "Name",
            "Position",
            tidyr::everything())
        schedule_games <- dplyr::bind_rows(schedule_games,sched)
      }
      schedule_games <- schedule_games %>%
        janitor::clean_names()
      ### Store Data
      kenpom <- c(list(players),list(schedule_games))
      names(kenpom) <- c("player_stats", "gamelog")
    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - No Player Career Data available for {player_id}",
      args = .args
    ),
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}
#' **Get Minutes Matrix from Expanded Player Page**
#'
#'
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a tibble of minutes matrix data
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr mutate filter
#' @import rvest
#' @export
#' @keywords Minutes Matrix
#' @family KenPom Team Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_minutes_matrix(team = 'Florida St.', year = 2021))
#'   }
#'
#'
kp_minutes_matrix <- function(team, year = 2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()

      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2014)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2014")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]


      ### Pull Data
      url <- paste0("https://kenpom.com/player-expanded.php?",
                    "team=",team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      header_cols <- c("Date","Opponent.Rk","Opponent","Result")

      x <- (page %>%
              rvest::html_elements(css = '#minutes-table'))[[1]] %>%
        rvest::html_table() %>%
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
      kenpom <- x %>%
        janitor::clean_names()

    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - {team} - {year} minutes matrix is missing",
      args = .args
    ),
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}


#' **Get Team Player Stats**
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @return Returns a list of named data frames: all_games, conference_games
#'
#'    **all_games**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       role \tab character \tab Role. \cr
#'       number \tab numeric \tab Number. \cr
#'       player \tab character \tab Player. \cr
#'       ht \tab character \tab Ht. \cr
#'       wt \tab numeric \tab Wt. \cr
#'       yr \tab character \tab Yr. \cr
#'       g \tab numeric \tab Games played. \cr
#'       min_pct \tab numeric \tab Min percentage (0-1 decimal). \cr
#'       o_rtg \tab numeric \tab O rtg. \cr
#'       poss_pct \tab numeric \tab Poss percentage (0-1 decimal). \cr
#'       shots_pct \tab numeric \tab Shots percentage (0-1 decimal). \cr
#'       e_fg_pct \tab numeric \tab E field goals percentage (0-1 decimal). \cr
#'       ts_pct \tab numeric \tab True shooting percentage (0-1). \cr
#'       or_pct \tab numeric \tab Or percentage (0-1 decimal). \cr
#'       dr_pct \tab numeric \tab Dr percentage (0-1 decimal). \cr
#'       a_rate \tab numeric \tab A rate. \cr
#'       to_rate \tab numeric \tab To rate. \cr
#'       blk_pct \tab numeric \tab Blocks percentage (0-1 decimal). \cr
#'       stl_pct \tab numeric \tab Steals percentage (0-1 decimal). \cr
#'       f_cper40 \tab numeric \tab F cper40. \cr
#'       f_dper40 \tab numeric \tab F dper40. \cr
#'       ft_rate \tab numeric \tab Ft rate. \cr
#'       ftm \tab numeric \tab Free throws made. \cr
#'       fta \tab numeric \tab Free throw attempts. \cr
#'       ft_pct \tab numeric \tab Free throw percentage (0-1). \cr
#'       fgm_2 \tab numeric \tab Fgm 2. \cr
#'       fga_2 \tab numeric \tab Fga 2. \cr
#'       fg_2_pct \tab numeric \tab Field goals 2 percentage (0-1 decimal). \cr
#'       fgm_3 \tab numeric \tab Fgm 3. \cr
#'       fga_3 \tab numeric \tab Fga 3. \cr
#'       fg_3_pct \tab numeric \tab Field goals 3 percentage (0-1 decimal). \cr
#'       category \tab character \tab Category label. \cr
#'       min_pct_rk \tab numeric \tab Min pct rk. \cr
#'       o_rtg_rk \tab numeric \tab O rtg rk. \cr
#'       poss_pct_rk \tab numeric \tab Poss pct rk. \cr
#'       shots_pct_rk \tab numeric \tab Shots pct rk. \cr
#'       e_fg_pct_rk \tab numeric \tab E fg pct rk. \cr
#'       ts_pct_rk \tab numeric \tab Ts pct rk. \cr
#'       or_pct_rk \tab numeric \tab Or pct rk. \cr
#'       dr_pct_rk \tab numeric \tab Dr pct rk. \cr
#'       a_rate_rk \tab numeric \tab A rate rk. \cr
#'       to_rate_rk \tab numeric \tab To rate rk. \cr
#'       blk_pct_rk \tab numeric \tab Blk pct rk. \cr
#'       stl_pct_rk \tab numeric \tab Stl pct rk. \cr
#'       f_cper40_rk \tab numeric \tab F cper40 rk. \cr
#'       f_dper40_rk \tab numeric \tab F dper40 rk. \cr
#'       ft_rate_rk \tab numeric \tab Ft rate rk. \cr
#'       ft_pct_rk \tab numeric \tab Ft pct rk. \cr
#'       fg_2_pct_rk \tab numeric \tab Fg 2 pct rk. \cr
#'       fg_3_pct_rk \tab numeric \tab Fg 3 pct rk. \cr
#'       group_rank \tab character \tab League/season rank for group. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       player_id \tab numeric \tab Unique player identifier. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **conference_games**
#'
#'
#'    Same columns as the **all_games** table above.
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select mutate filter case_when mutate_at bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect
#' @importFrom tidyr everything separate
#' @import rvest
#' @export
#' @keywords Team Player Stats
#' @family KenPom Team Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_team_player_stats(team = 'Florida St.', year = 2021))
#'   }
kp_team_player_stats <- function(team, year = 2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()

      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2014)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2014")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]




      ### Pull Data
      url <- paste0("https://kenpom.com/player-expanded.php?",
                    "team=",team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      players <- (page %>%
                    rvest::html_elements(css = '#player-table'))
      y <- list()

      for (i in 1:length(players)) {
        player_links <- (page %>%
                           rvest::html_elements(css = '#player-table'))[[i]] %>%
          rvest::html_elements("td:nth-child(2) > a")


        pid <- dplyr::bind_rows(lapply(xml2::xml_attrs(player_links),
                                       function(x){
                                         if (!stringr::str_detect(x,"kpoy")) {
                                           data.frame(as.list(x), stringsAsFactors = FALSE)
                                         }
                                       }))
        # pid <- dplyr::bind_rows(lapply(player_links, extractor))

        pid <- pid %>%
          dplyr::mutate(PlayerId = stringr::str_remove(stringr::str_extract(.data$href,"=(.+)"),"=")) %>%
          dplyr::select("PlayerId")

        players_header_cols <- c("Number", "Player", "Ht", "Wt", "Yr", "G",
                                 "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                                 "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                                 "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                                 "FTRate", "FTM-A", "FT.Pct",
                                 "FGM_2-A", "FG_2.Pct", "FGM_3-A", "FG_3.Pct")

        players <- (page %>%
                      rvest::html_elements(css = '#player-table'))[[i]]

        players <- players %>%
          rvest::html_table()

        colnames(players) <- players_header_cols
        suppressWarnings(
          players <- players %>%
            dplyr::filter(!is.na(as.numeric(.data$G)))
        )
        if (i == 1) {
          players$Category <- "All Games"
        } else {
          players$Category <- "Conference Games"
        }
        players$Min.Pct.Rk <- NA_real_
        players$ORtg.Rk <- NA_real_
        players$Poss.Pct.Rk <- NA_real_
        players$Shots.Pct.Rk <- NA_real_
        players$eFG.Pct.Rk <- NA_real_
        players$TS.Pct.Rk <- NA_real_
        players$OR.Pct.Rk <- NA_real_
        players$DR.Pct.Rk <- NA_real_
        players$ARate.Rk <- NA_real_
        players$TORate.Rk <- NA_real_
        players$Blk.Pct.Rk <- NA_real_
        players$Stl.Pct.Rk <- NA_real_
        players$FCper40.Rk <- NA_real_
        players$FDper40.Rk <- NA_real_
        players$FTRate.Rk <- NA_real_
        players$FT.Pct.Rk <- NA_real_
        players$FG_2.Pct.Rk <- NA_real_
        players$FG_3.Pct.Rk <- NA_real_

        players <- players %>%
          dplyr::mutate(
            Min.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Min.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            ORtg.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$ORtg, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            Poss.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Poss.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            Shots.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Shots.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            eFG.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$eFG.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            TS.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$TS.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            OR.Pct.Rk = stringr::str_replace(stringr::str_extract(.data$OR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', ""),
            DR.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$DR.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            ARate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$ARate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            TORate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$TORate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            Blk.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Blk.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            Stl.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$Stl.Pct, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            FCper40.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FCper40, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            FDper40.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FDper40, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            FTRate.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FTRate, '\\d{1,3}\\.\\d(.+)'), '(.+)\\.\\d', "")),
            FT.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FT.Pct, '\\.\\d{3}(.+)'), '\\.\\d{3}', "")),
            FG_2.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FG_2.Pct, '\\.\\d{3}(.+)'), '\\.\\d{3}', "")),
            FG_3.Pct.Rk = as.numeric(stringr::str_replace(stringr::str_extract(.data$FG_3.Pct, '\\.\\d{3}(.+)'), '\\.\\d{3}', "")),
            GroupRank = stringr::str_extract(.data$Player, "National Rank|Conference Rank"),
            Player = stringr::str_replace(.data$Player, "National Rank|Conference Rank",""),
            Min.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$Min.Pct)), 1,
                             nchar(sprintf("%.*f", 4, as.numeric(.data$Min.Pct))) - 3),
            ORtg = substr(sprintf("%.*f", 4, as.numeric(.data$ORtg)), 1,
                          nchar(sprintf("%.*f", 4, as.numeric(.data$ORtg))) - 3),
            Poss.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$Poss.Pct)), 1,
                              nchar(sprintf("%.*f",4, as.numeric(.data$Poss.Pct))) - 3),
            Shots.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Shots.Pct)), 1,
                               nchar(sprintf("%.*f",4, as.numeric(.data$Shots.Pct))) - 3),
            eFG.Pct = substr(sprintf("%.*f",4, as.numeric(.data$eFG.Pct)), 1,
                             nchar(sprintf("%.*f",4, as.numeric(.data$eFG.Pct))) - 3),
            TS.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$TS.Pct)), 1,
                            nchar(sprintf("%.*f", 4, as.numeric(.data$TS.Pct))) - 3),
            OR.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$OR.Pct)), 1,
                            nchar(sprintf("%.*f", 4, as.numeric(.data$OR.Pct))) - 3),
            DR.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$ARate)), 1,
                            nchar(sprintf("%.*f", 4, as.numeric(.data$DR.Pct))) - 3),
            ARate = substr(sprintf("%.*f", 4, as.numeric(.data$ARate)), 1,
                           nchar(sprintf("%.*f", 4, as.numeric(.data$ARate))) - 3),
            TORate = substr(sprintf("%.*f", 4, as.numeric(.data$TORate)), 1,
                            nchar(sprintf("%.*f", 4, as.numeric(.data$TORate))) - 3),
            Blk.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$Blk.Pct)), 1,
                             nchar(sprintf("%.*f", 4, as.numeric(.data$Blk.Pct))) - 3),
            Stl.Pct = substr(sprintf("%.*f", 4, as.numeric(.data$Stl.Pct)), 1,
                             nchar(sprintf("%.*f", 4, as.numeric(.data$Stl.Pct))) - 3),
            FCper40 = substr(sprintf("%.*f",4, as.numeric(.data$FCper40)), 1,
                             nchar(sprintf("%.*f", 4, as.numeric(.data$FCper40))) - 3),
            FDper40 = substr(sprintf("%.*f", 4, as.numeric(.data$FDper40)), 1,
                             nchar(sprintf("%.*f", 4, as.numeric(.data$FDper40))) - 3),
            FTRate = substr(sprintf("%.*f", 4, as.numeric(.data$FTRate)), 1,
                            nchar(sprintf("%.*f", 4, as.numeric(.data$FTRate))) - 3),
            FT.Pct = substr(sprintf("%.*f", 6, as.numeric(.data$FT.Pct)), 1,
                            nchar(sprintf("%.*f", 6, as.numeric(.data$FT.Pct))) - 3),
            FG_2.Pct = substr(sprintf("%.*f", 6, as.numeric(.data$FG_2.Pct)), 1,
                              nchar(sprintf("%.*f", 6, as.numeric(.data$FG_2.Pct))) - 3),
            FG_3.Pct = substr(sprintf("%.*f", 6, as.numeric(.data$FG_3.Pct)), 1,
                              nchar(sprintf("%.*f", 6, as.numeric(.data$FG_3.Pct))) - 3))

        suppressWarnings(
          players <- players %>%
            tidyr::separate("FTM-A", into = c("FTM", "FTA"), sep = "-") %>%
            tidyr::separate("FGM_2-A", into = c("FGM_2", "FGA_2"), sep = "-") %>%
            tidyr::separate("FGM_3-A", into = c("FGM_3", "FGA_3"), sep = "-") %>%
            dplyr::mutate_at(c("Number", "Wt", "G",
                               "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                               "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                               "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                               "FTRate", "FTM", "FTA", "FT.Pct",
                               "FGM_2", "FGA_2", "FG_2.Pct", "FGM_3", "FGA_3", "FG_3.Pct",
                               "Min.Pct.Rk", "ORtg.Rk", "Poss.Pct.Rk", "Shots.Pct.Rk",
                               "eFG.Pct.Rk", "TS.Pct.Rk", "OR.Pct.Rk", "DR.Pct.Rk",
                               "ARate.Rk", "TORate.Rk", "Blk.Pct.Rk","Stl.Pct.Rk", "FCper40.Rk", "FDper40.Rk",
                               "FTRate.Rk", "FT.Pct.Rk", "FG_2.Pct.Rk", "FG_3.Pct.Rk"), as.numeric)
        )

        players <- players %>%
          dplyr::mutate(Team = team,
                        Year = year,
                        Role = dplyr::case_when(.data$Min.Pct < 10.0 ~ "Benchwarmer",
                                                .data$Poss.Pct < 12.0 ~ "Nearly Invisible",
                                                .data$Poss.Pct >= 12.0 & .data$Poss.Pct < 16.0 ~ "Limited Role",
                                                .data$Poss.Pct >= 16.0 & .data$Poss.Pct < 20.0 ~ "Role Player",
                                                .data$Poss.Pct >= 20.0 & .data$Poss.Pct < 24.0 ~ "Significant Contributor",
                                                .data$Poss.Pct >= 24.0 & .data$Poss.Pct < 28.0 ~ "Major Contributor",
                                                .data$Poss.Pct >= 28.0 ~ "Go-to Guys")) %>%
          dplyr::select("Role", tidyr::everything()) %>%
          dplyr::bind_cols(lapply(pid, as.numeric)) %>%
          janitor::clean_names()

        y <- c(y, list(players))

      }
      ### Store Data
      kenpom <- y
      names(kenpom) <- c("all_games", "conference_games")
    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - {team} - {year} team player stats are missing",
      args = .args
    ),
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}


#' **Get Depth Chart Last 5 Games from Team Page**
#'
#'
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return A data frame with one row per rostered player, with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       player_id \tab integer \tab KenPom player identifier. \cr
#'       player_name \tab character \tab Player full name. \cr
#'       class_year \tab character \tab Class year (e.g. 'Fr', 'So', 'Jr', 'Sr'). \cr
#'       height \tab character \tab Height (e.g. '6-9'). \cr
#'       weight \tab numeric \tab Weight in pounds. \cr
#'       pct_pg \tab numeric \tab Percentage of the player's minutes played at point guard (0-1 decimal). \cr
#'       pct_sg \tab numeric \tab Percentage of the player's minutes played at shooting guard (0-1 decimal). \cr
#'       pct_sf \tab numeric \tab Percentage of the player's minutes played at small forward (0-1 decimal). \cr
#'       pct_pf \tab numeric \tab Percentage of the player's minutes played at power forward (0-1 decimal). \cr
#'       pct_c \tab numeric \tab Percentage of the player's minutes played at center (0-1 decimal). \cr
#'       pct_poss \tab numeric \tab Percentage of team possessions used while the player was on the floor (0-1 decimal). \cr
#'       fta \tab integer \tab Season free throw attempts. \cr
#'       fg2a \tab integer \tab Season 2-point field goal attempts. \cr
#'       fg3a \tab integer \tab Season 3-point field goal attempts. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select mutate filter rename
#' @importFrom stringr str_extract
#' @import rvest
#' @export
#' @keywords Depth Chart
#' @family KenPom Team Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_team_depth_chart(team = 'Florida St.', year= 2021))
#'   }
#'
#'

kp_team_depth_chart <- function(team, year= 2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()

      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2014)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2014")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]


      ### Pull Data
      url <- paste0("https://kenpom.com/team.php?",
                    "team=",team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)

      # KenPom removed the `#dc-table` depth chart table (#152); team.php
      # now renders an empty `<div id="depth-chart">` client-side from a
      # `const players = [...]` JSON array embedded in an inline <script>
      # tag. Extract that JSON directly rather than scraping rendered HTML.
      scripts <- page %>% rvest::html_elements("script") %>% rvest::html_text()
      players_script <- scripts[stringr::str_detect(scripts, "const players = ")]
      if (length(players_script) == 0) {
        cli::cli_abort("Could not find the depth chart player data on KenPom's team page -- the site layout may have changed again.")
      }
      players_json <- stringr::str_extract(players_script[[1]], "const players = (\\[.*?\\]);", group = 1)

      depth1 <- jsonlite::fromJSON(players_json) %>%
        dplyr::rename(
          player_id = "playerID",
          player_name = "Name",
          class_year = "Year",
          height = "Height",
          weight = "Weight"
        ) %>%
        dplyr::mutate(
          team = team,
          year = year,
          pct_pg = .data$PctPG / 100,
          pct_sg = .data$PctSG / 100,
          pct_sf = .data$PctSF / 100,
          pct_pf = .data$PctPF / 100,
          pct_c = .data$PctC / 100,
          pct_poss = .data$PctPoss / 100,
          fta = as.integer(.data$FTA),
          fg2a = as.integer(.data$FG2A),
          fg3a = as.integer(.data$FG3A)
        ) %>%
        dplyr::select(
          "team",
          "year",
          "player_id",
          "player_name",
          "class_year",
          "height",
          "weight",
          "pct_pg",
          "pct_sg",
          "pct_sf",
          "pct_pf",
          "pct_c",
          "pct_poss",
          "fta",
          "fg2a",
          "fg3a"
        )

      ### Store Data
      kenpom <- depth1
    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - {team} - {year} Team Depth Chart is missing",
      args = .args
    ),
    warning = function(w){
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get Lineups Last 5 Games from Team Page**
#'
#'
#' @rdname kp_team_schedule
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return A data frame with the following columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       min_pct \tab numeric \tab Min percentage (0-1 decimal). \cr
#'       pg_number \tab numeric \tab Pg number. \cr
#'       pg_player_first_name \tab character \tab Pg player first name. \cr
#'       pg_player_last_name \tab character \tab Pg player last name. \cr
#'       pg_hgt \tab character \tab Pg hgt. \cr
#'       pg_wgt \tab numeric \tab Pg wgt. \cr
#'       pg_yr \tab character \tab Pg yr. \cr
#'       sg_number \tab numeric \tab Sg number. \cr
#'       sg_player_first_name \tab character \tab Sg player first name. \cr
#'       sg_player_last_name \tab character \tab Sg player last name. \cr
#'       sg_hgt \tab character \tab Sg hgt. \cr
#'       sg_wgt \tab numeric \tab Sg wgt. \cr
#'       sg_yr \tab character \tab Sg yr. \cr
#'       sf_number \tab numeric \tab Sf number. \cr
#'       sf_player_first_name \tab character \tab Sf player first name. \cr
#'       sf_player_last_name \tab character \tab Sf player last name. \cr
#'       sf_hgt \tab character \tab Sf hgt. \cr
#'       sf_wgt \tab numeric \tab Sf wgt. \cr
#'       sf_yr \tab character \tab Sf yr. \cr
#'       pf_number \tab numeric \tab Pf number. \cr
#'       pf_player_first_name \tab character \tab Personal fouls player first name. \cr
#'       pf_player_last_name \tab character \tab Personal fouls player last name. \cr
#'       pf_hgt \tab character \tab Pf hgt. \cr
#'       pf_wgt \tab numeric \tab Pf wgt. \cr
#'       pf_yr \tab character \tab Pf yr. \cr
#'       c_number \tab numeric \tab C number. \cr
#'       c_player_first_name \tab character \tab C player first name. \cr
#'       c_player_last_name \tab character \tab C player last name. \cr
#'       c_hgt \tab character \tab C hgt. \cr
#'       c_wgt \tab numeric \tab C wgt. \cr
#'       c_yr \tab character \tab C yr. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select mutate filter
#' @importFrom stringr str_remove str_replace str_extract
#' @import rvest
#' @export
#' @keywords Depth Chart
#' @family KenPom Team Functions
#'
#' @examples
#'   \donttest{
#'     try(kp_team_lineups(team = 'Florida St.', year = 2021))
#'   }
#'

kp_team_lineups <- function(team, year=2021){
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()

      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2010)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
      }

      if (!(team %in% hoopR::teams_links$Team)) {
        cli::cli_abort("Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
      }
      teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
      team_name = teams_links$team.link.ref[teams_links$Team == team]


      ### Pull Data
      url <- paste0("https://kenpom.com/team.php?",
                    "team=",team_name,
                    "&y=", year)

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      depth2_header_cols <- c("Rk","PG", "SG", "SF",
                             "PF", "C", "Min.Pct")

      depth2 <- (page %>%
                  rvest::html_elements(css = '#dc-table2'))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(depth2) <- depth2_header_cols

      suppressWarnings(
        depth2 <- depth2 %>%
          dplyr::filter(!is.na(as.numeric(.data$Min.Pct)))
      )

      depth2 <- depth2 %>%
        dplyr::mutate(
          PG.Yr = substr(.data$PG, nchar(.data$PG) - 2, nchar(.data$PG)),
          PG = substr(.data$PG, 1, nchar(.data$PG) - 3),
          PG.Wgt = stringr::str_extract(.data$PG, '\\d{3}'),
          PG = stringr::str_trim(stringr::str_remove(.data$PG, '\\d{3}')),
          PG.Hgt = stringr::str_extract(.data$PG, '\\d{1}-\\d{0,2}'),
          PG = stringr::str_remove(.data$PG, '\\d{1}-\\d{0,2}'),
          SG.Yr = substr(.data$SG, nchar(.data$SG) - 2, nchar(.data$SG)),
          SG = substr(.data$SG, 1, nchar(.data$SG) - 3),
          SG.Wgt = stringr::str_extract(.data$SG, '\\d{3}'),
          SG = stringr::str_trim(stringr::str_remove(.data$SG, '\\d{3}')),
          SG.Hgt = stringr::str_extract(.data$SG, '\\d{1}-\\d{0,2}'),
          SG = stringr::str_remove(.data$SG, '\\d{1}-\\d{0,2}'),
          SF.Yr = substr(.data$SF, nchar(.data$SF) - 2, nchar(.data$SF)),
          SF = substr(.data$SF, 1, nchar(.data$SF) - 3),
          SF.Wgt = stringr::str_extract(.data$SF, '\\d{3}'),
          SF = stringr::str_trim(stringr::str_remove(.data$SF, '\\d{3}')),
          SF.Hgt = stringr::str_extract(.data$SF, '\\d{1}-\\d{0,2}'),
          SF = stringr::str_remove(.data$SF, '\\d{1}-\\d{0,2}'),
          PF.Yr = substr(.data$PF, nchar(.data$PF) - 2, nchar(.data$PF)),
          PF = substr(.data$PF, 1, nchar(.data$PF) - 3),
          PF.Wgt = stringr::str_extract(.data$PF, '\\d{3}'),
          PF = stringr::str_trim(stringr::str_remove(.data$PF, '\\d{3}')),
          PF.Hgt = stringr::str_extract(.data$PF, '\\d{1}-\\d{0,2}'),
          PF = stringr::str_remove(.data$PF, '\\d{1}-\\d{0,2}'),
          C.Yr = substr(.data$C, nchar(.data$C) - 2, nchar(.data$C)),
          C = substr(.data$C, 1, nchar(.data$C) - 3),
          C.Wgt = stringr::str_extract(.data$C, '\\d{3}'),
          C = stringr::str_trim(stringr::str_remove(.data$C, '\\d{3}')),
          C.Hgt = stringr::str_extract(.data$C, '\\d{1}-\\d{0,2}'),
          C = stringr::str_remove(.data$C, '\\d{1}-\\d{0,2}')
        )
      suppressWarnings(
        depth2 <- depth2 %>%
          tidyr::separate("PG", into = c("PG.Number", "PG.PlayerFirstName", "PG.PlayerLastName"), sep = "[^\\w']") %>%
          tidyr::separate("SG", into = c("SG.Number", "SG.PlayerFirstName", "SG.PlayerLastName"), sep = "[^\\w']") %>%
          tidyr::separate("SF", into = c("SF.Number", "SF.PlayerFirstName", "SF.PlayerLastName"), sep = "[^\\w']") %>%
          tidyr::separate("PF", into = c("PF.Number", "PF.PlayerFirstName", "PF.PlayerLastName"), sep = "[^\\w']") %>%
          tidyr::separate("C", into = c("C.Number", "C.PlayerFirstName", "C.PlayerLastName"), sep = "[^\\w']")
      )
      suppressWarnings(
        depth2 <- depth2 %>%
          dplyr::mutate(
            Min.Pct = as.numeric(stringr::str_replace(.data$Min.Pct, '%', ''))/100,
            PG.Number = as.numeric(.data$PG.Number),
            SG.Number = as.numeric(.data$SG.Number),
            SF.Number = as.numeric(.data$SF.Number),
            PF.Number = as.numeric(.data$PF.Number),
            C.Number = as.numeric(.data$C.Number),
            PG.Wgt = as.numeric(.data$PG.Wgt),
            SG.Wgt = as.numeric(.data$SG.Wgt),
            SF.Wgt = as.numeric(.data$SF.Wgt),
            PF.Wgt = as.numeric(.data$PF.Wgt),
            C.Wgt = as.numeric(.data$C.Wgt))
      )
      depth2 <- depth2 %>%
        dplyr::mutate(Team = team,
                      Year = year) %>%
        dplyr::select(
          "Year",
          "Team",
          "Min.Pct",
          "PG.Number",
          "PG.PlayerFirstName",
          "PG.PlayerLastName",
          "PG.Hgt",
          "PG.Wgt",
          "PG.Yr",
          "SG.Number",
          "SG.PlayerFirstName",
          "SG.PlayerLastName",
          "SG.Hgt",
          "SG.Wgt",
          "SG.Yr",
          "SF.Number",
          "SF.PlayerFirstName",
          "SF.PlayerLastName",
          "SF.Hgt",
          "SF.Wgt",
          "SF.Yr",
          "PF.Number",
          "PF.PlayerFirstName",
          "PF.PlayerLastName",
          "PF.Hgt",
          "PF.Wgt",
          "PF.Yr",
          "C.Number",
          "C.PlayerFirstName",
          "C.PlayerLastName",
          "C.Hgt",
          "C.Wgt",
          "C.Yr")

      ### Store Data
      depth2[nrow(depth2),"PG.PlayerFirstName"] <- "UNKNOWN"
      depth2[nrow(depth2),"C.Number"] <- NA_real_
      depth2[nrow(depth2),"C.Yr"] <- NA_real_
      kenpom <- depth2 %>%
        janitor::clean_names()

    },
    error = function(e) .report_api_error(
      e,
      hint = "{Sys.time()} - {team} - {year} Team Lineups are missing",
      args = .args
    ),
    warning = function(w){
    },
    finally = {
    }
  )
  return(kenpom)
}
