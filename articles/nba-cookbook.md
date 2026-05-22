# NBA Cookbook

## Before we cook

Every recipe in this cookbook is a small story: a question you might
actually ask about the NBA, and the shortest honest path from that
question to a data frame you can work with. Most of the code blocks run
live when this page is built, so the tables you see are real data
freshly pulled from ESPN and NBA.com. A handful – bulk season downloads,
the database recipe, and the proxy examples – are shown but not run,
since they either take too long or would reconfigure your session; those
are flagged where they appear.

Here’s the one idea worth internalizing before anything else: **`hoopR`
function names are not arbitrary. They’re a grammar.** Once you can read
the grammar, you can *guess* the function you need instead of hunting
for it. That guessing skill is the real subject of this cookbook; the
basketball is just the excuse.

### The grammar of a `hoopR` function name

Almost every function answers three questions in order:

1.  **Where does the data come from?** – the prefix.
    - `espn_` – ESPN’s APIs. Broadest coverage, most stable.
    - `nba_` – the official NBA Stats API (stats.nba.com). Deepest box
      scores, tracking data, lineup data.
    - `kp_` – KenPom (men’s college only – you won’t use it here, but
      you’ll meet it in the MBB cookbook).
    - `load_` – pre-built bulk data. A whole season in one call.
    - `nbagl_` – the NBA G League.
2.  **Which league / which slice?** – for ESPN functions the league is
    baked in: `espn_nba_`. For the NBA Stats API the `nba_` prefix *is*
    the league.
3.  **What thing do you want?** – the rest of the name, read left to
    right from general to specific: `team_season_roster`,
    `athlete_career_stats`, `event_competitor_linescores`.

