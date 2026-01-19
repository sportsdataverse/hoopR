# **Get NBA Stats API Boxscore Similarity Score**

**Get NBA Stats API Boxscore Similarity Score**

**Get NBA Stats API Boxscore Similarity Score**

## Usage

``` r
nba_boxscoresimilarityscore(
  person_1_id = "202691",
  person_1_league_id = "00",
  person_1_season = most_recent_nba_season() - 3,
  person_1_season_type = "Regular Season",
  person_2_id = "1626164",
  person_2_league_id = "00",
  person_2_season = most_recent_nba_season() - 3,
  person_2_season_type = "Regular Season",
  ...
)
```

## Arguments

- person_1_id:

  person_1_id

- person_1_league_id:

  person_1_league_id

- person_1_season:

  person_1_season

- person_1_season_type:

  person_1_season_type

- person_2_id:

  person_2_id

- person_2_league_id:

  person_2_league_id

- person_2_season:

  person_2_season

- person_2_season_type:

  person_2_season_type

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: BoxScoreSimilarityScores

## Details

(Possibly Deprecated)

    z <- nba_commonallplayers()$CommonAllPlayers
    klay <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Klay Thompson')
    book <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Devin Booker')
    nba_boxscoresimilarityscore(person_1_id = klay$PERSON_ID,
      person_1_league_id = '00',
      person_1_season = year_to_season(most_recent_nba_season() - 1),
      person_1_season_type = 'Regular Season',
      person_2_id = book$PERSON_ID,
      person_2_league_id = '00',
      person_2_season = year_to_season(most_recent_nba_season() - 1),
      person_2_season_type = 'Regular Season'
    )

## See also

Other NBA Boxscore Similarity Functions:
[`nba_glalumboxscoresimilarityscore()`](https://hoopR.sportsdataverse.org/reference/nba_glalumboxscoresimilarityscore.md)

## Author

Saiem Gilani
