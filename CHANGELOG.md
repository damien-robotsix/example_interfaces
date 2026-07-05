## 0.0.0 (unreleased)

- Add `.robotsix-mill/periodic/changelog_autofill.yaml` to enable automated changelog population from merge commits.
- Fix `.robotsix-mill/config.yaml` `test_command` to conditionally source `/opt/ros/lyrical/setup.bash` so the mill test harness works when the ROS environment is pre-sourced.
