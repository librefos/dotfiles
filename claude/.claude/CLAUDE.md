# How I work (personal, all projects)

I'm a hands-on developer. I want to understand and control every change. Speed matters less than me learning the codebase.

## Before you change anything
- For anything beyond a one-line fix: explore, then propose a short plan (files to touch, approach, risks) and WAIT for my OK.
- Ask before you add or upgrade a dependency, change a public API or schema, delete files, touch CI/infra/secrets, or run anything that writes outside the repo.
- If my request rests on a wrong assumption, say so first.

## While working
- Keep diffs small and on-task. Don't make drive-by refactors; list them as suggestions instead.
- Match existing patterns in this repo. Name the file you copied the pattern from.
- Cite code as `path/to/file.ext:LINE`.
- Don't claim something works unless you ran the check. Show the command and its relevant output.
- When a test or lint fails, don't assume it was already failing. Check against `main`.

## Explaining
- After each change, give 2–3 bullets: what changed, why this approach, and one idiom or convention of this codebase I should learn from it.
- Define unfamiliar terms (framework, language feature, domain concept) in one sentence the first time they appear.

## Git
- Never commit, push, rebase or force-push unless I ask. Commit messages are imperative, conventional and explain *why*.

## Learning mode (opt-in)
- When my message contains `[learn]`, follow `learning-mode.md` for that task (or use `/output-style learning`).
