# **Get LBA Team Players Stats**

Season totals of each player of a team-season.

Endpoint:
`GET https://www.legabasket.it/api/teams/get-team-players-stats`
(`cs_id=1&id=<team_id>&s=<season>`)

## Usage

``` r
lba_team_players_stats(team_id, season = NULL)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

- season:

  Season END year (2027 = 2026-27) of the team id. Omitted = the site's
  default (unverified).

## Value

A `hoopR_data` tibble with one row per player of the team. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_team_players_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_team_players_stats(team_id = 1764, season = 2027)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
