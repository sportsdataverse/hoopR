---
title: kp_confstats
sidebar_label: kp_confstats
---
# `kp_confstats`

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
  

*  `Conf` character.  

*  `Eff` double.  

*  `Eff.Rk` double.  

*  `Tempo` double.  

*  `Tempo.Rk` double.  

*  `eFG.Pct` double.  

*  `eFG.Pct.Rk` double.  

*  `TO.Pct` double.  

*  `TO.Pct.Rk` double.  

*  `OR.Pct` double.  

*  `OR.Pct.Rk` double.  

*  `FTRate` double.  

*  `FTRate.Rk` double.  

*  `Blk.Pct` double.  

*  `Blk.Pct.Rk` double.  

*  `Stl.Pct` double.  

*  `Stl.Pct.Rk` double.  

*  `FG_2.Pct` double.  

*  `FG_2.Pct.Rk` double.  

*  `FG_3.Pct` double.  

*  `FG_3.Pct.Rk` double.  

*  `FT.Pct` double.  

*  `FT.Pct.Rk` double.  

*  `FG_3A.Pct` double.  

*  `FG_3A.Pct.Rk` double.  

*  `A.Pct` double.  

*  `A.Pct.Rk` double.  

*  `HomeWL` character.  

*  `HomeWL.Pct` double.  

*  `HomeWL.Rk` double.  

*  `Close` double.  

*  `Close.Rk` double.  

*  `Blowouts` double.  

*  `Blowouts.Rk` double.  

*  `Year` character.


## Examples

```r
kp_confstats(year='2020')
```


