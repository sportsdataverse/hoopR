
# 

# hoopR <a href='https://hoopR.sportsdataverse.org/'><img src="https://raw.githubusercontent.com/saiemgilani/hoopR/master/logo.png" align="right"  width="20%" min-width="100px"/></a>

<!-- badges: start -->

[![CRAN
status](https://img.shields.io/badge/dynamic/json?style=for-the-badge&color=success&label=CRAN%20version&prefix=v&query=%24.Version&url=https%3A%2F%2Fcrandb.r-pkg.org%2FhoopR)](https://CRAN.R-project.org/package=hoopR)
[![CRAN
downloads](https://img.shields.io/badge/dynamic/json?style=for-the-badge&color=success&label=Downloads&query=%24%5B0%5D.downloads&url=https%3A%2F%2Fcranlogs.r-pkg.org%2Fdownloads%2Ftotal%2F2021-10-26%3Alast-day%2FhoopR)](https://CRAN.R-project.org/package=hoopR)
[![Version-Number](https://img.shields.io/github/r-package/v/saiemgilani/hoopR?label=hoopR&logo=R&style=for-the-badge)](https://github.com/saiemgilani/hoopR)
[![R-CMD-check](https://img.shields.io/github/workflow/status/saiemgilani/hoopR/R-CMD-check?label=R-CMD-Check&logo=R&logoColor=white&style=for-the-badge)](https://github.com/saiemgilani/hoopR/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=for-the-badge&logo=github)](https://github.com/saiemgilani/hoopR/)
[![Twitter
Follow](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge)](https://twitter.com/saiemgilani)
[![Twitter
Follow](https://img.shields.io/twitter/follow/SportsDataverse?color=blue&label=%40SportsDataverse&logo=twitter&style=for-the-badge)](https://twitter.com/SportsDataverse)
[![Contributors](https://img.shields.io/github/contributors/saiemgilani/hoopR?style=for-the-badge)](https://github.com/saiemgilani/hoopR/graphs/contributors)
<!-- badges: end -->

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
[**`hoopR`**](https://github.com/saiemgilani/hoopR/) from
[GitHub](https://github.com/saiemgilani/hoopR) with:

``` r
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
pacman::p_load_current_gh("saiemgilani/hoopR", dependencies = TRUE, update = TRUE)
```

## Quick Start

### **NBA full play-by-play seasons (2002-2021) \~ 1-2 minutes**

``` r
tictoc::tic()
progressr::with_progress({
  nba_pbp <- hoopR::load_nba_pbp(2002:2021)
})
tictoc::toc()
```

    ## 71.54 sec elapsed

    ## 11789401 rows of NBA play-by-play data from 26035 games.

### **Men’s college basketball full play-by-play seasons (2006-2021) \~ 2-3 minutes**

``` r
tictoc::tic()
progressr::with_progress({
  mbb_pbp <-  hoopR::load_mbb_pbp(2006:2021)
})
tictoc::toc()
```

    ## 137.5 sec elapsed

    ## 20815191 rows of men's college basketball play-by-play data from 64423 games.

## **Documentation**

For more information on the package and function reference, please see
the [**`hoopR`** documentation
website](https://hoopR.sportsdataverse.org).

## **Breaking Changes**

[**Full News on
Releases**](https://hoopR.sportsdataverse.org/news/index.html)

## Follow the [SportsDataverse](https://twitter.com/SportsDataverse) on Twitter and star this repo

[![Twitter
Follow](https://img.shields.io/twitter/follow/SportsDataverse?color=blue&label=%40SportsDataverse&logo=twitter&style=for-the-badge)](https://twitter.com/SportsDataverse)

[![GitHub
stars](https://img.shields.io/github/stars/saiemgilani/hoopR.svg?color=eee&logo=github&style=for-the-badge&label=Star%20hoopR&maxAge=2592000)](https://github.com/saiemgilani/hoopR/stargazers/)

## **Our Authors**

-   [Saiem Gilani](https://twitter.com/saiemgilani)  
    <a href="https://twitter.com/saiemgilani" target="blank"><img src="https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge" alt="@saiemgilani" /></a>
    <a href="https://github.com/saiemgilani" target="blank"><img src="https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge" alt="@saiemgilani" /></a>

## **Our Contributors (they’re awesome)**

-   [Jason Lee](https://twitter.com/theFirmAISports)  
    <a href="https://twitter.com/theFirmAISports" target="blank"><img src="https://img.shields.io/twitter/follow/theFirmAISports?color=blue&label=%40theFirmAISports&logo=twitter&style=for-the-badge" alt="@theFirmAISports" /></a>
    <a href="https://github.com/papagorgio23" target="blank"><img src="https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge" alt="@papagorgio23" /></a>

-   [Billy Fryer](https://twitter.com/_b4billy_)  
    <a href="https://twitter.com/_b4billy_" target="blank"><img src="https://img.shields.io/twitter/follow/_b4billy_?color=blue&label=%40_b4billy_&logo=twitter&style=for-the-badge" alt="@_b4billy_" /></a>
    <a href="https://github.com/b4billy" target="blank"><img src="https://img.shields.io/github/followers/b4billy?color=eee&logo=Github&style=for-the-badge" alt="@b4billy" /></a>

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
