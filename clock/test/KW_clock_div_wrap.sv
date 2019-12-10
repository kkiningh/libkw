`default_nettype none
`define RATIO (4)

module KW_clock_div_wrap (
  input  logic i_clock,  // Input clock
  input  logic reset_n,  // ASYCN reset (active low)
  input  logic testmode, // testmode enable
  input  logic en,       // clock divide enable
  output logic o_clock   // Output clock
);
  KW_clock_div #(
    .RATIO(`RATIO)
  ) dut (
    .*
  );
endmodule
