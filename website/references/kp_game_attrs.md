---
title: kp_game_attrs
description: Get Game Attributes
featured: true
topics: Game
recommended: null
---
# `kp_game_attrs`

Get Game Attributes


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
`attr`     |     Game Attribute, valid values include: list()  'Excitement', 'Tension','Dominance','MinWp','FanMatch', list()  'Upsets','Busts','Comeback','Window'


## Examples

```r
kp_game_attrs(year=2020, attr = "Excitement")
```


