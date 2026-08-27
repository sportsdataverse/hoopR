# Men's College Basketball Cookbook

### Before we cook

Men’s college basketball is a sprawl – 360-odd Division I teams, a month
of March that decides everything, and a stats culture built as much on
tempo-free efficiency as on raw box scores. `hoopR` covers all of it,
and the trick to not drowning is the same as in the NBA cookbook:
**learn the grammar of the function names and you can guess your way to
almost anything.**

If you’ve read the NBA cookbook, you already know most of the grammar.
This one adds one new prefix – `kp_` for KenPom – and swaps the league
token from `nba` to `mbb`. That’s nearly the whole diff.

#### The grammar, refreshed for college

A `hoopR` college function answers three questions in order:

1.  **Where’s the data from?** – the prefix.
    - `espn_` – ESPN’s APIs. The broad, stable backbone.
    - `kp_` – KenPom (kenpom.com). Tempo-free efficiency, the lingua
      franca of college analytics. **Requires a KenPom subscription.**
    - `load_` – pre-built bulk season files.
2.  **Which league?** – for ESPN it’s spelled out: `espn_mbb_`. The
    `mbb` token is “men’s basketball.” (KenPom is men’s-college-only, so
    `kp_` functions don’t need a league token – the prefix already
    implies it.)
3.  **What do you want?** – the rest of the name, general to specific.

So “a team’s schedule from ESPN” is `espn_` + `mbb_` + `team_schedule`
-\>
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md).
“KenPom’s efficiency ratings” is `kp_` + `efficiency` -\>
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md).
You will be right far more often than you’ll be wrong, and being wrong
just means opening the reference index.

``` r

library(hoopR)
library(dplyr)
```

### Recipe 1: A blue-blood program’s season

**The story.** It’s November and you want to set the table for Duke’s
season – schedule, roster, and where they sit.

Type `espn_mbb_team` and the grammar lays out the menu for you:

