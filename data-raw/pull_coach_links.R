library(rvest)
library(xml2)
library(jsonlite)
library(assertthat)
library(purrr)
library(dplyr)
library(tidyr)
library(stringr)
team = "Florida St."
year=2020
browser <- login(Sys.getenv("kp_user"),Sys.getenv("kp_pw"))
# Check teams parameter in teams list names
assertthat::assert_that(team %in% hoopR::teams_links$Team,
                        msg = "Incorrect team name as compared to the website, see hoopR::teams_links for team name parameter specifications.")
team_name = hoopR::teams_links$team.link.ref[hoopR::teams_links$Team == team]

url <- paste0("https://kenpom.com/team.php?",
              "team=", team_name,
              "&y=", year)

page <- rvest::session_jump_to(browser, url)
q <- (page %>%
        xml2::read_html() %>%
        rvest::html_elements(".coach"))[[1]]

links <- as.list(html_elements(q, "a")[[1]])
texts <- html_text(html_elements(q, "a"))[[1]]
coaches <- data.frame()
coaches <- data.frame(lapply(xml_attrs(links), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))
colnames(coaches)<-"coach.link"
coaches$coach = texts
coaches = coaches[,order(ncol(coaches):1)]


coaches <- coaches %>%
  mutate(
    coach.link.ref = stringr::str_remove(stringr::str_extract(string = .data$coach.link,"=(.+)"),"=")) %>%
  select(.data$coach, .data$coach.link, .data$coach.link.ref)

y <- x %>%
  mutate(ind = rep(c(1, 2), length.out = n())) %>%
  group_by(ind) %>%
  mutate(id = row_number()) %>%
  spread(ind, href) %>%
  select(-id) %>%
  rename(
    "Team.link"=.data$`1`,
    "Conf.link"=.data$`2`
  )
w <- data.frame()
w <- data.frame(texts = sapply(texts, unlist))

z <- w %>%
  mutate(ind = rep(c(1, 2), length.out = n())) %>%
  group_by(ind) %>%
  mutate(id = row_number()) %>%
  spread(ind, texts) %>%
  select(-id) %>%
  rename(
    "Team"=.data$`1`,
    "Conf"=.data$`2`
  )

teams_links <- bind_cols(z, y)
teams_links <- teams_links %>%
  arrange(.data$Team)

nrow(teams_links)



write.csv(teams_links, "kp_team_info.csv", row.names=FALSE)
usethis::use_data(teams_links, overwrite = TRUE)


teamlist <- data.frame(hoopR::teams_links)


teamlist








