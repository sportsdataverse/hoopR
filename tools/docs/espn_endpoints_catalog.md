# ESPN Endpoint Reference (Basketball)

Reference for the ESPN API endpoints surfaced by `hoopR`'s `espn_*` wrappers and probed by `tools/docs/mine_api_descriptions.R`. Scoped to the four basketball leagues `hoopR` + `wehoop` cover. Maintained inside `tools/docs/` so it's available at build time but excluded from the package via `.Rbuildignore`.

## League slugs

| League | `hoopR` league slug | `wehoop` league slug |
|---|---|---|
| NBA | `nba` | — |
| Men's college basketball | `mens-college-basketball` | — |
| WNBA | — | `wnba` |
| Women's college basketball | — | `womens-college-basketball` |

## ESPN API hosts

ESPN exposes basketball data through three independent API hosts; hoopR and wehoop wrap endpoints from all three. Each host has its own URL convention, authentication model (none, in practice), and response schema style.

| Host | URL pattern | Used for |
|---|---|---|
| **Site v2** | `https://site.api.espn.com/apis/site/v2/sports/basketball/{league}/{resource}` | Scoreboard, schedule, teams, news, calendar, league injuries |
| **Web common v3** | `https://site.web.api.espn.com/apis/common/v3/sports/basketball/{league}/{resource}` | Athlete stats / splits / gamelog / overview, leaderboards |
| **Core v2** | `https://sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/{resource}` | Events, athletes, seasons, statistics, odds, draft |

## Site v2

### Scoreboard, schedule, summary

| Resource | Description |
|---|---|
| `scoreboard` | Live + scheduled events with scores. |
| `scoreboard?dates={YYYYMMDD}` | Scores for a specific date. |
| `scoreboard?dates={YYYYMMDD}-{YYYYMMDD}` | Scores for a date range. |
| `summary?event={id}` | Full game summary: boxscore, plays, leaders, broadcasts. |
| `calendar` | Full season calendar. |
| `calendar/offseason` | Offseason date range. |
| `calendar/regular-season` | Regular season weeks/dates. |
| `calendar/postseason` | Postseason date ranges. |

### Teams

| Resource | Description |
|---|---|
| `teams` | All teams in the league. |
| `teams/{id}` | Single team detail. |
| `teams/{id}/roster` | Team roster with athlete details. |
| `teams/{id}/schedule` | Team schedule. |
| `teams/{id}/record` | Team win/loss record. |
| `teams/{id}/depthcharts` | Depth chart by position (sparse for basketball). |
| `teams/{id}/injuries` | Team injury report. |
| `teams/{id}/transactions` | Recent team transactions. |
| `teams/{id}/history` | Franchise historical record. |
| `teams/{id}/news` | Team news feed. |
| `teams/{id}/leaders` | Team statistical leaders. |

### Athletes (site v2)

| Resource | Description |
|---|---|
| `athletes/{id}` | Athlete profile. |
| `athletes/{id}/gamelog` | Game-by-game log (lightweight site-v2 variant). |
| `athletes/{id}/splits` | Statistical splits (lightweight site-v2 variant). |
| `athletes/{id}/news` | Athlete news. |
| `athletes/{id}/bio` | Athlete bio. |

### League-wide

| Resource | Description |
|---|---|
| `injuries` | League-wide injury report (all teams). |
| `transactions` | League-wide signings, trades, waivers. |
| `groups` | Conferences and divisions. |
| `news` | Latest news articles. |
| `rankings` | Poll rankings (NCAA only). |
| `statistics` | League statistical leaders. |
| `draft` | Draft board (NBA + WNBA). |
| `standings` | **Stub only.** Use the v2 alternate path (below). |

### Standings (alternate path)

The site-v2 `/standings` resource returns a stub. Use this instead:

```
https://site.api.espn.com/apis/v2/sports/basketball/{league}/standings
```

Optional `?season={year}`. Response includes `children[].standings.entries[].stats[]` with per-team stat objects that carry `{name, displayName, abbreviation, description}` — useful for mining column descriptions.

## Web common v3

The richest source of per-athlete statistical data. Confirmed populated for all four basketball leagues.

| Resource | Description |
|---|---|
| `athletes/{id}/overview` | Stats snapshot, next game, news, rotowire notes. Embedded `statistics.{stats}` array. |
| `athletes/{id}/stats?season={year}` | Full season stats with `categories[].{labels, names, displayNames, descriptions, statistics, totals}` parallel-array layout. Top of the mining target list. |
| `athletes/{id}/gamelog?season={year}` | Game-by-game log with parallel `labels` / `names` / `displayNames` arrays at root + `events[]` and `glossary[]`. |
| `athletes/{id}/splits?season={year}` | Home/away/opponent splits with parallel arrays at root + `splitCategories[]`. |
| `statistics/byathlete?category={cat}&season={year}` | Ranked leaderboard across all athletes. Top-level `glossary[]` mineable for description text. |
| `statistics/byathlete?category={cat}&sort={field}:desc` | Same, with explicit sort. |

## Core v2

### Athletes (core v2)

| Resource | Description |
|---|---|
| `athletes?active=true&limit={n}&page={p}` | Paginated athlete list. |
| `athletes/{id}` | Athlete profile (enriched vs. site-v2). |
| `athletes/{id}/statistics` | Career statistics (`splits.categories[].stats[].description` self-documenting). |
| `athletes/{id}/statisticslog` | Game-by-game stats log. |
| `athletes/{id}/eventlog` | Event history. |
| `athletes/{id}/contracts` | Contract info (NBA). |
| `athletes/{id}/awards` | Awards. |
| `athletes/{id}/seasons` | Seasons played. |
| `athletes/{id}/records` | Career records. |
| `athletes/{id}/injuries` | Athlete injury history. |
| `athletes/{id}/vsathlete/{opponentId}` | Head-to-head stats. |

