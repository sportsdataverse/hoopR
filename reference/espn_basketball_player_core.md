# **Project an ESPN core-v2 athlete record into a `player_core` row**

Turns one ESPN core-v2 `/athletes/{id}` payload into the single tidy row
released as the `player_core` dataset.

This is a **pure projection**: it takes an already-fetched payload and
never performs I/O. That is deliberate - the compile stages in
`hoopR-nba-data` / `hoopR-mbb-data` read the payload from the sibling
`-raw` tree, and re-fetching here would both break the one-way raw -\>
data boundary and mean the R and Python pipelines read different bytes,
so a value divergence could not be attributed to method.

Ids for college and current team are parsed out of the payload's `$ref`
URLs (`/colleges/{id}`, `/teams/{id}`). The `$ref` is **never**
followed.

## Usage

``` r
espn_basketball_player_core(payload, athlete_id)
```

## Arguments

- payload:

  list. One athlete's core-v2 `/athletes/{athlete_id}` payload, as
  returned by `jsonlite::fromJSON(..., simplifyVector = FALSE)`. An
  empty or non-list value yields a zero-row tibble rather than an error.

- athlete_id:

  numeric or character. The ESPN athlete id. **Required and never
  inferred from the payload** - callers pass the id from the file path,
  so a payload missing its own `id` still produces a joinable row.

## Value

A `hoopR_data` tibble with one row per athlete. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "espn_basketball_player_core")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

**What the row means.** `current_team_id` is the athlete's team *today*,
not their team in any past season - the season a released row is filed
under is *participation* (who appeared that year, taken from
`player_box`), not the vintage of the bio. Height, weight and jersey are
likewise a current snapshot: ESPN overwrites them in place, so
era-correct bio is not obtainable from this endpoint.

**Parity.** This is a port of
`sportsdataverse.nba.helper_nba_player_core` (sportsdataverse-py
0.0.75), which produces the released dataset today. The two are held to
byte-parity by `tests/testthat/test-espn_basketball_player_core.R`
against a golden fixture captured from that function; see
`tests/testthat/fixtures/player_core/README.md` for provenance. Neither
implementation is authoritative - a divergence is a review item.

## Twin

[`wehoop::espn_basketball_player_core()`](https://wehoop.sportsdataverse.org/reference/espn_basketball_player_core.html)
is the identical function for the women's leagues. The core-v2 athlete
resource is the same payload shape for nba/wnba/mbb/wbb, so the
projection is league-agnostic – sportsdataverse-py implements it once
and re-exports it per league. hoopR and wehoop are independently
published and neither depends on the other, so here it is duplicated:
**a change to one must land in the other in the same session,
verified.**

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  # Split across lines to keep the Rd under the line-width limit; the
  # core-v2 $ref URLs are long enough to be truncated in the PDF manual.
  team_ref <- paste0(
    "http://sports.core.api.espn.com/v2/sports/basketball/",
    "leagues/nba/seasons/2025/teams/22"
  )
  payload <- list(
    guid = "abc", fullName = "Jane Doe", jersey = "23",
    position = list(id = "5", abbreviation = "G"),
    team = list(`$ref` = team_ref)
  )
  espn_basketball_player_core(payload, athlete_id = 1966)
#> ── ESPN Basketball Player Core from ESPN.com ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:20 UTC
#> # A tibble: 1 × 35
#>   athlete_id guid  uid   slug  type  first_name last_name full_name display_name
#>        <int> <chr> <chr> <chr> <chr> <chr>      <chr>     <chr>     <chr>       
#> 1       1966 abc   NA    NA    NA    NA         NA        Jane Doe  Jane Doe    
#> # ℹ 26 more variables: short_name <chr>, height <dbl>, display_height <chr>,
#> #   weight <dbl>, display_weight <chr>, age <int>, date_of_birth <chr>,
#> #   birth_city <chr>, birth_state <chr>, birth_country <chr>, jersey <chr>,
#> #   position_id <int>, position_name <chr>, position_abbreviation <chr>,
#> #   position_display_name <chr>, college_id <int>, current_team_id <int>,
#> #   headshot_href <chr>, experience_years <int>, status_id <int>,
#> #   status_name <chr>, status_type <chr>, draft_year <int>, …
# }
```
