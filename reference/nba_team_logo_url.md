# **NBA Team Logo URL**

Build the official NBA CDN logo URL(s) for one or more team ids.
Vectorized.

## Usage

``` r
nba_team_logo_url(team_id, variant = "primary")
```

## Arguments

- team_id:

  Team id(s) (`TEAM_ID`, the 10-digit form e.g. `1610612744`).

- variant:

  Logo variant: `"primary"` (default), `"secondary"` or `"global"`.

## Value

A character vector of SVG logo URLs.

## See also

Other NBA Dictionary Functions:
[`nba_player_dict()`](https://hoopR.sportsdataverse.org/reference/nba_player_dict.md),
[`nba_player_headshot_url()`](https://hoopR.sportsdataverse.org/reference/nba_player_headshot_url.md),
[`nba_team_dict()`](https://hoopR.sportsdataverse.org/reference/nba_team_dict.md)

## Examples

``` r
nba_team_logo_url(team_id = 1610612744)                # Golden State Warriors
#> [1] "https://cdn.nba.com/logos/nba/1610612744/primary/L/logo.svg"
```
