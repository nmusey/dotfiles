# Telescope double-space extension filter

## Problem

In Telescope file pickers (`find_files`, `git_files`, etc.), there's no way to
narrow results to a specific file extension without typing the full
extension as part of a fuzzy-matched string, which doesn't reliably restrict
to only that extension.

## Goal

Typing `name  ext` (two or more literal spaces before the trailing token) in
a Telescope file picker's prompt filters results to files whose name
fuzzy-matches `name` **and** whose extension is exactly `ext`.

Example: `login  ts` matches `login.ts`, `login2.ts` — not `login.tsx` or
`login.test.ts`... (see "Extension matching" below for the exact-suffix
caveat on compound extensions).

## Scope

Applied globally via `defaults.file_sorter` in `telescope.setup()`
(`nvim/.config/nvim/lua/plugins/telescope.lua`), so every picker that uses
Telescope's file sorter (`find_files`, `git_files`, etc.) gets this behavior
automatically. No new keymaps.

## Design

Wrap Telescope's default file sorter (`sorters.get_fzy_sorter`) in a custom
`sorters.Sorter` and register it as `defaults.file_sorter`.

**Parsing** (on each keystroke): match the prompt against
`^(.-)  +(%S+)$` (two-or-more literal spaces before a trailing run of
non-space characters).

- If it matches: `name` = left side, `ext` = right side, with a leading `.`
  stripped from `ext` if present (so `name  .ts` and `name  ts` are
  equivalent).
- If it doesn't match: treat the whole prompt as `name` with no extension
  filter (normal behavior, including a single space, which has no special
  meaning).

**Filtering:** if `ext` was parsed, reject (score `-1`, i.e. `FILTERED`) any
entry whose ordinal (relative path) doesn't end in `.` + `ext`,
case-insensitive.

**Scoring/highlighting:** entries that pass the extension check are scored
and highlighted by delegating to the wrapped fzy sorter's
`scoring_function`/`highlighter`, called with just the `name` portion — so
ranking and match highlighting are unchanged from today, just pre-filtered
by extension.

## Extension matching semantics

Matching is a case-insensitive suffix check: `path:lower():match("%." ..
ext:lower():gsub("%p", "%%%1") .. "$")`. This means:

- `ts` matches `foo.ts` and also `foo.test.ts` (suffix `.ts`), since suffix
  matching can't distinguish "the extension" from "the last dot-segment of
  a compound extension." This is accepted as correct, expected behavior —
  not a bug to fix.

## Edge cases

- Trailing double-space with nothing after it (`name  `): no `%S+` to
  match, so it falls through to plain fuzzy search on the full literal
  prompt (no extension filter applied).
- A single space anywhere in the prompt: no special meaning, behaves as
  plain fuzzy search today.
- Empty `name` before the double space (`  ts`): valid — filters to all
  files with extension `ts`, ranked by the (empty-string) fzy score, which
  fzy treats as a neutral/worst-case score for all remaining candidates
  (no further ranking signal beyond the extension filter).

## Non-goals

- No support for multiple extensions in one query (e.g. `ts,tsx`).
- No change to `git_files`/other picker keymaps or options beyond the
  shared sorter.
- No new dependency (no telescope-fzf-native); if fzf-native is added to
  this config later, per Telescope's own convention it will override
  `defaults.file_sorter` directly, superseding this behavior — that's
  accepted as an out-of-scope future consideration, not something this
  design needs to guard against now.

## Implementation location

`nvim/.config/nvim/lua/plugins/telescope.lua` — add the wrapper sorter
function and pass it as `defaults.file_sorter` in the existing
`telescope.setup({...})` call.
