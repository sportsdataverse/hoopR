#' **Get team schedule results**
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @return Returns a tibble of team schedules
#'
#'    |col_name          |types     |description                         |
#'    |:-----------------|:---------|:-----------------------------------|
#'    |team_rk           |numeric   |Team rk.                            |
#'    |team              |character |Team-side label or team identifier. |
#'    |opponent_rk       |numeric   |Opponent rk.                        |
#'    |opponent          |character |Opponent.                           |
#'    |result            |character |Result.                             |
#'    |poss              |numeric   |Poss.                               |
#'    |ot                |numeric   |Ot.                                 |
#'    |pre_wp            |numeric   |Pre wp.                             |
#'    |location          |character |Location.                           |
#'    |w                 |numeric   |Wins.                               |
#'    |l                 |numeric   |Losses.                             |
#'    |w_conference      |numeric   |W conference.                       |
#'    |l_conference      |numeric   |L conference.                       |
#'    |conference_game   |logical   |Conference game.                    |
#'    |postseason        |character |Postseason.                         |
#'    |year              |numeric   |4-digit year.                       |
#'    |day_date          |character |Date in YYYY-MM-DD format.          |
#'    |game_date         |numeric   |Game date (YYYY-MM-DD).             |
#'    |w_proj            |numeric   |W proj.                             |
#'    |l_proj            |numeric   |L proj.                             |
#'    |w_conference_proj |numeric   |W conference proj.                  |
#'    |l_conference_proj |numeric   |L conference proj.                  |
#'    |date              |character |Date in YYYY-MM-DD format.          |
#'    |game_id           |numeric   |Unique game identifier.             |
#'    |tiers_of_joy      |character |Tiers of joy.                       |
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
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a named list of tibbles: gameplan, correlations, position_distributions
#'
#'    **gameplan**
#'
#'
#'    |col_name       |types     |description                                  |
#'    |:--------------|:---------|:--------------------------------------------|
#'    |date           |Date      |Date in YYYY-MM-DD format.                   |
#'    |opponent_rk    |numeric   |Opponent rk.                                 |
#'    |opponent       |character |Opponent.                                    |
#'    |result         |character |Result.                                      |
#'    |location       |character |Location.                                    |
#'    |pace           |numeric   |Possessions per 48 minutes.                  |
#'    |off_eff        |numeric   |Off eff.                                     |
#'    |off_eff_rk     |numeric   |Off eff rk.                                  |
#'    |off_e_fg_pct   |numeric   |Off e field goals percentage (0-1 decimal).  |
#'    |off_to_pct     |numeric   |Off to percentage (0-1 decimal).             |
#'    |off_or_pct     |numeric   |Off or percentage (0-1 decimal).             |
#'    |off_ftr        |numeric   |Off ftr.                                     |
#'    |off_fgm_2      |numeric   |Off fgm 2.                                   |
#'    |off_fga_2      |numeric   |Off fga 2.                                   |
#'    |off_fg_2_pct   |numeric   |Off field goals 2 percentage (0-1 decimal).  |
#'    |off_fgm_3      |numeric   |Off fgm 3.                                   |
#'    |off_fga_3      |numeric   |Off fga 3.                                   |
#'    |off_fg_3_pct   |numeric   |Off field goals 3 percentage (0-1 decimal).  |
#'    |off_fg_3a_pct  |numeric   |Off field goals 3a percentage (0-1 decimal). |
#'    |def_eff        |numeric   |Def eff.                                     |
#'    |def_eff_rk     |numeric   |Def eff rk.                                  |
#'    |def_e_fg_pct   |numeric   |Def e field goals percentage (0-1 decimal).  |
#'    |def_to_pct     |numeric   |Def to percentage (0-1 decimal).             |
#'    |def_or_pct     |numeric   |Def or percentage (0-1 decimal).             |
#'    |def_ftr        |numeric   |Def ftr.                                     |
#'    |def_fgm_2      |numeric   |Def fgm 2.                                   |
#'    |def_fga_2      |numeric   |Def fga 2.                                   |
#'    |def_fg_2_pct   |numeric   |Def field goals 2 percentage (0-1 decimal).  |
#'    |def_fgm_3      |numeric   |Def fgm 3.                                   |
#'    |def_fga_3      |numeric   |Def fga 3.                                   |
#'    |def_fg_3_pct   |numeric   |Def field goals 3 percentage (0-1 decimal).  |
#'    |def_fg_3a_pct  |numeric   |Def field goals 3a percentage (0-1 decimal). |
#'    |wl             |character |Wl.                                          |
#'    |team_score     |numeric   |Team's score / final score.                  |
#'    |opponent_score |numeric   |Opponent score.                              |
#'    |day_date       |character |Date in YYYY-MM-DD format.                   |
#'    |game_date      |numeric   |Game date (YYYY-MM-DD).                      |
#'
#'    **correlations**
#'
#'
#'    |col_name             |types     |description                                 |
#'    |:--------------------|:---------|:-------------------------------------------|
#'    |correlations_r_x_100 |character |Correlations r x 100.                       |
#'    |pace                 |character |Possessions per 48 minutes.                 |
#'    |off_e_fg_pct         |character |Off e field goals percentage (0-1 decimal). |
#'    |off_to_pct           |character |Off to percentage (0-1 decimal).            |
#'    |off_or_pct           |character |Off or percentage (0-1 decimal).            |
#'    |off_ftr              |character |Off ftr.                                    |
#'    |def_e_fg_pct         |character |Def e field goals percentage (0-1 decimal). |
#'    |def_to_pct           |character |Def to percentage (0-1 decimal).            |
#'    |def_or_pct           |character |Def or percentage (0-1 decimal).            |
#'    |def_ftr              |character |Def ftr.                                    |
#'
#'    **position_distributions**
#'
#'
#'    |col_name      |types     |description                              |
#'    |:-------------|:---------|:----------------------------------------|
#'    |team          |character |Team-side label or team identifier.      |
#'    |category      |character |Category label.                          |
#'    |c_pct         |numeric   |C percentage (0-1 decimal).              |
#'    |pf_pct        |numeric   |Personal fouls percentage (0-1 decimal). |
#'    |sf_pct        |numeric   |Sf percentage (0-1 decimal).             |
#'    |sg_pct        |numeric   |Sg percentage (0-1 decimal).             |
#'    |pg_pct        |numeric   |Pg percentage (0-1 decimal).             |
#'    |c_pct_rk      |numeric   |C pct rk.                                |
#'    |pf_pct_rk     |numeric   |Pf pct rk.                               |
#'    |sf_pct_rk     |numeric   |Sf pct rk.                               |
#'    |sg_pct_rk     |numeric   |Sg pct rk.                               |
#'    |pg_pct_rk     |numeric   |Pg pct rk.                               |
#'    |c_pct_d1_avg  |numeric   |C pct d1 avg.                            |
#'    |pf_pct_d1_avg |numeric   |Pf pct d1 avg.                           |
#'    |sf_pct_d1_avg |numeric   |Sf pct d1 avg.                           |
#'    |sg_pct_d1_avg |numeric   |Sg pct d1 avg.                           |
#'    |pg_pct_d1_avg |numeric   |Pg pct d1 avg.                           |
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
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a tibble of team opponent tracker data
#'
#'    |col_name         |types     |description                                  |
#'    |:----------------|:---------|:--------------------------------------------|
#'    |date             |Date      |Date in YYYY-MM-DD format.                   |
#'    |game_date        |numeric   |Game date (YYYY-MM-DD).                      |
#'    |day_date         |character |Date in YYYY-MM-DD format.                   |
#'    |wl               |character |Wl.                                          |
#'    |team             |character |Team-side label or team identifier.          |
#'    |team_score       |numeric   |Team's score / final score.                  |
#'    |opponent         |character |Opponent.                                    |
#'    |opponent_score   |numeric   |Opponent score.                              |
#'    |result           |character |Result.                                      |
#'    |adj_oe           |numeric   |Adj oe.                                      |
#'    |adj_oe_rk        |integer   |Adj oe rk.                                   |
#'    |off_e_fg_pct     |numeric   |Off e field goals percentage (0-1 decimal).  |
#'    |off_e_fg_pct_rk  |integer   |Off e fg pct rk.                             |
#'    |off_to_pct       |numeric   |Off to percentage (0-1 decimal).             |
#'    |off_to_pct_rk    |integer   |Off to pct rk.                               |
#'    |off_or_pct       |numeric   |Off or percentage (0-1 decimal).             |
#'    |off_or_pct_rk    |integer   |Off or pct rk.                               |
#'    |off_ft_rate      |numeric   |Off ft rate.                                 |
#'    |off_ft_rate_rk   |integer   |Off ft rate rk.                              |
#'    |off_fg_2_pct     |numeric   |Off field goals 2 percentage (0-1 decimal).  |
#'    |off_fg_2_pct_rk  |integer   |Off fg 2 pct rk.                             |
#'    |off_fg_3_pct     |numeric   |Off field goals 3 percentage (0-1 decimal).  |
#'    |off_fg_3_pct_rk  |integer   |Off fg 3 pct rk.                             |
#'    |off_blk_pct      |numeric   |Off blocks percentage (0-1 decimal).         |
#'    |off_blk_pct_rk   |integer   |Off blk pct rk.                              |
#'    |off_fg_3a_pct    |numeric   |Off field goals 3a percentage (0-1 decimal). |
#'    |off_fg_3a_pct_rk |integer   |Off fg 3a pct rk.                            |
#'    |off_apl          |numeric   |Off apl.                                     |
#'    |off_apl_rk       |integer   |Off apl rk.                                  |
#'    |adj_de           |numeric   |Adj de.                                      |
#'    |adj_de_rk        |integer   |Adj de rk.                                   |
#'    |def_e_fg_pct     |numeric   |Def e field goals percentage (0-1 decimal).  |
#'    |def_e_fg_pct_rk  |integer   |Def e fg pct rk.                             |
#'    |def_to_pct       |numeric   |Def to percentage (0-1 decimal).             |
#'    |def_to_pct_rk    |integer   |Def to pct rk.                               |
#'    |def_or_pct       |numeric   |Def or percentage (0-1 decimal).             |
#'    |def_or_pct_rk    |integer   |Def or pct rk.                               |
#'    |def_ft_rate      |numeric   |Def ft rate.                                 |
#'    |def_ft_rate_rk   |integer   |Def ft rate rk.                              |
#'    |def_fg_2_pct     |numeric   |Def field goals 2 percentage (0-1 decimal).  |
#'    |def_fg_2_pct_rk  |integer   |Def fg 2 pct rk.                             |
#'    |def_fg_3_pct     |numeric   |Def field goals 3 percentage (0-1 decimal).  |
#'    |def_fg_3_pct_rk  |integer   |Def fg 3 pct rk.                             |
#'    |def_blk_pct      |numeric   |Def blocks percentage (0-1 decimal).         |
#'    |def_blk_pct_rk   |integer   |Def blk pct rk.                              |
#'    |def_fg_3a_pct    |numeric   |Def field goals 3a percentage (0-1 decimal). |
#'    |def_fg_3a_pct_rk |integer   |Def fg 3a pct rk.                            |
#'    |def_apl          |numeric   |Def apl.                                     |
#'    |def_apl_rk       |integer   |Def apl rk.                                  |
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
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return Returns a tibble of team player data
#'
#'    |col_name      |types     |description                             |
#'    |:-------------|:---------|:---------------------------------------|
#'    |role          |character |Role.                                   |
#'    |number        |numeric   |Number.                                 |
#'    |player        |character |Player.                                 |
#'    |ht            |character |Ht.                                     |
#'    |wt            |numeric   |Wt.                                     |
#'    |yr            |character |Yr.                                     |
#'    |g             |numeric   |Games played.                           |
#'    |s             |numeric   |S.                                      |
#'    |min_pct       |numeric   |Min percentage (0-1 decimal).           |
#'    |o_rtg         |numeric   |O rtg.                                  |
#'    |poss_pct      |numeric   |Poss percentage (0-1 decimal).          |
#'    |shots_pct     |numeric   |Shots percentage (0-1 decimal).         |
#'    |e_fg_pct      |numeric   |E field goals percentage (0-1 decimal). |
#'    |ts_pct        |numeric   |True shooting percentage (0-1).         |
#'    |or_pct        |numeric   |Or percentage (0-1 decimal).            |
#'    |dr_pct        |numeric   |Dr percentage (0-1 decimal).            |
#'    |a_rate        |numeric   |A rate.                                 |
#'    |to_rate       |numeric   |To rate.                                |
#'    |blk_pct       |numeric   |Blocks percentage (0-1 decimal).        |
#'    |stl_pct       |numeric   |Steals percentage (0-1 decimal).        |
#'    |f_cper40      |numeric   |F cper40.                               |
#'    |f_dper40      |numeric   |F dper40.                               |
#'    |ft_rate       |numeric   |Ft rate.                                |
#'    |ftm           |numeric   |Free throws made.                       |
#'    |fta           |numeric   |Free throw attempts.                    |
#'    |ft_pct        |numeric   |Free throw percentage (0-1).            |
#'    |fgm_2         |numeric   |Fgm 2.                                  |
#'    |fga_2         |numeric   |Fga 2.                                  |
#'    |fg_2_pct      |numeric   |Field goals 2 percentage (0-1 decimal). |
#'    |fgm_3         |numeric   |Fgm 3.                                  |
#'    |fga_3         |numeric   |Fga 3.                                  |
#'    |fg_3_pct      |numeric   |Field goals 3 percentage (0-1 decimal). |
#'    |min_pct_rk    |numeric   |Min pct rk.                             |
#'    |o_rtg_rk      |numeric   |O rtg rk.                               |
#'    |poss_pct_rk   |numeric   |Poss pct rk.                            |
#'    |shots_pct_rk  |numeric   |Shots pct rk.                           |
#'    |e_fg_pct_rk   |numeric   |E fg pct rk.                            |
#'    |ts_pct_rk     |numeric   |Ts pct rk.                              |
#'    |or_pct_rk     |numeric   |Or pct rk.                              |
#'    |dr_pct_rk     |numeric   |Dr pct rk.                              |
#'    |a_rate_rk     |numeric   |A rate rk.                              |
#'    |to_rate_rk    |numeric   |To rate rk.                             |
#'    |blk_pct_rk    |numeric   |Blk pct rk.                             |
#'    |stl_pct_rk    |numeric   |Stl pct rk.                             |
#'    |f_cper40_rk   |numeric   |F cper40 rk.                            |
#'    |f_dper40_rk   |numeric   |F dper40 rk.                            |
#'    |ft_rate_rk    |numeric   |Ft rate rk.                             |
#'    |ft_pct_rk     |numeric   |Ft pct rk.                              |
#'    |fg_2_pct_rk   |numeric   |Fg 2 pct rk.                            |
#'    |fg_3_pct_rk   |numeric   |Fg 3 pct rk.                            |
#'    |national_rank |character |League/season rank for national.        |
#'    |team          |character |Team-side label or team identifier.     |
#'    |year          |numeric   |4-digit year.                           |
#'    |player_id     |numeric   |Unique player identifier.               |
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
#' @param player_id Player Id filter to select.
#' @return Returns a named list of tibbles: player_stats, gamelog
#'
#'    **player_stats**
#'
#'
#'    |col_name      |types     |description                             |
#'    |:-------------|:---------|:---------------------------------------|
#'    |year          |numeric   |4-digit year.                           |
#'    |team_rk       |numeric   |Team rk.                                |
#'    |team          |character |Team-side label or team identifier.     |
#'    |number        |numeric   |Number.                                 |
#'    |name          |character |Display name.                           |
#'    |position      |character |Listed roster position (G, F, C, etc.). |
#'    |hgt           |character |Hgt.                                    |
#'    |wgt           |numeric   |Wgt.                                    |
#'    |yr            |character |Yr.                                     |
#'    |g             |numeric   |Games played.                           |
#'    |min_pct       |numeric   |Min percentage (0-1 decimal).           |
#'    |o_rtg         |numeric   |O rtg.                                  |
#'    |poss_pct      |numeric   |Poss percentage (0-1 decimal).          |
#'    |shots_pct     |numeric   |Shots percentage (0-1 decimal).         |
#'    |e_fg_pct      |numeric   |E field goals percentage (0-1 decimal). |
#'    |ts_pct        |numeric   |True shooting percentage (0-1).         |
#'    |or_pct        |numeric   |Or percentage (0-1 decimal).            |
#'    |dr_pct        |numeric   |Dr percentage (0-1 decimal).            |
#'    |a_rate        |numeric   |A rate.                                 |
#'    |to_rate       |numeric   |To rate.                                |
#'    |blk_pct       |numeric   |Blocks percentage (0-1 decimal).        |
#'    |stl_pct       |numeric   |Steals percentage (0-1 decimal).        |
#'    |f_cper40      |numeric   |F cper40.                               |
#'    |f_dper40      |numeric   |F dper40.                               |
#'    |ft_rate       |numeric   |Ft rate.                                |
#'    |ftm           |numeric   |Free throws made.                       |
#'    |fta           |numeric   |Free throw attempts.                    |
#'    |ft_pct        |numeric   |Free throw percentage (0-1).            |
#'    |fgm_2         |numeric   |Fgm 2.                                  |
#'    |fga_2         |numeric   |Fga 2.                                  |
#'    |fg_2_pct      |numeric   |Field goals 2 percentage (0-1 decimal). |
#'    |fgm_3         |numeric   |Fgm 3.                                  |
#'    |fga_3         |numeric   |Fga 3.                                  |
#'    |fg_3_pct      |numeric   |Field goals 3 percentage (0-1 decimal). |
#'    |group_rank    |character |League/season rank for group.           |
#'    |team_finish   |character |Team finish.                            |
#'    |ncaa_seed     |numeric   |Ncaa seed.                              |
#'    |hometown      |character |Player hometown.                        |
#'    |date_of_birth |character |Date of birth (YYYY-MM-DD).             |
#'    |age           |character |Player age (in years).                  |
#'    |comparisons   |character |Comparisons.                            |
#'
#'    **gamelog**
#'
#'
#'    |col_name       |types     |description                             |
#'    |:--------------|:---------|:---------------------------------------|
#'    |year           |numeric   |4-digit year.                           |
#'    |team           |character |Team-side label or team identifier.     |
#'    |name           |character |Display name.                           |
#'    |position       |character |Listed roster position (G, F, C, etc.). |
#'    |opponent_tier  |logical   |Opponent tier.                          |
#'    |date           |character |Date in YYYY-MM-DD format.              |
#'    |opponent_rk    |numeric   |Opponent rk.                            |
#'    |opponent       |character |Opponent.                               |
#'    |result         |character |Result.                                 |
#'    |ot             |character |Ot.                                     |
#'    |location       |character |Location.                               |
#'    |game_type      |character |Game type.                              |
#'    |mvp            |character |Mvp.                                    |
#'    |start          |character |Start.                                  |
#'    |minutes_played |numeric   |Minutes played.                         |
#'    |o_rtg          |numeric   |O rtg.                                  |
#'    |poss_pct       |numeric   |Poss percentage (0-1 decimal).          |
#'    |pts            |numeric   |Points scored.                          |
#'    |fgm_2          |numeric   |Fgm 2.                                  |
#'    |fga_2          |numeric   |Fga 2.                                  |
#'    |fgm_3          |numeric   |Fgm 3.                                  |
#'    |fga_3          |numeric   |Fga 3.                                  |
#'    |ftm            |numeric   |Free throws made.                       |
#'    |fta            |numeric   |Free throw attempts.                    |
#'    |or             |numeric   |Or.                                     |
#'    |dr             |numeric   |Dr.                                     |
#'    |a              |numeric   |A.                                      |
#'    |to             |numeric   |To.                                     |
#'    |blk            |numeric   |Blocks.                                 |
#'    |stl            |numeric   |Steals.                                 |
#'    |pf             |numeric   |Personal fouls.                         |
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
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @return Returns a list of named data frames: all_games, conference_games
#'
#'    **all_games**
#'
#'
#'    |col_name     |types     |description                             |
#'    |:------------|:---------|:---------------------------------------|
#'    |role         |character |Role.                                   |
#'    |number       |numeric   |Number.                                 |
#'    |player       |character |Player.                                 |
#'    |ht           |character |Ht.                                     |
#'    |wt           |numeric   |Wt.                                     |
#'    |yr           |character |Yr.                                     |
#'    |g            |numeric   |Games played.                           |
#'    |min_pct      |numeric   |Min percentage (0-1 decimal).           |
#'    |o_rtg        |numeric   |O rtg.                                  |
#'    |poss_pct     |numeric   |Poss percentage (0-1 decimal).          |
#'    |shots_pct    |numeric   |Shots percentage (0-1 decimal).         |
#'    |e_fg_pct     |numeric   |E field goals percentage (0-1 decimal). |
#'    |ts_pct       |numeric   |True shooting percentage (0-1).         |
#'    |or_pct       |numeric   |Or percentage (0-1 decimal).            |
#'    |dr_pct       |numeric   |Dr percentage (0-1 decimal).            |
#'    |a_rate       |numeric   |A rate.                                 |
#'    |to_rate      |numeric   |To rate.                                |
#'    |blk_pct      |numeric   |Blocks percentage (0-1 decimal).        |
#'    |stl_pct      |numeric   |Steals percentage (0-1 decimal).        |
#'    |f_cper40     |numeric   |F cper40.                               |
#'    |f_dper40     |numeric   |F dper40.                               |
#'    |ft_rate      |numeric   |Ft rate.                                |
#'    |ftm          |numeric   |Free throws made.                       |
#'    |fta          |numeric   |Free throw attempts.                    |
#'    |ft_pct       |numeric   |Free throw percentage (0-1).            |
#'    |fgm_2        |numeric   |Fgm 2.                                  |
#'    |fga_2        |numeric   |Fga 2.                                  |
#'    |fg_2_pct     |numeric   |Field goals 2 percentage (0-1 decimal). |
#'    |fgm_3        |numeric   |Fgm 3.                                  |
#'    |fga_3        |numeric   |Fga 3.                                  |
#'    |fg_3_pct     |numeric   |Field goals 3 percentage (0-1 decimal). |
#'    |category     |character |Category label.                         |
#'    |min_pct_rk   |numeric   |Min pct rk.                             |
#'    |o_rtg_rk     |numeric   |O rtg rk.                               |
#'    |poss_pct_rk  |numeric   |Poss pct rk.                            |
#'    |shots_pct_rk |numeric   |Shots pct rk.                           |
#'    |e_fg_pct_rk  |numeric   |E fg pct rk.                            |
#'    |ts_pct_rk    |numeric   |Ts pct rk.                              |
#'    |or_pct_rk    |numeric   |Or pct rk.                              |
#'    |dr_pct_rk    |numeric   |Dr pct rk.                              |
#'    |a_rate_rk    |numeric   |A rate rk.                              |
#'    |to_rate_rk   |numeric   |To rate rk.                             |
#'    |blk_pct_rk   |numeric   |Blk pct rk.                             |
#'    |stl_pct_rk   |numeric   |Stl pct rk.                             |
#'    |f_cper40_rk  |numeric   |F cper40 rk.                            |
#'    |f_dper40_rk  |numeric   |F dper40 rk.                            |
#'    |ft_rate_rk   |numeric   |Ft rate rk.                             |
#'    |ft_pct_rk    |numeric   |Ft pct rk.                              |
#'    |fg_2_pct_rk  |numeric   |Fg 2 pct rk.                            |
#'    |fg_3_pct_rk  |numeric   |Fg 3 pct rk.                            |
#'    |group_rank   |character |League/season rank for group.           |
#'    |team         |character |Team-side label or team identifier.     |
#'    |year         |numeric   |4-digit year.                           |
#'    |player_id    |numeric   |Unique player identifier.               |
#'
#'    **conference_games**
#'
#'
#'    |col_name     |types     |description                             |
#'    |:------------|:---------|:---------------------------------------|
#'    |role         |character |Role.                                   |
#'    |number       |numeric   |Number.                                 |
#'    |player       |character |Player.                                 |
#'    |ht           |character |Ht.                                     |
#'    |wt           |numeric   |Wt.                                     |
#'    |yr           |character |Yr.                                     |
#'    |g            |numeric   |Games played.                           |
#'    |min_pct      |numeric   |Min percentage (0-1 decimal).           |
#'    |o_rtg        |numeric   |O rtg.                                  |
#'    |poss_pct     |numeric   |Poss percentage (0-1 decimal).          |
#'    |shots_pct    |numeric   |Shots percentage (0-1 decimal).         |
#'    |e_fg_pct     |numeric   |E field goals percentage (0-1 decimal). |
#'    |ts_pct       |numeric   |True shooting percentage (0-1).         |
#'    |or_pct       |numeric   |Or percentage (0-1 decimal).            |
#'    |dr_pct       |numeric   |Dr percentage (0-1 decimal).            |
#'    |a_rate       |numeric   |A rate.                                 |
#'    |to_rate      |numeric   |To rate.                                |
#'    |blk_pct      |numeric   |Blocks percentage (0-1 decimal).        |
#'    |stl_pct      |numeric   |Steals percentage (0-1 decimal).        |
#'    |f_cper40     |numeric   |F cper40.                               |
#'    |f_dper40     |numeric   |F dper40.                               |
#'    |ft_rate      |numeric   |Ft rate.                                |
#'    |ftm          |numeric   |Free throws made.                       |
#'    |fta          |numeric   |Free throw attempts.                    |
#'    |ft_pct       |numeric   |Free throw percentage (0-1).            |
#'    |fgm_2        |numeric   |Fgm 2.                                  |
#'    |fga_2        |numeric   |Fga 2.                                  |
#'    |fg_2_pct     |numeric   |Field goals 2 percentage (0-1 decimal). |
#'    |fgm_3        |numeric   |Fgm 3.                                  |
#'    |fga_3        |numeric   |Fga 3.                                  |
#'    |fg_3_pct     |numeric   |Field goals 3 percentage (0-1 decimal). |
#'    |category     |character |Category label.                         |
#'    |min_pct_rk   |numeric   |Min pct rk.                             |
#'    |o_rtg_rk     |numeric   |O rtg rk.                               |
#'    |poss_pct_rk  |numeric   |Poss pct rk.                            |
#'    |shots_pct_rk |numeric   |Shots pct rk.                           |
#'    |e_fg_pct_rk  |numeric   |E fg pct rk.                            |
#'    |ts_pct_rk    |numeric   |Ts pct rk.                              |
#'    |or_pct_rk    |numeric   |Or pct rk.                              |
#'    |dr_pct_rk    |numeric   |Dr pct rk.                              |
#'    |a_rate_rk    |numeric   |A rate rk.                              |
#'    |to_rate_rk   |numeric   |To rate rk.                             |
#'    |blk_pct_rk   |numeric   |Blk pct rk.                             |
#'    |stl_pct_rk   |numeric   |Stl pct rk.                             |
#'    |f_cper40_rk  |numeric   |F cper40 rk.                            |
#'    |f_dper40_rk  |numeric   |F dper40 rk.                            |
#'    |ft_rate_rk   |numeric   |Ft rate rk.                             |
#'    |ft_pct_rk    |numeric   |Ft pct rk.                              |
#'    |fg_2_pct_rk  |numeric   |Fg 2 pct rk.                            |
#'    |fg_3_pct_rk  |numeric   |Fg 3 pct rk.                            |
#'    |group_rank   |character |League/season rank for group.           |
#'    |team         |character |Team-side label or team identifier.     |
#'    |year         |numeric   |4-digit year.                           |
#'    |player_id    |numeric   |Unique player identifier.               |
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
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return A data frame with one row per rostered player, with the following columns:
#'
#'    |col_name    |types     |description                                                  |
#'    |:-----------|:---------|:-------------------------------------------------------------|
#'    |team        |character |Team-side label or team identifier.                            |
#'    |year        |numeric   |4-digit year.                                                  |
#'    |player_id   |integer   |KenPom player identifier.                                       |
#'    |player_name |character |Player full name.                                               |
#'    |class_year  |character |Class year (e.g. 'Fr', 'So', 'Jr', 'Sr').                       |
#'    |height      |character |Height (e.g. '6-9').                                            |
#'    |weight      |numeric   |Weight in pounds.                                               |
#'    |pct_pg      |numeric   |Percentage of the player's minutes played at point guard (0-1 decimal). |
#'    |pct_sg      |numeric   |Percentage of the player's minutes played at shooting guard (0-1 decimal). |
#'    |pct_sf      |numeric   |Percentage of the player's minutes played at small forward (0-1 decimal). |
#'    |pct_pf      |numeric   |Percentage of the player's minutes played at power forward (0-1 decimal). |
#'    |pct_c       |numeric   |Percentage of the player's minutes played at center (0-1 decimal). |
#'    |pct_poss    |numeric   |Percentage of team possessions used while the player was on the floor (0-1 decimal). |
#'    |fta         |integer   |Season free throw attempts.                                     |
#'    |fg2a        |integer   |Season 2-point field goal attempts.                             |
#'    |fg3a        |integer   |Season 3-point field goal attempts.                             |
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
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @return A data frame with the following columns:
#'
#'    |col_name             |types     |description                         |
#'    |:--------------------|:---------|:-----------------------------------|
#'    |year                 |numeric   |4-digit year.                       |
#'    |team                 |character |Team-side label or team identifier. |
#'    |min_pct              |numeric   |Min percentage (0-1 decimal).       |
#'    |pg_number            |numeric   |Pg number.                          |
#'    |pg_player_first_name |character |Pg player first name.               |
#'    |pg_player_last_name  |character |Pg player last name.                |
#'    |pg_hgt               |character |Pg hgt.                             |
#'    |pg_wgt               |numeric   |Pg wgt.                             |
#'    |pg_yr                |character |Pg yr.                              |
#'    |sg_number            |numeric   |Sg number.                          |
#'    |sg_player_first_name |character |Sg player first name.               |
#'    |sg_player_last_name  |character |Sg player last name.                |
#'    |sg_hgt               |character |Sg hgt.                             |
#'    |sg_wgt               |numeric   |Sg wgt.                             |
#'    |sg_yr                |character |Sg yr.                              |
#'    |sf_number            |numeric   |Sf number.                          |
#'    |sf_player_first_name |character |Sf player first name.               |
#'    |sf_player_last_name  |character |Sf player last name.                |
#'    |sf_hgt               |character |Sf hgt.                             |
#'    |sf_wgt               |numeric   |Sf wgt.                             |
#'    |sf_yr                |character |Sf yr.                              |
#'    |pf_number            |numeric   |Pf number.                          |
#'    |pf_player_first_name |character |Personal fouls player first name.   |
#'    |pf_player_last_name  |character |Personal fouls player last name.    |
#'    |pf_hgt               |character |Pf hgt.                             |
#'    |pf_wgt               |numeric   |Pf wgt.                             |
#'    |pf_yr                |character |Pf yr.                              |
#'    |c_number             |numeric   |C number.                           |
#'    |c_player_first_name  |character |C player first name.                |
#'    |c_player_last_name   |character |C player last name.                 |
#'    |c_hgt                |character |C hgt.                              |
#'    |c_wgt                |numeric   |C wgt.                              |
#'    |c_yr                 |character |C yr.                               |
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
