# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal macOS dotfiles managed by [Dotbot](https://github.com/anishathalye/dotbot). Targets are a developer workstation: Neovim, tmux, Zsh (oh-my-zsh), Ghostty, Aerospace, Starship, and a Brewfile of CLI tools and casks. There is no application to build or test — changes are configuration that takes effect after running the installer.

## Installer

- `./install` — runs the default Dotbot config (`default.conf.yaml`). Idempotent: re-run after editing the config or adding a file that should be linked.
- `./install personal` — runs `default.conf.yaml` then `personal.conf.yaml` (which currently just layers in `Brewfile.personal`). Any positional argument resolves to `{arg}.conf.yaml`, so additional per-machine configs can be added the same way.
- The installer auto-initializes the `dotbot` submodule. Other submodules (`dotbot-brew`, `nvim`, the zsh plugins) are initialized by the `git submodule update` shell step inside the default config — so the first run handles them, but `git submodule update --init --recursive` is the manual fallback.

## How Dotbot configs are organized

`default.conf.yaml` is the source of truth for what lands where. When adding a new tool:

1. Drop the config file/folder into this repo (e.g., `foo/config`).
2. Add a `link:` entry mapping the destination path (under `~`) to the repo-relative path.
3. If a parent directory needs to exist first, add it under `create:`.
4. If the tool needs a post-install command, add it under `shell:`.
5. Re-run `./install`.

Note the `relink: true` default — existing symlinks are replaced, but Dotbot will refuse to clobber a real file at the destination. Move or delete the conflicting file first.

Brew packages are split: `Brewfile` is the shared baseline, `Brewfile.personal` is opt-in via `./install personal`. The `dotbot-brew` plugin installs them.

## Agent skills

`agents/skills/` is the home for custom Claude Code skills. The installer symlinks this directory to **both** `~/.agents/skills` and `~/.claude/skills`, so anything added here becomes available to local Claude Code sessions immediately after `./install`.

Layout conventions:

- Each skill is its own directory with a `SKILL.md` whose YAML frontmatter declares `name` and `description` (description is what triggers skill discovery — keep it specific about when to invoke).
- `agents/skills/_shared/` holds cross-skill content (currently `solo-integration.md` for Solo MCP sync and `testing-rules.md` for TDD discipline). Skills reference these via `~/.claude/skills/_shared/...` paths, which only resolve after `./install` has created the symlink.
- The `to-spec` → `task-planner` → `task-implementor` skills form a planning pipeline that writes into `.ai/plans/{slug}/` in the consuming repo (spec, tasks, learnings). They optionally sync to Solo MCP when `mcp__solo__*` tools are present; the boot sequences in each `SKILL.md` are the contract.

When editing a skill, keep the frontmatter `description` in sync with the behaviour — it's what other agents see when deciding whether to invoke.

## Submodules

- `dotbot/`, `dotbot-brew/` — installer machinery; treat as upstream, don't modify.
- `nvim/` — points at the separate `andrewbroberg/kickstart-modular.nvim` repo. Neovim config changes belong in that repo, not here.
- `zsh/custom/plugins/zsh-syntax-highlighting`, `zsh/custom/plugins/zsh-autosuggestions` — upstream oh-my-zsh plugins.

`.gitmodules` has `ignore = dirty` on `dotbot` so local plugin caches don't pollute status.

## Development branch

When working as Claude Code on this repo, develop on the branch named in the task brief (currently `claude/init-project-setup-ZQglL`). Commit and push there; do not push to `main` or `master`.
