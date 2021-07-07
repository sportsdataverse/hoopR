---
title: update_mbb_db
description: `update_mbb_db()` updates or creates a database with `hoopR` 
 play by play data of all completed and available games since 2002.
featured: true

recommended: null
---
# `update_mbb_db`

Update or create a hoopR play-by-play database


## Description

`update_mbb_db()` updates or creates a database with `hoopR` 
 play by play data of all completed and available games since 2002.


## Usage

```r
update_mbb_db(
  dbdir = ".",
  dbname = "hoopR_db",
  tblname = "hoopR_mbb_pbp",
  force_rebuild = FALSE,
  db_connection = NULL
)
```


## Arguments

Argument      |Description
------------- |----------------
`dbdir`     |     Directory in which the database is or shall be located
`dbname`     |     File name of an existing or desired SQLite database within `dbdir`
`tblname`     |     The name of the play by play data table within the database
`force_rebuild`     |     Hybrid parameter (logical or numeric) to rebuild parts of or the complete play by play data table within the database (please see details for further information)
`db_connection`     |     A `DBIConnection` object, as returned by [`DBI::dbConnect()`](#dbi::dbconnect()) (please see details for further information)


## Details

This function creates and updates a data table with the name `tblname` 
 within a SQLite database (other drivers via `db_connection` ) located in
 `dbdir` and named `dbname` .
 The data table combines all play by play data for every available game back
 to the 2002 season and adds the most recent completed games as soon as they
 are available for `hoopR` .
 
 The argument `force_rebuild` is of hybrid type. It can rebuild the play
 by play data table either for the whole hoopR era (with `force_rebuild = TRUE` )
 or just for specified seasons (e.g. `force_rebuild = c(2019, 2020)` ).
 Please note the following behavior:
  

*  list(list("force_rebuild = TRUE")) list(": The data table with the name ", list("tblname"), "\n", "will be removed completely and rebuilt from scratch. This is helpful when\n", "new columns are added during the Off-Season.")  

*  list(list("force_rebuild = c(2019, 2020)")) list(": The data table with the name ", list("tblname"), "\n", "will be preserved and only rows from the 2019 and 2020 seasons will be\n", "deleted and re-added. This is intended to be used for ongoing seasons because\n", "ESPN's data provider can make changes to the underlying data during the week.")  
 
 The parameter `db_connection` is intended for advanced users who want
 to use other DBI drivers, such as MariaDB, Postgres or odbc. Please note that
 the arguments `dbdir` and `dbname` are dropped in case a `db_connection` 
 is provided but the argument `tblname` will still be used to write the
 data table into the database.


