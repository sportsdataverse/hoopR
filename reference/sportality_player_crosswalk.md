# **Get the Basketligaen player id crosswalk**

Genius person id -\> athlete uuid for every player of a Basketligaen
season, from one stats-info call (`players_summary`). The site has two
player id systems: the **Genius person id** that play-by-play, box
scores and stats tables key on (and that joins the genius family), and
the platform **athlete uuid** that rosters and athlete routes key on.
The `players_summary` table's `players` map is keyed by Genius id and
carries each player's uuid.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/stats-info/players_summary`

## Usage

``` r
sportality_player_crosswalk(season, game_type = "regular")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025/26), mapped to its ssgt
  through layout-info.

- game_type:

  (default `"regular"`) Game type: `regular` (the league season) or
  `finals` (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_player_crosswalk")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_player_crosswalk(season = 2026)

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
