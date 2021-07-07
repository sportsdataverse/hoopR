---
title: kp_confstats
description: Get KenPom's conference comparison stats
featured: true
topics: Comparison
recommended: null
---
# `kp_confstats`

Get KenPom's conference comparison stats


## Description

Get KenPom's conference comparison stats


## Usage

```r
kp_confstats(year)
```


## Arguments

Argument      |Description
------------- |----------------
`year`     |     Year (YYYY)


## Value

A data frame with 35 columns:
  

*  list("Conf") character.  

*  list("Eff") double.  

*  list("Eff.Rk") double.  

*  list("Tempo") double.  

*  list("Tempo.Rk") double.  

*  list("eFG.Pct") double.  

*  list("eFG.Pct.Rk") double.  

*  list("TO.Pct") double.  

*  list("TO.Pct.Rk") double.  

*  list("OR.Pct") double.  

*  list("OR.Pct.Rk") double.  

*  list("FTRate") double.  

*  list("FTRate.Rk") double.  

*  list("Blk.Pct") double.  

*  list("Blk.Pct.Rk") double.  

*  list("Stl.Pct") double.  

*  list("Stl.Pct.Rk") double.  

*  list("FG_2.Pct") double.  

*  list("FG_2.Pct.Rk") double.  

*  list("FG_3.Pct") double.  

*  list("FG_3.Pct.Rk") double.  

*  list("FT.Pct") double.  

*  list("FT.Pct.Rk") double.  

*  list("FG_3A.Pct") double.  

*  list("FG_3A.Pct.Rk") double.  

*  list("A.Pct") double.  

*  list("A.Pct.Rk") double.  

*  list("HomeWL") character.  

*  list("HomeWL.Pct") double.  

*  list("HomeWL.Rk") double.  

*  list("Close") double.  

*  list("Close.Rk") double.  

*  list("Blowouts") double.  

*  list("Blowouts.Rk") double.  

*  list("Year") character.


## Examples

```r
kp_confstats(year='2020')
```


