#' **Get KenPom Game Box Score**
#'
#' @param game_id Game id of game to pull
#' @param year Year of game to pull
#' @returns Returns a tibble of game box scores with names: away_team, home_team,
#'  linescore, officials
#'
#'    **away_team**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       hgt \tab character \tab Hgt. \cr
#'       wgt \tab numeric \tab Wgt. \cr
#'       yr \tab character \tab Yr. \cr
#'       number \tab numeric \tab Number. \cr
#'       player \tab character \tab Player. \cr
#'       min \tab numeric \tab Minutes played. \cr
#'       o_rtg \tab numeric \tab O rtg. \cr
#'       percent_ps \tab numeric \tab Percent ps. \cr
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
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       wp_note \tab character \tab Wp note. \cr
#'       game_id \tab numeric \tab Unique game identifier. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **home_team**
#'
#'
#'    Same columns as the **away_team** table above.
#'
#'    **linescore**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       q1 \tab integer \tab Q1. \cr
#'       q2 \tab integer \tab Q2. \cr
#'       q3 \tab integer \tab Q3. \cr
#'       q4 \tab integer \tab Q4. \cr
#'       t \tab integer \tab T. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **officials**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       official_id \tab character \tab Unique official / referee identifier. \cr
#'       official_name \tab character \tab Official name. \cr
#'       game_id \tab numeric \tab Unique game identifier. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate arrange bind_rows mutate_at rename
#' @importFrom tidyr everything separate
#' @import rvest
#' @import stringr
#' @export
#' @keywords Game Box Score
#' @family KenPom Boxscore Functions
#'
#' @examples
#' \donttest{
#' try(kp_box(game_id = 6, year = 2021))
#' }
kp_box <- function(game_id, year) {
  .args <- mget(setdiff(names(formals()), "..."))
  kenpom <- NULL

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

      browser <- login()

      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2013)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2013")
      }
      ### Pull Data
      url <- paste0(
        "https://kenpom.com/box.php?",
        "g=", game_id,
        "&y=", year
      )


      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      teams <- page %>%
        rvest::html_elements(".teamnav") %>%
        rvest::html_elements("b > a")
      teams <- dplyr::bind_rows(lapply(
        rvest::html_text(teams),
        function(x) {
          data.frame(Team = x)
        }
      ))


      refs <- (page %>%
        rvest::html_elements("div.refline") %>%
        rvest::html_elements("a"))[-1]

      ref_ranks <- page %>%
        rvest::html_elements("div.refline") %>%
        rvest::html_elements(".seed")
      ref_ranks <- dplyr::bind_rows(lapply(
        rvest::html_text(ref_ranks),
        function(x) {
          data.frame(Official.Rk = x)
        }
      ))


      ref_ids <- dplyr::bind_rows(lapply(
        xml2::xml_attrs(refs),
        function(x) {
          data.frame(as.list(x))
        }
      ))
      if (length(ref_ids) > 0) {
        ref_ids <- ref_ids %>%
          dplyr::filter(stringr::str_detect(.data$href, "referee")) %>%
          dplyr::mutate(ref_id = stringr::str_remove(stringr::str_remove(
            stringi::stri_extract_first_regex(.data$href, "=(.+)"), "="
          ), "&(.+)")) %>%
          dplyr::select("ref_id") %>%
          dplyr::rename("OfficialId" = "ref_id")
      }

      ref_names <- dplyr::bind_rows(lapply(
        rvest::html_text(refs),
        function(x) {
          data.frame(OfficialName = x)
        }
      ))

      ref_table <- dplyr::bind_cols(ref_ids, ref_names)
      ref_table$GameId <- game_id
      ref_table$Year <- year
      ref_table <- ref_table %>%
        janitor::clean_names()
      linescore <- ((page %>%
        rvest::html_elements("#linescore-table2"))[[1]]) %>%
        rvest::html_table()

      names(linescore)[1] <- "Team"
      linescore <- linescore %>%
        janitor::clean_names()
      y <- list()
      for (i in 1:2) {
        x <- (page %>%
          rvest::html_elements(".box-table"))[[i]]


        box_stat <- x %>%
          rvest::html_elements(".box-stat")
        xml2::xml_remove(box_stat)

        x <- x %>%
          rvest::html_table()
        x$Team <- teams[i, ]
        x$WP.Note <- NA_character_
        x$WP.Note <- x[nrow(x), 1][[1]]
        x <- x[1:(nrow(x) - 1), ]
        header_cols <- c(
          "Hgt-Wgt-Yr", "Number", "Player", "Min",
          "ORtg", "%Ps", "Pts", "FGM2-A", "FGM3-A",
          "FTM-A", "OR", "DR", "A",
          "TO", "Blk", "Stl", "PF", "Team", "WP.Note"
        )

        colnames(x) <- header_cols

        # box <- xml2::xml_text(box_stat)
        suppressWarnings(
          x <- x %>%
            tidyr::separate(
              col = "Hgt-Wgt-Yr",
              into = c("Hgt", "Wgt", "Yr"),
              sep = "\\s"
            ) %>%
            tidyr::separate(
              col = "FGM2-A",
              into = c("FGM_2", "FGA_2"),
              sep = "-"
            ) %>%
            tidyr::separate(
              col = "FGM3-A",
              into = c("FGM_3", "FGA_3"),
              sep = "-"
            ) %>%
            tidyr::separate(
              col = "FTM-A",
              into = c("FTM", "FTA"),
              sep = "-"
            ) %>%
            dplyr::mutate_at(c(
              "Wgt", "Number", "Min",
              "ORtg", "%Ps", "Pts",
              "FGM_2", "FGA_2",
              "FGM_3", "FGA_3",
              "FTM", "FTA",
              "OR", "DR", "A", "TO",
              "Blk", "Stl", "PF"
            ), as.numeric)
        )
        x <- x %>%
          dplyr::mutate(
            GameId = game_id,
            Year = year
          ) %>%
          janitor::clean_names()
        y <- c(y, list(x))
      }
      ### Store Data
      kenpom <- c(y, list(linescore), list(ref_table))
      names(kenpom) <- c("away_team", "home_team", "linescore", "officials")
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no box data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(kenpom)
}