### Events / games

| Resource | Description |
|---|---|
| `events` | All events with pagination. |
| `events?dates={YYYYMMDD}` | Events on a specific date. |
| `events/{id}` | Single event detail. |
| `events/{id}/competitions/{cid}/odds` | Betting odds (spread, moneyline, total). |
| `events/{id}/competitions/{cid}/odds?provider.priority={n}` | Filter by sportsbook. |
| `events/{id}/competitions/{cid}/probabilities` | Win probabilities. |
| `events/{id}/competitions/{cid}/plays` | Play-by-play. |
| `events/{id}/competitions/{cid}/plays?limit={n}` | Override default page size. |
| `events/{id}/competitions/{cid}/situation` | Current game state. |
| `events/{id}/competitions/{cid}/broadcasts` | Broadcast info. |
| `events/{id}/competitions/{cid}/predictor` | ESPN game predictor. |
| `events/{id}/competitions/{cid}/powerindex` | BPI for the game. |
| `events/{id}/competitions/{cid}/officials` | Game officials. |
| `events/{id}/competitions/{cid}/competitors/{tid}/linescores` | Period-by-period scores. |
| `events/{id}/competitions/{cid}/competitors/{tid}/statistics` | Per-competitor stats (self-documenting). |

Note: in basketball `competition_id` ≡ `event_id` (single competition per event).

### Seasons

| Resource | Description |
|---|---|
| `seasons` | Season list. |
| `seasons/{year}` | Season detail. |
| `seasons/{year}/teams` | Teams in a season. |
| `seasons/{year}/athletes` | Athletes for a season. |
| `seasons/{year}/coaches` | Coaching staff. |
| `seasons/{year}/draft` | Draft data (NBA / WNBA). |
| `seasons/{year}/futures` | Futures odds. |
| `seasons/{year}/freeagents` | Free agents (WNBA / NBA off-season). |
| `seasons/{year}/powerindex` | Season-level BPI. |
| `seasons/{year}/powerindex/leaders` | BPI leaders. |
| `seasons/{year}/powerindex/{teamId}` | BPI for one team. |
| `seasons/{year}/types/{type}/athletes/{id}/statistics` | Per-season-type athlete statistics. |
| `seasons/{year}/types/{type}/teams/{id}/statistics` | Per-season-type team statistics. |
| `seasons/{year}/types/{type}/leaders` | Per-season-type leaders. |

`{type}` is `2` (regular season), `3` (postseason), `1` (preseason), `4` (off-season / all-star).

### Standings, leaders, rankings (core v2)

| Resource | Description |
|---|---|
| `standings` | League standings. |
| `leaders` | Statistical leaders (self-documenting). |
| `rankings` | Rankings (NCAA only). |

### Teams, venues, coaches

| Resource | Description |
|---|---|
| `teams` | All teams (paginated, detailed). |
| `teams/{id}` | Single team detail. |
| `venues` | Venues / arenas. |
| `franchises` | Franchise history. |
| `coaches` | All coaches. |
| `coaches/{id}` | Coach profile. |
| `coaches/{id}/record/{type}` | Coaching record by type. |

### Misc

| Resource | Description |
|---|---|
| `positions` | Position definitions. |
| `countries` | Countries. |
| `providers` | Data providers. |
| `tournaments` | Tournament data. |
| `recruiting` | Recruiting data (NCAA). |
| `season` | Current season pointer. |

## Response-shape patterns for mining column descriptions

When `tools/docs/mine_api_descriptions.R` probes these endpoints, the helper `mine_espn_api_descriptions()` (in `tools/docs/markdown_man_table_helper.R`) recognizes three response shapes that expose per-column description text:

1. **Nested `categories[].stats[]`**, each `stats[]` element carrying `{name, displayName, description}` — produced by core-v2 `/athletes/{id}/statistics`, `/teams/{id}/statistics`, and competitor statistics on event endpoints.
2. **Parallel arrays under `categories[]`** (`names[]`, `displayNames[]`, `descriptions[]`) — produced by web-v3 `/athletes/{id}/stats` and friends.
3. **Top-level parallel arrays** (`labels[]`, `names[]`, `displayNames[]`, optional `descriptions[]`) at the response root — produced by web-v3 `/athletes/{id}/splits` and `/athletes/{id}/gamelog`.

A fourth pattern — top-level `glossary[]` — also exposes `{abbreviation, displayName, description}` triples on some web-v3 leaderboard endpoints and is mined when present.

## Empirically-observed gotchas

- Site-v2 `/standings` returns only a stub. Use the `apis/v2/...` path instead (see Standings alternate above).
- `site.api.espn.com` `/injuries` returns 500 for sports without injury feeds (golf, tennis, MMA). Basketball is supported.
- Many core-v2 resources benefit from `?lang=en&region=us`; some endpoints 200 with empty bodies otherwise.
- core-v2 lists (`/athletes`, `/teams`, `/events`) default to small `limit` values; pass `?limit=1000` and iterate `?page=N` for full enumeration.
- WBB injury feed is sparse; wrappers return an empty tibble (rather than erroring) when no injuries are reported.
- The legacy `core-v2 scheduleleaguev2` endpoint is retired for both NBA and WNBA as of 2026 — use the public CDN at `cdn.{nba,wnba}.com/static/json/staticData/scheduleLeagueV2.json` for the current season (handled internally by `nba_schedule()` / `wnba_schedule()`).
