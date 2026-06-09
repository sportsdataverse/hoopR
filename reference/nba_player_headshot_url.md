# **NBA Player Headshot URL**

Build the official NBA CDN headshot URL(s) for one or more player ids.
Vectorized – pass a vector of ids to get a vector of URLs.

## Usage

``` r
nba_player_headshot_url(player_id, size = "1040x760")
```

## Arguments

- player_id:

  Player id(s) (`PERSON_ID`), numeric or character.

- size:

  Image size: `"1040x760"` (default, large) or `"260x190"` (small).

## Value

A character vector of headshot URLs.

## See also

Other NBA Dictionary Functions:
[`nba_player_dict()`](https://hoopR.sportsdataverse.org/reference/nba_player_dict.md),
[`nba_team_dict()`](https://hoopR.sportsdataverse.org/reference/nba_team_dict.md),
[`nba_team_logo_url()`](https://hoopR.sportsdataverse.org/reference/nba_team_logo_url.md)

## Examples

``` r
nba_player_headshot_url(player_id = 201939)            # Stephen Curry
#> [1] "https://cdn.nba.com/headshots/nba/latest/1040x760/201939.png"
nba_player_headshot_url(c(2544, 201939), size = "260x190")
#> [1] "https://cdn.nba.com/headshots/nba/latest/260x190/2544.png"  
#> [2] "https://cdn.nba.com/headshots/nba/latest/260x190/201939.png"
```
