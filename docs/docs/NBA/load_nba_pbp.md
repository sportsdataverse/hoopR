---
title: load_nba_pbp
sidebar_label: load_nba_pbp
---
# `load_nba_pbp`

Load hoopR NBA play-by-play


## Description

helper that loads multiple seasons from the data repo either into memory
 or writes it into a db using some forwarded arguments in the dots


## Usage

```r
load_nba_pbp(seasons, ..., qs = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`seasons`     |     A vector of 4-digit years associated with given women's college basketball seasons.
`...`     |     Additional arguments passed to an underlying function that writes the season data into a database (used by [`update_nba_db()`](#updatenbadb()) ).
`qs`     |     Wheter to use the function [`qs::qdeserialize()`](#qs::qdeserialize()) for more efficient loading.


## Examples

```r
future::plan("multisession")
load_nba_pbp(2002:2021)
```


