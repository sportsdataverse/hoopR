# **Get Division-I statistical trends**

**Get Division-I statistical trends**

**Get officials rankings**

**Get referee game log**

**Get Home Court Advantage Estimates**

**Get Home Court Arenas**

**Get Game Attributes**

**Get FanMatch by date**

## Usage

``` r
kp_trends()

kp_officials(year = most_recent_mbb_season())

kp_referee(referee, year)

kp_hca()

kp_arenas(year = most_recent_mbb_season())

kp_game_attrs(year = most_recent_mbb_season(), attr = "Excitement")

kp_fanmatch(date)
```

## Arguments

- year:

  Year of data to pull

- referee:

  Referee ID

- attr:

  Game Attribute, valid values include:  
  'Excitement', 'Tension','Dominance','MinWp','FanMatch',  
  'Upsets','Busts','Comeback','Window'

- date:

  Date of games to pull (YYYY-MM-DD)

## Value

A data frame with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_trends")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per official. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_officials")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_referee")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_hca")`) and in the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per venue. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_arenas")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_game_attrs")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A data frame with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_fanmatch")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
try(kp_trends())
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_officials(year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_referee(referee = 714363, year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_hca())
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_arenas(year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_game_attrs(year = 2021, attr = "Excitement"))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_fanmatch(date = "2022-02-22"))
# }
}
```