So if you want “a team’s roster for a given season, from ESPN,” you can
assemble the name in your head before you ever open the docs: `espn_` +
`nba_` + `team` + `_roster` -\>
[`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md).
If you want “the league leaders from NBA.com,” it’s `nba_` +
`leagueleaders` -\>
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md).
The package has hundreds of functions; you do not need to memorize them.
You need to memorize the grammar.

We’ll point at the grammar in the margins of each recipe, like a cooking
show host muttering “and notice we salt the water *first*.”

``` r

library(hoopR)
library(dplyr)
```

## Recipe 1: One game, three levels of detail

**The story.** A friend texts you about last night’s game and you want
to actually look at it – not a headline, the game itself.

ESPN gives you a game at three zoom levels, and the function names tell
you which zoom you’re asking for. Start wide, then push in.

``` r

game_id <- 401283399

# Widest: the whole game summary as a named list of tibbles.
# Read the name: espn / nba / "game" / "all" -- give me all of it.
full_game <- espn_nba_game_all(game_id = game_id)
names(full_game)
#> [1] "Plays"  "Team"   "Player"

# Medium: the box score. "team_box" and "player_box" are siblings --
# same noun (box), different grain (team vs. player).
team_box   <- espn_nba_team_box(game_id = game_id)
player_box <- espn_nba_player_box(game_id = game_id)

# Tightest: the play-by-play. Every possession, one row each.
pbp <- espn_nba_pbp(game_id = game_id)
```

The lesson hiding in the margin: `team_box` and `player_box` differ by
exactly one word, and that word is the *grain* of the table. Whenever
you see two functions whose names differ by a single noun, that noun is
almost always telling you “one row per \_\_\_.”

## Recipe 2: A superstar’s whole career on one screen

**The story.** You want to see LeBron James’s career arc – not this
season, the whole thing – and you want it tidy enough to plot.

The word you’re reaching for is **career**. ESPN’s core-v2 API has a
dedicated career rollup, and the function is named exactly what it is.

``` r

# espn / nba / athlete / career / stats. The name is the sentence.
lebron <- espn_nba_athlete_career_stats(athlete_id = 1966)

# It comes back long -- one row per (stat_type x category x stat) --
# which is exactly the shape you want for a faceted ggplot.
lebron |>
  filter(category_name == "offensive", stat_name == "avgPoints") |>
  select(stat_type_id, value)
#> # A tibble: 1 × 2
#>   stat_type_id value
#>   <chr>        <dbl>
#> 1 0             26.8
```

Margin note: `athlete_career_stats()` defaults to fetching *both*
regular season and postseason and stacking them, keyed by a
`stat_type_id` column. A lot of the newer `espn_nba_*` functions do this
– when a function could sensibly return “regular + playoffs,” it usually
returns both and lets you filter. If you only want one, pass
`season_type`.

Want the season-by-season index instead of the career rollup? The
grammar predicts it: swap `career_stats` for `seasons`.

``` r

espn_nba_athlete_seasons(athlete_id = 1966)
#> # A tibble: 23 × 4
#>    league athlete_id season ref                                                 
#>    <chr>  <chr>       <int> <chr>                                               
#>  1 nba    1966         2026 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  2 nba    1966         2025 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  3 nba    1966         2024 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  4 nba    1966         2023 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  5 nba    1966         2022 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  6 nba    1966         2021 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  7 nba    1966         2020 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  8 nba    1966         2019 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  9 nba    1966         2018 http://sports.core.api.espn.com/v2/sports/basketbal…
#> 10 nba    1966         2017 http://sports.core.api.espn.com/v2/sports/basketbal…
#> # ℹ 13 more rows
```

## Recipe 3: Game flow and the comeback

**The story.** The game in Recipe 1 had a wild fourth quarter. You want
to *see* the momentum swing.

``` r

# Route A -- ESPN's per-play win probability, ready to plot as-is.
wp <- espn_nba_event_probabilities(event_id = 401283399)

# Route B -- if you'd rather compute momentum yourself, the NBA Stats
# API's V3 play-by-play is the rawest material. The prefix flips to
# `nba_` -- different data source, different first token -- and it
# keys off stats.nba.com game ids, which look nothing like ESPN's, so
# lift a real one off the schedule first.
sched  <- nba_schedule()
pbp_v3 <- nba_playbyplayv3(game_id = sched$game_id[1])
```

This is the grammar doing real work.
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md)
and
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md)
answer almost the same question – give me the plays – and you can tell
at a glance that the first is ESPN’s take and the second is NBA.com’s,
*because the prefix is the data source*. When two functions look like
near-synonyms, check the prefix; that’s the tiebreaker. (A small caveat
the grammar can’t tell you: the NBA Stats API churns faster than ESPN’s.
If a `nba_*` function ever tells you it is deprecated, it will name its
replacement in the same breath – here, the older
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)
now points you at
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md).
Read the message; it is doing you a favor.)

## Recipe 4: How did each player do in one game, one at a time?

**The story.** You want one player’s stat line from one game, broken out
into a tidy long table – not the whole `player_box`, just them.

This is one of the newer core-v2 endpoints, and its name is a little
sentence: a player’s *box* score for one *event*.

``` r

# espn / nba / event / player_box. "event" = one game; "player_box" =
# one athlete's line. You need the (event, team, athlete) trio because
# that's exactly what uniquely identifies "this player in this game."
kyle_anderson <- espn_nba_event_player_box(
  event_id   = 401283399,
  team_id    = 29,
  athlete_id = 2993874
)
```

Margin note on *why three IDs*: a function’s arguments are a hint about
its grain. One ID (`game_id`) gets you a whole game. Three IDs
(`event` + `team` + `athlete`) get you one cell of it. If a function
asks for more identifiers, it’s because it returns something more
specific – the arguments and the grain move together.

While you’re in event-detail land, the siblings all follow the pattern
`espn_nba_event_*`:

``` r

espn_nba_event_competitor_linescores(event_id = 401283399, team_id = 29)
#> # A tibble: 8 × 7
#>   league event_id  team_id period value display_value source      
#>   <chr>  <chr>     <chr>    <int> <dbl> <chr>         <chr>       
#> 1 nba    401283399 29           1    30 30            1           
#> 2 nba    401283399 29           1    30 30            Basic/Manual
#> 3 nba    401283399 29           2    27 27            1           
#> 4 nba    401283399 29           2    27 27            Basic/Manual
#> 5 nba    401283399 29           3    29 29            1           
#> 6 nba    401283399 29           3    29 29            Basic/Manual
#> 7 nba    401283399 29           4    36 36            1           
#> 8 nba    401283399 29           4    36 36            Basic/Manual
espn_nba_event_officials(event_id = 401283399)
#> # A tibble: 3 × 8
#>   event_id  official_id full_name   display_name position_id position_name
#>   <chr>     <chr>       <chr>       <chr>        <chr>       <chr>        
#> 1 401283399 6856        Eric Lewis  Eric Lewis   40          Referee      
#> 2 401283399 2612372     Jacyn Goble Jacyn Goble  40          Referee      
#> 3 401283399 4394825     Evan Scott  Evan Scott   40          Referee      
#> # ℹ 2 more variables: position_type <chr>, order <int>
espn_nba_event_play(event_id = 401283399, play_id = 4012833994)
#> # A tibble: 1 × 19
#>   league event_id  play_id    sequence_number type_id type_text text  short_text
#>   <chr>  <chr>     <chr>      <chr>           <chr>   <chr>     <chr> <chr>     
#> 1 nba    401283399 4012833994 4               615     Jumpball  Isai… NA        
#> # ℹ 11 more variables: period <int>, clock <chr>, scoring_play <lgl>,
#> #   score_value <dbl>, away_score <int>, home_score <int>, shooting_play <lgl>,
#> #   coordinate_x <dbl>, coordinate_y <dbl>, team_ref <chr>, wallclock <chr>
```

## Recipe 5: A team’s season at a glance

**The story.** You’re previewing a team and want the essentials –
record, schedule, roster, and how they actually stack up statistically.

Everything you need starts with `espn_nba_team`. Type that much and let
autocomplete show you the menu; the grammar guarantees the menu is
sensibly named.

``` r

team_id <- 13   # Los Angeles Lakers
season  <- most_recent_nba_season()

# The "season profile" is a hub -- it hands you $refs to everything
# else about this team-season.
profile <- espn_nba_team_season_profile(team_id = team_id, season = season)

espn_nba_team_schedule(team_id = team_id, season = season)
#> # A tibble: 82 × 21
#>    event_id  season season_type  week date          name  short_name opponent_id
#>    <chr>      <int>       <int> <int> <chr>         <chr> <chr>      <chr>      
#>  1 401809244   2026          NA    NA 2025-10-22T0… Gold… GS @ LAL   NA         
#>  2 401809951   2026          NA    NA 2025-10-25T0… Minn… MIN @ LAL  NA         
#>  3 401809968   2026          NA    NA 2025-10-27T0… Los … LAL @ SAC  NA         
#>  4 401809977   2026          NA    NA 2025-10-28T0… Port… POR @ LAL  NA         
#>  5 401809991   2026          NA    NA 2025-10-30T0… Los … LAL @ MIN  NA         
#>  6 401809506   2026          NA    NA 2025-11-01T0… Los … LAL @ MEM  NA         
#>  7 401810010   2026          NA    NA 2025-11-03T0… Miam… MIA @ LAL  NA         
#>  8 401810018   2026          NA    NA 2025-11-04T0… Los … LAL @ POR  NA         
#>  9 401810034   2026          NA    NA 2025-11-06T0… San … SA @ LAL   NA         
#> 10 401810040   2026          NA    NA 2025-11-09T0… Los … LAL @ ATL  NA         
#> # ℹ 72 more rows
#> # ℹ 13 more variables: opponent_abbrev <chr>, home_away <chr>,
#> #   neutral_site <lgl>, conference_competition <lgl>, venue_id <chr>,
#> #   venue_name <chr>, venue_city <chr>, venue_state <chr>, broadcast <chr>,
#> #   result <chr>, team_score <chr>, opponent_score <chr>, winner <lgl>
espn_nba_team_roster(team_id = team_id, season = season)
#> # A tibble: 17 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 4278129    Deandre … 5      C               Center        "7' 0… 252 l… 27   
#>  2 3945274    Luka Don… 77     G               Guard         "6' 8… 230 l… 27   
#>  3 4066648    Rui Hach… 28     F               Forward       "6' 8… 230 l… 28   
#>  4 4397077    Jaxson H… 11     C               Center        "7' 0… 220 l… 25   
#>  5 4683774    Bronny J… 9      G               Guard         "6' 2… 210 l… 21   
#>  6 1966       LeBron J… 23     F               Forward       "6' 9… 250 l… 41   
#>  7 3913174    Luke Ken… 10     G               Guard         "6' 5… 206 l… 29   
#>  8 2960236    Maxi Kle… 14     F               Forward       "6' 1… 240 l… 34   
#>  9 4897943    Dalton K… 4      F               Forward       "6' 6… 215 l… 25   
#> 10 4592691    Jake LaR… 12     F               Forward       "6' 7… 235 l… 24   
#> 11 4702972    Chris Ma… 30     G               Guard         "6' 4… 209 l… 24   
#> 12 4066457    Austin R… 15     G               Guard         "6' 5… 197 l… 27   
#> 13 2990992    Marcus S… 36     G               Guard         "6' 3… 220 l… 32   
#> 14 4683686    Nick Smi… 20     G               Guard         "6' 2… 185 l… 22   
#> 15 5060631    Adou Thi… 1      F               Forward       "6' 8… 220 l… 22   
#> 16 4431695    Drew Tim… 17     F               Forward       "6' 1… 235 l… 25   
#> 17 4278077    Jarred V… 2      F               Forward       "6' 8… 214 l… 27   
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>

# The full team-season stat sheet, with the team's league RANK baked
# into every row -- "team_season_statistics" is the long-format sheet,
# "team_record" is just the W-L.
espn_nba_team_season_statistics(team_id = team_id, season = season)
#> # A tibble: 109 × 13
#>    league season season_type team_id category_name category_display stat_name   
#>    <chr>   <int>       <int> <chr>   <chr>         <chr>            <chr>       
#>  1 nba      2026           2 13      defensive     Defensive        blocks      
#>  2 nba      2026           2 13      defensive     Defensive        defensiveRe…
#>  3 nba      2026           2 13      defensive     Defensive        steals      
#>  4 nba      2026           2 13      defensive     Defensive        turnoverPoi…
#>  5 nba      2026           2 13      defensive     Defensive        defReboundR…
#>  6 nba      2026           2 13      defensive     Defensive        avgDefensiv…
#>  7 nba      2026           2 13      defensive     Defensive        avgBlocks   
#>  8 nba      2026           2 13      defensive     Defensive        avgSteals   
#>  9 nba      2026           2 13      defensive     Defensive        avg48Defens…
#> 10 nba      2026           2 13      defensive     Defensive        avg48Blocks 
#> # ℹ 99 more rows
#> # ℹ 6 more variables: stat_abbrev <chr>, stat_display <chr>, value <dbl>,
#> #   display_value <chr>, rank <int>, rank_display_value <chr>
espn_nba_team_record(team_id = team_id, season = season)
#> # A tibble: 12 × 14
#>    league team_id season season_type record_id name    abbreviation display_name
#>    <chr>  <chr>    <int>       <int> <chr>     <chr>   <chr>        <chr>       
#>  1 nba    13        2026           2 0         overall Total        Overall     
#>  2 nba    13        2026           2 33        Home    NA           Home        
#>  3 nba    13        2026           2 34        Road    NA           Road        
#>  4 nba    13        2026           2 60        vs. Di… NA           DIV         
#>  5 nba    13        2026           2 61        vs. Co… NA           CONF        
#>  6 nba    13        2026           2 901       Last T… L10          Last Ten Ga…
#>  7 nba    13        2026           3 0         overall Total        Overall     
#>  8 nba    13        2026           3 33        Home    NA           Home        
#>  9 nba    13        2026           3 34        Road    NA           Road        
#> 10 nba    13        2026           3 60        vs. Di… NA           DIV         
#> 11 nba    13        2026           3 61        vs. Co… NA           CONF        
#> 12 nba    13        2026           3 901       Last T… L10          Last Ten Ga…
#> # ℹ 6 more variables: short_display_name <chr>, description <chr>, type <chr>,
#> #   summary <chr>, display_value <chr>, value <dbl>
```

Notice the family resemblance: `team_season_profile`,
`team_season_roster`, `team_season_statistics`. The shared middle
(`team_season`) is the subject; the last word is the lens. Find one
member of a family and you’ve found the whole family.

## Recipe 6: The MVP leaderboard race

**The story.** It’s March and you want the scoring, rebounding, and
assist leaders – the raw material of every MVP argument.

``` r

# NBA.com's leaders. Prefix `nba_` -> this is the official Stats API.
nba_leagueleaders(season = "2024-25", stat_category = "PTS")
#> $LeagueLeaders
#> # A tibble: 569 × 28
#>    PLAYER_ID RANK  PLAYER     TEAM_ID TEAM  GP    MIN   FGM   FGA   FG_PCT FG3M 
#>    <chr>     <chr> <chr>      <chr>   <chr> <chr> <chr> <chr> <chr> <chr>  <chr>
#>  1 1628983   1     Shai Gilg… 161061… OKC   76    2598  860   1656  0.519  163  
#>  2 1630162   2     Anthony E… 161061… MIN   79    2871  721   1612  0.447  320  
#>  3 203999    3     Nikola Jo… 161061… DEN   70    2571  786   1364  0.576  138  
#>  4 203507    4     Giannis A… 161061… MIL   67    2289  793   1319  0.601  14   
#>  5 1628369   5     Jayson Ta… 161061… BOS   72    2624  662   1465  0.452  250  
#>  6 1626164   6     Devin Boo… 161061… PHX   75    2795  654   1420  0.461  183  
#>  7 1629027   7     Trae Young 161061… ATL   76    2739  566   1376  0.411  218  
#>  8 1629639   8     Tyler Her… 161061… MIA   77    2725  651   1378  0.472  251  
#>  9 1630595   9     Cade Cunn… 161061… DET   70    2452  684   1457  0.469  149  
#> 10 201935    10    James Har… 161061… LAC   79    2789  531   1295  0.41   235  
#> # ℹ 559 more rows
#> # ℹ 17 more variables: FG3A <chr>, FG3_PCT <chr>, FTM <chr>, FTA <chr>,
#> #   FT_PCT <chr>, OREB <chr>, DREB <chr>, REB <chr>, AST <chr>, STL <chr>,
#> #   BLK <chr>, TOV <chr>, PF <chr>, PTS <chr>, EFF <chr>, AST_TOV <chr>,
#> #   STL_TOV <chr>

# ESPN's version of the same idea. Same question, different kitchen --
# and the prefix tells you which kitchen before you read another word.
espn_nba_leaders(season = most_recent_nba_season())
#> # A tibble: 400 × 11
#>    season season_type category      abbreviation athlete_id athlete_name team_id
#>     <int>       <int> <chr>         <chr>        <chr>      <chr>        <chr>  
#>  1   2026           2 pointsPerGame PTS          3945274    NA           13     
#>  2   2026           2 pointsPerGame PTS          4278073    NA           25     
#>  3   2026           2 pointsPerGame PTS          4594268    NA           16     
#>  4   2026           2 pointsPerGame PTS          3917376    NA           2      
#>  5   2026           2 pointsPerGame PTS          4431678    NA           20     
#>  6   2026           2 pointsPerGame PTS          6450       NA           12     
#>  7   2026           2 pointsPerGame PTS          3908809    NA           5      
#>  8   2026           2 pointsPerGame PTS          3112335    NA           7      
#>  9   2026           2 pointsPerGame PTS          3032977    NA           15     
#> 10   2026           2 pointsPerGame PTS          3059318    NA           20     
#> # ℹ 390 more rows
#> # ℹ 4 more variables: team_abbrev <chr>, value <dbl>, rank <int>,
#> #   display_value <chr>
```

If you ever forget whether leaders live under `nba_` or `espn_nba_`:
they live under *both*, because both APIs publish them. That’s normal.
The package mirrors the data sources honestly rather than papering one
over the other – so you choose based on which columns you want, not on
which name you happened to remember.

## Recipe 7: Tracking a draft class

**The story.** You want to follow a draft class – who went where, and in
what order.

The draft has a little family of its own, and the names sort from
general to specific exactly as the grammar promises:

``` r

season <- 2024

espn_nba_season_draft(season = season)        # the draft, top level
#> # A tibble: 1 × 10
#>   league season  year uid       number_of_rounds display_name short_display_name
#>   <chr>   <int> <int> <chr>                <int> <chr>        <chr>             
#> 1 nba      2024  2024 s:40~l:4…                2 2024 Nation… 2024 NBA Draft    
#> # ℹ 3 more variables: status_ref <chr>, athletes_ref <chr>, rounds_ref <chr>
espn_nba_draft_rounds(season = season)        # broken out by round
#> # A tibble: 2 × 7
#>   league season round display_name short_display_name n_picks status   
#>   <chr>   <int> <int> <chr>        <chr>                <int> <chr>    
#> 1 nba      2024     1 1st Round    1st                     30 COMPLETED
#> 2 nba      2024     2 2nd Round    2nd                     28 COMPLETED
espn_nba_draft_athletes(season = season)      # every drafted player
#> # A tibble: 102 × 4
#>    league season athlete_id ref                                                 
#>    <chr>   <int> <chr>      <chr>                                               
#>  1 nba      2024 108206     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  2 nba      2024 108204     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  3 nba      2024 108106     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  4 nba      2024 108231     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  5 nba      2024 108203     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  6 nba      2024 108107     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  7 nba      2024 108228     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  8 nba      2024 108142     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  9 nba      2024 108207     http://sports.core.api.espn.com/v2/sports/basketbal…
#> 10 nba      2024 108210     http://sports.core.api.espn.com/v2/sports/basketbal…
#> # ℹ 92 more rows
espn_nba_draft_athlete_detail(season = season, athlete_id = 108206)
#> # A tibble: 1 × 19
#>   league season draftee_id athlete_id first_name last_name full_name         
#>   <chr>   <int> <chr>      <chr>      <chr>      <chr>     <chr>             
#> 1 nba      2024 108206     5211175    Zaccharie  Risacher  Zaccharie Risacher
#> # ℹ 12 more variables: display_name <chr>, height <dbl>, display_height <chr>,
#> #   weight <dbl>, display_weight <chr>, position_name <chr>,
#> #   position_abbrev <chr>, pick_overall <int>, pick_round <int>,
#> #   pick_team_id <chr>, athlete_ref <chr>, headshot <chr>
espn_nba_draft_pick(season = season, round = 1, pick = 1)
#> # A tibble: 1 × 12
#>   league season round  pick overall traded trade_note status  athlete_id team_id
#>   <chr>   <int> <int> <int>   <int> <lgl>  <chr>      <chr>   <chr>      <chr>  
#> 1 nba      2024     1     1       1 FALSE  NA         SELECT… 108206     1      
#> # ℹ 2 more variables: athlete_ref <chr>, team_ref <chr>
```

Read that list top to bottom: `season_draft` -\> `draft_rounds` -\>
`draft_athletes` -\> `draft_athlete_detail` -\> `draft_pick`. Each step
adds a word and narrows the grain. That’s the grammar’s “general to
specific, left to right” rule made visible. When you find yourself
wanting something *between* two of these, the name you want is usually
*also* between them alphabetically and conceptually.

## Recipe 8: A whole season at once, the fast way

**The story.** You don’t want one game. You want *every* game – a full
season of play-by-play to model on.

Calling
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md)
in a loop over a thousand `game_id`s would work, and it would also be
slow and rude to ESPN’s servers. The `load_` prefix exists precisely for
this: pre-built, pre-cleaned season files.

``` r

# load / nba / pbp. One call, one season, ~600k rows.
pbp_2024 <- load_nba_pbp(seasons = 2024)

# The whole family loads the same way.
load_nba_player_box(seasons = 2024)
load_nba_team_box(seasons = 2024)
load_nba_schedule(seasons = 2024)
```

The grammar lesson: the `load_` prefix changes the *performance
contract*, not the subject.
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md)
and
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md)
both hand you play-by-play; the first hands you a whole season fast, the
second hands you one game live. Reach for `load_` when you’re doing
research across many games, and for `espn_` when you want one specific,
fresh game.

## Recipe 9: Pour it straight into a database

**The story.** A season of play-by-play is big. You’d rather not hold it
all in memory – you want it in a database you can query.

Every `load_` function takes the same optional plumbing arguments, and
once you’ve seen them once you’ve seen them everywhere:

``` r

library(DBI)
con <- dbConnect(RSQLite::SQLite(), "nba.sqlite")

# `dbConnection` + `tablename` -> write straight to disk while loading.
load_nba_pbp(
  seasons      = 2020:2024,
  dbConnection = con,
  tablename    = "nba_pbp"
)

dbDisconnect(con)
```

Margin note: consistency *is* a feature. Because every `load_` function
shares the `(seasons, ..., dbConnection, tablename)` signature, learning
one teaches you all of them. When a package keeps signatures parallel
like this, lean on it – guess the arguments the same way you guess the
names.

## Working through a proxy

If you’re on a corporate or campus network, your traffic may need to go
through a proxy. `hoopR` understands proxies in three layers, and you
should reach for the *least* invasive one that works.

**Layer 1 – set it once for the whole session.** This is what you want
99% of the time. It covers every function in the package – ESPN, NBA
Stats, KenPom, loaders, all of it.

``` r

# Plain proxy.
options(hoopR.proxy = "http://proxy.company.com:8080")

# Authenticated proxy -- pass a list and it's spread into the request.
options(hoopR.proxy = list(
  url      = "http://proxy.company.com",
  port     = 8080,
  username = "saiem",
  password = Sys.getenv("PROXY_PASS")
))

# From here on, nothing changes -- just call functions normally.
espn_nba_team_roster(team_id = 13, season = most_recent_nba_season())
nba_leagueleaders(season = "2024-25")
```

**Layer 2 – one call, one proxy.** Every NBA Stats API function
(`nba_*`) threads `...` down to the HTTP layer, so you can override the
proxy for a single call:

``` r

nba_leaguestandings(
  season = "2024-25",
  proxy  = "http://other-proxy.company.com:3128"
)
#> list()
```

A grammar-flavored caveat: per-call `proxy =` works for the `nba_*`
Stats API functions because they pass `...` through. The `espn_*`,
`kp_*`, and `load_*` functions don’t take a per-call proxy – for those,
use the session option in Layer 1. The prefix tells you the capability:
`nba_` functions are the ones wired for per-call overrides.

**Layer 3 – let the environment decide.** If you’d rather not put a
proxy in your R code at all, `hoopR` will honor the standard environment
variables:

``` r

Sys.setenv(
  http_proxy  = "http://proxy.company.com:8080",
  https_proxy = "http://proxy.company.com:8080",
  no_proxy    = "localhost,127.0.0.1"
)
```

These are read by libcurl automatically whenever you *haven’t* set an
explicit proxy. It’s the right layer for shared scripts and CI, where
the proxy is a property of the machine, not the analysis.

## Where to go next

You now have the grammar. Every recipe above was really the same trick:
decide where the data lives (the prefix), name the league, then name the
thing from general to specific. The NBA surface in `hoopR` is large, but
it is *regular* – and regular things are guessable.

When you want the men’s college game, the same grammar carries over
almost unchanged – swap `nba` for `mbb`, meet a new prefix (`kp_` for
KenPom), and keep cooking. That’s the MBB cookbook.
