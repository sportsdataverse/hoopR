suppressPackageStartupMessages(suppressMessages(library(rvest)))
suppressPackageStartupMessages(suppressMessages(library(dplyr)))
suppressPackageStartupMessages(suppressMessages(library(tidyr)))
suppressPackageStartupMessages(suppressMessages(library(stringr)))
suppressPackageStartupMessages(suppressMessages(library(magrittr)))
suppressPackageStartupMessages(suppressMessages(library(jsonlite)))
suppressPackageStartupMessages(suppressMessages(library(purrr)))
suppressPackageStartupMessages(suppressMessages(library(data.table)))
suppressPackageStartupMessages(suppressMessages(library(arrow)))
suppressPackageStartupMessages(suppressMessages(library(glue)))
suppressPackageStartupMessages(suppressMessages(library(optparse)))
years <- hoopR::most_recent_mbb_season():2002

browser <- hoopR::login()

all_teams_links <- data.frame()
for (year in years) {
  url <- paste0("https://kenpom.com/index.php?y=", year)
  page <- rvest::session_jump_to(browser, url)
  q <- (page %>%
          xml2::read_html() %>%
          rvest::html_elements("table > tbody > tr > td"))


  texts <- as.list(rvest::html_text(rvest::html_elements(q, "a")))
  y <- dplyr::bind_rows(lapply(xml2::xml_attrs(rvest::html_elements(q, "a")), function(x) data.frame(as.list(x), stringsAsFactors = FALSE)))

  y <- y %>%
    dplyr::mutate(ind = rep(c(1, 2), length.out = n())) %>%
    dplyr::group_by(ind) %>%
    dplyr::mutate(id = row_number()) %>%
    tidyr::spread("ind", "href") %>%
    dplyr::select(-"id") %>%
    dplyr::rename("Team.link" = 1,
                  "Conf.link" = 2) %>%
    dplyr::mutate(Team.link = stringr::str_remove(.data$Team.link, "&y(.+)"),
                  Conf.link = stringr::str_remove(.data$Conf.link, "&y(.+)"))
  z <- data.frame()
  z <- data.frame(texts = sapply(texts, unlist))

  z <- z %>%
    dplyr::mutate(ind = rep(c(1, 2), length.out = n())) %>%
    dplyr::group_by(ind) %>%
    dplyr::mutate(id = row_number()) %>%
    tidyr::spread("ind", "texts") %>%
    dplyr::select(-"id") %>%
    dplyr::rename(
      "Team" = 1,
      "Conf" = 2
    )

  team_links <- dplyr::bind_cols(z, y)
  team_links <- team_links %>%
    dplyr::arrange(.data$Team)

  nrow(team_links)

  team_links <- team_links %>%
    dplyr::mutate(
      team.link.ref = stringr::str_remove(stringr::str_extract(string = .data$Team.link,"=(.+)"),"=|&y(.+)"),
      conf.link.ref = stringr::str_remove(stringr::str_extract(string = .data$Conf.link,"=(.+)"),"=|&y(.+)")) %>%
    dplyr::select(
      "Team",
      "Team.link",
      "team.link.ref",
      "Conf",
      "Conf.link",
      "conf.link.ref") %>%
    dplyr::mutate(Year = year)
  all_teams_links <- dplyr::bind_rows(all_teams_links,team_links)
  Sys.sleep(5)
}
all_teams <- collapse::funique.data.frame(all_teams_links)

write.csv(all_teams, "data-raw/kp_team_info_2024.csv", row.names = FALSE)
# remotes::install_github("lbenz730/ncaahoopR")
all_teams_joined <- all_teams %>%
  dplyr::left_join(ncaahoopR::dict, by = c("Team" = "Trank"), keep = TRUE) %>%
  dplyr::filter(!is.na(.data$Trank))

anti_joined_all_teams <- all_teams %>%
  dplyr::anti_join(ncaahoopR::dict, by = c("Team" = "Trank"))

dict_hoopR <- data.table::fread("data-raw/dict_hoopR.csv")
espn_teams <- espn_mbb_teams()
ncaa_teams <- ncaa_mbb_teams(year = hoopR::most_recent_mbb_season(), division = 1)

dict_hoopR_joined <- dict_hoopR %>%
  dplyr::left_join(espn_teams, by = c("ESPN" = "team"), keep = TRUE) %>%
  dplyr::left_join(espn_teams, by = c("ESPN_PBP" = "team"))

# teams_links <- all_teams
# usethis::use_data(teams_links, overwrite = TRUE)
#
# teamlist <- data.frame(hoopR::teams_links)
#
# teamlist
