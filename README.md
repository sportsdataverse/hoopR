
# kenpomR <a href='http://saiemgilani.github.io/kenpomR'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=for-the-badge&logo=github)
![R-CMD-check](https://img.shields.io/github/workflow/status/saiemgilani/kenpomR/R-CMD-check?label=R-CMD-Check&logo=R&logoColor=blue&style=for-the-badge)
[![R-CMD-check](https://github.com/saiemgilani/kenpomR/actions/workflows/R-CMD-check.yaml/badge.svg?branch=master)](https://github.com/saiemgilani/kenpomR/actions/workflows/R-CMD-check.yaml)
![Contributors](https://img.shields.io/github/contributors/saiemgilani/kenpomr?style=for-the-badge)
![Version-Number](https://img.shields.io/github/r-package/v/saiemgilani/kenpomr?label=kenpomR&logo=R&style=for-the-badge)
[![Twitter
Follow](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge)](https://twitter.com/saiemgilani)
<!-- badges: end -->

[**`kenpomR`**](https://saiemgilani.github.io/kenpomR/) is an R package
for working with men’s basketball data.

The package has functions to access **live play by play and box score**
data from ESPN with shot locations when available.

It is additionally a scraping and aggregating interface for Ken
Pomeroy’s men’s college basketball statistics website,
[kenpom.com](https://kenpom.com). It provides users with an active
subscription the capability to scrape the website tables and analyze the
data for themselves.

## Installation

You can install the released version of
[**`kenpomR`**](https://github.com/saiemgilani/kenpomR/) from
[GitHub](https://github.com/saiemgilani/kenpomR) with:

``` r
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
pacman::p_load_current_gh("saiemgilani/kenpomR")
```

``` r
# if you would prefer devtools installation
if (!requireNamespace('devtools', quietly = TRUE)){
  install.packages('devtools')
}
# Alternatively, using the devtools package:
devtools::install_github(repo = "saiemgilani/kenpomR")
```

## Documentation

For more information on the package and function reference, please see
the [**`kenpomR`** documentation
website](https://saiemgilani.github.io/kenpomR/).

## **Breaking Changes**

[**Full News on
Releases**](https://saiemgilani.github.io/kenpomR/news/index.html)

# **kenpomR 0.4**

  - Added support for ESPN’s NBA play-by-play endpoints with the
    addition of the following functions:
  - `kenpomR::espn_nba_game_all()` - a convenience wrapper function
    around the following three functions (returns the results as a list
    of three data frames)
  - `kenpomR::espn_nba_team_box()`
  - `kenpomR::espn_nba_player_box()`
  - `kenpomR::espn_nba_pbp()`
  - `kenpomR::espn_nba_teams()`
  - `kenpomR::espn_nba_scoreboard()`

# **kenpomR 0.3.0**

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

## **Test coverage**

  - Added tests for all KP and ESPN functions

#### **Function Naming Convention Change**

  - All functions sourced from [kenpom.com](https://www.kenpom.com/)
    will start with `kp_` as opposed to `get_`

  - Similarly, data and metrics sourced from ESPN will begin with
    `espn_` as opposed to `cbb_`. Moreover, all references to `cbb_`
    have been changed to `mbb_` as appropriate.

  - Data sourced directly from the NCAA website will start the function
    with `ncaa_`

<details>

<summary>View more version news</summary>

#### New in v0.2.0-3: Support for ESPN’s men’s college basketball game data and NCAA NET Rankings

See the following ~~four~~ eight functions:

  - [`kenpomR::espn_mbb_game_all()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_game_all.html)

  - [`kenpomR::espn_mbb_pbp()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_pbp.html)

  - [`kenpomR::espn_mbb_team_box()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_team_box.html)

  - [`kenpomR::espn_mbb_player_box()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_player_box.html)

  - [`kenpomR::espn_mbb_teams()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_teams.html)
    (bumps to v0.2.1)

  - [`kenpomR::espn_mbb_conferences()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_conferences.html)
    (bumps to v0.2.1)

  - [`kenpomR::espn_mbb_scoreboard()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_scoreboard.html)
    (bumps to v0.2.2)

  - [`kenpomR::ncaa_mbb_NET_rankings()`](https://saiemgilani.github.io/kenpomR/reference/ncaa_mbb_NET_rankings.html)
    (bumps to v0.2.3)

  - [`kenpomR::espn_mbb_rankings()`](https://saiemgilani.github.io/kenpomR/reference/espn_mbb_rankings.html)
    (bumps to v0.2.3)

</details>

## Current Issues

| issue | icon | title | labels | opened\_by | date | closed |
| :---- | :--- | :---- | :----- | :--------- | :--- | :----- |
| NA    | NA   | NA    | NA     | NA         | NA   | NA     |

<details>

<summary>View More</summary>

| issue | icon                                                                                                                                         | title                                                                                                                                                             | labels | opened\_by                                      | date       | closed              |
| :---- | :------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----- | :---------------------------------------------- | :--------- | :------------------ |
| 1     | <span title="Closed Issue"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/issue-closed.png?raw=true"></span>               | <span title="**Describe the bug**...">[gameplan function error](https://github.com/saiemgilani/kenpomR/issues/1)</span>                                           | bug    | [mcoleman9221](https://github.com/mcoleman9221) | 2021-01-28 | 2021-01-28 03:31:48 |
| 10    | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="continue updating docs to reflect MBB">[Add support for nba data from espn (including tests)](https://github.com/saiemgilani/kenpomR/pull/10)</span> |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-04-29 | 2021-04-29 10:26:44 |
| 9     | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="# **kenpomR 0.3.0**...">[v0.3.0](https://github.com/saiemgilani/kenpomR/pull/9)</span>                                                               |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-04-26 | 2021-04-26 21:59:14 |
| 8     | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="">[add cbb\_espn\_scoreboard function()](https://github.com/saiemgilani/kenpomR/pull/8)</span>                                                       |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-02-24 | 2021-02-24 20:43:38 |
| 7     | <span title="Merged Pull Request"><img src="https://github.com/yonicd/issue/blob/master/inst/icons/pull-request-merged.png?raw=true"></span> | <span title="Adding teams and conference lookup">[Espn](https://github.com/saiemgilani/kenpomR/pull/7)</span>                                                     |        | [saiemgilani](https://github.com/saiemgilani)   | 2021-02-21 | 2021-02-21 17:08:14 |

</details>

<br>

## **Our Authors**

  - [Saiem Gilani](https://twitter.com/saiemgilani)  
    <a href="https://twitter.com/saiemgilani" target="blank"><img src="https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge" alt="@saiemgilani" /></a>
    <a href="https://github.com/saiemgilani" target="blank"><img src="https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge" alt="@saiemgilani" /></a>
