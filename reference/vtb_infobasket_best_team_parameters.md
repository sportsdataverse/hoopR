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

A `hoopR_data` tibble: Team leader categories (a code table). The
columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_best_team_parameters`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| param | integer | Leader-category id; pass it as `param` to /Widget/BestPlayers or /Widget/BestTeams. |
| name | character | Leader-category name, English (double spaces as sent). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_best_team_parameters()

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
