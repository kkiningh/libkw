`default_nettype none

/// Transpose the bits in a packed 2d array
module KW_transpose_packed_2d #(
  parameter int unsigned WIDTH_0,
  parameter int unsigned WIDTH_1
) (
  input  logic [WIDTH_0-1:0][WIDTH_1-1:0] i,
  output logic [WIDTH_1-1:0][WIDTH_0-1:0] o
);
  genvar idx0, idx1;
  generate
    for (idx0 = 0; idx0 < WIDTH_0; idx0 = idx0 + 1) begin
      for (idx1 = 0; idx1 < WIDTH_1; idx1 = idx1 + 1) begin
        assign o[idx1][idx0] = i[idx0][idx1];
      end
    end
  endgenerate
endmodule
