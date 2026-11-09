# **Get the Basketligaen ssgt uuid of a season**

The ssgt (season + series + game type) uuid of a season END year and
game type, from `/statistics-v2/layout-info` (fetched once per R
session). Use it for the routes that take an ssgt uuid directly:
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md)
and
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md).

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/layout-info`

## Usage

``` r
sportality_ssgt_uuid(season, game_type = "regular")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025/26). Basketligaen 2002/03 on.

- game_type:

  (default `"regular"`) Game type: `regular` (the league season) or
  `finals` (the playoffs, Slutspil).

## Value

A character string: the ssgt uuid (e.g. `"qzw34da6jg"` for the 2025/26
regular season). A season or game type layout-info does not list raises
`hoopR_no_data`; a season that is not a year raises `hoopR_bad_request`.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_ssgt_uuid(season = 2026)
     sportality_ssgt_uuid(season = 2026, game_type = "finals")

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
