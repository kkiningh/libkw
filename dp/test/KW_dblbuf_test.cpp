#include <cstdint>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

#include "gcn/test/verilator_driver.h"
#include "gcn/lib/dp/test/VKW_dblbuf_wrap/VKW_dblbuf_wrap.h"

class DblbufTest : public ::testing::Test {
  protected:
    VerilatorDUT<VKW_dblbuf_wrap> dut;
    void SetUp() override {
      dut.poke(&VKW_dblbuf_wrap::w_en_n, 1);
      dut.poke(&VKW_dblbuf_wrap::r_en_n, 1);
      dut.reset();
    }

    void TearDown() override {
      dut.finish();
    }

    void write(uint16_t addr, uint16_t data) {
      dut.poke(&VKW_dblbuf_wrap::w_en_n, 0);
      dut.poke(&VKW_dblbuf_wrap::w_addr, addr);
      dut.poke(&VKW_dblbuf_wrap::w_data, data);
      dut.step();
      dut.poke(&VKW_dblbuf_wrap::w_en_n, 1);
    }

    uint16_t read(uint16_t addr) {
      dut.poke(&VKW_dblbuf_wrap::r_en_n, 0);
      dut.poke(&VKW_dblbuf_wrap::r_addr, addr);
      dut.eval(); // Reads are combinational
      uint16_t data = dut.peek(&VKW_dblbuf_wrap::r_data);
      dut.poke(&VKW_dblbuf_wrap::r_en_n, 1);
      return data;
    }

    void SwapBuffers() {
      dut.poke(&VKW_dblbuf_wrap::swap_n, 0);
      dut.step();
      dut.poke(&VKW_dblbuf_wrap::swap_n, 1);
    }
};

TEST_F(DblbufTest, Simple) {
  // TODO - short outline below
#if 0
  for (int i = 0; i < 32; i++) {
    write(i, i + 1);
  }
  SwapBuffers();
  for (int i = 0; i < 32; i++) {
    write(i, 0xAA);
    EXPECT_EQ(read(i), i + 1);
  }
  SwapBuffers();
  for (int i = 0; i < 32; i++) {
    EXPECT_EQ(read(i), 0xAA);
  }
#endif
}

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  // Global verilator setup
  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);
  Verilated::debug(0);
  Verilated::randReset(0);
  return RUN_ALL_TESTS();
}