#' **Get KenPom Win Probability**
#'
#' @rdname kp_box
#' @param game_id Game id of game to pull
#' @param year Year of game to pull
#' @return Returns a named list of tibbles: winprob_dataset, game_data, runs
#'
#'    **winprob_dataset**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       period \tab integer \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'       wp \tab numeric \tab Wp. \cr
#'       time_left \tab numeric \tab Time left. \cr
#'       visitor_score \tab integer \tab Visitor score. \cr
#'       home_score \tab integer \tab Home team score at the time of the play. \cr
#'       visitor_scoring \tab integer \tab Visitor scoring. \cr
#'       home_scoring \tab integer \tab Home team's scoring. \cr
#'       possession_team \tab character \tab Possession team. \cr
#'       possession_number \tab character \tab Possession number. \cr
#'       game_id \tab numeric \tab Unique game identifier. \cr
#'       year \tab numeric \tab 4-digit year. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **game_data**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       year \tab integer \tab 4-digit year. \cr
#'       full_date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       game_time \tab character \tab Game start time. \cr
#'       venue \tab character \tab Venue name. \cr
#'       city \tab character \tab City. \cr
#'       team1 \tab character \tab Team1. \cr
#'       team1score \tab integer \tab Team1score. \cr
#'       team1_rk \tab character \tab Team1 rk. \cr
#'       team2 \tab character \tab Team2. \cr
#'       team2score \tab integer \tab Team2score. \cr
#'       team2_rk \tab character \tab Team2 rk. \cr
#'       dominance_season_rk \tab character \tab Dominance season rk. \cr
#'       tension_season_rk \tab character \tab Tension season rk. \cr
#'       excitement_season_rk \tab character \tab Excitement season rk. \cr
#'       lead_changes_season_rk \tab character \tab Lead changes season rk. \cr
#'       minimum_wp_season_rk \tab character \tab Minimum wp season rk. \cr
#'       dominance_rk \tab character \tab Dominance rk. \cr
#'       tension_rk \tab character \tab Tension rk. \cr
#'       excitement_rk \tab character \tab Excitement rk. \cr
#'       lead_changes_rk \tab character \tab Lead changes rk. \cr
#'       minimum_wp_rk \tab character \tab Minimum wp rk. \cr
#'       dominance \tab character \tab Dominance. \cr
#'       tension \tab character \tab Tension. \cr
#'       excitement \tab character \tab Excitement. \cr
#'       favchg \tab character \tab Favchg. \cr
#'       min_wp \tab character \tab Min wp. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **runs**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       start \tab numeric \tab Start. \cr
#'       end \tab numeric \tab End. \cr
#'       visitor \tab integer \tab Visitor. \cr
#'       home \tab integer \tab Home. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate arrange bind_rows bind_cols rename
#' @importFrom tidyr everything
#' @importFrom stringr str_remove str_extract_all
#' @import rvest
#' @export
#' @keywords Win Probability
#' @family KenPom Boxscore Functions
#'
#' @examples
#' \donttest{
#' try(kp_winprob(game_id = 1238, year = 2020))
#' }
kp_winprob <- function(game_id, year) {
  .args <- mget(setdiff(names(formals()), "..."))

  kenpom <- list()

  tryCatch(
    expr = {
      if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
      browser <- login()
      if (!(is.numeric(year) && nchar(year) == 4 && year >= 2010)) {
        # Check if year is numeric, if not NULL
        cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
      }
      url <- paste0(
        "https://kenpom.com/winprob.php?",
        "g=", game_id,
        "&y=", year
      )

      page <- .kp_get_page(browser, url)
      Sys.sleep(5)
      q <- (page %>%
        rvest::html_elements("#content-header") %>%
        rvest::html_elements("script")) %>%
        rvest::html_text2()

      # KenPom relocated the win-probability payload from the 2nd <script>
      # under #content-header to the 1st. Locate it by content (the script
      # that declares `var dataset=`) rather than a hard-coded position, and
      # fall back to scanning every <script> on the page if the header
      # scoping ever changes again.
      wp_script <- q[which(grepl("var dataset=", q))[1]]
      if (length(wp_script) == 0 || is.na(wp_script)) {
        all_scripts <- page %>%
          rvest::html_elements("script") %>%
          rvest::html_text2()
        wp_script <- all_scripts[which(grepl("var dataset=", all_scripts))[1]]
      }
      if (length(wp_script) == 0 || is.na(wp_script)) {
        cli::cli_abort("No win probability data found for game {game_id} ({year}).")
      }

      r <- stringr::str_extract(stringr::str_remove(wp_script, "var dataset="), "(.+?)(?=; var runs=)")
      r <- gsub("'", '"', r)
      wp_dataset <- purrr::map_dfr(c(r), jsonlite::fromJSON)

      wp_dataset$GameId <- game_id
      wp_dataset$Year <- year
      wp_dataset <- wp_dataset %>%
        janitor::clean_names() %>%
        dplyr::rename(
          "Period" = "pd",
          "TimeLeft" = "tl",
          "VisitorScore" = "vs",
          "HomeScore" = "hs",
          "VisitorScoring" = "v_sc",
          "HomeScoring" = "h_sc",
          "PossessionTeam" = "p",
          "PossessionNumber" = "pn"
        ) %>%
        janitor::clean_names()
      run_str <- stringr::str_extract(stringr::str_remove(wp_script, "(.+)var runs="), "(.+?)(?=; var data=)")
      run_str <- gsub("'", '"', run_str)
      runs <- purrr::map_dfr(c(run_str), jsonlite::fromJSON)
      runs <- runs %>%
        dplyr::rename(
          "visitor" = "V",
          "home" = "H",
          "start" = "Start",
          "end" = "End"
        )
      #---- game_data --------
      game_data_str <- stringr::str_remove(stringr::str_remove(wp_script, "(.+)var data="), "makeWP\\(data\\);")
      vn <- data.frame(vn = t(gsub(pattern = "'", "", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(wp_script, pattern = "venue:\'(.+)\', city:"), pattern = ", city:"), pattern = "venue:"))))
      cty <- data.frame(cty = t(gsub(pattern = "'", "", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(wp_script, pattern = "city:\'(.+)\', gameTime:"), pattern = ", gameTime:"), pattern = "city:"))))
      gmtm <- data.frame(gmtm = t(gsub(pattern = "'", "", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(wp_script, pattern = "gameTime:\'(.+)\', dominance:"), pattern = ", dominance:"), pattern = "gameTime:"))))
      dateofgame <- data.frame(dateofgame = t(gsub(pattern = "'", "", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(wp_script, pattern = "dateOfGame:\'(.+)\', ymd:"), pattern = ", ymd:"), pattern = "dateOfGame:"))))
      game_data_str <- stringr::str_remove(game_data_str, pattern = "venue:\'(.+)\',(?= city:)")
      game_data_str <- stringr::str_remove(game_data_str, pattern = "city:\'(.+)\',(?= gameTime:)")
      game_data_str <- stringr::str_remove(game_data_str, pattern = "gameTime:\'(.+)\',(?= dominance:)")
      game_data_str <- stringr::str_remove(game_data_str, pattern = "dateOfGame:\'(.+)\',(?= ymd:)")
      game_data_str <- stringr::str_remove(game_data_str, pattern = ", input:(.+)(?=\\})")
      game_data_str <- gsub("\\{ ", '\\{ "', game_data_str)
      game_data_str <- gsub(", ", ', "', game_data_str)
      game_data_str <- gsub(":", '":', game_data_str)
      game_data_str <- gsub("'", '"', game_data_str)
      game_data_str <- paste0("[", game_data_str, "]")
      game_data <- purrr::map_dfr(c(game_data_str), jsonlite::fromJSON)
      game_data <- dplyr::bind_cols(game_data, vn, cty, gmtm, dateofgame)
      colnames(game_data) <- gsub(" ", "", colnames(game_data))
      game_data <- game_data %>%
        dplyr::rename(
          "GameId" = "gid",
          "Full.Date" = "dateofgame",
          "Date" = "ymd",
          "GameTime" = "gmtm",
          "Venue" = "vn",
          "City" = "cty",
          "Team1.Rk" = "rank1",
          "Team1" = "team1",
          "Team1Score" = "score1",
          "Team2.Rk" = "rank2",
          "Team2" = "team2",
          "Team2Score" = "score2",
          "Dominance.Season.Rk" = "srank_dominance",
          "Tension.Season.Rk" = "srank_tension",
          "Excitement.Season.Rk" = "srank_excitement",
          "LeadChanges.Season.Rk" = "srank_favchg",
          "MinimumWP.Season.Rk" = "srank_minWP",
          "Dominance.Rk" = "rank_dominance",
          "Tension.Rk" = "rank_tension",
          "Excitement.Rk" = "rank_excitement",
          "LeadChanges.Rk" = "rank_favchg",
          "MinimumWP.Rk" = "rank_minWP"
        ) %>%
        janitor::clean_names()
      game_data <- game_data %>%
        dplyr::select(
          "game_id",
          "year",
          "full_date",
          "date",
          "game_time",
          "venue",
          "city",
          "team1",
          "team1score",
          "team1_rk",
          "team2",
          "team2score",
          "team2_rk",
          "dominance_season_rk",
          "tension_season_rk",
          "excitement_season_rk",
          "lead_changes_season_rk",
          "minimum_wp_season_rk",
          "dominance_rk",
          "tension_rk",
          "excitement_rk",
          "lead_changes_rk",
          "minimum_wp_rk",
          dplyr::everything()
        )
      kenpom <- list(wp_dataset, game_data, runs)
      names(kenpom) <- c("winprob_dataset", "game_data", "runs")
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no win probability data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )

  return(kenpom)
}
