# **Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Board**

## Usage

``` r
nba_draftboard(season = most_recent_nba_season() - 1, ...)
```

## Arguments

- season:

  season

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: Picks, TeamsWithoutPicks,
LiveDetails

**Picks**

|                                  |           |
|----------------------------------|-----------|
| col_name                         | types     |
| pick_number                      | integer   |
| pick_details                     | character |
| team_id                          | integer   |
| team_type                        | character |
| team_season                      | integer   |
| team_team_id                     | integer   |
| team_permalink                   | character |
| team_app_url                     | character |
| team_trade_details               | list      |
| team_team_name                   | character |
| team_team_abbr                   | character |
| team_picked_first_round          | logical   |
| team_picked_second_round         | logical   |
| team_team_record_season          | character |
| team_team_record_wins_and_losses | character |
| team_team_record_season_finish   | character |
| team_team_record_playoffs_finish | character |
| prospect_id                      | integer   |
| prospect_type                    | character |
| prospect_season                  | integer   |
| prospect_display_name            | character |
| prospect_first_name              | character |
| prospect_last_name               | character |
| prospect_permalink               | character |
| prospect_app_url                 | character |
| prospect_position                | character |
| prospect_weight_lbs              | integer   |
| prospect_school                  | character |
| prospect_status                  | character |
| prospect_birthday                | character |
| prospect_country                 | character |
| prospect_trade_details           | list      |
| prospect_height_feet_and_inches  | character |
| prospect_height_inches_only      | integer   |

**TeamsWithoutPicks**

|                     |            |
|---------------------|------------|
| col_name            | types      |
| id                  | integer    |
| type                | character  |
| season              | integer    |
| team_id             | integer    |
| team_record         | data.frame |
| permalink           | character  |
| app_url             | character  |
| trade_details       | list       |
| team_name           | character  |
| team_abbr           | character  |
| picked_second_round | logical    |
| picked_first_round  | logical    |

**LiveDetails**

|                                |         |
|--------------------------------|---------|
| col_name                       | types   |
| is_draft_live                  | logical |
| live_draft_current_pick_number | numeric |

## Details

      nba_draftboard(season = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
