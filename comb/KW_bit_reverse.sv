`default_nettype none

/// Reverse the bits of a bus
module KW_bit_reverse #(
  parameter int unsigned WIDTH
) (
  input  logic [WIDTH-1:0] i,
  output logic [WIDTH-1:0] o
);
  // If the streaming operator is not supported, can also use a generate loop
  assign o = {<<{i}};
endmodule
