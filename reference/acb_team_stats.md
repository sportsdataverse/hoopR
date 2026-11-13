# **Get ACB Team Stats**

A club's player season statistics for an edition: totals, averages and
per-40 side by side.

One row per player. `total_*` are season counts (`Int64`;
`total_time_played` is seconds, `*_percentage` are Float64), `avg_*`
per-game averages and `per40_*` per-40-minute rates (Float64).
`num_games` is games played and `starter` games started.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-stats`

## Usage

``` r
acb_team_stats(club_id, competition_id = NULL, season = NULL)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble with one row per player of the club. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_team_stats")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
  try(acb_team_stats(club_id = 2, season = 2027))
#> ── ACB Team Stats from api2.acb.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:48:19 UTC
#> # A tibble: 15 × 97
#>    club_id team_id edition_id season player_id player_name  first_name last_name
#>      <int>   <int>      <int>  <int>     <int> <chr>        <chr>      <chr>    
#>  1       2    4467         91   2027  30005357 Olivier Nka… Olivier    Nkamhoua 
#>  2       2    4467         91   2027  30003361 Kevin Punter Kevin      Punter   
#>  3       2    4467         91   2027  30005377 Tosan Evbuo… Torisesan  Evbuomwan
#>  4       2    4467         91   2027  30005356 Josh Nebo    Joshua     Nebo     
#>  5       2    4467         91   2027  30004602 Abdu Kone    Abdrahama… Kone     
#>  6       2    4467         91   2027  20212243 Olek Balcer… Aleksander Balcerow…
#>  7       2    4467         91   2027  30005378 Tyrese Mart… Tyrese     Martin   
#>  8       2    4467         91   2027  30001332 Agustín Ubal Agustín    Ubal     
#>  9       2    4467         91   2027  20212265 Joel Parra   Joel       Parra    
#> 10       2    4467         91   2027  30003340 Justin Robi… Justin     Robinson 
#> 11       2    4467         91   2027  30005355 Umoja Gibson Umoja      Gibson   
#> 12       2    4467         91   2027  30000093 Juan Núñez   Juan       Núñez    
#> 13       2    4467         91   2027  30005361 Stanley Umu… Stanley    Umude    
#> 14       2    4467         91   2027  20209919 Darío Brizu… Darío      Brizuela 
#> 15       2    4467         91   2027  30005476 Justin Mina… Justin     Minaya   
#> # ℹ 89 more variables: shirt_number <chr>, game_role <chr>,
#> #   total_num_games <int>, total_time_played <int>, total_starter <int>,
#> #   total_points <int>, total_max_points <int>,
#> #   total_three_pointers_made <int>, total_three_pointers_attempted <int>,
#> #   total_three_pointers_percentage <dbl>, total_two_pointers_made <int>,
#> #   total_two_pointers_attempted <int>, total_two_pointers_percentage <dbl>,
#> #   total_free_throws_made <int>, total_free_throws_attempted <int>, …
# }
```
