# **Get CBA Player Shots**

Season player shot-zone profile (one page).

Endpoint: `POST https://data-server.cbaleague.com/api/player-shoot-list`
(JSON body)

## Usage

``` r
cba_player_shots(
  season,
  match_type_id = 1,
  count_ranger = 1,
  player_ranger = 1,
  team_id = NULL,
  sort = 3,
  rank = 1,
  page_number = 1,
  page_size = 100
)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- count_ranger:

  (default `1`) How counting statistics scale: 1 per game (default), 2
  season total, 3 per 36 minutes, 4 per 100 possessions.

- player_ranger:

  (default `1`) Which players: 1 all (default), 2 domestic (Chinese)
  only, 4 foreign only.

- team_id:

  (optional) Optional CBA team id (clubs, stable across seasons and
  renames) to list one team's players.

- sort:

  (default `3`) Sort column code the site sends (3 is the default
  order); the API answers an empty body without it.

- rank:

  (default `1`) Sort direction code the site sends (1 default); the API
  answers an empty body without it.

- page_number:

  (default `1`) Page number of the paged list, from 1.

- page_size:

  (default `100`) Rows per page (the site uses 100).

## Value

A `hoopR_data` tibble with one row per player of the requested page. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_player_shots")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_player_shots(season = 2026, team_id = 29128)

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
