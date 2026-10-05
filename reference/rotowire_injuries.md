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
#> ℹ Data updated: 2026-10-05 18:58:03 UTC
#> # A tibble: 83 × 10
#>    player_id player          first_name last_name team  position injury   status
#>    <chr>     <chr>           <chr>      <chr>     <chr> <chr>    <chr>    <chr> 
#>  1 5428      Santi Aldama    Santi      Aldama    DAL   F        Undiscl… Quest…
#>  2 3586      Kyle Anderson   Kyle       Anderson  TOR   F        Knee     Quest…
#>  3 5670      Dominick Barlow Dominick   Barlow    PHI   C        Rest     Quest…
#>  4 5390      Scottie Barnes  Scottie    Barnes    TOR   F        Knee     Quest…
#>  5 6323      Jamison Battle  Jamison    Battle    TOR   F        Back     Quest…
#>  6 3303      Bradley Beal    Bradley    Beal      LAC   G        Knee     Quest…
#>  7 6608      Nate Bittle     Nate       Bittle    TOR   C        Foot     Quest…
#>  8 5910      Anthony Black   Anthony    Black     ORL   G        Ankle    Quest…
#>  9 6287      Adem Bona       Adem       Bona      PHI   C        Foot     Quest…
#> 10 6929      Mikel Brown     Mikel      Brown     BKN   G        Ankle    Quest…
#> # ℹ 73 more rows
#> # ℹ 2 more variables: return_date <chr>, url <chr>
# }
```
