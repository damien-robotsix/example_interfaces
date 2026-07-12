## 0.0.0 (unreleased)

- Migrate build-and-test CI job from deprecated Docker Hub images to actively maintained GHCR equivalents (humble→ubuntu-jammy-ros-humble-desktop, jazzy→ubuntu-noble-ros-jazzy-desktop, rolling→ubuntu-noble-ros-rolling-ros-base) and add `docker` Dependabot ecosystem entry for automated digest-bump PRs. SHA digest pinning deferred — digests require resolution from network-connected environment.
- CI: set ``LCOVRC`` environment variable so lcov discovers ``.lcovrc`` during coverage generation
- AGENT.md: document the `trivy-scan` job, weekly schedule trigger, and concurrency group in the CI section.
- Correct AGENT.md CI documentation: remove `lyrical` from the build-and-test matrix (only `humble`, `jazzy`, `rolling` are configured), fix pre-commit job description (no standalone `reuse lint` step), and add missing pre-commit hooks (`check-added-large-files`, `check-merge-conflict`, `detect-private-key`, `reuse`).
- Add `fsfe/reuse-tool` pre-commit hook to `.pre-commit-config.yaml` and remove the redundant standalone `reuse lint` step from CI workflow.
- Add `.robotsix-mill/periodic/changelog_autofill.yaml` to enable automated changelog population from merge commits.
- Fix `.robotsix-mill/config.yaml` `test_command` to conditionally source `/opt/ros/lyrical/setup.bash` so the mill test harness works when the ROS environment is pre-sourced.
