`default_nettype none

// Rotate the input LEFT by a fixed amount
module KW_rol_static #(
  parameter int unsigned WIDTH,
  parameter int unsigned ROL = 0
) (
  input  logic [WIDTH-1:0] a,
  output logic [WIDTH-1:0] b
);
`ifndef SYNTHESIS
  initial assert (ROL < WIDTH)
  else $error("ROL must be in [0, %d), was %d", WIDTH, ROL);
`endif

  /* verilator lint_off UNUSED */
  wire [2*WIDTH-1:0] temp = {2{a}} << ROL;
  assign b = temp[2*WIDTH-1:WIDTH];
  /* verilator lint_on UNUSED */
endmodule
