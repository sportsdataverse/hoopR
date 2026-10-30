
  - [hoopR
    <a href='https://hoopR.sportsdataverse.org/'><img src="https://raw.githubusercontent.com/sportsdataverse/hoopR/main/logo.png" align="right"  width="20%" min-width="100px" alt="hoopR logo"/></a>](#hoopr-)
      - [Data status](#data-status)
      - [Installation](#installation)
      - [Quick Start](#quick-start)
      - [**Plotting and related
        packages**](#plotting-and-related-packages)
      - [**Documentation**](#documentation)
      - [**Breaking Changes**](#breaking-changes)
      - [Follow the SportsDataverse (@SportsDataverse) on X and star
        this
        repo](#follow-the-sportsdataverse-sportsdataverse-on-x-and-star-this-repo)
      - [**Our Authors**](#our-authors)
      - [**Our Contributors (they’re
        awesome)**](#our-contributors-theyre-awesome)
      - [**Cheat sheet**](#cheat-sheet)
      - [**Citations**](#citations)

# hoopR <a href='https://hoopR.sportsdataverse.org/'><img src="https://raw.githubusercontent.com/sportsdataverse/hoopR/main/logo.png" align="right"  width="20%" min-width="100px" alt="hoopR logo"/></a>

<!-- badges: start -->

[![CRAN
status](https://img.shields.io/badge/dynamic/json?style=for-the-badge&color=success&label=CRAN%20version&prefix=v&query=%24.Version&url=https%3A%2F%2Fcrandb.r-pkg.org%2FhoopR)](https://CRAN.R-project.org/package=hoopR)
[![CRAN
downloads](https://img.shields.io/badge/dynamic/json?style=for-the-badge&color=success&label=Downloads&query=%24%5B0%5D.downloads&url=https%3A%2F%2Fcranlogs.r-pkg.org%2Fdownloads%2Ftotal%2F2021-10-26%3Alast-day%2FhoopR)](https://CRAN.R-project.org/package=hoopR)
[![Version-Number](https://img.shields.io/github/r-package/v/sportsdataverse/hoopR?label=hoopR&logo=R&style=for-the-badge)](https://github.com/sportsdataverse/hoopR)
[![R-CMD-check](https://img.shields.io/github/actions/workflow/status/sportsdataverse/hoopR/R-CMD-check.yaml?branch=main&label=R-CMD-Check&logo=R&logoColor=white&style=for-the-badge)](https://github.com/sportsdataverse/hoopR/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=for-the-badge&logo=github)](https://github.com/sportsdataverse/hoopR/)
[![X
Follow](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge)](https://x.com/saiemgilani)
[![X
Follow](https://img.shields.io/twitter/follow/SportsDataverse?color=blue&label=%40SportsDataverse&logo=x&style=for-the-badge)](https://x.com/SportsDataverse)
[![Contributors](https://img.shields.io/github/contributors/sportsdataverse/hoopR?style=for-the-badge)](https://github.com/sportsdataverse/hoopR/graphs/contributors)
<!-- badges: end -->

[**`hoopR`**](https://hoopR.sportsdataverse.org/) is an R package for
working with men’s basketball data.

It exports more than 1,300 functions:

  - **NBA:** the NBA Stats API (`nba_*`, about 200 functions), ESPN
    (`espn_nba_*`), the NBA G League (`nbagl_*`), Basketball-Reference
    (`bref_*`), RealGM (`realgm_*`), Fox Sports (`fox_nba_*`),
    official.nba.com officiating reports (`nba_l2m()`,
    `nba_referee_assignments()`), salary and mock-draft sources, and
    cross-source crosswalks.
  - **Men’s college basketball:** ESPN (`espn_mbb_*`), Ken Pomeroy’s
    [kenpom.com](https://kenpom.com/) (`kp_*`, for users with an active
    subscription), CollegeBasketballData (`cbbd_*`), Bart Torvik
    (`torvik_*`), the NCAA (`ncaa_mbb_*`) and Fox Sports (`fox_mbb_*`).
  - **International:** EuroLeague and EuroCup (`euroleague_*`) and about
    two dozen leagues and competitions, among them FIBA events
    (`fiba_*`), Spain’s ACB (`acb_*`), Italy’s LBA (`lba_*`), the VTB
    United League (`vtb_*`), Japan’s B.LEAGUE (`bleague_*`), Australia’s
    NBL (`nbl_rosetta_*`), Korea’s KBL (`kbl_*`) and China’s CBA
    (`cba_*`). See the [function
    reference](https://hoopR.sportsdataverse.org/reference/) for the
    full list.
  - **Loaders:** `load_nba_*()`, `load_mbb_*()`, `load_nba_stats_*()`
    and `load_ncaa_mbb_*()` read pre-built play-by-play, box score,
    schedule, shot and model data from the `sportsdataverse-data`
    releases.

## Data status

The `load_*()` functions read release assets on
[sportsdataverse-data](https://github.com/sportsdataverse/sportsdataverse-data/releases).
The badges below are rebuilt nightly from each producer’s latest
workflow run and newest release files; idle means the sport is out of
season. Full detail:
[sportsdataverse.org/status](https://sportsdataverse.org/status).

| Dataset                                                                                              | Data updated                                                                                                                                                                                                                                                                     | Through                                                                                                                                                                                                                                                                            | Pipeline                                                                                                                                                                                                                                                                 | Update workflows                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| :--------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Men’s college basketball (ESPN)](https://github.com/sportsdataverse/hoopR-mbb-data)                 | [![hoopR-mbb-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)             | [![hoopR-mbb-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)             | [![hoopR-mbb-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fstatus.json)](https://sportsdataverse.org/status#hoopR-mbb-data)                   | [![hoopR-mbb-data daily\_mbb](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fwf-daily_mbb.json)](https://github.com/sportsdataverse/hoopR-mbb-data/actions/workflows/daily_mbb.yml) [![hoopR-mbb-data mbb\_models\_cron](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-mbb-data%2Fwf-mbb_models_cron.json)](https://github.com/sportsdataverse/hoopR-mbb-data/actions/workflows/mbb_models_cron.yml)                                                                                                                                                                                                                                                                                                                                                                                            |
| [Men’s college basketball (stats.ncaa.org)](https://github.com/sportsdataverse/ncaa-mbb-hoops-data)  | [![ncaa-mbb-hoops-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)   | [![ncaa-mbb-hoops-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)   | [![ncaa-mbb-hoops-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fstatus.json)](https://sportsdataverse.org/status#ncaa-mbb-hoops-data)    | [![ncaa-mbb-hoops-data ncaa\_mbb\_models](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fncaa-mbb-hoops-data%2Fwf-ncaa_mbb_models.json)](https://github.com/sportsdataverse/ncaa-mbb-hoops-data/actions/workflows/ncaa_mbb_models.yml)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [NBA (ESPN)](https://github.com/sportsdataverse/hoopR-nba-data)                                      | [![hoopR-nba-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)             | [![hoopR-nba-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)             | [![hoopR-nba-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fstatus.json)](https://sportsdataverse.org/status#hoopR-nba-data)                   | [![hoopR-nba-data daily\_nba](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-data%2Fwf-daily_nba.json)](https://github.com/sportsdataverse/hoopR-nba-data/actions/workflows/daily_nba.yml)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [NBA Stats API](https://github.com/sportsdataverse/hoopR-nba-stats-data)                             | [![hoopR-nba-stats-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-nba-stats-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases) | [![hoopR-nba-stats-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fstatus.json)](https://sportsdataverse.org/status#hoopR-nba-stats-data) | [![hoopR-nba-stats-data daily\_nba\_stats](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fwf-daily_nba_stats.json)](https://github.com/sportsdataverse/hoopR-nba-stats-data/actions/workflows/daily_nba_stats.yml) [![hoopR-nba-stats-data nba\_models](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fwf-nba_models.json)](https://github.com/sportsdataverse/hoopR-nba-stats-data/actions/workflows/nba_models.yml) [![hoopR-nba-stats-data annual\_nba\_stats\_draft](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2FhoopR-nba-stats-data%2Fwf-annual_nba_stats_draft.json)](https://github.com/sportsdataverse/hoopR-nba-stats-data/actions/workflows/annual_nba_stats_draft.yml) |
| [Conference, division and ballpark reference](https://github.com/sportsdataverse/sdv-reference-data) | [![sdv-reference-data data updated](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fsdv-reference-data%2Fupdated.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)     | [![sdv-reference-data through season](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fsdv-reference-data%2Fthrough.json)](https://github.com/sportsdataverse/sportsdataverse-data/releases)     | [![sdv-reference-data pipeline state](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsportsdataverse%2F.github%2Fmain%2Fstatus%2Fbadges%2Fsdv-reference-data%2Fstatus.json)](https://sportsdataverse.org/status#sdv-reference-data)       | —                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

## Installation

You can install the CRAN version of
[**`hoopR`**](https://CRAN.R-project.org/package=hoopR) with:

``` r
install.packages("hoopR")
```

You can install the development version of
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

### **NBA play-by-play for a season**

`load_nba_pbp()` covers 2002-2027; pass several seasons (or `seasons
= 2002:2026`) to load more at once.

``` r
nba_pbp <- hoopR::load_nba_pbp(seasons = 2026)
```

    ## 642472 rows of NBA play-by-play data from 1325 games.

### **Men’s college basketball play-by-play for a season**

`load_mbb_pbp()` covers 2006-2027.

``` r
mbb_pbp <- hoopR::load_mbb_pbp(seasons = 2026)
```

    ## 2915731 rows of men's college basketball play-by-play data from 6275 games.

## **Plotting and related packages**

  - [**`sdvplotR`**](https://sdvplotR.sportsdataverse.org/) (0.3.0,
    `pak::pak("sportsdataverse/sdvplotR")`) adds team logos and colours
    to `ggplot2` charts and draws shot charts from the `hoopR` shot
    loaders; see its
    [NBA](https://sdvplotR.sportsdataverse.org/articles/nba-viz.html),
    [men’s
    college](https://sdvplotR.sportsdataverse.org/articles/mbb-viz.html)
    and [shot
    chart](https://sdvplotR.sportsdataverse.org/articles/cookbook-surfaces-shot-charts.html)
    articles.
  - [**`sportyR`**](https://sportyR.sportsdataverse.org/) (2.4.5,
    `install.packages("sportyR")`) draws NBA, NCAA and FIBA courts to
    plot shot locations on.
  - [**`wehoop`**](https://wehoop.sportsdataverse.org/) is the women’s
    basketball companion (WNBA and women’s college basketball).
  - [**`sportsdataverse-py`**](https://py.sportsdataverse.org/) is the
    Python package; most `hoopR` functions have a Python twin of the
    same name.

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

<a href="https://github.com/sportsdataverse/hoopR"> <picture>
<source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/sportsdataverse/hoopR/star-history/star-history-dark.svg">
<img alt="Star history of sportsdataverse/hoopR" src="https://raw.githubusercontent.com/sportsdataverse/hoopR/star-history/star-history.png" width="600">
</picture> </a>

## **Our Authors**

  - Saiem Gilani (@saiemgilani)
    <a href="https://x.com/saiemgilani" target="blank"><img src="https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge" alt="@saiemgilani" /></a>

<a href="https://github.com/saiemgilani" target="blank"><img src="https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge" alt="@saiemgilani" /></a>

## **Our Contributors (they’re awesome)**

  - Jason Lee (@theFirmAISports)
    <a href="https://x.com/theFirmAISports" target="blank"><img src="https://img.shields.io/twitter/follow/theFirmAISports?color=blue&label=%40theFirmAISports&logo=x&style=for-the-badge" alt="@theFirmAISports" /></a>
    <a href="https://github.com/papagorgio23" target="blank"><img src="https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge" alt="@papagorgio23" /></a>

  - Billy Fryer

  - Ross Drucker (@rossdrucker9)
    <a href="https://x.com/rossdrucker9" target="blank"><img src="https://img.shields.io/twitter/follow/rossdrucker9?color=blue&label=%40rossdrucker9&logo=x&style=for-the-badge" alt="@rossdrucker9" /></a>
    <a href="https://github.com/rossdrucker" target="blank"><img src="https://img.shields.io/github/followers/rossdrucker?color=eee&logo=Github&style=for-the-badge" alt="@rossdrucker" /></a>

  - Vladislav Shufinskiy (@vshufinskiy)
    <a href="https://x.com/vshufinskiy" target="blank"><img src="https://img.shields.io/twitter/follow/vshufinskiy?color=blue&label=%40vshufinskiy&logo=x&style=for-the-badge" alt="@vshufinskiy" /></a>
    <a href="https://github.com/shufinskiy" target="blank"><img src="https://img.shields.io/github/followers/shufinskiy?color=eee&logo=Github&style=for-the-badge" alt="@shufinskiy" /></a>

<!-- cheatsheet-section -->

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
  title = {hoopR: Access Men's Basketball Play by Play Data},
  url = {https://hoopR.sportsdataverse.org},
  doi = {10.32614/CRAN.package.hoopR},
  year = {2026}
}
```
