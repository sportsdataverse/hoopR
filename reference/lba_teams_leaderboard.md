# **Get LBA Teams Leaderboard**

Season team leaderboards, offensive or defensive, one row per team and
category.

Endpoint:
`GET https://www.legabasket.it/api/statistics/get-teams-statistics-by-type`
(`cs_id=1&type=<board>&s=<season>`)

## Usage

``` r
lba_teams_leaderboard(board, season = NULL)
```

## Arguments

- board:

  (required) Board: teams_offensive or teams_defensive. One of
  `"teams_offensive"`, `"teams_defensive"`.

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

## Value

A `hoopR_data` tibble with one row per team and category. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_teams_leaderboard")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_teams_leaderboard(board = "teams_offensive", season = 2027)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
