# **kenpomR 0.4**

- Added support for ESPN's NBA play-by-play endpoints with the addition of the following functions:
- ```kenpomR::espn_nba_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```kenpomR::espn_nba_team_box()```
- ```kenpomR::espn_nba_player_box()```
- ```kenpomR::espn_nba_pbp()```
- ```kenpomR::espn_nba_teams()``` 
- ```kenpomR::espn_nba_scoreboard()``` 

# **kenpomR 0.3.0**

## Dependencies
- ```R``` version 3.5.0 or greater dependency added
- ```purrr``` version 0.3.0 or greater dependency added
- ```rvest``` version 1.0.0 or greater dependency added
- ```progressr``` version 0.6.0 or greater dependency added
- ```usethis``` version 1.6.0 or greater dependency added
- ```xgboost``` version 1.1.0 or greater dependency added
- ```tidyr``` version 1.0.0 or greater dependency added
- ```stringr``` version 1.3.0 or greater dependency added
- ```tibble``` version 3.0.0 or greater dependency added
- ```furrr``` dependency added
- ```future``` dependency added

## **Test coverage**

* Added tests for all KP and ESPN functions

#### **Function Naming Convention Change**

* All functions sourced from [kenpom.com](https://www.kenpom.com/) will start with `kp_` as opposed to `get_` 

* Similarly, data and metrics sourced from ESPN will begin with `espn_` as opposed to `cbb_`. Moreover, all references to `cbb_` have been changed to `mbb_` as appropriate.

* Data sourced directly from the NCAA website will start the function with `ncaa_`


# **kenpomR 0.2.0-3**

- Added support for ESPN's men's college basketball play-by-play endpoints with the addition of the following functions:
- ```kenpomR::espn_mbb_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```kenpomR::espn_mbb_team_box()```
- ```kenpomR::espn_mbb_player_box()```
- ```kenpomR::espn_mbb_pbp()```
- ```kenpomR::espn_mbb_teams()``` (bumps to v0.2.1)
- ```kenpomR::espn_mbb_conferences()``` (bumps to v0.2.1)
- ```kenpomR::espn_mbb_scoreboard()``` (bumps to v0.2.2)
- ```kenpomR::ncaa_mbb_NET_rankings()``` (bumps to v0.2.3)
- ```kenpomR::espn_mbb_rankings()``` (bumps to v0.2.3)

# **kenpomR 0.1.0** 

-    Minor fixes

# **kenpomR 0.0.0.9**

Initial Commits, remaining tasks:

-   Game Prep Tables
-   ~~Player Career Tables~~
-   ~~Game Box Scores~~
-   ~~Argument assertions~~
