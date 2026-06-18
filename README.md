ROS 2 examples
==============

This repository is a fork of [ros2/example_interfaces](https://github.com/ros2/example_interfaces),
maintained for use by the [robotsix-mill](https://github.com/robotsix) project. It tracks
upstream while adding a small custom message used to validate the mill end-to-end (E2E)
workflow on a forked sub-repository.

Overview
--------

The `example_interfaces` package provides a collection of message, service, and action
definitions that are commonly used in ROS 2 tutorials and examples:

* **Messages** (`msg/`) — primitive and multi-array wrappers such as `Bool`, `String`,
  `Int32`, `Float64`, and the `*MultiArray` variants.
* **Services** (`srv/`) — `AddTwoInts`, `SetBool`, and `Trigger`.
* **Actions** (`action/`) — `Fibonacci`.

Custom additions
----------------

* **`msg/TestFeature.msg`** — a placeholder message added by this fork to validate the
  robotsix-mill end-to-end workflow on a forked sub-repository. It uses only built-in
  ROS 2 field types and introduces no external dependencies:

  ```
  string name
  int32 value
  ```

Building and testing
--------------------

This package is built with [colcon](https://colcon.readthedocs.io/). From the root of
your ROS 2 workspace:

```bash
# Build the package
colcon build --packages-select example_interfaces

# Run the tests
colcon test --packages-select example_interfaces
colcon test-result --verbose
```

Tutorials
---------

Tutorials on how to try out the examples:
* [Writing a simple service and client C++](https://docs.ros.org/en/rolling/Tutorials/Writing-A-Simple-Cpp-Service-And-Client.html)
* [Writing a simple service and client Python](https://docs.ros.org/en/rolling/Tutorials/Writing-A-Simple-Py-Service-And-Client.html)

Further reading
---------------

* [About ROS 2 interfaces](https://docs.ros.org/en/rolling/Concepts/Basic/About-Interfaces.html)
* [Creating custom msg and srv files](https://docs.ros.org/en/rolling/Tutorials/Beginner-Client-Libraries/Custom-ROS2-Interfaces.html)

License
-------

This repository is fully REUSE-compliant. All files are covered by
`REUSE.toml` annotations declaring `Apache-2.0` with copyright held by
`2026 Damien SIX <damien@robotsix.net>`. The full license text is
available in `LICENSES/Apache-2.0.txt`.
