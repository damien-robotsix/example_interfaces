# AGENT.md — `ros2-example-interfaces`

## Purpose

Fork of [`ros2/example_interfaces`](https://github.com/ros2/example_interfaces)
maintained by the [robotsix-mill](https://github.com/robotsix) project.  Ships
standard ROS 2 `.msg`, `.srv`, and `.action` definitions plus a custom
`TestFeature.msg` introduced solely to validate the mill's E2E workflow on a
forked sub-repository.

## Language & build system

- **Language:** C++17 (no Python source code).
- **Build system:** `ament_cmake` with `rosidl_default_generators`.
- **Tests:** GTest + `rclcpp`; linting via `ament_lint_auto` / `ament_lint_common`.

## Layout

| Directory     | Contents |
|---------------|----------|
| `msg/`        | 30 `.msg` files — primitive wrappers, multi-array types, `TestFeature` |
| `srv/`        | 3 `.srv` files — `AddTwoInts`, `SetBool`, `Trigger` |
| `action/`     | 1 `.action` file — `Fibonacci` |
| `test/`       | single GTest file: `test_publish_test_feature.cpp` |
| `.github/`    | CI workflow (`ci.yaml`) — DCO, pre-commit, matrix build |
| `.robotsix-mill/` | `config.yaml` — mill workspace member configuration |

## Key conventions

- **`package.xml`** drives the build: declares dependencies, package metadata,
  and the `rosidl_interface_packages` group membership.
- **`CMakeLists.txt`** wires `rosidl_generate_interfaces()` and `ament_add_gtest()`.
- **`mapping_rules.yaml`** provides ROS 1 ↔ ROS 2 bridge mappings for
  `AddTwoInts` → `TwoInts`; exported via `package.xml`'s `<ros1_bridge>` export.
- **Licensing:** Apache-2.0, REUSE-compliant (declared via `REUSE.toml`).
- **Pre-commit hooks:** trailing-whitespace, end-of-file-fixer, check-yaml,
  check-added-large-files, check-merge-conflict, detect-private-key,
  cmake-format, cmake-lint, shellcheck, reuse.
- **Changelog:** `CHANGELOG.rst` (RST format, not Markdown).

## CI (`ci.yaml`)

Three jobs on every PR/push to `lyrical`:

| Job             | Notes |
|-----------------|-------|
| **DCO**         | `git log --grep '^Signed-off-by:'`; PRs only. |
| **pre-commit**  | Runs pre-commit hooks (includes reuse, cmake-format, cmake-lint, shellcheck). |
| **build-and-test** | Matrix across `humble`, `jazzy`, `rolling`. Uses `ros-tooling/action-ros-ci` with ccache and coverage via `coverage-gcc` colcon mixin; uploads logs and Codecov coverage. |

## Stale issue/PR management (`stale.yaml`)

Weekly scheduled workflow (every Monday 07:00 UTC, also triggerable via `workflow_dispatch`)
using `actions/stale@v9`:

| Config              | Issues | PRs |
|---------------------|--------|-----|
| Days until stale    | 60     | 90  |
| Days until close    | 7      | 14  |
| Exempt labels       | `pinned`, `security`, `bug`, `enhancement` (same for both) |

### Mill CI note

`.robotsix-mill/config.yaml` sets `skip_ci: true` — the mill's per-PR CI gate
is **bypassed** because the upstream GitHub workflow already fails on this fork
(pre-existing target-branch debt).  The merge stage routes a mergeable PR
straight to human approval.

## Building & testing locally

```bash
# From a ROS 2 workspace root (lyrical environment sourced):
colcon build --packages-select example_interfaces
colcon test --packages-select example_interfaces
colcon test-result --verbose
```
