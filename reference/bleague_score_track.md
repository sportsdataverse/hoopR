# **B.LEAGUE Score Track**

**Running score after each scoring event of one B.LEAGUE game (v1 feed
only; the site's score-track chart).**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

One row per scoring event: `event_index` is the index of the event (0 =
the 0-0 start row, then 1, 2, ...; the chart's x axis, NOT a clock) and
`home_points` / `away_points` the running totals. Only the v1 feed
publishes it: a v2 game gives a zero-row tibble.

## Usage

``` r
bleague_score_track(schedule_key, season = NULL)
```

## Arguments

- schedule_key:

  (*integer* required): B.LEAGUE ScheduleKey, one global sequence across
  B1, B2, B3 and every season, e.g. `504734` (B1 2025-26 sec 1, Alvark
  Tokyo v Utsunomiya Brex); the `schedule_key` column of
  [`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md).

- season:

  (*integer* optional): a guard, the season END year the game must
  belong to; a context whose `Year` differs raises `hoopR_asset_fetch`.
  `NULL` (default) = no check (the key alone selects the game).

## Value

A `hoopR_data` tibble with one row per scoring event. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_score_track")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md).

     bleague_score_track(schedule_key = 10693)

## See also

[family_b_league](https://hoopR.sportsdataverse.org/reference/family_b_league.md)
lists every function in this family.
