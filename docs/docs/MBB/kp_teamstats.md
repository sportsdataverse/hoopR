---
title: kp_teamstats
sidebar_label: kp_teamstats
---
# `kp_teamstats`

## Description

Get Team Stats


## Usage

```r
kp_teamstats(min_year, max_year, defense = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`min_year`     |     First year of data to pull
`max_year`     |     Last year of data to pull
`defense`     |     Choose whether to pull offense(default) with FALSE or defense with TRUE


## Examples

```r
kp_teamstats(min_year = 2019, max_year = 2020, defense = FALSE)
```


