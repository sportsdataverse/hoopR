---
title: espn_mbb_scoreboard
sidebar_label: espn_mbb_scoreboard
---
# `espn_mbb_scoreboard`

## Description

Get ESPN men's college basketball schedule for a specific year


## Usage

```r
espn_mbb_scoreboard(season)
```


## Arguments

Argument      |Description
------------- |----------------
`season`     |     Either numeric or character


## Value

Returns a tibble


## Author

Thomas Mock, you a genius for this one.


## Examples

```r
# Get schedule from 2018 season (returns 1000 results, max allowable.)

# Get schedule from date 2021-02-15
espn_mbb_scoreboard (season = "20210215")
```


