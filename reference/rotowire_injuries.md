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
#> ── NBA injury report from rotowire.com ────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-06 04:19:29 UTC
#> # A tibble: 117 × 10
#>    player_id player            first_name last_name team  position injury status
#>    <chr>     <chr>             <chr>      <chr>     <chr> <chr>    <chr>  <chr> 
#>  1 6931      Darius Acuff      Darius     Acuff     SAC   G        Rest   Proba…
#>  2 3445      Steven Adams      Steven     Adams     HOU   C        Ankle  Quest…
#>  3 4153      Bam Adebayo       Bam        Adebayo   MIA   C        Back   Proba…
#>  4 5428      Santi Aldama      Santi      Aldama    DAL   F        Knee   Quest…
#>  5 6291      Trey Alexander    Trey       Alexander UTA   G        Ribs   Proba…
#>  6 3456      Giannis Antetoko… Giannis    Antetoko… MIA   F        Knee   Proba…
#>  7 6551      Ace Bailey        Ace        Bailey    UTA   F        Back   Proba…
#>  8 6576      Joan Beringer     Joan       Beringer  MIN   C        Back   Quest…
#>  9 6608      Nate Bittle       Nate       Bittle    TOR   C        Knee   Quest…
#> 10 6999      Trevon Brazile    Trevon     Brazile   DEN   F        Undis… Quest…
#> # ℹ 107 more rows
#> # ℹ 2 more variables: return_date <chr>, url <chr>
# }
```
