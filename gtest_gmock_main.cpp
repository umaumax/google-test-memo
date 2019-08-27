#include <iostream>
#include <string>
#include <vector>

#include "gmock/gmock.h"
#include "gtest/gtest.h"

int add(int a, int b) { return a + b; }
TEST(GTest, add_normal) { EXPECT_TRUE(add(2, 2) == 4); }

TEST(GTest, vector_normal) {
  std::vector<int> v{5, 10, 15};
  ASSERT_THAT(v, ::testing::ElementsAre(5, 10, 15));
}

int main(int argc, char* argv[]) {
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
