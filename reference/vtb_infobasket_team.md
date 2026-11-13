# **Get VTB Infobasket Team**

Club profile: names, region, country, status.

Endpoint: `GET https://org.infobasket.su/Widget/TeamPage/{team_id}`

## Usage

``` r
vtb_infobasket_team(team_id, lang = "en", tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per club. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_team")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_team(team_id = 2650))
#> ── VTB Infobasket Team from org.infobasket.su ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:56:03 UTC
#> # A tibble: 1 × 16
#>   team_id team_type team_name_ru     team_name_en    team_short_name_ru
#>     <int>     <int> <chr>            <chr>           <chr>             
#> 1    2650         1 Локомотив-Кубань Lokomotiv Kuban Локомотив-Кубань  
#> # ℹ 11 more variables: team_short_name_en <chr>, team_abc_name_ru <chr>,
#> #   team_abc_name_en <chr>, team_gender <int>, team_region <int>,
#> #   team_country <int>, team_logo <int>, team_uniform1 <int>,
#> #   team_uniform2 <int>, team_status <int>, team_record_id <int>
# }
```
