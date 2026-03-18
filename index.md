# 

**Table of Contents** *generated with
[DocToc](https://github.com/thlorenz/doctoc)*

- [](#)
- [hoopR](#hoopr-a-hrefhttpshooprsportsdataverseorgimg-srchttpsrawgithubusercontentcomsportsdataversehooprmainlogopng-alignright--width20%25-min-width100pxa)
  [![](https://raw.githubusercontent.com/sportsdataverse/hoopR/main/logo.png)](https://hoopR.sportsdataverse.org/)
  - [Installation](#installation)
  - [Quick Start](#quick-start)
    - [**NBA full play-by-play seasons (2002-2025) ~ 1-2
      minutes**](#nba-full-play-by-play-seasons-2002-2025--1-2-minutes)
    - [**Men’s college basketball full play-by-play seasons (2006-2025)
      ~ 2-3
      minutes**](#mens-college-basketball-full-play-by-play-seasons-2006-2025--2-3-minutes)
  - [**Documentation**](#documentation)
  - [**Breaking Changes**](#breaking-changes)
  - [Follow the SportsDataverse (@SportsDataverse) on Twitter and star
    this
    repo](#follow-the-sportsdataverse-sportsdataverse-on-twitter-and-star-this-repo)
  - [**Our Authors**](#our-authors)
  - [**Our Contributors (they’re
    awesome)**](#our-contributors-theyre-awesome)
  - [**Citations**](#citations)

# hoopR

[**`hoopR`**](https://hoopR.sportsdataverse.org/) is an R package for
working with men’s basketball data.

The package has functions to access **live play by play and box score**
data from ESPN with shot locations when available. As of version 1.3.0,
[**`hoopR`**](https://hoopR.sportsdataverse.org/) is also a full NBA
Stats API wrapper with 127 functions added in this release.

It is additionally a scraping and aggregating interface for Ken
Pomeroy’s men’s college basketball statistics website,
[kenpom.com](https://kenpom.com/). It provides users with an active
subscription the capability to scrape the website tables and analyze the
data for themselves.

## Installation

You can install the CRAN version of
[**`hoopR`**](https://CRAN.R-project.org/package=hoopR) with:

``` r
install.packages("hoopR")
```

You can install the released version of
[**`hoopR`**](https://github.com/sportsdataverse/hoopR/) from
[GitHub](https://github.com/sportsdataverse/hoopR) with:

``` r
# You can install using the pak package using the following code:
if (!requireNamespace('pak', quietly = TRUE)){
  install.packages('pak')
}
pak::pak("sportsdataverse/hoopR")
```

## Quick Start

### **NBA full play-by-play seasons (2002-2025) ~ 1-2 minutes**

``` r
tictoc::tic()
progressr::with_progress({
  nba_pbp <- hoopR::load_nba_pbp()
})
tictoc::toc()
```

``` R
## 3.55 sec elapsed

## 615581 rows of NBA play-by-play data from 1305 games.
```

### **Men’s college basketball full play-by-play seasons (2006-2025) ~ 2-3 minutes**

``` r
tictoc::tic()
progressr::with_progress({
  mbb_pbp <-  hoopR::load_mbb_pbp()
})
tictoc::toc()
```

``` R
## 6.94 sec elapsed

## 2112541 rows of men's college basketball play-by-play data from 5915 games.
```

## **Documentation**

For more information on the package and function reference, please see
the [**`hoopR`** documentation
website](https://hoopR.sportsdataverse.org).

## **Breaking Changes**

[**Full News on
Releases**](https://hoopR.sportsdataverse.org/news/index.html)

- Legacy `nbagl_*` wrappers now follow NBA Stats-backed payload
  structures.
- [`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md)
  and
  [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)
  return named lists of data frames (`PlayerIndex`, `Standings`) instead
  of legacy flat schema assumptions.
- [`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md)
  and
  [`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md)
  return modernized core columns aligned with current upstream sources.

## Follow the SportsDataverse (@SportsDataverse) on Twitter and star this repo

[![GitHub
stars](https://img.shields.io/github/stars/sportsdataverse/hoopR.svg?color=eee&logo=github&style=for-the-badge&label=Star%20hoopR&maxAge=2592000)](https://github.com/sportsdataverse/hoopR/stargazers/)

## **Our Authors**

- Saiem Gilani (@saiemgilani)

[![@saiemgilani](https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge)](https://github.com/saiemgilani)

## **Our Contributors (they’re awesome)**

- Jason Lee (@theFirmAISports)
  [![@papagorgio23](https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge)](https://github.com/papagorgio23)

- Billy Fryer (@\_b4billy\_)
  [![@billyfryer](https://img.shields.io/github/followers/billyfryer?color=eee&logo=Github&style=for-the-badge)](https://github.com/billyfryer)

- Ross Drucker (@rossdrucker9)
  [![@rossdrucker](https://img.shields.io/github/followers/rossdrucker?color=eee&logo=Github&style=for-the-badge)](https://github.com/rossdrucker)

- Vladislav Shufinskiy (@vshufinskiy)
  [![@shufinskiy](https://img.shields.io/github/followers/shufinskiy?color=eee&logo=Github&style=for-the-badge)](https://github.com/shufinskiy)

## **Citations**

To cite the [**`hoopR`**](https://hoopR.sportsdataverse.org) R package
in publications, use:

BibTex Citation

``` bibtex
@misc{gilani_2021_hoopR,
  author = {Gilani, Saiem},
  title = {hoopR: The SportsDataverse's R Package for Men's Basketball Data.},
  url = {https://hoopR.sportsdataverse.org},
  year = {2021}
}
```
