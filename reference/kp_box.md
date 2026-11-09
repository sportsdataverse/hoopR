# **Get KenPom Game Box Score**

**Get KenPom Game Box Score**

**Get KenPom Win Probability**

## Usage

``` r
kp_box(game_id, year)

kp_winprob(game_id, year)
```

## Arguments

- game_id:

  Game id of game to pull

- year:

  Year of game to pull

## Value

A named list of tibbles: `away_team`, `home_team`, `linescore`,
`officials`. Their column names and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_box")`, and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A named list of tibbles: `winprob_dataset`, `game_data`, `runs`. Their
column names and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_winprob")`, and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
try(kp_box(game_id = 6, year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_winprob(game_id = 1238, year = 2020))
# }
}
```
