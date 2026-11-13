# **Get ESPN NBA Athlete Contracts Index**

Returns the index of contract seasons recorded for an NBA athlete from
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/athletes/{athlete_id}/contracts`.
Each row is one contract year - pass the season to
`espn_nba_player_contract()` for the full contract record.

Returns the full contract record for one NBA athlete in one season,
including salary, cap-rule flags, option type, Bird status, and trade
protections. Backed by
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/athletes/{athlete_id}/contracts/{season}`.

## Usage

``` r
espn_nba_player_contracts(athlete_id, ...)

espn_nba_player_contract(athlete_id, season = most_recent_nba_season(), ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

- season:

  Season year (numeric). Defaults to the most recent NBA season.

## Value

A `hoopR_data` tibble with one row per contract year.

|            |           |                                          |
|------------|-----------|------------------------------------------|
| col_name   | types     | description                              |
| athlete_id | character | ESPN athlete identifier.                 |
| season     | integer   | Contract season year.                    |
| ref        | character | Full `$ref` URL for the contract detail. |
| league     | character | League slug (`"nba"`).                   |

A `hoopR_data` tibble with one row per contract.

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | character | ESPN athlete identifier. |
| season | integer | Contract season year. |
| bird_status | integer | Bird-rights tier (0 = Non, 1 = Early, 2 = Full). |
| salary | numeric | Total cap-counting salary for the season (\$). |
| salary_remaining | numeric | Remaining salary owed. |
| years_remaining | integer | Years left on the contract. |
| incoming_trade_value | numeric | Trade value if receiving this contract (\$). |
| outgoing_trade_value | numeric | Trade value if sending out this contract (\$). |
| option_type | integer | Option type code (e.g. team / player option). |
| minimum_salary_exception | logical | Signed under the minimum-salary exception. |
| trade_restriction | logical | Whether a trade restriction is active. |
| unsigned_foreign_pick | logical | Unsigned-foreign-pick flag. |
| active | logical | Whether the contract is currently active. |
| base_year_compensation_active | logical | Base-year-compensation rule active. |
| poison_pill_provision_active | logical | Poison-pill provision active. |
| trade_kicker_active | logical | Trade kicker active. |
| trade_kicker_percentage | numeric | Trade kicker percentage of salary. |
| trade_kicker_value | numeric | Trade kicker dollar value. |
| trade_kicker_trade_value | numeric | Trade kicker post-trade dollar value. |
| season_ref | character | `$ref` to the season resource. |
| team_ref | character | `$ref` to the team-in-season resource. |
| team_id | character | ESPN team id parsed from `team_ref`. |
| league | character | League slug (`"nba"`). |

## See also

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  # LeBron James - athlete id 1966
  espn_nba_player_contracts(athlete_id = 1966)
#> ── ESPN NBA Athlete Contracts Index ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:45 UTC
#> # A tibble: 20 × 4
#>    athlete_id season ref                                                  league
#>    <chr>       <int> <chr>                                                <chr> 
#>  1 1966         2026 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  2 1966         2025 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  3 1966         2024 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  4 1966         2023 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  5 1966         2022 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  6 1966         2021 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  7 1966         2020 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  8 1966         2019 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#>  9 1966         2017 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 10 1966         2016 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 11 1966         2015 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 12 1966         2014 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 13 1966         2013 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 14 1966         2012 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 15 1966         2011 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 16 1966         2010 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 17 1966         2009 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 18 1966         2008 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 19 1966         2007 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
#> 20 1966         2006 http://sports.core.api.espn.com/v2/sports/basketbal… nba   
# }
# \donttest{
  # LeBron James 2025 contract
  espn_nba_player_contract(athlete_id = 1966, season = 2025)
#> ── ESPN NBA Athlete Contract from ESPN.com ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:45 UTC
#> # A tibble: 1 × 23
#>   athlete_id season bird_status   salary salary_remaining years_remaining
#>   <chr>       <int>       <int>    <int>            <int>           <int>
#> 1 1966         2025           0 48728845                0               2
#> # ℹ 17 more variables: incoming_trade_value <int>, outgoing_trade_value <int>,
#> #   option_type <int>, minimum_salary_exception <lgl>, trade_restriction <lgl>,
#> #   unsigned_foreign_pick <lgl>, active <lgl>,
#> #   base_year_compensation_active <lgl>, poison_pill_provision_active <lgl>,
#> #   trade_kicker_active <lgl>, trade_kicker_percentage <dbl>,
#> #   trade_kicker_value <int>, trade_kicker_trade_value <int>, season_ref <chr>,
#> #   team_ref <chr>, team_id <chr>, league <chr>
# }
```
