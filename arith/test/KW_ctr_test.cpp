#include <cstdint>

#include <gtest/gtest.h>
#include <gmock/gmock.h>

#include "gcn/lib/arith/test/VKW_ctr_wrap/VKW_ctr_wrap.h"
#include "gcn/test/verilator_driver.h"

class CtrTest : public ::testing::Test {
  protected:
    VerilatorDUT<VKW_ctr_wrap> dut;

    void SetUp() override {
      dut.poke(&VKW_ctr_wrap::cen, 0);
      dut.reset();
    }

    void TearDown() override {
      dut.finish();
    }

    void stepCount() {
      dut.poke(&VKW_ctr_wrap::cen, 1);
      dut.step();
      dut.poke(&VKW_ctr_wrap::cen, 0);
    }

    uint16_t peekCount() {
      return dut.peek(&VKW_ctr_wrap::count);
    }
};

TEST_F(CtrTest, CountAll) {
  for (int i = 0; i < 0xFFFF; i++) {
    EXPECT_EQ(peekCount(), i);
    stepCount();
  }
  // Test wrapping behavior
  EXPECT_EQ(peekCount(), 0);
}
