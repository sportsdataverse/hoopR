---
title: kp_opptracker
description: Get KenPom's team opponent tracker page
featured: true
topics: Opponent
recommended: null
---
# `kp_opptracker`

Get KenPom's team opponent tracker page


## Description

Get KenPom's team opponent tracker page


## Usage

```r
kp_opptracker(team, year = as.integer(format(Sys.Date(), "%Y")))
```


## Arguments

Argument      |Description
------------- |----------------
`team`     |     Team filter to select.
`year`     |     Year of data to pull


## Examples

```r
kp_opptracker(team='Florida St.', year=2020)
```


