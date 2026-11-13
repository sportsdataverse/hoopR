# **IBBA Teams**

**Teams of a board and season with their standings line and club profile
fields.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Teams`

## Usage

``` r
ibba_teams(season, board_id = 5)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `5`): Competition (board) id: 5 league, 10 cup, 16
  / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34
  Supercup. Default 5.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(ibba_teams(season = 2026))
#> ── IBBA teams ─────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:16:23 UTC
#> # A tibble: 14 × 26
#>    team_uid team_id season team_name_he             team_short_name_he team_name
#>       <int>   <int>  <int> <chr>                    <chr>              <chr>    
#>  1       10    1109   2026 "מכבי Rapyd תל אביב"     "מכבי ת\"א"        Maccabi …
#>  2        9    1110   2026 "הפועל IBI תל אביב"      "הפועל ת\"א"       Hapoel I…
#>  3        8    1112   2026 "הפועל מידטאון י-ם"      "הפועל י-ם"        Hapoel M…
#>  4        3    1118   2026 "בני Penlink הרצליה"     "בני הרצליה"       Bnei Pen…
#>  5        7    1113   2026 "הפועל נתנאל חולון"      "הפועל חולון"      Hapoel N…
#>  6       61    1122   2026 "הפועל גילת טלקום העמק"  "הפועל העמק"       Hapoel G…
#>  7        5    1123   2026 "מכבי תפוזינה ראשון לצי… "ראשון לציון"      Maccabi …
#>  8       60    1120   2026 "הפועל אלטשולר שחם ב\"ש… "הפועל ב\"ש"       Hapoel A…
#>  9       13    1111   2026 "מכבי קבוצת כנען רמת גן" "מכבי רמת גן"      Maccabi …
#> 10       17    1114   2026 "עירוני לאטי קריית אתא"  "קריית אתא"        Ironi La…
#> 11       58    1116   2026 "עירוני חי מוטורס נס צי… "נס ציונה"         Ironi Ha…
#> 12        1    1119   2026 "הפועל Rivulis גליל עלי… "גליל עליון"       Hapoel R…
#> 13       22    2109   2026 "אליצור נתניה"           "אליצור נתניה"     Elitzur …
#> 14       31    1124   2026 "מכבי אב־גד רעננה"       "מכבי רעננה"       Maccabi …
#> # ℹ 20 more variables: team_short_name <chr>, board_id <int>, place <int>,
#> #   games <int>, wins <int>, losses <int>, points_for <int>,
#> #   points_against <int>, table_points <int>, logo_url <chr>, photo_path <chr>,
#> #   address_he <chr>, sponsors_he <chr>, facebook_url <chr>, twitter_url <chr>,
#> #   instagram_url <chr>, youtube_url <chr>, ticket_url <chr>,
#> #   subscribe_url <chr>, coaches_he <chr>
# }
```
