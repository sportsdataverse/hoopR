# **Get NBA Stats API Video Events Asset**

**Get NBA Stats API Video Events Asset**

**Get NBA Stats API Video Events Asset**

## Usage

``` r
nba_videoeventsasset(game_id, game_event_id = 0, ...)
```

## Arguments

- game_id:

  Game ID - 10-digit zero-padded ID (e.g., '0021700807')

- game_event_id:

  Game Event ID - event number from play-by-play data

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list containing video event asset data (structure varies
by response)

## Details

     nba_videoeventsasset(game_id = '0021700807', game_event_id = 10)

## See also

Other NBA Video Functions:
[`nba_videodetails()`](https://hoopR.sportsdataverse.org/reference/nba_videodetails.md),
[`nba_videodetailsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videodetailsasset.md),
[`nba_videoevents()`](https://hoopR.sportsdataverse.org/reference/nba_videoevents.md),
[`nba_videostatus()`](https://hoopR.sportsdataverse.org/reference/nba_videostatus.md)

## Author

Saiem Gilani
