`default_nettype none

// Rotate the input LEFT by a fixed amount
module KW_ror_static #(
  parameter int WIDTH,
  parameter int ROR = 0
) (
  input  logic [WIDTH-1:0] a,
  output logic [WIDTH-1:0] b
);
`ifndef SYNTHESIS
  initial assert (ROR >= 0 && ROR < WIDTH)
  else $error("ROR must be in [0, %d), was %d", WIDTH, ROR);
`endif

  /* verilator lint_off UNUSED */
  wire [2*WIDTH-1:0] temp = {2{a}} >> ROR;
  assign b = temp[WIDTH-1:0];
  /* verilator lint_on UNUSED */
endmodule
