# **Get BBL Referees**

Current referees and commissioners (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/referees`

## Usage

``` r
scb_referees(page_size = 100)
```

## Arguments

- page_size:

  (default `100`) Rows per page. 100 returns all current officials in
  one page; a result that needs more pages is refused.

## Value

A `hoopR_data` tibble: Current referees and commissioners (BBL only). An
empty valid answer raises `hoopR_no_data`; the columns are always these,
in this order (sportsdataverse-py `scb_referees`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| referee_id | character | Official id (`refId`, equal to the API's `id`); joins `referee1_id` .. `commissioner_id` of `scb_games`. |
| first_name | character | Official's given name. |
| last_name | character | Official's family name. |
| official_function | character | REFEREE or COMMISSIONER. |
| participations | integer | League games officiated. |
| year_joined_bbl | integer | Year the official joined the league. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_referees()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
