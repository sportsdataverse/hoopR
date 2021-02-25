
# kenpomR <a href='http://saiemgilani.github.io/kenpomR'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
[![Build
Status](https://travis-ci.com/saiemgilani/kenpomR.svg?branch=master)](https://travis-ci.com/saiemgilani/kenpomR)
![R-CMD-check](https://github.com/saiemgilani/kenpomR/workflows/R-CMD-check/badge.svg)
[![Twitter
Follow](https://img.shields.io/twitter/follow/saiemgilani?style=social)](https://twitter.com/saiemgilani)
<!-- badges: end -->

`kenpomR` is an R package for working with college basketball data. A
scraping and aggregating interface for Ken Pomeroy’s college basketball
statistics website, [kenpom.com](https://kenpom.com). It provides users
with an active subscription the capability to scrape the website tables
and analyze the data for themselves.

#### New in v0.2.0-3: Support for ESPN’s college basketball game data and NCAA NET Rankings

See the following ~~four~~ eight functions:

  - [`kenpomR::cbb_espn_game_all()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_game_all.html)

  - [`kenpomR::cbb_espn_pbp()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_pbp.html)

  - [`kenpomR::cbb_espn_team_box()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_team_box.html)

  - [`kenpomR::cbb_espn_player_box()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_player_box.html)

  - [`kenpomR::cbb_espn_teams()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_teams.html)
    (bumps to v0.2.1)

  - [`kenpomR::cbb_espn_conferences()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_conferences.html)
    (bumps to v0.2.1)

  - [`kenpomR::cbb_espn_scoreboard()`](https://saiemgilani.github.io/kenpomR/reference/cbb_espn_scoreboard.html)
    (bumps to v0.2.2)

  - [`kenpomR::cbb_ncaa_NET_rankings()`](https://saiemgilani.github.io/kenpomR/reference/cbb_ncaa_NET_rankings.html)
    (bumps to v0.2.3)

  - [`kenpomR::cbb_rankings()`](https://saiemgilani.github.io/kenpomR/reference/cbb_rankings.html)
    (bumps to v0.2.3)

## Installation

You can install `kenpomR` from
[GitHub](https://github.com/saiemgilani/kenpomR) with:

``` r
# Install via devtools package using the following:
devtools::install_github(repo = "saiemgilani/kenpomR")
```

## Documentation

For more information on the package and function reference, please see
the `kenpomR` [documentation](https://saiemgilani.github.io/kenpomR/).

## Code of Conduct

Please note that the `kenpomR` project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
