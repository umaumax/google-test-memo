#include <iostream>
#include <string>
#include <vector>

#include "gtest/gtest.h"

int add(int a, int b) { return a + b; }
TEST(GTest, add_normal) { EXPECT_TRUE(add(2, 2) == 4); }

int main(int argc, char* argv[]) {
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
