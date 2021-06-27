
# 

# hoopR <a href='http://saiemgilani.github.io/hoopR'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![Version-Number](https://img.shields.io/github/r-package/v/saiemgilani/hoopR?label=hoopR&logo=R&style=for-the-badge)](https://github.com/saiemgilani/hoopR/)
[![R-CMD-check](https://img.shields.io/github/workflow/status/saiemgilani/hoopR/R-CMD-check?label=R-CMD-Check&logo=R&logoColor=blue&style=for-the-badge)](https://github.com/saiemgilani/hoopR/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=for-the-badge&logo=github)](https://github.com/saiemgilani/hoopR/)
[![Twitter
Follow](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge)](https://twitter.com/saiemgilani)
[![Contributors](https://img.shields.io/github/contributors/saiemgilani/hoopR?style=for-the-badge)](https://github.com/saiemgilani/hoopR/graphs/contributors)
<!-- badges: end -->

[**`hoopR`**](https://saiemgilani.github.io/hoopR/) is an R package for
working with men’s basketball data.

The package has functions to access **live play by play and box score**
data from ESPN with shot locations when available.

It is additionally a scraping and aggregating interface for Ken
Pomeroy’s men’s college basketball statistics website,
[kenpom.com](https://kenpom.com). It provides users with an active
subscription the capability to scrape the website tables and analyze the
data for themselves.

## Installation

You can install the released version of
[**`hoopR`**](https://github.com/saiemgilani/hoopR/) from
[GitHub](https://github.com/saiemgilani/hoopR) with:

``` r
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
pacman::p_load_current_gh("saiemgilani/hoopR")
```

``` r
# if you would prefer devtools installation
if (!requireNamespace('devtools', quietly = TRUE)){
  install.packages('devtools')
}
# Alternatively, using the devtools package:
devtools::install_github(repo = "saiemgilani/hoopR")
```

## Quick Start

### **NBA full play-by-play seasons (2002-2021) \~ 1-2 minutes**

``` r
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
pacman::p_load_current_gh("saiemgilani/hoopR")
future::plan("multisession")
tictoc::tic()
progressr::with_progress({
  pbp <- load_nba_pbp(2002:2021)
})
tictoc::toc()
## 66.99 sec elapsed
length(unique(pbp$game_id))
nrow(pbp)
```

### **Men’s college basketball full play-by-play seasons (2002-2021) \~ 2-3 minutes**

``` r
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
pacman::p_load_current_gh("saiemgilani/hoopR")
future::plan("multisession")
tictoc::tic()
progressr::with_progress({
  pbp <- load_mbb_pbp(2002:2021)
})
tictoc::toc()

## 135.87 sec elapsed
length(unique(pbp$game_id))
nrow(pbp)
```

## **Documentation**

For more information on the package and function reference, please see
the [**`hoopR`** documentation
website](https://saiemgilani.github.io/hoopR/).

## **Breaking Changes**

[**Full News on
Releases**](https://saiemgilani.github.io/hoopR/news/index.html)

# **hoopR 1.2.0**

### **Add schedule loaders**

  - [`hoopR::load_mbb_schedule()`](https://saiemgilani.github.io/hoopR/reference/load_mbb_schedule.html)
    function added
  - [`hoopR::load_nba_schedule()`](https://saiemgilani.github.io/hoopR/reference/load_nba_schedule.html)
    function added

# 

<details>

<summary>View more version news</summary>

## **hoopR 1.1.0**

### **Add team box score loaders**

  - [`hoopR::load_mbb_team_box()`](https://saiemgilani.github.io/hoopR/reference/load_mbb_team_box.html)
    function added
  - [`hoopR::load_nba_team_box()`](https://saiemgilani.github.io/hoopR/reference/load_nba_team_box.html)
    function added

### **Add player box score loaders**

  - [`hoopR::load_mbb_player_box()`](https://saiemgilani.github.io/hoopR/reference/load_mbb_player_box.html)
    function added
  - [`hoopR::load_nba_player_box()`](https://saiemgilani.github.io/hoopR/reference/load_nba_player_box.html)
    function added

## **hoopR 1.0.5**

### **Standings functions**

  - [`hoopR::espn_nba_standings()`](https://saiemgilani.github.io/hoopR/reference/espn_nba_standings.html)
  - [`hoopR::espn_mbb_standings()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_standings.html)

## **hoopR 1.0.4**

### **Add retry**

  - Adding
    [`httr::retry()`](https://httr.r-lib.org/reference/RETRY.html) to
    all function calls to more naturally navigate rejected/failed
    requests from the API.

## **hoopR 1.0.2-3**

### **Quick fix for update db functions**

## **hoopR 1.0.1**

### **Dependency pruning**

This update is a non-user facing change to package dependencies to
shrink the list of dependencies.

## **hoopR 1.0.0**

### **Package renamed to hoopR**

To reflect that the package is no longer just a men’s college basketball
and KenPom package, but also an NBA package.

### **Clean names and team returns**

  - All functions have now been given the
    [`janitor::clean_names()`](https://rdrr.io/cran/janitor/man/clean_names.html)
    treatment
  - [`hoopR::espn_mbb_teams()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_teams.html)
    has updated the returns to be more identity information related only
  - [`hoopR::espn_nba_teams()`](https://saiemgilani.github.io/hoopR/reference/espn_nba_teams.html)
    to be more identity information related only
  - All tests were updated

### **Loading capabilities added to the package**

  - [`hoopR::load_mbb_pbp()`](https://saiemgilani.github.io/hoopR/reference/load_mbb_pbp.html)
    and
    [`hoopR::update_mbb_db()`](https://saiemgilani.github.io/hoopR/reference/update_mbb_db.html)
    functions added
  - [`hoopR::load_nba_pbp()`](https://saiemgilani.github.io/hoopR/reference/load_nba_pbp.html)
    and
    [`hoopR::update_nba_db()`](https://saiemgilani.github.io/hoopR/reference/update_nba_db.html)
    functions added

### **hoopR 0.4**

  - Added support for ESPN’s NBA play-by-play endpoints with the
    addition of the following functions:
  - `hoopR::espn_nba_game_all()` - a convenience wrapper function around
    the following three functions (returns the results as a list of
    three data frames)
  - `hoopR::espn_nba_team_box()`
  - `hoopR::espn_nba_player_box()`
  - `hoopR::espn_nba_pbp()`
  - `hoopR::espn_nba_teams()`
  - `hoopR::espn_nba_scoreboard()`

### **hoopR 0.3.0**

  - `R` version 3.5.0 or greater dependency added
  - `purrr` version 0.3.0 or greater dependency added
  - `rvest` version 1.0.0 or greater dependency added
  - `progressr` version 0.6.0 or greater dependency added
  - `usethis` version 1.6.0 or greater dependency added
  - `xgboost` version 1.1.0 or greater dependency added
  - `tidyr` version 1.0.0 or greater dependency added
  - `stringr` version 1.3.0 or greater dependency added
  - `tibble` version 3.0.0 or greater dependency added
  - `furrr` dependency added
  - `future` dependency added

### **Test coverage**

  - Added tests for all KP and ESPN functions

#### **Function Naming Convention Change**

  - All functions sourced from [kenpom.com](https://www.kenpom.com/)
    will start with `kp_` as opposed to `get_`

  - Similarly, data and metrics sourced from ESPN will begin with
    `espn_` as opposed to `cbb_`. Moreover, all references to `cbb_`
    have been changed to `mbb_` as appropriate.

  - Data sourced directly from the NCAA website will start the function
    with `ncaa_`

#### New in v0.2.0-3: Support for ESPN’s men’s college basketball game data and NCAA NET Rankings

See the following ~~four~~ eight functions:

  - [`hoopR::espn_mbb_game_all()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_game_all.html)

  - [`hoopR::espn_mbb_pbp()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_pbp.html)

  - [`hoopR::espn_mbb_team_box()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_team_box.html)

  - [`hoopR::espn_mbb_player_box()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_player_box.html)

  - [`hoopR::espn_mbb_teams()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_teams.html)
    (bumps to v0.2.1)

  - [`hoopR::espn_mbb_conferences()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_conferences.html)
    (bumps to v0.2.1)

  - [`hoopR::espn_mbb_scoreboard()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_scoreboard.html)
    (bumps to v0.2.2)

  - [`hoopR::ncaa_mbb_NET_rankings()`](https://saiemgilani.github.io/hoopR/reference/ncaa_mbb_NET_rankings.html)
    (bumps to v0.2.3)

  - [`hoopR::espn_mbb_rankings()`](https://saiemgilani.github.io/hoopR/reference/espn_mbb_rankings.html)
    (bumps to v0.2.3)

</details>

# Current Issues

| issue | icon | title | labels | opened\_by | date | closed |
| :---- | :--- | :---- | :----- | :--------- | :--- | :----- |
| NA    | NA   | NA    | NA     | NA         | NA   | NA     |

<details>

<summary>View More</summary>

| issue | icon                                                                                                                                         | title                                                                                                                                                       | labels | opened\_by                                      | date       | closed              |
| :---- | :------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------- | :----- | :---------------------------------------------- | :--------- | :------------------ |
| 14    | <span title="Closed Issue"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/issue-closed.png?raw=true"></span>               | <span title="    library(hoopR)...">[Error in “update\_nba\_db”: could not find function “my\_time”](https://github.com/saiemgilani/hoopR/issues/14)</span> |        | [jedwards757](https://github.com/jedwards757)   | 2021-05-20 | 2021-05-20 22:53:32 |
| 1     | <span title="Closed Issue"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/issue-closed.png?raw=true"></span>               | <span title="**Describe the bug**...">[gameplan function error](https://github.com/saiemgilani/hoopR/issues/1)</span>                                       | bug    | [mcoleman9221](https://github.com/mcoleman9221) | 2021-01-28 | 2021-01-28 03:31:48 |
| 19    | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="# **hoopR 1.2.0**...">[schedule loaders](https://github.com/saiemgilani/hoopR/pull/19)</span>                                                  |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-06-26 | 2021-06-26 04:10:53 |
| 18    | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="# **hoopR 1.1.0** ...">[team/player boxes](https://github.com/saiemgilani/hoopR/pull/18)</span>                                                |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-05-31 | 2021-05-31 07:34:30 |
| 17    | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="">[standings](https://github.com/saiemgilani/hoopR/pull/17)</span>                                                                             |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-05-22 | 2021-05-22 11:11:07 |

</details>

<br>

# **Our Authors**

  - [Saiem Gilani](https://twitter.com/saiemgilani)  
    <a href="https://twitter.com/saiemgilani" target="blank"><img src="https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge" alt="@saiemgilani" /></a>
    <a href="https://github.com/saiemgilani" target="blank"><img src="https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge" alt="@saiemgilani" /></a>

## **Citations**

To cite the [**`hoopR`**](https://saiemgilani.github.io/hoopR/) R
package in publications, use:

BibTex Citation

``` bibtex
@misc{saiemgilani2021hoopR,
  author = {Gilani, Saiem},
  title = {hoopR: the SportsDataverse R package for men's basketball play by play data.},
  url = {https://saiemgilani.github.io/hoopR/},
  year = {2021}
}
```
