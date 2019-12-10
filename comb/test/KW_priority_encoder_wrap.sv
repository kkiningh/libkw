`default_nettype none
`define N (16)
`define M ($clog2(`N))

module KW_priority_encoder_wrap (
  input  logic [`N-1:0] a,
  output logic [`M-1:0] b
);
  KW_priority_encoder #(
    .N(`N),
    .M(`M)
  ) dut (
    .a(a),
    .b(b)
  );
endmodule
