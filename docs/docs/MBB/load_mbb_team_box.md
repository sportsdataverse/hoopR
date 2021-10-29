---
title: load_mbb_team_box
sidebar_label: load_mbb_team_box
---
# `load_mbb_team_box`

Load hoopR men's college basketball team box scores


## Description

helper that loads multiple seasons from the data repo either into memory
 or writes it into a db using some forwarded arguments in the dots


## Usage

```r
load_mbb_team_box(seasons, ..., qs = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`seasons`     |     A vector of 4-digit years associated with given men's college basketball seasons.
`...`     |     Additional arguments passed to an underlying function that writes the season data into a database (used by [`update_mbb_db()`](#updatembbdb()) ).
`qs`     |     Wheter to use the function [`qs::qdeserialize()`](#qs::qdeserialize()) for more efficient loading.


## Examples

```r
future::plan("multisession")
load_mbb_team_box(2003:2021)
```


