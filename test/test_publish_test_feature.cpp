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
#include <future>
#include <memory>

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

  auto promise = std::make_shared<std::promise<example_interfaces::msg::TestFeature>>();
  auto future = promise->get_future();

  rclcpp::TimerBase::SharedPtr timer;
  auto subscription = node->create_subscription<example_interfaces::msg::TestFeature>(
    "test_feature", qos,
    [promise, &timer](example_interfaces::msg::TestFeature::SharedPtr msg) {
      // Cancel the republish timer first so the callback never sets the
      // promise value twice (set_value would throw std::future_error).
      timer->cancel();
      promise->set_value(*msg);
    });

  auto publisher =
    node->create_publisher<example_interfaces::msg::TestFeature>("test_feature", qos);

  example_interfaces::msg::TestFeature message;
  message.name = "hello";
  message.value = 42;

  // Republish periodically so the message is delivered once discovery completes.
  timer = node->create_wall_timer(
    50ms, [publisher, message]() {
      publisher->publish(message);
    });

  rclcpp::executors::SingleThreadedExecutor exec;
  exec.add_node(node);
  auto ret = exec.spin_until_future_complete(future, 5s);

  ASSERT_EQ(ret, rclcpp::FutureReturnCode::SUCCESS)
    << "TestFeature message was not received before timeout";
  const auto received = future.get();
  EXPECT_EQ(received.name, "hello");
  EXPECT_EQ(received.value, 42);

  if (rclcpp::ok()) {
    rclcpp::shutdown();
  }
}
