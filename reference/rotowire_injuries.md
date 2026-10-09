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

A `hoopR_data` tibble with one row per injured player:

|             |           |                                                   |
|-------------|-----------|---------------------------------------------------|
| col_name    | types     | description                                       |
| player_id   | character | RotoWire player id.                               |
| player      | character | Player name.                                      |
| first_name  | character | First name.                                       |
| last_name   | character | Last name.                                        |
| team        | character | Team abbreviation.                                |
| position    | character | Position.                                         |
| injury      | character | Injury (body part / description).                 |
| status      | character | Injury designation (Out, GTD, Questionable, ...). |
| return_date | character | Projected return (`NA` unless a subscriber).      |
| url         | character | RotoWire player page URL.                         |

## Examples

``` r
# \donttest{
  try(rotowire_injuries())
#> ── NBA injury report from rotowire.com ───────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 04:48:48 UTC
#> # A tibble: 5 × 10
#>   player_id player first_name last_name team  position injury status return_date
#>   <chr>     <chr>  <chr>      <chr>     <chr> <chr>    <chr>  <chr>  <chr>      
#> 1 5683      Ochai… Ochai      Agbaji    NYK   F        Coach… Proba… NA         
#> 2 5428      Santi… Santi      Aldama    DAL   F        Undis… Quest… NA         
#> 3 6965      Nate … Nate       Ament     MIL   F        Ankle  Quest… NA         
#> 4 6978      Chris… Christian  Anderson  CHA   G        Ankle  Quest… NA         
#> 5 5670      Domin… Dominick   Barlow    PHI   C        Back   Quest… NA         
#> # ℹ 1 more variable: url <chr>
# }
```
