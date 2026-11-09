# **Get VTB Infobasket Best Team Parameters**

Team leader categories (a code table).

Endpoint: `GET https://org.infobasket.su/Widget/GetBestTeamParameters/`

## Usage

``` r
vtb_infobasket_best_team_parameters(lang = "en")
```

## Arguments

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

## Value

A `hoopR_data` tibble with one row per leader category. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_best_team_parameters")`)
and in the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_best_team_parameters()

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
