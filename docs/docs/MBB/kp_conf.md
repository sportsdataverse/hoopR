---
title: kp_conf
sidebar_label: kp_conf
---
# `kp_conf`

## Description

Get KenPom's conference-wide stats


## Usage

```r
kp_conf(year, conf)
```


## Arguments

Argument      |Description
------------- |----------------
`year`     |     Year (YYYY)
`conf`     |     Used to limit to players in a specific conference. Allowed values are: 'A10', 'ACC', 'AE', 'AMER', 'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY', 'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB', 'SC', 'SEC', 'SLND', 'SUM', 'SWAC', 'WAC', 'WCC'. If you try to use a conference that doesn't exist for a given season, like 'IND' and '2018', you'll get an empty table, as kenpom.com doesn't serve 404 pages for invalid table queries like that. No filter applied by default.


## Value

A list of 7 dataframes accessible via `[[1]]` , `[[2]]` ,...,, `[[7]]` list() 
 First data frame, accessible via `[[1]]` list() 
 A data frame with 15 columns
 Second data frame, accessible via `[[2]]` list() 
 A data frame with 20 columns
 Third data frame, accessible via `[[3]]` list() 
 A data frame with 20 columns
 Fourth data frame, accessible via `[[4]]` list() 
 A data frame with 3 columns
 Fifth data frame, accessible via `[[5]]` list() 
 A data frame with 4 columns
 Sixth data frame, accessible via `[[6]]` list() 
 A data frame with 5 columns
 Seventh data frame, accessible via `[[7]]` list() 
 A data frame 4 columns
 
## Examples

```r
kp_conf(year='2020',conf='ACC')
```


