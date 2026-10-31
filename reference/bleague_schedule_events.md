# **B.LEAGUE Schedule Events**

**The competitions the B.LEAGUE schedule page offers for one season and
division (the `event` filter).**

Endpoint: `GET https://www.bleague.jp/schedule/`

One row per competition type (2 B1 league, 3 B1 Championship, 5
all-star, 7 B2 league, 15 B3 league, ...) with its Japanese label;
`selected` marks the one the page was asked for. Reads the same page as
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md)
(one request).

## Usage

``` r
bleague_schedule_events(season, tab, month, day, event = NULL)
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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
| event_id | integer | Competition type code (see event); the page's event filter value. |
| label | character | Competition label in Japanese (e.g. B1 league, all-star game, B1 Championship). |
| selected | logical | True for the competition the page was asked for. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md).

     bleague_schedule_events(season = 2026, tab = 1, month = 10, day = 4)

## See also

Other B.LEAGUE Functions:
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md),
[`bleague_leaders()`](https://hoopR.sportsdataverse.org/reference/bleague_leaders.md),
[`bleague_pbp()`](https://hoopR.sportsdataverse.org/reference/bleague_pbp.md),
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md),
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md),
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md),
[`bleague_schedule_clubs()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_clubs.md),
[`bleague_schedule_days()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_days.md),
[`bleague_score_track()`](https://hoopR.sportsdataverse.org/reference/bleague_score_track.md),
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md),
[`bleague_standings()`](https://hoopR.sportsdataverse.org/reference/bleague_standings.md),
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)
