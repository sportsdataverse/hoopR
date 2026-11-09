# **Get ACB Club Data**

Club profile: arena, contacts and links.

One row: the club's current team entry, the arena (name, address,
capacity), foundation year, contact details and social links. Several
fields are null for many clubs.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/club-data`

## Usage

``` r
acb_club_data(club_id)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per club. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_club_data")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_club_data(club_id = 2)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
