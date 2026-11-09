# **Get ACB Team Leaders**

A club's statistical leaders for an edition and all-time.

One row per scope, metric and rank. `scope` is `all_time` (club record
holders, the API's `leaders`) or `edition` (the selected season,
`seasonLeaders`); `metric` is the API's category (`points`,
`avg_points`, `played_matches`...); `value` is a total or an average
depending on the metric (Float64). The scope assignment is inferred from
the values.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-leaders`

## Usage

``` r
acb_team_leaders(
  club_id,
  number_of_players,
  competition_id = NULL,
  season = NULL
)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- number_of_players:

  (required) Leaders per statistic; 0 is refused (HTTP 400). A whole
  number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble with one row per scope, statistic and rank. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_team_leaders")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_leaders(club_id = 2, number_of_players = 3, season = 2027)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
