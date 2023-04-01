library(hoopR)
library(dplyr)


x <- ncaa_mbb_teams(year = 2023, division = 1)

x <- x %>%
  dplyr::arrange(.data$team_name)
y <- espn_mbb_teams()

x %>%
  dplyr::left_join(y, by = c("team"))
