# **Get LBA Roster Coach**

Head coach of one team-season.

Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster`
(`id=<team_id>`)

## Usage

``` r
lba_roster_coach(team_id)
```

## Arguments

- team_id:

  (required) Team id (team_id in lba_teams), e.g. 1764. One team-season:
  ids are re-issued every season.

## Value

A `hoopR_data` tibble with one row per head coach. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_roster_coach")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_roster_coach(team_id = 1764)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
