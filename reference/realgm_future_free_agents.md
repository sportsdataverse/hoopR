# **RealGM Future NBA Free Agents**

**Get RealGM's projected future NBA free-agent class from RealGM
(basketball.realgm.com).**

One row per upcoming free agent, including the free-agency season, the
player's Bird/veteran free-agent status, recent production and –
distinctively – the player's listed agent.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_future_free_agents()
```

## Value

A `hoopR_data` tibble with one row per future free agent. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_future_free_agents")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_future_free_agents())
} # }
```
