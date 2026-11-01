# **B.LEAGUE Standings**

**Standings of one B.LEAGUE season and division, one row per club per
table (conference, division or wild card).**

Endpoint: `GET https://www.bleague.jp/standings/`

One row per club per table. `section` is the table heading in Japanese
(East, Central and West divisions, wild card; B2 and B3 may have one
table with a different heading) and `section_en` its English name for
those four. A club can appear in a division table and in the wild-card
table. `win_pct` is a 0-1 fraction. The page shows the standings as of
the request, not a season end.

## Usage

``` r
bleague_standings(season, tab)
```

## Arguments

- season:

  (*integer* required): season END year (`2026` = 2025-26); the site's
  own year is the START year, so the request sends `season - 1`.

- tab:

  (*integer* required): division tab: 1 = B1, 2 = B2, 3 = B3.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
| season_label | character | Season label of the selected option (2025-26). |
| section | character | Table heading in Japanese (East, Central and West divisions, wild card); section_en is its English name. |
| section_en | character | English name of section for the four known headings; null for any other heading. |
| rank | integer | Rank in that table; a club in a division table also appears in the wild-card table. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| team | character | Club name in Japanese as the standings page prints it (e.g. Chiba Jets). |
| team_short | character | Club short name in Japanese (e.g. Chiba J). |
| wins | integer | Games won so far this season in the table. |
| losses | integer | Games lost so far this season in the table. |
| win_pct | double | Win percentage as a 0-1 fraction. |
| games_behind | double | Games behind the table leader. |
| points_for | integer | Points scored over the season to date. |
| points_against | integer | Points allowed over the season to date. |
| point_diff | integer | Point differential. |
| home_record | character | Home record W-L. |
| away_record | character | Away record W-L. |
| last_n | integer | Length of the recent-form window the page shows: 5 or 10 games. |
| last_n_record | character | Record W-L over the last_n games. |
| streak | character | Current streak as printed: W5 = five straight wins, L1 = one loss. |
| division_title | character | Division-title mark as printed; null when none ('–'). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md).

## See also

Other B.LEAGUE Functions:
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md),
[`bleague_leaders()`](https://hoopR.sportsdataverse.org/reference/bleague_leaders.md),
[`bleague_pbp()`](https://hoopR.sportsdataverse.org/reference/bleague_pbp.md),
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md),
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md),
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md),
[`bleague_schedule_clubs()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_clubs.md),
[`bleague_schedule_days()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_days.md),
[`bleague_schedule_events()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_events.md),
[`bleague_score_track()`](https://hoopR.sportsdataverse.org/reference/bleague_score_track.md),
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md),
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)

## Examples

``` r
# \donttest{
  try(bleague_standings(season = 2026, tab = 1))
#> ── B.LEAGUE standings from www.bleague.jp ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:45:19 UTC
#> # A tibble: 48 × 22
#>    season   tab season_label section section_en  rank team_id team    team_short
#>     <int> <int> <chr>        <chr>   <chr>      <int> <chr>   <chr>   <chr>     
#>  1   2026     1 2025-26      東地区  East           1 703     宇都宮ブレッ… 宇都宮    
#>  2   2026     1 2025-26      東地区  East           2 704     千葉ジェッツ… 千葉J     
#>  3   2026     1 2025-26      東地区  East           3 713     群馬クレイン… 群馬      
#>  4   2026     1 2025-26      東地区  East           4 706     アルバルク東… A東京     
#>  5   2026     1 2025-26      東地区  East           5 702     レバンガ北海… 北海道    
#>  6   2026     1 2025-26      東地区  East           6 692     仙台89ER… 仙台      
#>  7   2026     1 2025-26      東地区  East           7 694     横浜ビー・コ… 横浜BC    
#>  8   2026     1 2025-26      東地区  East           8 726     サンロッカー… SR渋谷    
#>  9   2026     1 2025-26      東地区  East           9 745     越谷アルファ… 越谷      
#> 10   2026     1 2025-26      東地区  East          10 712     茨城ロボッツ… 茨城      
#> # ℹ 38 more rows
#> # ℹ 13 more variables: wins <int>, losses <int>, win_pct <dbl>,
#> #   games_behind <dbl>, points_for <int>, points_against <int>,
#> #   point_diff <int>, home_record <chr>, away_record <chr>, last_n <int>,
#> #   last_n_record <chr>, streak <chr>, division_title <chr>
# }
```
