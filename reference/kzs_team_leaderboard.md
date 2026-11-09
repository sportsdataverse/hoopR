# **Get KZS Team Leaderboard**

Team leaderboard of a competition for one stat category (total, per-game
average and single-game best).

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/teamStats`

## Usage

``` r
kzs_team_leaderboard(
  competition_id,
  stats_category = "PTS",
  order_type = "AVERAGE",
  sort_by = "avg",
  sort = "DESC"
)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

- stats_category:

  Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2
  two-pointers, M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field
  goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D defensive, R_O
  offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls
  committed/received, ASS_TOV and ST_TOV ratios. Competitions without
  live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of
  "PTS", "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG",
  "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D", "R_O", "ASS", "ST",
  "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".

- order_type:

  Figure the leaderboard is built on: AVERAGE (per game), SUM (season
  total) or BEST_PERFORMANCE. One of "AVERAGE", "SUM",
  "BEST_PERFORMANCE".

- sort_by:

  Row column the board is ordered by: avg (average), sum or max. The
  runtime checks the order. One of "avg", "sum", "max".

- sort:

  Sort direction. One of "ASC", "DESC".

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_team_leaderboard")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_team_leaderboard(competition_id = 579)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
