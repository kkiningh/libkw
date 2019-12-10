`default_nettype none

/// Simple decoder with valid signal
module KW_decode_v #(
  parameter int unsigned O_WIDTH,
  parameter int unsigned I_WIDTH = $clog2(O_WIDTH)
) (
  input  logic               i_v,
  input  logic [I_WIDTH-1:0] i,
  output logic [O_WIDTH-1:0] o
);
  logic [O_WIDTH-1:0] o_unmask;
  KW_decode #(
    .O_WIDTH(O_WIDTH),
    .I_WIDTH(I_WIDTH)
  ) decode (
    .i(i),
    .o(o_unmask)
  );

  assign o = i_v ? o_unmask : {O_WIDTH{1'b0}};
endmodule
