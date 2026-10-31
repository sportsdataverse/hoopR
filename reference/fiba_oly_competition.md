# **FIBA competition: Men's Olympic Basketball Tournament**

Per-competition aliases of the FIBA wrappers for Men's Olympic
Basketball Tournament (GDAP competition family 320), named as in
sportsdataverse-py. Season rule: event year (Paris 2024 = 2024).

## Usage

``` r
fiba_oly_editions(season = NULL, to_season = NULL, return_parsed = TRUE)

fiba_oly_schedule(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_standings(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_teams(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_player_box(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_team_box(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_pbp(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_oly_shots(game_id, season = NULL, comp = NULL, return_parsed = TRUE)
```

## Arguments

- game_id:

  FIBA game id (`game_id` in the schedule).

- season:

  Edition season key (event year (Paris 2024 = 2024)). Omitted = the
  newest edition that has started; a game function needs `season` or
  `comp`. For `fiba_oly_editions()`: the first season (inclusive),
  omitted = every edition.

- to_season:

  Last season, inclusive (`fiba_oly_editions()` only).

- comp:

  FIBA competition id (one per edition); skips the edition lookup and is
  needed when a season lists several editions. Checked to be an edition
  of this competition (one cached getGdapCompetitionById request).

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with the columns of the base wrapper (the raw JSON
list when `return_parsed = FALSE`) of each function:

- `fiba_oly_editions()`: the columns of
  [`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md).

- `fiba_oly_schedule()`: the columns of
  [`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md).

- `fiba_oly_standings()`: the columns of
  [`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md).

- `fiba_oly_teams()`: the columns of
  [`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md).

- `fiba_oly_player_box()`: the columns of
  [`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

- `fiba_oly_team_box()`: the columns of
  [`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md).

- `fiba_oly_pbp()`: the columns of
  [`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md).

- `fiba_oly_shots()`: the columns of
  [`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md).

## Details

FIBA's terms restrict this source: the GDAP developer-portal terms limit
API use to 'Authorized Users' and the fiba.basketball terms say no
portion of the site may be duplicated, redistributed or manipulated.
Users who are not themselves authorised by FIBA should check the terms
before using the wrappers. See
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md)
for the shared notes.

A `comp` of another competition family, or one GDAP gives no family, is
`hoopR_asset_fetch`; a season with no edition is `hoopR_no_data`; a
season listing several editions, or a game function called with neither
`season` nor `comp`, is `hoopR_bad_request`.

     fiba_oly_editions(season = 2024)
     fiba_oly_schedule(season = 2024)

## See also

Other FIBA Competition Functions:
[`fiba_afrobasket_competition`](https://hoopR.sportsdataverse.org/reference/fiba_afrobasket_competition.md),
[`fiba_americup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_americup_competition.md),
[`fiba_asiacup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_asiacup_competition.md),
[`fiba_bcl_competition`](https://hoopR.sportsdataverse.org/reference/fiba_bcl_competition.md),
[`fiba_bcla_competition`](https://hoopR.sportsdataverse.org/reference/fiba_bcla_competition.md),
[`fiba_eurobasket_competition`](https://hoopR.sportsdataverse.org/reference/fiba_eurobasket_competition.md),
[`fiba_icup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_icup_competition.md),
[`fiba_wc_competition`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md)
