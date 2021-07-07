---
title: kp_game_attrs
sidebar_label: kp_game_attrs
---
# `kp_game_attrs`

## Description

Get Game Attributes


## Usage

```r
kp_game_attrs(year = 2020, attr = "Excitement")
```


## Arguments

Argument      |Description
------------- |----------------
`year`     |     Year of data to pull
`attr`     |     Game Attribute, valid values include: 'Excitement', 'Tension','Dominance','MinWp','FanMatch', 'Upsets','Busts','Comeback','Window'


## Examples

```r
kp_game_attrs(year=2020, attr = "Excitement")
```


