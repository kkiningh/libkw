#include <cstdint>
#include <vector>
#include <random>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

#include "gcn/lib/arith/test/VKW_prod_sum_wrap/VKW_prod_sum_wrap.h"
#include "gcn/test/verilator_driver.h"

class ProdSumTest : public ::testing::Test {
  protected:
    VerilatorDUT<VKW_prod_sum_wrap> dut;
    using data_t = uint16_t;
    using sum_t = uint16_t;
    static constexpr int NUM_INPUTS = 16;
    static constexpr int NUM_STAGES = 3;

    void SetUp() override {
      dut.reset();
    }

    sum_t multiply(data_t a[], data_t b[]) {
      std::memcpy(dut.top.a, a, NUM_INPUTS * sizeof(data_t));
      std::memcpy(dut.top.b, b, NUM_INPUTS * sizeof(data_t));
      dut.step(NUM_STAGES-1);
      return dut.peek(&VKW_prod_sum_wrap::sum);
    }

    void TearDown() override {
      dut.finish();
    }
};

TEST_F(ProdSumTest, SumOne) {
  data_t a[16], b[16];
  std::fill_n(a, 16, 1);
  std::fill_n(b, 16, 1);
  EXPECT_EQ(multiply(a, b), 16);
}

TEST_F(ProdSumTest, Random) {
  data_t a[16], b[16];

  // Random number generator
  std::mt19937 gen(/*seed*/0);
  std::uniform_int_distribution<uint16_t> dis; // For values to push/pop

  // Fill with random numbers
  for (int i = 0; i < NUM_INPUTS; i++) {
    a[i] = dis(gen);
    b[i] = dis(gen);
  }

  uint16_t prod = 0;
  for (int i = 0; i < NUM_INPUTS; i++) {
    prod += a[i] * b[i];
  }

  EXPECT_EQ(multiply(a, b), prod);
}

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  // Global verilator setup
  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(false);
  Verilated::debug(0);
  Verilated::randReset(0);

  return RUN_ALL_TESTS();
}
