`default_nettype none
`define WIDTH_0 (32)
`define WIDTH_1 (16)

module KW_transpose_packed_2d_wrap (
  input  logic [`WIDTH_0-1:0][`WIDTH_1-1:0] i,
  output logic [`WIDTH_1-1:0][`WIDTH_0-1:0] o
);
  KW_transpose_packed_2d #(
    .WIDTH_0(`WIDTH_0),
    .WIDTH_1(`WIDTH_1)
  ) dut (
    .i(i),
    .o(o)
  );
endmodule
