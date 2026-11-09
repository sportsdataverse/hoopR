# **Get ACB Team Records**

A club's single-game records (best performance per statistic).

One row per statistic (`stat`): `value` is the record, with the game
(`game_id`, `game_date`), the player and both teams of that game.
Records go back to 1983-84; `game_id` is a match id of the legacy
sequence.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-records`

## Usage

``` r
acb_team_records(club_id)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per statistic. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_team_records")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_records(club_id = 2)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
