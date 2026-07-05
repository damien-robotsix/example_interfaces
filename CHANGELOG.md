## 0.0.0 (unreleased)

- Add `fsfe/reuse-tool` pre-commit hook to `.pre-commit-config.yaml` and remove the redundant standalone `reuse lint` step from CI workflow.
- Add `.robotsix-mill/periodic/changelog_autofill.yaml` to enable automated changelog population from merge commits.
- Fix `.robotsix-mill/config.yaml` `test_command` to conditionally source `/opt/ros/lyrical/setup.bash` so the mill test harness works when the ROS environment is pre-sourced.
