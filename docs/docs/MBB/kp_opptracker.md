---
title: kp_opptracker
sidebar_label: kp_opptracker
---
# `kp_opptracker`

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