``` r

team_id <- 150            # Duke
season  <- most_recent_mbb_season()

espn_mbb_team(team_id = team_id)                              # identity + record
#> $Info
#> # A tibble: 1 × 13
#>   id    uid    slug  abbreviation display_name short_display_name name  nickname
#>   <chr> <chr>  <chr> <chr>        <chr>        <chr>              <chr> <chr>   
#> 1 150   s:40~… duke… DUKE         Duke Blue D… Duke               Blue… Duke    
#> # ℹ 5 more variables: location <chr>, color <chr>, alternate_color <chr>,
#> #   logo <chr>, logo_dark <chr>
#> 
#> $Record
#> data frame with 0 columns and 0 rows
#> 
#> $NextEvent
#> # A tibble: 1 × 4
#>   id        date              name                                   short_name 
#>   <chr>     <chr>             <chr>                                  <chr>      
#> 1 401909562 2026-11-02T05:00Z Army Black Knights at Duke Blue Devils ARMY @ DUKE
#> 
#> $StandingSummary
#> # A tibble: 1 × 1
#>   standing_summary
#>   <chr>           
#> 1 1st in ACC      
#> 
#> $Coaches
#> data frame with 0 columns and 0 rows
espn_mbb_team_schedule(team_id = team_id, season = season)    # the slate
#> # A tibble: 34 × 21
#>    event_id  season season_type  week date          name  short_name opponent_id
#>    <chr>      <int>       <int> <int> <chr>         <chr> <chr>      <chr>      
#>  1 401817228   2026          NA     1 2025-11-05T0… Texa… TEX VS DU… NA         
#>  2 401817229   2026          NA     1 2025-11-08T1… West… WCU @ DUKE NA         
#>  3 401817230   2026          NA     2 2025-11-12T0… Duke… DUKE @ AR… NA         
#>  4 401817231   2026          NA     2 2025-11-15T0… Indi… INST @ DU… NA         
#>  5 401817232   2026          NA     3 2025-11-19T0… Kans… KU VS DUKE NA         
#>  6 401813377   2026          NA     3 2025-11-22T0… Niag… NIA @ DUKE NA         
#>  7 401817233   2026          NA     3 2025-11-23T2… Howa… HOW @ DUKE NA         
#>  8 401817234   2026          NA     4 2025-11-28T0… Duke… DUKE VS A… NA         
#>  9 401806364   2026          NA     5 2025-12-03T0… Flor… FLA @ DUKE NA         
#> 10 401817235   2026          NA     5 2025-12-06T1… Duke… DUKE @ MSU NA         
#> # ℹ 24 more rows
#> # ℹ 13 more variables: opponent_abbrev <chr>, home_away <chr>,
#> #   neutral_site <lgl>, conference_competition <lgl>, venue_id <chr>,
#> #   venue_name <chr>, venue_city <chr>, venue_state <chr>, broadcast <chr>,
#> #   result <chr>, team_score <chr>, opponent_score <chr>, winner <lgl>
espn_mbb_team_roster(team_id = team_id, season = season)      # the players
#> # A tibble: 11 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 5041937    Cayden B… 2      G               Guard         "6' 4… 205 l… NA   
#>  2 5341547    Brock Da… 50     G               Guard         "6' 4… 195 l… NA   
#>  3 4711256    Caleb Fo… 1      G               Guard         "6' 5… 205 l… NA   
#>  4 4873107    Darren H… 8      G               Guard         "6' 5… 195 l… NA   
#>  5 5144124    Nikolas … 14     G               Guard         "6' 8… 215 l… NA   
#>  6 4873209    Patrick … 21     C               Center        "6' 1… 250 l… NA   
#>  7 5287474    Dame Sarr 7      G               Guard         "6' 8… 190 l… NA   
#>  8 4888720    Jack Sco… 20     G               Guard         "6' 6… 220 l… NA   
#>  9 4432321    Cameron … 13     G               Guard         "6' 6… 205 l… NA   
#> 10 5107141    Ifeanyi … 15     C               Center        "6' 1… 240 l… NA   
#> 11 5144150    Sebastia… 5      G               Guard         "6' 8… 220 l… NA   
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>
espn_mbb_team_season_statistics(team_id = team_id, season = season)
#> # A tibble: 77 × 13
#>    league    season season_type team_id category_name category_display stat_name
#>    <chr>      <int>       <int> <chr>   <chr>         <chr>            <chr>    
#>  1 mens-col…   2026           2 150     defensive     Defensive        blocks   
#>  2 mens-col…   2026           2 150     defensive     Defensive        defensiv…
#>  3 mens-col…   2026           2 150     defensive     Defensive        steals   
#>  4 mens-col…   2026           2 150     defensive     Defensive        turnover…
#>  5 mens-col…   2026           2 150     defensive     Defensive        avgDefen…
#>  6 mens-col…   2026           2 150     defensive     Defensive        avgBlocks
#>  7 mens-col…   2026           2 150     defensive     Defensive        avgSteals
#>  8 mens-col…   2026           2 150     general       General          disquali…
#>  9 mens-col…   2026           2 150     general       General          flagrant…
#> 10 mens-col…   2026           2 150     general       General          fouls    
#> # ℹ 67 more rows
#> # ℹ 6 more variables: stat_abbrev <chr>, stat_display <chr>, value <dbl>,
#> #   display_value <chr>, rank <int>, rank_display_value <chr>
```

