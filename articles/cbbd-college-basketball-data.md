# CollegeBasketballData (CBD) Endpoints

The `cbbd_*()` functions wrap the [CollegeBasketballData
API](https://collegebasketballdata.com), the men’s college basketball
sibling of CollegeFootballData (which `cfbfastR` wraps with `cfbd_*`).
They cover the full v1 endpoint surface — games, play-by-play,
substitutions, team/player statistics, lineups, ratings, rankings,
betting lines, recruiting, the transfer portal, the NBA draft, and
reference data for teams, venues and conferences.

Every wrapper returns a tidy `hoopR_data` tibble and prints its usage
with the shared hoopR theming.

### Registering an API key

The CollegeBasketballData API requires a free Bearer-token API key.
Request one at
[collegebasketballdata.com/key](https://collegebasketballdata.com/key),
then store it as the `CBBD_API_KEY` environment variable. The easiest
way is to add it to your `.Renviron` file:

``` r

usethis::edit_r_environ()
# add this line, save, and restart R:
# CBBD_API_KEY = XXXX-YOUR-API-KEY-HERE-XXXXX
```

For one-off use within a single session:

``` r

Sys.setenv(CBBD_API_KEY = "XXXX-YOUR-API-KEY-HERE-XXXXX")
```

Confirm the key is detected and inspect the registration help:

``` r

library(hoopR)

has_cbbd_key()
#> [1] TRUE

?register_cbbd
```

### Reference data: conferences, teams, venues

Start with the lookups you will use to filter the other endpoints. The
`id` values returned here are the CollegeBasketballData ids consumed
elsewhere; `source_id` holds the matching ESPN id.

``` r

# Conferences (and historical membership)
cbbd_conferences()
cbbd_conferences_history(conference = "ACC")

# Teams for a season, and a single team's roster
cbbd_teams(conference = "ACC", season = 2024)
cbbd_teams_roster(season = 2024, team = "Duke")

# Venues
cbbd_venues()
```

### Games and box scores

[`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md)
returns the schedule/results; the `*_teams` and `*_players` variants
return team- and player-level box scores.
[`cbbd_scoreboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md)
returns live and same-day games (so it is empty in the off-season).

``` r

games <- cbbd_games(season = 2024, team = "Duke")
games

cbbd_games_media(season = 2024, team = "Duke")    # broadcast info
cbbd_games_teams(season = 2024, team = "Duke")    # team box scores
cbbd_games_players(season = 2024, team = "Duke")  # player box scores

cbbd_scoreboard(conference = "ACC")
```

Most by-id endpoints take a CollegeBasketballData `game_id` from
[`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md):

``` r

game_id <- games$id[1]
```

### Play-by-play

Pull play-by-play by game, by player, by team, by date, or by
tournament. Pass `shooting_plays_only = TRUE` to restrict to shot
events.

``` r

cbbd_plays_game(game_id = game_id)
cbbd_plays_team(season = 2024, team = "Duke")
cbbd_plays_player(player_id = 160, season = 2024)
cbbd_plays_date(date = "2024-02-01T00:00:00.000Z")
cbbd_plays_tournament(tournament = "NCAA", season = 2024)

# Reference: the list of play types
cbbd_play_types()
```

### Substitutions

``` r

cbbd_substitutions_game(game_id = game_id)
cbbd_substitutions_team(season = 2024, team = "Duke")
cbbd_substitutions_player(player_id = 160, season = 2024)
```

### Team and player statistics

Season aggregates for teams and players, plus dedicated shooting splits
and a team leaderboard. Nested statistic objects are flattened into
prefixed columns (e.g. `team_stats_*`, `field_goals_*`).

``` r

cbbd_stats_team_season(season = 2024, team = "Duke")
cbbd_stats_team_leaderboard(season = 2024)
cbbd_stats_team_shooting_season(season = 2024, team = "Duke")

cbbd_stats_player_season(season = 2024, team = "Duke")
cbbd_stats_player_shooting_season(season = 2024, team = "Duke")
```

### Lineups

Five-player lineup stats for a team-season or a single game.

``` r

cbbd_lineups_team(season = 2024, team = "Duke")
cbbd_lineups_game(game_id = game_id)
```

### Ratings and rankings

``` r

cbbd_ratings_srs(season = 2024)        # Simple Rating System
cbbd_ratings_adjusted(season = 2024)   # adjusted offensive/defensive efficiency
cbbd_ratings_elo(season = 2024)        # Elo

cbbd_rankings(season = 2024, poll_type = "ap")
```

### Betting lines

``` r

cbbd_lines(season = 2024, team = "Duke")
cbbd_lines_providers()
```

### Recruiting and the transfer portal

``` r

cbbd_recruiting_players(year = 2024)
cbbd_recruiting_teams(year = 2024)
cbbd_recruiting_portal(year = 2024)
```

### NBA draft

``` r

cbbd_draft_teams()
cbbd_draft_positions()
cbbd_draft_picks(year = 2024)
```

### Where to go next

- Browse the full function reference under the **CollegeBasketballData
  (CBD)** section of the [reference
  index](https://hoopR.sportsdataverse.org/reference/index.md).
- Each wrapper’s help page
  ([`?cbbd_games`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md),
  [`?cbbd_plays_game`](https://hoopR.sportsdataverse.org/reference/cbbd_play_types.md),
  …) documents its parameters and the columns it returns.
- Inspect your remaining API usage and rate limits in the response
  headers from the [CollegeBasketballData
  API](https://collegebasketballdata.com).

## **Our Authors**

- [Saiem Gilani](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge)](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge)](https://github.com/saiemgilani)

### **Our Contributors**

- [Jason Lee](https://x.com/theFirmAISports)
  [![@theFirmAISports](https://img.shields.io/twitter/follow/theFirmAISports?color=blue&label=%40theFirmAISports&logo=x&style=for-the-badge)](https://x.com/theFirmAISports)
  [![@papagorgio23](https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge)](https://github.com/papagorgio23)
- [Billy Fryer](https://x.com/BillyFryer42)
  [![@BillyFryer42](https://img.shields.io/twitter/follow/BillyFryer42?color=blue&label=%40BillyFryer42&logo=x&style=for-the-badge)](https://x.com/BillyFryer42)
  [![@billyfryer](https://img.shields.io/github/followers/billyfryer?color=eee&logo=Github&style=for-the-badge)](https://github.com/billyfryer)
- [Ross Drucker](https://x.com/rossdrucker9)
  [![@rossdrucker9](https://img.shields.io/twitter/follow/rossdrucker9?color=blue&label=%40rossdrucker9&logo=x&style=for-the-badge)](https://x.com/rossdrucker9)
  [![@rossdrucker](https://img.shields.io/github/followers/rossdrucker?color=eee&logo=Github&style=for-the-badge)](https://github.com/rossdrucker)
- [Vladislav Shufinskiy](https://x.com/vshufinskiy)
  [![@vshufinskiy](https://img.shields.io/twitter/follow/vshufinskiy?color=blue&label=%40vshufinskiy&logo=x&style=for-the-badge)](https://x.com/vshufinskiy)
  [![@shufinskiy](https://img.shields.io/github/followers/shufinskiy?color=eee&logo=Github&style=for-the-badge)](https://github.com/shufinskiy)

### **Citation**

To cite the [**`hoopR`**](https://hoopR.sportsdataverse.org/) R package
in publications, use:

BibTeX Citation

``` bibtex
@misc{hoopr,
  author = {Saiem Gilani},
  title = {hoopR: Access Men’s Basketball Play by Play Data.},
  url = {https://hoopR.sportsdataverse.org/},
  year = {2026}
}
```

### **Related SportsDataverse packages**

- [**cfbfastR**](https://cfbfastR.sportsdataverse.org/) - college
  football
- [**hoopR**](https://hoopR.sportsdataverse.org/) - men’s basketball
- [**wehoop**](https://wehoop.sportsdataverse.org/) - women’s basketball
- [**baseballr**](https://baseballr.sportsdataverse.org/) - baseball
- [**fastRhockey**](https://fastRhockey.sportsdataverse.org/) - hockey
- [**oddsapiR**](https://oddsapiR.sportsdataverse.org/) - betting odds
- [**sportyR**](https://sportyR.sportsdataverse.org/) - playing surfaces
- [**sportsdataverse-py**](https://py.sportsdataverse.org/) - the Python
  package
- [**sportsdataverse-R**](https://r.sportsdataverse.org/) - the R
  meta-package
