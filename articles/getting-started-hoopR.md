# Getting Started with hoopR: NBA and College Basketball Data in R

Welcome folks,

I’m Saiem Gilani, one of the
[authors](https://hoopR.sportsdataverse.org/authors.html "Authors and contributors to hoopR")
of [`hoopR`](https://hoopR.sportsdataverse.org), and I hope to give the
community a high-quality resource for accessing men’s basketball data
for statistical analysis, basketball research, and more. This guide is
written for students and newcomers: it assumes no prior R or
basketball-analytics experience, and it ends with your first chart.

### What you’ll learn

- How to install R, RStudio and the `hoopR` package.
- How `hoopR` is organized: what each function prefix (`load_nba_*`,
  `espn_mbb_*`, `nba_*`, `kp_*`, …) means and where its data comes from.
- How seasons are counted, and why that matters when you load data.
- How to load one season of NBA team box scores and play-by-play,
  compute possessions and efficiency ratings, and draw a first `ggplot2`
  chart.
- The basketball-analytics vocabulary you will meet in the rest of the
  documentation (possessions, pace, offensive rating, four factors,
  RAPM, …).
- Where to find every function and article.

### How do I install R and RStudio?

1.  Head to <https://cran.r-project.org>
2.  Select the appropriate link for your operating system (Windows, Mac
    OS X, or Linux)

- **Windows** - Select base and download the most recent version
- **Mac OS X** - Select Latest Release, but check to make sure your OS
  is the correct version. Look through Binaries for Legacy OS X Systems
  if you are on an older release
- **Linux** - Select the appropriate distro and follow the installation
  instructions

3.  Head to
    [posit.co](https://posit.co/download/rstudio-desktop/#download "Download the appropriate version of RStudio (Free) for your operating system to use with R")
4.  Follow the associated download and installation instructions for
    RStudio.
5.  Start peering over the [RStudio IDE
    Cheatsheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf).
    *An IDE is an integrated development environment.*
6.  For **Windows** users: I recommend you install
    [Rtools](https://cran.r-project.org/bin/windows/Rtools/). This is
    not an R package! It is “a collection of resources for building
    packages for R under Microsoft Windows, or for building R itself”.
    Go to <https://cran.r-project.org/bin/windows/Rtools/> and follow
    the directions for installation.

### How do I install hoopR?

`hoopR` is on CRAN, and the development version lives on GitHub. Either
works for this guide.

``` r

# The released version from CRAN
install.packages("hoopR")

# Or the development version from GitHub, using the pak package
if (!requireNamespace("pak", quietly = TRUE)) {
  install.packages("pak")
}
pak::pak("sportsdataverse/hoopR", dependencies = TRUE, update = TRUE)

# The examples in this guide also use dplyr and ggplot2
install.packages(c("dplyr", "ggplot2"))
```

Then load the packages at the top of every script:

``` r

library(hoopR)
library(dplyr)
library(ggplot2)
```

### How is hoopR organized? Function prefixes and data sources

`hoopR` version 3.2.0 exports 1340 functions. That sounds like a lot,
but the **prefix** of a function name tells you where its data comes
from, so you only need to learn a dozen patterns.

| Prefix | Source | What you get | Notes |
|----|----|----|----|
| `load_nba_*()`, `load_mbb_*()` | SportsDataverse data releases built from ESPN | Season files: play-by-play, team and player box scores, schedules, shots, rosters, standings | Fast, no rate limits. NBA from 2002, men’s college from 2003/2006. |
| `load_nba_stats_*()` | Data releases built from the NBA Stats API | Possessions with lineups, shots in the NBA Stats frame, lineups, game logs, season stats | Takes the season **start** year (see below). |
| `load_ncaa_mbb_*()` | Data releases built from stats.ncaa.org | NCAA play-by-play, shots, lineups, 10-man stints, possessions, RAPM | Uses stats.ncaa.org ids. |
| [`load_nba_player_impact()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md), [`load_mbb_ratings()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md), [`load_mbb_player_value()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md) | Model datasets published by the SportsDataverse | Player impact (RAPM, BPM, WAR), team ratings, player box plus-minus | See the model articles below. |
| `espn_nba_*()`, `espn_mbb_*()` | ESPN’s live APIs | Scoreboards, game summaries, play-by-play, rankings, standings, team and player stats | 105 NBA and 94 college functions. |
| `nba_*()` | The NBA Stats API (stats.nba.com) and other NBA.com sources | Every NBA Stats endpoint: box scores, tracking, shot charts, lineups, draft, play-by-play | 199 functions; slow and sometimes blocked from cloud servers. |
| `nbagl_*()` | NBA G League Stats API | G League schedules and stats | 6 functions. |
| `kp_*()` | [KenPom.com](https://kenpom.com) | Efficiency ratings, four factors, team and player pages | Requires a paid KenPom subscription. |
| `cbbd_*()` | [CollegeBasketballData.com](https://collegebasketballdata.com) | Games, lines, ratings, plays, lineups | Free API key, stored in the `CBBD_API_KEY` environment variable ([how to register](https://hoopR.sportsdataverse.org/reference/register_cbbd.md)). |
| `torvik_*()` | [Bart Torvik (T-Rank)](https://barttorvik.com) | T-Rank ratings, game and player data | 6 functions. |
| `ncaa_mbb_*()` | stats.ncaa.org (live) | Team and player stats, play-by-play | Use the `load_ncaa_mbb_*()` releases when you can. |
| `bref_*()`, `fox_*()`, `realgm_*()` | Basketball-Reference, Fox Sports, RealGM | Historical tables, odds, rosters | `realgm_*()` needs the chromote package and Chrome. |
| `euroleague_*()`, `fiba_*()`, `acb_*()`, `nbl_rosetta_*()`, … | EuroLeague, FIBA and about forty other leagues and competitions | Schedules, play-by-play, box scores, shots | See the [international leagues guide](https://hoopR.sportsdataverse.org/articles/international-basketball-leagues.md). |
| [`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md), [`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md), [`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md), … | Your own data (no network) | Efficiency formulas and box-score helpers | Work on NBA and college box scores alike. |

#### Release data or live APIs: which should I use?

The `load_*()` functions download files that the SportsDataverse
rebuilds and publishes on its [`sportsdataverse-data`
releases](https://github.com/sportsdataverse/sportsdataverse-data/releases).
They are the fastest and most reliable way to get a full season, and
they are what every evaluated example on this site uses. The live
functions (`espn_*()`, `nba_*()`, `kp_*()`, …) call the source website
directly: use them for today’s games, for endpoints that have no release
file, or for a single game you need right now. Live sources can change,
rate-limit you or block cloud servers, so keep live calls small and
cache what you download.

#### How does hoopR count seasons?

A basketball season spans two calendar years. `hoopR` names a season by
the year it **ends**: the 2025-26 NBA season is `2026`. The helpers
[`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)
and
[`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md)
return the current season’s end year (this guide was built when they
returned 2027 and 2027).

The one exception is the `load_nba_stats_*()` family, which follows the
NBA Stats API and takes the season’s **start** year:
`load_nba_stats_possessions(2025)` returns the 2025-26 season. Its
helper is
[`most_recent_nba_stats_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_stats_season.md).
When in doubt, look at the `season` column of what came back.

### Worked example: which NBA teams were most efficient in 2025-26?

This is the whole workflow in miniature: load a season, clean it,
compute a metric, and plot it.

#### Step 1: load one season of team box scores

[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md)
returns one row per team per game.

``` r

season <- 2026
nba_team_box <- load_nba_team_box(seasons = season)
dim(nba_team_box)
```

    ## [1] 2652   59

``` r

nba_team_box |>
  select(game_id, game_date, season_type, team_abbreviation, team_score,
         field_goals_attempted, free_throws_attempted, offensive_rebounds,
         total_turnovers, opponent_team_abbreviation, opponent_team_score) |>
  head()
```

    ## # A tibble: 6 × 11
    ##     game_id game_date  season_type team_abbreviation team_score
    ##       <int> <date>           <int> <chr>                  <int>
    ## 1 401859967 2026-06-13           3 NY                        94
    ## 2 401859967 2026-06-13           3 SA                        90
    ## 3 401859966 2026-06-10           3 SA                       106
    ## 4 401859966 2026-06-10           3 NY                       107
    ## 5 401859965 2026-06-08           3 SA                       115
    ## 6 401859965 2026-06-08           3 NY                       111
    ## # ℹ 6 more variables: field_goals_attempted <int>, free_throws_attempted <int>,
    ## #   offensive_rebounds <int>, total_turnovers <int>,
    ## #   opponent_team_abbreviation <chr>, opponent_team_score <int>

`season_type` is ESPN’s code: `2` is the regular season and `3` the
playoffs. We keep the regular season so teams are compared over a
similar schedule. Always check what you filtered: ESPN’s regular-season
file also holds the All-Star exhibition games, played by teams that are
not NBA franchises.

``` r

nba_team_box |>
  filter(season_type == 2) |>
  count(team_display_name, name = "games") |>
  arrange(games) |>
  head(5)
```

    ## # A tibble: 5 × 2
    ##   team_display_name games
    ##   <chr>             <int>
    ## 1 World                 2
    ## 2 Team Stars            3
    ## 3 Team Stripes          3
    ## 4 Atlanta Hawks        82
    ## 5 Boston Celtics       82

Keeping teams with at least 41 games (half a season) leaves the 30
franchises:

``` r

regular <- nba_team_box |>
  filter(season_type == 2) |>
  add_count(team_id, name = "team_games") |>
  filter(team_games >= 41)

n_distinct(regular$team_id)
```

    ## [1] 30

#### Step 2: estimate possessions and efficiency

Raw points per game reward teams that play fast. Analysts compare teams
**per possession** instead. A *possession* is one team’s turn with the
ball; it ends with a made basket, a defensive rebound, a turnover or the
end of a period. Box scores do not count possessions directly, so we
estimate them with
[`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md):

`possessions = FGA + 0.44 * FTA - OREB + TOV`

The 0.44 converts free-throw attempts into the share of possessions they
end (two-shot fouls, and-ones and technicals make this less than 0.5).
*Offensive rating* (ORtg) is points scored per 100 possessions,
*defensive rating* (DRtg) is points allowed per 100 possessions, and
*net rating* is the difference.

``` r

team_ratings <- regular |>
  mutate(
    poss = nba_possessions(
      fga = field_goals_attempted, fta = free_throws_attempted,
      oreb = offensive_rebounds, tov = total_turnovers
    )
  ) |>
  group_by(team_abbreviation, team_display_name) |>
  summarise(
    games = n(),
    poss = sum(poss),
    pts = sum(team_score),
    opp_pts = sum(opponent_team_score),
    .groups = "drop"
  ) |>
  mutate(
    ortg = nba_offensive_rating(pts, poss),
    drtg = nba_defensive_rating(opp_pts, poss),
    net = nba_net_rating(ortg, drtg)
  ) |>
  arrange(desc(net))

team_ratings |>
  select(team_display_name, games, ortg, drtg, net) |>
  mutate(across(c(ortg, drtg, net), \(x) round(x, 1))) |>
  head(10)
```

    ## # A tibble: 10 × 5
    ##    team_display_name      games  ortg  drtg   net
    ##    <chr>                  <int> <dbl> <dbl> <dbl>
    ##  1 Oklahoma City Thunder     82  116.  105.  10.9
    ##  2 Detroit Pistons           82  114.  106.   7.9
    ##  3 San Antonio Spurs         83  117.  109.   7.9
    ##  4 Boston Celtics            82  117.  109    7.8
    ##  5 New York Knicks           83  117.  110.   6.4
    ##  6 Houston Rockets           82  115.  110.   5.2
    ##  7 Denver Nuggets            82  119.  114.   5  
    ##  8 Charlotte Hornets         82  115.  110    4.8
    ##  9 Cleveland Cavaliers       82  116.  112.   4  
    ## 10 Minnesota Timberwolves    82  114.  111.   3.2

The Oklahoma City Thunder led the league with a net rating of +10.9
points per 100 possessions. (We used each team’s own possession estimate
for both ratings; the [advanced metrics
article](https://hoopR.sportsdataverse.org/articles/basketball-advanced-metrics.md)
shows the two-team version.)

#### Step 3: your first ggplot2 chart

Plot offense against defense. The defensive axis is reversed so the best
teams land in the top-right corner.

``` r

ggplot(team_ratings, aes(x = ortg, y = drtg)) +
  geom_hline(yintercept = mean(team_ratings$drtg), linetype = "dashed", colour = "grey60") +
  geom_vline(xintercept = mean(team_ratings$ortg), linetype = "dashed", colour = "grey60") +
  geom_point(aes(colour = net), size = 3) +
  geom_text(aes(label = team_abbreviation), nudge_y = 0.45, size = 3) +
  scale_y_reverse() +
  scale_colour_gradient2(low = "#B2182B", mid = "grey70", high = "#2166AC", name = "Net rating") +
  labs(
    title = "NBA offensive vs defensive rating, 2025-26 regular season",
    subtitle = "Points per 100 estimated possessions; better defense is higher",
    x = "Offensive rating (points scored per 100 possessions)",
    y = "Defensive rating (points allowed per 100 possessions)",
    caption = "Data: hoopR::load_nba_team_box()"
  ) +
  theme_minimal()
```

![Scatter plot of NBA teams' offensive rating against defensive rating
for the 2025-26 regular season, with team abbreviations as labels and
the defensive axis reversed so better teams appear toward the top
right.](getting-started-hoopR_files/figure-html/first_plot-1.png)

#### Step 4: go one level deeper with play-by-play

Box scores summarize a game; play-by-play (pbp) lists every event.
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md)
returns one row per play with the score, clock, players involved and,
for shots, court coordinates.

``` r

nba_pbp <- load_nba_pbp(seasons = season)
dim(nba_pbp)
```

    ## [1] 642472     68

``` r

nba_pbp |>
  filter(season_type == 2) |>
  count(type_text, sort = TRUE) |>
  head(10)
```

    ## # A tibble: 10 × 2
    ##    type_text               n
    ##    <chr>               <int>
    ##  1 Defensive Rebound   85775
    ##  2 Substitution        76521
    ##  3 Jump Shot           64451
    ##  4 Offensive Rebound   43975
    ##  5 Pullup Jump Shot    25696
    ##  6 Shooting Foul       25633
    ##  7 Free Throw - 1 of 2 23626
    ##  8 Free Throw - 2 of 2 23603
    ##  9 Driving Layup Shot  19826
    ## 10 Personal Foul       14830

For example, the share of field-goal attempts that were three-pointers
in each quarter of regulation:

``` r

nba_pbp |>
  filter(season_type == 2, shooting_play, period_number <= 4,
         !grepl("Free Throw", type_text)) |>
  group_by(period_number) |>
  summarise(fga = n(), three_share = mean(points_attempted == 3)) |>
  mutate(three_share = round(three_share, 3))
```

    ## # A tibble: 4 × 3
    ##   period_number   fga three_share
    ##           <int> <int>       <dbl>
    ## 1             1 57445       0.423
    ## 2             2 55201       0.415
    ## 3             3 54739       0.415
    ## 4             4 52066       0.418

The same calls work for college basketball: swap in
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md)
and
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md).
A college game is 40 minutes, so college pace is usually quoted per 40
minutes rather than per 48.

### Basketball analytics glossary

Terms used across the `hoopR` documentation, with the helper that
computes each one where there is one.

| Term | Meaning |
|----|----|
| **Box score** | Per-game totals for each team or player: points, field goals, rebounds, assists, turnovers, fouls, minutes. |
| **Play-by-play (pbp)** | One row per game event (shot, rebound, foul, substitution, timeout) with clock and score. |
| **FGA, FGM, 3PA, FTA, OREB, DREB, TOV** | Field-goal attempts and makes, three-point attempts, free-throw attempts, offensive and defensive rebounds, turnovers. |
| **Possession** | One team’s turn with the ball, ending with a made shot, defensive rebound, turnover or end of period. Estimated by [`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md): `FGA + 0.44 * FTA - OREB + TOV`. |
| **Pace** | Possessions per 48 minutes (NBA) or per 40 minutes (college). [`nba_pace()`](https://hoopR.sportsdataverse.org/reference/nba_pace.md) uses 48. |
| **Offensive rating (ORtg)** | Points scored per 100 possessions: [`nba_offensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_offensive_rating.md). |
| **Defensive rating (DRtg)** | Points allowed per 100 possessions: [`nba_defensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_defensive_rating.md). Lower is better. |
| **Net rating** | ORtg minus DRtg: [`nba_net_rating()`](https://hoopR.sportsdataverse.org/reference/nba_net_rating.md). |
| **Adjusted efficiency** | Ratings corrected for opponent strength, as in KenPom or [`load_mbb_ratings()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_value.md) (`adj_o`, `adj_d`, `adj_em`). |
| **eFG%** | Effective field-goal percentage, `(FGM + 0.5 * 3PM) / FGA`, crediting threes for their extra point: [`nba_effective_fg_pct()`](https://hoopR.sportsdataverse.org/reference/nba_effective_fg_pct.md). |
| **TS%** | True shooting percentage, points per shooting possession, `PTS / (2 * (FGA + 0.44 * FTA))`: [`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md). |
| **FT rate** | Free throws relative to field-goal attempts: [`nba_ft_rate()`](https://hoopR.sportsdataverse.org/reference/nba_ft_rate.md) uses `FTA / FGA`; the four-factors version uses `FTM / FGA`. |
| **TOV%** | Turnovers per 100 plays, `100 * TOV / (FGA + 0.44 * FTA + TOV)`: [`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md). |
| **OREB%** | Share of available offensive rebounds a team grabbed, `100 * OREB / (OREB + opponent DREB)`: [`nba_oreb_pct()`](https://hoopR.sportsdataverse.org/reference/nba_oreb_pct.md). |
| **Four factors** | Dean Oliver’s four drivers of winning: shooting (eFG%), turnovers (TOV%), rebounding (OREB%) and free throws (FT rate). [`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md) returns all four. |
| **Usage rate** | Share of team plays a player used while on the floor: [`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md). |
| **Per-36 / per-100** | Counting stats scaled to 36 minutes or 100 possessions so players with different playing time compare fairly: [`nba_per_minutes()`](https://hoopR.sportsdataverse.org/reference/nba_per_minutes.md), [`nba_per_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_per_possessions.md). |
| **Plus/minus** | Point differential while a player was on the court (`plus_minus` in the NBA player box). Heavily influenced by teammates and opponents. |
| **Stint** | A stretch of play during which the same ten players are on the court. [`load_ncaa_mbb_matchup_stints()`](https://hoopR.sportsdataverse.org/reference/load_ncaa_mbb_lineups.md) returns college stints. |
| **Lineup** | A specific group of five teammates on the court together. |
| **Garbage time** | Late minutes of a lopsided game, when results are decided and benches play; often filtered out of analyses (`is_garbage_time` in [`load_ncaa_mbb_possessions()`](https://hoopR.sportsdataverse.org/reference/load_ncaa_mbb_lineups.md)). |
| **APM / RAPM** | Adjusted plus-minus: a regression that credits each player for possession outcomes while controlling for the other nine players on the court. *Regularized* APM (RAPM) adds a ridge penalty that shrinks noisy estimates toward zero. See the [RAPM model article](https://hoopR.sportsdataverse.org/articles/college-basketball-rapm-model.md). |
| **BPM / SPM** | Box (or statistical) plus-minus: a regression that estimates a player’s impact from box-score statistics alone. |
| **WAR** | Wins above replacement: a player’s value in wins relative to a freely available replacement player. |
| **Win probability (WP)** | The chance a team wins given the current game state (score, time, possession): `home_win_prob` in [`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md). |

### Where are the functions? The reference index by section

The [function
reference](https://hoopR.sportsdataverse.org/reference/index.md) groups
every exported function by source. Jump straight to a section:

- [hoopR
  Data](https://hoopR.sportsdataverse.org/reference/index.html#hoopr-data):
  every `load_*()` release loader, including the [NBA Stats API
  loaders](https://hoopR.sportsdataverse.org/reference/index.html#nba-stats-api-data-loaders),
  the [NCAA engine
  loaders](https://hoopR.sportsdataverse.org/reference/index.html#ncaa-men-s-college-basketball-play-by-play-engine-data-loaders)
  and the [model dataset
  loaders](https://hoopR.sportsdataverse.org/reference/index.html#model-dataset-loaders).
- [Cross-Source
  Crosswalks](https://hoopR.sportsdataverse.org/reference/index.html#cross-source-crosswalks):
  join ESPN, NBA Stats, KenPom, Torvik and Fox ids.
- [ESPN
  Data](https://hoopR.sportsdataverse.org/reference/index.html#espn-data):
  `espn_mbb_*()`, `espn_nba_*()` and `fox_*()`.
- [NBA
  Data](https://hoopR.sportsdataverse.org/reference/index.html#nba-data):
  the [NBA Stats
  API](https://hoopR.sportsdataverse.org/reference/index.html#nba-stats-api),
  the [G
  League](https://hoopR.sportsdataverse.org/reference/index.html#nba-g-league-stats-api)
  and the [basketball analytics
  utilities](https://hoopR.sportsdataverse.org/reference/index.html#basketball-analytics-utilities).
- [NCAA
  Data](https://hoopR.sportsdataverse.org/reference/index.html#ncaa-data),
  [KenPom
  Data](https://hoopR.sportsdataverse.org/reference/index.html#kenpom-data),
  [CollegeBasketballData
  (CBD)](https://hoopR.sportsdataverse.org/reference/index.html#collegebasketballdata-cbd-)
  and [Bart Torvik
  (T-Rank)](https://hoopR.sportsdataverse.org/reference/index.html#bart-torvik-t-rank-).
- [Injury
  Reports](https://hoopR.sportsdataverse.org/reference/index.html#injury-reports),
  [Officiating](https://hoopR.sportsdataverse.org/reference/index.html#officiating)
  and
  [Basketball-Reference](https://hoopR.sportsdataverse.org/reference/index.html#basketball-reference).
- [Euroleague
  Data](https://hoopR.sportsdataverse.org/reference/index.html#euroleague-data)
  and [International
  Basketball](https://hoopR.sportsdataverse.org/reference/index.html#international-basketball).
- [Salary & Mock Draft
  Sources](https://hoopR.sportsdataverse.org/reference/index.html#salary-mock-draft-sources),
  [RealGM](https://hoopR.sportsdataverse.org/reference/index.html#realgm)
  and [Helper Functions and
  Data](https://hoopR.sportsdataverse.org/reference/index.html#helper-functions-and-data).

Good first function pages (each name links to its reference page):
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_shots()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md)
and
[`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md).

### Articles and guides

Data guides:

- [ESPN
  endpoints](https://hoopR.sportsdataverse.org/articles/espn-endpoints.md):
  live ESPN scoreboards, game summaries and play-by-play for the NBA and
  college.
- [NBA
  cookbook](https://hoopR.sportsdataverse.org/articles/nba-cookbook.md)
  and [men’s college basketball
  cookbook](https://hoopR.sportsdataverse.org/articles/mbb-cookbook.md):
  short recipes for common questions.
- [NBA Stats API parameter
  descriptions](https://hoopR.sportsdataverse.org/articles/parameter-descriptions.md):
  what each `nba_*()` argument means.
- [KenPom example
  functions](https://hoopR.sportsdataverse.org/articles/kenpom-example-functions.md)
  and [CollegeBasketballData (CBD)
  endpoints](https://hoopR.sportsdataverse.org/articles/cbbd-college-basketball-data.md).
- [International basketball
  leagues](https://hoopR.sportsdataverse.org/articles/international-basketball-leagues.md):
  EuroLeague, FIBA and about forty more leagues and competitions.

Analysis guides:

- [Shot charts and court
  plots](https://hoopR.sportsdataverse.org/articles/nba-college-basketball-shot-charts.md)
  with sportyR and sdvplotR.
- [Basketball advanced
  metrics](https://hoopR.sportsdataverse.org/articles/basketball-advanced-metrics.md):
  possessions, pace, ratings, four factors, usage and true shooting.

Model write-ups:

- [NBA player impact
  model](https://hoopR.sportsdataverse.org/articles/nba-player-impact-model.md):
  RAPM, SPM, BPM, DARKO-style projections and WAR.
- [College basketball RAPM
  model](https://hoopR.sportsdataverse.org/articles/college-basketball-rapm-model.md),
  including fitting your own RAPM with
  [`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md).
- [College basketball team ratings
  model](https://hoopR.sportsdataverse.org/articles/college-basketball-team-ratings-model.md).
- [College basketball player value
  model](https://hoopR.sportsdataverse.org/articles/college-basketball-player-value-model.md).
- [College basketball win probability
  model](https://hoopR.sportsdataverse.org/articles/college-basketball-win-probability-model.md).

### Where to go next

1.  Repeat the worked example for college: `load_mbb_team_box(2026)` and
    the same
    [`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md)
    code.
2.  Read the [advanced metrics
    article](https://hoopR.sportsdataverse.org/articles/basketball-advanced-metrics.md)
    to compute the four factors, usage and true shooting for every team
    and player.
3.  Draw a [shot
    chart](https://hoopR.sportsdataverse.org/articles/nba-college-basketball-shot-charts.md)
    for your favorite player.
4.  Explore player value with
    [`load_nba_player_impact()`](https://hoopR.sportsdataverse.org/articles/nba-player-impact-model.md)
    or college
    [RAPM](https://hoopR.sportsdataverse.org/articles/college-basketball-rapm-model.md).
5.  Ask questions and share what you build: open an issue on
    [GitHub](https://github.com/sportsdataverse/hoopR/issues).

## **Our Authors**

- [Saiem Gilani](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge)](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge)](https://github.com/saiemgilani)

### **Our Contributors**

- [Jason Lee](https://x.com/theFirmAISports)
  [![@theFirmAISports](https://img.shields.io/twitter/follow/theFirmAISports?color=blue&label=%40theFirmAISports&logo=x&style=for-the-badge)](https://x.com/theFirmAISports)
  [![@papagorgio23](https://img.shields.io/github/followers/papagorgio23?color=eee&logo=Github&style=for-the-badge)](https://github.com/papagorgio23)
- Billy Fryer
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
  title = {hoopR: Access Men's Basketball Play by Play Data},
  doi = {10.32614/CRAN.package.hoopR},
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
  (2.4.5 on CRAN: NBA, NCAA and FIBA courts for plotting shot locations)
- [**sdvplotR**](https://sdvplotR.sportsdataverse.org/) - team logos and
  colours for `ggplot2`, and shot charts from the `hoopR` shot loaders
  (0.3.0, `pak::pak("sportsdataverse/sdvplotR")`; see its
  [NBA](https://sdvplotR.sportsdataverse.org/articles/nba-viz.html),
  [men’s
  college](https://sdvplotR.sportsdataverse.org/articles/mbb-viz.html)
  and [shot
  chart](https://sdvplotR.sportsdataverse.org/articles/cookbook-surfaces-shot-charts.html)
  articles)
- [**sportsdataverse-py**](https://py.sportsdataverse.org/) - the Python
  package
- [**sportsdataverse-R**](https://r.sportsdataverse.org/) - the R
  meta-package
