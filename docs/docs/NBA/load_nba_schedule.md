---
title: load_nba_schedule
sidebar_label: load_nba_schedule
---
# `load_nba_schedule`

Load hoopR NBA schedules


## Description

helper that loads multiple seasons from the data repo either into memory
 or writes it into a db using some forwarded arguments in the dots


## Usage

```r
load_nba_schedule(seasons, ..., qs = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`seasons`     |     A vector of 4-digit years associated with given NBA seasons.
`...`     |     Additional arguments passed to an underlying function that writes the season data into a database (used by [`update_nba_db()`](#updatenbadb()) ).
`qs`     |     Wheter to use the function [`qs::qdeserialize()`](#qs::qdeserialize()) for more efficient loading.


## Examples

```r
future::plan("multisession")
load_nba_schedule(2002:2021)
```


