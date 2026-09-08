---
name: weekly-pr-summary
description: Summarize the user's own GitHub PRs into a short, non-technical update for a team sync. Use when asked for a weekly PR or work summary.
---

# Weekly PR Summary

Non-technical tone throughout: no jargon, no PR numbers or links unless asked,
grouped by theme — never by repo, which means nothing to this audience.

## Scope

Search every repo the user has PRs in. Do not assume a repo list.

If the user names one or more repos, scope to those instead by adding
`--repo <owner/name>` per repo (repeatable). If they name an org, use
`--owner <org>`.

## Steps

1. Resolve the user's GitHub login: `gh api user --jq .login`
2. Resolve the window. Default is since last Tuesday, or whatever date/range
   the user gives. Compute the actual calendar date yourself; if "last
   Tuesday" is ambiguous (e.g. today is Tuesday), ask rather than guess.
3. Run these in parallel, where `<date>` is `YYYY-MM-DD`. Filter on when
   the PR was merged or closed, not when it was opened — a PR opened before
   the window and merged inside it counts as this week's work:
   - Merged: `gh search prs --author <login> --merged-at ">=<date>" --json repository,number,title,url,mergedAt --limit 100`
   - In progress: `gh search prs --author <login> --state open --json repository,number,title,url,createdAt,isDraft --limit 100` (no date filter — anything still open is still in progress)
   - Closed unmerged: `gh search prs --author <login> --closed ">=<date>" --state closed --merged=false --json repository,number,title,url --limit 100`
4. Bucket into **Merged** or **Still in progress** (open + draft). Drop the
   closed-unmerged PRs, unless a merged PR superseded one — then fold in a
   one-line mention of the supersession.
5. Within each bucket, group by theme (e.g. "Customers & Contacts", "Orders",
   "Tooling/maintenance") and rewrite each title in plain language.
6. Done when the output is exactly two headers — "Merged this week" /
   "Still in progress" — each holding a few themed bullets, one line per PR.
