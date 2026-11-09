# **NBL Rosetta Player Game Log**

A player's game log for a season: the box-score line of each game
(period 0 = whole game) and the game.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/player_boxscores/for/{player_id}/in/season/{season}/regular`

## Usage

``` r
nbl_rosetta_player_game_log(
  player_id,
  season,
  org = "nbl",
  participated = NULL
)
```

## Arguments

- player_id:

  (*character* required): Player id: the DataCore person id (player_id
  of nbl_rosetta_players) or Rosetta's own id; either is accepted.

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- participated:

  (*integer* default `NULL`): 1 = only games the player played in
  (without it, games on the roster that he sat out too). Sent as
  `filter[participated]`.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_player_game_log")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_player_game_log(
       org = "nbl", participated = 1, player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f",
       season = 2026
     )

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.
