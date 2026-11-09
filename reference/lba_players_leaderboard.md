# **Get LBA Players Leaderboard**

Season player leaderboard for one category (per-game average).

Endpoint:
`GET https://www.legabasket.it/api/statistics/get-players-statistics`
(`cs_id=1&s=<season>&cat=<category>`)

## Usage

``` r
lba_players_leaderboard(season = NULL, category = "points")
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

- category:

  Category: points, rating_lega, total_rebound, assists, shots_3p_perc,
  ... (the site's filters.categories).

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_players_leaderboard")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_players_leaderboard(season = 2027, category = "points")

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
