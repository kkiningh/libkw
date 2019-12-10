`default_nettype none
`define WIDTH (16)
`define ROR (15)

module KW_ror_static_wrap (
  input  logic [`WIDTH-1:0] a,
  output logic [`WIDTH-1:0] b
);
  KW_ror_static #(
    .WIDTH(`WIDTH),
    .ROR(`ROR)
  ) dut (
    .a(a),
    .b(b)
  );
endmodule
