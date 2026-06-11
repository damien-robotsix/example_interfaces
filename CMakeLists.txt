cmake_minimum_required(VERSION 3.20)

project(example_interfaces)

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()
if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "action/Fibonacci.action"
  "msg/Bool.msg"
  "msg/Byte.msg"
  "msg/ByteMultiArray.msg"
  "msg/Char.msg"
  "msg/Empty.msg"
  "msg/Float32.msg"
  "msg/Float32MultiArray.msg"
  "msg/Float64.msg"
  "msg/Float64MultiArray.msg"
  "msg/Int16.msg"
  "msg/Int16MultiArray.msg"
  "msg/Int32.msg"
  "msg/Int32MultiArray.msg"
  "msg/Int64.msg"
  "msg/Int64MultiArray.msg"
  "msg/Int8.msg"
  "msg/Int8MultiArray.msg"
  "msg/MultiArrayDimension.msg"
  "msg/MultiArrayLayout.msg"
  "msg/String.msg"
  "msg/TestFeature.msg"
  "msg/UInt16.msg"
  "msg/UInt16MultiArray.msg"
  "msg/UInt32.msg"
  "msg/UInt32MultiArray.msg"
  "msg/UInt64.msg"
  "msg/UInt64MultiArray.msg"
  "msg/UInt8.msg"
  "msg/UInt8MultiArray.msg"
  "msg/WString.msg"
  "srv/AddTwoInts.srv"
  "srv/SetBool.srv"
  "srv/Trigger.srv"
)

install(FILES mapping_rules.yaml DESTINATION share/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  find_package(rclcpp REQUIRED)
  ament_add_gtest(test_publish_test_feature test/test_publish_test_feature.cpp)
  if(TARGET test_publish_test_feature)
    # Link this package's own generated C++ typesupport so the test can
    # use example_interfaces::msg::TestFeature defined in the same package.
    rosidl_get_typesupport_target(cpp_typesupport_target
      ${PROJECT_NAME} "rosidl_typesupport_cpp")
    target_link_libraries(test_publish_test_feature
      rclcpp::rclcpp
      "${cpp_typesupport_target}")
  endif()
endif()

ament_export_dependencies(rosidl_default_runtime)
ament_package()
