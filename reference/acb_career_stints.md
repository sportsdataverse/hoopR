# **Get ACB Career Stints**

A player's club stints, one row per stint.

One row per stint: first and last year, the club's team entry for the
stint and how many editions it spans (`n_editions`).

Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/career`

## Usage

``` r
acb_career_stints(player_id)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per stint. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_career_stints")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_career_stints(player_id = 20209407)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
