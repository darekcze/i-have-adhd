# DC4I ADHD Execution Mode update policy

Canonical repository: https://github.com/darekcze/i-have-adhd
Upstream reference: https://github.com/ayghri/i-have-adhd

- Existing DC4I Tool Evolution Watch (not a second scheduler) checks upstream changes and raises a review issue only when meaningful.
- Inspect and merge upstream changes in a review branch. Do not overwrite `skills/dc4i-adhd-execution/SKILL.md` automatically.
- Run `python3 -m unittest discover -s tests -q`, `bash -n scripts/*.sh`, and `git diff --check`. Review any external integrations and hook changes.
- Before each host deployment, save version and previous skill files. Run a canary on Mac Pro (macOS) and MaxDesk (Windows) before Mac mini. The x360 is the preferred Windows canary when connected. Stop on first failed verification.
- Install only a pinned reviewed commit and verify SHA-256. Mac mini remains update coordinator; no second runner or database.
- Rollback: restore the timestamped `*.backup.*` skill directory created by `scripts/install-dc4i.sh`, or reinstall the previous reviewed commit. Restart agent sessions as needed.
- For GitHub checks, run `scripts/update-upstream.sh` from a clean checkout with upstream remote configured. It never merges or pushes.
- Releasing an update requires evidence from all affected hosts, and production-impacting changes follow existing owner authorization.
