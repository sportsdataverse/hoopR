---
title: kp_playerstats
sidebar_label: kp_playerstats
---
# `kp_playerstats`

Get Player Stats Leaders by Metric


## Description

Get Player Stats Leaders by Metric


## Usage

```r
kp_playerstats(metric = "eFG", conf = NULL, conf_only = FALSE, year)
```


## Arguments

Argument      |Description
------------- |----------------
`metric`     |     Used to get leaders for different metrics. Available values are: list()  'ORtg', 'Min', 'eFG', 'Poss', Shots', 'OR', 'DR', 'TO', 'ARate', 'Blk', list()  'FTRate', 'Stl', 'TS', 'FC40', 'FD40', '2P', '3P', 'FT'. list()  Default is 'eFG'. 'ORtg' returns a list of four dataframes, as there are four tables: list()  players that used more than 28 percent of possessions, more than 24 percent of possessions, more than 20 percent of possessions, and with no possession restriction.
`conf`     |     Used to limit to players in a specific conference. Allowed values are: 'A10', 'ACC', 'AE', 'AMER', list()  'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', list()  'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', list()  'SUM', 'SWAC', 'WAC', 'WCC'. list()  If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', list()  you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that. list()  No filter applied by default.
`conf_only`     |     Used to define whether stats should reflect conference games only. list()  Only available if specific conference is defined. Only available for season after 2013, FALSE by default.
`year`     |     Year of data to pull (earliest year of data available: 2004)


## Examples

```r
kp_playerstats(metric = 'eFG', conf_only = FALSE, year=2020)
```


