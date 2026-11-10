# **IBBA Boards**

**Competitions (boards) of a season: league, cup, playoff rounds,
play-in, Supercup.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Boards`

## Usage

``` r
ibba_boards(season)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with one row per board. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_boards")`) and in the searchable
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
  try(ibba_boards(season = 2026))
#> ── IBBA boards ────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:02:08 UTC
#> # A tibble: 7 × 5
#>   board_id season board_name_he        board_title_he                category_he
#>      <int>  <int> <chr>                <chr>                         <chr>      
#> 1        5   2026 ליגת העל             ליגת Winner סל                טבלה       
#> 2       10   2026 גביע הליגה           גביע ווינר סל                 נוק אאוט   
#> 3       16   2026 ליגת העל - רבע גמר   ליגת Winner סל - רבע הגמר     סדרה       
#> 4       17   2026 ליגת העל - סדרת הגמר ליגת Winner סל - סדרת הגמר    סדרה       
#> 5       26   2026 ליגת העל - חצי גמר   ליגת Winner סל - סדרת חצי גמר סדרה       
#> 6       33   2026 פליי-אין             פליי-אין                      נוק אאוט   
#> 7       34   2026 סופרקאפ              סופרקאפ הסופר החברתי          נוק אאוט   
# }
```
