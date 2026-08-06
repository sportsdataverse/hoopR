# **Project an ESPN core-v2 athlete record into a `player_core` row**

Turns one ESPN core-v2 `/athletes/{id}` payload into the single tidy row
released as the `player_core` dataset.

This is a **pure projection**: it takes an already-fetched payload and
never performs I/O. That is deliberate — the compile stages in
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
  inferred from the payload** — callers pass the id from the file path,
  so a payload missing its own `id` still produces a joinable row.

## Value

A one-row tibble carrying the full 35-column set (absent fields are
`NA`), so callers see a stable schema regardless of payload
completeness:

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| athlete_id            | integer   |
| guid                  | character |
| uid                   | character |
| slug                  | character |
| type                  | character |
| first_name            | character |
| last_name             | character |
| full_name             | character |
| display_name          | character |
| short_name            | character |
| height                | numeric   |
| display_height        | character |
| weight                | numeric   |
| display_weight        | character |
| age                   | integer   |
| date_of_birth         | character |
| birth_city            | character |
| birth_state           | character |
| birth_country         | character |
| jersey                | character |
| position_id           | integer   |
| position_name         | character |
| position_abbreviation | character |
| position_display_name | character |
| college_id            | integer   |
| current_team_id       | integer   |
| headshot_href         | character |
| experience_years      | integer   |
| status_id             | integer   |
| status_name           | character |
| status_type           | character |
| draft_year            | integer   |
| draft_round           | integer   |
| draft_selection       | integer   |
| active                | logical   |

## Details

**What the row means.** `current_team_id` is the athlete's team *today*,
not their team in any past season — the season a released row is filed
under is *participation* (who appeared that year, taken from
`player_box`), not the vintage of the bio. Height, weight and jersey are
likewise a current snapshot: ESPN overwrites them in place, so
era-correct bio is not obtainable from this endpoint.

**Parity.** This is a port of
`sportsdataverse.nba.helper_nba_player_core` (sdv-py 0.0.75), which
produces the released dataset today. The two are held to byte-parity by
`tests/testthat/test-espn_basketball_player_core.R` against a golden
fixture captured from that function; see
`tests/testthat/fixtures/player_core/README.md` for provenance. Neither
implementation is authoritative — a divergence is a review item.

## Twin

`wehoop::espn_basketball_player_core()` is the identical function for
the women's leagues. The core-v2 athlete resource is the same payload
shape for nba/wnba/mbb/wbb, so the projection is league-agnostic –
sdv-py implements it once and re-exports it per league. hoopR and wehoop
are independently published and neither depends on the other, so here it
is duplicated: **a change to one must land in the other in the same
session, verified.**

## See also

Other Basketball Analytics Utilities:
[`nba_add_advanced_metrics()`](https://hoopR.sportsdataverse.org/reference/nba_add_advanced_metrics.md),
[`nba_assist_pct()`](https://hoopR.sportsdataverse.org/reference/nba_assist_pct.md),
[`nba_assist_to_turnover()`](https://hoopR.sportsdataverse.org/reference/nba_assist_to_turnover.md),
[`nba_defensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_defensive_rating.md),
[`nba_effective_fg_pct()`](https://hoopR.sportsdataverse.org/reference/nba_effective_fg_pct.md),
[`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md),
[`nba_ft_rate()`](https://hoopR.sportsdataverse.org/reference/nba_ft_rate.md),
[`nba_game_score()`](https://hoopR.sportsdataverse.org/reference/nba_game_score.md),
[`nba_net_rating()`](https://hoopR.sportsdataverse.org/reference/nba_net_rating.md),
[`nba_offensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_offensive_rating.md),
[`nba_oreb_pct()`](https://hoopR.sportsdataverse.org/reference/nba_oreb_pct.md),
[`nba_pace()`](https://hoopR.sportsdataverse.org/reference/nba_pace.md),
[`nba_per_minutes()`](https://hoopR.sportsdataverse.org/reference/nba_per_minutes.md),
[`nba_per_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_per_possessions.md),
[`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
[`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
[`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
[`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md)

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
#> ── ESPN Basketball Player Core from ESPN.com ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-06 03:58:59 UTC
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
