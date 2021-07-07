---
title: espn_nba_scoreboard
description: Get ESPN men's NBA schedule for a specific year
featured: true

recommended: null
---
# `espn_nba_scoreboard`

Get ESPN men's NBA schedule for a specific year


## Description

Get ESPN men's NBA schedule for a specific year


## Usage

```r
espn_nba_scoreboard(season)
```


## Arguments

Argument      |Description
------------- |----------------
`season`     |     Either numeric or character (YYYYMMDD)


## Value

Returns a tibble


## Author

Thomas Mock, you a genius for this one.


## Examples

```r
# Get schedule from date 2021-02-15 (returns 1000 results, max allowable.)
espn_nba_scoreboard (season = "20210215")
```


