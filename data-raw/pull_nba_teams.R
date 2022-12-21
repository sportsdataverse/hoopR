library(hoopR)
library(dplyr)

season <- hoopR::year_to_season(1975)
standings <- nba_leaguestandingsv3(season = season)$Standings
nba_teams <- standings %>%
  dplyr::select(c("LeagueID","SeasonID","TeamID", "TeamCity", "TeamName","TeamSlug","Conference","Division")) %>%
  dplyr::mutate(
    Season = paste0('',season),
    TeamNameFull = paste(.data$TeamCity,.data$TeamName)) %>%
  dplyr::arrange(.data$TeamNameFull)

espn_nba_teams <- espn_nba_teams() %>%
  dplyr::rename("espn_team_id"="team_id")
nba_teams <- nba_teams %>%
  dplyr::left_join(espn_nba_teams, by=c("TeamName"="short_name"))

nba_teams <- nba_teams %>%
  dplyr::mutate(
    espn_team_id = as.integer(.data$espn_team_id),

  )

nba_teams <- collapse::funique.data.frame(nba_teams)

write.csv(nba_teams, "data-raw/nba_teams.csv", row.names=FALSE)
nba_teams <- nba_teams
usethis::use_data(nba_teams, overwrite = TRUE)
