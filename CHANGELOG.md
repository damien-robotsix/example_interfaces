## 0.0.0 (unreleased)

- Restore `skip_ci: true` in `.robotsix-mill/config.yaml` to keep the mill CI gate bypassed (the sandbox lacks ROS 2 binaries, causing rc=127 on test commands)
- Split the single `build-and-test` matrix job in `.github/workflows/ci.yaml` into three independent per-distro jobs (`humble`, `jazzy`, `rolling`), each with its own container image, ccache cache key, and artifact name. Updated AGENT.md CI table and `.robotsix-mill/config.yaml` accordingly.
- CI: set ``LCOVRC`` environment variable so lcov discovers ``.lcovrc`` during coverage generation
- AGENT.md: document the `trivy-scan` job, weekly schedule trigger, and concurrency group in the CI section.
- Correct AGENT.md CI documentation: remove `lyrical` from the build-and-test matrix (only `humble`, `jazzy`, `rolling` are configured), fix pre-commit job description (no standalone `reuse lint` step), and add missing pre-commit hooks (`check-added-large-files`, `check-merge-conflict`, `detect-private-key`, `reuse`).
- Add `fsfe/reuse-tool` pre-commit hook to `.pre-commit-config.yaml` and remove the redundant standalone `reuse lint` step from CI workflow.
- Add `.robotsix-mill/periodic/changelog_autofill.yaml` to enable automated changelog population from merge commits.
- Fix `.robotsix-mill/config.yaml` `test_command` to conditionally source `/opt/ros/lyrical/setup.bash` so the mill test harness works when the ROS environment is pre-sourced.
