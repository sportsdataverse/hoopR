---
title: kp_team_depth_chart
sidebar_label: kp_team_depth_chart
---
# `kp_team_depth_chart`

## Description

Get Depth Chart Last 5 Games from Team Page


## Usage

```r
kp_team_depth_chart(team, year = 2020)
```


## Arguments

Argument      |Description
------------- |----------------
`team`     |     Team filter to select.
`year`     |     Year of data to pull


## Value

A data frame with 12 columns

## Examples

```r
kp_team_depth_chart(team = 'Florida St.', year= 2020)
```


