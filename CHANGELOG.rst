^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package example_interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0.0.0 (unreleased)
-------------------
* Add AGENT.md with repo purpose, layout, build system, and CI conventions.
* Add CI and Codecov status badges to README.
* Add .robotsix-mill/config.yaml — mill workspace member configuration.
* Add .robotsix-mill/periodic/ — eight automated audit workflows (board
  cleanup, backward-compatibility, health, test gaps, copy-paste detection,
  completeness, survey, and general improvements).
* Add .github/workflows/ci.yaml — full CI pipeline with DCO check, pre-commit,
  build-and-test matrix (humble, jazzy, rolling, lyrical), ccache, and
  coverage.
* Add .github/dependabot.yml — weekly GitHub Actions dependency updates.
* Add .github/codecov.yml — code coverage gating configuration.
* Add .github/ISSUE_TEMPLATE/ (bug report, feature request, config) and
  .github/PULL_REQUEST_TEMPLATE.md — standard contribution templates.
* Add msg/TestFeature.msg — custom test interface for mill E2E validation.
* Add test/test_publish_test_feature.cpp — companion gtest binary for
  TestFeature round-trip publish/subscribe.
* Add REUSE.toml — REUSE 3.3 license compliance configuration with wildcard
  annotations for .msg and .srv patterns.
* Add .pre-commit-config.yaml — pre-commit hooks for whitespace, YAML, merge
  conflicts, and private keys.
* Upgrade pre-commit hooks: pre-commit-hooks v5.0.0→v6.0.0,
  shellcheck-precommit v0.10.0→v0.11.0.
* Add .lcovrc — lcov configuration for code coverage generation.
* Expand .gitignore — add colcon build artifacts, editor files, macOS
  .DS_Store, IDE directories, and compiled objects.

0.14.1 (2025-07-01)
-------------------
* fix cmake deprecation (`#23 <https://github.com/ros2/example_interfaces/issues/23>`_)
* Contributors: mosfet80

0.14.0 (2025-04-25)
-------------------
* Remove .github/ISSUE_TEMPLATE.md (old version of templates) (`#21 <https://github.com/ros2/example_interfaces/issues/21>`_)
* Remove CODEOWNERS and mirror-rolling-to-master workflow. (`#19 <https://github.com/ros2/example_interfaces/issues/19>`_)
* Contributors: Chris Lalancette, Tomoya Fujita

0.13.0 (2024-04-26)
-------------------

0.12.0 (2023-08-21)
-------------------
* Update to C++17. (`#18 <https://github.com/ros2/example_interfaces/issues/18>`_)
* Contributors: Chris Lalancette

0.11.0 (2023-04-27)
-------------------

0.10.2 (2023-02-13)
-------------------
* [rolling] Update maintainers - 2022-11-07 (`#17 <https://github.com/ros2/example_interfaces/issues/17>`_)
* Contributors: Audrow Nash

0.10.1 (2022-09-13)
-------------------
* Remove action_msgs dependency (`#16 <https://github.com/ros2/example_interfaces/issues/16>`_)
* Mirror rolling to master
* Contributors: Audrow Nash, Jacob Perron

0.10.0 (2022-04-29)
-------------------

0.9.3 (2022-04-06)
------------------
* Update maintainers to Mabel Zhang (`#15 <https://github.com/ros2/example_interfaces/issues/15>`_)
* Add changelog (`#14 <https://github.com/ros2/example_interfaces/issues/14>`_)
* Contributors: Audrow Nash, Ivan Santiago Paunovic

0.9.2 (2021-04-06)
------------------
* Change links from index.ros.org -> docs.ros.org. (`#13 <https://github.com/ros2/example_interfaces/issues/13>`_)
* Contributors: Chris Lalancette

0.9.1 (2021-03-18)
------------------
* Update maintainer. (`#12 <https://github.com/ros2/example_interfaces/issues/12>`_)
* Contributors: Jacob Perron

0.9.0 (2020-05-26)
------------------
* Migrate content from std_msgs. (`#11 <https://github.com/ros2/example_interfaces/issues/11>`_)
* Contributors: Tully Foote

0.8.0 (2020-04-30)
------------------
* Update tutorial link. (`#9 <https://github.com/ros2/example_interfaces/issues/9>`_)
* Add mapping for rospy_tutorials/AddTwoInts.srv. (`#7 <https://github.com/ros2/example_interfaces/issues/7>`_)
* Contributors: Claire Wang, Dirk Thomas

0.7.1 (2019-05-29)
------------------
* Remove the action_msgs dependency CMake code. (`#6 <https://github.com/ros2/example_interfaces/issues/6>`_)
* Contributors: Jacob Perron

0.7.0 (2019-04-14)
------------------
* Add section about DCO to CONTRIBUTING.md.
* Contributors: Dirk Thomas

0.6.2 (2019-02-08)
------------------
* Remove action mapping for ROS 1. (`#5 <https://github.com/ros2/example_interfaces/issues/5>`_)
* Contributors: Jacob Perron

0.6.1 (2018-12-06)
------------------
* Add Fibonacci.action. (`#4 <https://github.com/ros2/example_interfaces/issues/4>`_)
* Contributors: Jacob Perron

0.6.0 (2018-11-19)
------------------
* Use add_compile_options instead of setting only cxx flags
* Contributors: Mikael Arguedas

0.5.0 (2018-06-25)
------------------
* Advise to ask questions on ROS answers in issue template.
* Contributors: Mikael Arguedas

0.4.0 (2017-12-08)
------------------
* Member of rosidl_interfaces_packages group. (`#2 <https://github.com/ros2/example_interfaces/issues/2>`_)
* Add issue template.
* Use CMAKE_X_STANDARD and check compiler rather than platform.
* Restore contrib, license, and readme after moving.
* Add pedantic flag.
* Comment mapping_rules.yaml. (`#156 <https://github.com/ros2/examples/issues/156>`_)
* Read dummy message  workaround. (`#155 <https://github.com/ros2/examples/issues/155>`_)
* Messages and services mappings moved to one file.
* Cpp14. (`#147 <https://github.com/ros2/examples/issues/147>`_)
* Remove unused LargeFixed msg. (`#150 <https://github.com/ros2/examples/issues/150>`_)
* Added a service mapping rule. (`#136 <https://github.com/ros2/examples/issues/136>`_)
* Update schema url in manifest files.
* Add schema to manifest files.
* Require CMake 3.5.
* Add explicit build type.
* Raise warning level.
* Major refactor of examples and message packages
* Contributors: Dirk Thomas, Jackie Kay, Mikael Arguedas, Morgan Quigley, Rafal Kozik, William Woodall, dhood
