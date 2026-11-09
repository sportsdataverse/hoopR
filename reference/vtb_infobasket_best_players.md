# **Get VTB Infobasket Best Players**

Player leaders of a season for the first `count` leader categories.

Endpoint: `GET https://org.infobasket.su/Comp/GetBestPlayers/{season}`

## Usage

``` r
vtb_infobasket_best_players(season, count = 5, lang = "en", tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached).

- count:

  Leader categories to return (the site's widget asks 5).

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per ranked player. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_best_players")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_best_players(season = 2026)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
