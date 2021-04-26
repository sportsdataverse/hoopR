#' Get team schedule results
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Schedule
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate select
#' @importFrom stringr str_trim str_extract str_remove str_replace str_detect str_pad
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_team_schedule(team = 'Florida St.', year= 2020)
#' }

kp_team_schedule <- function(team, year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  if(year >= 2011){
    sched_header_cols<- c("Day.Date","Team.Rk","Opponent.Rk","Opponent","Result",
                          "Poss","OT","Location","Record","Conference", "Postseason")
  }else{
    sched_header_cols<- c("Day.Date", "Opponent.Rk", "Opponent", "Result",
                          "Poss", "OT", "Location", "Record", "Conference", "Postseason")
  }

  sched <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements(css='#schedule-table') %>%
              rvest::html_table())[[1]] %>%
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
  sched <-sched %>%
    dplyr::mutate(Postseason = ifelse(.data$Postseason == "", NA_character_, .data$Postseason)) %>%
    tidyr::fill(.data$Postseason, .direction = c("down"))

  suppressWarnings(
    sched <- sched %>%
      dplyr::mutate(
        WL = stringr::str_replace(stringr::str_extract(.data$Result,'W|L'),",",""),
        Score = stringr::str_replace(stringr::str_extract(.data$Result,'\\d{1,3}-\\d{1,3}'),",","")) %>%
      tidyr::separate(.data$Score, into = c("WinnerScore", "LoserScore"), sep = "-") %>%
      dplyr::mutate(
        TeamScore = dplyr::case_when(
          .data$WL == "W" & .data$Record != "" ~ as.numeric(.data$WinnerScore),
          .data$WL == "L" & .data$Record != "" ~ as.numeric(.data$LoserScore),
          .data$WL == "" ~ NA_real_),
        OpponentScore = dplyr::case_when(
          .data$WL == "L" & .data$Record != "" ~ as.numeric(.data$WinnerScore),
          .data$WL == "W" & .data$Record != "" ~ as.numeric(.data$LoserScore),
          .data$WL == "" ~ NA_real_)) %>%
      tidyr::separate(.data$Record,into= c("W", "L"), sep = "-") %>%
      dplyr::filter(.data$Location %in% c("Home", "Away", "Neutral",
                                          "Semi-Home","Semi-Away")) %>%
      dplyr::select(-.data$WinnerScore,-.data$LoserScore) %>%
      dplyr::mutate_at(c("Opponent.Rk", "Poss","TeamScore","OpponentScore"), as.numeric)
  )
  suppressWarnings(
    if(year>= 2011){
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
      tidyr::separate(.data$Conference,
                      into = c("W.Conference","L.Conference"), sep = "-") %>%
      dplyr::mutate(
        W.Conference = ifelse((.data$W.Conference == "\u00d7")|(.data$W.Conference == ""), NA_real_, .data$W.Conference)
      )
  )
  if(year>=2011){
    sched <- sched %>%
      dplyr::select(.data$Team.Rk, .data$Team, .data$Opponent.Rk, .data$Opponent,
                    .data$Result, .data$Poss, .data$OT, .data$PreWP, .data$Location,
                    .data$W, .data$L, .data$W.Conference, .data$L.Conference,
                    .data$ConferenceGame, .data$Postseason, .data$Year, .data$Day.Date)
  }else{
    sched <- sched %>%
      dplyr::select(.data$Team, .data$Opponent.Rk, .data$Opponent,
                    .data$Result, .data$Poss, .data$OT, .data$PreWP, .data$Location,
                    .data$W, .data$L, .data$W.Conference, .data$L.Conference,
                    .data$ConferenceGame, .data$Postseason, .data$Year, .data$Day.Date)
  }

  suppressWarnings(
    sched <- sched %>%
      dplyr::filter(!is.na(.data$Day.Date)) %>%
      dplyr::mutate_at(c("Opponent.Rk","Poss","W", "L",
                         "W.Conference","L.Conference"), as.numeric)
  )

  sched <- sched %>%
    dplyr::mutate(
      Date.DD = stringr::str_pad(stringr::str_extract(.data$Day.Date,'\\d+'), 2, pad="0"),
      Date.MO = NA_character_,
      Date.MO = dplyr::case_when(
        stringr::str_detect(.data$Day.Date,regex("Oct",ignore_case=TRUE)) ~ "10",
        stringr::str_detect(.data$Day.Date,regex("Nov",ignore_case=TRUE)) ~ "11",
        stringr::str_detect(.data$Day.Date,regex("Dec",ignore_case=TRUE)) ~ "12",
        stringr::str_detect(.data$Day.Date,regex("Jan",ignore_case=TRUE)) ~ stringr::str_pad(1, 2, pad="0"),
        stringr::str_detect(.data$Day.Date,regex("Feb",ignore_case=TRUE)) ~ stringr::str_pad(2, 2, pad="0"),
        stringr::str_detect(.data$Day.Date,regex("Mar",ignore_case=TRUE)) ~ stringr::str_pad(3, 2, pad="0"),
        stringr::str_detect(.data$Day.Date,regex("Apr",ignore_case=TRUE)) ~ stringr::str_pad(4, 2, pad="0")),
      Date.YR = dplyr::case_when(
        stringr::str_detect(.data$Day.Date,regex("Oct",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
        stringr::str_detect(.data$Day.Date,regex("Nov",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
        stringr::str_detect(.data$Day.Date,regex("Dec",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
        stringr::str_detect(.data$Day.Date,regex("Jan",ignore_case=TRUE)) ~ glue::glue("{year}"),
        stringr::str_detect(.data$Day.Date,regex("Feb",ignore_case=TRUE)) ~ glue::glue("{year}"),
        stringr::str_detect(.data$Day.Date,regex("Mar",ignore_case=TRUE)) ~ glue::glue("{year}"),
        stringr::str_detect(.data$Day.Date,regex("Apr",ignore_case=TRUE)) ~ glue::glue("{year}")),
      GameDate = as.numeric(paste0(.data$Date.YR, .data$Date.MO, .data$Date.DD)),
      W.Proj = round(cummax(ifelse(is.na(.data$W), 0, .data$W)) +
        cumsum(ifelse(is.na(.data$PreWP), 0, .data$PreWP))),
      L.Proj = round(cummax(ifelse(is.na(.data$L), 0, .data$L)) +
        cumsum(ifelse(is.na(.data$PreWP), 0, 1 - .data$PreWP))),
      W.ConferenceProj = round(cummax(ifelse(is.na(.data$W.Conference), 0, .data$W.Conference)) +
        cumsum(ifelse(.data$ConferenceGame==TRUE & !is.na(.data$PreWP), .data$PreWP, 0))),
      L.ConferenceProj = round(cummax(ifelse(is.na(.data$L.Conference), 0, .data$L.Conference)) +
        cumsum(ifelse(.data$ConferenceGame==TRUE & !is.na(.data$PreWP), 1 - .data$PreWP, 0)))) %>%
    dplyr::select(-.data$Date.DD,-.data$Date.MO,-.data$Date.YR)

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

  if(year >= 2011){
    w_links <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.w > td:not(.label):nth-child(1)")

    l_links <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.l > td:not(.label):nth-child(1)")

    un_links <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.un > td:not(.label):nth-child(1)")

    fm_links <- c(w_links,l_links,un_links)

    w_box <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css="#schedule-table") %>%
      rvest::html_elements("tr.w > td:not(.label):nth-child(5)")
    l_box <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css="#schedule-table") %>%
      rvest::html_elements("tr.l > td:not(.label):nth-child(5)")
    un_box <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css="#schedule-table") %>%
      rvest::html_elements("tr.un > td:not(.label):nth-child(5)")

    box_links <- c(w_box, l_box, un_box)

    w_tier <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.w > td:not(.label):nth-child(11)")

    l_tier <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.l > td:not(.label):nth-child(11)")

    un_tier <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.un > td:not(.label):nth-child(11)")

    tiers <- c(w_tier, l_tier, un_tier)

  }else{
    w_links <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.w > td:not(.label):nth-child(1)")

    l_links <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.l > td:not(.label):nth-child(1)")

    un_links <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.un > td:not(.label):nth-child(1)")

    fm_links <- c(w_links,l_links,un_links)

    w_box <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css="#schedule-table") %>%
      rvest::html_elements("tr.w > td:not(.label):nth-child(4)")

    l_box <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css="#schedule-table") %>%
      rvest::html_elements("tr.l > td:not(.label):nth-child(4)")

    un_box <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css="#schedule-table") %>%
      rvest::html_elements("tr.un > td:not(.label):nth-child(4)")

    box_links <- c(w_box, l_box, un_box)

    w_tier <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.w > td:not(.label):nth-child(10)")

    l_tier <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
      rvest::html_elements("tr.l > td:not(.label):nth-child(10)")

    un_tier <- page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#schedule-table') %>%
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
    dplyr::select(.data$Date,.data$GameId, .data$TiersOfJoy, .data$Day.Date)

  ### Add Date and GameId back back to data frame
  sched <- dplyr::left_join(sched, sched_links, by = "Day.Date")

  ### Store Data
  kenpom <- sched %>%
    dplyr::arrange(.data$GameDate) %>%
    dplyr::mutate(Postseason = ifelse(is.na(.data$Postseason), "Regular", .data$Postseason))

  return(kenpom)
}

#' Get KenPom's team game plan page
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Game Plan
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter select rename mutate case_when mutate_at bind_rows
#' @importFrom tidyr separate everything
#' @importFrom stringr str_trim str_extract str_remove str_replace str_detect
#' @export
#' @examples
#' \dontrun{
#'   kp_gameplan(team='Florida St.', year=2020)
#' }

kp_gameplan <- function(team, year=2020){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/gameplan.php?",
                "team=", team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)
  header_cols <- c("Date","Opponent.Rk",	"Opponent","Result","Location","Pace",
                   "Off.Eff", "Off.Eff.Rk", "Off.eFG.Pct",	"Off.TO.Pct",	"Off.OR.Pct", "Off.FTR",
                   "Off.FGM_2-A", "Off.FG_2.Pct", "Off.FGM_3-A",	"Off.FG_3.Pct",	"Off.FG_3A.Pct",
                   "Def.Eff", "Def.Eff.Rk", "Def.eFG.Pct",	"Def.TO.Pct",	"Def.OR.Pct", "Def.FTR",
                   "Def.FGM_2-A",	"Def.FG_2.Pct",	"Def.FGM_3-A", "Def.FG_3.Pct",	"Def.FG_3A.Pct")


  gp <- (page %>%
           xml2::read_html() %>%
           rvest::html_elements(css='#schedule-table'))[[1]] %>%
    rvest::html_table() %>%
    as.data.frame()

  colnames(gp) <- header_cols

  gp <- gp %>%
    dplyr::filter(.data$Location!="")
  suppressWarnings(
    gp <- gp %>%
      dplyr::mutate(
        WL = stringr::str_replace(stringr::str_extract(.data$Result,'W|L'),",",""),
        Score = stringr::str_replace(stringr::str_extract(.data$Result,'\\d{1,3}-\\d{1,3}'),",","")) %>%
      tidyr::separate(.data$Score, into = c("WinnerScore", "LoserScore"), sep = "-") %>%
      dplyr::mutate(
        TeamScore = dplyr::case_when(
          .data$WL == "W"  ~ as.numeric(.data$WinnerScore),
          .data$WL == "L"  ~ as.numeric(.data$LoserScore),
          .data$WL == "" ~ NA_real_),
        OpponentScore = dplyr::case_when(
          .data$WL == "L" ~ as.numeric(.data$WinnerScore),
          .data$WL == "W" ~ as.numeric(.data$LoserScore),
          .data$WL == "" ~ NA_real_),
        Date.DD = stringr::str_pad(stringr::str_extract(.data$Date,'\\d+'), 2, pad="0"),
        Date.MO = NA_character_,
        Date.MO = dplyr::case_when(
          stringr::str_detect(.data$Date,regex("Oct",ignore_case=TRUE)) ~ "10",
          stringr::str_detect(.data$Date,regex("Nov",ignore_case=TRUE)) ~ "11",
          stringr::str_detect(.data$Date,regex("Dec",ignore_case=TRUE)) ~ "12",
          stringr::str_detect(.data$Date,regex("Jan",ignore_case=TRUE)) ~ stringr::str_pad(1, 2, pad="0"),
          stringr::str_detect(.data$Date,regex("Feb",ignore_case=TRUE)) ~ stringr::str_pad(2, 2, pad="0"),
          stringr::str_detect(.data$Date,regex("Mar",ignore_case=TRUE)) ~ stringr::str_pad(3, 2, pad="0"),
          stringr::str_detect(.data$Date,regex("Apr",ignore_case=TRUE)) ~ stringr::str_pad(4, 2, pad="0")
        ),
        Date.YR = dplyr::case_when(
          stringr::str_detect(.data$Date,regex("Oct",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
          stringr::str_detect(.data$Date,regex("Nov",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
          stringr::str_detect(.data$Date,regex("Dec",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
          stringr::str_detect(.data$Date,regex("Jan",ignore_case=TRUE)) ~ glue::glue("{year}"),
          stringr::str_detect(.data$Date,regex("Feb",ignore_case=TRUE)) ~ glue::glue("{year}"),
          stringr::str_detect(.data$Date,regex("Mar",ignore_case=TRUE)) ~ glue::glue("{year}"),
          stringr::str_detect(.data$Date,regex("Apr",ignore_case=TRUE)) ~ glue::glue("{year}")
        ),
        Day.Date = .data$Date,
        Date = as.Date(glue::glue("{.data$Date.YR}-{.data$Date.MO}-{.data$Date.DD}")),
        GameDate = as.numeric(paste0(.data$Date.YR, .data$Date.MO, .data$Date.DD))) %>%
      dplyr::select(-.data$Date.DD,-.data$Date.MO,-.data$Date.YR)
  )
  cor <- gp[(nrow(gp)-2):nrow(gp),]
  cor <- cor %>%
    dplyr::select(.data$Location, .data$Pace,
                  .data$Off.eFG.Pct,.data$Off.TO.Pct,.data$Off.OR.Pct,.data$Off.FTR,
                  .data$Def.eFG.Pct,.data$Def.TO.Pct,.data$Def.OR.Pct,.data$Def.FTR) %>%
    dplyr::rename("Correlations (R x 100)" = .data$Location)
  cor <- cor[2:3,]
  suppressWarnings(
    gp <- gp %>%
      dplyr::filter(!is.na(as.numeric(.data$Off.Eff))) %>%
      tidyr::separate(.data$"Off.FGM_2-A", into = c("Off.FGM_2","Off.FGA_2")) %>%
      tidyr::separate(.data$"Off.FGM_3-A", into = c("Off.FGM_3","Off.FGA_3")) %>%
      tidyr::separate(.data$"Def.FGM_2-A", into = c("Def.FGM_2","Def.FGA_2")) %>%
      tidyr::separate(.data$"Def.FGM_3-A", into = c("Def.FGM_3","Def.FGA_3")) %>%
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
  gp <- gp %>% dplyr::select(-.data$WinnerScore, -.data$LoserScore)

  z <- data.frame()
  tryCatch(
    expr = {
      y <- page %>%
        xml2::read_html() %>%
        rvest::html_elements(css='.dist-table')
      if(length(y)>0){
        for(i in 1:length(y)){
          header_cols <- c("Team","C.Pct","PF.Pct","SF.Pct","SG.Pct","PG.Pct")
          d <- (page %>%
                  xml2::read_html() %>%
                  rvest::html_elements(css='.dist-table'))[[i]] %>%
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
                                nchar(sprintf("%.*f",4, as.numeric(.data$SF.Pct))) - 3)),
                SG.Pct = as.numeric(substr(sprintf("%.*f",4, as.numeric(.data$SG.Pct)), 1,
                                nchar(sprintf("%.*f",4, as.numeric(.data$SG.Pct))) - 3)),
                PG.Pct = as.numeric(substr(sprintf("%.*f",4, as.numeric(.data$PG.Pct)), 1,
                                nchar(sprintf("%.*f",4, as.numeric(.data$PG.Pct))) - 3)))
          )
          d$C.Pct.D1.Avg = as.numeric(d[3,"C.Pct"])
          d$PF.Pct.D1.Avg = as.numeric(d[3,"PF.Pct"])
          d$SF.Pct.D1.Avg = as.numeric(d[3,"SF.Pct"])
          d$SG.Pct.D1.Avg = as.numeric(d[3,"SG.Pct"])
          d$PG.Pct.D1.Avg = as.numeric(d[3, "PG.Pct"])
          d <- d %>%
            dplyr::filter(!is.na(.data$C.Pct.Rk)) %>%
            dplyr::select(.data$Team, .data$Category, tidyr::everything())

          z <- dplyr::bind_rows(z, d)
        }
      }
    },
    error = function(e){
      message(glue::glue("{Sys.date()} - No Game Plan Points distribution tables available for {team} - {year}"))
    },
    warning = function(w){
    },
    finally = function(f){

    }
  )

  kenpom <- c(list(gp),list(cor),list(z))

  return(kenpom)
}

#' Get KenPom's team opponent tracker page
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#' @keywords Opponent Tracker
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_opptracker(team='Florida St.', year=2020)
#' }

kp_opptracker <- function(team, year=as.integer(format(Sys.Date(), "%Y"))){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")

  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]




  ### Pull Data
  url <- paste0("https://kenpom.com/opptracker.php?",
                "team=", team_name,
                "&y=", year,
                "&t=o")

  page_o <- rvest::session_jump_to(browser, url)

  header_cols<- c("Date","Opponent","Result","AdjOE","AdjOE.Rk",
                  "Off.eFG.Pct","Off.eFG.Pct.Rk","Off.TO.Pct","Off.TO.Pct.Rk",
                  "Off.OR.Pct","Off.OR.Pct.Rk","Off.FTRate","Off.FTRate.Rk",
                  "Off.FG_2.Pct","Off.FG_2.Pct.Rk","Off.FG_3.Pct","Off.FG_3.Pct.Rk",
                  "Off.Blk.Pct","Off.Blk.Pct.Rk","Off.FG_3A.Pct","Off.FG_3A.Pct.Rk")
  if(year>=2010){
    header_cols <- c(header_cols, "Off.APL","Off.APL.Rk")
  }

  opptracker_o <- (page_o %>%
    xml2::read_html() %>%
    rvest::html_elements(css='#conf-table'))[[1]] %>%
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
      tidyr::separate(.data$Score, into = c("WinnerScore", "LoserScore"), sep = "-") %>%
      dplyr::mutate(
        TeamScore = dplyr::case_when(
          .data$WL == "W"  ~ as.numeric(.data$WinnerScore),
          .data$WL == "L"  ~ as.numeric(.data$LoserScore),
          .data$WL == "" ~ NA_real_),
        OpponentScore = dplyr::case_when(
          .data$WL == "L" ~ as.numeric(.data$WinnerScore),
          .data$WL == "W" ~ as.numeric(.data$LoserScore),
          .data$WL == "" ~ NA_real_),
        Date.DD = stringr::str_pad(stringr::str_extract(.data$Date,'\\d+'), 2, pad="0"),
        Date.MO = NA_character_,
        Date.MO = dplyr::case_when(
          stringr::str_detect(.data$Date,regex("Oct",ignore_case=TRUE)) ~ "10",
          stringr::str_detect(.data$Date,regex("Nov",ignore_case=TRUE)) ~ "11",
          stringr::str_detect(.data$Date,regex("Dec",ignore_case=TRUE)) ~ "12",
          stringr::str_detect(.data$Date,regex("Jan",ignore_case=TRUE)) ~ stringr::str_pad(1, 2, pad="0"),
          stringr::str_detect(.data$Date,regex("Feb",ignore_case=TRUE)) ~ stringr::str_pad(2, 2, pad="0"),
          stringr::str_detect(.data$Date,regex("Mar",ignore_case=TRUE)) ~ stringr::str_pad(3, 2, pad="0"),
          stringr::str_detect(.data$Date,regex("Apr",ignore_case=TRUE)) ~ stringr::str_pad(4, 2, pad="0")
        ),
        Date.YR = dplyr::case_when(
          stringr::str_detect(.data$Date,regex("Oct",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
          stringr::str_detect(.data$Date,regex("Nov",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
          stringr::str_detect(.data$Date,regex("Dec",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
          stringr::str_detect(.data$Date,regex("Jan",ignore_case=TRUE)) ~ glue::glue("{year}"),
          stringr::str_detect(.data$Date,regex("Feb",ignore_case=TRUE)) ~ glue::glue("{year}"),
          stringr::str_detect(.data$Date,regex("Mar",ignore_case=TRUE)) ~ glue::glue("{year}"),
          stringr::str_detect(.data$Date,regex("Apr",ignore_case=TRUE)) ~ glue::glue("{year}")
        ),
        Day.Date = .data$Date,
        Date = as.Date(glue::glue("{.data$Date.YR}-{.data$Date.MO}-{.data$Date.DD}")),
        GameDate = as.numeric(paste0(.data$Date.YR, .data$Date.MO, .data$Date.DD))) %>%
      dplyr::select(-.data$Date.DD, -.data$Date.MO, -.data$Date.YR, -.data$WinnerScore, -.data$LoserScore)
  )

  header_cols<- c("Date","Opponent","Result","AdjDE","AdjDE.Rk",
                  "Def.eFG.Pct","Def.eFG.Pct.Rk","Def.TO.Pct","Def.TO.Pct.Rk",
                  "Def.OR.Pct","Def.OR.Pct.Rk","Def.FTRate","Def.FTRate.Rk",
                  "Def.FG_2.Pct","Def.FG_2.Pct.Rk","Def.FG_3.Pct","Def.FG_3.Pct.Rk",
                  "Def.Blk.Pct","Def.Blk.Pct.Rk","Def.FG_3A.Pct","Def.FG_3A.Pct.Rk")

  if(year>=2010){
    header_cols <- c(header_cols, "Def.APL","Def.APL.Rk")
  }

  ### Pull Data
  url <- paste0("https://kenpom.com/opptracker.php?",
                "team=", team_name,
                "&y=", year,
                "&t=d")

  page_d <- rvest::session_jump_to(browser, url)
  opptracker_d <- (page_d %>%
                     xml2::read_html() %>%
                     rvest::html_elements(css='#conf-table'))[[1]] %>%
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
    dplyr::select(.data$Date, .data$GameDate, .data$Day.Date,
                  .data$WL, .data$Team, .data$TeamScore,
                  .data$Opponent, .data$OpponentScore,
                  tidyr::everything())
  return(kenpom)
}

#' Get KenPom's player stats from the team page
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Player Stats
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html xml_attrs
#' @importFrom dplyr select mutate filter case_when mutate_at bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect
#' @importFrom tidyr everything separate
#' @export
#'
#' @examples
#'   \dontrun{
#'     kp_team_players(team = 'Florida St.', year= 2020)
#'   }
#'

kp_team_players <- function(team, year= 2020){
  browser <- login()
  assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  tryCatch(
    expr = {
      player_links <- page %>%
        xml2::read_html() %>%
        rvest::html_elements(css='#player-table') %>%
        rvest::html_elements("td:nth-child(2) > a")


      pid <- dplyr::bind_rows(lapply(xml2::xml_attrs(player_links),
                                     function(x){
                                       if(!stringr::str_detect(x,"kpoy")){
                                         data.frame(as.list(x), stringsAsFactors=FALSE)
                                       }
                                     }))

      pid <- pid %>%
        dplyr::mutate(PlayerId = stringr::str_remove(stringr::str_extract(.data$href,"=(.+)"),"=")) %>%
        dplyr::select(.data$PlayerId)

      if(year>= 2014){ # "S" - starts only available from 2014 onwards
        players_header_cols <- c("Number", "Player", "Ht", "Wt", "Yr", "G", "S",
                                 "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                                 "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                                 "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                                 "FTRate", "FTM-A", "FT.Pct",
                                 "FGM_2-A", "FG_2.Pct", "FGM_3-A", "FG_3.Pct")
      }else{
        players_header_cols <- c("Number", "Player", "Ht", "Wt", "Yr", "G",
                                 "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                                 "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                                 "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                                 "FTRate", "FTM-A", "FT.Pct",
                                 "FGM_2-A", "FG_2.Pct", "FGM_3-A", "FG_3.Pct")
      }

      players <- (page %>%
                    xml2::read_html() %>%
                    rvest::html_elements(css='#player-table'))[[1]]

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
                           nchar(sprintf("%.*f",4, as.numeric(.data$Min.Pct)))-3),
          ORtg = substr(sprintf("%.*f",4, as.numeric(.data$ORtg)), 1,
                        nchar(sprintf("%.*f",4, as.numeric(.data$ORtg))) - 3),
          Poss.Pct = substr(sprintf("%.*f",4, as.numeric(.data$Poss.Pct)), 1,
                            nchar(sprintf("%.*f",4, as.numeric(.data$Poss.Pct)))-3),
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
      if(year>=2014){
        suppressWarnings(
          players <- players %>%
            tidyr::separate(.data$"FTM-A", into = c("FTM", "FTA"), sep = "-") %>%
            tidyr::separate(.data$"FGM_2-A", into = c("FGM_2", "FGA_2"), sep = "-") %>%
            tidyr::separate(.data$"FGM_3-A", into = c("FGM_3", "FGA_3"), sep = "-") %>%
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
      }else{
        suppressWarnings(
          players <- players %>%
            tidyr::separate(.data$"FTM-A", into = c("FTM", "FTA"), sep = "-") %>%
            tidyr::separate(.data$"FGM_2-A", into = c("FGM_2", "FGA_2"), sep = "-") %>%
            tidyr::separate(.data$"FGM_3-A", into = c("FGM_3", "FGA_3"), sep = "-") %>%
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
        dplyr::select(.data$Role, tidyr::everything()) %>%
        dplyr::bind_cols(lapply(pid, as.numeric))

      ### Store Data
      kenpom <- players
    },
    error = function(e){
      message(glue::glue("{Sys.time()} - No Player Data available for {team} in {year}"))
    },
    warning = function(w){

    },
    finally = {

    }
  )


  return(kenpom)
}

#' Get KenPom's player career stats from the player page
#'
#'
#' @param player_id Player Id filter to select.
#'
#' @keywords Player Career Stats
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html xml_attrs
#' @importFrom dplyr select mutate filter case_when mutate_at bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect
#' @importFrom tidyr everything separate
#' @export
#'
#' @examples
#'   \dontrun{
#'     kp_player_career(player_id = '41180')
#'   }
#'
kp_player_career <- function(player_id){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

  browser <- login()

  ### Pull Data
  url <- paste0("https://kenpom.com/player.php?",
                "p=",player_id)

  page <- rvest::session_jump_to(browser, url)

  tryCatch(
    expr = {
      #--- Player Info ----
      player_info <- (page %>%
                        xml2::read_html() %>%
                        rvest::html_elements(css = 'span.name')) %>%
        rvest::html_text() %>%
        as.data.frame()
      colnames(player_info) <- "Player"
      player_town <- (page %>%
                        xml2::read_html() %>%
                        rvest::html_elements(css = 'span.town')) %>%
        rvest::html_text() %>%
        as.data.frame()
      colnames(player_town) <- "Num"
      player_town <- player_town %>%
        tidyr::separate(.data$Num, into = c("Number", "Town", "DateOfBirth"), sep = "\u00b7")
      player_info <- dplyr::bind_cols(player_info, player_town)

      #--- Player Career Average Stats ----
      players_header_cols <- c("Year","Team","Hgt","Wgt","Yr","G","Min.Pct","ORtg",
                               "Poss.Pct","Shots.Pct","eFG.Pct","TS.Pct","OR.Pct",
                               "DR.Pct","ARate","TORate","Blk.Pct",
                               "Stl.Pct","FCper40","FDper40","FTRate",
                               "FTM-A","FT.Pct","FG_2M-A","FG_2.Pct","FG_3M-A",
                               "FG_3.Pct")
      players <- (page %>%
                    xml2::read_html() %>%
                    rvest::html_elements(css='#player-table'))[[1]] %>%
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
      players_career <- players[(nrow(players)-2):nrow(players),]
      players <- players[1:(nrow(players)-3),]
      # Now need to fill year to create a join column for the age and player comps columns
      players <- players %>%
        dplyr::mutate(Year = ifelse(.data$Year == "", NA_real_, .data$Year)) %>%
        tidyr::fill(.data$Year, .direction = c("down"))

      player_age <- players %>%
        dplyr::filter(stringr::str_detect(.data$Team,'Age:')) %>%
        dplyr::select(.data$Year, .data$Team, .data$Min.Pct) %>%
        dplyr::rename(Age = .data$Team, Comparisons = .data$Min.Pct) %>%
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
        tidyr::fill(.data$Hgt, .direction = c("down")) %>%
        tidyr::fill(.data$Wgt, .direction = c("down")) %>%
        tidyr::fill(.data$Yr, .direction = c("down")) %>%
        tidyr::fill(.data$Position, .direction = c("down")) %>%
        tidyr::fill(.data$Team.Rk, .direction = c("down")) %>%
        dplyr::group_by(.data$Year) %>%
        tidyr::fill(.data$Team.Finish, .direction = c("down")) %>%
        tidyr::fill(.data$NCAASeed, .direction = c("down")) %>%
        dplyr::ungroup() %>%
        dplyr::bind_rows(players_career) %>%
        dplyr::left_join(player_age, by = c("Year"))

      suppressWarnings(
        players <- players %>%
          tidyr::separate(.data$"FTM-A",into=c("FTM", "FTA")) %>%
          tidyr::separate(.data$"FG_2M-A",into=c("FGM_2", "FGA_2")) %>%
          tidyr::separate(.data$"FG_3M-A",into=c("FGM_3", "FGA_3")) %>%
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
        dplyr::select(.data$Year, .data$Team, .data$Name, .data$Position)

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
          .data$Year, .data$Team.Rk,.data$Team, .data$Number,
          .data$Name, .data$Position, tidyr::everything())
      s <- (page %>%
              xml2::read_html() %>%
              rvest::html_elements(css='#schedule-table'))
      schedule_games <- data.frame()
      for(i in 1:length(s)){

        header <- (page %>%
                     xml2::read_html() %>%
                     rvest::html_elements(css='div.gamelogdiv > h3'))[[i]] %>%
          rvest::html_text()
        sched_header_cols <- c("Opponent.Tier", "Date", "Opponent.Rk", "Opponent",
                               "Result","OT", "Location", "GameType",
                               "MVP", "Start", "MinutesPlayed", "ORtg", "Poss.Pct",
                               "Pts", "FG_2M-A", "FG_3M-A", "FTM-A",
                               "OR", "DR", "A", "TO", "Blk", "Stl", "PF")

        sched <-  ((page %>%
                      xml2::read_html() %>%
                      rvest::html_elements(css='#schedule-table'))[[i]] %>%
                     rvest::html_table())[,1:24]

        colnames(sched) <- sched_header_cols
        rownames(sched) <- NULL
        sched <- sched %>% dplyr::filter(.data$Date != "")
        sched$GameData <- header
        sched <- sched %>%
          dplyr::mutate(Year = as.numeric(stringr::str_replace(.data$GameData," Game Data",""))) %>%
          dplyr::select(-.data$GameData)
        sched <- sched %>%
          dplyr::left_join(players_team_name, by="Year")

        suppressWarnings(
          sched <- sched %>%
            tidyr::separate(.data$"FTM-A",into=c("FTM", "FTA")) %>%
            tidyr::separate(.data$"FG_2M-A",into=c("FGM_2", "FGA_2")) %>%
            tidyr::separate(.data$"FG_3M-A",into=c("FGM_3", "FGA_3")) %>%
            dplyr::mutate_at(c("Opponent.Rk","MinutesPlayed","ORtg","Poss.Pct",
                               "Pts","OR","DR","A","TO",
                               "FTM", "FTA","FGM_2", "FGA_2",
                               "FGM_3", "FGA_3",
                               "Blk","Stl","PF"), as.numeric)
        )
        sched <- sched %>%
          dplyr::select(.data$Year, .data$Team, .data$Name, .data$Position, tidyr::everything())
        schedule_games <- dplyr::bind_rows(schedule_games,sched)
      }

      ### Store Data
      kenpom <- c(list(players),list(schedule_games))
    },
    error = function(e){
      message(glue::glue("{Sys.time()} - No Player Data available for {team} in {year}"))
    },
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}
#' Get Minutes Matrix from Expanded Player Page
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Minutes Matrix
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr mutate filter
#' @export
#'
#' @examples
#'   \dontrun{
#'     kp_minutes_matrix(team = 'Florida St.', year = 2020)
#'   }
#'
#'
kp_minutes_matrix <- function(team, year = 2020){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  assertthat::assert_that(year >= 2014, msg="Data only goes back to 2014")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/player-expanded.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  header_cols<- c("Date","Opponent.Rk","Opponent","Result")

  x <- (page %>%
    xml2::read_html() %>%
    rvest::html_elements(css='#minutes-table'))[[1]] %>%
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
  kenpom <- x

  return(kenpom)
}


#' Get Team Player Stats
#'
#'
#' @param team Team filter to select.
#' @param year Year of data to pull
#'
#' @keywords Team Player Stats
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html xml_attrs
#' @importFrom dplyr select mutate filter case_when mutate_at bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect
#' @importFrom tidyr everything separate
#' @export
#'
#' @examples
#'   \dontrun{
#'     kp_team_player_stats(team = 'Florida St.', year = 2020)
#'   }
kp_team_player_stats <- function(team, year = 2020){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  assertthat::assert_that(year>=2014, msg="Data only goes back to 2014")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]




  ### Pull Data
  url <- paste0("https://kenpom.com/player-expanded.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  players <- (page %>%
                xml2::read_html() %>%
                rvest::html_elements(css='#player-table'))
  y <- list()

  for(i in 1:length(players)){
    player_links <- (page %>%
      xml2::read_html() %>%
      rvest::html_elements(css='#player-table'))[[i]] %>%
      rvest::html_elements("td:nth-child(2) > a")


    pid <- dplyr::bind_rows(lapply(xml2::xml_attrs(player_links),
                                   function(x){
                                     if(!stringr::str_detect(x,"kpoy")){
                                       data.frame(as.list(x), stringsAsFactors=FALSE)
                                     }
                                   }))
    # pid <- dplyr::bind_rows(lapply(player_links, extractor))

    pid <- pid %>%
      dplyr::mutate(PlayerId = stringr::str_remove(stringr::str_extract(.data$href,"=(.+)"),"=")) %>%
      dplyr::select(.data$PlayerId)

    players_header_cols <- c("Number", "Player", "Ht", "Wt", "Yr", "G",
                             "Min.Pct", "ORtg", "Poss.Pct","Shots.Pct",
                             "eFG.Pct", "TS.Pct", "OR.Pct", "DR.Pct",
                             "ARate", "TORate", "Blk.Pct","Stl.Pct","FCper40","FDper40",
                             "FTRate", "FTM-A", "FT.Pct",
                             "FGM_2-A", "FG_2.Pct", "FGM_3-A", "FG_3.Pct")

    players <- (page %>%
                  xml2::read_html() %>%
                  rvest::html_elements(css='#player-table'))[[i]]

    players <- players %>%
      rvest::html_table()

    colnames(players) <- players_header_cols
    suppressWarnings(
      players <- players %>%
        dplyr::filter(!is.na(as.numeric(.data$G)))
    )
    if(i==1){
      players$Category <- "All Games"
    }else{
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
          tidyr::separate(.data$"FTM-A", into = c("FTM", "FTA"), sep = "-") %>%
          tidyr::separate(.data$"FGM_2-A", into = c("FGM_2", "FGA_2"), sep = "-") %>%
          tidyr::separate(.data$"FGM_3-A", into = c("FGM_3", "FGA_3"), sep = "-") %>%
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
      dplyr::select(.data$Role, tidyr::everything()) %>%
      dplyr::bind_cols(lapply(pid, as.numeric))

    y <- dplyr::bind_rows(y, players)
  }
  ### Store Data
  kenpom <- y

  return(kenpom)
}


#' Get Depth Chart Last 5 Games from Team Page
#'
#'
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
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select mutate filter  bind_cols bind_rows
#' @importFrom stringr str_extract str_remove str_replace str_detect str_trim
#' @importFrom tidyr separate
#' @importFrom glue glue
#' @export
#'
#' @examples
#'   \dontrun{
#'     kp_team_depth_chart(team = 'Florida St.', year= 2020)
#'   }
#'
#'

kp_team_depth_chart <- function(team, year= 2020){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  assertthat::assert_that(year>=2010, msg="Data only goes back to 2010")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  tryCatch(
    expr = {
      depth1_header_cols<- c("PG", "PG.Min.Pct", "SG", "SG.Min.Pct", "SF", "SF.Min.Pct",
                             "PF", "PF.Min.Pct", "C", "C.Min.Pct")

      depth1 <- (page %>%
                   xml2::read_html() %>%
                   rvest::html_elements(css='#dc-table'))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(depth1) <- depth1_header_cols

      suppressWarnings(
        depth1 <- depth1 %>%
          dplyr::filter(.data$PG != "PG")
      )

      depth1 <- depth1 %>%
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
          PF.Wgt = stringr::str_extract(.data$PF,'\\d{3}'),
          PF = stringr::str_trim(stringr::str_remove(.data$PF,'\\d{3}')),
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
        depth1 <- depth1 %>%
          tidyr::separate(.data$PG, into = c("PG.Number", "PG.PlayerFirstName", "PG.PlayerLastName")) %>%
          tidyr::separate(.data$SG, into = c("SG.Number", "SG.PlayerFirstName", "SG.PlayerLastName")) %>%
          tidyr::separate(.data$SF, into = c("SF.Number", "SF.PlayerFirstName", "SF.PlayerLastName")) %>%
          tidyr::separate(.data$PF, into = c("PF.Number", "PF.PlayerFirstName", "PF.PlayerLastName")) %>%
          tidyr::separate(.data$C, into = c("C.Number", "C.PlayerFirstName", "C.PlayerLastName"))
      )
      suppressWarnings(
        depth1 <- depth1 %>%
          dplyr::mutate(
            Team = team,
            Year = year,
            PG.Min.Pct = as.numeric(stringr::str_replace(.data$PG.Min.Pct, '%', ''))/100,
            SG.Min.Pct = as.numeric(stringr::str_replace(.data$SG.Min.Pct, '%', ''))/100,
            SF.Min.Pct = as.numeric(stringr::str_replace(.data$SF.Min.Pct, '%', ''))/100,
            PF.Min.Pct = as.numeric(stringr::str_replace(.data$PF.Min.Pct, '%', ''))/100,
            C.Min.Pct = as.numeric(stringr::str_replace(.data$C.Min.Pct, '%', ''))/100,
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
      depth1 <- depth1 %>%
        dplyr::select(
          .data$PG.Number, .data$PG.PlayerFirstName,
          .data$PG.PlayerLastName, .data$PG.Hgt, .data$PG.Wgt, .data$PG.Yr, .data$PG.Min.Pct,
          .data$SG.Number, .data$SG.PlayerFirstName,
          .data$SG.PlayerLastName, .data$SG.Hgt, .data$SG.Wgt, .data$SG.Yr, .data$SG.Min.Pct,
          .data$SF.Number, .data$SF.PlayerFirstName,
          .data$SF.PlayerLastName, .data$SF.Hgt, .data$SF.Wgt, .data$SF.Yr, .data$SF.Min.Pct,
          .data$PF.Number, .data$PF.PlayerFirstName,
          .data$PF.PlayerLastName, .data$PF.Hgt, .data$PF.Wgt, .data$PF.Yr, .data$PF.Min.Pct,
          .data$C.Number, .data$C.PlayerFirstName,
          .data$C.PlayerLastName, .data$C.Hgt, .data$C.Wgt, .data$C.Yr, .data$C.Min.Pct,
          .data$Team, .data$Year)
      ### Store Data
      kenpom <- depth1
    },
    error = function(e){
      message(glue::glue("{Sys.time()} - {team} - {year} Team Depth Chart is missing"))
    },
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}

#' Get Lineups Last 5 Games from Team Page
#'
#'
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
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr select mutate filter
#' @importFrom glue glue
#' @importFrom stringr str_remove str_replace str_extract
#' @export
#'
#' @examples
#'   \dontrun{
#'     kp_team_lineups(team = 'Florida St.', year= 2020)
#'   }
#'

kp_team_lineups <- function(team, year= 2020){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()

  assertthat::assert_that(year >= 2010, msg = "Data only goes back to 2010")
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  teams_links <- kenpomR::teams_links[kenpomR::teams_links$Year == year,]
  team_name = teams_links$team.link.ref[teams_links$Team == team]


  ### Pull Data
  url <- paste0("https://kenpom.com/team.php?",
                "team=",team_name,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  tryCatch(
    expr = {
      depth2_header_cols<- c("Rk","PG", "SG", "SF",
                             "PF", "C", "Min.Pct")

      depth2<- (page %>%
                  xml2::read_html() %>%
                  rvest::html_elements(css='#dc-table2'))[[1]] %>%
        rvest::html_table() %>%
        as.data.frame()

      colnames(depth2) <- depth2_header_cols

      suppressWarnings(
        depth2 <- depth2 %>%
          dplyr::filter(!is.na(as.numeric(.data$Min.Pct)))
      )

      depth2 <- depth2 %>%
        dplyr::mutate(
          PG.Yr = substr(.data$PG, nchar(.data$PG)-2, nchar(.data$PG)),
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
          tidyr::separate(.data$PG, into = c("PG.Number", "PG.PlayerFirstName", "PG.PlayerLastName")) %>%
          tidyr::separate(.data$SG, into = c("SG.Number", "SG.PlayerFirstName", "SG.PlayerLastName")) %>%
          tidyr::separate(.data$SF, into = c("SF.Number", "SF.PlayerFirstName", "SF.PlayerLastName")) %>%
          tidyr::separate(.data$PF, into = c("PF.Number", "PF.PlayerFirstName", "PF.PlayerLastName")) %>%
          tidyr::separate(.data$C, into = c("C.Number", "C.PlayerFirstName", "C.PlayerLastName"))
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
          .data$Year, .data$Team, .data$Min.Pct,
          .data$PG.Number, .data$PG.PlayerFirstName,
          .data$PG.PlayerLastName, .data$PG.Hgt, .data$PG.Wgt, .data$PG.Yr,
          .data$SG.Number, .data$SG.PlayerFirstName,
          .data$SG.PlayerLastName, .data$SG.Hgt, .data$SG.Wgt, .data$SG.Yr,
          .data$SF.Number, .data$SF.PlayerFirstName,
          .data$SF.PlayerLastName, .data$SF.Hgt, .data$SF.Wgt, .data$SF.Yr,
          .data$PF.Number, .data$PF.PlayerFirstName,
          .data$PF.PlayerLastName, .data$PF.Hgt, .data$PF.Wgt, .data$PF.Yr,
          .data$C.Number, .data$C.PlayerFirstName,
          .data$C.PlayerLastName, .data$C.Hgt, .data$C.Wgt, .data$C.Yr)

      ### Store Data
      depth2[nrow(depth2),"PG.PlayerFirstName"]<- "UNKNOWN"
      depth2[nrow(depth2),"C.Number"] <- NA_real_
      depth2[nrow(depth2),"C.Yr"] <- NA_real_
      kenpom <- depth2

    },
    error = function(e){
      message(glue::glue("{Sys.time()} - {team} - {year} Team Lineups is missing"))
    },
    warning = function(w){

    },
    finally = {

    }
  )
  return(kenpom)
}



