# **FIBA competition: Basketball Champions League Americas**

Per-competition aliases of the FIBA wrappers for Basketball Champions
League Americas (GDAP competition family 110), named as in
sportsdataverse-py. Season rule: END year (2024-25 = 2025).

## Usage

``` r
fiba_bcla_editions(season = NULL, to_season = NULL, return_parsed = TRUE)

fiba_bcla_schedule(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_bcla_standings(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_bcla_teams(season = NULL, comp = NULL, return_parsed = TRUE)

fiba_bcla_player_box(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_bcla_team_box(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_bcla_pbp(game_id, season = NULL, comp = NULL, return_parsed = TRUE)

fiba_bcla_shots(game_id, season = NULL, comp = NULL, return_parsed = TRUE)
```

## Arguments

- game_id:

  FIBA game id (`game_id` in the schedule).

- season:

  Edition season key (END year (2024-25 = 2025)). Omitted = the newest
  edition that has started; a game function needs `season` or `comp`.
  For `fiba_bcla_editions()`: the first season (inclusive), omitted =
  every edition.

- to_season:

  Last season, inclusive (`fiba_bcla_editions()` only).

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

- `fiba_bcla_editions()`: the columns of
  [`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md).

- `fiba_bcla_schedule()`: the columns of
  [`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md).

- `fiba_bcla_standings()`: the columns of
  [`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md).

- `fiba_bcla_teams()`: the columns of
  [`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md).

- `fiba_bcla_player_box()`: the columns of
  [`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

- `fiba_bcla_team_box()`: the columns of
  [`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md).

- `fiba_bcla_pbp()`: the columns of
  [`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md).

- `fiba_bcla_shots()`: the columns of
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

     fiba_bcla_editions(season = 2025)
     fiba_bcla_schedule(season = 2025)

## See also

Other FIBA Competition Functions:
[`fiba_afrobasket_competition`](https://hoopR.sportsdataverse.org/reference/fiba_afrobasket_competition.md),
[`fiba_americup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_americup_competition.md),
[`fiba_asiacup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_asiacup_competition.md),
[`fiba_bcl_competition`](https://hoopR.sportsdataverse.org/reference/fiba_bcl_competition.md),
[`fiba_eurobasket_competition`](https://hoopR.sportsdataverse.org/reference/fiba_eurobasket_competition.md),
[`fiba_icup_competition`](https://hoopR.sportsdataverse.org/reference/fiba_icup_competition.md),
[`fiba_oly_competition`](https://hoopR.sportsdataverse.org/reference/fiba_oly_competition.md),
[`fiba_wc_competition`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md)
