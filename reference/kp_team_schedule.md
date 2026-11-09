# **Get team schedule results**

**Get team schedule results**

**Get KenPom's team game plan page**

**Get KenPom's team opponent tracker page**

**Get KenPom's player stats from the team page**

**Get KenPom's player career stats from the player page**

**Get Minutes Matrix from Expanded Player Page**

**Get Team Player Stats**

**Get Depth Chart Last 5 Games from Team Page**

**Get Lineups Last 5 Games from Team Page**

## Usage

``` r
kp_team_schedule(team, year = 2022)

kp_gameplan(team, year = 2021)

kp_opptracker(team, year = 2021)

kp_team_players(team, year = 2021)

kp_player_career(player_id)

kp_minutes_matrix(team, year = 2021)

kp_team_player_stats(team, year = 2021)

kp_team_depth_chart(team, year = 2021)

kp_team_lineups(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

- player_id:

  Player Id filter to select.

## Value

A tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_team_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A named list of tibbles: `gameplan`, `correlations`,
`position_distributions`. Their column names and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_gameplan")`, and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_opptracker")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_team_players")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A named list of tibbles: `player_stats`, `gamelog`. Their column names
and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_player_career")`, and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

Returns a tibble of minutes matrix data

A named list of data frames: `all_games`, `conference_games`. Their
column names and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_team_player_stats")`, and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per rostered player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_team_depth_chart")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_team_lineups")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
# \donttest{
  try(kp_team_schedule(team = 'Florida St.', year = 2022))
# }
}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
# \donttest{
   try(kp_gameplan(team='Florida St.', year=2021))
# }
}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
# \donttest{
  try(kp_opptracker(team = 'Florida St.', year = 2021))
# }
}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
  # \donttest{
    try(kp_team_players(team = 'Florida St.', year = 2024))
  # }
}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
  # \donttest{
    try(kp_player_career(player_id = '41180'))
  # }
}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
  # \donttest{
    try(kp_minutes_matrix(team = 'Florida St.', year = 2021))
  # }

}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
  # \donttest{
    try(kp_team_player_stats(team = 'Florida St.', year = 2021))
  # }
}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
  # \donttest{
    try(kp_team_depth_chart(team = 'Florida St.', year= 2021))
  # }

}
if (FALSE) { # interactive() && !nzchar(Sys.getenv("CI"))
  # \donttest{
    try(kp_team_lineups(team = 'Florida St.', year = 2021))
  # }
}
```
