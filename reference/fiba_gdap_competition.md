# **FIBA GDAP: competition**

One competition (edition): season, dates, hosts, zone, category and
competition family.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getGdapCompetitionById`

## Usage

``` r
fiba_gdap_competition(comp, return_parsed = TRUE)
```

## Arguments

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| hosts | character | Host countries with their cities. Stored as a JSON string. |
| competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| competition_code | character | Competition code (WMM men's World Cup, WOLYM, BCL, ELW...). |
| season | integer | Season key, three rules: the END year for club competitions (BCL 2024-25 = 2025) and the event year for national-team events (World Cup 2023 = 2023), both equal to the package season key; qualifiers carry the TARGET tournament year, not the year played (World Cup 2027 qualifiers played in 2025 = 2027, EuroBasket 2029 pre-qualifiers = 2029). |
| official_name | character | Edition title (FIBA Basketball World Cup; Paris 2024 Men's Olympic Basketball Tournament). |
| start | character | First day, YYYY-MM-DD. |
| end | character | Last day, YYYY-MM-DD. |
| status | character | Competition status: In Progress, Completed, Closed. |
| age_category | character | Age category (Senior, Under 16...). |
| gender | character | Men or Women: the gender of the competition. |
| fiba_zone | character | FIBA zone the competition belongs to (World, Europe, Americas...). |
| zone_information_zone_id | integer | FIBA zone id (1 = World, 23 = Europe; zone table key space). |
| zone_information_zone_official_name | character | Official name of the competition's FIBA zone (FIBA Europe, FIBA Americas, World). |
| zone_information_zone_code | character | Zone code (W, E, AF, AM, AS, OC). |
| zone_information_top_zone_id | integer | Parent zone id; null for top zones. |
| zone_information_top_zone_official_name | character | Parent zone name; always null in the samples, values unverified. |
| zone_information_top_zone_code | character | Parent zone code; always null in the samples, values unverified. |
| competition_type | character | National Teams or Clubs. |
| competition_category_is_league | logical | True for league-format club competitions. |
| competition_category_age_type | character | Age type code: S senior, U16. |
| competition_category_code | character | Category code (WC World Cup, OLY Olympic Tournament, CCC-1 continental club tier 1). |
| competition_category_name | character | Name of the competition's category (FIBA Basketball World Cup, Olympic Basketball Tournament...). |
| official_flag_item_code | character | Official-status code: O = official. |
| official_flag_item_name | character | Official-status label. |
| official | character | Official-status label. |
| discipline | character | Discipline (Basketball; 3x3 is a separate platform). |
| competition_marketing_name_competition_marketing_name_id | integer | Competition family id (201 = World Cup, 112 = BCL tier 1, 211 = EuroLeague Women); the `<histId>` of /en/history/ pages. |
| competition_marketing_name_marketing_name | character | Competition family name; slugified it is the `<histSlug>` of /en/history/ pages. |
| competition_marketing_name_code | character | Family code; null in every sample. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gdap_competition(comp = 208182))
#> ── FIBA gdap_competition from fiba.basketball ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:05:34 UTC
#> # A tibble: 1 × 29
#>   hosts  competition_id competition_code season official_name start end   status
#>   <chr>           <int> <chr>             <int> <chr>         <chr> <chr> <chr> 
#> 1 "[{\"…         208182 WMM                2023 FIBA Basketb… 2023… 2023… Compl…
#> # ℹ 21 more variables: age_category <chr>, gender <chr>, fiba_zone <chr>,
#> #   zone_information_zone_id <int>, zone_information_zone_official_name <chr>,
#> #   zone_information_zone_code <chr>, zone_information_top_zone_id <int>,
#> #   zone_information_top_zone_official_name <chr>,
#> #   zone_information_top_zone_code <chr>, competition_type <chr>,
#> #   competition_category_is_league <lgl>, competition_category_age_type <chr>,
#> #   competition_category_code <chr>, competition_category_name <chr>, …
# }
```
