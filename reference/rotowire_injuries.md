# **RotoWire NBA Injury Report**

**Get the current NBA injury report from
[RotoWire](https://www.rotowire.com/basketball/news.php?view=injuries).**

One row per injured player with team, position, the injury, the current
designation (Out / Doubtful / Questionable / GTD / Day-To-Day) and a
link to the player's RotoWire page. The projected return date is
RotoWire subscriber-only content and is returned as `NA` for
non-subscribers.

This is the live replacement for the defunct RotoWorld injuries feed.
See also
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md)
for the Basketball-Reference injury report.

## Usage

``` r
rotowire_injuries()
```

## Value

A `hoopR_data` tibble with one row per injured player. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "rotowire_injuries")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(rotowire_injuries())
#> ── NBA injury report from rotowire.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 14:01:48 UTC
#> # A tibble: 5 × 10
#>   player_id player first_name last_name team  position injury status return_date
#>   <chr>     <chr>  <chr>      <chr>     <chr> <chr>    <chr>  <chr>  <chr>      
#> 1 5249      Preci… Precious   Achiuwa   SAC   F        Ankle  Quest… NA         
#> 2 3445      Steve… Steven     Adams     HOU   C        Calf   Out    NA         
#> 3 6291      Trey … Trey       Alexander UTA   G        Ankle  Quest… NA         
#> 4 3456      Giann… Giannis    Antetoko… MIA   F        Wrist  Proba… NA         
#> 5 7008      Tobe … Tobe       Awaka     CHI   C        Back   Out    NA         
#> # ℹ 1 more variable: url <chr>
# }
```
