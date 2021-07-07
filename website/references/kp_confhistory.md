---
title: kp_confhistory
description: Get KenPom's historical conference ratings
featured: true
topics: Conference
recommended: null
---
# `kp_confhistory`

Get KenPom's historical conference ratings


## Description

Get KenPom's historical conference ratings


## Usage

```r
kp_confhistory(conf)
```


## Arguments

Argument      |Description
------------- |----------------
`conf`     |     Used to limit to players in a specific conference.  Allowed values are: 'A10', 'ACC', 'AE', 'AMER', 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', 'SUM', 'SWAC', 'WAC', 'WCC'.  If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that. No filter applied by default.


## Value

A data frame with 23 columns:
  

*   `Year` - integer  

*   `Rank` - character  

*   `Tempo` - double  

*   `Efficiency` - double  

*   `eFG.Pct` - double  

*   `TO.Pct` - double  

*   `OR.Pct` - double  

*   `FTR` - double  

*   `FG2.Pct` - double  

*   `FG3.Pct` - double  

*   `FT.Pct` - double  

*   `FG3A.Pct` - double  

*   `A.Pct` - double  

*   `Blk.Pct` - double  

*   `Stl.Pct` - double  

*   `HomeRecord` - character  

*   `Bids` - character  

*   `S16` - character  

*   `F4` - character  

*   `CH` - character  

*   `RegSeasonChamp` - character  

*   `TourneyChamp` - character  

*   `BestTeam` - character


## Examples

```r
kp_confhistory(conf='ACC')
```


