# 

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
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
pacman::p_load_current_gh("sportsdataverse/hoopR", dependencies = TRUE, update = TRUE)
```

## Quick Start

### **NBA full play-by-play seasons (2002-2024) ~ 1-2 minutes**

``` r
tictoc::tic()
progressr::with_progress({
  nba_pbp <- hoopR::load_nba_pbp()
})
tictoc::toc()
```

``` R
## 1.02 sec elapsed

## 109783 rows of NBA play-by-play data from 230 games.
```

### **Men’s college basketball full play-by-play seasons (2006-2024) ~ 2-3 minutes**

``` r
tictoc::tic()
progressr::with_progress({
  mbb_pbp <-  hoopR::load_mbb_pbp()
})
tictoc::toc()
```

``` R
## 1.62 sec elapsed

## 360517 rows of men's college basketball play-by-play data from 1074 games.
```

## **Documentation**

For more information on the package and function reference, please see
the [**`hoopR`** documentation
website](https://hoopR.sportsdataverse.org).

## **Breaking Changes**

[**Full News on
Releases**](https://hoopR.sportsdataverse.org/news/index.html)

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
