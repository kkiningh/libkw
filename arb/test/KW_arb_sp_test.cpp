#include <cstdint>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

#include "grip/rtl/lib/arb/test/VKW_arb_sp_wrap.h/VKW_arb_sp_wrap.h"

// TODO

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  // Global verilator setup
  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(false);
  Verilated::debug(0);
  Verilated::randReset(0);

  return RUN_ALL_TESTS();
}
