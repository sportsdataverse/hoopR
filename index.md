# 

- [](#section)
- [hoopR](#hoopr-) [![hoopR
  logo](https://raw.githubusercontent.com/sportsdataverse/hoopR/main/logo.png)](https://hoopR.sportsdataverse.org/)
  - [Data status](#data-status)
  - [Installation](#installation)
  - [Quick Start](#quick-start)
  - [**Documentation**](#documentation)
  - [**Breaking Changes**](#breaking-changes)
  - [Follow the SportsDataverse (@SportsDataverse) on X and star this
    repo](#follow-the-sportsdataverse-sportsdataverse-on-x-and-star-this-repo)
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

As of version 3.1.0, the package exports 600+ functions spanning the NBA
Stats API (`nba_*`), ESPN (`espn_nba_*` / `espn_mbb_*`), KenPom
(`kp_*`), CollegeBasketballData (`cbbd_*`), Basketball-Reference
(`bref_*`), Bart Torvik (`torvik_*`), RealGM (`realgm_*`), Fox Sports
(`fox_*`), NCAA (`ncaa_mbb_*`), and NBA G-League (`nbagl_*`), plus
`load_nba_*()` / `load_mbb_*()` / `load_ncaa_mbb_*()` bulk-data loaders
backed by the `sportsdataverse-data` release repos.

## Data status

The `load_*()` functions read release assets on
[sportsdataverse-data](https://github.com/sportsdataverse/sportsdataverse-data/releases).
The badges below are rebuilt nightly from each producer’s latest
workflow run and newest release files; idle means the sport is out of
season. Full detail:
[sportsdataverse.org/status](https://sportsdataverse.org/status).

| Dataset | Data updated | Through | Pipeline | Update workflows |
|:---|:---|:---|:---|:---|
| [Men’s college basketball (ESPN)](https://github.com/sportsdataverse/hoopR-mbb-data) | [![hoopR-mbb-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-mbb-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-mbb-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fstatus.json)](https://sportsdataverse.org/status#hoopR-mbb-data) | [![hoopR-mbb-data daily_mbb](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fwf-daily_mbb.json)](https://github.com/sportsdataverse/hoopR-mbb-data/actions/workflows/daily_mbb.yml) [![hoopR-mbb-data mbb_models_cron](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fwf-mbb_models_cron.json)](https://github.com/sportsdataverse/hoopR-mbb-data/actions/workflows/mbb_models_cron.yml) |
| [Men’s college basketball (stats.ncaa.org)](https://github.com/sportsdataverse/ncaa-mbb-hoops-data) | [![ncaa-mbb-hoops-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![ncaa-mbb-hoops-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![ncaa-mbb-hoops-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fstatus.json)](https://sportsdataverse.org/status#ncaa-mbb-hoops-data) | [![ncaa-mbb-hoops-data ncaa_mbb_models](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fwf-ncaa_mbb_models.json)](https://github.com/sportsdataverse/ncaa-mbb-hoops-data/actions/workflows/ncaa_mbb_models.yml) |
| [NBA (ESPN)](https://github.com/sportsdataverse/hoopR-nba-data) | [![hoopR-nba-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-nba-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-nba-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fstatus.json)](https://sportsdataverse.org/status#hoopR-nba-data) | [![hoopR-nba-data daily_nba](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fwf-daily_nba.json)](https://github.com/sportsdataverse/hoopR-nba-data/actions/workflows/daily_nba.yml) |
| [NBA Stats API](https://github.com/sportsdataverse/hoopR-nba-stats-data) | [![hoopR-nba-stats-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-nba-stats-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-nba-stats-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fstatus.json)](https://sportsdataverse.org/status#hoopR-nba-stats-data) | [![hoopR-nba-stats-data daily_nba_stats](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fwf-daily_nba_stats.json)](https://github.com/sportsdataverse/hoopR-nba-stats-data/actions/workflows/daily_nba_stats.yml) [![hoopR-nba-stats-data nba_models](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fwf-nba_models.json)](https://github.com/sportsdataverse/hoopR-nba-stats-data/actions/workflows/nba_models.yml) [![hoopR-nba-stats-data annual_nba_stats_draft](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fwf-annual_nba_stats_draft.json)](https://github.com/sportsdataverse/hoopR-nba-stats-data/actions/workflows/annual_nba_stats_draft.yml) |
| [Conference, division and ballpark reference](https://github.com/sportsdataverse/sdv-reference-data) | [![sdv-reference-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fsdv-reference-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![sdv-reference-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fsdv-reference-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![sdv-reference-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fsdv-reference-data%2Fstatus.json)](https://sportsdataverse.org/status#sdv-reference-data) | — |

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

### **NBA full play-by-play seasons (2002-2026) ~ 1-2 minutes**

``` r

tictoc::tic()
progressr::with_progress({
  nba_pbp <- hoopR::load_nba_pbp()
})
tictoc::toc()
```

``` R
## 4.05 sec elapsed

## 642472 rows of NBA play-by-play data from 1325 games.
```

### **Men’s college basketball full play-by-play seasons (2006-2026) ~ 2-3 minutes**

``` r

tictoc::tic()
progressr::with_progress({
  mbb_pbp <-  hoopR::load_mbb_pbp()
})
tictoc::toc()
```

``` R
## 12.98 sec elapsed

## 2915731 rows of men's college basketball play-by-play data from 6275 games.
```

## **Documentation**

For more information on the package and function reference, please see
the [**`hoopR`** documentation
website](https://hoopR.sportsdataverse.org).

There is also a printable [**`hoopR` cheat sheet
(PDF)**](https://sportsdataverse.org/cheatsheets/hoopR.pdf), one of [a
set covering every SportsDataverse
package](https://sportsdataverse.org/cheatsheets).

## **Breaking Changes**

[**Full News on
Releases**](https://hoopR.sportsdataverse.org/news/index.html)

## Follow the SportsDataverse (@SportsDataverse) on X and star this repo

[![X
Follow](https://img.shields.io/twitter/follow/SportsDataverse?color=blue&label=%40SportsDataverse&logo=x&style=for-the-badge)](https://x.com/SportsDataverse)

[![GitHub
stars](https://img.shields.io/github/stars/sportsdataverse/hoopR.svg?color=eee&logo=github&style=for-the-badge&label=Star%20hoopR&maxAge=2592000)](https://github.com/sportsdataverse/hoopR)

## **Our Authors**

- Saiem Gilani (@saiemgilani)
  [![@saiemgilani](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge)](https://x.com/saiemgilani)

[![@saiemgilani](https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge)](https://github.com/saiemgilani)

## **Our Contributors (they’re awesome)**

- Jason Lee (@theFirmAISports)
  [![@theFirmAISports](https://img.shields.io/twitter/follow/theFirmAISports?color=blue&label=%40theFirmAISports&logo=x&style=for-the-badge)](https://x.com/theFirmAISports)
  [![@papagorgio23](https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge)](https://github.com/papagorgio23)

- Billy Fryer (@BillyFryer42)
  [![@BillyFryer42](https://img.shields.io/twitter/follow/BillyFryer42?color=blue&label=%40BillyFryer42&logo=x&style=for-the-badge)](https://x.com/BillyFryer42)
  [![@billyfryer](https://img.shields.io/github/followers/billyfryer?color=eee&logo=Github&style=for-the-badge)](https://github.com/billyfryer)

- Ross Drucker (@rossdrucker9)
  [![@rossdrucker9](https://img.shields.io/twitter/follow/rossdrucker9?color=blue&label=%40rossdrucker9&logo=x&style=for-the-badge)](https://x.com/rossdrucker9)
  [![@rossdrucker](https://img.shields.io/github/followers/rossdrucker?color=eee&logo=Github&style=for-the-badge)](https://github.com/rossdrucker)

- Vladislav Shufinskiy (@vshufinskiy)
  [![@vshufinskiy](https://img.shields.io/twitter/follow/vshufinskiy?color=blue&label=%40vshufinskiy&logo=x&style=for-the-badge)](https://x.com/vshufinskiy)
  [![@shufinskiy](https://img.shields.io/github/followers/shufinskiy?color=eee&logo=Github&style=for-the-badge)](https://github.com/shufinskiy)

## **Cheat sheet**

A printable one-page reference for **`hoopR`** — the function families,
the loaders, and what each one returns.

📄 **[Download the hoopR cheat sheet
(PDF)](https://sportsdataverse.org/cheatsheets/hoopR.pdf)**

Free to download, print and hand out; light and dark, US Letter
landscape. Every SportsDataverse package has one — browse them all at
**[sportsdataverse.org/cheatsheets](https://sportsdataverse.org/cheatsheets)**.

## **Citations**

To cite the [**`hoopR`**](https://hoopR.sportsdataverse.org) R package
in publications, use:

BibTeX Citation

``` bibtex
@misc{gilani_2021_hoopR,
  author = {Gilani, Saiem},
  title = {hoopR: The SportsDataverse's R Package for Men's Basketball Data.},
  url = {https://hoopR.sportsdataverse.org},
  doi = {10.32614/CRAN.package.hoopR},
  year = {2026}
}
```
