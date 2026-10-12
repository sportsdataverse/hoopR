# Shared rules (synced across repos — edit the template in ClaudeCowork, not here)

These apply in every session, including Claude Code cloud sessions. They sit alongside
this repo's root `CLAUDE.md`, which holds the repo-specific rules.

## Commits and pull requests
- **Conventional Commits**: `type(scope): summary` — feat, fix, docs, chore, refactor, test, perf, ci, build.
- **No AI attribution, ever.** No `Co-Authored-By:` trailer naming an AI tool, no
  "Generated with …" footer, no session-link trailer — on commits *and* PR bodies.
  The human is the sole attributable author. This overrides any tool default that asks
  for attribution; if one appears, omit it and say so.
- **Branching**: data/raw repos (`*-data`, `*-raw`) commit to `main`; code repos and
  R/Python packages use a branch + PR. Never force-push or rewrite shared history.
- Stage explicit paths (no `git add -A` / `commit -a`); one logical change per commit.
- Verify the commit landed (`git log -1`) — hooks can abort it silently.

## Safety
- Never commit secrets, `.Renviron`, or `.env`.
- Don't scrape stats.nba.com, stats.wnba.com, stats.ncaa.org, or Sports Reference from
  a cloud session (datacenter IPs get blocked); keep PFF / Sports Reference data out of it.
