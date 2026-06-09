# **RotoWire NBA Injury Report**

**Get the current NBA injury report from
[RotoWire](https://www.rotowire.com/basketball/news.php?view=injuries).**

One row per injured player with team, position, the injury, the current
designation (Out / Doubtful / Questionable / GTD / Day-To-Day) and a
link to the player's RotoWire page. The projected return date is
RotoWire subscriber-only content and is returned as `NA` for
non-subscribers.

This is the live replacement for the defunct RotoWorld injuries feed
that the classic `nbastatR::nba_injuries()` used. See also
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
#> ── NBA injury report from rotowire.com ────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:08:54 UTC
#> # A tibble: 126 × 10
#>    player_id player            first_name last_name team  position injury status
#>    <chr>     <chr>             <chr>      <chr>     <chr> <chr>    <chr>  <chr> 
#>  1 3445      Steven Adams      Steven     Adams     HOU   C        Ankle  Out   
#>  2 4153      Bam Adebayo       Bam        Adebayo   MIA   C        Back   Out   
#>  3 5428      Santi Aldama      Santi      Aldama    MEM   F        Knee   Out   
#>  4 3456      Giannis Antetoko… Giannis    Antetoko… MIL   F        Knee   Out   
#>  5 4397      Marvin Bagley     Marvin     Bagley    DAL   C        Shoul… Out   
#>  6 6782      Adama Bal         Adama      Bal       MEM   G        Ankle  Out   
#>  7 3303      Bradley Beal      Bradley    Beal      LAC   G        Hip    Out   
#>  8 3231      Jimmy Butler      Jimmy      Butler    GSW   F        Knee   Out   
#>  9 5938      Matas Buzelis     Matas      Buzelis   CHI   F        Ankle  Out   
#> 10 3450      Kentavious Caldw… Kentavious Caldwell… MEM   G        Finger Out   
#> # ℹ 116 more rows
#> # ℹ 2 more variables: return_date <chr>, url <chr>
# }
```
