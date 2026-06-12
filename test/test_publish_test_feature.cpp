// Copyright 2025 Open Robotics
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <gtest/gtest.h>

#include <chrono>
#include <memory>
#include <thread>

#include "rclcpp/rclcpp.hpp"

#include "example_interfaces/msg/test_feature.hpp"

using namespace std::chrono_literals;

TEST(TestPublishTestFeature, PublishSubscribeRoundTrip)
{
  if (!rclcpp::ok()) {
    rclcpp::init(0, nullptr);
  }

  auto node = std::make_shared<rclcpp::Node>("test_publish_test_feature_node");

  rclcpp::QoS qos(rclcpp::KeepLast(10));
  qos.reliable();

  auto publisher =
    node->create_publisher<example_interfaces::msg::TestFeature>("test_feature", qos);

  example_interfaces::msg::TestFeature::SharedPtr received;
  auto subscription = node->create_subscription<example_interfaces::msg::TestFeature>(
    "test_feature", qos,
    [&received](example_interfaces::msg::TestFeature::SharedPtr msg) {
      received = msg;
    });

  example_interfaces::msg::TestFeature message;
  message.name = "hello";
  message.value = 42;

  const auto deadline = std::chrono::steady_clock::now() + 5s;
  while (!received && std::chrono::steady_clock::now() < deadline) {
    publisher->publish(message);
    rclcpp::spin_some(node);
    std::this_thread::sleep_for(50ms);
  }

  ASSERT_TRUE(received) << "TestFeature message was not received before timeout";
  EXPECT_EQ(received->name, "hello");
  EXPECT_EQ(received->value, 42);

  if (rclcpp::ok()) {
    rclcpp::shutdown();
  }
}
