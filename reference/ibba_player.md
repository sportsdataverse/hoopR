# **IBBA Player**

**One player-season row: jersey, team, names and photo.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/PlayerById`

## Usage

``` r
ibba_player(player_id, season)
```

## Arguments

- player_id:

  (*integer* required): Player-season id (new every season; Jaylen Hoard
  = 21912 in 2025-26): `player_id` in ibba_players.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_player")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_player(player_id = 21912, season = 2026)

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
