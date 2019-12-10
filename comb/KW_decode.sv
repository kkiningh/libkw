`default_nettype none

/// Simple decoder.
module KW_decode #(
  parameter int unsigned O_WIDTH,
  parameter int unsigned I_WIDTH = $clog2(O_WIDTH)
) (
  input  logic [I_WIDTH-1:0] i,
  output logic [O_WIDTH-1:0] o
);
  assign o = {{O_WIDTH-1{1'b0}}, 1'b1} << i;
endmodule
