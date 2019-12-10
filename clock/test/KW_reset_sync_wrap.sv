`default_nettype none
`define STAGES (4)

module KW_reset_sync_wrap (
  input  logic clock,     // Destination clock being syncronized to
  input  logic i_reset_n, // Input reset, active low, async
  input  logic testmode,  // Testmode enable
  output logic o_reset_n  // Output reset, active low, AASD
);
  KW_reset_sync #(
    .STAGES(`STAGES)
  ) dut (
    .*
  );
endmodule
