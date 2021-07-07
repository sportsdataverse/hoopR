
# 

# hoopR <a href='https://hoopR.sportsdataverse.org'><img src="https://hoopR.sportsdataverse.org/img/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![Version-Number](https://img.shields.io/github/r-package/v/saiemgilani/hoopR?label=hoopR&logo=R&style=for-the-badge)](https://github.com/saiemgilani/hoopR/)
[![R-CMD-check](https://img.shields.io/github/workflow/status/saiemgilani/hoopR/R-CMD-check?label=R-CMD-Check&logo=R&logoColor=white&style=for-the-badge)](https://github.com/saiemgilani/hoopR/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=for-the-badge&logo=github)](https://github.com/saiemgilani/hoopR/)
[![Twitter
Follow](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge)](https://twitter.com/saiemgilani)
[![Contributors](https://img.shields.io/github/contributors/saiemgilani/hoopR?style=for-the-badge)](https://github.com/saiemgilani/hoopR/graphs/contributors)
<!-- badges: end -->

[**`hoopR`**](https://hoopR.sportsdataverse.org) is an R package for
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

[**Full News on Releases**](https://hoopR.sportsdataverse.org/CHANGELOG)

# **Our Authors**

  - [Saiem Gilani](https://twitter.com/saiemgilani)  
    <a href="https://twitter.com/saiemgilani" target="blank"><img src="https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=twitter&style=for-the-badge" alt="@saiemgilani" /></a>
    <a href="https://github.com/saiemgilani" target="blank"><img src="https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge" alt="@saiemgilani" /></a>

## **Citations**

To cite the [**`hoopR`**](https://hoopR.sportsdataverse.org) R package
in publications, use:

BibTex Citation

``` bibtex
@misc{saiemgilani2021hoopR,
  author = {Gilani, Saiem},
  title = {hoopR: The SportsDataverse's R Package for M en's Basketball Data.},
  url = {https://hoopR.sportsdataverse.org},
  year = {2021}
}
```
