# **hoopR 1.0.1**

### **Dependency pruning**
This update is a non-user facing change to package dependencies to shrink the list of dependencies.

# **hoopR 1.0.0**

### **Package renamed to hoopR**
To reflect that the package is no longer just a men's college basketball and KenPom package, but also an NBA package. 

### **Clean names and team returns**
- All functions have now been given the [```janitor::clean_names()```](https://rdrr.io/cran/janitor/man/clean_names.html) treatment
- [```hoopR::espn_mbb_teams()```](https://saiemgilani.github.io/hoopR/reference/espn_mbb_teams.html) has updated the returns to be more identity information related only
- [```hoopR::espn_nba_teams()```](https://saiemgilani.github.io/hoopR/reference/espn_nba_teams.html) to be more identity information related only
- All tests were updated

### **Loading capabilities added to the package**
- [```hoopR::load_mbb_pbp()```](https://saiemgilani.github.io/hoopR/reference/load_mbb_pbp.html) and [```hoopR::update_mbb_db()```](https://saiemgilani.github.io/hoopR/reference/update_mbb_db.html) functions added
- [```hoopR::load_nba_pbp()```](https://saiemgilani.github.io/hoopR/reference/load_nba_pbp.html) and [```hoopR::update_nba_db()```](https://saiemgilani.github.io/hoopR/reference/update_nba_db.html) functions added

# **hoopR 0.4**

- Added support for ESPN's NBA play-by-play endpoints with the addition of the following functions:
- ```hoopR::espn_nba_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```hoopR::espn_nba_team_box()```
- ```hoopR::espn_nba_player_box()```
- ```hoopR::espn_nba_pbp()```
- ```hoopR::espn_nba_teams()``` 
- ```hoopR::espn_nba_scoreboard()``` 

# **hoopR 0.3.0**

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


# **hoopR 0.2.0-3**

- Added support for ESPN's men's college basketball play-by-play endpoints with the addition of the following functions:
- ```hoopR::espn_mbb_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```hoopR::espn_mbb_team_box()```
- ```hoopR::espn_mbb_player_box()```
- ```hoopR::espn_mbb_pbp()```
- ```hoopR::espn_mbb_teams()``` (bumps to v0.2.1)
- ```hoopR::espn_mbb_conferences()``` (bumps to v0.2.1)
- ```hoopR::espn_mbb_scoreboard()``` (bumps to v0.2.2)
- ```hoopR::ncaa_mbb_NET_rankings()``` (bumps to v0.2.3)
- ```hoopR::espn_mbb_rankings()``` (bumps to v0.2.3)

# **hoopR 0.1.0** 

-    Minor fixes

# **hoopR 0.0.0.9**

Initial Commits, remaining tasks:

-   Game Prep Tables
-   ~~Player Career Tables~~
-   ~~Game Box Scores~~
-   ~~Argument assertions~~
