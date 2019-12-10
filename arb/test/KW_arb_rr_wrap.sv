`default_nettype none
`define N 16

module KW_arb_rr_wrap (
  input logic clock,
  input logic reset_n,

  input  logic [`N-1:0] request,
  input  logic [`N-1:0] mask,
  input  logic [`N-1:0] lock,
  output logic [`N-1:0] grant,
  output logic parked,
  output logic granted,
  output logic locked
);
  KW_arb_rr #(
    .N(`N)
  ) dut (
    .*
  );
endmodule
