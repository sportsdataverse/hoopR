# **Get ACB Season Leaders**

Each team's season leaders before a game, by category.

One row per team, metric and rank, like `acb_match_leaders` but over the
season so far; `value` is a total or an average depending on the metric.

Endpoint:
`GET https://api2.acb.com/api/matchdata/Preview/season-leaders`

## Usage

``` r
acb_season_leaders(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_season_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
| team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| metric | character | Leader category in snake_case (the API's key, e.g. rating, points, rebounds, assists). |
| rank | integer | Place in the category list, 1 = the leader, in the order the feed lists them. |
| value | double | The player's season value in the category before this game (a total or an average depending on the category). |
| player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_season_leaders(match_id = 105401))
#> ── ACB Season Leaders from api2.acb.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:02:05 UTC
#> # A tibble: 40 × 17
#>    match_id edition_id season team_side team_id club_id team  team_abbr metric
#>       <int>      <int>  <int> <chr>       <int>   <int> <chr> <chr>     <chr> 
#>  1   105401         91   2027 home         4467       2 Barça BAR       rating
#>  2   105401         91   2027 home         4467       2 Barça BAR       rating
#>  3   105401         91   2027 home         4467       2 Barça BAR       rating
#>  4   105401         91   2027 home         4467       2 Barça BAR       rating
#>  5   105401         91   2027 home         4467       2 Barça BAR       rating
#>  6   105401         91   2027 home         4467       2 Barça BAR       points
#>  7   105401         91   2027 home         4467       2 Barça BAR       points
#>  8   105401         91   2027 home         4467       2 Barça BAR       points
#>  9   105401         91   2027 home         4467       2 Barça BAR       points
#> 10   105401         91   2027 home         4467       2 Barça BAR       points
#> # ℹ 30 more rows
#> # ℹ 8 more variables: rank <int>, value <dbl>, player_id <int>,
#> #   player_name <chr>, first_name <chr>, last_name <chr>, shirt_number <chr>,
#> #   game_role <chr>
# }
```
