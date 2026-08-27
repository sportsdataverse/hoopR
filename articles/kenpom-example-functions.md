# KenPom Example Functions

### Ratings Table Function examples

``` r

#---- kp_ratings_tables.R ----------------
pomeroy_ratings <- kp_pomeroy_ratings(min_year = 2020, max_year = 2020)

efficiency <- kp_efficiency(min_year = 2020, max_year = 2020)

fourfactors <- kp_fourfactors(min_year = 2020, max_year = 2020)

pointdist <- kp_pointdist(min_year = 2020, max_year = 2020)

height <- kp_height(min_year = 2020, max_year = 2020)

teamstats <- kp_teamstats(min_year = 2020, max_year = 2020)

playerstats <- kp_playerstats(metric = 'eFG', conf_only = FALSE, year = 2020)

kpoy <- kp_kpoy(year = 2020)
```

### Team Tables

``` r

#---- kp_team_tables.R -------------------
team_sched <- kp_team_schedule(team = 'Florida St.', year = 2020)

gameplan <- kp_gameplan(team = 'Florida St.', year = 2020)

opptracker <- kp_opptracker(team = 'Florida St.', year = 2020)

team_players <- kp_team_players(team = 'Florida St.', year = 2020)

minutes_matrix <- kp_minutes_matrix(team = 'Florida St.', year = 2020)

team_player_stats <- kp_team_player_stats(team = 'Florida St.', year = 2020)

team_player_stats1 <- team_player_stats[[1]]

team_player_stats2 <- team_player_stats[[2]]

team_depth_chart <- kp_team_depth_chart(team = 'Florida St.', year = 2020)

team_lineups <- kp_team_lineups(team = 'Florida St.', year = 2020)
```

### Historical Tables

``` r

#---- kp_historical_tables.R ------------
team_history <- kp_team_history(team = 'Florida St.')

coach_history <- kp_coach_history(coach = 'Leonard Hamilton')

program_ratings <- kp_program_ratings()

# records_team appears to be working but there isn't anything
# there anymore at the moment for all years
# records_team <- get_records_team(browser, team = 'Florida St.')

pomeroy_archive_ratings <- kp_pomeroy_archive_ratings(date = '2018-11-22')

conf <- kp_conf(year = '2020',conf = 'ACC')

conf_stats <- kp_confstats(year = '2020')

conf_history <- kp_confhistory(conf = 'ACC')
```

### Miscellaneous Stats Tables

``` r

#---- kp_misc_stats.R ------------------
trends <- kp_trends()


officials <- kp_officials(year = 2020)

hca <- kp_hca()


arenas <- kp_arenas(year = 2020)



game_attrs <- kp_game_attrs(year = 2020, attr = "Excitement")

fanmatch <- kp_fanmatch(date = "2020-03-10")
```

## **Our Authors**

- [Saiem Gilani](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge)](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge)](https://github.com/saiemgilani)

### **Our Contributors**

- [Jason Lee](https://x.com/theFirmAISports)
  [![@theFirmAISports](https://img.shields.io/twitter/follow/theFirmAISports?color=blue&label=%40theFirmAISports&logo=x&style=for-the-badge)](https://x.com/theFirmAISports)
  [![@papagorgio23](https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge)](https://github.com/papagorgio23)
- [Billy Fryer](https://x.com/BillyFryer42)
  [![@BillyFryer42](https://img.shields.io/twitter/follow/BillyFryer42?color=blue&label=%40BillyFryer42&logo=x&style=for-the-badge)](https://x.com/BillyFryer42)
  [![@billyfryer](https://img.shields.io/github/followers/billyfryer?color=eee&logo=Github&style=for-the-badge)](https://github.com/billyfryer)
- [Ross Drucker](https://x.com/rossdrucker9)
  [![@rossdrucker9](https://img.shields.io/twitter/follow/rossdrucker9?color=blue&label=%40rossdrucker9&logo=x&style=for-the-badge)](https://x.com/rossdrucker9)
  [![@rossdrucker](https://img.shields.io/github/followers/rossdrucker?color=eee&logo=Github&style=for-the-badge)](https://github.com/rossdrucker)
- [Vladislav Shufinskiy](https://x.com/vshufinskiy)
  [![@vshufinskiy](https://img.shields.io/twitter/follow/vshufinskiy?color=blue&label=%40vshufinskiy&logo=x&style=for-the-badge)](https://x.com/vshufinskiy)
  [![@shufinskiy](https://img.shields.io/github/followers/shufinskiy?color=eee&logo=Github&style=for-the-badge)](https://github.com/shufinskiy)

### **Citation**

To cite the [**`hoopR`**](https://hoopR.sportsdataverse.org/) R package
in publications, use:

BibTeX Citation

``` bibtex
@misc{hoopr,
  author = {Saiem Gilani},
  title = {hoopR: Access Men’s Basketball Play by Play Data.},
  url = {https://hoopR.sportsdataverse.org/},
  year = {2026}
}
```

### **Related SportsDataverse packages**

- [**cfbfastR**](https://cfbfastR.sportsdataverse.org/) - college
  football
- [**hoopR**](https://hoopR.sportsdataverse.org/) - men’s basketball
- [**wehoop**](https://wehoop.sportsdataverse.org/) - women’s basketball
- [**baseballr**](https://baseballr.sportsdataverse.org/) - baseball
- [**fastRhockey**](https://fastRhockey.sportsdataverse.org/) - hockey
- [**oddsapiR**](https://oddsapiR.sportsdataverse.org/) - betting odds
- [**sportyR**](https://sportyR.sportsdataverse.org/) - playing surfaces
- [**sportsdataverse-py**](https://py.sportsdataverse.org/) - the Python
  package
- [**sportsdataverse-R**](https://r.sportsdataverse.org/) - the R
  meta-package
