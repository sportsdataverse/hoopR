# **FIBA GDAP: game officials**

Officials nominated to one game (referees, table officials,
commissioner).

Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`

## Usage

``` r
fiba_gdap_game_officials(game_id, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) Required. FIBA game id (global GDAP key space):
  gameId of a schedule row; the `<gameId>` of a game page URL

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64) of the game the official was nominated to. |
| person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name (officials: upper case). |
| gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
| role_code | character | Role code (REF, FIBATDEL...). |
| role_name | character | Role name on the game (Crew chief, Umpire, Commissioner, Assistant scorer...). |
| role_order | character | Order within the role; a numeric string or null. |
| default_nationality | character | FIBA code of the official's main nationality. |
| license_nationality | character | FIBA code of the federation that licenses the official. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_game_officials(game_id = 100720)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
