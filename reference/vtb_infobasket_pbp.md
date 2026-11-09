# **Get VTB Infobasket Play-by-Play**

Play-by-play of a finished game with shot x/y (2022-23 onwards; earlier
games have no plays).

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_pbp(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble: Play-by-play of a finished game with shot x/y
(2022-23 onwards; earlier games have no plays). The columns are always
these, in this order (sportsdataverse-py `vtb_infobasket_pbp`); an empty
valid answer raises `hoopR_no_data`, a valid body with no rows for this
frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Infobasket GameID of the game (the v2 matches' match_id); global across seasons. |
| play_id | integer | Play id within the game (the row-0 header play included); parent_play_id points at another play_id. |
| parent_play_id | integer | play_id of the parent play (a made shot's children: shot type, assist, possession change). |
| play_type_id | integer | Play type code (see play_type; the full table is in vtb-returns.md). |
| play_type | character | English label of play_type_id from the site widget's table (null for a code the table lacks). |
| play_period | integer | Period: 1-4 quarters, 5+ overtimes. |
| play_second | integer | Time ELAPSED in the period, in tenths of a second (6000 = 600 s = end of a 10-minute quarter). Game clock = period length - PlaySecond/10. |
| play_sort_order | integer | Order among plays sharing the same play_second. |
| play_flag | integer | Play flag; 0 in every sample (meaning unverified). |
| start_id | integer | Line-up slot id within this game's line-up (0 = the placeholder row); not a person id. |
| team_number | integer | Side (1 or 2) of the line-up slot the play belongs to; null for a play with no player. |
| team_id | integer | Infobasket TeamID of the team the play belongs to; null for a play with no player. |
| person_id | integer | Infobasket PersonID of the player of the line-up slot; null for a play with no player. |
| play_zone | integer | Court zone code of a shot: 1-3 count as paint in the site's widget, 3-pointers sit in zones 7-12; the full map is unverified. |
| play_x | integer | Shot x in decimetres across the court, -75..75, origin at the basket centre (orientation from the renderer, unverified). |
| play_y | integer | Shot y in decimetres from the basket toward midcourt (about -16 baseline, 124 midcourt). |
| video_from | integer | Video clip start, Unix epoch seconds; 0 when none. |
| video_to | integer | Video clip end, Unix epoch seconds; 0 when none. |

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
  try(vtb_infobasket_pbp(game_id = 921391))
#> ── VTB Infobasket Play-by-Play from org.infobasket.su ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:09:56 UTC
#> # A tibble: 1,152 × 18
#>    game_id play_id parent_play_id play_type_id play_type play_period play_second
#>      <int>   <int>          <int>        <int> <chr>           <int>       <int>
#>  1  921391       0             NA            0 -                   4        6000
#>  2  921391       1             NA           60 Warmup              1           0
#>  3  921391       2             NA           59 (none)              1           0
#>  4  921391       3             NA           21 Start               1           0
#>  5  921391       4              3            8 In                  1           0
#>  6  921391       5              3            8 In                  1           0
#>  7  921391       6              3            8 In                  1           0
#>  8  921391       7              3            8 In                  1           0
#>  9  921391       8              3            8 In                  1           0
#> 10  921391       9              3            8 In                  1           0
#> # ℹ 1,142 more rows
#> # ℹ 11 more variables: play_sort_order <int>, play_flag <int>, start_id <int>,
#> #   team_number <int>, team_id <int>, person_id <int>, play_zone <int>,
#> #   play_x <int>, play_y <int>, video_from <int>, video_to <int>
# }
```
