#include <cassert>
#include <cstdint>

#include "gtest/gtest.h"
#include "gmock/gmock.h"
#include <iostream>

#include "grip/rtl/lib/arb/test/VKW_arb_rr_wrap.h/VKW_arb_rr_wrap.h"

template <std::size_t N>
SC_MODULE(ArbRRModel) {
  sc_in<bool> clock_;
  sc_in<bool> reset_n_;
  sc_in<uint32_t> request;
  sc_in<uint32_t> mask;
  sc_out<uint32_t> grant;
  sc_out<bool> granted;
  sc_out<bool> parked;

  SC_CTOR(ArbRRModel) {
    SC_CTHREAD(thread, clock_.pos());
  }

  int priority;
  void thread() {
    while (true) {
      if (!reset_n_) {
        priority = 0;
      } else {
        auto req = request.read() & ~mask.read();
        if (!req) {
          grant.write(0);
          granted.write(0);
          parked.write(1);
        } else {
          for (int i = 0; i < N; i++) {
            auto bit = 1 << ((priority + i) % N);
            if (req & bit) {
              // Grant the request
              grant.write(bit);
              // Update priority
              priority = (priority + i + 1) % N;
              // Flags
              granted.write(true);
              parked.write(false);
              break;
            }
          }
        }
      }
      wait();
    }
  }
};

class ArbRRTest : public ::testing::Test {
 protected:
  VKW_arb_rr_wrap dut{"dut"};
  ArbRRModel<16> model{"model"};

  sc_clock clock{"clock", 1, SC_NS, 0.5};
  sc_signal<bool> reset_n{"reset_n"};
  // Inputs
  sc_signal<uint32_t> request{"request"};
  sc_signal<uint32_t> mask{"mask"};
  sc_signal<uint32_t> lock{"lock"};
  // Outputs
  sc_signal<uint32_t> grant{"grant"};
  sc_signal<uint32_t> model_grant{"model_grant"};
  // Flags
  sc_signal<bool> parked{"parked"};
  sc_signal<bool> model_parked{"model_parked"};
  sc_signal<bool> granted{"granted"};
  sc_signal<bool> model_granted{"model_granted"};
  sc_signal<bool> locked{"locked"};

  ArbRRTest() {
#define B(x) (dut.x.bind(x))
    B(clock);
    B(reset_n);
    B(request);
    B(mask);
    B(lock);
    B(grant);
    B(parked);
    B(granted);
    B(locked);
#undef B
    model.clock_.bind(clock);
    model.reset_n_.bind(reset_n);
    model.request.bind(request);
    model.mask.bind(mask);
    model.grant.bind(model_grant);
    model.parked.bind(model_parked);
    model.granted.bind(model_granted);
  }

  void reset() {
    reset_n.write(0);
    request.write(0);
    mask.write(0);
    lock.write(0);
    sc_start(10, SC_NS);
    reset_n.write(1);
  }
};

TEST_F(ArbRRTest, Simple) {
  reset();
  for (int i = 0; i < 10; i++) {
    request.write(i);
    sc_start(1, SC_NS);
    ASSERT_EQ(grant.read(), model_grant.read()) << "Index " << i;
    ASSERT_EQ(parked.read(), model_parked.read());
    ASSERT_EQ(granted.read(), model_granted.read());
  }
  request.write(0);
  sc_start(1, SC_NS);
  ASSERT_EQ(grant.read(), model_grant.read());
  ASSERT_EQ(parked.read(), model_parked.read());
  ASSERT_EQ(granted.read(), model_granted.read());

  reset();
  request.write(0xFFFF);
  for (int i = 0; i < 16; i++) {
    sc_start(1, SC_NS);
    ASSERT_EQ(grant.read(), 1 << i);
  }
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
