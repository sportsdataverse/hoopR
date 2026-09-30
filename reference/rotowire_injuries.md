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
#> ℹ Data updated: 2026-09-30 02:25:15 UTC
#> # A tibble: 67 × 10
#>    player_id player            first_name last_name team  position injury status
#>    <chr>     <chr>             <chr>      <chr>     <chr> <chr>    <chr>  <chr> 
#>  1 5428      Santi Aldama      Santi      Aldama    DAL   F        Undis… Quest…
#>  2 6291      Trey Alexander    Trey       Alexander UTA   G        Ribs   Proba…
#>  3 3303      Bradley Beal      Bradley    Beal      LAC   G        Knee   Quest…
#>  4 6608      Nate Bittle       Nate       Bittle    TOR   C        Lower… Quest…
#>  5 6287      Adem Bona         Adem       Bona      PHI   C        Foot   Quest…
#>  6 6999      Trevon Brazile    Trevon     Brazile   DEN   F        Undis… Quest…
#>  7 6929      Mikel Brown       Mikel      Brown     BKN   G        Ankle  Quest…
#>  8 3231      Jimmy Butler      Jimmy      Butler    GSW   F        Knee   Out   
#>  9 3450      Kentavious Caldw… Kentavious Caldwell… PHI   G        Finger Proba…
#> 10 6575      Walter Clayton    Walter     Clayton   MEM   G        Knee   Quest…
#> # ℹ 57 more rows
#> # ℹ 2 more variables: return_date <chr>, url <chr>
# }
```
