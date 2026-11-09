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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
| board_title_he | character | Sponsor-branded competition name in Hebrew (the Hebrew for 'Winner League'). |
| category_he | character | Competition format in Hebrew: the Hebrew words for table, knockout or series. |

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
#> ℹ Data updated: 2026-11-09 12:05:45 UTC
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
