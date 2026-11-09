# **B.LEAGUE Schedule Clubs**

**The club filter of the B.LEAGUE schedule page: every club of the
season and division with its team id.**

Endpoint: `GET https://www.bleague.jp/schedule/`

One row per club the page's filter lists, which maps a team id to the
short Japanese name the schedule uses. Reads the same page as
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md)
(one request).

## Usage

``` r
bleague_schedule_clubs(season, tab, month, day, event = NULL)
```

## Arguments

- season:

  (*integer* required): season END year (`2026` = 2025-26); the site's
  own year is the START year, so the request sends `season - 1`.

- tab:

  (*integer* required): division tab: 1 = B1, 2 = B2, 3 = B3.

- month:

  (*integer* required): calendar month 1-12 of the game day (seasons run
  September to June).

- day:

  (*integer* required): day of month of the game day.

- event:

  (*integer* optional): competition type: 2 B1 league, 3 B1
  Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2
  playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs.
  `NULL` (default) = the league competition of the tab (2 / 7 / 15).

## Value

A `hoopR_data` tibble with one row per club the page's filter lists. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_schedule_clubs")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md).

     bleague_schedule_clubs(season = 2026, tab = 1, month = 10, day = 4)

## See also

[family_b_league](https://hoopR.sportsdataverse.org/reference/family_b_league.md)
lists every function in this family.
