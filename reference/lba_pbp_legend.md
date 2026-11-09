# **Get LBA Play-by-Play Legend**

The play-by-play qualifier code table (59 codes) with its Italian
labels.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play`
(`info=true&sort=asc&id=<game_id>`)

## Usage

``` r
lba_pbp_legend(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble: The play-by-play qualifier code table (59 codes)
with its Italian labels. The columns are always these, in this order
(sportsdataverse-py `lba_pbp_legend`); a column the site adds later is
appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| code | integer | Qualifier code, the value of action_1_qualifier_code / action_2_qualifier_code on the actions. |
| label | character | Italian label of the qualifier code, as sent. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_pbp_legend(game_id = 25602)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