The
[`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md)
helper is worth a margin note. Every league in `hoopR` has a
`most_recent_<league>_season()` companion, and the new `espn_mbb_*`
functions use it as their default `season` argument. So most of the time
you can simply *omit* `season` and get the current year – the function
already knows what “now” means.

### Recipe 2: The freshman phenom

**The story.** Every college season has a one-and-done freshman everyone
argues about. You want that player’s numbers.

College players turn over fast – this year’s phenom is next year’s pro –
so the reliable move is to pull the current roster first and lift an
`athlete_id` straight off it, then walk the `athlete_` family:

``` r

roster     <- espn_mbb_team_roster(team_id = 150, season = most_recent_mbb_season())
athlete_id <- roster$athlete_id[1]   # whoever is first on the roster

espn_mbb_player_info(athlete_id = athlete_id)            # bio
#> $Bio
#> # A tibble: 1 × 18
#>   id      uid       guid  first_name last_name full_name display_name short_name
#>   <chr>   <chr>     <chr> <chr>      <chr>     <chr>     <chr>        <chr>     
#> 1 5041937 s:40~l:4… 609b… Cayden     Boozer    Cayden B… Cayden Booz… C. Boozer 
#> # ℹ 10 more variables: weight <dbl>, display_weight <chr>, height <dbl>,
#> #   display_height <chr>, jersey <chr>, active <lgl>, headshot_href <chr>,
#> #   birth_city <chr>, birth_state <chr>, birth_country <chr>
#> 
#> $Team
#> # A tibble: 1 × 1
#>   x_ref                                                                         
#>   <chr>                                                                         
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-bas…
#> 
#> $Position
#> # A tibble: 1 × 5
#>   id    name  display_name abbreviation leaf 
#>   <chr> <chr> <chr>        <chr>        <lgl>
#> 1 3     Guard Guard        G            FALSE
#> 
#> $Status
#> # A tibble: 1 × 4
#>   id    name   type   abbreviation
#>   <chr> <chr>  <chr>  <chr>       
#> 1 1     Active active Active      
#> 
#> $College
#> # A tibble: 0 × 0
#> 
#> $Draft
#> # A tibble: 0 × 0
espn_mbb_player_gamelog(athlete_id = athlete_id, season = most_recent_mbb_season())
#> # A tibble: 38 × 26
#>    id        at_vs game_date     score home_team_id away_team_id home_team_score
#>    <chr>     <chr> <chr>         <chr> <chr>        <chr>        <chr>          
#>  1 401856577 vs    2026-03-29T2… 73-72 150          41           72             
#>  2 401856570 vs    2026-03-27T2… 80-75 150          2599         80             
#>  3 401856530 vs    2026-03-21T2… 81-58 150          2628         81             
#>  4 401856478 vs    2026-03-19T1… 71-65 150          2561         71             
#>  5 401851183 vs    2026-03-15T0… 74-70 150          258          74             
#>  6 401851182 vs    2026-03-14T0… 73-61 150          228          73             
#>  7 401851179 vs    2026-03-12T2… 80-79 150          52           80             
#>  8 401820788 vs    2026-03-07T2… 76-61 150          153          76             
#>  9 401820778 @     2026-03-03T0… 93-64 152          150          64             
#> 10 401820771 vs    2026-02-28T1… 77-51 150          258          77             
#> # ℹ 28 more rows
#> # ℹ 19 more variables: away_team_score <chr>, game_result <chr>,
#> #   league_name <chr>, league_abbreviation <chr>, league_short_name <chr>,
#> #   event_note <chr>, team_id <chr>, team_uid <chr>, team_abbreviation <chr>,
#> #   team_logo <chr>, team_is_all_star <chr>, opponent_id <chr>,
#> #   opponent_uid <chr>, opponent_display_name <chr>,
#> #   opponent_abbreviation <chr>, opponent_logo <chr>, opponent_rank <chr>, …
espn_mbb_player_career_stats(athlete_id = athlete_id)    # career rollup, long format
#> # A tibble: 87 × 17
#>    league   athlete_id stat_type_id split_id split_name split_type category_name
#>    <chr>    <chr>      <chr>        <chr>    <chr>      <chr>      <chr>        
#>  1 mens-co… 5041937    0            0        Season     season     defensive    
#>  2 mens-co… 5041937    0            0        Season     season     defensive    
#>  3 mens-co… 5041937    0            0        Season     season     defensive    
#>  4 mens-co… 5041937    0            0        Season     season     defensive    
#>  5 mens-co… 5041937    0            0        Season     season     defensive    
#>  6 mens-co… 5041937    0            0        Season     season     defensive    
#>  7 mens-co… 5041937    0            0        Season     season     defensive    
#>  8 mens-co… 5041937    0            0        Season     season     defensive    
#>  9 mens-co… 5041937    0            0        Season     season     general      
#> 10 mens-co… 5041937    0            0        Season     season     general      
#> # ℹ 77 more rows
#> # ℹ 10 more variables: category_display <chr>, category_short <chr>,
#> #   category_abbrev <chr>, stat_name <chr>, stat_abbrev <chr>,
#> #   stat_display <chr>, stat_short <chr>, description <chr>, value <dbl>,
#> #   display_value <chr>
```

That “pull the index, lift an ID, drill down” move is the single most
useful habit in the whole package. `athlete_gamelog` in particular only
has data for players *currently* on a roster – last year’s star has
moved on – so feeding it an ID you just lifted off `team_roster` is how
you guarantee it returns something.

Margin note: `athlete_info`, `athlete_gamelog`, `athlete_career_stats`
all share the `athlete_` stem. When a stem repeats across many
functions, that stem is a *namespace* – a promise that everything under
it is about the same subject. Browsing by stem (`espn_mbb_athlete` +
Tab) is often faster than searching.

### Recipe 3: Tempo-free, the KenPom way

**The story.** Box scores lie a little in college – a team that plays
fast will pile up points without being good. You want *efficiency*:
points per possession, not per game. That’s KenPom’s whole reason to
exist.

This is where the new prefix earns its keep. Everything KenPom is `kp_`.

``` r

# KenPom needs a subscription. Log in once per session.
kp_user_email <- "you@example.com"
kp_password   <- Sys.getenv("KP_PASSWORD")

# The famous Pomeroy ratings -- adjusted efficiency for every team.
kp_pomeroy_ratings(min_year = 2024, max_year = 2025)

# The four factors: shooting, turnovers, rebounding, free throws.
kp_fourfactors(min_year = 2025, max_year = 2025)

# Raw adjusted-efficiency table.
kp_efficiency(min_year = 2025, max_year = 2025)
```

The grammar lesson here is about *prefixes as capabilities*. The moment
you see `kp_`, three things are implied without another word: the data
is men’s-college-only, it is tempo-free, and it needs authentication. A
prefix is a compressed paragraph. Learn what each prefix promises and
half the documentation becomes redundant.

KenPom’s own family is deep – and, of course, regular:

``` r

kp_team_schedule(team = "Duke", year = 2025)
kp_teamstats(min_year = 2025, max_year = 2025)
kp_playerstats(metric = "eFG", year = 2025)
kp_kpoy(year = 2025)         # KenPom Player of the Year race
kp_fanmatch(date = "2025-02-01")   # every game on a date, win probs attached
```

### Recipe 4: Game flow without the bracket pressure

**The story.** A January road game went to overtime. You want the play-
by-play and a sense of the swing.

Same three zoom levels as the NBA cookbook – the grammar is
league-agnostic:

``` r

game_id <- 401256760

espn_mbb_game_all(game_id = game_id)      # everything, as a named list
#> $Plays
#> # A tibble: 353 × 48
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4012567… 101805901       M.J.…          0          0 FALSE                  3
#>  2 4012567… 101806301       RaiQ…          0          0 FALSE                  0
#>  3 4012567… 101806302       RaiQ…          0          2 TRUE                   2
#>  4 4012567… 101808801       Scot…          0          2 FALSE                  2
#>  5 4012567… 101809001       Bals…          0          2 FALSE                  0
#>  6 4012567… 101814501       Bals…          0          2 FALSE                  2
#>  7 4012567… 101814502       Flor…          0          2 FALSE                  0
#>  8 4012567… 101817001       Tre …          3          2 TRUE                   3
#>  9 4012567… 101818201       RaiQ…          3          2 FALSE                  0
#> 10 4012567… 101818202       Tre …          3          2 FALSE                  0
#> # ℹ 343 more rows
#> # ℹ 41 more variables: shooting_play <lgl>, points_attempted <int>,
#> #   short_description <chr>, type_id <int>, type_text <chr>,
#> #   period_number <int>, period_display_value <chr>, clock_display_value <chr>,
#> #   team_id <int>, play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>,
#> #   home_team_id <int>, home_team_mascot <chr>, home_team_name <chr>,
#> #   home_team_abbrev <chr>, home_team_logo <chr>, home_team_logo_dark <chr>, …
#> 
#> $Team
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401256760   2021           2 2020-12-12 2020-12-12 11:00:00      57 s:40~l:41…
#> 2 401256760   2021           2 2020-12-12 2020-12-12 11:00:00      52 s:40~l:41…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
#> 
#> $Player
#> # A tibble: 34 × 54
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4395714
#>  2 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4397204
#>  3 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4432819
#>  4 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4432812
#>  5 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4395713
#>  6 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4702251
#>  7 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4432825
#>  8 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4279008
#>  9 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4592827
#> 10 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4565449
#> # ℹ 24 more rows
#> # ℹ 48 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
espn_mbb_team_box(game_id = game_id)      # team box
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401256760   2021           2 2020-12-12 2020-12-12 11:00:00      57 s:40~l:41…
#> 2 401256760   2021           2 2020-12-12 2020-12-12 11:00:00      52 s:40~l:41…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
espn_mbb_player_box(game_id = game_id)    # player box
#> # A tibble: 34 × 54
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4395714
#>  2 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4397204
#>  3 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4432819
#>  4 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4432812
#>  5 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4395713
#>  6 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4702251
#>  7 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4432825
#>  8 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4279008
#>  9 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4592827
#> 10 401256760   2021           2 2020-12-12 2020-12-12 11:00:00    4565449
#> # ℹ 24 more rows
#> # ℹ 48 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
espn_mbb_pbp(game_id = game_id)           # play-by-play
#> # A tibble: 353 × 48
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4012567… 101805901       M.J.…          0          0 FALSE                  3
#>  2 4012567… 101806301       RaiQ…          0          0 FALSE                  0
#>  3 4012567… 101806302       RaiQ…          0          2 TRUE                   2
#>  4 4012567… 101808801       Scot…          0          2 FALSE                  2
#>  5 4012567… 101809001       Bals…          0          2 FALSE                  0
#>  6 4012567… 101814501       Bals…          0          2 FALSE                  2
#>  7 4012567… 101814502       Flor…          0          2 FALSE                  0
#>  8 4012567… 101817001       Tre …          3          2 TRUE                   3
#>  9 4012567… 101818201       RaiQ…          3          2 FALSE                  0
#> 10 4012567… 101818202       Tre …          3          2 FALSE                  0
#> # ℹ 343 more rows
#> # ℹ 41 more variables: shooting_play <lgl>, points_attempted <int>,
#> #   short_description <chr>, type_id <int>, type_text <chr>,
#> #   period_number <int>, period_display_value <chr>, clock_display_value <chr>,
#> #   team_id <int>, play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>,
#> #   home_team_id <int>, home_team_mascot <chr>, home_team_name <chr>,
#> #   home_team_abbrev <chr>, home_team_logo <chr>, home_team_logo_dark <chr>, …

# ESPN's win-probability-per-play for the same game.
espn_mbb_game_probabilities(event_id = game_id)
#> # A tibble: 200 × 10
#>    event_id  sequence_number play_id period clock home_win_percentage
#>    <chr>     <chr>           <chr>    <int> <chr>               <dbl>
#>  1 401256760 101805901       NA          NA NA                  0.413
#>  2 401256760 101806301       NA          NA NA                  0.431
#>  3 401256760 101806302       NA          NA NA                  0.458
#>  4 401256760 101808801       NA          NA NA                  0.482
#>  5 401256760 101809001       NA          NA NA                  0.489
#>  6 401256760 101814501       NA          NA NA                  0.467
#>  7 401256760 101814502       NA          NA NA                  0.459
#>  8 401256760 101817001       NA          NA NA                  0.409
#>  9 401256760 101818201       NA          NA NA                  0.387
#> 10 401256760 101818202       NA          NA NA                  0.387
#> # ℹ 190 more rows
#> # ℹ 4 more variables: away_win_percentage <dbl>, tie_percentage <dbl>,
#> #   secs_to_end_of_period <dbl>, secs_to_end_of_game <dbl>
```

If you read the NBA cookbook, you’ve now seen `espn_*_game_all`,
`espn_*_team_box`, `espn_*_player_box`, `espn_*_pbp` in two leagues with
*only the league token changing*. That’s the payoff of a regular
grammar: a recipe you learned for the NBA transfers to college by
editing one word.

### Recipe 5: Per-player, per-game box scores

**The story.** You want a single player’s line from a single game, tidy
and long – not the whole `player_box`.

``` r

# event + team + athlete -- three IDs, because you're naming one cell
# of one game. (More identifiers = finer grain. Always.)
espn_mbb_game_player_box(
  event_id   = 401256760,
  team_id    = 52,
  athlete_id = 4277850
)
#> # A tibble: 77 × 12
#>    league   event_id team_id athlete_id stat_type category_name category_display
#>    <chr>    <chr>    <chr>   <chr>          <int> <chr>         <chr>           
#>  1 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  2 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  3 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  4 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  5 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  6 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  7 mens-co… 4012567… 52      4277850            0 defensive     Defensive       
#>  8 mens-co… 4012567… 52      4277850            0 general       General         
#>  9 mens-co… 4012567… 52      4277850            0 general       General         
#> 10 mens-co… 4012567… 52      4277850            0 general       General         
#> # ℹ 67 more rows
#> # ℹ 5 more variables: stat_name <chr>, stat_abbrev <chr>, stat_display <chr>,
#> #   value <dbl>, display_value <chr>
```

### Recipe 6: The conference race

**The story.** It’s February and your league is a three-team knife
fight. You want the standings and the structure underneath them.

College conferences are a *hierarchy* – divisions, conferences, the
whole D-I grouping – and ESPN models that hierarchy with the
`season_group` family.

``` r

season <- most_recent_mbb_season()

# A grammar gotcha worth flagging: espn_mbb_standings() takes `year`,
# not `season`. Most functions say `season`, a few older ones say
# `year` -- when an argument name surprises you, ?function is the
# two-second fix.
espn_mbb_standings(year = season)
#> # A tibble: 365 × 87
#>    team_id team             conference avgpointsagainst avgpointsfor gamesbehind
#>      <int> <chr>            <chr>                 <dbl>        <dbl>       <dbl>
#>  1    2378 UMBC Retrievers  America E…             67.6         76.4         0  
#>  2     261 Vermont Catamou… America E…             68.5         73.4         2.5
#>  3    2885 NJIT Highlanders America E…             73.2         67.0         8  
#>  4    2349 UMass Lowell Ri… America E…             76.3         74.9         9  
#>  5     399 UAlbany Great D… America E…             72.9         72.0        12.5
#>  6     160 New Hampshire W… America E…             74.6         69.2        13.5
#>  7    2803 Bryant Bulldogs  America E…             72.5         64.8        14  
#>  8    2066 Binghamton Bear… America E…             74.9         67.9        15  
#>  9     311 Maine Black Bea… America E…             68.4         62.5        15.5
#> 10     202 Tulsa Golden Hu… American …             73.7         85.1         0  
#> # ℹ 355 more rows
#> # ℹ 81 more variables: leaguewinpercent <dbl>, losses <dbl>, playoffseed <dbl>,
#> #   pointdifferential <chr>, pointsagainst <dbl>, pointsfor <dbl>,
#> #   streak <dbl>, winpercent <dbl>, wins <dbl>, gamesahead <chr>, total <chr>,
#> #   home_avgpointsagainst <dbl>, home_avgpointsfor <dbl>,
#> #   home_gamesbehind <dbl>, home_leaguewinpercent <dbl>, home_losses <dbl>,
#> #   home_playoffseed <dbl>, home_pointdifferential <chr>, …

# The group tree: groups -> one group -> its teams.
espn_mbb_season_groups(season = season, season_type = 2)
#> # A tibble: 2 × 5
#>   league                  season season_type group_id ref                       
#>   <chr>                    <int>       <int> <chr>    <chr>                     
#> 1 mens-college-basketball   2026           2 50       http://sports.core.api.es…
#> 2 mens-college-basketball   2026           2 51       http://sports.core.api.es…
espn_mbb_season_group(group_id = 50, season = season, season_type = 2)
#> # A tibble: 1 × 15
#>   league         season season_type group_id uid   name  abbreviation short_name
#>   <chr>           <int>       <int> <chr>    <chr> <chr> <chr>        <chr>     
#> 1 mens-college-…   2026           2 50       s:40… NCAA… NCAA         Division I
#> # ℹ 7 more variables: midsize_name <chr>, is_conference <lgl>, slug <chr>,
#> #   parent_ref <chr>, children_ref <chr>, teams_ref <chr>, standings_ref <chr>
espn_mbb_season_group_teams(group_id = 50, season = season, season_type = 2)
#> # A tibble: 200 × 6
#>    league                  season season_type group_id team_id ref              
#>    <chr>                    <int>       <int> <chr>    <chr>   <chr>            
#>  1 mens-college-basketball   2026           2 50       2       http://sports.co…
#>  2 mens-college-basketball   2026           2 50       5       http://sports.co…
#>  3 mens-college-basketball   2026           2 50       6       http://sports.co…
#>  4 mens-college-basketball   2026           2 50       8       http://sports.co…
#>  5 mens-college-basketball   2026           2 50       9       http://sports.co…
#>  6 mens-college-basketball   2026           2 50       12      http://sports.co…
#>  7 mens-college-basketball   2026           2 50       13      http://sports.co…
#>  8 mens-college-basketball   2026           2 50       16      http://sports.co…
#>  9 mens-college-basketball   2026           2 50       21      http://sports.co…
#> 10 mens-college-basketball   2026           2 50       23      http://sports.co…
#> # ℹ 190 more rows
```

Margin note: `season_groups` (plural) is the index; `season_group`
(singular) is one item. That singular/plural pair shows up all over the
package – `franchises`/`franchise`, `tournaments`/`tournament`,
`positions`/`position`. Plural = “give me the list,” singular = “give me
this one.” It’s the most reliable two-word rule in the whole grammar.

### Recipe 7: March

**The story.** It’s the only story in college basketball. You want the
tournament.

``` r

season <- most_recent_mbb_season()

espn_mbb_tournaments()                                  # which tournaments exist
#> # A tibble: 38 × 3
#>    tournament_id ref                                                      league
#>    <chr>         <chr>                                                    <chr> 
#>  1 3             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  2 1             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  3 39            http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  4 2             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  5 4             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  6 5             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  7 6             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  8 7             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  9 8             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#> 10 9             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#> # ℹ 28 more rows
espn_mbb_tournament(tournament_id = 3)                  # one tournament
#> # A tibble: 1 × 4
#>   tournament_id display_name                   seasons_ref                league
#>   <chr>         <chr>                          <chr>                      <chr> 
#> 1 3             Atlantic Coast Conf Tournament http://sports.core.api.es… mens-…
espn_mbb_tournament_seasons(tournament_id = 3)          # its yearly editions
#> # A tibble: 14 × 4
#>    league                  tournament_id season ref                             
#>    <chr>                   <chr>          <int> <chr>                           
#>  1 mens-college-basketball 3               2009 http://sports.core.api.espn.com…
#>  2 mens-college-basketball 3               2010 http://sports.core.api.espn.com…
#>  3 mens-college-basketball 3               2011 http://sports.core.api.espn.com…
#>  4 mens-college-basketball 3               2012 http://sports.core.api.espn.com…
#>  5 mens-college-basketball 3               2013 http://sports.core.api.espn.com…
#>  6 mens-college-basketball 3               2014 http://sports.core.api.espn.com…
#>  7 mens-college-basketball 3               2015 http://sports.core.api.espn.com…
#>  8 mens-college-basketball 3               2016 http://sports.core.api.espn.com…
#>  9 mens-college-basketball 3               2017 http://sports.core.api.espn.com…
#> 10 mens-college-basketball 3               2018 http://sports.core.api.espn.com…
#> 11 mens-college-basketball 3               2019 http://sports.core.api.espn.com…
#> 12 mens-college-basketball 3               2020 http://sports.core.api.espn.com…
#> 13 mens-college-basketball 3               2022 http://sports.core.api.espn.com…
#> 14 mens-college-basketball 3               2023 http://sports.core.api.espn.com…
espn_mbb_tournament_season(tournament_id = 3, season = season)
#> # A tibble: 1 × 8
#>   league   tournament_id season display_name short_display_name number_of_rounds
#>   <chr>    <chr>          <int> <chr>        <chr>                         <int>
#> 1 mens-co… 3               2026 ACC Tournam… ACC                               0
#> # ℹ 2 more variables: season_ref <chr>, bracketology_ref <chr>
```

Same singular/plural rule as Recipe 6, same general-to-specific march
from `tournaments` down to one `tournament_season`. By now you should be
able to *predict* this family before you read it – which is the entire
point of the cookbook.

### Recipe 8: A whole season, in bulk

**The story.** You’re done with single games. You want every college
game of a season to model on.

``` r

# load / mbb / pbp -- one call, one season.
pbp <- load_mbb_pbp(seasons = 2024)

load_mbb_player_box(seasons = 2024)
load_mbb_team_box(seasons = 2024)
load_mbb_schedule(seasons = 2024)
```

And straight into a database, with the same
`(seasons, dbConnection, tablename)` plumbing every `load_` function
shares:

``` r

library(DBI)
con <- dbConnect(RSQLite::SQLite(), "mbb.sqlite")
load_mbb_pbp(seasons = 2020:2024, dbConnection = con, tablename = "mbb_pbp")
dbDisconnect(con)
```

### Working through a proxy

Campus networks love a proxy. `hoopR` handles them in three layers –
reach for the least invasive one that works.

**Layer 1 – set it once for the session.** Covers everything: ESPN,
KenPom, loaders.

``` r

options(hoopR.proxy = "http://proxy.university.edu:8080")

# Authenticated proxy? Pass a list instead of a string.
options(hoopR.proxy = list(
  url      = "http://proxy.university.edu",
  port     = 8080,
  username = "netid",
  password = Sys.getenv("PROXY_PASS")
))

# Then just work -- every call inherits it.
espn_mbb_team_roster(team_id = 150, season = most_recent_mbb_season())
kp_pomeroy_ratings(min_year = 2025, max_year = 2025)
```

**Layer 2 – environment variables.** For shared scripts and CI, where
the proxy belongs to the machine and not the analysis, set the standard
variables and let libcurl pick them up:

``` r

Sys.setenv(
  http_proxy  = "http://proxy.university.edu:8080",
  https_proxy = "http://proxy.university.edu:8080",
  no_proxy    = "localhost,127.0.0.1"
)
```

A grammar-flavored note on what *doesn’t* take a per-call `proxy =`
argument: the `espn_*`, `kp_*`, and `load_*` functions all call the HTTP
layer directly, so they read the proxy from the session option or the
environment – not from an argument. (In the NBA cookbook, the `nba_*`
Stats API functions *do* accept per-call `proxy =`, because they thread
`...` through. College basketball has no equivalent NBA-Stats-style
surface, so for `mbb` you’ll use Layer 1 or Layer 2 every time.) The
prefix, once again, tells you the capability before you go looking.

### Where to go next

The college game has more teams, a deeper conference hierarchy, and the
`kp_` prefix – but the grammar is identical to the NBA’s. You decided
where the data lived, you named the league, you named the thing from
general to specific, and you let the singular/plural rule and the shared
stems carry you the rest of the way.

The women’s game runs on `wehoop`, a sibling package with the exact same
grammar. `espn_mbb_team_roster` has a mirror image in
`espn_wbb_team_roster`; everything you just learned crosses straight
over. That’s the WBB cookbook.

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
