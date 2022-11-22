
# seasons <- paste0(2002:2018, gsub("0\\.", "-", sprintf("%.2f", seq(.03, .19, 0.01))))
# if(!dir.exists(seasons[j])) {
#   dir.create(seasons[j])
# }
gather_team_pages <- function(year, fp){
  year_players <- data.frame()
  year_team_schedules <- data.frame()
  year_coaches <- data.frame()
  year_depth1 <- data.frame()
  year_depth2 <- data.frame()
  teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
  teams =  teams_links$Team
  for(team in teams){
    # team = "Gonzaga"
    # team = "Alabama"
    # team = "Arkansas"
    # team = "Florida A&M"
    cat(team,"\n")
    team_name = teams_links$team.link.ref[teams_links$Team == team]

    url <- paste0("https://kenpom.com/team.php?",
                  "team=", team_name,
                  "&y=", year)

    page <- rvest::session_jump_to(browser, url)

    #---- Coach ----------------
    c <- (page %>%
            xml2::read_html() %>%
            rvest::html_elements(".coach"))[[1]]

    links <- as.list(rvest::html_elements(c, "a")[[1]])
    texts <- rvest::html_text(rvest::html_elements(c, "a"))

    coaches <- dplyr::bind_rows(lapply(xml2::xml_attrs(links),
                                       function(x){data.frame(as.list(x), stringsAsFactors=FALSE)}))
    colnames(coaches)<-"coach.link"
    coaches$coach = texts
    coaches = coaches[,order(ncol(coaches):1)]


    coaches <- coaches %>%
      dplyr::mutate(coach.link.ref = stringr::str_remove(stringr::str_extract(string = .data$coach.link,"=(.+)"),"=")) %>%
      dplyr::select(.data$coach, .data$coach.link, .data$coach.link.ref)

    coaches <- coaches %>% dplyr::mutate(team = team, year = year)
    year_coaches <- dplyr::bind_rows(year_coaches, coaches)
  #----- Schedule Table ------------------
    assertthat::assert_that(year>=2002, msg="Data only goes back to 2002")
    # Check teams parameter in teams list names
    assertthat::assert_that(team %in% hoopR::teams_links$Team,
                            msg = "Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
    teams_links <- hoopR::teams_links[hoopR::teams_links$Year == year,]
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

    tryCatch(
      expr = {
        sched <- (page %>%
                    xml2::read_html() %>%
                    rvest::html_elements(css='#schedule-table') %>%
                    rvest::html_table(fill=FALSE))[[1]] %>%
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
              W.Conference = ifelse((.data$W.Conference == "\u00d7")|(.data$W.Conference == ""), NA_real_,.data$W.Conference)
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
              stringr::str_detect(.data$Day.Date,regex("Apr",ignore_case=TRUE)) ~ stringr::str_pad(4, 2, pad="0")
            ),
            Date.YR = dplyr::case_when(
              stringr::str_detect(.data$Day.Date,regex("Oct",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
              stringr::str_detect(.data$Day.Date,regex("Nov",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
              stringr::str_detect(.data$Day.Date,regex("Dec",ignore_case=TRUE)) ~ glue::glue("{year-1}"),
              stringr::str_detect(.data$Day.Date,regex("Jan",ignore_case=TRUE)) ~ glue::glue("{year}"),
              stringr::str_detect(.data$Day.Date,regex("Feb",ignore_case=TRUE)) ~ glue::glue("{year}"),
              stringr::str_detect(.data$Day.Date,regex("Mar",ignore_case=TRUE)) ~ glue::glue("{year}"),
              stringr::str_detect(.data$Day.Date,regex("Apr",ignore_case=TRUE)) ~ glue::glue("{year}")
            ),
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
              toupper(
                stringr::str_replace(
                  stringr::str_extract(rvest::html_element(x, css = "a > img") %>%
                                         xml2::xml_attr("src"), "a.gif|b.gif"),
                  ".gif",""))),
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

        # if(year==2010){
        #   fm_links <- fm_links[1:length(fm_links)-1]
        # }
        # rvest::html_text(fm_links[[1]])

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
        sched <- sched %>%
          dplyr::arrange(.data$GameDate) %>%
          dplyr::mutate(Postseason = ifelse(is.na(.data$Postseason), "Regular", .data$Postseason))

        year_team_schedules <- dplyr::bind_rows(year_team_schedules, sched)
      },
      error = function(e){
        message(glue::glue("{Sys.time()} - {team} - {year} schedule missing"))
      },
      warning = function(w){

      },
      finally = {

      }
    )
    #---- Players table --------

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
        # pid <- dplyr::bind_rows(lapply(player_links, extractor))

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
          rvest::html_table(fill=FALSE)

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
        year_players <- dplyr::bind_rows(year_players, players)
      },
      error = function(e){
        message(glue::glue("{Sys.time()} - No Player Data available for {team} in {year}"))
      },
      warning = function(w){

      },
      finally = {

      }
    )

    if(year>=2010){
      #---- Team Depth Chart (last 5 games) ------------
      tryCatch(
        expr = {
          depth1_header_cols<- c("PG", "PG.Min.Pct", "SG", "SG.Min.Pct", "SF", "SF.Min.Pct",
                                 "PF", "PF.Min.Pct", "C", "C.Min.Pct")

          depth1 <- (page %>%
                       xml2::read_html() %>%
                       rvest::html_elements(css='#dc-table'))[[1]] %>%
            rvest::html_table(fill=FALSE) %>%
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
              PG.Wt = stringr::str_extract(.data$PG, '\\d{3}'),
              PG = stringr::str_trim(stringr::str_remove(.data$PG, '\\d{3}')),
              PG.Ht = stringr::str_extract(.data$PG, '\\d{1}-\\d{0,2}'),
              PG = stringr::str_remove(.data$PG, '\\d{1}-\\d{0,2}'),
              SG.Yr = substr(.data$SG, nchar(.data$SG) - 2, nchar(.data$SG)),
              SG = substr(.data$SG, 1, nchar(.data$SG) - 3),
              SG.Wt = stringr::str_extract(.data$SG, '\\d{3}'),
              SG = stringr::str_trim(stringr::str_remove(.data$SG, '\\d{3}')),
              SG.Ht = stringr::str_extract(.data$SG, '\\d{1}-\\d{0,2}'),
              SG = stringr::str_remove(.data$SG, '\\d{1}-\\d{0,2}'),
              SF.Yr = substr(.data$SF, nchar(.data$SF) - 2, nchar(.data$SF)),
              SF = substr(.data$SF, 1, nchar(.data$SF) - 3),
              SF.Wt = stringr::str_extract(.data$SF, '\\d{3}'),
              SF = stringr::str_trim(stringr::str_remove(.data$SF, '\\d{3}')),
              SF.Ht = stringr::str_extract(.data$SF, '\\d{1}-\\d{0,2}'),
              SF = stringr::str_remove(.data$SF, '\\d{1}-\\d{0,2}'),
              PF.Yr = substr(.data$PF, nchar(.data$PF) - 2, nchar(.data$PF)),
              PF = substr(.data$PF, 1, nchar(.data$PF) - 3),
              PF.Wt = stringr::str_extract(.data$PF,'\\d{3}'),
              PF = stringr::str_trim(stringr::str_remove(.data$PF,'\\d{3}')),
              PF.Ht = stringr::str_extract(.data$PF, '\\d{1}-\\d{0,2}'),
              PF = stringr::str_remove(.data$PF, '\\d{1}-\\d{0,2}'),
              C.Yr = substr(.data$C, nchar(.data$C) - 2, nchar(.data$C)),
              C = substr(.data$C, 1, nchar(.data$C) - 3),
              C.Wt = stringr::str_extract(.data$C, '\\d{3}'),
              C = stringr::str_trim(stringr::str_remove(.data$C, '\\d{3}')),
              C.Ht = stringr::str_extract(.data$C, '\\d{1}-\\d{0,2}'),
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
                PG.Wt = as.numeric(.data$PG.Wt),
                SG.Wt = as.numeric(.data$SG.Wt),
                SF.Wt = as.numeric(.data$SF.Wt),
                PF.Wt = as.numeric(.data$PF.Wt),
                C.Wt = as.numeric(.data$C.Wt))
          )
          depth1 <- depth1 %>%
            dplyr::select(
              .data$PG.Number, .data$PG.PlayerFirstName,
              .data$PG.PlayerLastName, .data$PG.Ht, .data$PG.Wt, .data$PG.Yr, .data$PG.Min.Pct,
              .data$SG.Number, .data$SG.PlayerFirstName,
              .data$SG.PlayerLastName, .data$SG.Ht, .data$SG.Wt, .data$SG.Yr, .data$SG.Min.Pct,
              .data$SF.Number, .data$SF.PlayerFirstName,
              .data$SF.PlayerLastName, .data$SF.Ht, .data$SF.Wt, .data$SF.Yr, .data$SF.Min.Pct,
              .data$PF.Number, .data$PF.PlayerFirstName,
              .data$PF.PlayerLastName, .data$PF.Ht, .data$PF.Wt, .data$PF.Yr, .data$PF.Min.Pct,
              .data$C.Number, .data$C.PlayerFirstName,
              .data$C.PlayerLastName, .data$C.Ht, .data$C.Wt, .data$C.Yr, .data$C.Min.Pct,
              .data$Team, .data$Year)

          ### Store Data
          year_depth1 <- dplyr::bind_rows(year_depth1, depth1)
        },
        error = function(e){
          message(glue::glue("{Sys.time()} - {team} - {year} depth chart 1 missing"))
        },
        warning = function(w){

        },
        finally = {

        }
      )

      #---- Team lineups (last 5 games) ------------
      tryCatch(
        expr = {
          depth2_header_cols<- c("Rk","PG", "SG", "SF",
                                 "PF", "C", "Min.Pct")

          depth2<- (page %>%
                      xml2::read_html() %>%
                      rvest::html_elements(css='#dc-table2'))[[1]] %>%
            rvest::html_table(fill=FALSE) %>%
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
              PG.Wt = stringr::str_extract(.data$PG, '\\d{3}'),
              PG = stringr::str_trim(stringr::str_remove(.data$PG, '\\d{3}')),
              PG.Ht = stringr::str_extract(.data$PG, '\\d{1}-\\d{0,2}'),
              PG = stringr::str_remove(.data$PG, '\\d{1}-\\d{0,2}'),
              SG.Yr = substr(.data$SG, nchar(.data$SG) - 2, nchar(.data$SG)),
              SG = substr(.data$SG, 1, nchar(.data$SG) - 3),
              SG.Wt = stringr::str_extract(.data$SG, '\\d{3}'),
              SG = stringr::str_trim(stringr::str_remove(.data$SG, '\\d{3}')),
              SG.Ht = stringr::str_extract(.data$SG, '\\d{1}-\\d{0,2}'),
              SG = stringr::str_remove(.data$SG, '\\d{1}-\\d{0,2}'),
              SF.Yr = substr(.data$SF, nchar(.data$SF) - 2, nchar(.data$SF)),
              SF = substr(.data$SF, 1, nchar(.data$SF) - 3),
              SF.Wt = stringr::str_extract(.data$SF, '\\d{3}'),
              SF = stringr::str_trim(stringr::str_remove(.data$SF, '\\d{3}')),
              SF.Ht = stringr::str_extract(.data$SF, '\\d{1}-\\d{0,2}'),
              SF = stringr::str_remove(.data$SF, '\\d{1}-\\d{0,2}'),
              PF.Yr = substr(.data$PF, nchar(.data$PF) - 2, nchar(.data$PF)),
              PF = substr(.data$PF, 1, nchar(.data$PF) - 3),
              PF.Wt = stringr::str_extract(.data$PF, '\\d{3}'),
              PF = stringr::str_trim(stringr::str_remove(.data$PF, '\\d{3}')),
              PF.Ht = stringr::str_extract(.data$PF, '\\d{1}-\\d{0,2}'),
              PF = stringr::str_remove(.data$PF, '\\d{1}-\\d{0,2}'),
              C.Yr = substr(.data$C, nchar(.data$C) - 2, nchar(.data$C)),
              C = substr(.data$C, 1, nchar(.data$C) - 3),
              C.Wt = stringr::str_extract(.data$C, '\\d{3}'),
              C = stringr::str_trim(stringr::str_remove(.data$C, '\\d{3}')),
              C.Ht = stringr::str_extract(.data$C, '\\d{1}-\\d{0,2}'),
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
                PG.Wt = as.numeric(.data$PG.Wt),
                SG.Wt = as.numeric(.data$SG.Wt),
                SF.Wt = as.numeric(.data$SF.Wt),
                PF.Wt = as.numeric(.data$PF.Wt),
                C.Wt = as.numeric(.data$C.Wt))
          )
          depth2 <- depth2 %>%
            dplyr::mutate(Team = team,
                          Year = year) %>%
            dplyr::select(
              .data$Year, .data$Team, .data$Min.Pct,
              .data$PG.Number, .data$PG.PlayerFirstName,
              .data$PG.PlayerLastName, .data$PG.Ht, .data$PG.Wt, .data$PG.Yr,
              .data$SG.Number, .data$SG.PlayerFirstName,
              .data$SG.PlayerLastName, .data$SG.Ht, .data$SG.Wt, .data$SG.Yr,
              .data$SF.Number, .data$SF.PlayerFirstName,
              .data$SF.PlayerLastName, .data$SF.Ht, .data$SF.Wt, .data$SF.Yr,
              .data$PF.Number, .data$PF.PlayerFirstName,
              .data$PF.PlayerLastName, .data$PF.Ht, .data$PF.Wt, .data$PF.Yr,
              .data$C.Number, .data$C.PlayerFirstName,
              .data$C.PlayerLastName, .data$C.Ht, .data$C.Wt, .data$C.Yr)


          depth2[nrow(depth2),"PG.PlayerFirstName"]<- "UNKNOWN"
          depth2[nrow(depth2),"C.Number"] <- NA_real_
          depth2[nrow(depth2),"C.Yr"] <- NA_real_

          ### Store Data
          year_depth2 <- dplyr::bind_rows(year_depth2, depth2)

        },
        error = function(e){
          message(glue::glue("{Sys.time()} - {team} - {year} depth chart 2 missing"))
        },
        warning = function(w){
        },
        finally = {
        }
      )
    }
    Sys.sleep(1)
  }

  readr::write_csv(year_players, glue::glue("{fp}/players_{year}.csv"))
  readr::write_csv(year_coaches, glue::glue("{fp}/coaches_{year}.csv"))
  readr::write_csv(year_team_schedules, glue::glue("{fp}/team_schedules_{year}.csv"))
  saveRDS(year_players, glue::glue("{fp}/players_{year}.rds"))
  saveRDS(year_coaches, glue::glue("{fp}/coaches_{year}.rds"))
  saveRDS(year_team_schedules, glue::glue("{fp}/team_schedules_{year}.rds"))
  arrow::write_parquet(year_players, glue::glue("{fp}/players_{year}.parquet"))
  arrow::write_parquet(year_coaches, glue::glue("{fp}/coaches_{year}.parquet"))
  arrow::write_parquet(year_team_schedules, glue::glue("{fp}/team_schedules_{year}.parquet"))

  if(year>=2010){
    readr::write_csv(year_depth1, glue::glue("{fp}/year_depth1_{year}.csv"))
    readr::write_csv(year_depth2, glue::glue("{fp}/year_depth2_{year}.csv"))
    saveRDS(year_depth1, glue::glue("{fp}/year_depth1_{year}.rds"))
    saveRDS(year_depth2, glue::glue("{fp}/year_depth2_{year}.rds"))
    arrow::write_parquet(year_depth1, glue::glue("{fp}/year_depth1_{year}.parquet"))
    arrow::write_parquet(year_depth2, glue::glue("{fp}/year_depth2_{year}.parquet"))
  }
}
